Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EDFC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Dec 2021 13:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhLLNnK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Dec 2021 08:43:10 -0500
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:48505 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLLNnK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Dec 2021 08:43:10 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07456958|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0874047-0.00321975-0.909376;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.MAlmeSv_1639316587;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MAlmeSv_1639316587)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sun, 12 Dec 2021 21:43:08 +0800
Date:   Sun, 12 Dec 2021 21:43:07 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 06/16] generic: add mmap CoW test for
 mixed&destination extents
Message-ID: <YbX8a/04jx9HRIwz@desktop>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-7-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:42PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode works when the CoW range originally
> covers multiple extents, mixed with reflinked, unwritten, hole, regular and
> delalloc blocks.
> (MMAP version of generic/200,199)
> 
> Also, add a check to make sure the delalloc block is accutally exist.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        |  3 ++
>  tests/generic/905     | 68 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/905.out | 12 ++++++++
>  3 files changed, 83 insertions(+)
>  create mode 100755 tests/generic/905
>  create mode 100644 tests/generic/905.out
> 
> diff --git a/common/reflink b/common/reflink
> index 38210673..84173d59 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -362,6 +362,9 @@ _weave_reflink_rainbow_delalloc() {
>  		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile
>  		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile.chk
>  	done
> +	# make sure we actually got delalloc block
> +	$FILEFRAG_PROG -v $dfile 2>&1 | grep -q delalloc || \
> +		_notrun "test requires delayed allocation writes"

Same comments as to _weave_reflink_holes_dealloc().

Thanks,
Eryu

>  }
>  
>  # Make the source file have interleaved regular blocks and reflinked blocks
> diff --git a/tests/generic/905 b/tests/generic/905
> new file mode 100755
> index 00000000..56cdcd27
> --- /dev/null
> +++ b/tests/generic/905
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 905
> +#
> +# Ensuring that copy on write in mmap mode works when the CoW
> +# range originally covers multiple extents, mixed with reflinked, unwritten,
> +# hole, regular and delalloc blocks.
> +# (MMAP version of generic/200,199)
> +#   - Create a file with the following repeating sequence of blocks:
> +#     1. reflinked
> +#     2. unwritten
> +#     3. hole
> +#     4. regular block
> +#     5. delalloc
> +#   - mmap CoW across the halfway mark, starting with the unwritten extent.
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
> +_weave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
> +_weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
> +# now cow
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
> diff --git a/tests/generic/905.out b/tests/generic/905.out
> new file mode 100644
> index 00000000..6fb0be5f
> --- /dev/null
> +++ b/tests/generic/905.out
> @@ -0,0 +1,12 @@
> +QA output created by 905
> +Format and mount
> +Create the original files
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-905/file1
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-905/file3
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-905/file3.chk
> +mmap CoW across the transition
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-905/file1
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-905/file3
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-905/file3.chk
> -- 
> 2.34.0
> 
> 
