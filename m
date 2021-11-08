Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE32CC433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 06:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE0C61055
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 06:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhKHGgI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Nov 2021 01:36:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28361 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230170AbhKHGgI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Nov 2021 01:36:08 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AF0MxvqwartdDWrYWsIx6t+cexCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDkg0TEOmjBLWzuBPa2PZ2Wgc4xybdnk/EMP6MPWm4JmHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHuWkUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeaYeSTh7pHDp6HBWz62qxl0N2k6P5If/OlfAmx?=
 =?us-ascii?q?U8/EcbjcXYXirifmqzamnUcFyick5asrmJoUSvjdn1z6xMBqMafgvWI2TvZkBg?=
 =?us-ascii?q?mh23ZsIQJ7jiwMiQWIHRHz9j9dnYz/70K4Dodo=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/l62qawfRHw7gP8VEZtNKrPwSb1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uEvBw+PrCoB1273XJYVUqOU3I++ruBEDoexq1nqKdibNhXotKNzOLhI?=
 =?us-ascii?q?LHFu9f0bc=3D?=
X-IronPort-AV: E=Sophos;i="5.87,217,1631548800"; 
   d="scan'208";a="117046758"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Nov 2021 14:33:22 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 4225549F19C5;
        Mon,  8 Nov 2021 14:33:18 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 8 Nov 2021 14:33:20 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 8 Nov 2021 14:33:20 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 8 Nov 2021 14:33:19 +0800
Message-ID: <1d34c348-33e1-345a-2f4f-10b0ca2c42e5@fujitsu.com>
Date:   Mon, 8 Nov 2021 14:33:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 3/5] generic/xxx: Add MMAP CoW test for 'hole' case
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
 <20211105045222.157826-4-ruansy.fnst@fujitsu.com>
 <20211105164012.GE24282@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20211105164012.GE24282@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 4225549F19C5.ACF26
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2021/11/6 0:40, Darrick J. Wong 写道:
> On Fri, Nov 05, 2021 at 12:52:20PM +0800, Shiyang Ruan wrote:
>> Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
>> the second block is a hole.  (MMAP version of generic/218,220)
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   tests/generic/902     | 70 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/902.out |  6 ++++
>>   2 files changed, 76 insertions(+)
>>   create mode 100755 tests/generic/902
>>   create mode 100644 tests/generic/902.out
>>
>> diff --git a/tests/generic/902 b/tests/generic/902
>> new file mode 100755
>> index 00000000..a0992fc8
>> --- /dev/null
>> +++ b/tests/generic/902
>> @@ -0,0 +1,70 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# FS QA Test No. xxx
>> +#
>> +# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
>> +# the second block is a hole.  (MMAP version of generic/218,220)
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
>> +_require_xfs_io_command "falloc"
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
>> +_reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
>> +_pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
>> +_scratch_cycle_mount
>> +
>> +echo "Compare files"
>> +cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
>> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
>> +
>> +echo "CoW and unmount"
>> +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
>> +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
>> +$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
>> +    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
>> +_scratch_cycle_mount
> 
> One thing I noticed about the last two tests is that since you only
> write to the two shared blocks in the middle of the page, the fs could
> very well ignore the holes in the first and last block when it's
> handling the page fault.  XFS/iomap will (iirc) allocate those two holes
> at writeback time and flush the whole thing to disk, but that isn't a
> guaranteed behavior.

I noticed this too.

> 
> So I think the point of this test is to make sure that COW does the
> right thing on a bs<ps filesystem such that the adjoining blocks don't
> end up with garbage in them, right?  And we don't care what allocation
> decisions the fs makes, so long as the read()able contents are what we
> expect, right?

Yes, this is the purpose of this set of tests, including BufferedIO, 
DIO, MMAP operations.

> 
> If that's correct,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks.


--
Ruan.

> 
> --D
> 
>> +
>> +echo "Compare files"
>> +cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
>> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/902.out b/tests/generic/902.out
>> new file mode 100644
>> index 00000000..4fb8b6cb
>> --- /dev/null
>> +++ b/tests/generic/902.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 902
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


