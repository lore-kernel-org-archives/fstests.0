Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CE1C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Dec 2021 15:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhLLPRO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Dec 2021 10:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhLLPRN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Dec 2021 10:17:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE5DC061714
        for <fstests@vger.kernel.org>; Sun, 12 Dec 2021 07:17:12 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k9so5261318wrd.2
        for <fstests@vger.kernel.org>; Sun, 12 Dec 2021 07:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6JJvS3dGapXgQYKI2p5+K4lW6cw82Tbo7N2ZahaEfI8=;
        b=dgRHZ0Wd+xz4TH1npn88kFNuRTQxDEgTRIt4BnD+RLuuDBKgNF4mMK883+ONvx5ISz
         kC8B6RpTJ4SHJoRwhC4ftAFrn6KK4ez7fQCqyJthuCHXVDEWhh+urjnbctpPwDTHhioP
         Uo5OUgKwsXjQQV1nrBwi2kaQPQJAaCc8DGhn9PQT4spLnLmE8evMUKPdxJ9TaT+kJh9N
         hXxgehmJRgkCN6jdtN14aA1jxLSU1v/aFL1LrASdzYXLqicDDpe6tyucl8JZick/ErTA
         xKDe+1hjRK1sLPDE8sQwzYZwP6Yl0mj/aNcBcka3lW1GITAHU1RUx6Vx3zI+ZiUDavvP
         mysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6JJvS3dGapXgQYKI2p5+K4lW6cw82Tbo7N2ZahaEfI8=;
        b=D04aTWVqQTzq2eB/flVTEd/RHLWTmM7h09gKc17JHrP56pbVBkmNy+/KH+8HPawQ8x
         yvLhYOrZvTE3sguOzcY7w4bw/HNs5AIgte7nUqBQYHnOBWg2o/d0U1wA9g4IaZ2dvFGT
         cOSyzgfI98DT2o2m6ItLUC9x7TU+ZCExFaPyB6zPu5BnwdDbinpBq8e/HePR+oXTuNS9
         nkqAe0URGxk5iFs4VaPRvwW3JgCo7+SbvuEN/EsUUPCoCi2p58p2BjmNc328c5SDtsu3
         TeQKmpq2flmKBM8FedqG1tapD+A2PA8sN4hfTjEgS3ea3dywUjtz1JfQKyqC7WkdRE1b
         eJCg==
X-Gm-Message-State: AOAM531x9n+5rcSDOfPUbefMOzXE+Tu03gGeNv9jSt6jXkIZ/8VuqWi0
        Sg7QZ3rBxEVccHhmZ86xutjceVs1EeU=
X-Google-Smtp-Source: ABdhPJzshjYXUqsLYJ06ml1QfFn5hpmTV5DCzpiDiH6C6q7g7IL60X8hmXh9Y2wmbrraPOaUFab4ig==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr26264806wri.8.1639322231247;
        Sun, 12 Dec 2021 07:17:11 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id h27sm4686108wmc.43.2021.12.12.07.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 07:17:10 -0800 (PST)
Date:   Sun, 12 Dec 2021 23:17:06 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] Add support for using liburing xattr
Message-ID: <YbYScqspQfzeqPEn@desktop>
References: <20211201055202.3142034-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201055202.3142034-1-shr@fb.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 30, 2021 at 09:52:00PM -0800, Stefan Roesch wrote:
> This adds support for using the xattr implementation in liburing.
> 
> Patch 1: fstress: add suport for using liburing setxattr
>   Uses the liburing setxattr implementation in fsstress.
> 
> Patch 2: fstress: add suport for using liburing getxattr
>   Uses the liburing getxattr implementation in fsstress.
> 
> There are two additional patch series related to this:
> - io_uring: add xattr support
> - liburing: add xattr support

Patches look fine to me overall, just one minor issue in patch 2.

But I'd like to firstly make sure the above patches for kernel and
liburing will be accepted, so we don't merge tests for features that are
never upstreamed. They don't have to be actually upstreamed, as long as
the maintainers don't reject the new features.

And fsstress.c has been updated, would you please rebase & resend by
then?

Thanks,
Eryu

> 
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> base-commit: 2050356437e3576673ec5ead79ad72eb619f0d72
> ---
> V2: - Introduce dedicated functions for uring getxattr and
>       uring setxattr, so they are not automatically linked
>       in if liburing is available.
> 
> 
> Stefan Roesch (2):
>   fstress: add suport for using liburing setxattr
>   fstress: add suport for using liburing getxattr
> 
>  ltp/fsstress.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 116 insertions(+), 6 deletions(-)
> 
> -- 
> 2.30.2
