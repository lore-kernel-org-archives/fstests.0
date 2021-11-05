Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB5C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D86661246
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhKEDwP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Nov 2021 23:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhKEDwP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Nov 2021 23:52:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D62C61139;
        Fri,  5 Nov 2021 03:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636084176;
        bh=ZxCBm1cpkVcoQpmjsbGgLtmH21TuSQ8z5GXDehMOwE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffbpLWw6BOkVGUyKelB1s0luQJX28GQKu22MEud1FyuaX+lcI09WwatFEebSkrQbD
         loziZ0EXNdUzyN2YLsVHz0dlskcJwbadxhQvcJDh0EL4fTBMatYaWgQQcQtoOJ4aOV
         T0eWEO/ZMRtOILhp148t9GkgfJATL+xXm/rJO6rx7r3+xZoyjxcfbNJtxxz6K0e7++
         bBd91Wdo8mIewyGvkBkq8rZGu4zUiJCwD2/VOmPoepAixvBbjYLD1+LGz1twmwavZa
         GWY/L9Az4f1r8f3jEDmjjz7S9iDeKioMtecFYxb9qqWMJpT/DcuQ2gHV42Wlc8HHLu
         cZcbDegUjD7Og==
Date:   Thu, 4 Nov 2021 20:49:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] generic/xxx: Add MMAP CoW test for 'regular' case
Message-ID: <20211105034935.GA24282@magnolia>
References: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
 <20211105034200.143626-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105034200.143626-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 05, 2021 at 11:41:56AM +0800, Shiyang Ruan wrote:
> Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> the second block is a regular block.  (MMAP version of generic/205,206)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/generic/900     | 75 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/900.out |  6 ++++
>  2 files changed, 81 insertions(+)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
> 
> diff --git a/tests/generic/900 b/tests/generic/900
> new file mode 100755
> index 00000000..b608e314
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
> +! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."

not-or?  Is this the logical equivalent of:

cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match"

> +cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't match."

Also, for non-fatal failures, please use echo instead of _fail; the
discrepancy will be flagged as test failure(s) by the golden output
comparison.

> +
> +echo "CoW and unmount"
> +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
> +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
> +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
> +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
> +cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't match."

Same here.

--D

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
