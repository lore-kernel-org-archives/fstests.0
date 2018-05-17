Received: from mail.cn.fujitsu.com ([183.91.158.132]:9830 "EHLO
 heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1751457AbeEQDZ7 (ORCPT <rfc822;fstests@vger.kernel.org>); Wed, 16
 May 2018 23:25:59 -0400
MIME-Version: 1.0
Message-ID: <5AFCF642.2040507@cn.fujitsu.com>
Date: Wed, 16 May 2018 20:25:54 -0700 (PDT)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Subject: Re: [PATCH] generic/486: Get rid of the redundant error=%d printing
References: <20180516152714.GA4910@magnolia>
 <1526520970-17213-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180517031645.GE29080@desktop.hz.ali.com>
In-Reply-To: <20180517031645.GE29080@desktop.hz.ali.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Eryu Guan <guaneryu@gmail.com>
Cc: darrick.wong@oracle.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2018/05/17 11:16, Eryu Guan wrote:
> On Thu, May 17, 2018 at 09:36:10AM +0800, Xiao Yang wrote:
>> 1) Without the fix, perror() can indicate the actual error(ENODATA).
>> 2) After calling perror() and redirecting the output of perror()
>>     to a file, errno seems to be set to EINVAL unexpectedly.
>>     See the following mail for detailed info:
>>     https://www.spinics.net/lists/fstests/msg09675.html
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   src/attr_replace_test.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
>> index 23adc07..33fa74d 100644
>> --- a/src/attr_replace_test.c
>> +++ b/src/attr_replace_test.c
>> @@ -11,7 +11,6 @@
>>   #include<sys/stat.h>
>>
>>   #define die() do { perror(""); \
>> -fprintf(stderr, "error=%d at line %d\n", errno, __LINE__); \
> We can remove the error number in fprintf, but I think the line number
> info is still useful (at least it helped me when I was reviewing the
> test).
Hi Eryu,

OK, we just remove errno in fprintf() as below:

fprintf(stderr, "error at line %d\n", __LINE__);

Thanks,
Xiao Yang

> Thanks,
> Eryu
>
>>   exit(1); } while (0)
>>
>>   #define fail(...) do { \
>> -- 
>> 1.8.3.1
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



