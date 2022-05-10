Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2761EC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 01:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiEJBVr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 May 2022 21:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiEJBVq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 May 2022 21:21:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA8C1A90C8
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 18:17:49 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ky0Qj2v5jzCsYj;
        Tue, 10 May 2022 09:13:01 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 09:17:47 +0800
Message-ID: <8a9e9f21-8ade-fc5a-6f02-69bb722f1e41@huawei.com>
Date:   Tue, 10 May 2022 09:17:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC v2 2/2] common: correct overlay+tmpfs cycle_mount
To:     <fstests@vger.kernel.org>, <zlang@redhat.com>,
        <amir73il@gmail.com>, "yukuai (C)" <yukuai3@huawei.com>,
        chengzhihao <chengzhihao1@huawei.com>
References: <20220507094524.949615-1-libaokun1@huawei.com>
 <20220507094524.949615-3-libaokun1@huawei.com>
 <20220509151753.6ot6vtbzajl354j2@zlang-mailbox>
From:   "libaokun (A)" <libaokun1@huawei.com>
In-Reply-To: <20220509151753.6ot6vtbzajl354j2@zlang-mailbox>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

在 2022/5/9 23:17, Zorro Lang 写道:
> On Sat, May 07, 2022 at 05:45:24PM +0800, Baokun Li wrote:
>> overlay+tmpfs cycle_mount should be like tmpfs cycle_mount,
>> otherwise some test cases may have issue like "xxx: No such file or directory".
> If the 1st patch brings in an issue, then have to fix it in the 2nd patch,
> I'd like to merge them into one completed patch. And these two patches are
> not big, so it might be fine to do that and send again.
>
> As Amir has given you some review points from overlayfs side, this part might
> affect him more. So I'd like to wait a few days, if no reponse from him or
> others, I'll give your patch my personal RVB, and merge it if test passed.
>
> Thanks,
> Zorro

I will send a patch V3 with the changes suggested by you. Thank you!

>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   common/rc | 31 ++++++++++++++++++++++++-------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 553ae350..ca465438 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -410,10 +410,19 @@ _scratch_cycle_mount()
>>   {
>>       local opts="$1"
>>   
>> -    if [ "$FSTYP" = tmpfs ]; then
>> -	_scratch_remount "$opts"
>> -	return
>> -    fi
>> +	case "$FSTYP" in
>> +	tmpfs)
>> +		_scratch_remount "$opts"
>> +		return
>> +		;;
>> +	overlay)
>> +		if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
>> +			_scratch_remount "$opts"
>> +			return
>> +		fi
>> +		;;
>> +	esac
>> +
>>       if test -n "$opts"; then
>>   	opts="-o $opts"
>>       fi
>> @@ -522,9 +531,17 @@ _test_unmount()
>>   
>>   _test_cycle_mount()
>>   {
>> -    if [ "$FSTYP" = tmpfs ]; then
>> -	return
>> -    fi
>> +	case "$FSTYP" in
>> +	tmpfs)
>> +		return
>> +		;;
>> +	overlay)
>> +		if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
>> +			return
>> +		fi
>> +		;;
>> +	esac
>> +
>>       _test_unmount
>>       _test_mount
>>   }
>> -- 
>> 2.31.1
>>
> .

-- 
With Best Regards,
Baokun Li

