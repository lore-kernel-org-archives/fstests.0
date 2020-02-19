Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60683C3404D
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 08:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B30208E4
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgBSIsS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:48:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42422 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726163AbgBSIsS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Feb 2020 03:48:18 -0500
X-IronPort-AV: E=Sophos;i="5.70,459,1574092800"; 
   d="scan'208";a="83555591"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Feb 2020 16:48:13 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 75F7D50A996A;
        Wed, 19 Feb 2020 16:38:33 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 19 Feb 2020 16:48:07 +0800
Subject: Re: [PATCH v1 1/2] generic/054,055: add _require_v2log
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <guaneryu@gmail.com>, <fstests@vger.kernel.org>
References: <1582010652-1124-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200219050622.GB9504@magnolia>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <b42c4b51-84b5-15aa-0a9d-a3375e08d66b@cn.fujitsu.com>
Date:   Wed, 19 Feb 2020 16:48:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20200219050622.GB9504@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 75F7D50A996A.AB90E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2020/02/19 13:06, Darrick J. Wong wrote:
> On Tue, Feb 18, 2020 at 03:24:10PM +0800, Yang Xu wrote:
>> This two case fail on my server machine with GPT disklabe type,
>> info as below:
>> mount failed: -o logbsize=32k
>> dmesg info as below:
>> [92633.871954] XFS (sda7): logbuf size must be greater than or equal to log stripe size
>>
>> The min logbuf size is 256k on my server machine. It needs to use _require_v2log to check.
> 
> Works fine here.  What is sda7's storage and raid alignment
> configuration?
/dev/sda is a SAS disk, raid aligment is 256k.  When I mkfs.xfs -f 
/dev/sda7(20G), its lsunit value is 64blks(block size is 4k).

Best Regards
Yang Xu
> 
> --D
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   common/log        | 1 +
>>   tests/generic/054 | 1 +
>>   tests/generic/055 | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/common/log b/common/log
>> index c7921f50..f82919a6 100644
>> --- a/common/log
>> +++ b/common/log
>> @@ -494,6 +494,7 @@ _log_version()
>>   
>>   _require_v2log()
>>   {
>> +    [ "$FSTYP" != xfs ] && return 0
>>       # test out mkfs to see if it supports "-l version=2"
>>       export MKFS_OPTIONS="-l version=2"
>>       if ! _scratch_mkfs_xfs >>$seqres.full 2>&1; then
>> diff --git a/tests/generic/054 b/tests/generic/054
>> index 95d40c3c..b4b74615 100755
>> --- a/tests/generic/054
>> +++ b/tests/generic/054
>> @@ -30,6 +30,7 @@ rm -f $seqres.full $tmp.*
>>   _require_scratch
>>   _require_scratch_shutdown
>>   _require_logstate
>> +_require_v2log
>>   
>>   echo "*** init FS"
>>   _scratch_unmount >/dev/null 2>&1
>> diff --git a/tests/generic/055 b/tests/generic/055
>> index 9715f27b..071c4eaf 100755
>> --- a/tests/generic/055
>> +++ b/tests/generic/055
>> @@ -57,6 +57,7 @@ rm -f $seqres.full $tmp.*
>>   _require_scratch
>>   _require_scratch_shutdown
>>   _require_logstate
>> +_require_v2log
>>   
>>   QUOTA_OPTION=`_get_quota_option`
>>   
>> -- 
>> 2.18.0
>>
>>
>>
> 
> 


