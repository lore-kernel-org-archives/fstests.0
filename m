Received: from mail.cn.fujitsu.com ([183.91.158.132]:37739 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725727AbeHWE33 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Aug 2018 00:29:29 -0400
Subject: Re: [PATCH] xfstests: generic/062: Change output of empty attribute
 values
References: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
 <20180822114524.GI2791@desktop>
From: Su Yue <suy.fnst@cn.fujitsu.com>
Message-ID: <654ada95-89a4-2d39-7cd8-5194cc1648c9@cn.fujitsu.com>
Date: Thu, 23 Aug 2018 09:09:04 +0800
MIME-Version: 1.0
In-Reply-To: <20180822114524.GI2791@desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com
List-ID: <fstests@vger.kernel.org>

[CC to zlang@redhat.com to remind]

On 08/22/2018 07:45 PM, Eryu Guan wrote:
> On Wed, Aug 22, 2018 at 04:32:01PM +0800, Su Yue wrote:
>> Since v2.4.47 of attr(5)[1], commit 0550d2bc989d (Properly
>> set and report empty attribute values) changed output format of
>> empty attribute value with quotes.
>>
>> Here, change generic/062.out to match the actual output.
>>
>> [1]: https://git.savannah.nongnu.org/git/attr.git
>>
>> Signed-off-by: Su Yue <suy.fnst@cn.fujitsu.com>
>> ---
>>   tests/generic/062.out | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/tests/generic/062.out b/tests/generic/062.out
>> index 8cc3c655..9b9cd744 100644
>> --- a/tests/generic/062.out
>> +++ b/tests/generic/062.out
>> @@ -13,7 +13,7 @@ SCRATCH_MNT/reg
>>   
>>   *** set/get one initially empty attribute
>>   # file: SCRATCH_MNT/reg
>> -user.name
>> +user.name=""
> 
> This breaks tests with old attr version, we should filter the output so
> that both old and new attr could pass the test.
> 
Understood.

> Please see the discussions in this thread.
> 
> https://patchwork.kernel.org/patch/10521875/
> 
Hmmm, I didn't subscribe the fstests ML before.
Maybe I should search releated info next time :).

Since Zorro had a good solution in the discussion already, it
should belong to him.

Thanks,
Su

> Thanks,
> Eryu
> 
> 
