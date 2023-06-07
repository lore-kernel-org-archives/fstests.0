Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC077C7EE23
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jun 2023 16:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjFGQhT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jun 2023 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFGQhS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jun 2023 12:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01128196
        for <fstests@vger.kernel.org>; Wed,  7 Jun 2023 09:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91A1A6173D
        for <fstests@vger.kernel.org>; Wed,  7 Jun 2023 16:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28C9C433D2;
        Wed,  7 Jun 2023 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686155835;
        bh=w6kllnLFgP1V9jW7PiZ4sF+qvV9GqiBwuslXb7OctHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9Rv2nnF4KHkvPsUMsr1aCBaZwmb37y9SHWFkGGaz6+9hvitaT0Hb5v91f95wOurr
         re0sx9Hh7nFIKA5KMpFelxjXr3MwzGZNOtfKiB288q9eDeJXZpLuuwjycKwviZti+n
         tdFISDNlcu6BgZ0+JLcu1T1kGzmGd5RpnElmk6K1KdsX1dMcud/Eg2u8UAqnT5aH4G
         NZYDWmr43C/SSrDWBluvf6jhF45yTJ7Ct2aw34ymEbeX6pfP9HuSb122JioWCiCfns
         zq6fxbktH0nF1o8ATZva3Tx2Ds9ckmdw2x99Fec4iTLvwgXx4l6EvF27ee1gA5nmMK
         c2stwptkiF0Ig==
Date:   Wed, 7 Jun 2023 09:37:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/728: Add mmap + DIO write test
Message-ID: <20230607163714.GJ72267@frogsfrogsfrogs>
References: <20230607145334.1183177-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607145334.1183177-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 07, 2023 at 04:53:34PM +0200, Andreas Gruenbacher wrote:
> This is the same as generic/647, but with an additional test that writes
> a memory-mapped page onto itself using direct I/O.
> 
> For direct I/O writes, the kernel will invalidate the page cache before
> and after carrying out the write.  This puts filesystems that fault in
> pages on demand and then carry out the write with page faults disabled
> into a position in which they will not be able to make any progress.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  src/mmap-rw-fault.c   | 33 ++++++++++++++++++++++++++++++---
>  tests/generic/728     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/728.out |  2 ++
>  3 files changed, 74 insertions(+), 3 deletions(-)
>  create mode 100755 tests/generic/728
>  create mode 100644 tests/generic/728.out
> 
> diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
> index 82f9d978..161d9f79 100644
> --- a/src/mmap-rw-fault.c
> +++ b/src/mmap-rw-fault.c
> @@ -20,6 +20,7 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <err.h>
> +#include <getopt.h>
>  
>  char *filename;
>  unsigned int page_size;
> @@ -109,11 +110,29 @@ static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
>  	return count2;
>  }
>  
> +static void usage(const char *argv0)
> +{
> +	fprintf(stderr, "Usage: %s [-2] {filename}\n", argv0);
> +	exit(2);
> +}
> +
>  int main(int argc, char *argv[])
>  {
> -	if (argc != 2)
> -		errx(1, "no test filename argument given");
> -	filename = argv[1];
> +	int opt, opt_2 = 0;
> +
> +	while ((opt = getopt(argc, argv, "2")) != -1) {
> +		switch(opt) {
> +		case '2':
> +			opt_2 = 1;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind + 1 != argc)
> +		usage(argv[0]);
> +	filename = argv[optind];
>  
>  	page_size = ret = sysconf(_SC_PAGE_SIZE);
>  	if (ret == -1)
> @@ -179,6 +198,14 @@ int main(int argc, char *argv[])
>  		errx(1, "pread (D_DIRECT) from hole is broken");
>  	done();
>  
> +	if (opt_2) {
> +		init('f', O_RDWR | O_DIRECT);
> +		ret = do_write(fd, addr + page_size, page_size, page_size);
> +		if (ret != page_size)
> +			err(1, "pwrite %s (O_DIRECT): %ld != %u", filename, ret, page_size);
> +		done();
> +	}
> +
>  	if (unlink(filename))
>  		err(1, "unlink %s", filename);
>  
> diff --git a/tests/generic/728 b/tests/generic/728
> new file mode 100755
> index 00000000..483c7b73
> --- /dev/null
> +++ b/tests/generic/728
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 728
> +#
> +# Trigger page faults in the same file during read and write
> +#
> +# This is generic/647 with an additional test that writes a memory-mapped page
> +# onto itself using direct I/O.
> +#
> +# The kernel will invalidate the page cache before carrying out the write, so
> +# filesystems that fault in the page and then carry out the direct I/O write
> +# with page faults disabled will never make any progress.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	rm -f $TEST_DIR/mmap-rw-fault.tmp
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program mmap-rw-fault
> +
> +echo "Silence is golden"
> +
> +$here/src/mmap-rw-fault -2 $TEST_DIR/mmap-rw-fault.tmp
> +
> +status=$?
> +exit
> diff --git a/tests/generic/728.out b/tests/generic/728.out
> new file mode 100644
> index 00000000..ab39f45f
> --- /dev/null
> +++ b/tests/generic/728.out
> @@ -0,0 +1,2 @@
> +QA output created by 728
> +Silence is golden
> -- 
> 2.40.0
> 
