Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2479AC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 12:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiEXMW7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiEXMW6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 08:22:58 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB303939DA
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:22:57 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v11so14906253qkf.1
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynkvPzldsp7uPfK9f4Sd+mCdP5pCRjiPOWdhEsO29Ys=;
        b=ftj0lHuNfb04fAn9DXiUns8ZcfuASin7uKoU91GOH1P9vskK8ylFZWLT+WKhEgCMvW
         OcvmTcoCjHkGdqiWGXQsCebNjmowjLGQG+UZs0UltCD0WJhw6DldR8mTkYGISOmDqHcp
         RPQg3mjLqyGAggoa416sdJZroY42tGYx21JyJ3TyUbBGEMdFumqkFJwRqSx/n40CkLkL
         JvGOkYmtukEm72b5ArwF/d99u9TYCrlfNTibvzITQMmiyW71n/+3AYj2Pu2PC4MzvI9M
         6ZwZmF+AdGQheGnw9b6XOUl3+FjBBRWmr5w/YVJl04r/E/wDI5POAksu4yNuw/ETgI8m
         KaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynkvPzldsp7uPfK9f4Sd+mCdP5pCRjiPOWdhEsO29Ys=;
        b=gSzYgE+/E9qaf7EiNWjjhN6LhGiLOj1tdVOqWb1xafo5LJvzg+vT58ORRyd6zwb+7h
         3MsnAmMvmBXKUza2oR/JgXzPIOOoXIZfa/47RWUI2XiSRH2NmH/j9axSDp8eW9h2eAWq
         BLT62O9NA+7tL7NgIYXrWdQTkcaLqFkn+l6wuSG/xBhNXbCxoQ39ZpL0lGVSF4p61LnT
         7LGBpHqwy07sbwS1lfPTC0xPEXVAld3+tdbqos304dyaIB/A0O9nw6O4X91oQU0fE7iS
         5yiYLWJuS2P9RFE4GehA7qZEvhBdKIkhaaiUJhMUcbLXsI8TdE6hMeKudqVSnJvzTVB+
         thRg==
X-Gm-Message-State: AOAM530/lj/LAqLOzuNV+zMznXlr3sINYOGnS+sNkUNeoOR3VQxaYJwq
        TIvxAn/LQtPknADyg66/JZgdl6AFypgkzYnq2d4m9JEdyDXBjg==
X-Google-Smtp-Source: ABdhPJzJEam0W99NQoVIREyVef4fKcROj08vCQoePxbX8jA2YX6YSJ2pHu5ZmFlP+P9t/76/YxsoFLOu5bFmfebCOWo=
X-Received: by 2002:a37:6310:0:b0:6a5:71bf:17e6 with SMTP id
 x16-20020a376310000000b006a571bf17e6mr2200706qkb.258.1653394976994; Tue, 24
 May 2022 05:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-7-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-7-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 15:22:45 +0300
Message-ID: <CAOQ4uxg9L2kcnWsVO_bmLK7N9M1VgiEbYVgjkym4P7MB0DoX2g@mail.gmail.com>
Subject: Re: [PATCH 6/8] fstests: consolidate no cleanup test setup
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 2:42 PM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Many of the XFS fuzzer tests define a "no cleanup" cleanup function.
> Consolidate this in common/preamble and deduplicate all the tests
> using this setup.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/preamble | 9 +++++++++
>  tests/xfs/083   | 5 -----
>  tests/xfs/085   | 5 -----
>  tests/xfs/086   | 5 -----
>  tests/xfs/087   | 5 -----
>  tests/xfs/088   | 5 -----
>  tests/xfs/089   | 5 -----
>  tests/xfs/091   | 5 -----
>  tests/xfs/093   | 5 -----
>  tests/xfs/097   | 5 -----
>  tests/xfs/098   | 5 -----
>  tests/xfs/099   | 5 -----
>  tests/xfs/100   | 5 -----
>  tests/xfs/101   | 5 -----
>  tests/xfs/102   | 5 -----
>  tests/xfs/105   | 5 -----
>  tests/xfs/112   | 5 -----
>  tests/xfs/113   | 5 -----
>  tests/xfs/117   | 5 -----
>  tests/xfs/120   | 5 -----
>  tests/xfs/123   | 5 -----
>  tests/xfs/124   | 5 -----
>  tests/xfs/125   | 5 -----
>  tests/xfs/126   | 5 -----
>  tests/xfs/130   | 5 -----
>  25 files changed, 9 insertions(+), 120 deletions(-)
>

I propose to use a dedicated helper _unregister_cleanup to opt out
of _cleanup and still leave _cleanup implicit for all the rest of the tests,
but I will not stop merging this cleanup on account of this suggestion.
It could be done by a followup cleanup as well, so unless you want to
take my suggestion

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
