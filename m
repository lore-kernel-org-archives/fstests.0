Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF5C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 06:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E985B61208
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 06:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhKHGV1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Nov 2021 01:21:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53554 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229807AbhKHGV0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Nov 2021 01:21:26 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AsjbVP67JXLZmJJWQdGwUcgxRtBHFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENShWcCy2UcWD+Gb/yCMGOjeNggPYvi9E5X78CBy95rSgE5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+OkV7a?=
 =?us-ascii?q?eUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCfn7ZLJlRGun3zEhq8G4FsNFYEa5eFxDkl?=
 =?us-ascii?q?N+OYeJTRLaQqM78q42662UfV3rtosIdOtP44FvHxkizbDAp4brTrrK0nRzYYAm?=
 =?us-ascii?q?m5u2YYVRrCDD/f1oAFHNHzoCyCj8H9MYH7moNqVuw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Awwx7AqMZdnNnxcBcTiWjsMiBIKoaSvp037Eq?=
 =?us-ascii?q?v3oBKyC9Ffbo7vxG/c5rsyMc5wx/ZJhNo6HlBEDEewK6yXcX2+cs1NWZMDUO0V?=
 =?us-ascii?q?HAROoJgLcKgQeQfhEWndQ86U4PSdkcNDS9NzlHZNjBkXSFOudl0N+a67qpmOub?=
 =?us-ascii?q?639sSDthY6Zm4xwRMHfhLmRGABlBGYEiFIeRou5Opz+bc3wRacihQlYfWeyrna?=
 =?us-ascii?q?ywqLvWJQ4BGwU86BSDyReh6LvBGRCe2RsEFxNjqI1SiVT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,217,1631548800"; 
   d="scan'208";a="117046224"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Nov 2021 14:18:40 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 7F3F24D0D9D7;
        Mon,  8 Nov 2021 14:18:34 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 8 Nov 2021 14:18:36 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 8 Nov 2021 14:18:36 +0800
Message-ID: <3487e0fd-4fb6-d8ea-c5bf-b2ee679f792d@fujitsu.com>
Date:   Mon, 8 Nov 2021 14:18:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/5] generic/xxx: Add MMAP CoW test for 'unwritten'
 case
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
 <20211105045222.157826-3-ruansy.fnst@fujitsu.com>
 <20211105162011.GD24282@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20211105162011.GD24282@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 7F3F24D0D9D7.AF51A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2021/11/6 0:20, Darrick J. Wong 写道:
> On Fri, Nov 05, 2021 at 12:52:19PM +0800, Shiyang Ruan wrote:
>> Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
>> the second block is a unwritten block.  (MMAP version of generic/216,217)
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   tests/generic/901     | 76 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/901.out |  6 ++++
>>   2 files changed, 82 insertions(+)
>>   create mode 100755 tests/generic/901
>>   create mode 100644 tests/generic/901.out
>>
>> diff --git a/tests/generic/901 b/tests/generic/901
>> new file mode 100755
>> index 00000000..46459815
>> --- /dev/null
>> +++ b/tests/generic/901
>> @@ -0,0 +1,76 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# FS QA Test No. xxx
>> +#
>> +# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
>> +# the second block is a unwritten block.  (MMAP version of generic/216,217)
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
> 
> Oh, something I didn't notice with the previous patch -- this exact
> _cleanup function is now provided by common/preamble as a default.  If
> you don't have anything to add to the cleanup process, then you can omit
> this definition.

We created a testdir here but the default _cleanup doesn't remove it, so 
I think this overrided cleanup is needed.

--
Thanks,
Ruan.

> 
> With that fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> 
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
>> +$XFS_IO_PROG -f -c "falloc -k $blksz $blksz" $testdir/file2 >> $seqres.full
>> +_pwrite_byte 0x00 $blksz $blksz $testdir/file2.chk >> $seqres.full
>> +
>> +$XFS_IO_PROG -f -c "falloc -k $((blksz * 3)) $blksz" $testdir/file2 >> $seqres.full
>> +_pwrite_byte 0x00 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
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
>> +
>> +echo "Compare files"
>> +cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
>> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/901.out b/tests/generic/901.out
>> new file mode 100644
>> index 00000000..07b9b433
>> --- /dev/null
>> +++ b/tests/generic/901.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 901
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


