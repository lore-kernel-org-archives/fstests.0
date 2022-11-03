Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA55C4167D
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Nov 2022 10:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiKCKYU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Nov 2022 06:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKCKYS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Nov 2022 06:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BFEBE2D
        for <fstests@vger.kernel.org>; Thu,  3 Nov 2022 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667471006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0u5osz0JLZLDRh6vuKbEJiJxCR/2GRO/F/v8N9BP4F0=;
        b=Mfdf86FuLVjdlmAIFpISk05R29dLDN3Hk8yrw35311pADEjC1RlKWTA50SdfjfLPzfkU79
        /7GBTCebeiP2uPuHnadq0Zcz0qb5Xai1PnWnSSNz6r6jOAQw1WaNqWRrKCAGZH4j0G6L2Z
        qnFng6HIR8+Vd4PD7LrbMknF5KoPsYs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-BjXY0xf1NpydyegH9X8uoA-1; Thu, 03 Nov 2022 06:23:25 -0400
X-MC-Unique: BjXY0xf1NpydyegH9X8uoA-1
Received: by mail-ed1-f72.google.com with SMTP id w17-20020a056402269100b00461e28a75ccso1056355edd.8
        for <fstests@vger.kernel.org>; Thu, 03 Nov 2022 03:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u5osz0JLZLDRh6vuKbEJiJxCR/2GRO/F/v8N9BP4F0=;
        b=wnRHIaz8ok6VwNdlDjQMDqSS/gT82NkIxM3eZGXmNj3SBcbdSGPboKx+nqBUimXJnR
         BRM64LvYdCHjlyMbtGDNBzFlLi0po9wCWu420Iz50kuDwpoMudN0gWIynxqZJClOEiRi
         1sW4KDJhjZfgKXHXFmH1XUFMk8ZpaVR55rIJm7j6zLIm97XcJzSe8PNDQ1YPMx6E1NyY
         ziaYiraohKzgbbDz0BWx585uRM/I8GhdQYai7B2dThkrC2ON9ITp73dT3NzMINT+0z4g
         HIO6JVxwOmQsiHu82cAV3hkd1AbaeKQnv4CosaFHwBkICve5X7yxzi2ewJL/1Yf7dG1N
         rBmQ==
X-Gm-Message-State: ACrzQf3tEoFJcwRpBj6Kr71qanheDT2UXlIeRMBgV7Ozx8TOT6wOt0+D
        hQVYfCFncLMkanUJ6iiDGVBIL2NsHHpg/0z94xE+KKHsmKxVoTguY1BQWjV2VOCr8mkL+IbgnQK
        I7wE2T5HoNKHHoCQx
X-Received: by 2002:a17:906:2543:b0:7ad:d164:bc73 with SMTP id j3-20020a170906254300b007add164bc73mr20403149ejb.210.1667471004149;
        Thu, 03 Nov 2022 03:23:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7/aeiDOMBry7uIdQKYK0TQkqktL0ayN0/mNo/DG9MQqgeth5UL6KaZIgNgukziXGz5MxNbkg==
X-Received: by 2002:a17:906:2543:b0:7ad:d164:bc73 with SMTP id j3-20020a170906254300b007add164bc73mr20403131ejb.210.1667471003979;
        Thu, 03 Nov 2022 03:23:23 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ks24-20020a170906f85800b0078d424e8c09sm323697ejb.77.2022.11.03.03.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:23:23 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:23:21 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/577: add missing fsverity metadata cleaning
Message-ID: <20221103102321.73kklwrpjmslyl5s@aalbersh.remote.csb>
References: <20221102165134.169135-1-aalbersh@redhat.com>
 <Y2LyIiDDR9/RS773@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2LyIiDDR9/RS773@sol.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 02, 2022 at 03:41:38PM -0700, Eric Biggers wrote:
> Thank you for reporting this.  How did you notice this?  This test actually is
> currently passing, because there is another test bug that makes
> _fsv_have_hash_algorithm always return false here.  That really needs to be
> fixed first, as otherwise your fix doesn't really do anything.

Hmm, it fails for me. _fsv_have_hash_algorithm also seems to work
(returns 0), what bug do you mean? Don't see anything obvious.

I was running -g verity on ext4/xfs (I'm working on adding fsverity
support to xfs).

-- 
- Andrey

