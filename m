Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D891C636D6
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Feb 2023 14:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjBWOpJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjBWOpI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Feb 2023 09:45:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA426E3A7
        for <fstests@vger.kernel.org>; Thu, 23 Feb 2023 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677163448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTccrz4s2zaJ32cNzpmIx5lbVR6uq8er9+SQzU1uziA=;
        b=X6CvVA4WEGEMTkuOu9nnf1UyntQBDoqJk48f9h+vTJGPBOZ8R3dAJTwxG/eCzktIMJOCNf
        XDq52GKudZgCoNWZ8dEYEOsJIBHn+6JIOKltDksFv8U25XxcJ/0iohFjr4F+YhwoHHHnoz
        kTYh7N1oDIiZ/qPXmoWS+hGCgY0CkiQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-295--9BmwVN6NrilreioVBIyuw-1; Thu, 23 Feb 2023 09:44:06 -0500
X-MC-Unique: -9BmwVN6NrilreioVBIyuw-1
Received: by mail-pf1-f197.google.com with SMTP id be12-20020a056a001f0c00b00593e2189278so4980888pfb.19
        for <fstests@vger.kernel.org>; Thu, 23 Feb 2023 06:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTccrz4s2zaJ32cNzpmIx5lbVR6uq8er9+SQzU1uziA=;
        b=s761gpjpPesSUklfk/L7gm50I/1FfdjSKtWrN7LhXgad8JoKc+2H3iXbaSMbVn5jfx
         KC4QDgGWV0xZ7UOcg8C1Nbg5SWFo6XdMplKqzbreZTvR/Q06cCmAJGocDh1Q+JqHDb8l
         IdsZzDljPC4wfukpyDBcm5TyeccRQJnjwe5OmJKAZiDplen0mCoCMbHajDaGFbUK51e4
         f0ZPZ1v80DqYildUK3ZU8Wwz8/Jf2LJtBiOkr9YqvE8GztW5+OJtbuU9fHtKBqNDfdNu
         NbqIJFknIUnTlZf/s3qHwS7LtAvkBnR5Q6ZgYGOe29D/iAz2h14T11Ai391I0nJ9Aygl
         GuTg==
X-Gm-Message-State: AO0yUKXCzBkB5RNz9mxJam+Aqb01DEuFcNVG5J27Ubl45xAbFPfMILgR
        /dLXhxPZ36voFVb7JD2/9hf4XmTCVV+tv6F7cuyMSfVlj7mcMLI9+iFcKya03wUTOlk7mM4a9YB
        CQWeBR/GEeMLENajmnQ==
X-Received: by 2002:a17:90b:4a4d:b0:236:73e8:f53 with SMTP id lb13-20020a17090b4a4d00b0023673e80f53mr14796180pjb.19.1677163445502;
        Thu, 23 Feb 2023 06:44:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/YITJ0sPTxBE+hww6m3H+cuUxE7p3pGSnMypg5vzJ5htqxAcHQN+ufU7gTJPLXyqWnhOzqfQ==
X-Received: by 2002:a17:90b:4a4d:b0:236:73e8:f53 with SMTP id lb13-20020a17090b4a4d00b0023673e80f53mr14796161pjb.19.1677163445059;
        Thu, 23 Feb 2023 06:44:05 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090a690900b00230cbb4b6e8sm5139123pjj.24.2023.02.23.06.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 06:44:03 -0800 (PST)
Date:   Thu, 23 Feb 2023 22:43:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add test for direct io partial writes
Message-ID: <20230223144359.cafgaxywqmwlchs5@zlang-mailbox>
References: <eba2cc47c628ce065e742decac7bc1ef5a91ae54.1677094146.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba2cc47c628ce065e742decac7bc1ef5a91ae54.1677094146.git.boris@bur.io>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 22, 2023 at 11:30:20AM -0800, Boris Burkov wrote:
> btrfs recently had a bug where a direct io partial write resulted in a
> hole in the file. Add a new generic test which creates a 2MiB file,
> mmaps it, touches the first byte, then does an O_DIRECT write of the
> mmapped buffer into a new file. This should result in the mapped pages
> being a mix of in and out of page cache and thus a partial write, for
> filesystems using iomap and IOMAP_DIO_PARTIAL.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/dio-buf-fault.c   | 83 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/708     | 48 +++++++++++++++++++++++++
>  tests/generic/708.out |  2 ++
>  5 files changed, 135 insertions(+), 1 deletion(-)
>  create mode 100644 src/dio-buf-fault.c
>  create mode 100755 tests/generic/708
>  create mode 100644 tests/generic/708.out
> 
> diff --git a/.gitignore b/.gitignore
> index cfff8f85..644290f0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -72,6 +72,7 @@ tags
>  /src/deduperace
>  /src/detached_mounts_propagation
>  /src/devzero
> +/src/dio-buf-fault
>  /src/dio-interleaved
>  /src/dio-invalidate-cache
>  /src/dirhash_collide
> diff --git a/src/Makefile b/src/Makefile
> index a574f7bd..24cd4747 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> -	t_mmap_cow_memory_failure fake-dump-rootino
> +	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/dio-buf-fault.c b/src/dio-buf-fault.c
> new file mode 100644
> index 00000000..36ff6710
> --- /dev/null
> +++ b/src/dio-buf-fault.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> + */
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE /* to get definition of O_DIRECT flag. */
> +#endif
> +
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +/*
> + * mmap a source file, then do a direct write of that mmapped region to a
> + * destination file.
> + */
> +
> +int prep_mmap_buffer(char *src_filename, int *fd, void **addr)
> +{
> +	struct stat st;
> +	int ret;
> +
> +	*fd = open(src_filename, O_RDWR, 0666);
> +	if (*fd == -1)
> +		err(1, "failed to open %s", src_filename);
> +
> +	ret = fstat(*fd, &st);
> +	if (ret)
> +		err(1, "failed to stat %d", *fd);
> +
> +	*addr = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, *fd, 0);
> +	if (*addr == MAP_FAILED)
> +		err(1, "failed to mmap %d", *fd);
> +
> +	return st.st_size;
> +}
> +
> +int do_dio(char *dst_filename, void *buf, size_t sz)
> +{
> +	int fd;
> +	ssize_t ret;
> +
> +	fd = open(dst_filename, O_CREAT | O_TRUNC | O_WRONLY | O_DIRECT, 0666);
> +	if (fd == -1)
> +		err(1, "failed to open %s", dst_filename);
> +	while (sz) {
> +		ret = write(fd, buf, sz);
> +		if (ret < 0) {
> +			if (errno == -EINTR)
> +				continue;
> +			else
> +				err(1, "failed to write %lu bytes to %d", sz, fd);
> +		} else if (ret == 0) {
> +			break;
> +		}
> +		buf += ret;
> +		sz -= ret;
> +	}
> +	return sz;
> +}
> +
> +int main(int argc, char *argv[]) {
> +	size_t sz;
> +	int fd;
> +	void *buf = NULL;
> +	char c;
> +
> +	if (argc != 3)
> +		errx(1, "no in and out file name arguments given");
> +	sz = prep_mmap_buffer(argv[1], &fd, &buf);
                                        ^^
What's the fd for? I didn't see you use it in main function after this line.

> +
> +	/* touch the first page of the mapping to bring it into cache */
> +	c = ((char *)buf)[0];
> +	printf("%u\n", c);
> +
> +	do_dio(argv[2], buf, sz);
> +}
> diff --git a/tests/generic/708 b/tests/generic/708
> new file mode 100755
> index 00000000..ff2e162b
> --- /dev/null
> +++ b/tests/generic/708
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 708
> +#
> +# Test iomap direct_io partial writes.
> +#
> +# Create a reasonably large file, then run a program which mmaps it,
> +# touches the first page, then dio writes it to a second file. This
> +# can result in a page fault reading from the mmapped dio write buffer and
> +# thus the iompap direct_io partial write codepath.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto
> +_fixed_by_kernel_commit XXXX 'btrfs: fix dio continue after short write due to buffer page fault'
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> + 	cd /
> + 	rm -r -f $tmp.*
> +	rm -f $TEST_DIR/dio-buf-fault.*
> +}
> +
> +# Import common functions.
> +. ./common/filter

Do you use any filter functions in this case?

> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
     ^^^
This comment can be removed.

> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program dio-buf-fault
> +src=$TEST_DIR/dio-buf-fault.src
> +dst=$TEST_DIR/dio-buf-fault.dst

I prefer using $seq to reduce the possibility of duplicate file names in
$TEST_DIR. E.g:
  src=$TEST_DIR/dio-buf-fault-${seq}.src
  dst=$TEST_DIR/dio-buf-fault-${seq}.dst

> +
> +echo "Silence is golden"
> +

Due to the $TEST_DIR isn't always clean, so better to remove the $src
and $dst files before below testing. e.g.

  rm -rf $src $dst

BTW, if you'd like, you can remove the specific _cleanup() of this cases. Due to
the $src and $dst are not big, we can keep them in $TEST_DIR. Either way is good
to me, you can decide that by yourself in next version.

> +$XFS_IO_PROG -fc "pwrite -q 0 $((2 * 1024 * 1024))" $src
> +sync
> +$here/src/dio-buf-fault $src $dst >> $seqres.full || _fail "failed doing the dio copy"
> +diff $src $dst
> +
> +# success, all done
> +status=$?
> +exit
> diff --git a/tests/generic/708.out b/tests/generic/708.out
> new file mode 100644
> index 00000000..33c478ad
> --- /dev/null
> +++ b/tests/generic/708.out
> @@ -0,0 +1,2 @@
> +QA output created by 708
> +Silence is golden
> -- 
> 2.39.1
> 

