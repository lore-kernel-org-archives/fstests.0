Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7021AC2B9F2
	for <linux-fstests@archiver.kernel.org>; Sat, 22 May 2021 09:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D38D610A2
	for <linux-fstests@archiver.kernel.org>; Sat, 22 May 2021 09:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEVJrV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 22 May 2021 05:47:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3632 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEVJrV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 22 May 2021 05:47:21 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnJRK5D5wzQphP;
        Sat, 22 May 2021 17:42:21 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 17:45:53 +0800
Received: from [10.174.179.225] (10.174.179.225) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 17:45:53 +0800
Subject: Re: [PATCH v3] ext4/048: Add new regression test
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>, <guaneryu@gmail.com>, <tytso@mit.edu>
References: <20210521120038.139848-1-chenlongcl.chen@huawei.com>
 <20210521151440.GH9648@magnolia>
From:   "Chenlong (H)" <chenlongcl.chen@huawei.com>
Message-ID: <d9d69637-60df-b979-5d96-0258a3431e39@huawei.com>
Date:   Sat, 22 May 2021 17:45:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521151440.GH9648@magnolia>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.225]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2021/5/21 23:14:40, Darrick J. Wong wrote:
> On Fri, May 21, 2021 at 08:00:38PM +0800, chenlong wrote:
>> Check the block group zero and prevent initializing reserved inodes.
>> But in some special cases, the reserved inode may not all belong to
>> the group zero, it may exist into the second group if we format
>> filesystem below.
>> mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
>> So, it will end up triggering a false positive report of a corrupted
>> file system
>>
>> It's a regression test for commit a149d2a5cabb.
>>
>> Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
>> ---
>>   tests/ext4/048     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/ext4/048.out |  5 ++++
>>   tests/ext4/group   |  1 +
>>   3 files changed, 66 insertions(+)
>>   create mode 100755 tests/ext4/048
>>   create mode 100644 tests/ext4/048.out
>>
>> diff --git a/tests/ext4/048 b/tests/ext4/048
>> new file mode 100755
>> index 00000000..fbbd229a
>> --- /dev/null
>> +++ b/tests/ext4/048
>> @@ -0,0 +1,60 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 Huawei.  All Rights Reserved.
>> +#
>> +# FS QA Test 048
>> +#
>> +# Regression test for commit:
>> +# a149d2a5cabb(ext4: fix check to prevent false positive report of incorrect
>> +# used inodes)
>> +#
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
>> +    cd /
>> +    rm -f $tmp.*
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
>> +_supported_fs ext4
>> +_require_scratch
>> +
>> +# default sleep interval
>> +sleep_time=5
>> +
>> +echo "+ create scratch fs"
>> +_scratch_mkfs_ext4 -b 4096 -g 8192 -N 1024 -I 4096 >> $seqres.full 2>&1
>> +
>> +echo "+ mount fs"
>> +_scratch_mount -o errors=remount-ro
>> +# The default maximum wake-up delay of the lazy init thread of ext4 is
>> +# EXT4_DEF_LI_MAX_START_DELAY (5s).
>> +# After mounting the file system, the lazy init thread will be awakened to
>> +# perform group initialization at 0~5s after the current time. If an error
>> +# is detected during the initialization process, it will be set to read-only,
>> +# so the test case needs to delay a little while waiting for the init thread
>> +# to execute.
>> +sleep $sleep_time
>> +
>> +echo "+ check mountpoint status"
>> +cat /proc/self/mounts | grep -w ${SCRATCH_MNT} | \
>> +    $AWK_PROG '{print $4}' | grep -oE '^rw,' | tee -a $seqres.full
> 
> Er, sorry to be a pain yet again, but I think the critical part of the
> above line is checking that the mount is still in read-write mode,
> correct?
> 
> If that's the case, couldn't this test check the writability of the
> mountpoint?  e.g.
> 
> test -w $SCRATCH_MNT || echo "scratch mount should still be writable"
> 
> (Or is there some other complication here, such as a crashed ext4 fs
> will return EROFS and then `test' does the wrong thing, hence the manual
> check of /proc/self/mounts?)
> 
> --D
> 

It is necessary to strengthen checkpoints. when this bug is not fixed,
the phenomenon of the file system is that it is successfully mounted
first after new formated, and then automatically remounted as read-only.
so i think the checkpoint of this test case must observe this process.
thence add the following two checkpoints.

echo "+ check mountpoint writability"
test -w $SCRATCH_MNT || echo "scratch mount should still be writable"
echo "+ check dmesg"
_check_dmesg_for "\(${sdev}\): Remounting filesystem read-only" && \
     echo "scratch dev should not be remounted to read-only"
if this bug not fixed, Then there must be get a remount log in dmesg.

thank you for your review.

>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/048.out b/tests/ext4/048.out
>> new file mode 100644
>> index 00000000..16e50e86
>> --- /dev/null
>> +++ b/tests/ext4/048.out
>> @@ -0,0 +1,5 @@
>> +QA output created by 048
>> ++ create scratch fs
>> ++ mount fs
>> ++ check mountpoint status
>> +rw,
>> diff --git a/tests/ext4/group b/tests/ext4/group
>> index ceda2ba6..82b77efb 100644
>> --- a/tests/ext4/group
>> +++ b/tests/ext4/group
>> @@ -50,6 +50,7 @@
>>   045 auto dir
>>   046 auto prealloc quick
>>   047 auto quick dax
>> +048 auto quick
>>   271 auto rw quick
>>   301 aio auto ioctl rw stress defrag
>>   302 aio auto ioctl rw stress defrag
>> -- 
>> 2.18.0.huawei.25
>>
> .
> 
