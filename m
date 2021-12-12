Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFA8C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Dec 2021 13:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhLLNsU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Dec 2021 08:48:20 -0500
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:45000 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLLNsU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Dec 2021 08:48:20 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07475923|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.137464-0.00588887-0.856647;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.MAmHpio_1639316897;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MAmHpio_1639316897)
          by smtp.aliyun-inc.com(10.147.42.253);
          Sun, 12 Dec 2021 21:48:18 +0800
Date:   Sun, 12 Dec 2021 21:48:17 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 10/16] generic: add mmap CoW test for delalloc&source
 extents
Message-ID: <YbX9oSm36H84Rs9o@desktop>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-11-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-11-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:46PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode to the source file when the CoW range
> covers delalloc blocks and regular shared blocks.
> (MMAP version of generic/293,295)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        |  3 ++
>  tests/generic/909     | 64 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/909.out | 12 ++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100755 tests/generic/909
>  create mode 100644 tests/generic/909.out
> 
> diff --git a/common/reflink b/common/reflink
> index 84173d59..e304ddc8 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -431,4 +431,7 @@ _sweave_reflink_holes_delalloc() {
>  		_pwrite_byte 0x64 $((blksz * i)) $blksz $sfile
>  		_pwrite_byte 0x64 $((blksz * i)) $blksz $sfile.chk
>  	done
> +	# make sure we actually got delalloc block
> +	$FILEFRAG_PROG -v $sfile 2>&1 | grep -q delalloc || \
> +		_notrun "test requires delayed allocation writes"

Same here, need a new helper to check delalloc status. And in test
generic/910 as well.

Thanks,
Eryu

>  }
> diff --git a/tests/generic/909 b/tests/generic/909
> new file mode 100755
> index 00000000..ef1233ea
> --- /dev/null
> +++ b/tests/generic/909
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 909
> +#
> +# Ensuring that copy on write in mmap mode to the source file when the
> +# CoW range covers delalloc blocks and regular shared blocks.
> +# (MMAP version of generic/293,295)
> +#   - Create two files.
> +#   - Truncate the first file.
> +#   - Write the odd blocks of the first file.
> +#   - Reflink the odd blocks of the first file into the second file.
> +#   - Write the even blocks of the first file.
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
> +_sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
> +_sweave_reflink_holes_delalloc $blksz $nr $testdir/file1 >> $seqres.full
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
> diff --git a/tests/generic/909.out b/tests/generic/909.out
> new file mode 100644
> index 00000000..4f9a5d33
> --- /dev/null
> +++ b/tests/generic/909.out
> @@ -0,0 +1,12 @@
> +QA output created by 909
> +Format and mount
> +Create the original files
> +Compare files
> +b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-909/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-909/file3
> +b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-909/file1.chk
> +mmap CoW across the transition
> +Compare files
> +35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-909/file1
> +ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-909/file3
> +35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-909/file1.chk
> -- 
> 2.34.0
> 
> 
