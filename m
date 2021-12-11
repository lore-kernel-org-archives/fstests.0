Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EDEC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbhLKAlP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:41:15 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36074 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbhLKAlO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:41:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0E915CE2D90
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B010C00446;
        Sat, 11 Dec 2021 00:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183056;
        bh=Pa5ITeM0PqQJ0jSw/haG8/xFG+Bd52mVMb/iRas3NzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noCA+sP5a57/mdaSc2+J47yCYXgPJetb8tS3iy5quK+quyKKk63ljteS2375tU8hH
         HGR+KCl8MI+3YPqFuEzNXe1KX1XMFUkJCDv8gcFWm7yC5D69DcL0MXfSKh/zvQ2eZR
         lGWZx3CPdJ0tNmkEuvPKOaj7lGJ8IomZsJJb2pN8mwWVcCDX1YIBaQkE8eHt6GPAaE
         9G/qDXxok0yvI1x42VYxTIvLp3Cwjw5QD6hlyQjXtX+WetE1GFOvDn+7RykjXJkhiO
         7OL2jK/gNJ8UsViG+fZR4C/ChD4meUBjsN4QJK1Y7lS2JKd8yIhLUaMI6UYVrLP0Z2
         AWLW/jP9dTdVA==
Date:   Fri, 10 Dec 2021 16:37:35 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 05/16] generic: add mmap CoW test for
 delalloc&destination extents
Message-ID: <20211211003735.GF69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-6-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:41PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode works when the CoW range originally
> covers multiple extents, some delalloc, some not.
> (MMAP version of generic/195,194)
> 
> Also, add a check to make sure the delalloc block is accutally exist.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        |  3 +++
>  tests/generic/904     | 61 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/904.out | 12 +++++++++
>  3 files changed, 76 insertions(+)
>  create mode 100755 tests/generic/904
>  create mode 100644 tests/generic/904.out
> 
> diff --git a/common/reflink b/common/reflink
> index ee60398e..38210673 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -296,6 +296,9 @@ _weave_reflink_holes_delalloc() {
>  		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile
>  		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile.chk
>  	done
> +	# make sure we actually got delalloc block
> +	$FILEFRAG_PROG -v $dfile 2>&1 | grep -q delalloc || \
> +		_notrun "test requires delayed allocation writes"

Heh, I forgot this check way back when.

However, I think this is going to require a:

_require_command "$FILEFRAG_PROG" filefrag

for all the tests that use _weave_reflink_holes_delalloc.  AFAICT that
is:

generic/194 generic/195 xfs/223 xfs/224

The actual generic/904 test looks good.

--D


>  }
>  
>  # Create a file of interleaved regular blocks and reflinked blocks
> diff --git a/tests/generic/904 b/tests/generic/904
> new file mode 100755
> index 00000000..69703d70
> --- /dev/null
> +++ b/tests/generic/904
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 904
> +#
> +# Ensuring that copy on write in mmap mode works when the CoW
> +# range originally covers multiple extents, some delalloc, some not.
> +# (MMAP version of generic/195,194)
> +#   - Create a file.
> +#   - Reflink the odd blocks of the first file into the second file.
> +#   - Buffered write the even blocks of the second file.
> +#   - mmap CoW across the halfway mark, starting with the unwritten extent.
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
> +_weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file3.chk | _filter_scratch
> +
> +echo "mmap CoW across the transition"
> +cowoff=$((filesize / 4))
> +cowsz=$((filesize / 2))
> +_weave_reflink_holes_delalloc $blksz $nr $testdir/file3 >> $seqres.full
> +mmapsz=$((cowoff + cowsz))
> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3 >> $seqres.full
> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file3.chk | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/904.out b/tests/generic/904.out
> new file mode 100644
> index 00000000..cc993394
> --- /dev/null
> +++ b/tests/generic/904.out
> @@ -0,0 +1,12 @@
> +QA output created by 904
> +Format and mount
> +Create the original files
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-904/file1
> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-904/file3
> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-904/file3.chk
> +mmap CoW across the transition
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-904/file1
> +55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-904/file3
> +55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-904/file3.chk
> -- 
> 2.34.0
> 
> 
> 
