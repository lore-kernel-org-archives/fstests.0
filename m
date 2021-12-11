Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A8C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbhLKAtE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:49:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59578 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhLKAtD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:49:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A368B82A4D
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD005C00446;
        Sat, 11 Dec 2021 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183526;
        bh=xW9iGGaPxssHHf7XI/1x3MtkVsNu9vpLiSfXdDhq9Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YASSYTWyebrtiCT9ZWGweAB4W2fIH3/S/IwXWxtmBq6zqu27143OS6C7ZF2OdZxfK
         uDIEL1Iw4i/RF3JBBRbS7iUisOK13cyCb1fdWP1Ed7S709KFnMrFVyrBEspQxRjR8U
         B9RqgOEQ5jswQoTP1VDvebAy/gxOm3CIX65q0Nav2pHFYfwoJhfHLZ3V4otEd/vusz
         Wfi6HS1Mr9fM9EE3IiRnJU7YNEk+Ws11BCo4LnVBsntVTMv0cwJTrLQ4N7uEPTbPSY
         rR9mLzptWJbe+gZc3LoYn/I0qnMniuJTGubk79bgXV2my65JafIXOhANRieIRbn512
         0fv3KQ6RZ7beg==
Date:   Fri, 10 Dec 2021 16:45:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 11/16] generic: add buffered-io CoW test for
 mixed&source extents
Message-ID: <20211211004525.GL69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-12-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-12-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:47PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in buffered mode works when the CoW
> range originally covers multiple extents, mixed with reflinked, unwritten,
> hole, regular and delalloc blocks.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        | 54 +++++++++++++++++++++++++++++++++++
>  tests/generic/910     | 66 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/910.out | 12 ++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100755 tests/generic/910
>  create mode 100644 tests/generic/910.out
> 
> diff --git a/common/reflink b/common/reflink
> index e304ddc8..cca43393 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -435,3 +435,57 @@ _sweave_reflink_holes_delalloc() {
>  	$FILEFRAG_PROG -v $sfile 2>&1 | grep -q delalloc || \
>  		_notrun "test requires delayed allocation writes"
>  }
> +
> +# Create a file of interleaved holes, unwritten blocks, regular blocks, and
> +# reflinked blocks
> +_sweave_reflink_rainbow() {
> +	blksz=$1
> +	nr=$2
> +	sfile=$3
> +	dfile=$4
> +
> +	$XFS_IO_PROG -f -c "truncate $((blksz * nr))" $sfile
> +	_pwrite_byte 0x00 0 $((blksz * nr)) $sfile.chk
> +	_pwrite_byte 0x61 0 $((blksz * nr)) $dfile
> +	seq 0 5 $((nr - 1)) | while read i; do
> +		_pwrite_byte 0x61 $((blksz * i)) $blksz $sfile
> +		_pwrite_byte 0x61 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 0 blocks are reflinked
> +	seq 0 5 $((nr - 1)) | while read i; do
> +		_reflink_range $sfile $((blksz * i)) $dfile $((blksz * i)) $blksz
> +		_pwrite_byte 0x61 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 1 blocks are unwritten
> +	seq 1 5 $((nr - 1)) | while read i; do
> +		$XFS_IO_PROG -f -c "falloc $((blksz * i)) $blksz" $sfile
> +		_pwrite_byte 0x00 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 2 blocks are holes
> +	seq 2 5 $((nr - 1)) | while read i; do
> +		_pwrite_byte 0x00 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 3 blocks are regular
> +	seq 3 5 $((nr - 1)) | while read i; do
> +		_pwrite_byte 0x71 $((blksz * i)) $blksz $sfile
> +		_pwrite_byte 0x71 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 4 blocks will be delalloc later
> +}
> +
> +# For a file created with _sweave_reflink_rainbow, fill the holes with delalloc
> +# extents
> +_sweave_reflink_rainbow_delalloc() {
> +	blksz=$1
> +	nr=$2
> +	dfile=$3
> +
> +	# 4 blocks are delalloc (do later)
> +	seq 4 5 $((nr - 1)) | while read i; do
> +		_pwrite_byte 0x62 $((blksz * i)) $blksz $sfile
> +		_pwrite_byte 0x62 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# make sure we actually got delalloc block
> +	$FILEFRAG_PROG -v $sfile 2>&1 | grep -q delalloc || \
> +		_notrun "test requires delayed allocation writes"
> +}
> diff --git a/tests/generic/910 b/tests/generic/910
> new file mode 100755
> index 00000000..8d731a2d
> --- /dev/null
> +++ b/tests/generic/910
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 910
> +#
> +# Ensuring that copy on write in buffered mode works when the CoW
> +# range originally covers multiple extents, mixed with reflinked, unwritten,
> +# hole, regular and delalloc blocks.
> +#   - Create a file with the following repeating sequence of blocks:
> +#     1. reflinked
> +#     2. unwritten
> +#     3. hole
> +#     4. regular block
> +#     5. delalloc
> +#   - CoW across the halfway mark, starting with the unwritten extent.
> +#   - Check that the files are now different where we say they're different.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone punch
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_scratch_reflink
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "fpunch"
> +_require_cp_reflink
> +_require_odirect

I don't see any directio going on in this test?

This test is also missing a _require_command $FILEFRAG_PROG filefrag.

The rest looks good.  Thanks for adding a new combination!

--D

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
> +_sweave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +echo "CoW across the transition"
> +cowoff=$((filesize / 4))
> +cowsz=$((filesize / 2))
> +_sweave_reflink_rainbow_delalloc $blksz $nr $testdir/file1 >> $seqres.full
> +# now cow
> +$XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
> +_pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +# success, all done
> +status=0
> diff --git a/tests/generic/910.out b/tests/generic/910.out
> new file mode 100644
> index 00000000..12956584
> --- /dev/null
> +++ b/tests/generic/910.out
> @@ -0,0 +1,12 @@
> +QA output created by 910
> +Format and mount
> +Create the original files
> +Compare files
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-910/file1
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-910/file3
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-910/file1.chk
> +CoW across the transition
> +Compare files
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-910/file1
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-910/file3
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-910/file1.chk
> -- 
> 2.34.0
> 
> 
> 
