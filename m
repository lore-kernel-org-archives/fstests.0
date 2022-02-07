Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766E9C433FE
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Feb 2022 06:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbiBGF6e (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Feb 2022 00:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbiBGD0K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Feb 2022 22:26:10 -0500
X-Greylist: delayed 1095 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 19:26:07 PST
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E40CC061A73
        for <fstests@vger.kernel.org>; Sun,  6 Feb 2022 19:26:07 -0800 (PST)
Received: from kwepemi100024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JsWJW1dtgzcck7;
        Mon,  7 Feb 2022 11:06:51 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100024.china.huawei.com (7.221.188.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 11:07:50 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 11:07:49 +0800
Subject: Re: [PATCH] common/attr: _acl_get_max echo 532 for f2fs
To:     Chao Yu <chao@kernel.org>, <fstests@vger.kernel.org>,
        <guan@eryu.me>
References: <20220130092858.1260210-1-sunke32@huawei.com>
 <6dbebe97-b29d-ede4-79cf-4d66b2d44c01@kernel.org>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <99dd767d-eb52-44ff-ecaf-059cf3623c29@huawei.com>
Date:   Mon, 7 Feb 2022 11:07:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <6dbebe97-b29d-ede4-79cf-4d66b2d44c01@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2022/1/30 23:07, Chao Yu 写道:
> On 2022/1/30 17:28, Sun Ke wrote:
>> Run generic/026 on f2fs, the diff:
>>
>>      -chacl: cannot set access acl on "largeaclfile": Argument list 
>> too long
>>      +Wrong ACL count - 532 != 531
>>
>> The ACL_MAX_ENTRIES depend on MAX_VALUE_LEN(inode), 
>> MAX_VALUE_LEN(inode) I got
>> by printk is 4244, so I think the ACL_MAX_ENTRIES should be
>> (4244 - 20) / 8 + 4 =532.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
> 
> FYI:
> 
> https://patchwork.kernel.org/project/fstests/patch/20170428131307.3384-1-chao@kernel.org/ 
> 
> 
> I've update the patch based on Jaegeuk's comments, however, I forgot to 
> send it to
> mailing list, so could you please check revised one below?
> 
>  From 68965c837fd04795064b352589e3f7005e6d75f5 Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao@kernel.org>
> Date: Fri, 28 Apr 2017 20:51:11 +0800
> Subject: [PATCH v2] attr: adbjust acl_max of f2fs
> 
> f2fs has set inline_xattr as a default option, and introduced a new option
> named 'noinline_xattr' for disabling default inline_xattr option. So in
> _acl_get_max we need to check 'noinline_xattr' string in fs option,
> otherwise we may select the wrong max acl number since we always found
> the string 'inline_xattr' in fs option.
> 
> Additionally, f2fs has changed disk layout of xattr block a bit, so will
> contain one more entry in both inline and noinline xattr inode, this patch
> will modify the max acl number to adjust it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - adjust the config for old kernel as well.
>   common/attr | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index 35682d7c..6377a936 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -26,11 +26,16 @@ _acl_get_max()
>           echo 8191
>           ;;
>       f2fs)
> -        _fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
> +        _fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
>           if [ $? -eq 0 ]; then
> -            echo 531
> +            echo 507
>           else
> -            echo 506
> +            _fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
> +            if [ $? -eq 0 ]; then
> +                echo 532
> +            else
> +                echo 507
> +            fi
>           fi
>           ;;
>       bcachefs)

Sorry for reply late.

I send a v2 patch base on your patch, right?

Thanks,
Sun Ke
