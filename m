Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8797C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Nov 2021 03:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376871AbhK2DqZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Nov 2021 22:46:25 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28115 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348683AbhK2DoZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Nov 2021 22:44:25 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J2WKJ6WSPz1DJcS;
        Mon, 29 Nov 2021 11:38:28 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 11:41:07 +0800
Received: from [10.174.179.138] (10.174.179.138) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 11:41:06 +0800
Subject: Re: [PATCH] ext4: verify ext4 when the starting block of index and
 leaf are inconsistent
To:     Eryu Guan <guan@eryu.me>
CC:     <fstests@vger.kernel.org>, <tytso@mit.edu>
References: <20211123013759.170012-1-chenlongcl.chen@huawei.com>
 <YaOrLVKnPMQbA6lQ@desktop>
From:   "Chenlong (H)" <chenlongcl.chen@huawei.com>
Message-ID: <da284f39-76f6-8c1b-bb87-7ac535480906@huawei.com>
Date:   Mon, 29 Nov 2021 11:41:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YaOrLVKnPMQbA6lQ@desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.138]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2021/11/29 0:15, Eryu Guan wrote:
> On Tue, Nov 23, 2021 at 09:37:59AM +0800, chenlongcl.chen@huawei.com wrote:
>> From: chenlong <chenlongcl.chen@huawei.com>
>>
>> Insert the extent entry in ext4_ext_insert_extent() (to be inserted at
>> the beginning of the block). In the stage of updating the starting block
>> number of the parent index block, an error happened
>> in ext4_ext_correct_indexes()->ext4_ext_get_access(), which caused the
>> index update of the parent index node to fail. The ext4_ext_insert_extent()
>> function exits directly and does not roll back the extent entry of
>> the leaf block. Eventually, the extent starting block numbers in
>> the index block and leaf block are inconsistent, triggering bugon
>>
>> This is a regression test for three kernel commit:
>> 1. 0f2f87d51aebc (ext4: prevent partial update of the extent blocks)
>> 2. 9c6e071913792 (ext4: check for inconsistent extents between index
>>     and leaf block)
>> 3. 8dd27fecede55 (ext4: check for out-of-order index extents in
>>     ext4_valid_extent_entries())
> 
> Missing Signed-off-by tag.
>

Thanks for your review.
I will add it in the V2 version.

>> ---
>>   tests/ext4/054     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/ext4/054.out |  2 +
>>   2 files changed, 99 insertions(+)
>>   create mode 100755 tests/ext4/054
>>   create mode 100644 tests/ext4/054.out
>>
>> diff --git a/tests/ext4/054 b/tests/ext4/054
>> new file mode 100755
>> index 00000000..3d63f12f
>> --- /dev/null
>> +++ b/tests/ext4/054
>> @@ -0,0 +1,97 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 Huawei.  All Rights Reserved.
>> +#
>> +# FS QA Test 054
>> +#
>> +# Regression test for kernel commit:
>> +# 1. 0f2f87d51aebc (ext4: prevent partial update of the extent blocks)
>> +# 2. 9c6e071913792 (ext4: check for inconsistent extents between index \
>> +#    and leaf block)
>> +# 3. 8dd27fecede55 (ext4: check for out-of-order index extents in \
>> +#    ext4_valid_extent_entries())
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_cleanup()
>> +{
>> +    cd /
>> +    rm -f $tmp.*
>> +    $UMOUNT_PROG ${IMG_MNT} > /dev/null 2>&1
>> +    rm -f ${IMG_FILE} > /dev/null 2>&1
>> +}
>> +
>> +# Import common functions
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +_supported_fs ext4
>> +_require_test
>> +_require_xfs_io_command "falloc"
>> +_require_xfs_io_command "pwrite"
>> +_require_xfs_io_command "fsync"
>> +_require_xfs_io_command "fpunch"
>> +_require_command "$DEBUGFS_PROG" debugfs
>> +
>> +IMG_FILE=${SCRATCH_MNT}/$seq.fs
>> +IMG_MNT=${SCRATCH_MNT}/$seq.mnt
> 
> SCRATCH_DEV is not required nor mounted, so IMG_FILE and IMG_MNT are
> created on the root filesystem.
> 
> And I don't see why we need to loop back mount an fs image here, does
> _require_scratch_nocheck then use $SCRATCH_DEV directly work for you?
> 
> And if loop device is really needed, _require_loop should be added as
> well, and use $TEST_DIR to save the fs image and mnt dir, e.g.
> 
> IMG_FILE=$TEST_DIR/$seq.fs
> IMG_MNT=$TEST_DIR/$seq.mnt
> 
> and use _create_loop_device and _destroy_loop_device helpers.
> 

The original idea was to construct a damaged file system by
creating a loop device. In fact, scratch_dev can also achieve
the goal. In V2 version, it will be changed to scratch_dev.

>> +TEST_FILE="${IMG_MNT}/testfile"
>> +
>> +fallocate -l 10M $IMG_FILE
> 
> $XFS_IO_PROG -c "falloc 0 10m" $IMG_FILE
>

use scratch_dev to test, no need to create img_file.

>> +mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
>> +
>> +$MKFS_EXT4_PROG -F $IMG_FILE >> $seqres.full 2>&1 || _fail "mkfs failed"
>> +
>> +$MOUNT_PROG -t ${FSTYP} ${IMG_FILE} ${IMG_MNT} >/dev/null 2>&1 || \
>> +    _fail "mount failed"
> 
> If use $SCRATCH_DEV, above will simply be
> 
> _scratch_mkfs >> $seqres.full 2>&1
> _scratch_mount
>

no need to use loop device.

>> +touch $TEST_FILE
>> +
>> +#
>> +# The following steps create an abnormal file system image and
>> +# create a file(testfile). The starting logic block of his second leaf
>                                                            ^^^^ its ?
>

it is more appropriate to use its here.

>> +# extent block is inconsistent with the starting logic block of the
>> +# second idx extent entry in the inode.
>> +# Level Entries       Logical      Physical Length Flags
>> +# 0/ 1   2/  2  5632 -  6527  2020            896
>> +#               ^^^^ 指向了leaf block
>                          ^^^^^ Use English please.
>

sorry, i correct it.

>> +# 1/ 1   1/ 15  5376 -  5439  7041 -  7104     64 Uninit
>> +# 1/ 1   2/ 15  5632 -  5695  7297 -  7360     64 Uninit
>> +#
>> +for i in {0..50}
>> +do
>> +    offset=$((1024 * 128 * i))
>> +    $XFS_IO_PROG -c "falloc $offset $((1024 * 64))" $TEST_FILE >> $seqres.full
>> +    offset=$((offset + 1024 * 64))
>> +    $XFS_IO_PROG -c "pwrite $offset $((1024 * 64))" $TEST_FILE >> $seqres.full
>> +    $XFS_IO_PROG -c "fsync" $TEST_FILE >> $seqres.full
>> +done
>> +
>> +$XFS_IO_PROG -c "fpunch $((1024 * 5376)) $((1024 * 256))" $TEST_FILE \
>> +        >> $seqres.full
>> +$XFS_IO_PROG -c "fsync" $TEST_FILE >> $seqres.full
>> +$XFS_IO_PROG -c "falloc $((1024 * 5376)) $((1024 * 64))" $TEST_FILE \
>> +        >> $seqres.full
>> +$XFS_IO_PROG -c "fsync" $TEST_FILE
>> +
>> +$UMOUNT_PROG ${IMG_MNT} || _fail "umount failed"
>> +
>> +$DEBUGFS_PROG -w -R "set_inode_field testfile block[6] 0x1600" $IMG_FILE \
>> +        2>>$seqres.full >> $seqres.full
>> +
>> +# Mount the file system and create a block at a location in the middle
>> +# of 5440-5632
>> +
>> +$MOUNT_PROG -t ${FSTYP} -o nodelalloc ${IMG_FILE} ${IMG_MNT} \
> 
> Please add comments to explain why nodelalloc is needed.
> 
> Thanks,
> Eryu
>

When the delalloc option is enabled when mounting, the block allocation
will not be triggered when writing (the maximum waiting time is about
30s). If nodellalloc is used, the block will be allocated when writing.
The expected BUG_ON in this use case can be triggered immediately, and
the test results can be quickly obtained.

I will add comments in the V2 version.

>> +        >/dev/null 2>&1 || _fail "mount failed"
>> +$XFS_IO_PROG -c "pwrite $((1024 * 5568)) $((1024 * 64))" $TEST_FILE \
>> +        2>>$seqres.full >> $seqres.full
>> +
>> +# If this BUG is not fixed, when the testcase is executed to this position,
>> +# the kernel will be BUG_ON immediately.
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/054.out b/tests/ext4/054.out
>> new file mode 100644
>> index 00000000..108fe4c9
>> --- /dev/null
>> +++ b/tests/ext4/054.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 054
>> +Silence is golden
>> -- 
>> 2.17.1
> .
> 
