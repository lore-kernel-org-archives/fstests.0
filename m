Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4FEC47094
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Jun 2021 12:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2A9613BC
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Jun 2021 12:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFJM2T (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Jun 2021 08:28:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3944 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJM2Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Jun 2021 08:28:16 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G13691mTNz6xKg;
        Thu, 10 Jun 2021 20:23:13 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 20:26:17 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 dggema759-chm.china.huawei.com (10.1.198.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 20:26:16 +0800
Subject: Re: [PATCH] generic/042: f2fs-utils 1.14.0 needs at least 52 MB
To:     Eryu Guan <guan@eryu.me>
CC:     <fstests@vger.kernel.org>, <yuchao0@huawei.com>
References: <20210601082005.1352814-1-sunke32@huawei.com>
 <YLzWiH5RwHFdEWIQ@desktop>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <232ee4fa-e777-f280-eca5-f98bdc5a620a@huawei.com>
Date:   Thu, 10 Jun 2021 20:26:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YLzWiH5RwHFdEWIQ@desktop>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



ÔÚ 2021/6/6 22:07, Eryu Guan Ð´µÀ:
> On Tue, Jun 01, 2021 at 04:20:05AM -0400, Sun Ke wrote:
>> f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
>> f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change again.
>> But at least we need to configure mininum size of f2fs image to 52MB now.
>>
>> Suggested-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   tests/generic/042 | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/generic/042 b/tests/generic/042
>> index ee0e4b400c71..bf3b4180b1a2 100755
>> --- a/tests/generic/042
>> +++ b/tests/generic/042
>> @@ -43,9 +43,12 @@ _crashtest()
>>   	file=$mnt/file
>>   	size=25M
>>   
>> -	# 25M is too small for f2fs.
>> +	# f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
>> +	# f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change
>> +	# again. But at least we need to configure mininum size of f2fs image
>> +	# to 52MB now.
> 
> It'd be better to specify a slightly bigger fs size for f2fs then. I
> don't think this test depends on the fs size, just that smaller size
> makes test run faster.
> 
> Maybe 64M or 128M, any suggestions from f2fs folks?
> 
> Thanks,
> Eryu
I tested both of them, they both take 5s. So, the bigger is the better, 
I choose 128M.

[root@localhost xfstests-dev]# git diff
diff --git a/tests/generic/042 b/tests/generic/042
index bf3b4180..e5d272ca 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -48,7 +48,7 @@ _crashtest()
         # again. But at least we need to configure mininum size of f2fs 
image
         # to 52MB now.
         if [ $FSTYP == "f2fs" ]; then
-               size=52M
+               size=64M
         fi

         # Create an fs on a small, initialized image. The pattern is 
written to
[root@localhost xfstests-dev]# ./check tests/generic/042
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #8 SMP 
Tue Jun 8 11:09:37 CST 2021
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /tmp/scratch

generic/042 5s ...  5s
Ran: generic/042
Passed all 1 tests

[root@localhost xfstests-dev]# git diff
diff --git a/tests/generic/042 b/tests/generic/042
index bf3b4180..c103959b 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -48,7 +48,7 @@ _crashtest()
         # again. But at least we need to configure mininum size of f2fs 
image
         # to 52MB now.
         if [ $FSTYP == "f2fs" ]; then
-               size=52M
+               size=128M
         fi

         # Create an fs on a small, initialized image. The pattern is 
written to
[root@localhost xfstests-dev]# ./check tests/generic/042
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #8 SMP 
Tue Jun 8 11:09:37 CST 2021
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /tmp/scratch

generic/042 5s ...  5s
Ran: generic/042
Passed all 1 tests

Thanks,
Sun Ke


> 
>>   	if [ $FSTYP == "f2fs" ]; then
>> -		size=38M
>> +		size=52M
>>   	fi
>>   
>>   	# Create an fs on a small, initialized image. The pattern is written to
>> -- 
>> 2.25.4
> .
> 
