Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D9C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58A461BE5
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbhKODwq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Nov 2021 22:52:46 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35709 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237359AbhKODvH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Nov 2021 22:51:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UwXdmiI_1636948087;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UwXdmiI_1636948087)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Nov 2021 11:48:08 +0800
Date:   Mon, 15 Nov 2021 11:48:07 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] generic: add race test between reflink and mmap read
Message-ID: <20211115034807.GY60846@e18g06458.et15sqa>
References: <20211115034108.1328167-1-ruansy.fnst@fujitsu.com>
 <20211115034108.1328167-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115034108.1328167-2-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 15, 2021 at 11:41:06AM +0800, Shiyang Ruan wrote:
> Test for races or FS corruption between reflink and mmap reading the
> target file. (MMAP version of generic/164,165)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        | 11 +++++++
>  tests/generic/930     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/930.out |  5 +++
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/generic/930
>  create mode 100644 tests/generic/930.out
> 
> diff --git a/common/reflink b/common/reflink
> index 85b586cb..215a8a48 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -186,6 +186,17 @@ _read_range() {
>  	$XFS_IO_PROG $xfs_io_args -f -c "pread -q -v $offset $len" "$file" | cut -d ' ' -f '3-18'
>  }
>  
> +# Prints a range of a file as a hex dump
> +_mread_range() {
> +	file="$1"
> +	offset="$2"
> +	len="$3"
> +	xfs_io_args="$4"
> +
> +	$XFS_IO_PROG $xfs_io_args -f -c "mmap -rw 0 $((offset + len))" \
> +		-c "mread -v $offset $len" "$file" | cut -d ' ' -f '3-18'
> +}
> +
>  # Compare ranges of two files
>  _compare_range() {
>  	file1="$1"
> diff --git a/tests/generic/930 b/tests/generic/930
> new file mode 100755
> index 00000000..c259ae45
> --- /dev/null
> +++ b/tests/generic/930
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. xxx

The test number in test should be 930 as well, otherwise I have to
manually edit it after applying & before running ./tools/mvtest, as
'xxx' won't be matched & replaced by the mvtest script.

The same applies to other tests as well.

Thanks,
Eryu

> +#
> +# Test for races or FS corruption between reflink and mmap reading the
> +# target file. (MMAP version of generic/164,165)
> +#
> +. ./common/preamble
> +_begin_fstest auto clone
> +
> +_register_cleanup "_cleanup" BUS
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_scratch_reflink
> +_require_cp_reflink
> +
> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +finished_file=/tmp/finished
> +rm -rf $finished_file
> +mkdir $testdir
> +
> +loops=512
> +nr_loops=$((loops - 1))
> +blksz=65536
> +
> +echo "Initialize files"
> +echo >> $seqres.full
> +_pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
> +_pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
> +_cp_reflink $testdir/file1 $testdir/file3
> +_scratch_cycle_mount
> +
> +fbytes() {
> +	egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
> +}
> +
> +reader() {
> +	while [ ! -e $finished_file ]; do
> +		_mread_range $testdir/file3 0 $((loops * blksz)) | fbytes
> +	done
> +}
> +
> +echo "Reflink and mmap reread the files!"
> +reader &
> +for i in `seq 1 2`; do
> +	seq $nr_loops -1 0 | while read i; do
> +		_reflink_range  $testdir/file1 $((i * blksz)) \
> +				$testdir/file3 $((i * blksz)) $blksz >> $seqres.full
> +		[ $? -ne 0 ] && break
> +	done
> +	seq $nr_loops -1 0 | while read i; do
> +		_reflink_range  $testdir/file2 $((i * blksz)) \
> +				$testdir/file3 $((i * blksz)) $blksz >> $seqres.full
> +		[ $? -ne 0 ] && break
> +	done
> +done
> +echo "Finished reflinking"
> +touch $finished_file
> +wait
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/930.out b/tests/generic/930.out
> new file mode 100644
> index 00000000..f8e0a1a3
> --- /dev/null
> +++ b/tests/generic/930.out
> @@ -0,0 +1,5 @@
> +QA output created by 930
> +Format and mount
> +Initialize files
> +Reflink and mmap reread the files!
> +Finished reflinking
> -- 
> 2.33.0
> 
> 
