Return-Path: <SRS0=Yh8Q=DG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB70C4741F
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Sep 2020 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31F1208FE
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Sep 2020 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="YvizFUxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgI2R0g (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Sep 2020 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2R0f (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Sep 2020 13:26:35 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4579CC0613D0
        for <fstests@vger.kernel.org>; Tue, 29 Sep 2020 10:26:35 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id db4so2667778qvb.4
        for <fstests@vger.kernel.org>; Tue, 29 Sep 2020 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hfJ7wuJbdOVgJvUcCm080DRoJhBBLzeROzot087OZMg=;
        b=YvizFUxohHydHbavz5BoJ8kuAegTHcy9a3A2mjU5ryrFLhYHq8DLoYhezhZ3Z0Efy7
         I2PLXb18IXfwueed4Z6QI9rd/8UQJaBxewE+b+n13GaR3H+MZM/6dCekI6UzQkXHQC+l
         +1Pops/TFjMQsLworAkIX+aSRI/ZIcI7q9WGpQJfMZLfFKmkEN4gVyRURMVyhvmfR5fw
         gOcncy0Q1n4bsKMnOiHB9y8Pso9YxxDwSLPh3Fw5VAZOXFTKvH/6eOfFk6fhqxU1gf5w
         7AqHCUz8B31sokzmAkwYz0R932CsUdCJn7gTNxLengW86jaB/Kl/5QABQykcaRkSYoyi
         ONfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfJ7wuJbdOVgJvUcCm080DRoJhBBLzeROzot087OZMg=;
        b=ZOBE2JDoa6yCaA3ozrUi/FmJFo0bOsCWJ8RogvC3Ygx2KKVS/vomEKeP7eM2yU57i/
         K/Tuv43TaKG/bhDLW7iNHr2fzYbtyxMg5znBsZQ3glM+vUI3BI2nqt2A5vHxXtfXYGUg
         4s6CJT/vQ5MYo8Mny5rkDg94+KliY3FVIbh3CiD13cWdG0zS/NUCRJ1a7n7z2asxbb2A
         BQBO4+AXXJKVQ8XAd6SCHoN4isOylhu69s15ch1AxRHFYQz7G1fGFfemr6Lv9pylXPxv
         bwkP8yYm/3MzeT7WklXaZclXplHSa2upuy9yqtN9wWsEuBdO1Q/jEiWdDmCqQ+lcNfjy
         7wyQ==
X-Gm-Message-State: AOAM531sY3qrwe3ZnPgkoOvSNEIxV6VDaxWiMS7yO1aJtO6e2OolY6Li
        1+1NgYoileUugBoUjNiGEqL3Eg==
X-Google-Smtp-Source: ABdhPJzERlIlMgoQFIYzdB+FLD1Sx49wjO5jliPZ1MAIUF38NNaFXBnLeIrjIouFEqNfj3q2LXcnSA==
X-Received: by 2002:a05:6214:222:: with SMTP id j2mr5663331qvt.32.1601400394358;
        Tue, 29 Sep 2020 10:26:34 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x9sm5813220qts.65.2020.09.29.10.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 10:26:33 -0700 (PDT)
Subject: Re: [PATCH] fstests: delete btrfs/064 it makes no sense
To:     fdmanana@gmail.com
Cc:     Anand Jain <anand.jain@oracle.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
 <CAL3q7H7QLe6EpK_g1S6MVhOPKaEsaYY9MeAHexdsEO=nz_qubQ@mail.gmail.com>
 <eba12792-b4b0-ca2e-3b78-7648ae60571c@toxicpanda.com>
 <CAL3q7H6qkVXMrJXeDnQWzVa95KS2QTEniKEEQbepEugPKMDrHQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9dff9883-6275-d92c-e8d1-d5f0ef771613@toxicpanda.com>
Date:   Tue, 29 Sep 2020 13:26:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6qkVXMrJXeDnQWzVa95KS2QTEniKEEQbepEugPKMDrHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 9/29/20 12:13 PM, Filipe Manana wrote:
> On Tue, Sep 29, 2020 at 5:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 9/29/20 11:55 AM, Filipe Manana wrote:
>>> On Tue, Sep 29, 2020 at 4:50 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>> btrfs/064 aimed to test balance and replace concurrency while the stress
>>>> test is running in the background.
>>>>
>>>> However, as the balance and the replace operation are mutually
>>>> exclusive, so they can never run concurrently.
>>>
>>> And it's good to have a test that verifies that attempting to run them
>>> concurrently doesn't cause any problems, like crashes, memory leaks or
>>> some sort of filesystem corruption.
>>>
>>> For example btrfs/187, which I wrote sometime ago, tests that running
>>> send, balance and deduplication in parallel doesn't result in crashes,
>>> since in the past they were allowed to run concurrently.
>>>
>>> I see no point in removing the test, it's useful.
>>
>> My confusion was around whether this test was actually testing what we
>> think it should be testing.  If this test was meant to make sure that
>> replace works while we've got load on the fs, then clearly it's not
>> doing what we think it's doing.
> 
> Given that neither the test's description nor the changelog mention
> that it expects device replace and balance to be able to run
> concurrently,
> that errors are explicitly ignored and redirected to $seqres.full, and
> we don't do any sort of validation after device replace operations, it
> makes it clear to me it's a stress test.
> 

Sure but I spent a while looking at it when it was failing being very 
confused.  In my mind my snapshot-stress.sh is a stress test, because 
its meant to run without errors.  The changelog and description are 
sufficiently vague enough that it appeared that Eryu meant to write a 
test that actually did a replace and balance at the same time.  The test 
clearly isn't doing that, so we need to update the description so it's 
clear that's what's going on.  And then I wanted to make sure that we do 
in fact have a test that stresses replace in these scenarios, because I 
want to make sure we actually test replace as well.

Not ripping it out is fine, but updating the description so I'm not 
confused in a couple years when I trip over this again would be nice. 
Thanks,

Josef
