Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5D6C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 05:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhLNFmA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 00:42:00 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:5941 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229977AbhLNFl7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 00:41:59 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AZ9Rc4qi7Yjy/77CyPVqQZq8WX161QhIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVUnWUZCmuCO/iCYTOhLY90bI2z8kMGsJfQztAwHQVl/nw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOOlUre?=
 =?us-ascii?q?YYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHm4ZzMlRKYKRMAxN0rVinaJ7Yw9ft+B0l?=
 =?us-ascii?q?D7+0FbjUABjiNnP67266gYvdji95lL8TxOo4b/HZ6wlnk4VwOKXzYa/ySo4YGg?=
 =?us-ascii?q?3Fr3YYTdcsyrvExMVJHBCksqTUVUrvPNK8DoQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgY1q3KjcPQZ/wR18Ow+EsVcp0HBQXjwji2hC?=
 =?us-ascii?q?6mlwRA09TySZ//re+cjzsiWE8Ar5OUtQ4OxoV5PvfZqxz+8T3WBVB8bFYOCEgg?=
 =?us-ascii?q?qVxeNZgrcKqgeIc0aVm4JgPOVbAsxD4bbLfDtHZKjBkWuF+poboOVv7prY+dv2?=
 =?us-ascii?q?/jN8Sx1wcaF840NcAgafKEd/Qw5LHvMCZeChz/sCtzy9Ym4Wc8j+InEEWtLIr9?=
 =?us-ascii?q?rNmImjTgUBA3ccmXSzpALt+LjnCAKZwxtbdztOxI0p+W/Dnxe8xojLiYDB9iPh?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118872762"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 13:41:57 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 589B74D140DD;
        Tue, 14 Dec 2021 13:41:53 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 13:41:53 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 13:41:52 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 13:41:52 +0800
Message-ID: <5cad413e-fe20-1d6e-9b03-1ce1249b1858@fujitsu.com>
Date:   Tue, 14 Dec 2021 13:41:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 05/16] generic: add mmap CoW test for
 delalloc&destination extents
To:     Eryu Guan <guan@eryu.me>
CC:     <fstests@vger.kernel.org>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-6-ruansy.fnst@fujitsu.com> <YbX7/AINpzbh5b2L@desktop>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YbX7/AINpzbh5b2L@desktop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 589B74D140DD.AE00A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2021/12/12 21:41, Eryu Guan 写道:
> On Thu, Nov 25, 2021 at 03:47:41PM +0800, Shiyang Ruan wrote:
>> Ensuring that copy on write in mmap mode works when the CoW range originally
>> covers multiple extents, some delalloc, some not.
>> (MMAP version of generic/195,194)
>>
>> Also, add a check to make sure the delalloc block is accutally exist.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   common/reflink        |  3 +++
>>   tests/generic/904     | 61 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/904.out | 12 +++++++++
>>   3 files changed, 76 insertions(+)
>>   create mode 100755 tests/generic/904
>>   create mode 100644 tests/generic/904.out
>>
>> diff --git a/common/reflink b/common/reflink
>> index ee60398e..38210673 100644
>> --- a/common/reflink
>> +++ b/common/reflink
>> @@ -296,6 +296,9 @@ _weave_reflink_holes_delalloc() {
>>   		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile
>>   		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile.chk
>>   	done
>> +	# make sure we actually got delalloc block
>> +	$FILEFRAG_PROG -v $dfile 2>&1 | grep -q delalloc || \
>> +		_notrun "test requires delayed allocation writes"
> 
> I think we need a new _require rule to check delalloc status explicitly,
> not do the check and call _notrun in a helper function that does the
> real work not check.
> 
> Perhaps we could turn the delalloc check in xfs/172 into a helper like
> _require_scratch_delalloc, and call it in each test that needs dealloc
> writes.

OK, thanks for the advice. I think this is better.


--
Thanks,
Ruan.

> 
> Thanks,
> Eryu
> 
>>   }
>>   
>>   # Create a file of interleaved regular blocks and reflinked blocks
>> diff --git a/tests/generic/904 b/tests/generic/904
>> new file mode 100755
>> index 00000000..69703d70
>> --- /dev/null
>> +++ b/tests/generic/904
>> @@ -0,0 +1,61 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# FS QA Test No. 904
>> +#
>> +# Ensuring that copy on write in mmap mode works when the CoW
>> +# range originally covers multiple extents, some delalloc, some not.
>> +# (MMAP version of generic/195,194)
>> +#   - Create a file.
>> +#   - Reflink the odd blocks of the first file into the second file.
>> +#   - Buffered write the even blocks of the second file.
>> +#   - mmap CoW across the halfway mark, starting with the unwritten extent.
>> +#   - Check that the files are now different where we say they're different.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick clone
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +. ./common/reflink
>> +
>> +# real QA test starts here
>> +_require_scratch_reflink
>> +_require_xfs_io_command "falloc"
>> +
>> +echo "Format and mount"
>> +_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mount >> $seqres.full 2>&1
>> +
>> +testdir=$SCRATCH_MNT/test-$seq
>> +mkdir $testdir
>> +
>> +echo "Create the original files"
>> +blksz=65536
>> +nr=64
>> +filesize=$((blksz * nr))
>> +_weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
>> +_scratch_cycle_mount
>> +
>> +echo "Compare files"
>> +md5sum $testdir/file1 | _filter_scratch
>> +md5sum $testdir/file3 | _filter_scratch
>> +md5sum $testdir/file3.chk | _filter_scratch
>> +
>> +echo "mmap CoW across the transition"
>> +cowoff=$((filesize / 4))
>> +cowsz=$((filesize / 2))
>> +_weave_reflink_holes_delalloc $blksz $nr $testdir/file3 >> $seqres.full
>> +mmapsz=$((cowoff + cowsz))
>> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3 >> $seqres.full
>> +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3.chk >> $seqres.full
>> +_scratch_cycle_mount
>> +
>> +echo "Compare files"
>> +md5sum $testdir/file1 | _filter_scratch
>> +md5sum $testdir/file3 | _filter_scratch
>> +md5sum $testdir/file3.chk | _filter_scratch
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/904.out b/tests/generic/904.out
>> new file mode 100644
>> index 00000000..cc993394
>> --- /dev/null
>> +++ b/tests/generic/904.out
>> @@ -0,0 +1,12 @@
>> +QA output created by 904
>> +Format and mount
>> +Create the original files
>> +Compare files
>> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-904/file1
>> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-904/file3
>> +fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-904/file3.chk
>> +mmap CoW across the transition
>> +Compare files
>> +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-904/file1
>> +55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-904/file3
>> +55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-904/file3.chk
>> -- 
>> 2.34.0
>>
>>


