Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12611C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Dec 2021 13:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhLLNlU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Dec 2021 08:41:20 -0500
Received: from out20-49.mail.aliyun.com ([115.124.20.49]:42624 "EHLO
        out20-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLLNlU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Dec 2021 08:41:20 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0744102|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.13613-0.00685008-0.85702;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.MAlHB9k_1639316476;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MAlHB9k_1639316476)
          by smtp.aliyun-inc.com(10.147.44.129);
          Sun, 12 Dec 2021 21:41:16 +0800
Date:   Sun, 12 Dec 2021 21:41:16 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 05/16] generic: add mmap CoW test for
 delalloc&destination extents
Message-ID: <YbX7/AINpzbh5b2L@desktop>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-6-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:41PM +0800, Shiyang Ruan wrote:
> Ensuring that copy on write in mmap mode works when the CoW range originally
> covers multiple extents, some delalloc, some not.
> (MMAP version of generic/195,194)
> 
> Also, add a check to make sure the delalloc block is accutally exist.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        |  3 +++
>  tests/generic/904     | 61 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/904.out | 12 +++++++++
>  3 files changed, 76 insertions(+)
>  create mode 100755 tests/generic/904
>  create mode 100644 tests/generic/904.out
> 
> diff --git a/common/reflink b/common/reflink
> index ee60398e..38210673 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -296,6 +296,9 @@ _weave_reflink_holes_delalloc() {
>  		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile
>  		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile.chk
>  	done
> +	# make sure we actually got delalloc block
> +	$FILEFRAG_PROG -v $dfile 2>&1 | grep -q delalloc || \
> +		_notrun "test requires delayed allocation writes"

I think we need a new _require rule to check delalloc status explicitly,
not do the check and call _notrun in a helper function that does the
real work not check.

Perhaps we could turn the delalloc check in xfs/172 into a helper like
_require_scratch_delalloc, and call it in each test that needs dealloc
writes.

Thanks,
Eryu

>  }
>  
>  # Create a file of interleaved regular blocks and reflinked blocks
> diff --git a/tests/generic/904 b/tests/generic/904
> new file mode 100755
> index 00000000..69703d70
> --- /dev/null
> +++ b/tests/generic/904
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 904
> +#
> +# Ensuring that copy on write in mmap mode works when the CoW
> +# range originally covers multiple extents, some delalloc, some not.
> +# (MMAP version of generic/195,194)
> +#   - Create a file.
> +#   - Reflink the odd blocks of the first file into the second file.
> +#   - Buffered write the even blocks of the second file.
> +#   - mmap CoW across the halfway mark, starting with the unwritten extent.
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
> +_weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
> +_weave_reflink_holes_delalloc $blksz $nr $testdir/file3 >> $seqres.full
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
> +exit
> diff --git a/tests/generic/904.out b/tests/generic/904.out
> new file mode 100644
> index 00000000..cc993394
> --- /dev/null
> +++ b/tests/generic/904.out
> @@ -0,0 +1,12 @@
> +QA output created by 904
> +Format and mount
> +Create the original files
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-904/file1
> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-904/file3
> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-904/file3.chk
> +mmap CoW across the transition
> +Compare files
> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-904/file1
> +55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-904/file3
> +55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-904/file3.chk
> -- 
> 2.34.0
> 
> 
