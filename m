Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B443FC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994FB611EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhKEQvy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233425AbhKEQvx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Nov 2021 12:51:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCF83611EE;
        Fri,  5 Nov 2021 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636130953;
        bh=8CI6bm2K9VhzBGUUAuhXG/QUEZhdQaxhjIYQb1sOq/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oE5Gu7oyHNoQXDExFynsQ5RRjAKkfdCicPgYOudTeknSn3l8Gz1uwdFVoTEAYo37S
         wD4FeTctj5osmKtDEgIMX5tL7uoSy9bMMe60TRN2zHXbI7tvWtyLt+8h+r0gRJXRpb
         urTx6teqq5J8xhRiyIodk9nu/XbgnP1qKFUqfYZ3zBiZHXZJS8PZniCZGmB6+0set8
         2WnXCUgJnPJjcgezzbv5X/9YVAJBXWM9oWvCbMzeLmMab5CTBVnz+Tiaw8zMoHENEU
         PQ4fnSznzaM79PVAh1ow+0n4R4rRlcrXmbPYQRW5XQQgN9ujwOuTqAq2lCxX5iPTz0
         lfU1VTtzv/Uhw==
Date:   Fri, 5 Nov 2021 09:49:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 5/5] generic/xxx: Add MMAP CoW test for 'all' case
Message-ID: <20211105164913.GG24282@magnolia>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
 <20211105045222.157826-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105045222.157826-6-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 05, 2021 at 12:52:22PM +0800, Shiyang Ruan wrote:
> Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> the surrounding blocks vary between unwritten/regular/delalloc/hole.
> (MMAP version of generic/229,238)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/generic/904     | 135 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/904.out |  82 +++++++++++++++++++++++++
>  2 files changed, 217 insertions(+)
>  create mode 100755 tests/generic/904
>  create mode 100644 tests/generic/904.out
> 
> diff --git a/tests/generic/904 b/tests/generic/904
> new file mode 100755
> index 00000000..c1cca379
> --- /dev/null
> +++ b/tests/generic/904
> @@ -0,0 +1,135 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. xxx
> +#
> +# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> +# the surrounding blocks vary between unwritten/regular/delalloc/hole.
> +# (MMAP version of generic/229,238)
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
> +runtest() {
> +	echo "runtest $1 $2"
> +	b2=$1
> +	b4=$2
> +	dir=$3
> +
> +	echo "Create the original files"
> +	mkdir -p $dir
> +	_pwrite_byte 0x61 0 $pagesz $dir/file1 >> $seqres.full
> +
> +	$XFS_IO_PROG -f -c "truncate $pagesz" $dir/file2 >> $seqres.full
> +	$XFS_IO_PROG -f -c "truncate $pagesz" $dir/file2.chk >> $seqres.full
> +
> +	case $b2 in
> +	"regular")
> +		_pwrite_byte 0x61 $blksz $blksz $dir/file2 >> $seqres.full
> +		_pwrite_byte 0x61 $blksz $blksz $dir/file2.chk >> $seqres.full
> +		;;
> +	"unwritten")
> +		$XFS_IO_PROG -f -c "falloc -k $blksz $blksz" $dir/file2 >> $seqres.full
> +		_pwrite_byte 0x00 $blksz $blksz $dir/file2.chk >> $seqres.full
> +		;;
> +	"hole")
> +		;;
> +	esac
> +
> +	case $b4 in
> +	"regular")
> +		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2 >> $seqres.full
> +		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2.chk >> $seqres.full
> +		;;
> +	"unwritten")
> +		$XFS_IO_PROG -f -c "falloc -k $((blksz * 3)) $blksz" $dir/file2 >> $seqres.full
> +		_pwrite_byte 0x00 $((blksz * 3)) $blksz $dir/file2.chk >> $seqres.full
> +		;;
> +	"hole")
> +		;;
> +	esac
> +
> +	_reflink_range $dir/file1 $blksz $dir/file2 $((blksz * 2)) $blksz >> $seqres.full
> +	_pwrite_byte 0x61 $((blksz * 2)) $blksz $dir/file2.chk >> $seqres.full
> +	_scratch_cycle_mount
> +
> +	echo "Compare files"
> +	cmp -s $dir/file1 $dir/file2 && echo "file1 and file2 should not match."
> +	cmp -s $dir/file2 $dir/file2.chk || echo "file2 and file2.chk don't match."
> +
> +	echo "CoW and unmount"
> +	if [ $b2 = "delalloc" ]; then
> +		_pwrite_byte 0x61 $blksz $blksz $dir/file2 >> $seqres.full
> +		_pwrite_byte 0x61 $blksz $blksz $dir/file2.chk >> $seqres.full
> +	fi
> +
> +	if [ $b4 = "delalloc" ]; then
> +		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2 >> $seqres.full
> +		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2.chk >> $seqres.full
> +	fi
> +
> +	$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
> +        -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $dir/file2 >> $seqres.full
> +	$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
> +        -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $dir/file2.chk >> $seqres.full
> +	_scratch_cycle_mount
> +
> +	echo "Compare files"
> +	cmp -s $dir/file1 $dir/file2 && echo "file1 and file2 should not match."
> +	cmp -s $dir/file2 $dir/file2.chk || echo "file2 and file2.chk don't match."
> +}
> +
> +runtest regular delalloc "$testdir/r-d"
> +runtest regular unwritten "$testdir/r-u"
> +runtest regular hole "$testdir/r-h"
> +runtest regular regular "$testdir/r-r"

How does regular-regular differ from the first test in the series?

(And the same for unwritten-unwritten, etc.)

--D

> +
> +runtest hole delalloc "$testdir/h-d"
> +runtest hole unwritten "$testdir/h-u"
> +runtest hole hole "$testdir/h-h"
> +runtest hole regular "$testdir/h-r"
> +
> +runtest unwritten delalloc "$testdir/u-d"
> +runtest unwritten unwritten "$testdir/u-u"
> +runtest unwritten hole "$testdir/u-h"
> +runtest unwritten regular "$testdir/u-r"
> +
> +runtest delalloc delalloc "$testdir/d-d"
> +runtest delalloc unwritten "$testdir/d-u"
> +runtest delalloc hole "$testdir/d-h"
> +runtest delalloc regular "$testdir/d-r"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/904.out b/tests/generic/904.out
> new file mode 100644
> index 00000000..f84bbe6d
> --- /dev/null
> +++ b/tests/generic/904.out
> @@ -0,0 +1,82 @@
> +QA output created by 904
> +Format and mount
> +runtest regular delalloc
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest regular unwritten
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest regular hole
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest regular regular
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest hole delalloc
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest hole unwritten
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest hole hole
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest hole regular
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest unwritten delalloc
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest unwritten unwritten
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest unwritten hole
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest unwritten regular
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest delalloc delalloc
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest delalloc unwritten
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest delalloc hole
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> +runtest delalloc regular
> +Create the original files
> +Compare files
> +CoW and unmount
> +Compare files
> -- 
> 2.33.0
> 
> 
> 
