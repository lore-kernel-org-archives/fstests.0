Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF7C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jan 2022 02:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348817AbiALCjD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Jan 2022 21:39:03 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59197 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236970AbiALCjD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Jan 2022 21:39:03 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Arllqn656oZt3NGz7gupUdgxRtBHFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0WEAxmVMUGiCa/eMamunKt1wPYu+8ksHu8OHyN83GgY5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuOlUba?=
 =?us-ascii?q?fUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyDl7JPJkhGun3zEhq8G4FsNFYEa5eFxDkl?=
 =?us-ascii?q?N+OYeJTRLaQqM78q42662UfV3rtosIdOtP44FvHxkizbDAp4brTrrK0nRzYYAm?=
 =?us-ascii?q?m5u2YYVRrCDD/f1oAFHNHzoCyCj8H9OYH7moNqVuw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A9Juhuq/+vI4uOFyMGtJuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,281,1635177600"; 
   d="scan'208";a="120257254"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Jan 2022 10:39:01 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 8FD4C4D13A1B;
        Wed, 12 Jan 2022 10:38:59 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 12 Jan 2022 10:38:57 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 12 Jan 2022 10:38:57 +0800
Message-ID: <f76e6ebc-2ffb-5ddf-d886-4d1fa4f82548@fujitsu.com>
Date:   Wed, 12 Jan 2022 10:38:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 15/17] generic: add race test between reflink and mmap
 read
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>, <ruansy.fnst@fujitsu.com>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
 <20211214081914.2478122-16-ruansy.fnst@fujitsu.com>
 <20220111185516.GF31566@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220111185516.GF31566@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 8FD4C4D13A1B.A1F83
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2022/1/12 2:55, Darrick J. Wong 写道:
> On Tue, Dec 14, 2021 at 04:19:12PM +0800, Shiyang Ruan wrote:
>> Test for races or FS corruption between reflink and mmap reading the
>> target file. (MMAP version of generic/164,165)
> 
> Hi, now that this test has been running for a couple of weeks, I have
> observed periodic false positives from this test:
> 
> QA output created by 670
> Format and mount
> Initialize files
> Reflink and mmap reread the files!
> 00001000:  61 61 61 61 61 61 61 61 62 62 62 62 62 62 62 62 aaaabbbb
> Finished reflinking
> 
> I suspect that if the _mread_range of file3 races with the page cache
> invalidation that FICLONERANGE performs, it is possible that the mread
> dump will contain a mix of 0x61 and 0x62.  Looking at mread_f, it looks
> like it does a byte-at-a-time copy of the mmap...
> 
> 	if (rflag) {
> 		for (tmp = length - 1, c = 0; tmp >= 0; tmp--, c = 1) {
> 			*bp = *(((char *)mapping->addr) + dumpoffset + tmp);
> 			cnt++;
> 
> ...which is a sufficient window for the page cache mapping to get
> invalidated such that the mread will block on the page fault until the
> reflink operation finishes.
> 
> I think the solution here is to adjust the egrep regexp above to find
> any line that does /not/ contain a's or b's, since (in principle) the
> reflink could run fast enough that every byte read hits a pgae fault.
> What do you think?

Reasonable.  I couldn't reproduce it in my test environment, so I didn't 
take that situation into consideration.

I'll change the regexp as below:
fbytes() {
-	egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 62 62 
62 62 62 62 62 62 62 62 62 62 62 62)'
+	egrep -v '((61|62) ){15}(61|62)'
}


--
Thanks,
Ruan.

> 
> --D
> 
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
>> index 68dbdedd..455260c6 100644
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
>> 2.34.1
>>
>>
>>


