Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C466C433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 21 May 2021 11:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA256008E
	for <linux-fstests@archiver.kernel.org>; Fri, 21 May 2021 11:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhEUL6k (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 May 2021 07:58:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5656 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhEUL6j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 May 2021 07:58:39 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FmlQC1GDHz1BPFK;
        Fri, 21 May 2021 19:54:27 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 19:57:14 +0800
Received: from [10.174.179.225] (10.174.179.225) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 19:57:14 +0800
Subject: Re: [PATCH] ext4/048: Add new regression test
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>, <guaneryu@gmail.com>, <tytso@mit.edu>
References: <20210519031015.14005-1-chenlongcl.chen@huawei.com>
 <20210519232435.GE9648@magnolia>
 <7a77fe95-2a4d-9092-9fdf-0a4a4fadd418@huawei.com>
 <20210520163425.GG9648@magnolia>
From:   "Chenlong (H)" <chenlongcl.chen@huawei.com>
Message-ID: <fa4f803c-495a-5de7-d33f-e1f730588d54@huawei.com>
Date:   Fri, 21 May 2021 19:57:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520163425.GG9648@magnolia>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.225]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2021/5/21 0:34:25, Darrick J. Wong wrote:
> On Thu, May 20, 2021 at 11:41:52AM +0800, Chenlong (H) wrote:
>>
>>
>> On 2021/5/20 7:24:35, Darrick J. Wong wrote:
>>> On Wed, May 19, 2021 at 11:10:15AM +0800, chenlong wrote:
>>>> Check the block group zero and prevent initializing reserved inodes.
>>>> But in some special cases, the reserved inode may not all belong to
>>>> the group zero, it may exist into the second group if we format
>>>> filesystem below.
>>>> mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
>>>> So, it will end up triggering a false positive report of a corrupted
>>>> file system
>>>>
>>>> It's a regression test for commit a149d2a5cabb.
>>>>
>>>> Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
>>>> ---
>>>>    tests/ext4/048     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>    tests/ext4/048.out |  5 +++++
>>>>    tests/ext4/group   |  1 +
>>>>    3 files changed, 56 insertions(+)
>>>>    create mode 100755 tests/ext4/048
>>>>    create mode 100644 tests/ext4/048.out
>>>>
>>>> diff --git a/tests/ext4/048 b/tests/ext4/048
>>>> new file mode 100755
>>>> index 00000000..56801579
>>>> --- /dev/null
>>>> +++ b/tests/ext4/048
>>>> @@ -0,0 +1,50 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2021 Huawei.  All Rights Reserved.
>>>> +#
>>>> +# FS QA Test 048
>>>> +#
>>>> +# Regression test for commit:
>>>> +# a149d2a5cabb(ext4: fix check to prevent false positive report of incorrect
>>>> +# used inodes)
>>>> +#
>>>> +seq=`basename $0`
>>>> +seqres=$RESULT_DIR/$seq
>>>> +echo "QA output created by $seq"
>>>> +
>>>> +here=`pwd`
>>>> +tmp=/tmp/$$
>>>> +status=1	# failure is the default!
>>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>>> +
>>>> +_cleanup()
>>>> +{
>>>> +    cd /
>>>> +    rm -f $tmp.*
>>>> +}
>>>> +
>>>> +# get standard environment, filters and checks
>>>> +. ./common/rc
>>>> +. ./common/filter
>>>> +
>>>> +# remove previous $seqres.full before test
>>>> +rm -f $seqres.full
>>>> +
>>>> +# real QA test starts here
>>>> +_supported_fs ext4
>>>> +_require_scratch
>>>> +
>>>> +echo "+ create scratch fs"
>>>> +_scratch_mkfs_ext4 -b 4096 -g 8192 -N 1024 -I 4096 >> $seqres.full 2>&1
>>>> +
>>>> +echo "+ mount fs"
>>>> +_scratch_mount -o errors=remount-ro
>>>> +sleep 5
>>>
>>> Why do we need to sleep here?  Won't _scratch_mount return nonzero if
>>> the (buggy) kernel thought the fs was corrupt?
>>>
>>> Also, won't the grep below catch that the fs didn't mount?
>>>
>>
>> The default maximum wake-up delay of the lazy init thread of ext4 is
>> EXT4_DEF_LI_MAX_START_DELAY (5s).
>>
>> After mounting the file system, the lazy init thread will be awakened to
>> perform group initialization at 0~5s
>>
>> after the current time. If an error is detected during the initialization
>> process, it will be set to read-only,
>>
>> so the test case needs to delay a little while waiting for the init thread
>> to execute.
> 
> Oh, that's why there's a delay.  Could you paste this explanation into
> the test case as a comment right before the 'sleep 5', please?
> 
> Also, if the delay is configurable you might want to set it to a known
> value at the start of this test.
> 
> --D
>

Thank you，here really need to add this explanation and set the sleep 
time to a configurable value.

>> in this testcase,  _scratch_mount will be return zero, after a short period
>> of time, the file system will be remounted as read-only.
>>
>> In an environment with this bug,  such as:
>>
>> [root@testvm ~]# mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
>>
>> [root@testvm ~]# mount -o errors=remount-ro /dev/sda /mnt
>>
>> [root@testvm ~]# mount | grep /dev/sda
>>
>> /dev/sda on /mnt type ext4 (rw,relatime,errors=remount-ro)
>>
>> After the file system is mounted，file system status is rw，but a moment
>> later, status will be change to ro.
>>
>> [root@testvm ~]# mount | grep /dev/sda
>>
>> /dev/sda on /mnt type ext4 (ro,relatime,errors=remount-ro)
>>
>>>> +
>>>> +echo "+ check mountpoint status"
>>>> +cat /proc/self/mounts | grep ${SCRATCH_MNT} | \
>>>
>>> Careful here, if someone sets SCRATCH_MNT=/u, this will match another
>>> mount for /usr.  At the bare minimum you want 'grep -w' here, I think.
>>>
>>> --D
>>>
>>
>> There is a risk here and needs to be fixed.
>>
>>>> +    $AWK_PROG '{print $4}' | grep -oE '^rw,' | tee -a $seqres.full
>>>> +
>>>> +# success, all done
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/ext4/048.out b/tests/ext4/048.out
>>>> new file mode 100644
>>>> index 00000000..16e50e86
>>>> --- /dev/null
>>>> +++ b/tests/ext4/048.out
>>>> @@ -0,0 +1,5 @@
>>>> +QA output created by 048
>>>> ++ create scratch fs
>>>> ++ mount fs
>>>> ++ check mountpoint status
>>>> +rw,
>>>> diff --git a/tests/ext4/group b/tests/ext4/group
>>>> index ceda2ba6..82b77efb 100644
>>>> --- a/tests/ext4/group
>>>> +++ b/tests/ext4/group
>>>> @@ -50,6 +50,7 @@
>>>>    045 auto dir
>>>>    046 auto prealloc quick
>>>>    047 auto quick dax
>>>> +048 auto quick
>>>>    271 auto rw quick
>>>>    301 aio auto ioctl rw stress defrag
>>>>    302 aio auto ioctl rw stress defrag
>>>> -- 
>>>> 2.18.0.huawei.25
>>>>
>>> .
>>>
> .
> 
