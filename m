Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D1C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 18:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbiD0SJj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244674AbiD0SJD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Apr 2022 14:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6F522D5
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 11:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75CAD61EBA
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 18:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C553FC385A7;
        Wed, 27 Apr 2022 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651082749;
        bh=7XdXcZ1Wn75KS1+mjDpyo/SkEx4SFfMo9HjCeBIwyAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wrq6HsJv/gUJeMNaSBMAiT/bQHpxxqfZ43gFUoC0+LsRCEN6COmU+C2XP8mDZkK/k
         F8E7xnUELS/FlMURlPrE7TMGGffoTMy1aNXl1glT398kujAL9ExH2vYHoq9yk/NAxA
         WESUWukuIFxiEL+UX6hY81/cSbPA2ELLRGM9KluJBfWDu/3dklG2SJzZf4WvEgaZ4N
         lE9jvvceHnCIvQI6jhnODlXgF07BLOt9NdgLSJV1bb4BUa0rOsL421YLBroYnwDRpZ
         qNGoHT8epQE899WNiFLGVpQ1oaA/b4LC26nmZugLqtL1Xhb5izBQDDawGNUda0ebF1
         vpa9KyM1g6FtQ==
Date:   Wed, 27 Apr 2022 11:05:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: add memory failure test for dax mode
Message-ID: <20220427180549.GK17014@magnolia>
References: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
 <20220311151816.2174870-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311151816.2174870-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Mar 11, 2022 at 11:18:14PM +0800, Shiyang Ruan wrote:
> Make sure memory failure mechanism works when filesystem is mounted with
> dax option.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  .gitignore                      |   1 +
>  src/Makefile                    |   3 +-
>  src/t_mmap_cow_memory_failure.c | 154 ++++++++++++++++++++++++++++++++
>  tests/xfs/900                   |  48 ++++++++++
>  tests/xfs/900.out               |   9 ++
>  5 files changed, 214 insertions(+), 1 deletion(-)
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
> index 00000000..e2266ced
> --- /dev/null
> +++ b/src/t_mmap_cow_memory_failure.c
> @@ -0,0 +1,154 @@
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
> +#define KiB(a) ((a)*1024)
> +#define MiB(a) (KiB(a)*1024)
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
> +void mmap_read_file_then_posion(char *filename, off_t offset, size_t size,

Nit: "poison", not "posion".

With that nit fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +		off_t posionOffset, size_t posionSize)
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
> +	printf("Inject posion...\n");
> +	error = madvise(map + posionOffset, posionSize, MADV_HWPOISON);
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
> +	char *pReadFile = NULL, *pPosionFile = NULL;
> +	/* mmap range, in unit of 4KiB */
> +	size_t mmapSize = KiB(4);
> +	off_t mmapOffset = 0;
> +	/* posion range, in unit of 4KiB */
> +	size_t posionSize = KiB(4);
> +	off_t posionOffset = 0;
> +	int c;
> +	pid_t pid;
> +
> +	while ((c = getopt(argc, argv, "o::s::O::S::R:P:")) != -1) {
> +		switch (c) {
> +		// mmap offset, in unit of 4KiB
> +		case 'o':
> +			mmapOffset = atoi(optarg) * KiB(4);
> +			break;
> +		// mmap size
> +		case 's':
> +			mmapSize = atoi(optarg) * KiB(4);
> +			break;
> +		// madvice offset
> +		case 'O':
> +			posionOffset = atoi(optarg) * KiB(4);
> +			break;
> +		// madvice size
> +		case 'S':
> +			posionSize = atoi(optarg) * KiB(4);
> +			break;
> +		// filename for mmap read
> +		case 'R':
> +			pReadFile = optarg;
> +			break;
> +		// filename for posion read
> +		case 'P':
> +			pPosionFile = optarg;
> +			break;
> +		default:
> +			printf("Unknown option: %c\n", c);
> +			exit(1);
> +		}
> +	}
> +
> +	if (!pReadFile || !pPosionFile) {
> +		printf("Usage: \n"
> +		       "  %s [-o mmapOffset] [-s mmapSize] [-O mmapOffset] [-S mmapSize] -R readFile -P posionFile\n",
> +				basename(argv[0]));
> +		exit(0);
> +	}
> +	if (posionSize < mmapSize)
> +		mmapSize = posionSize;
> +
> +	// fork and mmap files
> +	pid = fork();
> +	if (pid == 0) {
> +		/* handle SIGBUS */
> +		signal(SIGBUS, sigbus_handler);
> +		sem = sem_open("sync", O_CREAT, 0666, 0);
> +
> +		/* mread & do memory failure on posion file */
> +		mmap_read_file_then_posion(pPosionFile, mmapOffset, mmapSize,
> +				posionOffset, posionSize);
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
> index 00000000..51529db5
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
> +#  process1: mread 4k to cause page fault, and wait
> +#  process2: mread 4k to cause page fault, then inject posion on this 4k page
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
> +Inject posion...
> +Process is killed by signal: 7
> +Inject memory failure (2 pages)
> +Inject posion...
> +Process is killed by signal: 7
> -- 
> 2.35.1
> 
> 
> 
