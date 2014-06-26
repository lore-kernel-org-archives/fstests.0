Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5187 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbaFZMzC (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Jun 2014 08:55:02 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5QCt2ok019261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2014 08:55:02 -0400
Date: Thu, 26 Jun 2014 08:55:01 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [patch, v3] add an aio test which closes the fd before
 destroying the ioctx
Message-ID: <20140626125500.GD37470@bfoster.bfoster>
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 24, 2014 at 03:34:27PM -0400, Jeff Moyer wrote:
> 
> By closing the file descriptor before calling io_destroy, you pretty
> much guarantee that the last put on the ioctx will be done in interrupt
> context (during I/O completion).  This behavior has unearthed bugs in
> the kernel in several different kernel versions, so let's add a test to
> poke at it.
> 
> The original test case was provided by Matt Cross.  He has graciously
> relicensed it under the GPL v2 or later so that it can be included in
> xfstests.  I've modified the test a bit so that it would generate a
> stable output format and to run for a fixed amount of time.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 

Looks Ok to me..

Reviewed-by: Brian Foster <bfoster@redhat.com>

> ---
> Changes since v2:
> - fixed up fd leak
> - removed a stale comment
> - reducted test time to 60s per iteration (so 2 minutes total)
> 
> Changes since v1:
> - fixed up coding style
> - incorporated other stylistic review comments from dchinner
> - fixed the copyright
> - use xfs_io instead of dd
> 
> diff --git a/src/aio-dio-regress/aio-last-ref-held-by-io.c b/src/aio-dio-regress/aio-last-ref-held-by-io.c
> new file mode 100644
> index 0000000..a73dc3b
> --- /dev/null
> +++ b/src/aio-dio-regress/aio-last-ref-held-by-io.c
> @@ -0,0 +1,239 @@
> +/* Copyright (C) 2010, Matthew E. Cross <matt.cross@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +/* Code to reproduce the aio lockup.
> + *
> + * Make a test file that is at least 4MB long.  Something like this:
> + * 'dd if=/dev/zero of=/tmp/testfile bs=1M count=10'
> + *
> + * Run this test as './aio_test 0 100 /tmp/testfile' to induce the
> + * failure.
> + *
> + * Run this test as './aio_test 1 100 /tmp/testfile' to demonstrate an
> + * incomplete workaround (close fd, then wait for all io to complete
> + * on an io context before calling io_destroy()).  This still induces
> + * the failure.
> + *
> + * This test was written several years ago by Matt Cross, and he has
> + * graciously allowed me to post it for inclusion in xfstests.
> + *
> + * Changelog
> + * - reduce output and make it consistent for integration into xfstests (JEM)
> + * - run for fixed amount of time instead of indefinitely (JEM)
> + * - change coding style to meet xfstests standards (JEM)
> + * - get rid of unused code (workaround 2 documented above) (JEM)
> + * - use posix_memalign (JEM)
> + */
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE /* to get definition of O_DIRECT flag. */
> +#endif
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <libgen.h>
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <libaio.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/time.h>
> +#include <fcntl.h>
> +#include <sched.h>
> +
> +#undef DEBUG
> +#ifdef DEBUG
> +#define dprintf(fmt, args...) printf(fmt, ##args)
> +#else
> +#define dprintf(fmt, args...)
> +#endif
> +
> +char *filename;
> +int wait_for_events = 0;
> +
> +pthread_mutex_t count_mutex = PTHREAD_MUTEX_INITIALIZER;
> +unsigned long total_loop_count = 0;
> +
> +#define NUM_IOS 16
> +#define IOSIZE (1024 * 64)
> +
> +pid_t
> +gettid(void)
> +{
> +	return (pid_t)syscall(SYS_gettid);
> +}
> +
> +void *
> +aio_test_thread(void *data)
> +{
> +	int fd = -1;
> +	io_context_t ioctx;
> +	int ioctx_initted;
> +	int ios_submitted;
> +	struct iocb iocbs[NUM_IOS];
> +	int i;
> +	static unsigned char *buffer;
> +	int ret;
> +	long mycpu = (long)data;
> +	pid_t mytid = gettid();
> +	cpu_set_t cpuset;
> +
> +	dprintf("setting thread %d to run on cpu %ld\n", mytid, mycpu);
> +
> +	/*
> +	 * Problems have been easier to trigger when spreading the
> +	 * workload over the available CPUs.
> +	 */
> +	CPU_ZERO(&cpuset);
> +	CPU_SET(mycpu, &cpuset);
> +	if (sched_setaffinity(mytid, sizeof(cpuset), &cpuset)) {
> +		printf("FAILED to set thread %d to run on cpu %ld\n",
> +		       mytid, mycpu);
> +	}
> +
> +	ioctx_initted = 0;
> +	ios_submitted = 0;
> +
> +	ret = posix_memalign((void **)&buffer, getpagesize(), IOSIZE);
> +	if (ret != 0) {
> +		printf("%lu: Failed to allocate buffer for IO: %d\n",
> +		       pthread_self(), ret);
> +		goto done;
> +	}
> +
> +	while (1) {
> +		fd = open(filename, O_RDONLY | O_DIRECT);
> +		if (fd < 0) {
> +			printf("%lu: Failed to open file '%s'\n",
> +			       pthread_self(), filename);
> +			goto done;
> +		}
> +
> +		memset(&ioctx, 0, sizeof(ioctx));
> +		if (io_setup(NUM_IOS, &ioctx)) {
> +			printf("%lu: Failed to setup io context\n",
> +			       pthread_self());
> +			goto done;
> +		}
> +		ioctx_initted = 1;
> +
> +		if (mycpu != 0) {
> +			for (i = 0; i < NUM_IOS; i++) {
> +				struct iocb *iocb = &iocbs[i];
> +
> +				memset(iocb, 0, sizeof(*iocb));
> +				io_prep_pread(iocb, fd, buffer,
> +					      IOSIZE, i * IOSIZE);
> +				if (io_submit(ioctx, 1, &iocb) != 1) {
> +					printf("%lu: failed to submit io #%d\n",
> +						pthread_self(), i+1);
> +				}
> +			}
> +			ios_submitted = 1;
> +		}
> +
> +done:
> +		if (fd >= 0)
> +			close(fd);
> +
> +		if (wait_for_events && ios_submitted) {
> +			struct io_event io_events[NUM_IOS];
> +
> +			if (io_getevents(ioctx, NUM_IOS, NUM_IOS,
> +					 io_events, NULL) != NUM_IOS)
> +				printf("io_getevents failed to wait for all IO\n");
> +		}
> +
> +		if (ioctx_initted) {
> +			io_destroy(ioctx);
> +			ioctx_initted = 0;
> +		}
> +
> +		if (ios_submitted) {
> +			pthread_mutex_lock(&count_mutex);
> +			total_loop_count++;
> +			pthread_mutex_unlock(&count_mutex);
> +
> +			ios_submitted = 0;
> +		}
> +	}
> +}
> +
> +int
> +main(int argc, char **argv)
> +{
> +	unsigned num_threads;
> +	unsigned i;
> +	int fd;
> +	pthread_t *threads;
> +	long ncpus = sysconf(_SC_NPROCESSORS_ONLN);
> +	struct timeval start, now, delta = { 0, 0 };
> +
> +	if (argc != 4) {
> +		printf("Usage: aio_test [wait for events?] [# of threads] "
> +		       "[filename]\n");
> +		return -1;
> +	}
> +
> +	wait_for_events = strtoul(argv[1], NULL, 0);
> +	num_threads = strtoul(argv[2], NULL, 0);
> +	filename = argv[3];
> +
> +	printf("wait_for_events: %d\n", wait_for_events);
> +	printf("num_threads: %u\n", num_threads);
> +	printf("filename: '%s'\n", basename(filename));
> +
> +	if (num_threads < 1) {
> +		printf("Number of threads is invalid, must be at least 1\n");
> +		return -1;
> +	}
> +
> +	fd = open(filename, O_RDONLY|O_DIRECT);
> +	if (fd < 0) {
> +		printf("Failed to open filename '%s' for reading\n", filename);
> +		return -1;
> +	}
> +	close(fd);
> +
> +	threads = malloc(sizeof(pthread_t) * num_threads);
> +	if (threads == NULL) {
> +		printf("Failed to allocate thread id storage\n");
> +		return -1;
> +	}
> +
> +	for (i = 0; i < num_threads; i++) {
> +		if (pthread_create(&threads[i], NULL,
> +				   aio_test_thread, (void *)(i % ncpus))) {
> +			printf("Failed to create thread #%u\n", i+1);
> +			threads[i] = (pthread_t)-1;
> +		}
> +	}
> +
> +	printf("All threads spawned\n");
> +	gettimeofday(&start, NULL);
> +
> +	while (delta.tv_sec < 60) {
> +		sleep(1);
> +		gettimeofday(&now, NULL);
> +		timersub(&now, &start, &delta);
> +		dprintf("%lu loops completed in %ld seconds\n",
> +			total_loop_count, delta.tv_sec);
> +	}
> +
> +	return 0;
> +}
> diff --git a/tests/generic/323 b/tests/generic/323
> new file mode 100644
> index 0000000..b84cfc8
> --- /dev/null
> +++ b/tests/generic/323
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# FS QA Test No. 323
> +#
> +# Run aio-last-ref-held-by-io - last put of ioctx not in process
> +# context. We've had a couple of instances in the past where having the
> +# last reference to an ioctx be held by the IO (instead of the
> +# process) would cause problems (hung system, crashes).
> +
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2014 Red Hat, Inc.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_aiodio aio-last-ref-held-by-io
> +
> +testfile=$TEST_DIR/aio-testfile
> +$XFS_IO_PROG -ftc "pwrite 0 10m" $testfile | _filter_xfs_io
> +
> +$AIO_TEST 0 100 $testfile
> +if [ $? -ne 0 ]; then
> +	exit $status
> +fi
> +
> +$AIO_TEST 1 100 $testfile
> +if [ $? -ne 0 ]; then
> +	exit $status
> +fi
> +
> +status=0
> +exit $status
> diff --git a/tests/generic/323.out b/tests/generic/323.out
> new file mode 100644
> index 0000000..1baaae7
> --- /dev/null
> +++ b/tests/generic/323.out
> @@ -0,0 +1,11 @@
> +QA output created by 323
> +wrote 10485760/10485760 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wait_for_events: 0
> +num_threads: 100
> +filename: 'aio-testfile'
> +All threads spawned
> +wait_for_events: 1
> +num_threads: 100
> +filename: 'aio-testfile'
> +All threads spawned
> diff --git a/tests/generic/group b/tests/generic/group
> index e851c62..f45399c 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -141,3 +141,4 @@
>  320 auto rw
>  321 auto quick metadata log
>  322 auto quick metadata log
> +323 auto aio stress
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
