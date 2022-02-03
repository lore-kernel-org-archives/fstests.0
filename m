Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC820C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Feb 2022 14:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiBCOaz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351206AbiBCOaM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Feb 2022 09:30:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A1C06173E
        for <fstests@vger.kernel.org>; Thu,  3 Feb 2022 06:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E833161984
        for <fstests@vger.kernel.org>; Thu,  3 Feb 2022 14:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CD4C340F3;
        Thu,  3 Feb 2022 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643898611;
        bh=WQlUEDnPU6rflf/eis0zKL8HGwOfYb/N1ihp+Oy30rI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cgAohf+IerzFlOsz0HEomaf4zOuahOJgqEnXCuvsK3C5AgrQZG/ReE32vv2VpSQvy
         6UkzJ2H2D9Y2f3HyPfrTp5PMSppPVO73/EPi/StG9A5e8auurbVYWHVL8MyZuKHrGD
         DOJZ3ui6D4H/tu4YbYe1KZ76/JLPhfpMrdjlPe5HfVclQz06iRH4cdglMwaI3lk/3Y
         RSmRZCmgoaOF9+S5PrTfEtt/rqXcQXH0MCnh8uo4cTRXoAgOdm4+8e4Ua1PQSeT6Ad
         8T1SBcHKgrMHFycKu9lguVHRyiFX5RLPEJpqnOLflmpTkTqR7mIsuY13skXRO9pLNu
         8dUuSFKsYAeRA==
Message-ID: <28244cc2-8e83-0730-1777-a363b834819e@kernel.org>
Date:   Thu, 3 Feb 2022 22:30:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] common/attr: _acl_get_max echo 532 for f2fs
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org, guan@eryu.me,
        linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
References: <20220130092858.1260210-1-sunke32@huawei.com>
 <6dbebe97-b29d-ede4-79cf-4d66b2d44c01@kernel.org>
 <YflzoYxCHlA+yCdw@sol.localdomain>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YflzoYxCHlA+yCdw@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/2/2 1:53, Eric Biggers wrote:
> On Sun, Jan 30, 2022 at 11:07:17PM +0800, Chao Yu wrote:
>> On 2022/1/30 17:28, Sun Ke wrote:
>>> Run generic/026 on f2fs, the diff:
>>>
>>>       -chacl: cannot set access acl on "largeaclfile": Argument list too long
>>>       +Wrong ACL count - 532 != 531
>>>
>>> The ACL_MAX_ENTRIES depend on MAX_VALUE_LEN(inode), MAX_VALUE_LEN(inode) I got
>>> by printk is 4244, so I think the ACL_MAX_ENTRIES should be
>>> (4244 - 20) / 8 + 4 =532.
>>>
>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>
>> FYI:
>>
>> https://patchwork.kernel.org/project/fstests/patch/20170428131307.3384-1-chao@kernel.org/
>>
>> I've update the patch based on Jaegeuk's comments, however, I forgot to send it to
>> mailing list, so could you please check revised one below?
>>
>>  From 68965c837fd04795064b352589e3f7005e6d75f5 Mon Sep 17 00:00:00 2001
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
>>   common/attr | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/attr b/common/attr
>> index 35682d7c..6377a936 100644
>> --- a/common/attr
>> +++ b/common/attr
>> @@ -26,11 +26,16 @@ _acl_get_max()
>>   		echo 8191
>>   		;;
>>   	f2fs)
>> -		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
>> +		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
>>   		if [ $? -eq 0 ]; then
>> -			echo 531
>> +			echo 507
>>   		else
>> -			echo 506
>> +			_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
>> +			if [ $? -eq 0 ]; then
>> +				echo 532
>> +			else
>> +				echo 507
>> +			fi
>>   		fi
>>   		;;
> 
> Can you add a comment that explains how these numbers were calculated?  They
> seem very random.

I guess Sun Ke has given a good example...

If inline_xattr is enabled, max xattr size should be:
(4096 - 24 + 200) - (24 + 4) = 4244
then ACL_MAX_ENTRIES should be:
(4244 - (4 + 4 * 4)) / 8 + 4 = 532

Otherwise, if noinline_xattr is enabled, max xattr size should be:
(4096 - 24) - (24 + 4) = 4044
then ACL_MAX_ENTRIES should be:
(4044 - (4 + 4 * 4)) / 8 + 4 = 507

+Cc f2fs mailing list.

Thanks,

> 
> - Eric
