Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C4FC2B9F4
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 06:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FD1613C1
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 06:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhFQGYo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Jun 2021 02:24:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4822 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQGYo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Jun 2021 02:24:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5Bg05m10zXgkg;
        Thu, 17 Jun 2021 14:17:32 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 14:22:35 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 dggema759-chm.china.huawei.com (10.1.198.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 14:22:34 +0800
Subject: Re: [f2fs-dev] [PATCH] generic/103: leave more space for f2fs
To:     Chao Yu <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
CC:     <fstests@vger.kernel.org>, <guan@eryu.me>, <yuchao0@huawei.com>
References: <20210611112211.1408767-1-sunke32@huawei.com>
 <20210611112211.1408767-2-sunke32@huawei.com>
 <1ea6a853-d892-4c3e-d023-72adc379b803@huawei.com>
 <aa3fef51-5633-800a-1d93-cbfb66453c2a@kernel.org>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <50149b61-d9e1-9464-c5af-9f35d4542fc5@huawei.com>
Date:   Thu, 17 Jun 2021 14:22:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <aa3fef51-5633-800a-1d93-cbfb66453c2a@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2021/6/16 21:15, Chao Yu 写道:
> On 2021/6/15 11:28, Sun Ke wrote:
>> to linux-f2fs-devel@lists.sourceforge.net
>>
>> 在 2021/6/11 19:22, Sun Ke 写道:
>>> It failed on f2fs:
>>>       QA output created by 103
>>>      +fallocate: No space left on device
>>>       Silence is golden.
>>>      ...
>>>
>>> Try to leave ~512KB, but during the fallocate, f2fs will be filled.
>>> Provide error prompt: "fallocate: No space left on device".
>>>
>>> Leave more space for f2fs.
>>>
>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>> ---
>>> I add some test code
>>>     +       df
>>>             avail=`_get_available_space $SCRATCH_MNT`
>>>     +       echo "avail = ${avail}"
>>>             filesizekb=$((avail / 1024 - 512))
>>>     +       echo "filesizekb = ${filesizekb}"
>>>             $XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
>>>     +       df
>>>     }
>>>
>>> f2fs:
>>>     QA output created by 103
>>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>>     ...
>>>     +/dev/sdb          12580864     553292    12027572   5% /mnt/scratch
>>>     +avail = 12316233728
>>>     +filesizekb = 12027060
>>>     +fallocate: No space left on device
>>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>>     ...
>>>     +/dev/sdb          12580864   12580864           0 100% /mnt/scratch
>>>     Silence is golden.
>>>
>>> xfs:
>>>     QA output created by 103
>>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>>     ...
>>>     +/dev/sdb          12572672     120828    12451844   1% /mnt/scratch
>>>     +avail = 12750688256
>>>     +filesizekb = 12451332
>>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>>     ...
>>>     +/dev/sdb          12572672   12572160         512 100% /mnt/scratch
>>>     Silence is golden.
>>>
>>> ext4:
>>>     QA output created by 103
>>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>>     ...
>>>     +/dev/sdb          12319880      41048    11633304   1% /mnt/scratch
>>>     +avail = 11912503296
>>>     +filesizekb = 11632792
>>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>>     ...
>>>     +/dev/sdb          12319880   11673844         508 100% /mnt/scratch
>>>     Silence is golden.
>>>
>>> after change (f2fs)
>>>     QA output created by 103
>>>     Filesystem       1K-blocks       Used   Available Use% Mounted on
>>>     ...
>>>     /dev/sdb          12580864   12580396         468 100% /tmp/scratch
>>>     Silence is golden.
>>>
>>>   tests/generic/103 | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/generic/103 b/tests/generic/103
>>> index b22b0159623e..dfce3870781c 100755
>>> --- a/tests/generic/103
>>> +++ b/tests/generic/103
>>> @@ -40,10 +40,18 @@ rm -f $seqres.full
>>>   _consume_freesp()
>>>   {
>>>       file=$1
>>> +    leave=512
>>> +
>>> +    # Try to leave ~512KB, but during the fallocate, f2fs will be 
>>> filled.
>>> +    # Provide error prompt: "fallocate: No space left on device". Leave
>>> +    # more space for f2fs.
>>> +    if [ $FSTYP == "f2fs" ]; then
>>> +        leave=12288
>>> +    fi
>>>       # consume nearly all available space (leave ~512kB)
>>>       avail=`_get_available_space $SCRATCH_MNT`
> 
>          if [ $FSTYP == "f2fs" ]; then
>                  left=$((left + avail / 1024000))
>          fi
> 
> f2fs uses index(radix) tree as mapping metadata, its space overhead
> is about one thousandth of the data, so can you please try above
> calculation?
> 
> Thanks,
I have tried your calculation, it works. I will send v2 patch.

Thanks,
Sun Ke
> 
>>> -    filesizekb=$((avail / 1024 - 512))
>>> +    filesizekb=$((avail / 1024 - $leave))
>>>       $XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
>>>   }
>>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
