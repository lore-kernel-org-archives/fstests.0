Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D160C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 08:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiEXIsO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiEXIsN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 04:48:13 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B9B73546
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 01:48:12 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id r84so3142205qke.10
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jO9wvLzU/EWgkWy5fW5WlTHY1Q1G7e7wJbYL2fteZ18=;
        b=CNTQ/L+cTDMnen8r/yGnRQ74sMN/F1J1DZ5C7gGvqVFg29AOwE1yOVmQ6ziPKH7Cam
         BOl/0bGsPKZXy6upIFPznraGykIm01PW3BmBCMxXMHyVUnPB7xCSD14PGT7H3koe8409
         wNesLJcdaw3hvvffANqoB7quhizP8unc+sz2Co6CUmzKga4xdJ00iIsRqXiPLCaCp/fx
         XPcL3qJfpAEMRZXvTl4W8eOzyvJvdFpUVEmMN2O6bToi4ZCW3sMRfxMq0yJ0R/nPm60V
         POatl0RNEKDTyEDCsrEP2i/BGroD9Z6ggC8rCBmYNyzH6PMWFAIAicW4o416jr6JYomB
         csIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jO9wvLzU/EWgkWy5fW5WlTHY1Q1G7e7wJbYL2fteZ18=;
        b=iZvLwgzyNwrPSK5aTFlbWuEoFoyrrmjuTj2ODwcr54Q13ypIFTfLlUoU8VSS0X3Orm
         i6QJ4bKenak+Mi4VTsi313Lhi3+A08/YWffCJ6JnF4sERh+ND+g2krutNoz/k9GTl9WV
         ttVmEjpZkO1qRm6nGu3w/QIgZe+dvTaSMmMvjPnl9+8BXhjXrl9ymzgLR1Yu+C95PLkk
         RuVwRH7xqXCzUrxRrooxF1kRDNbEAZKL5uRkLfAafdXKL1N9nxsCikW37e3sCmtCsXxm
         xlxKaDQiv+gh/09dLpZa0/Vr5bqgDsKngwtW0HGcCfkoddIczgBaRScHBgVX8O+cjyo1
         +jMA==
X-Gm-Message-State: AOAM5316PkY6HNcfr2xnx/k6BT6Dm+FslBJlS6C1t52KUTyqomb0lE+9
        X23ybRGBg7YGPvC0xdyBgiN0mGTGvjBwziabwyfdyFfPbEoCbQ==
X-Google-Smtp-Source: ABdhPJxxrCBMGPQ7upl8V41xRlrbCSB9HVo//SBdB5TCAXSOvqHnDZKkJPMegLwSq0WUv2vkbeJtgIuQOJX22EceJtY=
X-Received: by 2002:a37:6cc2:0:b0:6a3:769c:e5ba with SMTP id
 h185-20020a376cc2000000b006a3769ce5bamr6942064qkc.19.1653382091574; Tue, 24
 May 2022 01:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-8-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-8-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 11:48:00 +0300
Message-ID: <CAOQ4uxhe6DKQAkZAZLyLXhmsULxpDi3yj+-vD9KN0wVsH8j_kw@mail.gmail.com>
Subject: Re: [PATCH 7/8] fstests: Set up BUS trap for tests by default
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 11:08 AM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> About 160 individual tests re-register the cleanup trap just to have
> it run on a BUS error signal. Just add the BUS signal to the default
> set of traps initialised by _register_cleanup() and get rid of these
> extra registrations.
>
> This was mostly done with this script:
>
> $ for f in `git grep -l "register_cleanup.*BUS"` ; do
> > sed -i -e '/_register_cleanup "_cleanup" BUS/,+1d'
> > done
>
> With a small number of non-matching conversions done by hand.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/preamble   | 4 ++--
>  tests/ext4/023    | 2 --
>  tests/generic/161 | 2 --
>  tests/generic/162 | 2 --
>  tests/generic/163 | 2 --
>  tests/generic/164 | 2 --
>  tests/generic/165 | 2 --
>  tests/generic/166 | 2 --
>  tests/generic/167 | 2 --
>  tests/generic/168 | 2 --
>  tests/generic/170 | 2 --
>  tests/generic/247 | 2 --
>  tests/generic/333 | 2 --
>  tests/generic/334 | 2 --
>  tests/generic/349 | 2 --
>  tests/generic/350 | 2 --
>  tests/generic/351 | 2 --
>  tests/generic/356 | 2 --
>  tests/generic/357 | 2 --
>  tests/generic/358 | 2 --
>  tests/generic/359 | 2 --
>  tests/generic/372 | 2 --
>  tests/generic/373 | 2 --
>  tests/generic/374 | 2 --
>  tests/generic/414 | 2 --
>  tests/generic/425 | 2 --
>  tests/generic/553 | 2 --
>  tests/generic/554 | 2 --
>  tests/generic/564 | 2 --
>  tests/generic/565 | 2 --
>  tests/generic/670 | 2 --
>  tests/generic/671 | 2 --
>  tests/generic/672 | 2 --
>  tests/xfs/017     | 2 --
>  tests/xfs/138     | 2 --
>  tests/xfs/162     | 2 --
>  tests/xfs/262     | 2 --
>  tests/xfs/280     | 2 --
>  tests/xfs/285     | 2 --
>  tests/xfs/286     | 2 --
>  tests/xfs/349     | 2 --
>  tests/xfs/350     | 2 --
>  tests/xfs/351     | 2 --
>  tests/xfs/352     | 2 --
>  tests/xfs/353     | 2 --
>  tests/xfs/354     | 2 --
>  tests/xfs/355     | 2 --
>  tests/xfs/356     | 2 --
>  tests/xfs/357     | 2 --
>  tests/xfs/358     | 2 --
>  tests/xfs/359     | 2 --
>  tests/xfs/360     | 2 --
>  tests/xfs/361     | 2 --
>  tests/xfs/362     | 2 --
>  tests/xfs/363     | 2 --
>  tests/xfs/364     | 2 --
>  tests/xfs/365     | 2 --
>  tests/xfs/366     | 2 --
>  tests/xfs/367     | 2 --
>  tests/xfs/368     | 2 --
>  tests/xfs/369     | 2 --
>  tests/xfs/370     | 2 --
>  tests/xfs/371     | 2 --
>  tests/xfs/372     | 2 --
>  tests/xfs/373     | 2 --
>  tests/xfs/374     | 2 --
>  tests/xfs/375     | 2 --
>  tests/xfs/376     | 2 --
>  tests/xfs/377     | 2 --
>  tests/xfs/378     | 2 --
>  tests/xfs/379     | 2 --
>  tests/xfs/380     | 2 --
>  tests/xfs/381     | 2 --
>  tests/xfs/382     | 2 --
>  tests/xfs/383     | 2 --
>  tests/xfs/384     | 2 --
>  tests/xfs/385     | 2 --
>  tests/xfs/386     | 2 --
>  tests/xfs/387     | 2 --
>  tests/xfs/388     | 2 --
>  tests/xfs/389     | 2 --
>  tests/xfs/390     | 2 --
>  tests/xfs/391     | 2 --
>  tests/xfs/392     | 2 --
>  tests/xfs/393     | 2 --
>  tests/xfs/394     | 2 --
>  tests/xfs/395     | 2 --
>  tests/xfs/396     | 2 --
>  tests/xfs/397     | 2 --
>  tests/xfs/398     | 2 --
>  tests/xfs/399     | 2 --
>  tests/xfs/400     | 2 --
>  tests/xfs/401     | 2 --
>  tests/xfs/402     | 2 --
>  tests/xfs/403     | 2 --
>  tests/xfs/404     | 2 --
>  tests/xfs/405     | 2 --
>  tests/xfs/406     | 2 --
>  tests/xfs/407     | 2 --
>  tests/xfs/408     | 2 --
>  tests/xfs/409     | 2 --
>  tests/xfs/410     | 2 --
>  tests/xfs/411     | 2 --
>  tests/xfs/412     | 2 --
>  tests/xfs/413     | 2 --
>  tests/xfs/414     | 2 --
>  tests/xfs/415     | 2 --
>  tests/xfs/416     | 2 --
>  tests/xfs/417     | 2 --
>  tests/xfs/418     | 2 --
>  tests/xfs/422     | 2 --
>  tests/xfs/423     | 2 --
>  tests/xfs/425     | 2 --
>  tests/xfs/426     | 2 --
>  tests/xfs/427     | 2 --
>  tests/xfs/428     | 2 --
>  tests/xfs/429     | 2 --
>  tests/xfs/430     | 2 --
>  tests/xfs/444     | 2 --
>  tests/xfs/453     | 2 --
>  tests/xfs/454     | 2 --
>  tests/xfs/455     | 2 --
>  tests/xfs/456     | 2 --
>  tests/xfs/457     | 2 --
>  tests/xfs/458     | 2 --
>  tests/xfs/459     | 2 --
>  tests/xfs/460     | 2 --
>  tests/xfs/461     | 2 --
>  tests/xfs/462     | 2 --
>  tests/xfs/463     | 2 --
>  tests/xfs/464     | 2 --
>  tests/xfs/465     | 2 --
>  tests/xfs/466     | 2 --
>  tests/xfs/467     | 2 --
>  tests/xfs/468     | 2 --
>  tests/xfs/469     | 2 --
>  tests/xfs/470     | 2 --
>  tests/xfs/471     | 2 --
>  tests/xfs/472     | 2 --
>  tests/xfs/473     | 2 --
>  tests/xfs/474     | 2 --
>  tests/xfs/475     | 2 --
>  tests/xfs/476     | 2 --
>  tests/xfs/477     | 2 --
>  tests/xfs/478     | 2 --
>  tests/xfs/479     | 2 --
>  tests/xfs/480     | 2 --
>  tests/xfs/481     | 2 --
>  tests/xfs/482     | 2 --
>  tests/xfs/483     | 2 --
>  tests/xfs/484     | 2 --
>  tests/xfs/485     | 2 --
>  tests/xfs/486     | 2 --
>  tests/xfs/487     | 2 --
>  tests/xfs/488     | 2 --
>  tests/xfs/489     | 2 --
>  tests/xfs/495     | 2 --
>  tests/xfs/496     | 2 --
>  tests/xfs/497     | 2 --
>  tests/xfs/498     | 2 --
>  tests/xfs/499     | 2 --
>  tests/xfs/503     | 2 +-
>  tests/xfs/507     | 2 +-
>  tests/xfs/517     | 2 +-
>  164 files changed, 5 insertions(+), 325 deletions(-)
>

Nice cleanup!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
