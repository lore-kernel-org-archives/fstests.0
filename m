Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D263EC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86B261252
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhKEQWv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232072AbhKEQWv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Nov 2021 12:22:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A73D2611C4;
        Fri,  5 Nov 2021 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636129211;
        bh=ZRNzuNqN/4utlkQG1p9Fk5jaNhsVveiSaTqxqgPcdls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlXs6fvb3+fCKHSUUDOI/ZmagDSpPsbJuCNxpuamWu0OBCvQBzwBL7P6TPUpYpTjh
         4BErh4tB8t3jTsk+2zE+RB4BXVt4pokcgWeDjdo6HARup4BglFhY51jAQED4hheCNc
         uih+wyTGfnZkCZEdQXsMlJqN5DWG8XOetISNiFRuCCipzAdZ7DpVvqfeBxENDvwhgn
         NI9YHqCW1rrVrkZvp01ZliCDqhXiV61PFbPbuOzdQlrSqgBblrP88pv/leWyKiPjc9
         /rIiwEApfRoSnuIweOoLRHAN6jEvusESXq8ZPZQJV6UFaWfjjgSVvWDO7vXGXkJ05c
         dUZL4HorBzDVg==
Date:   Fri, 5 Nov 2021 09:20:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/5] generic/xxx: Add MMAP CoW test for 'unwritten'
 case
Message-ID: <20211105162011.GD24282@magnolia>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
 <20211105045222.157826-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105045222.157826-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 05, 2021 at 12:52:19PM +0800, Shiyang Ruan wrote:
> Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> the second block is a unwritten block.  (MMAP version of generic/216,217)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/generic/901     | 76 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/901.out |  6 ++++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tests/generic/901
>  create mode 100644 tests/generic/901.out
> 
> diff --git a/tests/generic/901 b/tests/generic/901
> new file mode 100755
> index 00000000..46459815
> --- /dev/null
> +++ b/tests/generic/901
> @@ -0,0 +1,76 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. xxx
> +#
> +# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> +# the second block is a unwritten block.  (MMAP version of generic/216,217)
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

Oh, something I didn't notice with the previous patch -- this exact
_cleanup function is now provided by common/preamble as a default.  If
you don't have anything to add to the cleanup process, then you can omit
this definition.

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_scratch_reflink
> +_require_xfs_io_command "falloc"
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
> +$XFS_IO_PROG -f -c "falloc -k $blksz $blksz" $testdir/file2 >> $seqres.full
> +_pwrite_byte 0x00 $blksz $blksz $testdir/file2.chk >> $seqres.full
> +
> +$XFS_IO_PROG -f -c "falloc -k $((blksz * 3)) $blksz" $testdir/file2 >> $seqres.full
> +_pwrite_byte 0x00 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
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
> diff --git a/tests/generic/901.out b/tests/generic/901.out
> new file mode 100644
> index 00000000..07b9b433
> --- /dev/null
> +++ b/tests/generic/901.out
> @@ -0,0 +1,6 @@
> +QA output created by 901
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
