Return-Path: <SRS0=KSdQ=YK=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E7ECE599
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 03:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E87214E0
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 03:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392243AbfJQDzH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:55:07 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56434 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2407692AbfJQDzH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Oct 2019 23:55:07 -0400
X-IronPort-AV: E=Sophos;i="5.67,306,1566835200"; 
   d="scan'208";a="77083582"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Oct 2019 11:55:05 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 0CA684CE1503
        for <fstests@vger.kernel.org>; Thu, 17 Oct 2019 11:54:42 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Thu, 17 Oct 2019 11:55:00 +0800
Subject: Re: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
To:     =?UTF-8?B?TWlzb25vLCBUb21vaGlyby/lkbPmm73ph44g5pm656S8?= 
        <misono.tomohiro@fujitsu.com>
References: <20191016105347.16650-1-misono.tomohiro@jp.fujitsu.com>
 <7501d010-0a3f-f9e6-f705-48cce651c614@cn.fujitsu.com>
 <OSBPR01MB3783782B18D809ACD84EF562E56D0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Message-ID: <d2a0c4a1-61bb-5f4e-7338-1ccff10935d1@cn.fujitsu.com>
Date:   Thu, 17 Oct 2019 11:55:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB3783782B18D809ACD84EF562E56D0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 0CA684CE1503.AED6C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2019/10/17 10:52, Misono, Tomohiro/Î¶•ûÒ° ÖÇÀñ wrote:
>>> This test requires fallocate keep_size. So, skip the test if a target
>>> FS does not support the function to avoid false negative.
>>
>> Can you tell me your kernel version and filesystem. IMO this fallocate keep_size feature has been supported since long times ago(xfs
>> implemented it in 2008 and ext4 in 2007).
> 
> Hi,
> 
> I'm now testing virtiofs and want to avoid noise. I think NFS 4 does not support fallocate keep_size neither.
> 
Hi

I see.  But in generic/499, it also uses fallocate keep size, so I think 
you can also add _require_xfs_io_command "falloc" "-k" in that case(I 
guess generic/499 doesn't run on your system).

ps: In generic/469, it can also add fzero check.

Thanks.
> Thanks.
> 
>>>
>>> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
>>> ---
>>>    tests/generic/469 | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/generic/469 b/tests/generic/469 index
>>> 47fdf0cf..0c6f8ae5 100755
>>> --- a/tests/generic/469
>>> +++ b/tests/generic/469
>>> @@ -40,6 +40,7 @@ rm -f $seqres.full
>>>    _supported_fs generic
>>>    _supported_os Linux
>>>    _require_test
>>> +_require_xfs_io_command "falloc" "-k"
>>>
>>>    run_fsx()
>>>    {
>>>


