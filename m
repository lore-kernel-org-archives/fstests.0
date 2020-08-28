Return-Path: <SRS0=0PYM=CG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61351C433E2
	for <linux-fstests@archiver.kernel.org>; Fri, 28 Aug 2020 01:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF7320872
	for <linux-fstests@archiver.kernel.org>; Fri, 28 Aug 2020 01:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgH1Bdz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:33:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25461 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727843AbgH1Bdy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Aug 2020 21:33:54 -0400
X-IronPort-AV: E=Sophos;i="5.76,361,1592841600"; 
   d="scan'208";a="98646465"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Aug 2020 09:33:50 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B0CDD48990C4;
        Fri, 28 Aug 2020 09:33:49 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 28 Aug 2020 09:33:50 +0800
Subject: Re: [PATCH] xfs/010,030: filter AG header CRC error warnings
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eryu Guan <guaneryu@gmail.com>,
        fstests <fstests@vger.kernel.org>
References: <20200729025119.GV7600@magnolia>
 <20200729044956.GG2937@dhcp-12-102.nay.redhat.com>
 <20200729145033.GY7600@magnolia>
 <e23c06f4-e4e8-b916-e4f5-946cd3e01936@cn.fujitsu.com>
Message-ID: <2825f60b-8f64-a070-c593-bea5be3b6a6c@cn.fujitsu.com>
Date:   Fri, 28 Aug 2020 09:33:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e23c06f4-e4e8-b916-e4f5-946cd3e01936@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: B0CDD48990C4.A08BF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Darrick,Eryu

ping. Or I miss something?
> Hi Darrick, Eryu
> 
> It seems that fstests missed this patch. I used lastest xfsprogs 
> (include commit a891d871 xfs_repair: complain about ag header crc 
> errors) and xfs/030 still fails because of CRC verification warnings.
> 
> Best Regards
> Yang Xu
>> On Wed, Jul 29, 2020 at 12:49:56PM +0800, Zorro Lang wrote:
>>> On Tue, Jul 28, 2020 at 07:51:19PM -0700, Darrick J. Wong wrote:
>>>> From: Darrick J. Wong <darrick.wong@oracle.com>
>>>>
>>>> Filter out the new AG header CRC verification warnings in xfs_repair
>>>> since these tests were built before that existed.
>>>>
>>>> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
>>>> ---
>>>
>>> Hi Darrick,
>>>
>>> I still hit an error[1] on xfs/030 after merge your patch.
>>
>> D'oh, I forgot to send that one out in this batch.  Will fix that
>> shortly.
>>
>> --D
>>
>>> Thanks,
>>> Zorro
>>>
>>> # diff -u ./tests/xfs/030.out ./results//xfs/030.out.bad
>>> --- /root/git/xfstests-dev/tests/xfs/030.out    2020-03-12 
>>> 11:22:50.063148796 +0800
>>> +++ /root/git/xfstests-dev/results//xfs/030.out.bad     2020-07-29 
>>> 12:33:08.485428533 +0800
>>> @@ -105,6 +105,7 @@
>>>   Phase 2 - using <TYPEOF> log
>>>           - zero log...
>>>           - scan filesystem freespace and inode maps...
>>> +bad agbno AGBNO in agfl, agno 0
>>>           - found root inode chunk
>>>   Phase 3 - for each AG...
>>>           - scan and clear agi unlinked lists...
>>>
>>>>   tests/xfs/010 |    7 ++++++-
>>>>   tests/xfs/030 |    2 ++
>>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/xfs/010 b/tests/xfs/010
>>>> index e220a651..b65dd3ba 100755
>>>> --- a/tests/xfs/010
>>>> +++ b/tests/xfs/010
>>>> @@ -113,7 +113,12 @@ _check_scratch_fs
>>>>   # nuke the finobt root, repair will have to regenerate from the inobt
>>>>   _corrupt_finobt_root $SCRATCH_DEV
>>>> -_scratch_xfs_repair 2>&1 | _filter_repair_lostblocks
>>>> +filter_finobt_repair() {
>>>> +    sed -e '/^agi has bad CRC/d' | \
>>>> +        _filter_repair_lostblocks
>>>> +}
>>>> +
>>>> +_scratch_xfs_repair 2>&1 | filter_finobt_repair
>>>>   status=0
>>>>   exit
>>>> diff --git a/tests/xfs/030 b/tests/xfs/030
>>>> index efdb6a18..ebe4c92a 100755
>>>> --- a/tests/xfs/030
>>>> +++ b/tests/xfs/030
>>>> @@ -42,6 +42,8 @@ _check_ag()
>>>>                   -e '/^bad agbno AGBNO for finobt/d' \
>>>>                   -e '/^bad agbno AGBNO for rmapbt/d' \
>>>>                   -e '/^bad agbno AGBNO for refcntbt/d' \
>>>> +                -e '/^agf has bad CRC/d' \
>>>> +                -e '/^agi has bad CRC/d' \
>>>>                   -e '/^Missing reverse-mapping record.*/d' \
>>>>                   -e '/^unknown block state, ag AGNO, block.*/d'
>>>>       done
>>>>
>>>
>>
>>


