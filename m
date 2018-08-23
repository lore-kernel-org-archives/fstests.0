Received: from mail.cn.fujitsu.com ([183.91.158.132]:25517 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727162AbeHWDuP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Aug 2018 23:50:15 -0400
Subject: Re: [PATCH] xfstests: generic/062: Change output of empty attribute
 values
References: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
 <CAL3q7H4UVg8Rz5afkG5K4MOWymCe=w8DH5wKfMv_+PZeVbPmHQ@mail.gmail.com>
From: Su Yue <suy.fnst@cn.fujitsu.com>
Message-ID: <2bd649b9-b783-6756-adbd-af68eec45dd2@cn.fujitsu.com>
Date: Thu, 23 Aug 2018 08:29:59 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4UVg8Rz5afkG5K4MOWymCe=w8DH5wKfMv_+PZeVbPmHQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 08/22/2018 07:49 PM, Filipe Manana wrote:
> On Wed, Aug 22, 2018 at 9:32 AM, Su Yue <suy.fnst@cn.fujitsu.com> wrote:
>> Since v2.4.47 of attr(5)[1], commit 0550d2bc989d (Properly
>> set and report empty attribute values) changed output format of
>> empty attribute value with quotes.
>>
>> Here, change generic/062.out to match the actual output.
> 
> This will break the test on systems with older versions of the tool
> (think enterprise distros for example).
> The correct way to do this in fstests is to use filters (we have
> numerous examples around).
> 
Thanks, I will do it in V2.
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
>>
>>   *** overwrite empty, set several new attributes
>>   *** fetch several attribute names and values (hex)
>> @@ -42,7 +42,7 @@ user.name3=0xdeface
>>
>>   *** set an empty value for second attribute
>>   # file: SCRATCH_MNT/reg
>> -user.name2
>> +user.name2=""
>>
>>   *** overwrite empty value
>>   # file: SCRATCH_MNT/reg
>> @@ -60,7 +60,7 @@ user.name3=0xdeface
>>
>>   *** set/get one initially empty attribute
>>   # file: SCRATCH_MNT/dir
>> -user.name
>> +user.name=""
>>
>>   *** overwrite empty, set several new attributes
>>   *** fetch several attribute names and values (hex)
>> @@ -89,7 +89,7 @@ user.name3=0xdeface
>>
>>   *** set an empty value for second attribute
>>   # file: SCRATCH_MNT/dir
>> -user.name2
>> +user.name2=""
>>
>>   *** overwrite empty value
>>   # file: SCRATCH_MNT/dir
>> @@ -207,7 +207,7 @@ SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
>>
>>   *** set/get one initially empty attribute
>>   # file: SCRATCH_MNT/reg
>> -trusted.name
>> +trusted.name=""
>>
>>   *** overwrite empty, set several new attributes
>>   *** fetch several attribute names and values (hex)
>> @@ -236,7 +236,7 @@ trusted.name3=0xdeface
>>
>>   *** set an empty value for second attribute
>>   # file: SCRATCH_MNT/reg
>> -trusted.name2
>> +trusted.name2=""
>>
>>   *** overwrite empty value
>>   # file: SCRATCH_MNT/reg
>> @@ -256,7 +256,7 @@ user.name3=0xdeface
>>
>>   *** set/get one initially empty attribute
>>   # file: SCRATCH_MNT/dir
>> -trusted.name
>> +trusted.name=""
>>
>>   *** overwrite empty, set several new attributes
>>   *** fetch several attribute names and values (hex)
>> @@ -285,7 +285,7 @@ trusted.name3=0xdeface
>>
>>   *** set an empty value for second attribute
>>   # file: SCRATCH_MNT/dir
>> -trusted.name2
>> +trusted.name2=""
>>
>>   *** overwrite empty value
>>   # file: SCRATCH_MNT/dir
>> @@ -305,7 +305,7 @@ user.name3=0xdeface
>>
>>   *** set/get one initially empty attribute
>>   # file: SCRATCH_MNT/lnk
>> -trusted.name
>> +trusted.name=""
>>
>>   *** overwrite empty, set several new attributes
>>   *** fetch several attribute names and values (hex)
>> @@ -334,7 +334,7 @@ trusted.name3=0xdeface
>>
>>   *** set an empty value for second attribute
>>   # file: SCRATCH_MNT/lnk
>> -trusted.name2
>> +trusted.name2=""
>>
>>   *** overwrite empty value
>>   # file: SCRATCH_MNT/lnk
>> @@ -352,7 +352,7 @@ trusted.name3=0xdeface
>>
>>   *** set/get one initially empty attribute
>>   # file: SCRATCH_MNT/dev/b
>> -trusted.name
>> +trusted.name=""
>>
>>   *** overwrite empty, set several new attributes
>>   *** fetch several attribute names and values (hex)
>> @@ -381,7 +381,7 @@ trusted.name3=0xdeface
>>
>>   *** set an empty value for second attribute
>>   # file: SCRATCH_MNT/dev/b
>> -trusted.name2
>> +trusted.name2=""
>>
>>   *** overwrite empty value
>>   # file: SCRATCH_MNT/dev/b
>> @@ -399,7 +399,7 @@ trusted.name3=0xdeface
>>
>>   *** set/get one initially empty attribute
>>   # file: SCRATCH_MNT/dev/c
>> -trusted.name
>> +trusted.name=""
>>
>>   *** overwrite empty, set several new attributes
>>   *** fetch several attribute names and values (hex)
>> @@ -428,7 +428,7 @@ trusted.name3=0xdeface
>>
>>   *** set an empty value for second attribute
>>   # file: SCRATCH_MNT/dev/c
>> -trusted.name2
>> +trusted.name2=""
>>
>>   *** overwrite empty value
>>   # file: SCRATCH_MNT/dev/c
>> @@ -446,7 +446,7 @@ trusted.name3=0xdeface
>>
>>   *** set/get one initially empty attribute
>>   # file: SCRATCH_MNT/dev/p
>> -trusted.name
>> +trusted.name=""
>>
>>   *** overwrite empty, set several new attributes
>>   *** fetch several attribute names and values (hex)
>> @@ -475,7 +475,7 @@ trusted.name3=0xdeface
>>
>>   *** set an empty value for second attribute
>>   # file: SCRATCH_MNT/dev/p
>> -trusted.name2
>> +trusted.name2=""
>>
>>   *** overwrite empty value
>>   # file: SCRATCH_MNT/dev/p
>> --
>> 2.18.0
>>
>>
>>
> 
> 
> 
