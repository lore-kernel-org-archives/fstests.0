Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9518C0015E
	for <linux-fstests@archiver.kernel.org>; Fri, 28 Jul 2023 03:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjG1DG7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Jul 2023 23:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjG1DGX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Jul 2023 23:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F3735AB
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 20:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690513522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjMfbrYqSOv5okm5Gk5avC4J0TwsTGnQkbDohqzQDR8=;
        b=CxBn5X37FNPruVu6UEgmvPeDVDGkO7PAhTBk3Yte4bUd9hs2FfuP7j66Pe6099qbpzGlVr
        D2SdRqbRRCEODyF/OqqF/7Mm6DfZAxE7WDQUvbdBRQh9CvdGZ/rl+90oowGXaeQpe2uaIg
        uXf3roM6QUd/9i2AkQuoJ0RNonxlusw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-zIOWCp9fM0-1IxmOIMKc-g-1; Thu, 27 Jul 2023 23:05:21 -0400
X-MC-Unique: zIOWCp9fM0-1IxmOIMKc-g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55c79a55650so1468826a12.0
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 20:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690513520; x=1691118320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjMfbrYqSOv5okm5Gk5avC4J0TwsTGnQkbDohqzQDR8=;
        b=Xs1zpxUs7qHO1QrjMl/uGX6RMwZ4xfu0q5vTfD95py9LwaPajeiRxJ0P9FCsxJ99jB
         ZcO6GOWaXjPWBrnQbzNogcZbQzkjljl4BROu2GzYAk4cRx9rq8tOW5ussqpCQs0EC9dP
         6CXkqMmOYNa9gdQv/8hXV1hJ4GwCKFVkVJpAUbMuoHUG+TfRYs3/oZQ84u++KNAEcikY
         xQig/r0DDF/NjLXfoOeYIVc4b/GU31Y7nzBwvaldPOBykcourNbYAVCqx0Kt2qmJxd/v
         70ZQSPiCtdHrDMvzhHPNEmD7le1Q/i/eQivG/aHR5ZIdiclTEUCFoURxTUhsF2wXctfz
         jv3A==
X-Gm-Message-State: ABy/qLZEDjnJqUztLCHLjaVz7lnbbaLUQsN0Lavii1xj0agL+CvsesD8
        E0nK3QO/qRrdG9g5XKlONPhFP1Sja45I+g7dy+IjpKh70LEFg1NDi+d1+e0fmqpZreIg97lqvMR
        p9S766u5WVT6MGbbsSg==
X-Received: by 2002:a05:6a20:9696:b0:138:834:5dc7 with SMTP id hp22-20020a056a20969600b0013808345dc7mr508848pzc.30.1690513520059;
        Thu, 27 Jul 2023 20:05:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPRE23AU9zE6Yb73rAue0/mIuJ+KdVoV9qVqdpYUUIHT4GZepefvoQKHozHejokHrzr+npow==
X-Received: by 2002:a05:6a20:9696:b0:138:834:5dc7 with SMTP id hp22-20020a056a20969600b0013808345dc7mr508836pzc.30.1690513519707;
        Thu, 27 Jul 2023 20:05:19 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 12-20020a630d4c000000b0051b8172fa68sm2263287pgn.38.2023.07.27.20.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 20:05:19 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:05:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fstests: install soak_duration.awk
Message-ID: <20230728030515.6r26rwyy32xty33r@zlang-mailbox>
References: <20230727190512.357064-1-tytso@mit.edu>
 <20230727203943.GA358316@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727203943.GA358316@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 27, 2023 at 04:39:43PM -0400, Theodore Ts'o wrote:
> On Thu, Jul 27, 2023 at 03:05:12PM -0400, Theodore Ts'o wrote:
> > Commit 3e85dd4fe423 ("misc: add duration for long soak tests") added a
> > helper executable, soak_duration.awk, is which used by the check
> > script if SOAK_DURATION is set.  This script translates a
> > "human-firendly" time duration specifier, such as 4m or 2d into an
> 
> s/firendly/friendly/
> 
> > integer number of seconds.  We need to make sure that this script is
> > installed or the checks script will bomb out of SOAK_DURATION is set
> 
> s/checks/check/
> 
> > (and the fstests installation doesn't include a full set of fstests
> > source, but just those files installed by "make install").
> 
> s/and/and if/
> 
> Apologies for the typos in the commit description.

Thanks for this fix, I'll fix that when I merge it.

Thanks,
Zorro

> 
> 					- Ted
> 

