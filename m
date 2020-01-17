Return-Path: <SRS0=Jsw6=3G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03B7C33CAF
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 02:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7E8206D5
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 02:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbgAQC5x (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jan 2020 21:57:53 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7788 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388901AbgAQC5x (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jan 2020 21:57:53 -0500
X-IronPort-AV: E=Sophos;i="5.70,328,1574092800"; 
   d="scan'208";a="82083167"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Jan 2020 10:57:50 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 10ACF4CE20F3;
        Fri, 17 Jan 2020 10:48:41 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 17 Jan 2020 10:57:47 +0800
Subject: Re: [PATCH v2] generic/520: Remove sync in clean_dir
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <fdmanana@gmail.com>, <fstests@vger.kernel.org>
References: <1577096499-23471-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200116153552.GA2149943@magnolia>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <aadfd03b-2ac3-0e18-9621-31614899df54@cn.fujitsu.com>
Date:   Fri, 17 Jan 2020 10:57:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20200116153552.GA2149943@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 10ACF4CE20F3.A1345
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

on 2020/01/16 23:35, Darrick J. Wong wrote:
> On Mon, Dec 23, 2019 at 06:21:39PM +0800, Yang Xu wrote:
>> When I test this case on xfs, it may fail as below:
>> --------------------------------------------
>>   === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
>> +umount: /mnt/xfstests/scratch: target is busy.
>> +        (In some cases useful info about processes that use
>> +         the device is found by lsof(8) or fuser(1))
>> ---------------------------------------------
>>
>> It fails because somethings is still using the fs when we call sync and then
>> try to unmount it. We can simply remove sync as the unmount is supposed to
>> persist the file/directory removals.
> 
> /me continues to wonder why the target is busy in this case, but as the
> sync truly isn't necessary:
I don't konw(I use fuser or lsof to debug, but no useful info).  I guess 
call sync frequently in a case will cause this. sync doesn't ensure 
cached push into disk, also sync doesn't have fixed order(it may push 
other into disk, then push SCRATCH_DEV cached write into disk, between 
them, umount will report target busy, this happens randomly).

Also, my colleague has a smiliar bug for generic/442 when we remove dm 
device. If you can review it, I will be very grateful.
https://patchwork.kernel.org/patch/11160197

Best Regard
Yang Xu
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> --D
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   tests/generic/520 | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tests/generic/520 b/tests/generic/520
>> index 167d7077..d4457370 100755
>> --- a/tests/generic/520
>> +++ b/tests/generic/520
>> @@ -58,7 +58,6 @@ clean_dir()
>>   {
>>   	_mount_flakey
>>   	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
>> -	sync
>>   	_unmount_flakey
>>   }
>>   
>> -- 
>> 2.18.0
>>
>>
>>
> 
> 


