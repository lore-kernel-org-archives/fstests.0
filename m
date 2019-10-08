Return-Path: <SRS0=d8y6=YB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F934C47404
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Oct 2019 02:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F1D20867
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Oct 2019 02:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfJHCkE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Oct 2019 22:40:04 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37557 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729212AbfJHCkE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Oct 2019 22:40:04 -0400
X-IronPort-AV: E=Sophos;i="5.67,269,1566835200"; 
   d="scan'208";a="76615517"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Oct 2019 10:40:01 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id EC8204CE042F;
        Tue,  8 Oct 2019 10:40:01 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Tue, 8 Oct 2019 10:40:00 +0800
Subject: Re: [PATCH] xfs/097: Remove wrong broken assignment operation
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <fstests@vger.kernel.org>
References: <1570432515-13184-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191007151244.GC13097@magnolia>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <56deacb8-1d4a-193c-f41c-469c78d97315@cn.fujitsu.com>
Date:   Tue, 8 Oct 2019 10:39:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191007151244.GC13097@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: EC8204CE042F.ABF50
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2019/10/07 23:12, Darrick J. Wong wrote:
> On Mon, Oct 07, 2019 at 03:15:15PM +0800, Yang Xu wrote:
>> On old kernel, since commit ded188b8609 ("xfs: Fix the situation that mount
>> operation rejects corrupted XFS") running this case got the mismatched output,
>> as below:
> 
> But why did the output mismatch?  Did the fs heal itself?  Did
> allocating 5 more files somehow avoid touching the finobt?  Is the
> assignment logic in the loop broken?

The output mismatch because on old kernel, we can mount the corrupted 
xfs and touch action will be refused. so broken is equal to 0.
The fs doesn't heal ifself.
allocating 5 more file will touch the finobt.

You can see this url
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=ded188b86096e2845e59dedae6050c7f254a96b

eg xfs/087, they all delete "broken=0" before allocationg 5 more file. 
commit ded188b86 compatibled old kernel(permit mount and refuse touch) 
and new kernel(refuse mount) behavior on corrupted xfs.  Or, I 
misunderstand this case?
> 
> --D
> 
>> -----------------------------------
>>   + check fs
>>   + corrupt image
>>   + mount image && modify files
>> -broken: 1
>> +broken: 0
>>   + repair fs
>>   + mount image (2)
>> ------------------------------------
>>
>> It fails because the broken is always equal to 0 when _try_scratch_mount
>> succeed. So remove this wrong assignment operation.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   tests/xfs/097 | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/tests/xfs/097 b/tests/xfs/097
>> index 1cb7d69c..20791738 100755
>> --- a/tests/xfs/097
>> +++ b/tests/xfs/097
>> @@ -81,8 +81,6 @@ done
>>   echo "+ mount image && modify files"
>>   broken=1
>>   if _try_scratch_mount >> $seqres.full 2>&1; then
>> -
>> -	broken=0
>>   	for x in `seq 65 70`; do
>>   		touch "${TESTFILE}.${x}" 2> /dev/null && broken=0
>>   	done
>> -- 
>> 2.18.1
>>
>>
>>
> 
> 


