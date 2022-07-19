Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0ADC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 17:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiGSRwD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbiGSRwB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2022 13:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8F3E56B97
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658253116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcPxp5ZlSGSX6lMcvziuW7k8PbU+Glj1tlNyhZ85dqM=;
        b=dgrIqCVQ+7OSpvGthsIWO6hBY3ZA4reKLZy7Xzj910V6FcQJkb9FOmQOJh70VTEVPcfF9U
        +Pg9JG6qjTTqRPyj1w2MEZSC9OKQRIMUOoyOTGLI5eUp3J4Vs3hNG2HHXUyD3aCluwDB5q
        6eJNCl2BOeOy9e8Xe55Si+R092zvnXs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-yOxCKzyEOQOUHKGYLi4rIQ-1; Tue, 19 Jul 2022 13:51:56 -0400
X-MC-Unique: yOxCKzyEOQOUHKGYLi4rIQ-1
Received: by mail-qk1-f197.google.com with SMTP id s9-20020a05620a254900b006b54dd4d6deso12247155qko.3
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 10:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lcPxp5ZlSGSX6lMcvziuW7k8PbU+Glj1tlNyhZ85dqM=;
        b=on7+iNXJN9Q5ZzyNapj9eaJqRV8RcIMj4UKLC/sN6QK5mB0rEo0+w4e45FL6Q4zS8j
         zlDoGaJGzo/4NPY9ztMaGRoFsUkQjbfzfpoMQmBIJZu38aEeC+9NNcw+87KXpv8vBWxG
         EftMr+BdZVqDNDKOZRgNuqjDMXU5aDWWhSTiq8UnEtMn4YGDmwxdYjpl7zr5wWKEOyOj
         Mj76nx1vwsDBU9SHcokqNoITGJ/0MUDyfYh/tRdQ717l11XUffPsXIhkKFsVW/jfSFp+
         g2oXeG/3IOH0pmgLaKdXUwHVVPK59MsgyZvGpRX9zBqdx5vFOOm88jwpSSxuu8IE+hlR
         N9Uw==
X-Gm-Message-State: AJIora8P8rn2ncg6vawFonrdqdtSnDeOfl5P3mFNLbGgEo36ggm0IXid
        RDAyKK7pbLwYbXGSPUcefJyvxwGoR0q9qVf+/UArGi1oHQ5eJEtmUrvSnKukfFytywxO4HoyOlx
        IbfXWF4RmXAFQBHNtzA==
X-Received: by 2002:a0c:9c83:0:b0:473:442d:ad4 with SMTP id i3-20020a0c9c83000000b00473442d0ad4mr25739553qvf.9.1658253115210;
        Tue, 19 Jul 2022 10:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shTo4woAdXRvG/TtW1CZQiZ8/SwfGOgURUj0V/UKybfL0rZ6NePeJwrGi+S5QJlKqhg9RTWA==
X-Received: by 2002:a0c:9c83:0:b0:473:442d:ad4 with SMTP id i3-20020a0c9c83000000b00473442d0ad4mr25739536qvf.9.1658253114889;
        Tue, 19 Jul 2022 10:51:54 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x8-20020ac87ec8000000b0031f0485aee0sm369439qtj.88.2022.07.19.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:51:54 -0700 (PDT)
Date:   Wed, 20 Jul 2022 01:51:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v3 1/3] xfs: add memory failure test for dax mode
Message-ID: <20220719175148.quhcekzqtlbjvt5p@zlang-mailbox>
References: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
 <20220520013534.2894233-2-ruansy.fnst@fujitsu.com>
 <YtbgnNQKTlRDgqzj@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbgnNQKTlRDgqzj@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 19, 2022 at 09:49:32AM -0700, Darrick J. Wong wrote:
> On Fri, May 20, 2022 at 09:35:32AM +0800, Shiyang Ruan wrote:
> > Make sure memory failure mechanism works when filesystem is mounted with
> > dax option.
> > 
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> Looks like this is in good enough shape to merge,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks Darrick, I think it's time to merge this patchset now, I'll
do that in next fstests release.

Thanks,
Zorro

> 
> --D
> 
> > ---
> >  .gitignore                      |   1 +
> >  src/Makefile                    |   3 +-
> >  src/t_mmap_cow_memory_failure.c | 157 ++++++++++++++++++++++++++++++++
> >  tests/xfs/900                   |  48 ++++++++++
> >  tests/xfs/900.out               |   9 ++
> >  5 files changed, 217 insertions(+), 1 deletion(-)
> >  create mode 100644 src/t_mmap_cow_memory_failure.c
> >  create mode 100755 tests/xfs/900
> >  create mode 100644 tests/xfs/900.out
> > 
> > diff --git a/.gitignore b/.gitignore
> > index ba0c572b..1d26b28a 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -146,6 +146,7 @@ tags
> >  /src/t_holes
> >  /src/t_immutable
> >  /src/t_mmap_collision
> > +/src/t_mmap_cow_memory_failure
> >  /src/t_mmap_cow_race
> >  /src/t_mmap_dio
> >  /src/t_mmap_fallocate
> > diff --git a/src/Makefile b/src/Makefile
> > index 111ce1d9..d702e200 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -18,7 +18,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> >  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> >  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
> >  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > -	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale
> > +	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > +	t_mmap_cow_memory_failure
> >  
> >  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/t_mmap_cow_memory_failure.c b/src/t_mmap_cow_memory_failure.c
> > new file mode 100644
> > index 00000000..4b2c1b8a
> > --- /dev/null
> > +++ b/src/t_mmap_cow_memory_failure.c
> > @@ -0,0 +1,157 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 Fujitsu Corporation. */
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <libgen.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <semaphore.h>
> > +#include <sys/mman.h>
> > +#include <sys/wait.h>
> > +#include <sys/sem.h>
> > +#include <time.h>
> > +#include <unistd.h>
> > +
> > +sem_t *sem;
> > +
> > +void sigbus_handler(int signal)
> > +{
> > +	printf("Process is killed by signal: %d\n", signal);
> > +	sem_post(sem);
> > +}
> > +
> > +void mmap_read_file(char *filename, off_t offset, size_t size)
> > +{
> > +	int fd;
> > +	char *map, *dummy;
> > +	struct timespec ts;
> > +
> > +	fd = open(filename, O_RDWR);
> > +	map = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, offset);
> > +	dummy = malloc(size);
> > +
> > +	/* make sure page fault happens */
> > +	memcpy(dummy, map, size);
> > +
> > +	/* ready */
> > +	sem_post(sem);
> > +
> > +	usleep(200000);
> > +
> > +	clock_gettime(CLOCK_REALTIME, &ts);
> > +	ts.tv_sec += 3;
> > +	/* wait for injection done */
> > +	sem_timedwait(sem, &ts);
> > +
> > +	free(dummy);
> > +	munmap(map, size);
> > +	close(fd);
> > +}
> > +
> > +void mmap_read_file_then_poison(char *filename, off_t offset, size_t size,
> > +		off_t poisonOffset, size_t poisonSize)
> > +{
> > +	int fd, error;
> > +	char *map, *dummy;
> > +
> > +	/* wait for parent preparation done */
> > +	sem_wait(sem);
> > +
> > +	fd = open(filename, O_RDWR);
> > +	map = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, offset);
> > +	dummy = malloc(size);
> > +
> > +	/* make sure page fault happens */
> > +	memcpy(dummy, map, size);
> > +
> > +	printf("Inject poison...\n");
> > +	error = madvise(map + poisonOffset, poisonSize, MADV_HWPOISON);
> > +	if (error)
> > +		printf("madvise() has fault: %d, errno: %d\n", error, errno);
> > +
> > +	free(dummy);
> > +	munmap(map, size);
> > +	close(fd);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	char *pReadFile = NULL, *pPoisonFile = NULL;
> > +	size_t mmapSize, poisonSize;
> > +	off_t mmapOffset = 0, poisonOffset = 0;
> > +	long pagesize = sysconf(_SC_PAGESIZE);
> > +	int c;
> > +	pid_t pid;
> > +
> > +	if (pagesize < 1) {
> > +		fprintf(stderr, "sysconf(_SC_PAGESIZE): failed to get page size\n");
> > +		abort();
> > +	}
> > +
> > +	/* default mmap / poison size, in unit of System Page Size */
> > +	mmapSize = poisonSize = pagesize;
> > +
> > +	while ((c = getopt(argc, argv, "o::s::O::S::R:P:")) != -1) {
> > +		switch (c) {
> > +		/* mmap offset */
> > +		case 'o':
> > +			mmapOffset = atoi(optarg) * pagesize;
> > +			break;
> > +		/* mmap size */
> > +		case 's':
> > +			mmapSize = atoi(optarg) * pagesize;
> > +			break;
> > +		/* madvice offset */
> > +		case 'O':
> > +			poisonOffset = atoi(optarg) * pagesize;
> > +			break;
> > +		/* madvice size */
> > +		case 'S':
> > +			poisonSize = atoi(optarg) * pagesize;
> > +			break;
> > +		/* filename for mmap read */
> > +		case 'R':
> > +			pReadFile = optarg;
> > +			break;
> > +		/* filename for poison read */
> > +		case 'P':
> > +			pPoisonFile = optarg;
> > +			break;
> > +		default:
> > +			printf("Unknown option: %c\n", c);
> > +			exit(1);
> > +		}
> > +	}
> > +
> > +	if (!pReadFile || !pPoisonFile) {
> > +		printf("Usage: \n"
> > +		       "  %s [-o mmapOffset] [-s mmapSize] [-O mmapOffset] [-S mmapSize] -R readFile -P poisonFile\n"
> > +		       "  (offset and size are both in unit of System Page Size: %ld)\n",
> > +				basename(argv[0]), pagesize);
> > +		exit(0);
> > +	}
> > +	if (poisonSize < mmapSize)
> > +		mmapSize = poisonSize;
> > +
> > +	/* fork and mmap files */
> > +	pid = fork();
> > +	if (pid == 0) {
> > +		/* handle SIGBUS */
> > +		signal(SIGBUS, sigbus_handler);
> > +		sem = sem_open("sync", O_CREAT, 0666, 0);
> > +
> > +		/* mread & do memory failure on poison file */
> > +		mmap_read_file_then_poison(pPoisonFile, mmapOffset, mmapSize,
> > +				poisonOffset, poisonSize);
> > +
> > +		sem_close(sem);
> > +	} else {
> > +		sem = sem_open("sync", O_CREAT, 0666, 0);
> > +
> > +		/* mread read file, wait for child process to be killed */
> > +		mmap_read_file(pReadFile, mmapOffset, mmapSize);
> > +		sem_close(sem);
> > +	}
> > +	exit(0);
> > +}
> > diff --git a/tests/xfs/900 b/tests/xfs/900
> > new file mode 100755
> > index 00000000..da11230a
> > --- /dev/null
> > +++ b/tests/xfs/900
> > @@ -0,0 +1,48 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 900
> > +#
> > +# Test memory failure mechanism when dax enabled
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick dax
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/reflink
> > +
> > +# real QA test starts here
> > +_require_check_dmesg
> > +_require_scratch_reflink
> > +_require_cp_reflink
> > +_require_xfs_scratch_rmapbt
> > +_require_scratch_dax_mountopt "dax"
> > +_require_test_program "t_mmap_cow_memory_failure"
> > +
> > +echo "Format and mount"
> > +_scratch_mkfs > $seqres.full 2>&1
> > +_scratch_mount "-o dax" >> $seqres.full 2>&1
> > +
> > +testdir=$SCRATCH_MNT/test-$seq
> > +mkdir $testdir
> > +
> > +echo "Create the original files"
> > +filesize=65536
> > +_pwrite_byte 0x61 0 $filesize $testdir/testfile >> $seqres.full
> > +_scratch_cycle_mount "dax"
> > +
> > +echo "Inject memory failure (1 page)"
> > +# create two processes:
> > +#  process1: mread 1 page to cause page fault, and wait
> > +#  process2: mread 1 page to cause page fault, then inject poison on this page
> > +$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/testfile
> > +
> > +echo "Inject memory failure (2 pages)"
> > +$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/testfile
> > +
> > +_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
> > +_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
> > +
> > +# success, all done
> > +status=0
> > diff --git a/tests/xfs/900.out b/tests/xfs/900.out
> > new file mode 100644
> > index 00000000..d861bf1f
> > --- /dev/null
> > +++ b/tests/xfs/900.out
> > @@ -0,0 +1,9 @@
> > +QA output created by 900
> > +Format and mount
> > +Create the original files
> > +Inject memory failure (1 page)
> > +Inject poison...
> > +Process is killed by signal: 7
> > +Inject memory failure (2 pages)
> > +Inject poison...
> > +Process is killed by signal: 7
> > -- 
> > 2.35.1
> > 
> > 
> > 
> 

