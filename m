Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C78BC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1005661245
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhKEQSi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233231AbhKEQSM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Nov 2021 12:18:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93B2E611C0;
        Fri,  5 Nov 2021 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636128932;
        bh=zGAJ8+/BeFKfTx3EMDAUpDLkrKSPhzrtvTE92ovEaKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbiyBgjxs2nc1UflRx0Mi+YPeg0LLSlvTIVCnoIOp99nKVRlBWjmUkhuAyPPPnJxU
         08PZuQZ+u/r5T4BjyuWGF6hNu74cAWbCdCDyR7f/pEx8F96CYP+AQQ++I1Bpmr7krH
         Hd88c6uFTzL+aZBS/FTNuHBEHOf3p6jv5TNz4TE2zOc+rOBNE4Ak4ixx6o82C7qYfR
         NmQmSGduBSmOFA8/cpCMlAqNLscAWRaPyG24VSsB/FWwVUIhTmIRKERRTitFg0KWHC
         5VXLN79Fkf6R1CQMjaAyHyR0zHAppkvkGrjO+biy9u0YZ9Tb+LTGHhCYZd719IOxvt
         AHolqYNbXZMxw==
Date:   Fri, 5 Nov 2021 09:15:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/5] generic/xxx: Add MMAP CoW test for 'regular' case
Message-ID: <20211105161532.GC24282@magnolia>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
 <20211105045222.157826-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105045222.157826-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 05, 2021 at 12:52:18PM +0800, Shiyang Ruan wrote:
> Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> the second block is a regular block.  (MMAP version of generic/205,206)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks good to me.  Sorry I overlooked this back when I was writing all
the reflink tests. :/

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/900     | 75 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/900.out |  6 ++++
>  2 files changed, 81 insertions(+)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
> 
> diff --git a/tests/generic/900 b/tests/generic/900
> new file mode 100755
> index 00000000..c56d9acf
> --- /dev/null
> +++ b/tests/generic/900
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. xxx
> +#
> +# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> +# the second block is a regular block.  (MMAP version of generic/205,206)
> +#
> +# This test is dependent on the system page size, so we cannot use md5 in
> +# the golden output; we can only compare to a check file.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +    cd /
> +    rm -rf $tmp.* $testdir
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_scratch_reflink
> +
> +pagesz=$(getconf PAGE_SIZE)
> +blksz=$((pagesz / 4))
> +
> +echo "Format and mount"
> +_scratch_mkfs_blocksized $blksz > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +mkdir $testdir
> +
> +real_blksz=$(_get_file_block_size $testdir)
> +test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
> +
> +echo "Create the original files"
> +_pwrite_byte 0x61 0 $pagesz $testdir/file1 >> $seqres.full
> +
> +$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2 >> $seqres.full
> +$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2.chk >> $seqres.full
> +
> +_pwrite_byte 0x61 $blksz $blksz $testdir/file2 >> $seqres.full
> +_pwrite_byte 0x61 $blksz $blksz $testdir/file2.chk >> $seqres.full
> +
> +_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2 >> $seqres.full
> +_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
> +
> +_reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
> +_pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
> +
> +echo "CoW and unmount"
> +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
> +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
> +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
> +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/900.out b/tests/generic/900.out
> new file mode 100644
> index 00000000..2abfd789
> --- /dev/null
> +++ b/tests/generic/900.out
> @@ -0,0 +1,6 @@
> +QA output created by 900
> +Format and mount
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> -- 
> 2.33.0
> 
> 
> 
