Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34504C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Dec 2021 13:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhLYN1F (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Dec 2021 08:27:05 -0500
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:56308 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhLYN1E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Dec 2021 08:27:04 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436351|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0640487-0.00454744-0.931404;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.MR.ImCl_1640438822;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MR.ImCl_1640438822)
          by smtp.aliyun-inc.com(10.147.40.44);
          Sat, 25 Dec 2021 21:27:02 +0800
Date:   Sat, 25 Dec 2021 21:27:01 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 12/17] generic: add buffered-io CoW test for
 mixed&source extents
Message-ID: <YcccJY4stD0rGmCL@desktop>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
 <20211214081914.2478122-13-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214081914.2478122-13-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 14, 2021 at 04:19:09PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in buffered mode works when the CoW
> range originally covers multiple extents, mixed with reflinked, unwritten,
> hole, regular and delalloc blocks.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        | 51 +++++++++++++++++++++++++++++++++
>  tests/generic/910     | 65 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/910.out | 12 ++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100755 tests/generic/910
>  create mode 100644 tests/generic/910.out
> 
> diff --git a/common/reflink b/common/reflink
> index ee60398e..68dbdedd 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -426,3 +426,54 @@ _sweave_reflink_holes_delalloc() {
>  		_pwrite_byte 0x64 $((blksz * i)) $blksz $sfile.chk
>  	done
>  }
> +
> +# Create a file of interleaved holes, unwritten blocks, regular blocks, and
> +# reflinked blocks
> +_sweave_reflink_rainbow() {
> +	blksz=$1
> +	nr=$2
> +	sfile=$3
> +	dfile=$4

These variables should be declared as local.

> +
> +	$XFS_IO_PROG -f -c "truncate $((blksz * nr))" $sfile
> +	_pwrite_byte 0x00 0 $((blksz * nr)) $sfile.chk
> +	_pwrite_byte 0x61 0 $((blksz * nr)) $dfile
> +	seq 0 5 $((nr - 1)) | while read i; do
> +		_pwrite_byte 0x61 $((blksz * i)) $blksz $sfile
> +		_pwrite_byte 0x61 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 0 blocks are reflinked
> +	seq 0 5 $((nr - 1)) | while read i; do
> +		_reflink_range $sfile $((blksz * i)) $dfile $((blksz * i)) $blksz
> +		_pwrite_byte 0x61 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 1 blocks are unwritten
> +	seq 1 5 $((nr - 1)) | while read i; do
> +		$XFS_IO_PROG -f -c "falloc $((blksz * i)) $blksz" $sfile
> +		_pwrite_byte 0x00 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 2 blocks are holes
> +	seq 2 5 $((nr - 1)) | while read i; do
> +		_pwrite_byte 0x00 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 3 blocks are regular
> +	seq 3 5 $((nr - 1)) | while read i; do
> +		_pwrite_byte 0x71 $((blksz * i)) $blksz $sfile
> +		_pwrite_byte 0x71 $((blksz * i)) $blksz $sfile.chk
> +	done
> +	# 4 blocks will be delalloc later
> +}
> +
> +# For a file created with _sweave_reflink_rainbow, fill the holes with delalloc
> +# extents
> +_sweave_reflink_rainbow_delalloc() {
> +	blksz=$1
> +	nr=$2
> +	dfile=$3

Same here.

> +
> +	# 4 blocks are delalloc (do later)
> +	seq 4 5 $((nr - 1)) | while read i; do
> +		_pwrite_byte 0x62 $((blksz * i)) $blksz $sfile
> +		_pwrite_byte 0x62 $((blksz * i)) $blksz $sfile.chk

And there's no 'sfile' in this function, should be $dfile and $dfile.chk

I've fixed them all on commit.

Thanks,
Eryu

> +	done
> +}
> diff --git a/tests/generic/910 b/tests/generic/910
> new file mode 100755
> index 00000000..32628060
> --- /dev/null
> +++ b/tests/generic/910
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 910
> +#
> +# Ensuring that copy on write in buffered mode works when the CoW
> +# range originally covers multiple extents, mixed with reflinked, unwritten,
> +# hole, regular and delalloc blocks.
> +#   - Create a file with the following repeating sequence of blocks:
> +#     1. reflinked
> +#     2. unwritten
> +#     3. hole
> +#     4. regular block
> +#     5. delalloc
> +#   - CoW across the halfway mark, starting with the unwritten extent.
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
> +_require_scratch_delalloc
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "fpunch"
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
> +_sweave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +echo "CoW across the transition"
> +cowoff=$((filesize / 4))
> +cowsz=$((filesize / 2))
> +_sweave_reflink_rainbow_delalloc $blksz $nr $testdir/file1 >> $seqres.full
> +# now cow
> +$XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
> +_pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
> +_scratch_cycle_mount
> +
> +echo "Compare files"
> +md5sum $testdir/file1 | _filter_scratch
> +md5sum $testdir/file3 | _filter_scratch
> +md5sum $testdir/file1.chk | _filter_scratch
> +
> +# success, all done
> +status=0
> diff --git a/tests/generic/910.out b/tests/generic/910.out
> new file mode 100644
> index 00000000..12956584
> --- /dev/null
> +++ b/tests/generic/910.out
> @@ -0,0 +1,12 @@
> +QA output created by 910
> +Format and mount
> +Create the original files
> +Compare files
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-910/file1
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-910/file3
> +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-910/file1.chk
> +CoW across the transition
> +Compare files
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-910/file1
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-910/file3
> +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-910/file1.chk
> -- 
> 2.34.1
> 
> 
