Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149EDC433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 18:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E841F61503
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 18:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhKHSKu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234885AbhKHSKu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 Nov 2021 13:10:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C996E61458;
        Mon,  8 Nov 2021 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636394885;
        bh=yjNhdXYIG4GXfAZR77TkrP5ZqtC/HGyFvr1TI/8wmRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUx9MnFRujmzinHrIRIMksxUM8RMo4/t1UIUKZrmiaonHFS00XX+o/U7Ex9+n/MqT
         UBWenFEdvxe5pLBuMQ1mosbNMsGvsHZt6a4NOqAz4o13rRvIUvgv19Q19lFpCCEOn7
         y65GIOx62vvdJlzz8TFc3kP6jHDLc98ldCNrR5e6lTQy1KYsSVClV6MYxdrluNzAFF
         kA3sOwGIyEGKoDcg6wKq3BuCY0y98oIX13BHb8js2rZhLOaT2+HB3e8yQv9oPwdmdU
         CBIog7uhvxcroYcP8mW1VmEVgnDlK+dzc20nahEyqrQWdm8jFFMArV3gEhtRbWnkB+
         2ukpS1wLkXRkw==
Date:   Mon, 8 Nov 2021 10:08:05 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/5] generic/xxx: Add MMAP CoW test for 'unwritten'
 case
Message-ID: <20211108180805.GK24282@magnolia>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
 <20211105045222.157826-3-ruansy.fnst@fujitsu.com>
 <20211105162011.GD24282@magnolia>
 <3487e0fd-4fb6-d8ea-c5bf-b2ee679f792d@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3487e0fd-4fb6-d8ea-c5bf-b2ee679f792d@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 08, 2021 at 02:18:34PM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2021/11/6 0:20, Darrick J. Wong 写道:
> > On Fri, Nov 05, 2021 at 12:52:19PM +0800, Shiyang Ruan wrote:
> > > Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> > > the second block is a unwritten block.  (MMAP version of generic/216,217)
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >   tests/generic/901     | 76 +++++++++++++++++++++++++++++++++++++++++++
> > >   tests/generic/901.out |  6 ++++
> > >   2 files changed, 82 insertions(+)
> > >   create mode 100755 tests/generic/901
> > >   create mode 100644 tests/generic/901.out
> > > 
> > > diff --git a/tests/generic/901 b/tests/generic/901
> > > new file mode 100755
> > > index 00000000..46459815
> > > --- /dev/null
> > > +++ b/tests/generic/901
> > > @@ -0,0 +1,76 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# FS QA Test No. xxx
> > > +#
> > > +# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
> > > +# the second block is a unwritten block.  (MMAP version of generic/216,217)
> > > +#
> > > +# This test is dependent on the system page size, so we cannot use md5 in
> > > +# the golden output; we can only compare to a check file.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick clone
> > > +
> > > +# Override the default cleanup function.
> > > +_cleanup()
> > > +{
> > > +    cd /
> > > +    rm -rf $tmp.* $testdir
> > > +}
> > 
> > Oh, something I didn't notice with the previous patch -- this exact
> > _cleanup function is now provided by common/preamble as a default.  If
> > you don't have anything to add to the cleanup process, then you can omit
> > this definition.
> 
> We created a testdir here but the default _cleanup doesn't remove it, so I
> think this overrided cleanup is needed.

It's never necessary to clean things off the scratch fs because the next
test to use the scratch device will reformat it as desired.

--D

> --
> Thanks,
> Ruan.
> 
> > 
> > With that fixed,
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > --D
> > 
> > 
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +. ./common/reflink
> > > +
> > > +# real QA test starts here
> > > +_require_scratch_reflink
> > > +_require_xfs_io_command "falloc"
> > > +
> > > +pagesz=$(getconf PAGE_SIZE)
> > > +blksz=$((pagesz / 4))
> > > +
> > > +echo "Format and mount"
> > > +_scratch_mkfs_blocksized $blksz > $seqres.full 2>&1
> > > +_scratch_mount >> $seqres.full 2>&1
> > > +
> > > +testdir=$SCRATCH_MNT/test-$seq
> > > +mkdir $testdir
> > > +
> > > +real_blksz=$(_get_file_block_size $testdir)
> > > +test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
> > > +
> > > +echo "Create the original files"
> > > +_pwrite_byte 0x61 0 $pagesz $testdir/file1 >> $seqres.full
> > > +
> > > +$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2 >> $seqres.full
> > > +$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2.chk >> $seqres.full
> > > +
> > > +$XFS_IO_PROG -f -c "falloc -k $blksz $blksz" $testdir/file2 >> $seqres.full
> > > +_pwrite_byte 0x00 $blksz $blksz $testdir/file2.chk >> $seqres.full
> > > +
> > > +$XFS_IO_PROG -f -c "falloc -k $((blksz * 3)) $blksz" $testdir/file2 >> $seqres.full
> > > +_pwrite_byte 0x00 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
> > > +
> > > +_reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
> > > +_pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
> > > +_scratch_cycle_mount
> > > +
> > > +echo "Compare files"
> > > +cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
> > > +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
> > > +
> > > +echo "CoW and unmount"
> > > +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
> > > +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
> > > +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
> > > +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
> > > +_scratch_cycle_mount
> > > +
> > > +echo "Compare files"
> > > +cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
> > > +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/901.out b/tests/generic/901.out
> > > new file mode 100644
> > > index 00000000..07b9b433
> > > --- /dev/null
> > > +++ b/tests/generic/901.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 901
> > > +Format and mount
> > > +Create the original files
> > > +Compare files
> > > +CoW and unmount
> > > +Compare files
> > > -- 
> > > 2.33.0
> > > 
> > > 
> > > 
> 
> 
