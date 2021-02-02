Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D69C433E0
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Feb 2021 11:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5094664F51
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Feb 2021 11:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBBLxg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:53:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12007 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhBBLxf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Feb 2021 06:53:35 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVNSk67h8zjGx1;
        Tue,  2 Feb 2021 19:51:34 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 19:52:50 +0800
Subject: Re: [v2] ext4: Add a test for rename with RENAME_WHITEOUT
To:     <fstests@vger.kernel.org>
References: <20210128061202.210074-1-sunke32@huawei.com>
 <20210130111229.GW14354@localhost.localdomain>
CC:     <zlang@redhat.com>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <79c90c48-c011-b9f8-3ab8-299a7053abaa@huawei.com>
Date:   Tue, 2 Feb 2021 19:52:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210130111229.GW14354@localhost.localdomain>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi, Zorro

ÔÚ 2021/1/30 19:12, Zorro Lang Ð´µÀ:
> On Thu, Jan 28, 2021 at 02:12:02PM +0800, Sun Ke wrote:
>> Fill the disk space, try to create some files and rename a file, mount
>> again, list directory contents and triggers some errors. It is a
>> regression test for kernel commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for
>> rename with RENAME_WHITEOUT")
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>> v1 -> v3:
>> Use the original in src and modify 048.out
>> ---
>> ---
>>   tests/ext4/048     | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/ext4/048.out |  2 ++
>>   tests/ext4/group   |  1 +
>>   3 files changed, 79 insertions(+)
>>   create mode 100755 tests/ext4/048
>>   create mode 100644 tests/ext4/048.out
>>
>> diff --git a/tests/ext4/048 b/tests/ext4/048
>> new file mode 100755
>> index 00000000..0311d1a2
>> --- /dev/null
>> +++ b/tests/ext4/048
>> @@ -0,0 +1,76 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 HUAWEI.  All Rights Reserved.
>> +#
>> +# FS QA Test 048
>> +#
>> +# This is a regression test for kernel patch:
>> +# commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for rename with RENAME_WHITEOUT")
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs ext4
>> +_supported_fs generic
> ext4 or generic? Tell the truth, according to below testing steps, I think it
> can be a generic test case, not only for ext4.
>
>> +_require_scratch
>> +_require_xfs_io_command "falloc"
>> +
>> +dmesg -c > /dev/null
>> +
>> +_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mount >> $seqres.full 2>&1
>> +
>> +testdir=$SCRATCH_MNT
>> +cd ${testdir}
>> +
>> +mkdir test
>> +$XFS_IO_PROG -f -c "falloc 0 128M" img >> $seqres.full
>> +$MKFS_EXT4_PROG  img > /dev/null 2>&1
>> +$MOUNT_PROG img test
> Can we reproduce this bug by $SCRATCH_DEV directly, not through a loopdev.
> Likes:
>
> _scratch_mkfs_sized 128M (maybe bigger ?)
> _scratch_mount

I tried this:

dev_size=$((128 * 1024 * 1024))
_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
_scratch_mount

But it do not reproduce this bug. Maybe it should through a loopdev.


>
>> +
>> +# fill the disk space
>> +dd if=/dev/zero of=test/foo bs=1M count=128 > /dev/null 2>&1
> Can _fill_fs() helper help you that?
>
>> +
>> +# create 1000 files, not all the files will be created successfully
>> +mkdir test/dir
>> +cd test/dir
>> +for ((i = 0; i < 1000; i++))
>> +do
>> +	touch file$i > /dev/null 2>&1
>> +done
> I don't know if it can be 100% sure there's at least 1 file will be created at
> here, after you tried to fill the fs.
>
> So I think maybe you can create a file with known name, then use _fill_fs()
> to fill the whole fs. Then try to rename the file you know its name. Can that
> reproduce the bug?
It can not repoduce the bug.
>
>> +
>> +# try to rename, but now no space left on device
>> +$here/src/renameat2 -w $testdir/test/dir/file1 $testdir/test/dir/dst_file
>> +
>> +cd $testdir
>> +$UMOUNT_PROG test
>> +$MOUNT_PROG img test
>> +ls -l test/dir/file1 > /dev/null 2>&1
>> +$UMOUNT_PROG test
>> +
>> +dmesg -c | grep "deleted inode referenced"
> Can _check_dmesg_for() help you?
>
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/048.out b/tests/ext4/048.out
>> new file mode 100644
>> index 00000000..5b3990da
>> --- /dev/null
>> +++ b/tests/ext4/048.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 048
>> +No space left on device
>> diff --git a/tests/ext4/group b/tests/ext4/group
>> index ceda2ba6..6140dd7e 100644
>> --- a/tests/ext4/group
>> +++ b/tests/ext4/group
>> @@ -50,6 +50,7 @@
>>   045 auto dir
>>   046 auto prealloc quick
>>   047 auto quick dax
>> +048 other
> I think your test case is a general test case, "auto"and "rename" groups
> are good to it, if it's quick enough, add "quick" group.

Maybe it is only ext4 test case, I think.


Thanks,

Sun Ke

>
>>   271 auto rw quick
>>   301 aio auto ioctl rw stress defrag
>>   302 aio auto ioctl rw stress defrag
>> -- 
>> 2.13.6
>>
> .
