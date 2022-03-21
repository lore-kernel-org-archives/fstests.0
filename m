Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23B9C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Mar 2022 16:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348272AbiCUQVL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbiCUQVL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2022 12:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7D86A76FF
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647879584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=duXdjnBYf9YEk9BuxAA2Hs4ESRQYXPg8LXJqkSPUTic=;
        b=c7Iv3UQTHqVEFOVcdpQdCP+ilBhtLz6pX/QD6hS7Qpn6rwHVAIkrPdyL4qwmMDRYsqHrRh
        SF6ItmLf4vTEA3ig0jiIbLoacy+bKqC8rf6DXpz500jrIrQHAs4An+IOrYEPywk8E9HNak
        h70I92i1RcveDZcB+edMbXmBA6O/Ew8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-WuKfpvlOP_2Ri0E2JsiwzQ-1; Mon, 21 Mar 2022 12:19:42 -0400
X-MC-Unique: WuKfpvlOP_2Ri0E2JsiwzQ-1
Received: by mail-qk1-f198.google.com with SMTP id w200-20020a3762d1000000b0067d2149318dso10120507qkb.1
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 09:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=duXdjnBYf9YEk9BuxAA2Hs4ESRQYXPg8LXJqkSPUTic=;
        b=40h4Pcu9jIt6ccYiuAK3Otd0IeRamsQHYLAOXUwgTOwPB6m4ds0ifx/yda1lFbM3gO
         Ymb/MTsyjKAiaKBdWfOfRGsVDML9x/J16DslvVoAPTORkGhMVj00zLzG38e1Mw5QAjQv
         Q/Ub28h68vIzDOQPSqJgjZRosjYxBK6qbUP66CJiuGlcKKATHySm2NwU07zzLRT4x3rj
         trqvRWT0PNoL1vN7OIMnWQgwb8yO/Q3YYDm82dkLxtJdR6IvRk2AV3B5FvcS7Yj8sN0D
         mUwZtB/1FO4FaORMsv9FNvf0uZ5yYJl4clwJhoZsOO3BlnPBAllM8DWdhJVe/GvFU9JX
         Jfbg==
X-Gm-Message-State: AOAM533fIyikK//k4ObwtrMYw57bLYkg2+WE+uUJkqE7X00kKU6ISpDe
        enXygVsbsKghiqRPH6rkEmJ6QSKM7983uRV2pwJ5Ne61i/5pdDhI0S3Nus+RTGoMjDWEha5cXxf
        b4/kdoODfrjCStOaHUA==
X-Received: by 2002:ae9:e602:0:b0:67d:3e65:4a65 with SMTP id z2-20020ae9e602000000b0067d3e654a65mr12919829qkf.613.1647879581616;
        Mon, 21 Mar 2022 09:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaeq2ACKJW5sigkXKBeV8Kf6PK+cBxiCDv9o1D/TZl8OByFEv5gH4GZ3kZq3ADXroLAhbmIQ==
X-Received: by 2002:ae9:e602:0:b0:67d:3e65:4a65 with SMTP id z2-20020ae9e602000000b0067d3e654a65mr12919803qkf.613.1647879581172;
        Mon, 21 Mar 2022 09:19:41 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a0b0100b0067d3ac00982sm7765448qkg.57.2022.03.21.09.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:19:40 -0700 (PDT)
Date:   Tue, 22 Mar 2022 00:19:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: maintainership of fstests
Message-ID: <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
Mail-Followup-To: Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
References: <Yjdmj0lVqCbbbjW8@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjdmj0lVqCbbbjW8@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 21, 2022 at 01:38:23AM +0800, Eryu Guan wrote:
> Hi folks,
> 
> It's almost 6 years since I've taken the maintainership of fstests, and
> I tried my best to keep the pace of weekly update, or at least bi-weekly
> update due to something like public holidays.
> 
> But it's been a month since last fstests update due to my personal
> urgent issues, and some patches got no review for more than one month.
> So I think it's time to re-consider the maintainership of fstests.
> 
> I will have less spare time in the foreseeable future, as I have to
> spend more time on my family, so it's hard to keep the weekly update
> pace. And six years is a long time, I think it's time to have a new
> maintainer.

Hi Eryu,

By thinking about it a while, I get up my courage to apply this job, although I
know I'm not the best one can handle this job. Just this project is really
useful for my team. Nearly from I joined Red Hat, my jobs started to around the
xfstests. It's a great testsuit, which can cover most of our testing. I felt
relieved when you toke this maintainer, and admired your courage at that time,
that really helps us a lot. No matter what you decide, thanks again for all your
help, as previous colleague, as friend.

Thanks,
Zorro

> 
> Or we could go to the group-maintain way? As Darrick mentioned before
> (for xfs not fstests, if I recall correctly). Then we need a new primary
> maintainer :)
> 
> What do you think?
> 
> Thanks,
> Eryu
> 
> P.S.
> I'll keep the maintainer role and do the review & update as usual until
> all things settle down.
> 

