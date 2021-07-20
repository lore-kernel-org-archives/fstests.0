Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5CAC636C8
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Jul 2021 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFE161241
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Jul 2021 08:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhGTIQU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Jul 2021 04:16:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:55819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234897AbhGTIL0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 20 Jul 2021 04:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626771120;
        bh=1FBydMUdr5SBBEWX7UJ+djUwawBWu+TIpND3K/PjJEA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TmTxmMXRYyZ1hsfN2+j40UlYJkT/vaYWXf/ViN1aXNbK2aVA0pVPN+Gu0WqewBCmo
         XlD/f9cSNbzGxZlGqdLSqgHEcShV3QE+7r/BvKoEGzrIm/H/3uhrcSdqNFIShTsUsS
         R1GBQCaggkbIbHjSJLcDmoJ6GOvhQT/mK10hsm9w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiacR-1lQfW22f03-00fjRo; Tue, 20
 Jul 2021 10:44:34 +0200
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
To:     Eryu Guan <eguan@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com>
Date:   Tue, 20 Jul 2021 16:44:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DjUhkcVjv1gc0E5hcs2IjAxcu+i989Q37AaXVBTCsoiWSY/1Z+v
 yhIIyso7i/LEQVry1Uk/vDOOl5Ha4mcD3a/c+ODVDqDRwJfePpLqik+i0745j8gebrQEq/9
 ZjPgl+41ycFe4sp44FaO2m0lTBRSWjuVEJK7r3BqrWQqqkh8u70ojDxmlOyEKbF+CqjOzzv
 ZwuHu45qBif4NR9PzeznA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bz1r1M0CmOo=:vWd4CEqZCY0gbaJlljD4A4
 mNZxudsh8MrvhizuUf/hc12K3MiuVk2R0jMc4+c34PL3AK4B3XBrlqtmM9JykrwqRWpg5pI44
 RjHBaUQ8aOPRv80AfWg+RFlfoGyshwsPS4tJ1QhrKXAgGK+7/tW970qgpgAxfZqJqJlqhEjXC
 7cihAZe5a40d0W5knptdPnqh8fElFuer9h8Dl+4WiQy+5lnrxa/9bfguofSVLGGw8Wvzermd7
 0+rXJFWC0Tc9UPE2SFn2GBPno47fRQrSPOfZxCU4+xswXUPLdk+o+iky6F9ezE2hwt7vpSeGC
 9/iMhfStkuOnB6hDrSZSSt7jq2+WVKeCtF5o/Qf4eL3R5/pSbKNSwkoNdqBK2PYjQuRQDKrre
 Ugw6i/7RFQ7ORM2w6uU01jaeTF83SuvfL2waZFZXKvh/GU182/D1matU7pHfgbNRnuChJugfH
 1vLjspc/5VKUthmtsdeR36plmSiHdfuKVbsXWHcE56K+OYe0zScprjidJcoUk06S3vYp91JzI
 gKr0rUnIPFm530DyJsqHeE/otSaTlqI10BEZLsqXu1Osk30abZN8s92nbDdcRRAYpnsTMVMZx
 lWpCaA+8WH9koqAF27shA6NoRhIfsVVBRXTfoHzURAaxrMp5TWYhGE0IYMVjnn01+hr3peej5
 Xjd5T6XiBFNl9R+xdyLkNP7ChVaKI/ddqRw4kNpe4LgYH9CFt7pvaALTZtHrnWsb9ZNcPMVRN
 /wgj0EF1M0bglMjE9ceIf1dckQwnj8c7gd55mxnEaxYYhbIcQfpDyT3J6p8xyZ/X8f3SsmgF+
 5MpKRhYN+jbgjw6YkqPgTZFclqztAAI25BAGido/e169VVi8zNc5gGNP6hB8jHlTruPzFqzEe
 sPEIZj9377mG77b9L/pB0PziE6e7TTRMp5XyrpqIVgopgurBuxTMC1JONTUUBjPwwOAiLAYQe
 mZW0Rd0A0t74YpNUln2r4YIBCu5bxv92xPzzO+X/dyqQqYAu8tPyETfcWpaF88+0BrxtHJVSJ
 sFlCmA/nTw8qhZQun9gfIFinoucEZ4lF9+2L3NvYY6jmGaFrjuGFmBUk+PJwCvhIRs12EfcK1
 y+4TDJe/rgvHI7vXwO83Xr8jFElWCLvMnIgUeOj6pW45bLBPfcRSGZUeg==
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2021/7/20 =E4=B8=8B=E5=8D=884:29, Qu Wenruo wrote:
>
>
> On 2021/7/20 =E4=B8=8B=E5=8D=883:57, Eryu Guan wrote:
>> On Tue, Jul 20, 2021 at 04:43:17PM +1000, Dave Chinner wrote:
>> [snip]
>>>
>>> And given that it appears you haven't thought about maintaining a
>>> local repository of hooks, I strongly doubt you've even consider the
>>> impact of future changes to the hook API on existing hook scripts
>>> that devs and test engineers have written over months and years
>>> while debugging test failures.
>>>
>>> Darrick pointed out the difference between running in the check vs
>>> test environment, which is something that is very much an API
>>> consideration - we change the test environment arbitrarily and fix
>>> all the tests that change affects at the same time. But if there are
>>> private scripts that depend on the test environment and variables
>>> being stable, then we can't do things like, say, rename the "seqres"
>>> variable across all tests because that will break every custom hook
>>> script out there that writes to $seqres.full...
>>
>> I was thinking about this as well, if such private hook scripts are
>> useful to others as well, then I think maybe it's worth to maintain suc=
h
>> scripts in fstests repo, and further changes to the hook API won't brea=
k
>> the scripts
>
> But those hook scripts are really craft by each developer, which can
> have vastly different usage.
>
> How could that be maintained inside fstests?

Anyway, if building a stable and complex API just for hooks, then it's
completely against my initial purpose.

I'll just discard this patch then.

Thanks,
Qu

>
> Thanks,
> Qu
>>
>> Thanks,
>> Eryu
>>
