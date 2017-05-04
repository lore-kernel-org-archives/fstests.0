Received: from mail.kernel.org ([198.145.29.136]:36500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdEDPdN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 May 2017 11:33:13 -0400
Subject: Re: [PATCH] attr: adbjust acl_max of f2fs
References: <20170428131307.3384-1-chao@kernel.org>
 <20170503170227.GA93619@jaegeuk.local>
From: Chao Yu <chao@kernel.org>
Message-ID: <3c80f5f0-f68e-a6f6-b355-fd5e0fcdbe76@kernel.org>
Date: Thu, 4 May 2017 23:32:39 +0800
MIME-Version: 1.0
In-Reply-To: <20170503170227.GA93619@jaegeuk.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, eguan@redhat.com, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

Hi Jaegeuk,

On 2017/5/4 1:02, Jaegeuk Kim wrote:
> Hello,
> 
> On 04/28, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> f2fs has set inline_xattr as a default option, and introduced a new option
>> named 'noinline_xattr' for disabling default inline_xattr option. So in
>> _acl_get_max we need to check 'noinline_xattr' string in fs option,
>> otherwise we may select the wrong max acl number since we always found
>> the string 'ininline_xattr' in fs option.
>>
>> Additionally, f2fs has changed disk layout of xattr block a bit, so will
>> contain one more entry in both inline and noinline xattr inode, this patch
>> will modify the max acl number to adjust it.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  common/attr | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/attr b/common/attr
>> index ac139e61..6d4f68ed 100644
>> --- a/common/attr
>> +++ b/common/attr
>> @@ -43,11 +43,11 @@ _acl_get_max()
>>  		echo 8191
>>  		;;
>>  	f2fs)
>> -		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
>> +		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
> 
> This breaks old kernel support which has no "noinline_xattr". It'd be good to
> check "inline_xattr" again after checking "noinline_xattr". And, in terms of

Hmm, we have changed xattr layout a bit in new kernel, so even we have
knew that user set inline_xattr mount option, still we don't know
whether the last kernel was been used, so we can not decide to choose
532 or 531 as acl_max value. Maybe we need to check result of 'uname -r'
either.

> different number of entries, can we get the number from local.config by adding
> an export symbol likewise FSTYP?

You mean adding one more configuration parameter which can be defined by
user, then _acl_get_max can return correct acl_max value depend on that
parameter?

Thanks,

> 
> Thanks,
> 
>>  		if [ $? -eq 0 ]; then
>> -			echo 531
>> +			echo 507
>>  		else
>> -			echo 506
>> +			echo 532
>>  		fi
>>  		;;
>>  	*)
>> -- 
>> 2.12.2.575.gb14f27f
