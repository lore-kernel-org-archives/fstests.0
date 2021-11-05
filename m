Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEB4C433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A4A6127A
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhKEQmx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233079AbhKEQmx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Nov 2021 12:42:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 318B96125F;
        Fri,  5 Nov 2021 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636130413;
        bh=bzCD4eVZZE/N6wmU2caCdRXcz6eIpSdN1+PpfZvR1Kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvRd6DhTf86KM218tmhbxeGmgLxpkV8GYnMKEJzxKRIWEnXDARTK7sX+DTrcsu3W/
         UULjHgcHkO5EOKif+4EuwG2W5om3GXRoblD3fIq06t1h4GyYfH0o6gP4Zj2tOX7HSd
         tdWfg05HjNGKnWaFkmFqeoiGwiicjhiWOnK5BlwC83gH9bWToLxKpoZSOFVU+CjDND
         x+Pt54N7LwqnL9wAibFArNPbqLgQUItQP0hjPkATrwcWFXFtcyGcyQvBcaMmlDjpU2
         /ZTLVJkq9dDgzrASk3Ha4+SU2P4pig3CZUiHo9aDj1v9ZqcjY04Kn2aTBIod6P1X6G
         Syv59GCD+q4Cg==
Date:   Fri, 5 Nov 2021 09:40:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 3/5] generic/xxx: Add MMAP CoW test for 'hole' case
Message-ID: <20211105164012.GE24282@magnolia>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
 <20211105045222.157826-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105045222.157826-4-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 05, 2021 at 12:52:20PM +0800, Shiyang Ruan wrote:
> Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> the second block is a hole.  (MMAP version of generic/218,220)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/generic/902     | 70 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/902.out |  6 ++++
>  2 files changed, 76 insertions(+)
>  create mode 100755 tests/generic/902
>  create mode 100644 tests/generic/902.out
> 
> diff --git a/tests/generic/902 b/tests/generic/902
> new file mode 100755
> index 00000000..a0992fc8
> --- /dev/null
> +++ b/tests/generic/902
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. xxx
> +#
> +# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> +# the second block is a hole.  (MMAP version of generic/218,220)
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

One thing I noticed about the last two tests is that since you only
write to the two shared blocks in the middle of the page, the fs could
very well ignore the holes in the first and last block when it's
handling the page fault.  XFS/iomap will (iirc) allocate those two holes
at writeback time and flush the whole thing to disk, but that isn't a
guaranteed behavior.

So I think the point of this test is to make sure that COW does the
right thing on a bs<ps filesystem such that the adjoining blocks don't
end up with garbage in them, right?  And we don't care what allocation
decisions the fs makes, so long as the read()able contents are what we
expect, right?

If that's correct,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
> +echo "Compare files"
> +cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/902.out b/tests/generic/902.out
> new file mode 100644
> index 00000000..4fb8b6cb
> --- /dev/null
> +++ b/tests/generic/902.out
> @@ -0,0 +1,6 @@
> +QA output created by 902
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
