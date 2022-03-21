Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16069C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Mar 2022 05:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbiCUFwm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Mar 2022 01:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiCUFwl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2022 01:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B994845AD1
        for <fstests@vger.kernel.org>; Sun, 20 Mar 2022 22:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647841874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4s2w4EArsnCeDg6vqDdZWu9SHcEFDi8ITN3wVSqRV1s=;
        b=a0CBGPIRnnt13Ii/oo8k9OwGa5f4CifWbrWPYUtu/i9fqEWwypVGzW8AQPonsVaSG7TqMz
        9SnguoRC110qbz9LiFq4KEncHqDf8JG2yMoTN5RlHTFJHx7PKWXWqKHbfTP3eBHUEi1B59
        4ducGcuROD4Eov6lG6blBd8hlHZoO8g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-293ewbktNMKOc-em6_uf0w-1; Mon, 21 Mar 2022 01:51:12 -0400
X-MC-Unique: 293ewbktNMKOc-em6_uf0w-1
Received: by mail-wm1-f69.google.com with SMTP id m35-20020a05600c3b2300b0038c90ef2dceso4069664wms.4
        for <fstests@vger.kernel.org>; Sun, 20 Mar 2022 22:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4s2w4EArsnCeDg6vqDdZWu9SHcEFDi8ITN3wVSqRV1s=;
        b=56o5z39p0ZuWJo/qQdGgtsQ/M89q+aloSJBNpqI/R0gsxYv2715odHd+kfxhNAZ6tr
         YJsqQ+UyXBqAXnLbd5+6XPwrM0fcRRmcv2gSi0gaixY/zdGd4kyrJRB0LGi2La2+kdni
         L808P4uVNJQ6DNYMWgE8Wz4ezYzKJwG4xk/Gc0uNIXBYQHkMpv/jYPDjwCwH2Xf3rXIE
         f03L46aVrrRSY7cSIkv1FxwpUjFA1jxOKInperSGgiByWIeTCQOMxoZWUt5x8U4URvlu
         1NMvHza//792hgiv2iHBQEO0iKWJI9+3OQyyENXjrHjtm61c7taKcRtOT6KHOm7DiEUW
         iDTQ==
X-Gm-Message-State: AOAM5302IiRR9e9GGxivKqZzjGiA2ui/79UIenatI8+HgFzUzKxwZ+UJ
        wUn4kzf/rJIrxJMcGAKF1nf4ou0mVnj/yV9XTywOACDSHKK+lNA2iN7yUzjzs52RjHppetRPJJK
        2wmM4pvfTfeUp4suqqw==
X-Received: by 2002:a05:600c:3846:b0:38c:7e65:c9e1 with SMTP id s6-20020a05600c384600b0038c7e65c9e1mr15602082wmr.157.1647841871242;
        Sun, 20 Mar 2022 22:51:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4lGDsf8bACCaukSil8XSwZtfmXA2M5EdsKXLslc4MIlnin8PWQhNbykBod85VRyPtVNxKBA==
X-Received: by 2002:a05:600c:3846:b0:38c:7e65:c9e1 with SMTP id s6-20020a05600c384600b0038c7e65c9e1mr15602070wmr.157.1647841871036;
        Sun, 20 Mar 2022 22:51:11 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b00203f04ed4a8sm8830834wrn.13.2022.03.20.22.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 22:51:10 -0700 (PDT)
Date:   Mon, 21 Mar 2022 13:51:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: maintainership of fstests
Message-ID: <20220321055105.g6654ywbpsnvcoe5@zlang-mailbox>
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

Thanks for your long time contribution! Even after you leave Red Hat, you
still try to keep weekly updating, I don't know how to express my gratitude
for that. Rich blessing to you and your family!

Thanks,
Zorro

> 
> But it's been a month since last fstests update due to my personal
> urgent issues, and some patches got no review for more than one month.
> So I think it's time to re-consider the maintainership of fstests.
> 
> I will have less spare time in the foreseeable future, as I have to
> spend more time on my family, so it's hard to keep the weekly update
> pace. And six years is a long time, I think it's time to have a new
> maintainer.
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

