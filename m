Return-Path: <SRS0=LJOt=2K=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD88BC43603
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Dec 2019 02:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1CD2465E
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Dec 2019 02:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfLTCsq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:48:46 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33073 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbfLTCsq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Dec 2019 21:48:46 -0500
X-IronPort-AV: E=Sophos;i="5.69,334,1571673600"; 
   d="scan'208";a="80552143"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Dec 2019 10:48:39 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5DBA84CE1C86;
        Fri, 20 Dec 2019 10:39:53 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 20 Dec 2019 10:48:35 +0800
Subject: Re: [PATCH] generic/520: use fsync instead of sync during clean_dir
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <fstests@vger.kernel.org>
References: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191213204241.GC99869@magnolia>
 <8899c91c-1f92-4f49-c994-f04c9a6eb5fd@cn.fujitsu.com>
 <20191217223619.GI12766@magnolia>
 <3dffc06e-fceb-e7a5-b739-afd15f6b4093@cn.fujitsu.com>
 <20191219170859.GE7497@magnolia>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <750e04e4-86f7-127f-c759-d67157c929f1@cn.fujitsu.com>
Date:   Fri, 20 Dec 2019 10:48:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191219170859.GE7497@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 5DBA84CE1C86.A1FD8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

on 2019/12/20 1:08, Darrick J. Wong wrote:
> On Wed, Dec 18, 2019 at 10:37:51AM +0800, Yang Xu wrote:
>>
>>
>> on 2019/12/18 6:36, Darrick J. Wong wrote:
>>> On Mon, Dec 16, 2019 at 02:24:56PM +0800, Yang Xu wrote:
>>>>
>>>>
>>>> on 2019/12/14 4:42, Darrick J. Wong wrote:
>>>>> On Fri, Dec 13, 2019 at 01:45:41PM +0800, Yang Xu wrote:
>>>>>> When I test this case on xfs, it may fail as below:
>>>>>> --------------------------------------------
>>>>>>     === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
>>>>>> +umount: /mnt/xfstests/scratch: target is busy.
>>>>>> +        (In some cases useful info about processes that use
>>>>>> +         the device is found by lsof(8) or fuser(1))
>>>>>> ---------------------------------------------
>>>>>>
>>>>>> I think we don't need to sync all fs and fsync SCRATCH_MNT is enough.
>>>>>>
>>>>>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>>>>> ---
>>>>>>     tests/generic/520 | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tests/generic/520 b/tests/generic/520
>>>>>> index 167d7077..a16467ca 100755
>>>>>> --- a/tests/generic/520
>>>>>> +++ b/tests/generic/520
>>>>>> @@ -58,7 +58,7 @@ clean_dir()
>>>>>>     {
>>>>>>     	_mount_flakey
>>>>>>     	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
>>>>>> -	sync
>>>>>> +	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT
>>>>>
>>>>> But that only has to force the scratch mount directory to disk.
>>>>>
>>>>> Assuming the test authors really meant "write all of the scratch fs'
>>>>> dirty data/metadata to disk", I think you want:
>>>>>
>>>>>     $XFS_IO_PROG -c syncfs $SCRATCH_MNT
>>>>>
>>>>> here?
>>>> My xfsprogs version doesn't support syncfs command. Or, we can use fsync to
>>>> make four files(foo bar A/foo A/bar) write to disk?
>>>
>>> Hmm, 'sync -f $SCRATCH_MNT' then?
>> Both syncfs and sync -f are all useful when I test on 4.18.0-147.el8.x86_64.
>> But on old system (3.10.0-1101.el7.x86_64
>> ), sync command doesn't support -f option.  Or, I think we should use a
>> generic way to avoid busy error. IMHO, it has two ways(mkfs and fsync), but
>> mkfs will add more test time. What do you think about it?
> 
> Ahh, ok.  I guess fsyncing the four things is fine then....
> 
>>>>> Also, why did umount spit out 'target is busy' here?  clean_dir() erases
>>>>> the scratch fs between tests, there shouldn't be anything flakey about
>>>>> that.
>>>> I try to find the cause of this but fail. I debug it but no useful
>>>> output(using  _unmount_flakey  || fuser -uvm $SCRATCH_MNT ), failed as
>>>> below:
>>>> umount: /mnt/xfstests/scratch: target is busy.
>>>>           (In some cases useful info about processes that use
>>>>            the device is found by lsof(8) or fuser(1))
>>>>                        USER        PID ACCESS COMMAND
>>>> /mnt/xfstests/scratch:
>>>>                        root     kernel mount (root)/mnt/xfstests/scratch
>>>>
>>>> ps: My test machine only excutes this cases and doesn't do other  things.
>>>
>>> Does a second umount attempt succeed after the fuser fails to find
>>> anything sitting on the mount?
>> Yes, second umount succeed.
> 
> Also, which kernel behaves like this?  Does it happen with upstream?
> AFAICT when running this in a loop on 5.5-rc2 it doesn't exhibit this
> failure, but maybe another kernel does?
3.10.0-1101.el7.x86_64 and 4.18.0-147.el8.x86_64 all have the problem.

Yes. I use upstream kernel 5.4+(commit head 76bb8b05960c3d16) on my 
vm(4G memory, 4Gswap, 20G test/scratch dev,2 cpu) and test it in a 100 
loop. It fails 6 times . I think it fails because sync may make other 
things(such as system log or message) write to disk but maybe doesn't 
have enough time to  make our rm options file to disk.

ps: my colleague has a smiliar bug for generic/442 when we remove dm 
device. If you can review it, I will be very grateful.
https://patchwork.kernel.org/patch/11160197/
> 
> --D
> 
>>> --D
>>>
>>>>>
>>>>> --D
>>>>>
>>>>>>     	_unmount_flakey
>>>>>>     }
>>>>>> -- 
>>>>>> 2.18.0
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
> 
> 


