Return-Path: <SRS0=BfoT=2I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDAEC43603
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Dec 2019 02:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1978421775
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Dec 2019 02:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLRCh5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:37:57 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1334 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726487AbfLRCh5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Dec 2019 21:37:57 -0500
X-IronPort-AV: E=Sophos;i="5.69,327,1571673600"; 
   d="scan'208";a="80441680"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2019 10:37:56 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id E2C0E4CE1C91;
        Wed, 18 Dec 2019 10:29:13 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 18 Dec 2019 10:37:53 +0800
Subject: Re: [PATCH] generic/520: use fsync instead of sync during clean_dir
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <fstests@vger.kernel.org>
References: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191213204241.GC99869@magnolia>
 <8899c91c-1f92-4f49-c994-f04c9a6eb5fd@cn.fujitsu.com>
 <20191217223619.GI12766@magnolia>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <3dffc06e-fceb-e7a5-b739-afd15f6b4093@cn.fujitsu.com>
Date:   Wed, 18 Dec 2019 10:37:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191217223619.GI12766@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: E2C0E4CE1C91.AED66
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2019/12/18 6:36, Darrick J. Wong wrote:
> On Mon, Dec 16, 2019 at 02:24:56PM +0800, Yang Xu wrote:
>>
>>
>> on 2019/12/14 4:42, Darrick J. Wong wrote:
>>> On Fri, Dec 13, 2019 at 01:45:41PM +0800, Yang Xu wrote:
>>>> When I test this case on xfs, it may fail as below:
>>>> --------------------------------------------
>>>>    === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
>>>> +umount: /mnt/xfstests/scratch: target is busy.
>>>> +        (In some cases useful info about processes that use
>>>> +         the device is found by lsof(8) or fuser(1))
>>>> ---------------------------------------------
>>>>
>>>> I think we don't need to sync all fs and fsync SCRATCH_MNT is enough.
>>>>
>>>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>>> ---
>>>>    tests/generic/520 | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/generic/520 b/tests/generic/520
>>>> index 167d7077..a16467ca 100755
>>>> --- a/tests/generic/520
>>>> +++ b/tests/generic/520
>>>> @@ -58,7 +58,7 @@ clean_dir()
>>>>    {
>>>>    	_mount_flakey
>>>>    	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
>>>> -	sync
>>>> +	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT
>>>
>>> But that only has to force the scratch mount directory to disk.
>>>
>>> Assuming the test authors really meant "write all of the scratch fs'
>>> dirty data/metadata to disk", I think you want:
>>>
>>>    $XFS_IO_PROG -c syncfs $SCRATCH_MNT
>>>
>>> here?
>> My xfsprogs version doesn't support syncfs command. Or, we can use fsync to
>> make four files(foo bar A/foo A/bar) write to disk?
> 
> Hmm, 'sync -f $SCRATCH_MNT' then?
Both syncfs and sync -f are all useful when I test on 
4.18.0-147.el8.x86_64. But on old system (3.10.0-1101.el7.x86_64
), sync command doesn't support -f option.  Or, I think we should use a 
generic way to avoid busy error. IMHO, it has two ways(mkfs and fsync), 
but mkfs will add more test time. What do you think about it?
> 
>>> Also, why did umount spit out 'target is busy' here?  clean_dir() erases
>>> the scratch fs between tests, there shouldn't be anything flakey about
>>> that.
>> I try to find the cause of this but fail. I debug it but no useful
>> output(using  _unmount_flakey  || fuser -uvm $SCRATCH_MNT ), failed as
>> below:
>> umount: /mnt/xfstests/scratch: target is busy.
>>          (In some cases useful info about processes that use
>>           the device is found by lsof(8) or fuser(1))
>>                       USER        PID ACCESS COMMAND
>> /mnt/xfstests/scratch:
>>                       root     kernel mount (root)/mnt/xfstests/scratch
>>
>> ps: My test machine only excutes this cases and doesn't do other  things.
> 
> Does a second umount attempt succeed after the fuser fails to find
> anything sitting on the mount?
Yes, second umount succeed.
> 
> --D
> 
>>>
>>> --D
>>>
>>>>    	_unmount_flakey
>>>>    }
>>>> -- 
>>>> 2.18.0
>>>>
>>>>
>>>>
>>>
>>>
>>
>>
> 
> 


