Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A512DC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 04:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB53611C3
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 04:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhKEEH1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 00:07:27 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61915 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229470AbhKEEH1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Nov 2021 00:07:27 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A/IOyaqpwuRXJdXSP1+51dH+h681eBmIxZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmoZUGyCOPaNYWb8LY1+a960/EIAup6DzdBqTQU4r3w0QiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?dYn0pHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXNnhSYIiu9qxlpJARsVWECwc57A35?=
 =?us-ascii?q?J8/MwKz0XaB2HweWsz9qTRPJwi98/N+H1M44F/HJt1zfUCbAhW5+rfklgzbe0x?=
 =?us-ascii?q?x9p3oYXQ6mYPJFfNFJSgN37S0UnEj8q5FgWxY9EXkXCTgA=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ANDvNxapggDMSCLe9JP1o1mMaV5rPeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj5qKTdZMgpGbJYVcqKRcdcL+7V5VoLUmskaKdpLNhWotKPzOJhI?=
 =?us-ascii?q?LLFu1fBOLZqlWKcUDDH6xmpMJdmsNFaOEYY2IK7voSrDPYLz8/+qj7zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2fqYRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2fSIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl92ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="116916989"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2021 12:04:47 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 7B0554D10107;
        Fri,  5 Nov 2021 12:04:42 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 12:04:43 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 5 Nov 2021 12:04:42 +0800
Message-ID: <01f75786-9d5a-96c0-29b9-8bb889091a16@fujitsu.com>
Date:   Fri, 5 Nov 2021 12:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/5] generic/xxx: Add MMAP CoW test for 'regular' case
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>
References: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
 <20211105034200.143626-2-ruansy.fnst@fujitsu.com>
 <20211105034935.GA24282@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20211105034935.GA24282@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 7B0554D10107.ACAC0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2021/11/5 11:49, Darrick J. Wong 写道:
> On Fri, Nov 05, 2021 at 11:41:56AM +0800, Shiyang Ruan wrote:
>> Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
>> the second block is a regular block.  (MMAP version of generic/205,206)
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   tests/generic/900     | 75 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/900.out |  6 ++++
>>   2 files changed, 81 insertions(+)
>>   create mode 100755 tests/generic/900
>>   create mode 100644 tests/generic/900.out
>>
>> diff --git a/tests/generic/900 b/tests/generic/900
>> new file mode 100755
>> index 00000000..b608e314
>> --- /dev/null
>> +++ b/tests/generic/900
>> @@ -0,0 +1,75 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# FS QA Test No. xxx
>> +#
>> +# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
>> +# the second block is a regular block.  (MMAP version of generic/205,206)
>> +#
>> +# This test is dependent on the system page size, so we cannot use md5 in
>> +# the golden output; we can only compare to a check file.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick clone
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +    cd /
>> +    rm -rf $tmp.* $testdir
>> +}
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +. ./common/reflink
>> +
>> +# real QA test starts here
>> +_require_scratch_reflink
>> +
>> +pagesz=$(getconf PAGE_SIZE)
>> +blksz=$((pagesz / 4))
>> +
>> +echo "Format and mount"
>> +_scratch_mkfs_blocksized $blksz > $seqres.full 2>&1
>> +_scratch_mount >> $seqres.full 2>&1
>> +
>> +testdir=$SCRATCH_MNT/test-$seq
>> +mkdir $testdir
>> +
>> +real_blksz=$(_get_file_block_size $testdir)
>> +test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
>> +
>> +echo "Create the original files"
>> +_pwrite_byte 0x61 0 $pagesz $testdir/file1 >> $seqres.full
>> +
>> +$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2 >> $seqres.full
>> +$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2.chk >> $seqres.full
>> +
>> +_pwrite_byte 0x61 $blksz $blksz $testdir/file2 >> $seqres.full
>> +_pwrite_byte 0x61 $blksz $blksz $testdir/file2.chk >> $seqres.full
>> +
>> +_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2 >> $seqres.full
>> +_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
>> +
>> +_reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
>> +_pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
>> +_scratch_cycle_mount
>> +
>> +echo "Compare files"
>> +! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
> 
> not-or?  Is this the logical equivalent of:
> 
> cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match"

The logic is same.  I was thinking that it's easy for us to understand 
that it is supposed to be not equal with a '!' in the head of the line.

The echo message needs to be changed as your suggestion.

> 
>> +cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't match."
> 
> Also, for non-fatal failures, please use echo instead of _fail; the
> discrepancy will be flagged as test failure(s) by the golden output
> comparison.

Understood. I'll fix all this problems in this series.

--
Thanks,
Ruan.

> 
>> +
>> +echo "CoW and unmount"
>> +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
>> +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
>> +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
>> +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
>> +_scratch_cycle_mount
>> +
>> +echo "Compare files"
>> +! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
>> +cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't match."
> 
> Same here.
> 
> --D
> 
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/900.out b/tests/generic/900.out
>> new file mode 100644
>> index 00000000..2abfd789
>> --- /dev/null
>> +++ b/tests/generic/900.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 900
>> +Format and mount
>> +Create the original files
>> +Compare files
>> +CoW and unmount
>> +Compare files
>> -- 
>> 2.33.0
>>
>>
>>


