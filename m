Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38237C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 01:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AF923B70
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 01:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgLIBNQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:13:16 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:62704 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725881AbgLIBNQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Dec 2020 20:13:16 -0500
X-IronPort-AV: E=Sophos;i="5.78,404,1599494400"; 
   d="scan'208";a="102198812"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Dec 2020 09:12:29 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 53F694CE6008;
        Wed,  9 Dec 2020 09:12:25 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 9 Dec 2020 09:12:24 +0800
Message-ID: <5FD02476.2040909@cn.fujitsu.com>
Date:   Wed, 9 Dec 2020 09:12:22 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <guaneryu@gmail.com>, <fstests@vger.kernel.org>
Subject: Re: [PATCH 2/2] src/dmiperf: Stop using attr_setf
References: <20201208064005.1187031-1-yangx.jy@cn.fujitsu.com> <20201208064005.1187031-2-yangx.jy@cn.fujitsu.com> <20201208182423.GI106271@magnolia>
In-Reply-To: <20201208182423.GI106271@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 53F694CE6008.A90B1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/12/9 2:24, Darrick J. Wong wrote:
> On Tue, Dec 08, 2020 at 02:40:05PM +0800, Xiao Yang wrote:
>> Avoid the following warning by replacing deprecated
>> attr_setf with fsetxattr:
>> ---------------------------------------------------
>> dmiperf.c:192:2: warning: 'attr_setf' is deprecated: Use fsetxattr instead [-Wdeprecated-declarations]
>> ---------------------------------------------------
> I frankly wonder if it's time to kill the DMI tests since I've never
> seen it and none of the functionality is upstream.
Hi Darrick,

Agreed.  I wanted to remove it yesterday but I am not sure if it will be 
used in future.

I will remove it directly in v2 patch if Eryu or anyone also approves it.

Best Regards,
Xiao Yang
> --D
>
>> Also remove unneeded<attr/attributes.h>  and $(LIBATTR).
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   src/Makefile  | 2 +-
>>   src/dmiperf.c | 6 +++---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/Makefile b/src/Makefile
>> index 32940142..c0688520 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -33,7 +33,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>
>>   SUBDIRS = log-writes perf
>>
>> -LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL) -lpthread -lrt
>> +LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt
>>
>>   ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
>>   LINUX_TARGETS += loggen
>> diff --git a/src/dmiperf.c b/src/dmiperf.c
>> index 4026dcfb..f9415953 100644
>> --- a/src/dmiperf.c
>> +++ b/src/dmiperf.c
>> @@ -17,7 +17,7 @@
>>   #include<stdlib.h>
>>   #include<string.h>
>>   #include<unistd.h>
>> -#include<attr/attributes.h>
>> +#include<sys/xattr.h>
>>
>>   typedef unsigned int uint_t;
>>
>> @@ -189,8 +189,8 @@ mkfile(char *name, char *attr)
>>   		perror("open");
>>   		exit(1);
>>   	}
>> -	if (attr_setf(fd, DMFATTRNAME, attr, DMFATTRLEN, ATTR_ROOT)<  0) {
>> -		perror("attr_setf");
>> +	if (fsetxattr(fd, DMFATTRNAME, attr, DMFATTRLEN, 0)<  0) {
>> +		perror("fsetxattr");
>>   		exit(1);
>>   	}
>>   	while (bytes>  0) {
>> -- 
>> 2.23.0
>>
>>
>>
>
> .
>



