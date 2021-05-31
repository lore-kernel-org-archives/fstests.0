Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DDFC47082
	for <linux-fstests@archiver.kernel.org>; Mon, 31 May 2021 03:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2AE610A8
	for <linux-fstests@archiver.kernel.org>; Mon, 31 May 2021 03:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhEaDzv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 May 2021 23:55:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2478 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaDzu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 May 2021 23:55:50 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FthD13Lsmz68xs;
        Mon, 31 May 2021 11:51:13 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 11:54:07 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 dggema759-chm.china.huawei.com (10.1.198.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 31 May 2021 11:54:06 +0800
Subject: Re: [PATCH] generic/042: set size to 38M for f2fs
To:     Chao Yu <yuchao0@huawei.com>, <guan@eryu.me>
CC:     <fstests@vger.kernel.org>, <djwong@kernel.org>
References: <20210518114700.2118225-1-sunke32@huawei.com>
 <5876f2b8-1776-0a8c-4d69-71e573810afe@huawei.com>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <c6d71c1c-b242-5a81-2842-bcfb5bbf6296@huawei.com>
Date:   Mon, 31 May 2021 11:54:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5876f2b8-1776-0a8c-4d69-71e573810afe@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2021/5/31 10:11, Chao Yu 写道:
> On 2021/5/18 19:47, Sun Ke wrote:
>> 25M is too small for f2fs:
>>
>> Info: Disable heap-based policy
>> Info: Debug level = 0
>> Info: Label =
>> Info: Trim is enabled
>> Info: Segments per section = 1
>> Info: Sections per zone = 1
>> Info: sector size = 512
>> Info: total sectors = 51200 (25 MB)
>> Info: zone aligned segment0 blkaddr: 512
>>      Error: Device size is not sufficient for F2FS volume
>>      Error: Failed to prepare a super block!!!
>>      Error: Could not format the device!!!
>>
>> So, set size to 38M for f2fs.
> 
> It looks f2fs-utils 1.14.0 needs at least 52 MB space for f2fs image.
> 
> mkfs.f2fs /dev/zram0 13056 -f
> 
>      F2FS-tools: mkfs.f2fs Ver: 1.14.0 (2021-02-16)
> 
> Info: Disable heap-based policy
> Info: Debug level = 0
> Info: Trim is enabled
> Info: wanted sectors = 13056 (in 18446744073709551615 bytes)
> Info: total device sectors = 4194304 (in 4096 bytes)
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 4096
> Info: total sectors = 13056 (51 MB)
> Info: zone aligned segment0 blkaddr: 512
>      Error: Device size is not sufficient for F2FS volume
>      Error: Failed to prepare a super block!!!
>      Error: Could not format the device!!!
> 
> Thanks,

My F2FS-tools is mkfs.f2fs Ver: 1.9.0 (2017-09-21). So, is 52MB  enough? 
The image size f2fs needed seems growing.

Thanks.
Sun Ke

> 
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>> I have tried from 25M, until 38M, it passed.
>>
>> [root@localhost xfstests]# ./check tests/generic/042
>> FSTYP         -- f2fs
>> PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #3 
>> SMP Wed Apr 21 22:29:25 EDT 2021
>> MKFS_OPTIONS  -- /dev/sdb
>> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /mnt/scratch
>>
>> generic/042 2s ...  2s
>> Ran: generic/042
>> Passed all 1 tests
>>
>>   tests/generic/042 | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/042 b/tests/generic/042
>> index 35727bcb..ee0e4b40 100755
>> --- a/tests/generic/042
>> +++ b/tests/generic/042
>> @@ -41,10 +41,16 @@ _crashtest()
>>       img=$SCRATCH_MNT/$seq.img
>>       mnt=$SCRATCH_MNT/$seq.mnt
>>       file=$mnt/file
>> +    size=25M
>> +
>> +    # 25M is too small for f2fs.
>> +    if [ $FSTYP == "f2fs" ]; then
>> +        size=38M
>> +    fi
>>       # Create an fs on a small, initialized image. The pattern is 
>> written to
>>       # the image to detect stale data exposure.
>> -    $XFS_IO_PROG -f -c "truncate 0" -c "pwrite -S 0xCD 0 25M" $img \
>> +    $XFS_IO_PROG -f -c "truncate 0" -c "pwrite -S 0xCD 0 $size" $img \
>>           >> $seqres.full 2>&1
>>       _mkfs_dev $img >> $seqres.full 2>&1
>>
> .
