Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0466C34047
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 09:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802592464E
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 09:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgBSJth (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:49:37 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44590 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726210AbgBSJth (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Feb 2020 04:49:37 -0500
X-IronPort-AV: E=Sophos;i="5.70,459,1574092800"; 
   d="scan'208";a="83558276"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Feb 2020 17:49:31 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D85C7406AB15;
        Wed, 19 Feb 2020 17:39:53 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 19 Feb 2020 17:49:31 +0800
Subject: Re: [PATCH] xfs/029: filter out "extended-header: cycle: 1" from
 output
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <fstests@vger.kernel.org>
References: <1581922940-14074-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200219003204.GA9511@magnolia>
 <e5c3a5d8-23d2-4760-a9b0-dbe70c53d3bf@cn.fujitsu.com>
 <20200219050729.GC9504@magnolia>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <ec450062-de01-e043-dfb8-c70b14e6a8ee@cn.fujitsu.com>
Date:   Wed, 19 Feb 2020 17:49:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20200219050729.GC9504@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: D85C7406AB15.ABC9F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


on 2020/02/19 13:07, Darrick J. Wong wrote:
> On Wed, Feb 19, 2020 at 09:27:29AM +0800, Yang Xu wrote:
>>
>>
>> on 2020/02/19 8:32, Darrick J. Wong wrote:
>>> On Mon, Feb 17, 2020 at 03:02:20PM +0800, Yang Xu wrote:
>>>> When I test this case under GPT disklabel type, this case will fail,
>>>> as below:
>>>> cycle: 1        version: 2              lsn: 1,0        tail_lsn: 1,0
>>>> length of Log Record: 258048    prev offset: -1         num ops: 1
>>>>
>>>> ...
>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> extended-header: cycle: 1
>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> ...
>>>>
>>>> my mkfs information as below:
>>>> meta-data=/dev/sda7              isize=512    agcount=16, agsize=327680 blks
>>>>            =                       sectsz=512   attr=2, projid32bit=1
>>>>            =                       crc=1        finobt=1, sparse=1, rmapbt=0
>>>>            =                       reflink=1
>>>> data     =                       bsize=4096   blocks=5242880, imaxpct=25
>>>>            =                       sunit=64     swidth=64 blks
>>>> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
>>>> log      =internal log           bsize=4096   blocks=5184, version=2
>>>>            =                       sectsz=512   sunit=64 blks, lazy-count=1
>>>> realtime =none                   extsz=4096   blocks=0, rtextents=0
>>>>
>>>> It reports this info because xfs_logprint only read 32k header every time, so it
>>>> needs to read more times. We can filter this useless info.
>>>>
>>>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>>> ---
>>>>    tests/xfs/029 | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/xfs/029 b/tests/xfs/029
>>>> index f532a21b..99742792 100755
>>>> --- a/tests/xfs/029
>>>> +++ b/tests/xfs/029
>>>> @@ -45,7 +45,7 @@ echo
>>>>    _scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
>>>>    echo
>>>> -_scratch_xfs_logprint | _filter_logprint
>>>> +_scratch_xfs_logprint | _filter_logprint | sed -e "/^~~~/d" -e "/extended-header/d"
>>>
>>> Is there a reason not to add that to _filter_logprint?
>> I haven't mastered perl(never used). Can you add that to filter_logprint?
> 
> That helper function does not call perl.
Hi Darrick
xfs/029 used itself filter_logprint(perl) not used common/log 
filter_logprint(sed) function. Do we should use common/log and change 
xfs/029.out? Also, common/log filter_logprint has considered "~~~" and 
"extended-header: cycle: 1" output.

Best Regards
Yang Xu
> 
> --D
> 
>> Best Regards
>> Yang Xu
>>>
>>> --D
>>>
>>>>    status=0
>>>>    exit
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


