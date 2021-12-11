Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644BCC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244130AbhLKAnl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:43:41 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36804 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhLKAnk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:43:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D31FCE2D90
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD06C00446;
        Sat, 11 Dec 2021 00:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183202;
        bh=Fmk0f/3ci1EM+wFYXWWpEbpOXExwt8fl/uQonzzOtMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnq+zU9QAkvtIN1rkyzXqZ8fpT7URqFDO3mYdQUex6j3Hw6DzucvOgp9F+LwfYTdM
         TpNf3vMUWPSBNZjC/z6k5I4aAQZdRA57q2prKPkpEyyBLpRHyeLneYT/5KL5+FSGZ9
         DOfJ2xgDxIMLbRDKLx9N7peG6CdwKDaU/GLGes34+StA/4yY4ZxLaL0IwcvHjw9ifn
         SEZ+fnTMFXDpzeWGSrKvpCgw8XYnlq+0qEw4bA46NXKkEdo/kow7EHsamEgnw77aKy
         ACoCJYtxv3thjgumElYaf7F7d0e4MxlVoDPhzxXJMyhT6jNMdhvcuqaG0SBqDRZVkU
         GvI0bvs1UR19w==
Date:   Fri, 10 Dec 2021 16:40:01 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 08/16] generic: add mmap CoW test for unwritten&source
 extents
Message-ID: <20211211004001.GI69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-9-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-9-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:44PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode to the source file when the CoW range
> covers unwritten and regular shared blocks.
> (MMAP version of generic/289,290)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/907     | 62 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/907.out | 12 +++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100755 tests/generic/907
>  create mode 100644 tests/generic/907.out
> 
> diff --git a/tests/generic/907 b/tests/generic/907
> new file mode 100755
> index 00000000..61c9293a
> --- /dev/null
> +++ b/tests/generic/907
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 907
> +#
> +# Ensuring that copy on write in mmap mode to the source file when the
> +# CoW range covers unwritten and regular shared blocks.
> +# (MMAP version of generic/289,290)
> +#   - Create two files.
> +#   - fallocate the first file.
> +#   - Write the odd blocks of the first file.
> +#   - Reflink the odd blocks of the first file into the second file.
> +#   - mmap CoW the first file across the halfway mark, starting with the
> +#     regular extent.
> +#   - Check that the files are now different where we say they're different.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_scratch_reflink
> +_require_xfs_io_command "falloc"
> +
> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +mkdir $testdir
> +
> +echo "Create the original files"
> +blksz=65536
> +nr=64
> +filesize=$((blksz * nr))
> +_sweave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +echo "mmap CoW across the transition"
> +cowoff=$((filesize / 4))
> +cowsz=$((filesize / 2))
> +mmapsz=$((cowoff + cowsz))
> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1 >> $seqres.full
> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/907.out b/tests/generic/907.out
> new file mode 100644
> index 00000000..c18b849c
> --- /dev/null
> +++ b/tests/generic/907.out
> @@ -0,0 +1,12 @@
> +QA output created by 907
> +Format and mount
> +Create the original files
> +Compare files
> +b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-907/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-907/file3
> +b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-907/file1.chk
> +mmap CoW across the transition
> +Compare files
> +e8cf59797f0b3758c8878c368bb4cf7e  SCRATCH_MNT/test-907/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-907/file3
> +e8cf59797f0b3758c8878c368bb4cf7e  SCRATCH_MNT/test-907/file1.chk
> -- 
> 2.34.0
> 
> 
> 
