Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A2DC7EE25
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jun 2023 14:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjFGOns (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jun 2023 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbjFGOnq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jun 2023 10:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1A61BF3
        for <fstests@vger.kernel.org>; Wed,  7 Jun 2023 07:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2140C63DE7
        for <fstests@vger.kernel.org>; Wed,  7 Jun 2023 14:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C9EC433EF;
        Wed,  7 Jun 2023 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686149017;
        bh=eJyiXG4X86yQwDuOuPZpBwt+xzHSgIvJGMIH7nDKS7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTskV1tXOdal3EcuB98mPXGr7n3qTK5KtsgNcFi8wVCGdaJZcl2v01flBIlNq5iPU
         py3J0SfW1qV6VVJorlVj1ATRtHVNdtn2bVNIVLxew1nnQKQnG6vD2SHB25g0FkO8DB
         xI7wPQDPWad10TDrxHvWh7BisAnsSUQfqTzDVdLCZgQ5W5aGNYvyMhMsNyBtwCSBW5
         76nhNjsmnrj7LAa/1vK8j6pHjIhpa5IKPjkDGaacf4zfD1cZtdGTiUdg20tBN2KX/N
         DFUdpVUeJ5Sdj/LBQ70+0n0WHRPurLvobqTavqq6Flo68fyA9OIPZtnULi35LNcQHE
         P6AECs2I2dSFg==
Date:   Wed, 7 Jun 2023 07:43:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/728: Add mmap + DIO write test
Message-ID: <20230607144337.GI72267@frogsfrogsfrogs>
References: <20230607124705.1180081-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607124705.1180081-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 07, 2023 at 02:47:05PM +0200, Andreas Gruenbacher wrote:
> This is the same as generic/647, but with an additional test that writes
> a memory-mapped page onto itself using direct I/O.
> 
> For direct I/O writes, the kernel will invalidate the page cache before
> and after carrying out the write.  This puts filesystems that fault in
> pages on demand and then carry out the write with page faults disabled
> into a position in which they will not be able to make any progress.

Needs SOB tag.  Other than that I don't see any problems with this.

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
