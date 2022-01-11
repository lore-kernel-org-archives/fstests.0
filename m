Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11317C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Jan 2022 18:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350127AbiAKSzU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:55:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52864 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350251AbiAKSzU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Jan 2022 13:55:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70ED7B81A3C
        for <fstests@vger.kernel.org>; Tue, 11 Jan 2022 18:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19465C36AEF;
        Tue, 11 Jan 2022 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641927317;
        bh=s7JZ1wwQDt1g6JiGVWdprSNsaclg2O3QzJZj7Q3jSPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCEs2sR2jcT+k0Fn1KutUL8JXwWZgYqy/Ur7ndiOZVP6XlXtCci/gSNw6weoGK41k
         CeaASM9JWvT5kLoLNTEyDtTKQBUtdZqkIaHG7EpquxVNaS6mYwm7IT2Gh1Huion+1D
         lQqzEg+eElSWxxxNV0iLB1ZePLDUKKd8LDk+wsF8dqPdKaP9X0L7wcRqOhW6Ky1jcJ
         7nd2ueXMZVpmRY196qKN+sMcwJ9Fve4GsuDGX5JoYkF2DdvqhCTkZpM7E08UlCM98n
         fZVqzDe0xfr9BI+zPttckM6RyO80nEjte5JjWtvbv2+3A3D3tCMm/u9vuWUQeGTeRB
         2s8niNm4kcGXw==
Date:   Tue, 11 Jan 2022 10:55:16 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 15/17] generic: add race test between reflink and mmap
 read
Message-ID: <20220111185516.GF31566@magnolia>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
 <20211214081914.2478122-16-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214081914.2478122-16-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 14, 2021 at 04:19:12PM +0800, Shiyang Ruan wrote:
> Test for races or FS corruption between reflink and mmap reading the
> target file. (MMAP version of generic/164,165)

Hi, now that this test has been running for a couple of weeks, I have
observed periodic false positives from this test:

QA output created by 670
Format and mount
Initialize files
Reflink and mmap reread the files!
00001000:  61 61 61 61 61 61 61 61 62 62 62 62 62 62 62 62 aaaabbbb
Finished reflinking

I suspect that if the _mread_range of file3 races with the page cache
invalidation that FICLONERANGE performs, it is possible that the mread
dump will contain a mix of 0x61 and 0x62.  Looking at mread_f, it looks
like it does a byte-at-a-time copy of the mmap...

	if (rflag) {
		for (tmp = length - 1, c = 0; tmp >= 0; tmp--, c = 1) {
			*bp = *(((char *)mapping->addr) + dumpoffset + tmp);
			cnt++;

...which is a sufficient window for the page cache mapping to get
invalidated such that the mread will block on the page fault until the
reflink operation finishes.

I think the solution here is to adjust the egrep regexp above to find
any line that does /not/ contain a's or b's, since (in principle) the
reflink could run fast enough that every byte read hits a pgae fault.
What do you think?

--D

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
> index 68dbdedd..455260c6 100644
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
> 2.34.1
> 
> 
> 
