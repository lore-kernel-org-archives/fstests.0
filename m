Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C81C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 16:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiEXQRF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 12:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiEXQRE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 12:17:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101F3F329
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 09:17:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id j6so15397855qkp.9
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kb0mcG21dS4ALUuL6Q5CQ2A6S/ikW5vpo86EqX53Neg=;
        b=L59xz+C0GMsWFItEwMqo2+Dj6uqaMc0TCso9sz1zJfve0Yo0Jr0msjhraqZ50GfzqN
         /IjFtFMHs14F12lB82mMl5YbvjycFME3hFEO53i5swEiyGzwQfDX3Z4l1q/tpdK/n+iP
         XjGhrRfHnwPvTDqTUPJjgmPJ0IFvb/ZhMJrMq7kyP2F7Xmtbf7zXnjCWXz3uaR5eLNlA
         6u9rt6ut1FXncq52RfBDqsapX9ODXDSx3I+XlKsyJVWhvryYfs+Tl2FQ3S90dqwLCZeQ
         dIm56R3BGCCjjCqVgA/RK7gWofh5CAgK+eLKPfsrQnKTo26GockSlL8pcVa/F75aLcvk
         pELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kb0mcG21dS4ALUuL6Q5CQ2A6S/ikW5vpo86EqX53Neg=;
        b=OaUG3Nsc5jEV7x+RluLjhXgS2qJ/BFFytWxmYAigqTZTXcC00+cG/6AbizYDM+XJe6
         aAzew5v+QT2PMK7TdoUijtEJNYARMENreUgeRRiNTkw1kyrJugKJx2QU0rmiMOktWDmn
         jZLYosNjv2nFckXuL48CJSEzQsoS6ShpGyPMsEZGEMeh5F1EGeufPEgi3cxpUcCTM2fL
         OSylEfTCFOBTLBeQ6lYm56EmlmZRtTNhTAHwpx2OVBFME5jONfM3L8i6qEdzr3GjHIfw
         BAx2KC3krkvlszZ4dEZnAVOVgxLbI65GiIJEaJXxcmSWKs1THIOIoQT5zfPH2oEelQog
         vVpw==
X-Gm-Message-State: AOAM532EtmRMXF/u2wdKd8K228uTvlYIWYf888WVuhfSewzLxXkpTgT0
        ECsWzfllzUM430NU2l5szMK7tPh/P76izTpQwbEUxqrL3wjbmA==
X-Google-Smtp-Source: ABdhPJyjhIAxHeFclLJU4GeI8ftSYuWTP5+hfi/fTA/Yg8zELwY2KjBEfXaDYa02hvPhFdld1G5h5UqfCzLtZN/F+i0=
X-Received: by 2002:a37:8802:0:b0:6a3:4aa4:7cb4 with SMTP id
 k2-20020a378802000000b006a34aa47cb4mr14051194qkd.722.1653409023025; Tue, 24
 May 2022 09:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-3-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-3-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 19:16:51 +0300
Message-ID: <CAOQ4uxhzTH2FjRSURHOpXNd=xiX7ksH7Br57dBxgc9TRxkURJA@mail.gmail.com>
Subject: Re: [PATCH 2/8] fstests: _cleanup overrides are messy
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 6:39 PM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Most _cleanup() function overrides look like:
>
> _cleanup()
> {
>         # do something test specific
>         cd /
>         rm -rf $tmp.*
> }
>
> But they often get the last two lines either wrong or omit them.
> These are the lines the common/preamble::_cleanup() define.
>
> The problem here is that we are just overriding the generic _cleanup
> function by redeclaring it after calling _begin_fstest. What we
> should be doing is registering a new local cleanup function that
> calls the generic cleanup function when we have finished the local
> cleanup. i.e.:
>
> _local_cleanup()
> {
>         # do something test specific
>
>         _cleanup
> }
>
> Make _register_cleanup() function to cancel the existing
> cleanup trap and register the new trap function so that local
> cleanups can be done cleanly.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
