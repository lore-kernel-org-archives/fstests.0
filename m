Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:10435 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933020AbaFJAtT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 9 Jun 2014 20:49:19 -0400
Date: Tue, 10 Jun 2014 10:49:11 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [patch] add an aio test which closes the fd before destroying
 the ioctx
Message-ID: <20140610004911.GF4453@dastard>
References: <x4961k97o9o.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x4961k97o9o.fsf@segfault.boston.devel.redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org, Matt Cross <matt.cross@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 09, 2014 at 05:42:59PM -0400, Jeff Moyer wrote:
> Hi,
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
> Feedback is welcome and appreciated.

Mostly pretty good....

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
> + * Run this test as './aio_test 2 100 /tmp/testfile' to demonstrate
> + * the workaround (wait for all io to complete on an io context before
> + * calling io_destroy(), then close fd).
> + */

Ok, so the xfstest never runs the "waitevent == 2" case here, so
perhaps all that workaround demonstration code can be removed?

....
> +char *
> +round_up_to_page(unsigned char *ptr)
> +{
> +  unsigned long buf = (unsigned long) ptr;
> +
> +  if (buf % 4096) {
> +    buf += 4096 - buf%4096;
> +  }
> +
> +  return (char *)buf;
> +}

Urk. Just use memalign() to allocate "page" aligned buffers and all
this can go away.

Also, can you change this code to 8 space tabs and generally clean
it up to be the same as the kernel coding style? The mix of 2 space
indents and tabs really screws up the indenting here...

> +
> +pid_t
> +gettid(void)
> +{
> +  return (pid_t)syscall(SYS_gettid);
> +}
> +
> +void *
> +aio_test_thread(void *data)
> +{
> +  int fd;
> +  io_context_t ioctx;
> +  int ioctx_initted;
> +  int ios_submitted;
> +  struct iocb iocbs[NUM_IOS];
> +  int i;
> +  static unsigned char buffer[IOSIZE + 4096];
> +  long mycpu = (long)data;
> +  pid_t mytid = gettid();
> +  cpu_set_t cpuset;
> +
> +  dprintf ("setting thread %d to run on cpu %ld\n", mytid, mycpu);
> +
> +  CPU_ZERO(&cpuset);
> +  CPU_SET(mycpu, &cpuset);
> +  if (sched_setaffinity(mytid, sizeof(cpuset), &cpuset)) {
> +    printf("FAILED to set thread %d to run on cpu %ld\n", mytid, mycpu);
> +  }

Any reason why process layout like this is necessary? Comments are
nice, even in test code...

> +  ioctx_initted = 0;
> +  ios_submitted = 0;
> +
> +  while (1) {
> +    fd = open(filename, O_RDONLY | O_DIRECT);
> +    if (fd < 0) {
> +      printf ("%lu: Failed to open file '%s'\n", pthread_self(), filename);
> +      goto done;
> +    }
> +
> +    memset(&ioctx, 0, sizeof(ioctx));
> +    if (io_setup(NUM_IOS, &ioctx)) {
> +      printf ("%lu: Failed to setup io context\n", pthread_self());
> +      goto done;
> +    }
> +    ioctx_initted = 1;
> +
> +    if (mycpu != 0) {
> +      for (i=0; i<NUM_IOS; i++) {
> +	struct iocb *iocb = &iocbs[i];
> +
> +	memset(iocb, 0, sizeof(*iocb));
> +	io_prep_pread(iocb, fd, round_up_to_page(buffer), sizeof(buffer) - 4096, i * (sizeof(buffer) - 4096));

Is that really just for page alignment, or is there some other magic
going on here?

> +	if (io_submit(ioctx, 1, &iocb) != 1) {
> +	  printf ("%lu: failed to submit io #%d\n", pthread_self(), i+1);
> +	}
> +      }
> +      ios_submitted = 1;
> +    }
> +
> +  done:
> +    if ((fd >= 0) && (wait_for_events < 2)) {
> +      close(fd);
> +      fd = -1;
> +    }
> +    if (wait_for_events && ios_submitted) {
> +      struct io_event io_events[NUM_IOS];
> +
> +      if (io_getevents(ioctx, NUM_IOS, NUM_IOS, io_events, NULL) != NUM_IOS)
> +	printf ("io_getevents failed to wait for all IO\n");
> +    }
> +
> +    if (ioctx_initted) {
> +      io_destroy(ioctx);
> +      ioctx_initted = 0;
> +    }
> +
> +    if (fd >= 0) /* pass '2' (or higher) in for wait_for_events to close after calling io_destroy(). */
> +      close(fd);
> +
> +    if (ios_submitted) {
> +      pthread_mutex_lock(&count_mutex);
> +      total_loop_count++;
> +      pthread_mutex_unlock(&count_mutex);
> +
> +      ios_submitted = 0;
> +    }
> +  }

Ok, so this runs in an endless loop....

> +  printf ("All threads spawned\n");
> +
> +  gettimeofday(&start, NULL);
> +
> +  while (delta.tv_sec < 300) {
> +    sleep(1);
> +    gettimeofday(&now, NULL);
> +    timersub(&now, &start, &delta);
> +    dprintf("%lu loops completed in %ld seconds\n", total_loop_count, delta.tv_sec);
> +  }
> +
> +  return 0;

And it just exits when the timer expires, with still active AIOs in
flight. Which means that the tst harness may well finsih up and try
to unmount the filesystem while IOs are still in flight. That will
cause spurious test failures because the scratch filesystem can't be
unmounted....

> index 0000000..2202489
> --- /dev/null
> +++ b/tests/generic/323
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# FS QA Test No. 323
> +#
> +# Run aio-last-ref-in-irq-context - last put of ioctx not in process
> +# context We've had a couple of intances in the past where having the
           ^.                      instances
> +# last reference to an ioctx be held by the IO (instead of the
> +# process) would cause problems (hung system, crashes).

OK.

> This test was
> +# written several years ago by Matt Cross, and he has graciously
> +# allowed me to post it for inclusion in xfstests.  I modified it
> +# slightly to reduce the output (since the output was pretty much
> +# different every time) and to only run for a fixed amount of time (5
> +# minutes).

The history of the code should be in the commit message rather than
here in the test description.

> +#-----------------------------------------------------------------------
> +# Copyright (c) 2014 Jeff Moyer.  All Rights Reserved.

Sent from a Red Hat email address. Can you please clarify who owns
the copyright?

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
> +AIO_TEST=src/aio-dio-regress/aio-last-ref-in-irq-context
> +if [ ! -x $AIO_TEST ]; then
> +	_notrun "$AIO_TEST not built"
> +fi

_require_aiodio aio-last-ref-in-irq-context

That also sets up the AIO_TEST variable.

> +
> +_run_323() {
> +	local testtemp=$TEST_DIR/aio-testfile

testfile?

> +	rm -f $testtemp
> +	dd if=/dev/zero of=$testtemp bs=1M count=10

Use xfs_io rather than dd:

	$XFS_IO_PROG -ftc "pwrite 0 10m" $testfile | _filter_xfs_io

And the "-ft" options mean you don't need to rm the $testfile
because it'll get truncated to empty first or created if it doesn't
exist.

> +	$AIO_TEST 0 100 $testtemp
> +	$AIO_TEST 1 100 $testtemp
> +	status=$?
> +	rm -f $testtemp

no need to remove the test file - the $TEST_DIR is supposed to age
with the tests that are run, so leaving scraps around is a good
idea...

> +	return $status
> +}
> +
> +_run_323

Like I said, no need for a function for such a simple test... 

Ah, I see where that all came from - you just copied and renamed
_run_aiodio. Fair enough, but we can do better than that ;)

> +
> +exit $status
> diff --git a/tests/generic/323.out b/tests/generic/323.out
> new file mode 100644
> index 0000000..8405271
> --- /dev/null
> +++ b/tests/generic/323.out
> @@ -0,0 +1,11 @@
> +QA output created by 323
> +10+0 records in
> +10+0 records out
> +wait_for_events: 0
> +num_threads: 100
> +filename: '/mnt/test/aio-testfile'

This output needs to pass through _filter_testdir - so the $AIO_TEST
executions need to be:

	$AIO_TEST 0 100 $testfile | _filter_test_dir

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
