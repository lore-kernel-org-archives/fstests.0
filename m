Return-Path: <SRS0=WAnD=4J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10A3C11D00
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Feb 2020 01:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF56020658
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Feb 2020 01:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgBUBpb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:45:31 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54391 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727809AbgBUBpb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Feb 2020 20:45:31 -0500
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="83663336"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Feb 2020 09:45:24 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 689AE50A9976;
        Fri, 21 Feb 2020 09:35:44 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 21 Feb 2020 09:45:22 +0800
Subject: Re: [PATCH v2 1/2] xfs/029: filter out "extended-header: cycle: 1"
 from output
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <guaneryu@gmail.com>, <fstests@vger.kernel.org>
References: <20200219220935.GD9511@magnolia>
 <1582185528-8173-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200220233004.GG9511@magnolia>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <ecaecca4-ef6e-e0b7-0523-feb49a7df25d@cn.fujitsu.com>
Date:   Fri, 21 Feb 2020 09:45:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20200220233004.GG9511@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 689AE50A9976.ADFA5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2020/02/21 7:30, Darrick J. Wong wrote:
> On Thu, Feb 20, 2020 at 03:58:47PM +0800, Yang Xu wrote:
>> When I test this case(default lsunit 256k), this case will fail,
>> as below:
>> cycle: 1        version: 2              lsn: 1,0        tail_lsn: 1,0
>> length of Log Record: 258048    prev offset: -1         num ops: 1
>>
>> ...
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> extended-header: cycle: 1
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ...
>>
>> It reports this info because xfs_logprint only read 32k header every time, so it
>> needs to read more times. We can filter this useless info.
>>
>> common/log also has _filter_logprint function. only library function is
>> prefixed with "_", remove '_'.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   tests/xfs/029 | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/xfs/029 b/tests/xfs/029
>> index f532a21b..dbe700ab 100755
>> --- a/tests/xfs/029
>> +++ b/tests/xfs/029
>> @@ -19,7 +19,7 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
>>   . ./common/rc
>>   . ./common/filter
>>   
>> -_filter_logprint()
>> +filter_logprint()
>>   {
>>   	perl -ne '
>>   	    s/data device: ([\w|\/.-]+)/data device: DDEV/;
>> @@ -31,6 +31,8 @@ _filter_logprint()
>>               s/(length of Log Record:) \d+/$1 <LEN>/;
>>               s/version: \d/version: <VERN>/;
>>   	    s/h_size: \d+/h_size: <H_SIZE>/;
>> +	    s/^~+[\r|\n]+$//;
>> +	    s/extended-header: cycle: 1[\r|\n]+$//;
> 
> I guess this works, but do you want to delete this line for line with
> "extended-header: cycle: <some number>"?
Yes, because this line happens depend on log size(every 32k print a 
line, exclude the first, so 256k prints 7 line). This case is design to
test mkfs log(internal/external) zeroing. IMO, this line doesn't matter
unless we want to test 32k read header(If so, specify -lsunit=128, but I 
want to keep origal design).

Best Regards
Yang Xu
> 
>>   	    print;
>>   	'
>>   }
>> @@ -45,7 +47,7 @@ echo
>>   _scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
>>   
>>   echo
>> -_scratch_xfs_logprint | _filter_logprint
>> +_scratch_xfs_logprint | filter_logprint
> 
> Thanks for cleaning out the ^ leading underscore.
> 
> --D
> 
>>   
>>   status=0
>>   exit
>> -- 
>> 2.18.0
>>
>>
>>
> 
> 


