Return-Path: <SRS0=Yh8Q=DG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204B6C4727C
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Sep 2020 16:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8092074F
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Sep 2020 16:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="rCbE+orG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgI2QC1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgI2QC1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Sep 2020 12:02:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3968C0613D0
        for <fstests@vger.kernel.org>; Tue, 29 Sep 2020 09:02:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x201so4426011qkb.11
        for <fstests@vger.kernel.org>; Tue, 29 Sep 2020 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F/TdKVHKW/F79KeR7mYdyfEjda8I9ngvk0y8XuvXzBQ=;
        b=rCbE+orG21b69eLLfWEqas2rU6FWZZ25C+k2P84Q2UK9IbsdgAu3sE9fNRZ/gcPWaN
         2tMggWdlgXzTuTZEAyOmo2djNLfwkupNXPL+BFqDJOs6eo9f3r4xqZcHl9GTAySVyXP1
         vQJihpRQ0ZxovdXC8BUvnvwhtQMPO5ej8o75uQxvav/rl+5xRjySmuqIwrSqmk5taNTA
         66f780Y5yE9BCa/mYbuE7MmG3K6pxYe7bdKZs+7deQWfne87MB1e1ryXPUSO+3LTO8x5
         LW4TH1EtrDuQMnv1U3gL8XiNpWdQGWmX2qttSPZqdfFC0LX+lSd2FXH/wDyYdK15v8kJ
         D6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F/TdKVHKW/F79KeR7mYdyfEjda8I9ngvk0y8XuvXzBQ=;
        b=cWuN7jW4ZYEqw2SjGd8XIsMGeupH6TJ4b3MYAjXJvZN/VbwM5aaJe8sjZ1+lTAqL73
         g9NfDpim5FMju5eM5os7fNjylMgTHcNNBlKYl41VkIQLoXWL2/fGE1ikKYfo5BO9NTJa
         pLXGWTD9o7YCDLy1666LgbwbTKoQVXv5SIOEfKKVKgz/qQlD3td+lIoQVEUCYRRgEP5G
         JBqP7A5cFXbTVGINXCzdrwdmvE9iZ/mz2CZgeVnR/NtmHYt5++DZL7nklphUJ4ky2ypl
         AcuXy3Qf7bCciSNgLas80Asg3Ht087Pjiyxss9zeueLwQAPwdgG45fTXiH3XH99PVzZD
         lF3g==
X-Gm-Message-State: AOAM530tCLHxm0AbKsHAUAesqZz6q3AjScrCXzzGZYABd5aZb5eX+q2O
        0kuCxkrIigiHaa/R/of4muWEsA==
X-Google-Smtp-Source: ABdhPJyJ5++l1azd+3pYKBFJoX91hhFo/w6AVmtm/u01QcmElylTNN0ZV70YQFja23VLEGpBI1JsPg==
X-Received: by 2002:a05:620a:65a:: with SMTP id a26mr4905970qka.424.1601395346058;
        Tue, 29 Sep 2020 09:02:26 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a25sm5558425qtd.8.2020.09.29.09.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 09:02:25 -0700 (PDT)
Subject: Re: [PATCH] fstests: delete btrfs/064 it makes no sense
To:     fdmanana@gmail.com, Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
 <CAL3q7H7QLe6EpK_g1S6MVhOPKaEsaYY9MeAHexdsEO=nz_qubQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eba12792-b4b0-ca2e-3b78-7648ae60571c@toxicpanda.com>
Date:   Tue, 29 Sep 2020 12:02:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7QLe6EpK_g1S6MVhOPKaEsaYY9MeAHexdsEO=nz_qubQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 9/29/20 11:55 AM, Filipe Manana wrote:
> On Tue, Sep 29, 2020 at 4:50 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> btrfs/064 aimed to test balance and replace concurrency while the stress
>> test is running in the background.
>>
>> However, as the balance and the replace operation are mutually
>> exclusive, so they can never run concurrently.
> 
> And it's good to have a test that verifies that attempting to run them
> concurrently doesn't cause any problems, like crashes, memory leaks or
> some sort of filesystem corruption.
> 
> For example btrfs/187, which I wrote sometime ago, tests that running
> send, balance and deduplication in parallel doesn't result in crashes,
> since in the past they were allowed to run concurrently.
> 
> I see no point in removing the test, it's useful.

My confusion was around whether this test was actually testing what we 
think it should be testing.  If this test was meant to make sure that 
replace works while we've got load on the fs, then clearly it's not 
doing what we think it's doing.

In this case if we're ok with it exercising the exclusion path then I 
think we at least need to update the comment at the beginning of the 
test so it's clear what the purpose of the test is.  And then we need to 
make sure we do actually have a test where device replace is properly 
exercised.  I _think_ it is with btrfs/065 and some others, so just 
updating the comment here would be enough.  Thanks,

Josef
