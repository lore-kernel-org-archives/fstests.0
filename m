Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08485C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 09:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiEXJEu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiEXJEt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 05:04:49 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350313DF7
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 02:04:48 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id l82so9892789qke.3
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=am7SQQNIBtm8eLuIW3rnzGUMt55SpvjpT/bLJ7/likg=;
        b=esFnejOuyqLQAJTX2fK4zFMARTsOTaANBhFDNEjrTDkMeVAlKmV1TaqSX9+m3Wvp8A
         /3/RwiqFXYBHc90g+Uzri2kBALGMDLX5Pcl5mJRNAlAQsKDI8WNEoHyt5PACXwlfvtbS
         TKZwhg6YBi+dAWrHTa9OlcvzA7IcOi9o4dBoW2nQBwByThwB9oD91DFMgGqmDzGndSl8
         xNgvl5ztv1Gk0SBjIzUXe8HY6EvwCRySHB5RP0oiAcQ+4AlKxSGYgRzYqbD5Pp/gM7/v
         9r+AhPPS1LSUSsRJrpXpjk3sk2Ko5tq018G/469CmaVemYFrDqnKGGKrLqTrRMXz10yq
         aEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=am7SQQNIBtm8eLuIW3rnzGUMt55SpvjpT/bLJ7/likg=;
        b=fQSO88ZAHLrWTg4DGLAvvgP4Qbw+YwNOuWTMNoEyiJR3KZ80AA0D5kPqzusULLtXyY
         +WZRV964FxYW/M2Hy7uyxrLZtCORW+FkxDEYMZZNpzb83YZMt3MtNNv8ez42d4kw09Ui
         5htnUokQJ/Ce14F2AmwU56hxtmL8I/bpnfEfyJwltHk91DzKA7j312BM3GNSEFS0rK8V
         6rWsBXQ1Gs/tmmSY8wHBs+jwDad9vHuWKCTJQ5DY5QyImTV6aGSqcQxbXLQwWBZ3wylu
         4R70wOQkK0TU6pfn9EPcMGxmBmp+zK0McRbMlP619qXGvlGst9aqVunDCyur/4uKSjoV
         kBqg==
X-Gm-Message-State: AOAM5304PwxVAuegiC2hvfAgnGh2ceQlox/bNReHH+hewu9UY5ng4gJ0
        Zq6gpi+7v7SK37qPT9/jceUTCEcNQmrcC7DFnns=
X-Google-Smtp-Source: ABdhPJygDLSW4+icuSUc2TSb/WiC6xOxcmAQi9Y7FASfO8mW/gG2PWuNqkf/FWPtCzm+10P2fDuneLOuDuQ5CZH2d58=
X-Received: by 2002:a37:6310:0:b0:6a5:71bf:17e6 with SMTP id
 x16-20020a376310000000b006a571bf17e6mr1690626qkb.258.1653383088101; Tue, 24
 May 2022 02:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-5-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-5-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 12:04:36 +0300
Message-ID: <CAOQ4uxiKbdMQZsr335RM6Og6XLkSTUdVw7NdsYD3djJbtPGRmQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] fstests: define a common _dump_cleanup function
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 11:32 AM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Almost all xfsdump tests now use the same cleanup function.
> Deduplicate them.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/dump   | 53 ++++++++++++++++++++++++++-------------------------
>  tests/xfs/022 | 12 ++----------
>  tests/xfs/023 | 13 ++-----------
>  tests/xfs/024 | 12 ++----------
>  tests/xfs/025 | 12 ++----------
>  tests/xfs/026 | 12 ++----------
>  tests/xfs/027 | 12 ++----------
>  tests/xfs/028 | 12 ++----------
>  tests/xfs/035 | 10 +---------
>  tests/xfs/036 |  9 +--------
>  tests/xfs/037 | 10 +---------
>  tests/xfs/038 |  9 +--------
>  tests/xfs/039 |  9 +--------
>  tests/xfs/043 |  9 +--------
>  tests/xfs/046 |  9 +--------
>  tests/xfs/047 |  9 +--------
>  tests/xfs/055 |  9 +--------
>  tests/xfs/056 | 11 +----------
>  tests/xfs/059 | 12 ++----------
>  tests/xfs/060 | 12 ++----------
>  tests/xfs/061 | 12 ++----------
>  tests/xfs/063 |  9 ++-------
>  tests/xfs/064 |  9 ++-------
>  tests/xfs/065 |  9 ++-------
>  tests/xfs/066 | 11 +++--------
>  tests/xfs/068 | 12 ++----------
>  tests/xfs/266 | 14 +++-----------
>  tests/xfs/267 | 13 +++----------
>  tests/xfs/268 | 12 +++---------
>  tests/xfs/281 |  9 +--------
>  tests/xfs/282 |  9 +--------
>  tests/xfs/283 |  9 +--------
>  tests/xfs/287 | 11 +++--------
>  tests/xfs/296 | 11 ++---------
>  tests/xfs/301 | 11 ++---------
>  tests/xfs/302 | 11 ++---------
>  tests/xfs/544 | 10 ++--------
>  37 files changed, 91 insertions(+), 347 deletions(-)
>

Nice cleanup!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

See one question below...
[...]

> diff --git a/tests/xfs/026 b/tests/xfs/026
> index 18529003..0daa7c88 100755
> --- a/tests/xfs/026
> +++ b/tests/xfs/026
> @@ -9,17 +9,8 @@
>  . ./common/preamble
>  _begin_fstest dump ioctl auto quick
>
> -status=0       # success is the default!
> -

All those tests that you change from success is the default
to failure is the default, that makes sense, but
1. Should be documented in the commit message?
2. Why were those tests written this way? Do you know?

Thanks,
Amir.
