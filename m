Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF2AC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2416127C
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhKEQpS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233850AbhKEQpR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Nov 2021 12:45:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A7B361054;
        Fri,  5 Nov 2021 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636130558;
        bh=uTNZNLusc3c7LE2IppzbLNsKPg9tXipdfELTsxVhX9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEtNO3zXPI2YYjTmT6lhl5YUSO23CR7lru/jlaZwX8OTBeRb2miWZmUx79XPq3PLJ
         sWyvFtY0e3jvSXwjOSghjp+1B+9KzNePZRYOr+v3i96i0NOUw9QTPz1bLyCwc+fihk
         q503xWXgSKNeH8FiiqWaTrQ1S63hV+EJvkIQhSMlsi/1rQQTQsQ9qWF4MQONLuMWlW
         L6WmB6vx3q0KKlBAiat/P6pcT1NirxyHcGzuUI7A7qMQEcvR6wdsH7sKQkRrxGCk0O
         pKa0qc+nQsOU8PqVdeae5FBGkiXC3bS5Ktczcfw+Vb6jc4RzLGsEsldEZqju8HLOfD
         ELqWcywg5Goig==
Date:   Fri, 5 Nov 2021 09:42:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 4/5] generic/xxx: Add MMAP CoW test for 'delalloc' case
Message-ID: <20211105164237.GF24282@magnolia>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
 <20211105045222.157826-5-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105045222.157826-5-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 05, 2021 at 12:52:21PM +0800, Shiyang Ruan wrote:
> Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> the second block is delalloc.  (MMAP version of generic/222,227)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/generic/903     | 76 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/903.out |  6 ++++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tests/generic/903
>  create mode 100644 tests/generic/903.out
> 
> diff --git a/tests/generic/903 b/tests/generic/903
> new file mode 100755
> index 00000000..c55c4c71
> --- /dev/null
> +++ b/tests/generic/903
> @@ -0,0 +1,76 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. xxx
> +#
> +# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> +# the second block is delalloc.  (MMAP version of generic/222,227)
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
> +_pwrite_byte 0x61 $blksz $blksz $testdir/file2 >> $seqres.full
> +_pwrite_byte 0x61 $blksz $blksz $testdir/file2.chk >> $seqres.full
> +
> +_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2 >> $seqres.full
> +_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full

Does this need to check the block mapping to make sure that blocks 1 and
3 are actually delalloc reservations?  There are certain xfs configs
(such as extent size hints) that disable delalloc.

--D

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
> diff --git a/tests/generic/903.out b/tests/generic/903.out
> new file mode 100644
> index 00000000..cfeeb11c
> --- /dev/null
> +++ b/tests/generic/903.out
> @@ -0,0 +1,6 @@
> +QA output created by 903
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
