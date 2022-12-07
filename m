Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EB8C4708E
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Dec 2022 16:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLGQBw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Dec 2022 11:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLGQBv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Dec 2022 11:01:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E499B5E3E2
        for <fstests@vger.kernel.org>; Wed,  7 Dec 2022 08:01:49 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk9so15107860ejc.3
        for <fstests@vger.kernel.org>; Wed, 07 Dec 2022 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27d5KTshZL+wWjhuPK38mGtbc1S26VGxL/VygarE23w=;
        b=FD5ed0hpui4jxHqzQ8XCJUn6VKTgE2mZvhemTSQc0U7T+j99UgmNR9h1uxTz1J110E
         U1Wl+MJ1cCRPmT4521QRlXM6DDDDRYQV4LQIM3MBAYt21gQqDuYFAuvXQEGXbnOzF4aT
         PXcObn/fvvL3xSkT5r/CiPicSx4pdEcD0EpcJ9ZW7r0yb8nTJh/x/EilwO+5zocfqkDF
         gPT8DInYKoFsNKjv9h2Jz4EN+r4yv+7hcer0R/OabBN5GnlFiK6TjGagZrHIjj2AJb5D
         j5GiuOze7J9Hzc990Rnjp+eaB/+wnkl+W1ZbvOeExpqEkZlVFAYk14CjO6nMrN2xKY+d
         oj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27d5KTshZL+wWjhuPK38mGtbc1S26VGxL/VygarE23w=;
        b=mtMfq6xVxt092kvvR+4jh8pChPG4paqfqGG7lHSV3zw/i1jqe2UbNID2P3cL2JoaKA
         ZQLlrDlEqKEWPyTDoqcsZER9CTS3GAh00ajn6HAVnC8019ZjDr+1cjF3Jo54FcUKwrws
         yAN6TdURv3alAR6NG8AmQcN4Zuc+m6k0xz9JGPNZjI/+13MTlLUe8aejQ1fXRdCQzBTE
         IvkkRz6Du3GAk59NI/SdjFXs4ZBKJGoZA6QCX9RpJXvDnFkPHm3PLwwVt3jopaXPghWd
         a9fpm8qjHFXpLf/9XQVQAIIFHswmFTGEN/GLJ2vSMaDGiXIaEC12KKr+y34S52a2SxYM
         x2bA==
X-Gm-Message-State: ANoB5pkoHUVLMr4svVnuPWhbs2sqZk+lrMl2dnWoEE3rMDVY4bt7mPpV
        /ldUjShhTWrfqjXXcb+UCCtK4dePdHXWDQ==
X-Google-Smtp-Source: AA0mqf43cw5wKmN9zHSkmpmc86YSv0pzZeg18PfskWqB4GOokx1zqnxK2K6ePavxsAXl0YBgRhWy/w==
X-Received: by 2002:a17:906:240f:b0:7c0:f7b0:fbbb with SMTP id z15-20020a170906240f00b007c0f7b0fbbbmr11344453eja.266.1670428908338;
        Wed, 07 Dec 2022 08:01:48 -0800 (PST)
Received: from localhost ([2a02:aa7:4027:ca9f:cff:4010:12cd:69ef])
        by smtp.gmail.com with ESMTPSA id ec22-20020a0564020d5600b0046a0096bfdfsm2372991edb.52.2022.12.07.08.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 08:01:46 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:01:42 +0100
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [RFC 0/1] adapting btrfs/237 to work with the new reclaim
 algorithm
Message-ID: <20221207160142.cfyc4outcun5szjh@quentin>
References: <CGME20220819115338eucas1p11b916296213572e97a03241ebdc399d0@eucas1p1.samsung.com>
 <20220819115337.35681-1-p.raghav@samsung.com>
 <PH0PR04MB7416A0B8F8FA5698EB11A0D49B719@PH0PR04MB7416.namprd04.prod.outlook.com>
 <4abc02a3-3518-f5b9-e8c7-cbb77dca30a9@samsung.com>
 <252ec35c-01bf-e597-7a14-5724b6015b1c@samsung.com>
 <d39c1b29-4489-d998-c503-81449df442a7@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39c1b29-4489-d998-c503-81449df442a7@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 05, 2022 at 04:04:08PM +0000, Johannes Thumshirn wrote:
> On 05.12.22 15:53, Pankaj Raghav wrote:
> > Hi Johannes,
> > 
> >> Btw, what ever happend to this patch?
> > 
> > As I said before, I had trouble reproducing reclaim for 100G drive size,
> > and asked if you could reproduce the same on your end. I did not get any
> > reply to that.
> > 
> > I wanted to discuss with you what I was seeing during ALPSS, but we never
> > got around that!
> 
> Ah right! I'll try to reproduce it on my end as well.
> 
> But even with that one problem it makes the test pass again on my other setups.
> 
> So I think it's still an improvement to the status quo. Can you maybe resend it,
> so it's again on Zorro's list?

That sounds good. I will test it again and resend it next week. Thanks!

-- 
Pankaj Raghav
