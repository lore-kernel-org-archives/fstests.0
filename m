Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B3C433DB
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jan 2021 03:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D542067B
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jan 2021 03:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbhASDAl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Jan 2021 22:00:41 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7640 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728406AbhASDAk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Jan 2021 22:00:40 -0500
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="103602996"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Jan 2021 10:59:52 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B426C4CE6033;
        Tue, 19 Jan 2021 10:59:49 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 19 Jan 2021 10:59:48 +0800
Message-ID: <60064B4B.1060108@cn.fujitsu.com>
Date:   Tue, 19 Jan 2021 11:00:27 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: Re: [PATCH] ext4/046: skip test when ext4 doesn't support bs < ps
 with dioread_nolock
References: <1610596503-17149-1-git-send-email-xuyang2018.jy@cn.fujitsu.com> <20210117150624.GA2347@desktop>
In-Reply-To: <20210117150624.GA2347@desktop>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: B426C4CE6033.AAD2A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Eryu
> On Thu, Jan 14, 2021 at 11:55:03AM +0800, Yang Xu wrote:
>> When testing arm machine, this case fails because ps>  bs and kernel doesn't
>> introduced commit c8cc88163f40 ("ext4: Add support for blocksize<  pagesize in dioread_nolock").
>> Only skip this case when mounting failed.
>
> Perhaps it's the kernel that should be fixed? i.e. backport the
> mentioned patch? Depends on if we treat it as a bug or a feature I
> think..
IMO, it is a feature instead of a bug.
>
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   tests/ext4/046 | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/ext4/046 b/tests/ext4/046
>> index 5524024e..e307cbf1 100755
>> --- a/tests/ext4/046
>> +++ b/tests/ext4/046
>> @@ -37,7 +37,8 @@ _require_xfs_io_command "falloc"
>>   _require_scratch_size $((6 * 1024 * 1024)) #kB
>>
>>   _scratch_mkfs>>  $seqres.full 2>&1
>> -_scratch_mount "-o dioread_nolock">>  $seqres.full 2>&1
>> +_try_scratch_mount "-o dioread_nolock">>$seqres.full 2>&1 || \
>> +	_notrun "mount failed, ext4 doesn't support bs<  ps with dioread_nolock?"
>
> At least we should check if it's really the bs<  ps case before _notrun
> the test, otherwise we may fail to find dioread_nolock mount regression.
Ok. Will send v2.
>
> Thanks,
> Eryu
>
>>
>>   # Get blksz
>>   blksz=$(_get_file_block_size $SCRATCH_MNT)
>> --
>> 2.23.0
>>
>>
>
>
> .
>



