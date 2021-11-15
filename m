Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B63C43217
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 05:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72FF63223
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 05:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhKOFKh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Nov 2021 00:10:37 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20014 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229666AbhKOFKg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Nov 2021 00:10:36 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ArIERBa0b4A+fX5k/FvbD5eRzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ0Dp032YAzGBKDziEPfuIMGahf9x3YYWzo0MCuMPTz9A2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM+X9BDpC79SMljPjRGuKmYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoeCbeSTg4Jz7I0ruNiGEL+9VJEw5IIQe0uJ2B3x?=
 =?us-ascii?q?es/UcKToEZBnFjOWzqJq1UfVhndg4BNfkMZlZuXx6yzzdS/E8Tvj+rw/ijTND9?=
 =?us-ascii?q?G5owJkQQrCFPIxEAQeDpS/oO3VnUmr7wrpn9AtwukTCTg=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AELHmDq9gfTooupQrWOhuk+A8I+orL9Y04lQ7?=
 =?us-ascii?q?vn2YSXRuA66lfqeV7Y0mPH7P+VAssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFgg?=
 =?us-ascii?q?eVxehZhOOIqVDd8m/Fh4tgPMxbE5SWZueAbmSSwfya3OCnKadc/PC3tLCvmfzF?=
 =?us-ascii?q?z2pgCSVja6Rb5Q9/DQqBe3cGPzVuNN4oEoaG/Mpbq36FcXQTVM6yAX4IRKztvN?=
 =?us-ascii?q?vO/aiWGyIuNlo27hWUlzO05PrfGxic5B0XVDRC2vMD3AH+4nTE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="117404798"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2021 13:07:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id E695E4D1010E;
        Mon, 15 Nov 2021 13:07:36 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 15 Nov 2021 13:07:35 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 15 Nov 2021 13:07:38 +0800
Message-ID: <ad1fe7cc-480a-d6c1-266c-9f2153e710ab@fujitsu.com>
Date:   Mon, 15 Nov 2021 13:07:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/3] generic: add race test between reflink and mmap read
To:     Eryu Guan <eguan@linux.alibaba.com>
CC:     <fstests@vger.kernel.org>
References: <20211115034108.1328167-1-ruansy.fnst@fujitsu.com>
 <20211115034108.1328167-2-ruansy.fnst@fujitsu.com>
 <20211115034807.GY60846@e18g06458.et15sqa>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20211115034807.GY60846@e18g06458.et15sqa>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: E695E4D1010E.A0B40
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2021/11/15 11:48, Eryu Guan 写道:
> On Mon, Nov 15, 2021 at 11:41:06AM +0800, Shiyang Ruan wrote:
>> Test for races or FS corruption between reflink and mmap reading the
>> target file. (MMAP version of generic/164,165)
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   common/reflink        | 11 +++++++
>>   tests/generic/930     | 72 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/930.out |  5 +++
>>   3 files changed, 88 insertions(+)
>>   create mode 100755 tests/generic/930
>>   create mode 100644 tests/generic/930.out
>>
>> diff --git a/common/reflink b/common/reflink
>> index 85b586cb..215a8a48 100644
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
>> +
>>   # Compare ranges of two files
>>   _compare_range() {
>>   	file1="$1"
>> diff --git a/tests/generic/930 b/tests/generic/930
>> new file mode 100755
>> index 00000000..c259ae45
>> --- /dev/null
>> +++ b/tests/generic/930
>> @@ -0,0 +1,72 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# FS QA Test No. xxx
> 
> The test number in test should be 930 as well, otherwise I have to
> manually edit it after applying & before running ./tools/mvtest, as
> 'xxx' won't be matched & replaced by the mvtest script.
> 
> The same applies to other tests as well.

Ok.  I didn't know that...  I'll fix it.


--
Thanks,
Ruan.

> 
> Thanks,
> Eryu
> 
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
>> diff --git a/tests/generic/930.out b/tests/generic/930.out
>> new file mode 100644
>> index 00000000..f8e0a1a3
>> --- /dev/null
>> +++ b/tests/generic/930.out
>> @@ -0,0 +1,5 @@
>> +QA output created by 930
>> +Format and mount
>> +Initialize files
>> +Reflink and mmap reread the files!
>> +Finished reflinking
>> -- 
>> 2.33.0
>>
>>


