Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97987C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Dec 2021 00:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350895AbhLGAfq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Dec 2021 19:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350868AbhLGAfp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Dec 2021 19:35:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E5BC061746
        for <fstests@vger.kernel.org>; Mon,  6 Dec 2021 16:32:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 79EFBCE18E1
        for <fstests@vger.kernel.org>; Tue,  7 Dec 2021 00:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9FDC004DD;
        Tue,  7 Dec 2021 00:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638837132;
        bh=wx8MBB9ilnZT9YKvSt2khHKL/+75SMkALQZfyakQdks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJQteob8CRpgrlfMQ5cCnuk9KniQMq/ZynvpvQcSnRb0fZAPw5q711tSgcyIfh9D5
         2dfYybcHmylZAR6/F/R+FoozotmimF8wEiSgAl4ndt31eV3JuJpQRiG5xIwNqxlR4U
         WSvpBSW2ZEB1dm4wJbayNN1qgtooGrqwaBj3EPTWCj8+izoEL+uLu8BvE7ZtWJRdwQ
         vHpyTQrq5NPasuzOW31QGrYTndGrjcrN0LWBUGepDdjey5/z5FEN+Do57CI7WooeCT
         V9TS7sPCU7Czdi7V9sq07Our+F51rmw0NuRFMmm166Pxvegvu18V/mKdGjsjLMNvTz
         mgCL9wwM+Sogg==
Date:   Mon, 6 Dec 2021 16:32:12 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 14/16] generic: add race test between reflink and mmap
 read
Message-ID: <20211207003212.GE8442@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-15-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125074752.274176-15-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 03:47:50PM +0800, Shiyang Ruan wrote:
> Test for races or FS corruption between reflink and mmap reading the
> target file. (MMAP version of generic/164,165)
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  common/reflink        | 11 +++++++
>  tests/generic/913     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/913.out |  5 +++
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/generic/913
>  create mode 100644 tests/generic/913.out
> 
> diff --git a/common/reflink b/common/reflink
> index cca43393..7b94864e 100644
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

Hm.  Any reason why you didn't introduce a _mwrite_range helper for
some of these tests?

(This test looks fine otherwise...)

--D

> +
>  # Compare ranges of two files
>  _compare_range() {
>  	file1="$1"
> diff --git a/tests/generic/913 b/tests/generic/913
> new file mode 100755
> index 00000000..f709c36c
> --- /dev/null
> +++ b/tests/generic/913
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 913
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
> diff --git a/tests/generic/913.out b/tests/generic/913.out
> new file mode 100644
> index 00000000..a34df6ce
> --- /dev/null
> +++ b/tests/generic/913.out
> @@ -0,0 +1,5 @@
> +QA output created by 913
> +Format and mount
> +Initialize files
> +Reflink and mmap reread the files!
> +Finished reflinking
> -- 
> 2.34.0
> 
> 
> 
