Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AAFC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbhLKAnI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:43:08 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36608 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbhLKAnE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:43:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B0445CE2D8F
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ABFC00446;
        Sat, 11 Dec 2021 00:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183165;
        bh=7M578wfgkV4i4CX2rEC0/EKWTfZ9xyh+N4y24051mD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffJTWE027bVPEGnHMmGpTiWqHTo8uzB9lfzLUOhkgvkkOJdeEFtN0xVp/3ce9yLFh
         1nvYxIAoJMFtShcnQmdVs+yreQRdK793YzCHmfwTUOXy5FzQr2Sc7aCGdReLs1+CWv
         alYUzjihUC0o6+6beg2++fkUIOk1WBFn8K0jdebYOh5D70QXNzaNvbKLpDGbxA5leD
         CXORCKyLE2YjCJY37G2ALGykO5xU7zQ8iZGkAfu4sabimX15HBRsEGEl1GFRqVJHAT
         VQRB/wQ0NiRUkqgb+sEzllt/F5vMColPNojh4Fi8AieCSkj7CxRjk/tt2MdKM9Uro1
         tY0PCCoftrWEg==
Date:   Fri, 10 Dec 2021 16:39:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 07/16] generic: add mmap CoW test for regular&source
 extents
Message-ID: <20211211003925.GH69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-8-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:43PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode to the source file when the CoW range
> covers regular unshared and regular shared blocks.
> (MMAP version of generic/284,287)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/906     | 60 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/906.out | 12 +++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100755 tests/generic/906
>  create mode 100644 tests/generic/906.out
> 
> diff --git a/tests/generic/906 b/tests/generic/906
> new file mode 100755
> index 00000000..953348e8
> --- /dev/null
> +++ b/tests/generic/906
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 906
> +#
> +# Ensuring that copy on write in mmap mode to the source file when the
> +# CoW range covers regular unshared and regular shared blocks.
> +# (MMAP version of generic/284,287)
> +#   - Create two files.
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
> +_sweave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
> diff --git a/tests/generic/906.out b/tests/generic/906.out
> new file mode 100644
> index 00000000..4949769b
> --- /dev/null
> +++ b/tests/generic/906.out
> @@ -0,0 +1,12 @@
> +QA output created by 906
> +Format and mount
> +Create the original files
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-906/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-906/file3
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-906/file1.chk
> +mmap CoW across the transition
> +Compare files
> +2dc2b131303b2f70ddb480778caac8b7  SCRATCH_MNT/test-906/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-906/file3
> +2dc2b131303b2f70ddb480778caac8b7  SCRATCH_MNT/test-906/file1.chk
> -- 
> 2.34.0
> 
> 
> 
