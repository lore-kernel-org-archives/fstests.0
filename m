Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25606C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 05:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhLNFhI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 00:37:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:65058 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229755AbhLNFhI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 00:37:08 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Aibuhp69OvT5r/fh39ZpYDrUDqXyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUol0zYBnTMfX2rXOPyCNmP2f9B/aty080sPu5TXzIVjSFdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/jRHOOgULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OaecSjg65HCnyUqdFOpmZ2CFnoeMY8H/eB4KWJ?=
 =?us-ascii?q?D7/oVLHYKdB/rr+yt3L+gVvJEmMsuNo/oMZkZt3UmyivWZcvK67irr77ivIceh?=
 =?us-ascii?q?WlvwJsVW6u2WibQUhI3BDyoXvGFEg5/5EoCodqV?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A8lLN8KObPfRLuMBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118872598"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 13:37:07 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 7B5504D144A2;
        Tue, 14 Dec 2021 13:37:05 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 13:37:04 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 13:37:05 +0800
Message-ID: <14df6055-0b40-fb3d-588a-fe2d9aa8ff3e@fujitsu.com>
Date:   Tue, 14 Dec 2021 13:37:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 14/16] generic: add race test between reflink and mmap
 read
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-15-ruansy.fnst@fujitsu.com>
 <20211207003212.GE8442@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20211207003212.GE8442@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 7B5504D144A2.ABE7A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2021/12/7 8:32, Darrick J. Wong 写道:
> On Thu, Nov 25, 2021 at 03:47:50PM +0800, Shiyang Ruan wrote:
>> Test for races or FS corruption between reflink and mmap reading the
>> target file. (MMAP version of generic/164,165)
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   common/reflink        | 11 +++++++
>>   tests/generic/913     | 72 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/913.out |  5 +++
>>   3 files changed, 88 insertions(+)
>>   create mode 100755 tests/generic/913
>>   create mode 100644 tests/generic/913.out
>>
>> diff --git a/common/reflink b/common/reflink
>> index cca43393..7b94864e 100644
>> --- a/common/reflink
>> +++ b/common/reflink
>> @@ -186,6 +186,17 @@ _read_range() {
>>   	$XFS_IO_PROG $xfs_io_args -f -c "pread -q -v $offset $len" "$file" | cut -d ' ' -f '3-18'
>>   }
>>   
>> +# Prints a range of a file as a hex dump
>> +_mread_range() {
>> +	file="$1"
>> +	offset="$2"
>> +	len="$3"
>> +	xfs_io_args="$4"
>> +
>> +	$XFS_IO_PROG $xfs_io_args -f -c "mmap -rw 0 $((offset + len))" \
>> +		-c "mread -v $offset $len" "$file" | cut -d ' ' -f '3-18'
>> +}
> 
> Hm.  Any reason why you didn't introduce a _mwrite_range helper for
> some of these tests?

I think _mwrite_byte() is enough, since "mwrite" doesn't have a '-v' 
option to show what has been written.

--
Thanks,
Ruan.

> 
> (This test looks fine otherwise...)
> 
> --D
> 
>> +
>>   # Compare ranges of two files
>>   _compare_range() {
>>   	file1="$1"
>> diff --git a/tests/generic/913 b/tests/generic/913
>> new file mode 100755
>> index 00000000..f709c36c
>> --- /dev/null
>> +++ b/tests/generic/913
>> @@ -0,0 +1,72 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# FS QA Test No. 913
>> +#
>> +# Test for races or FS corruption between reflink and mmap reading the
>> +# target file. (MMAP version of generic/164,165)
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto clone
>> +
>> +_register_cleanup "_cleanup" BUS
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +. ./common/reflink
>> +
>> +# real QA test starts here
>> +_require_scratch_reflink
>> +_require_cp_reflink
>> +
>> +echo "Format and mount"
>> +_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mount >> $seqres.full 2>&1
>> +
>> +testdir=$SCRATCH_MNT/test-$seq
>> +finished_file=/tmp/finished
>> +rm -rf $finished_file
>> +mkdir $testdir
>> +
>> +loops=512
>> +nr_loops=$((loops - 1))
>> +blksz=65536
>> +
>> +echo "Initialize files"
>> +echo >> $seqres.full
>> +_pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>> +_pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
>> +_cp_reflink $testdir/file1 $testdir/file3
>> +_scratch_cycle_mount
>> +
>> +fbytes() {
>> +	egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
>> +}
>> +
>> +reader() {
>> +	while [ ! -e $finished_file ]; do
>> +		_mread_range $testdir/file3 0 $((loops * blksz)) | fbytes
>> +	done
>> +}
>> +
>> +echo "Reflink and mmap reread the files!"
>> +reader &
>> +for i in `seq 1 2`; do
>> +	seq $nr_loops -1 0 | while read i; do
>> +		_reflink_range  $testdir/file1 $((i * blksz)) \
>> +				$testdir/file3 $((i * blksz)) $blksz >> $seqres.full
>> +		[ $? -ne 0 ] && break
>> +	done
>> +	seq $nr_loops -1 0 | while read i; do
>> +		_reflink_range  $testdir/file2 $((i * blksz)) \
>> +				$testdir/file3 $((i * blksz)) $blksz >> $seqres.full
>> +		[ $? -ne 0 ] && break
>> +	done
>> +done
>> +echo "Finished reflinking"
>> +touch $finished_file
>> +wait
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/913.out b/tests/generic/913.out
>> new file mode 100644
>> index 00000000..a34df6ce
>> --- /dev/null
>> +++ b/tests/generic/913.out
>> @@ -0,0 +1,5 @@
>> +QA output created by 913
>> +Format and mount
>> +Initialize files
>> +Reflink and mmap reread the files!
>> +Finished reflinking
>> -- 
>> 2.34.0
>>
>>
>>


