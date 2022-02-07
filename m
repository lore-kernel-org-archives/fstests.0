Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47D8C433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Feb 2022 15:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiBGPyy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Feb 2022 10:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350807AbiBGPqT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Feb 2022 10:46:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE80C0401CF
        for <fstests@vger.kernel.org>; Mon,  7 Feb 2022 07:46:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45474B815E8
        for <fstests@vger.kernel.org>; Mon,  7 Feb 2022 15:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12AFC004E1;
        Mon,  7 Feb 2022 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644248774;
        bh=hh8j1K6VcEeboxMED15+3SFMjFdf8krgZrn1ypgBQOY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=VYLadK+eU6WQILYM6g2V8qzuNW8/VqjrrAPXUnWKm64F6BiQTdyaMBI/qspibv+jP
         6vjnsf3cU3snn7M6IWTr30vFMViYu0Nlj86xGklXJGRPz3IQsGLjfVyUMipRNZvtzD
         ZV5Qd4ZU4n95TrwtiU153MouMKT7cRiZY2nkXiQeXkg7q6DYpQKXGT9FVv+BL2JcgN
         Yh2C09KTokJpnIjxGdQbIqM7kBahErjRC2WY1kiEzRUxpTTogRMqLTNMhrrCkxfUOE
         XdWH5dSAxXgaYp2a9l4jMc9LDcVZVWaZxZEAcx/T912rcdumZRwrjbL1tqQhyk98Ja
         pnYF3zgBfXqmA==
Message-ID: <7e072d8c-b5e5-5ece-0241-dd51890c5b64@kernel.org>
Date:   Mon, 7 Feb 2022 23:46:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] common/attr: _acl_get_max echo 532 for f2fs
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org, guan@eryu.me
References: <20220130092858.1260210-1-sunke32@huawei.com>
 <6dbebe97-b29d-ede4-79cf-4d66b2d44c01@kernel.org>
 <99dd767d-eb52-44ff-ecaf-059cf3623c29@huawei.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <99dd767d-eb52-44ff-ecaf-059cf3623c29@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/2/7 11:07, Sun Ke wrote:
> 
> 
> 在 2022/1/30 23:07, Chao Yu 写道:
>> On 2022/1/30 17:28, Sun Ke wrote:
>>> Run generic/026 on f2fs, the diff:
>>>
>>>       -chacl: cannot set access acl on "largeaclfile": Argument list
>>> too long
>>>       +Wrong ACL count - 532 != 531
>>>
>>> The ACL_MAX_ENTRIES depend on MAX_VALUE_LEN(inode),
>>> MAX_VALUE_LEN(inode) I got
>>> by printk is 4244, so I think the ACL_MAX_ENTRIES should be
>>> (4244 - 20) / 8 + 4 =532.
>>>
>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>
>> FYI:
>>
>> https://patchwork.kernel.org/project/fstests/patch/20170428131307.3384-1-chao@kernel.org/
>>
>>
>> I've update the patch based on Jaegeuk's comments, however, I forgot to
>> send it to
>> mailing list, so could you please check revised one below?
>>
>>   From 68965c837fd04795064b352589e3f7005e6d75f5 Mon Sep 17 00:00:00 2001
>> From: Chao Yu <chao@kernel.org>
>> Date: Fri, 28 Apr 2017 20:51:11 +0800
>> Subject: [PATCH v2] attr: adbjust acl_max of f2fs
>>
>> f2fs has set inline_xattr as a default option, and introduced a new option
>> named 'noinline_xattr' for disabling default inline_xattr option. So in
>> _acl_get_max we need to check 'noinline_xattr' string in fs option,
>> otherwise we may select the wrong max acl number since we always found
>> the string 'inline_xattr' in fs option.
>>
>> Additionally, f2fs has changed disk layout of xattr block a bit, so will
>> contain one more entry in both inline and noinline xattr inode, this patch
>> will modify the max acl number to adjust it.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - adjust the config for old kernel as well.
>>    common/attr | 11 ++++++++---
>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/attr b/common/attr
>> index 35682d7c..6377a936 100644
>> --- a/common/attr
>> +++ b/common/attr
>> @@ -26,11 +26,16 @@ _acl_get_max()
>>            echo 8191
>>            ;;
>>        f2fs)
>> -        _fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
>> +        _fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
>>            if [ $? -eq 0 ]; then
>> -            echo 531
>> +            echo 507
>>            else
>> -            echo 506
>> +            _fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
>> +            if [ $? -eq 0 ]; then
>> +                echo 532
>> +            else
>> +                echo 507
>> +            fi
>>            fi
>>            ;;
>>        bcachefs)
> 
> Sorry for reply late.
> 
> I send a v2 patch base on your patch, right?

Yes.

Thanks,

> 
> Thanks,
> Sun Ke
