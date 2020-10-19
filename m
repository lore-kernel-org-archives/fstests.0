Return-Path: <SRS0=fS5H=D2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B606C433E7
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 02:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD73222C4
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 02:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgJSCFl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Oct 2020 22:05:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39700 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729096AbgJSCFl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Oct 2020 22:05:41 -0400
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; 
   d="scan'208";a="100275468"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Oct 2020 10:05:39 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 246C448990E8;
        Mon, 19 Oct 2020 10:05:38 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 19 Oct 2020 10:05:39 +0800
Message-ID: <5F8CF478.6080600@cn.fujitsu.com>
Date:   Mon, 19 Oct 2020 10:05:44 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Eryu Guan <guan@eryu.me>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <guaneryu@gmail.com>, <fstests@vger.kernel.org>
Subject: Re: [PATCH 2/2] generic/402: use _try_scratch_mount instead of _scratch_mount
References: <1602840684-25524-1-git-send-email-xuyang2018.jy@cn.fujitsu.com> <1602840684-25524-2-git-send-email-xuyang2018.jy@cn.fujitsu.com> <20201016153321.GB9830@magnolia> <20201018101058.GY3853@desktop>
In-Reply-To: <20201018101058.GY3853@desktop>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 246C448990E8.AA266
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

on 2020/10/18 18:10, Eryu Guan wrote:
> On Fri, Oct 16, 2020 at 08:33:21AM -0700, Darrick J. Wong wrote:
>> On Fri, Oct 16, 2020 at 05:31:24PM +0800, Yang Xu wrote:
>>> Here will check the return code of mount option. So update it
>>> to use _try_scratch_mount
>>>
>>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>>> ---
>>>   tests/generic/402 | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/generic/402 b/tests/generic/402
>>> index 7fc81864..4c940ac4 100755
>>> --- a/tests/generic/402
>>> +++ b/tests/generic/402
>>> @@ -102,7 +102,7 @@ run_test()
>>>   }
>>>
>>>   _scratch_mkfs&>>  $seqres.full 2>&1 || _fail "mkfs failed"
>>> -_scratch_mount || _fail "scratch mount failed"
>>> +_try_scratch_mount || _fail "scratch mount failed"
>>
>> Why not just drop the "|| _fail" part?  The message isn't much
>> more specific than the fail message that _scratch_mount emits.
>
> Agreed, using _scratch_mount is fine here.
Hi Darrick, Eryu
	Thanks for your review. Using _scratch_mount is better. I will send a 
v2 patch.

Best Regards
Yang Xu
	
>
> Thanks,
> Eryu
>
>
> .
>



