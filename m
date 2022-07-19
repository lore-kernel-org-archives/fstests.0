Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C161FC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 16:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGSQtg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiGSQtf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2022 12:49:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4483E57267
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 09:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D034E61A28
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 16:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1264AC341C6;
        Tue, 19 Jul 2022 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658249373;
        bh=O50lXj3cPqMyAnF2wtu5xx8cOKb3w9+PtM1uQZvGIKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTuPkSr94ZXzWAfCQx1Q8uMZ/yuITi5w4tbCG7xBxC/9ndat/ANAfeFXwPQ5WalnK
         FJhpflSvUns4HXqLCuIZL9NoFi+2kIvZD0+4EqXCpsnQ/2W0Y8Ws8kdNVNoGVq8kbK
         4YLCUH6bMajnJLBEZZCYiifkdxekJyQlriUH+BUzy7yF3objzOqhLWOVoN8RyCaMrA
         8vyzsGBLzqJs5sZums6O7Zs2YF3JwnJsHJ4GOzTmV59/r9OgZhug0EPX8tT6pvRI+d
         /YQRUsiSHYbvp1xN+aN5G8abNz4uEPfM1T1vA3wB59YF7YLH22aEQ79nbjfamgCZv/
         XwmZe0RMVc+Dg==
Date:   Tue, 19 Jul 2022 09:49:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 1/3] xfs: add memory failure test for dax mode
Message-ID: <YtbgnNQKTlRDgqzj@magnolia>
References: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
 <20220520013534.2894233-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520013534.2894233-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 09:35:32AM +0800, Shiyang Ruan wrote:
> Make sure memory failure mechanism works when filesystem is mounted with
> dax option.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks like this is in good enough shape to merge,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  .gitignore                      |   1 +
>  src/Makefile                    |   3 +-
>  src/t_mmap_cow_memory_failure.c | 157 ++++++++++++++++++++++++++++++++
>  tests/xfs/900                   |  48 ++++++++++
>  tests/xfs/900.out               |   9 ++
>  5 files changed, 217 insertions(+), 1 deletion(-)
>  create mode 100644 src/t_mmap_cow_memory_failure.c
>  create mode 100755 tests/xfs/900
>  create mode 100644 tests/xfs/900.out
> 
> diff --git a/.gitignore b/.gitignore
> index ba0c572b..1d26b28a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -146,6 +146,7 @@ tags
>  /src/t_holes
>  /src/t_immutable
>  /src/t_mmap_collision
> +/src/t_mmap_cow_memory_failure
>  /src/t_mmap_cow_race
>  /src/t_mmap_dio
>  /src/t_mmap_fallocate
> diff --git a/src/Makefile b/src/Makefile
> index 111ce1d9..d702e200 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -18,7 +18,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> -	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale
> +	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> +	t_mmap_cow_memory_failure
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/t_mmap_cow_memory_failure.c b/src/t_mmap_cow_memory_failure.c
> new file mode 100644
> index 00000000..4b2c1b8a
> --- /dev/null
> +++ b/src/t_mmap_cow_memory_failure.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Fujitsu Corporation. */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <libgen.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <semaphore.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <sys/sem.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +sem_t *sem;
> +
> +void sigbus_handler(int signal)
> +{
> +	printf("Process is killed by signal: %d\n", signal);
> +	sem_post(sem);
> +}
> +
> +void mmap_read_file(char *filename, off_t offset, size_t size)
> +{
> +	int fd;
> +	char *map, *dummy;
> +	struct timespec ts;
> +
> +	fd = open(filename, O_RDWR);
> +	map = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, offset);
> +	dummy = malloc(size);
> +
> +	/* make sure page fault happens */
> +	memcpy(dummy, map, size);
> +
> +	/* ready */
> +	sem_post(sem);
> +
> +	usleep(200000);
> +
> +	clock_gettime(CLOCK_REALTIME, &ts);
> +	ts.tv_sec += 3;
> +	/* wait for injection done */
> +	sem_timedwait(sem, &ts);
> +
> +	free(dummy);
> +	munmap(map, size);
> +	close(fd);
> +}
> +
> +void mmap_read_file_then_poison(char *filename, off_t offset, size_t size,
> +		off_t poisonOffset, size_t poisonSize)
> +{
> +	int fd, error;
> +	char *map, *dummy;
> +
> +	/* wait for parent preparation done */
> +	sem_wait(sem);
> +
> +	fd = open(filename, O_RDWR);
> +	map = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, offset);
> +	dummy = malloc(size);
> +
> +	/* make sure page fault happens */
> +	memcpy(dummy, map, size);
> +
> +	printf("Inject poison...\n");
> +	error = madvise(map + poisonOffset, poisonSize, MADV_HWPOISON);
> +	if (error)
> +		printf("madvise() has fault: %d, errno: %d\n", error, errno);
> +
> +	free(dummy);
> +	munmap(map, size);
> +	close(fd);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *pReadFile = NULL, *pPoisonFile = NULL;
> +	size_t mmapSize, poisonSize;
> +	off_t mmapOffset = 0, poisonOffset = 0;
> +	long pagesize = sysconf(_SC_PAGESIZE);
> +	int c;
> +	pid_t pid;
> +
> +	if (pagesize < 1) {
> +		fprintf(stderr, "sysconf(_SC_PAGESIZE): failed to get page size\n");
> +		abort();
> +	}
> +
> +	/* default mmap / poison size, in unit of System Page Size */
> +	mmapSize = poisonSize = pagesize;
> +
> +	while ((c = getopt(argc, argv, "o::s::O::S::R:P:")) != -1) {
> +		switch (c) {
> +		/* mmap offset */
> +		case 'o':
> +			mmapOffset = atoi(optarg) * pagesize;
> +			break;
> +		/* mmap size */
> +		case 's':
> +			mmapSize = atoi(optarg) * pagesize;
> +			break;
> +		/* madvice offset */
> +		case 'O':
> +			poisonOffset = atoi(optarg) * pagesize;
> +			break;
> +		/* madvice size */
> +		case 'S':
> +			poisonSize = atoi(optarg) * pagesize;
> +			break;
> +		/* filename for mmap read */
> +		case 'R':
> +			pReadFile = optarg;
> +			break;
> +		/* filename for poison read */
> +		case 'P':
> +			pPoisonFile = optarg;
> +			break;
> +		default:
> +			printf("Unknown option: %c\n", c);
> +			exit(1);
> +		}
> +	}
> +
> +	if (!pReadFile || !pPoisonFile) {
> +		printf("Usage: \n"
> +		       "  %s [-o mmapOffset] [-s mmapSize] [-O mmapOffset] [-S mmapSize] -R readFile -P poisonFile\n"
> +		       "  (offset and size are both in unit of System Page Size: %ld)\n",
> +				basename(argv[0]), pagesize);
> +		exit(0);
> +	}
> +	if (poisonSize < mmapSize)
> +		mmapSize = poisonSize;
> +
> +	/* fork and mmap files */
> +	pid = fork();
> +	if (pid == 0) {
> +		/* handle SIGBUS */
> +		signal(SIGBUS, sigbus_handler);
> +		sem = sem_open("sync", O_CREAT, 0666, 0);
> +
> +		/* mread & do memory failure on poison file */
> +		mmap_read_file_then_poison(pPoisonFile, mmapOffset, mmapSize,
> +				poisonOffset, poisonSize);
> +
> +		sem_close(sem);
> +	} else {
> +		sem = sem_open("sync", O_CREAT, 0666, 0);
> +
> +		/* mread read file, wait for child process to be killed */
> +		mmap_read_file(pReadFile, mmapOffset, mmapSize);
> +		sem_close(sem);
> +	}
> +	exit(0);
> +}
> diff --git a/tests/xfs/900 b/tests/xfs/900
> new file mode 100755
> index 00000000..da11230a
> --- /dev/null
> +++ b/tests/xfs/900
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 900
> +#
> +# Test memory failure mechanism when dax enabled
> +#
> +. ./common/preamble
> +_begin_fstest auto quick dax
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_check_dmesg
> +_require_scratch_reflink
> +_require_cp_reflink
> +_require_xfs_scratch_rmapbt
> +_require_scratch_dax_mountopt "dax"
> +_require_test_program "t_mmap_cow_memory_failure"
> +
> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount "-o dax" >> $seqres.full 2>&1
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +mkdir $testdir
> +
> +echo "Create the original files"
> +filesize=65536
> +_pwrite_byte 0x61 0 $filesize $testdir/testfile >> $seqres.full
> +_scratch_cycle_mount "dax"
> +
> +echo "Inject memory failure (1 page)"
> +# create two processes:
> +#  process1: mread 1 page to cause page fault, and wait
> +#  process2: mread 1 page to cause page fault, then inject poison on this page
> +$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/testfile
> +
> +echo "Inject memory failure (2 pages)"
> +$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/testfile
> +
> +_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
> +_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
> +
> +# success, all done
> +status=0
> diff --git a/tests/xfs/900.out b/tests/xfs/900.out
> new file mode 100644
> index 00000000..d861bf1f
> --- /dev/null
> +++ b/tests/xfs/900.out
> @@ -0,0 +1,9 @@
> +QA output created by 900
> +Format and mount
> +Create the original files
> +Inject memory failure (1 page)
> +Inject poison...
> +Process is killed by signal: 7
> +Inject memory failure (2 pages)
> +Inject poison...
> +Process is killed by signal: 7
> -- 
> 2.35.1
> 
> 
> 
