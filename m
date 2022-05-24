Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C3C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 12:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiEXM0S (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiEXM0J (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 08:26:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431D2C12B
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:26:07 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g21so6090401qtg.5
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvRgrEsD5UnTkkGo8KnReWJ2s56Q1rbxl7OGD132HXs=;
        b=p95WN5NJQ/MsN7ESQi9Bxzo1Z5zSf9Xe2YVXJiLws6W7JinbSIMi5L+7nyhCMvB5Iw
         BmD4Hpastu+GG0JnM798r79tAwWJrkqsgYhgBJoNNdK3cuOcDM2BK1iQYvg8skVF/6Bl
         G2IhlMUXba/iHp/FVg6EzvEB0zvpU6mAIpDk8sg3Bm/Y3hPVLyj+WQZUEZtBp7+A5s37
         e/voFvHJuO9es4408ROe9tCYbxoGLGjihwC/aGP9nZA3WMCSTvMAk6777dJtF5Wngxz6
         fHacFAisrGbOuNghiiLhp6sieAf3wPL0qfJX1g85CUZwSuC64BHvGJcpLnA7O1ZaFw7V
         Zm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvRgrEsD5UnTkkGo8KnReWJ2s56Q1rbxl7OGD132HXs=;
        b=tZGoOa8XSKfMWYVkc+PURZX+Qvan3LMyGwRK70dACmTgmVxvgSHmseJ1VVWR12BdHz
         kjcOQxiHwjYGcO/agRg0f0cpjGfg91GvmdHKLuzFmUiMi+DwwjvKzvPOWnnCXwbIBWb/
         VEggMQgE3B4FS/cmtaiqU6Q4oKo5LisY6tJriK03MP/aqDtNsAMli5+ERjaHEDqJ3Izz
         zoQPT1H3RGAEEq8c6q3sDcbEmj1CMwINMMyK4hRRj6ArQGB93go4QycmSPEnN1REK5TH
         mKVbntldE/bslKjv7S0wVP/T+TFlo6dNcL8nFYyhsjk+eqKQCqSBzBFdszkz+M5NXZo5
         tZOg==
X-Gm-Message-State: AOAM53169BKlQGTAxUejb2hTueq1q8SKsKGEuXAcWv/riqYU47npvDMk
        N835b8DN7LCnwdYqc60nAwI90/NU7ojUN6wC8YDNa3hZRqDa4g==
X-Google-Smtp-Source: ABdhPJzAUfqOKBXJHZyqlIvf3AhQcNpflZKLwwQP9mO5TseQGxhRKW2e/XlOt1/paLFZjVtlGH9T8Sr5v/ujNB0RaA4=
X-Received: by 2002:a05:622a:1a9c:b0:2f3:d873:4acc with SMTP id
 s28-20020a05622a1a9c00b002f3d8734accmr20043022qtc.424.1653395166381; Tue, 24
 May 2022 05:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-6-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-6-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 15:25:55 +0300
Message-ID: <CAOQ4uxh-x_dz7rG_T+NqBEcMbFbWtc-eDT-PJ4OL44xZtn_Ybg@mail.gmail.com>
Subject: Re: [PATCH 5/8] fstests: use a common fsstress cleanup function
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 2:16 PM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Lots of tests now have a common cleanup function for fsstress based
> tests. Define a common cleanup function in common/preamble and
> convert those tests to register it.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Makes sense.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
