Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78676C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 11:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiC3LMK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiC3LMJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 07:12:09 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941A46A420
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 04:10:23 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b189so16274907qkf.11
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 04:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaAdu7g2smZB44B/uGIuCqNPuaIoEiGQ+23y9etq6ck=;
        b=oeviuU8ZyR0TyUeJmRWpwh1iRxpp8KwtlG5vK03Kmj66QmIGXXYyvDlNMUF0SiDoOV
         sA0d81nEONEREako8AcIJE06I9+KZ0hpC54f1x4OJXMqvIgbsk6iCt0NXfy9/mwjMrXu
         94qoDNmlCwMFbpVG4oLwOmDbkHc3qr+p6YE6KtcyYdcU6Hlp+wVFGYwop77j7jpx/Xue
         A6wjvGALEnaSWwZ0d81R4QYJv/sEzW1bEf0WWWSsZfFfxbGnyEHRCL5AYDEg4pfGgz4R
         m5s2sicLmTJSqVk92zUHHCT0IUsTt3V6r3+b3PpCVAdTx0Vsb2v5IlNy9N8osj6/ssHu
         +RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaAdu7g2smZB44B/uGIuCqNPuaIoEiGQ+23y9etq6ck=;
        b=ZJr4A0zWAQ35vvzRNg9JGNjJbzRlUPZecjA8G2RHRko0t7mYmITpzOKU1fOBegZ4/3
         X7da1dDCXK2a3TsBOhGqy0x6Nv0AHO7/NxKi/kBVfpGopvakgXgYs+2i3J19APgJLY+f
         ydPrrY9IavKRbuoc+wZS/xzJBco7346uS/Th21FMQNyIjoCvIuwOJ8BN542dai3lpz37
         qrXbd3KhqQTf74WF1Qo28CfWTjKKILrFF9RORZJk4zHiasjCPlNuf5g6vU33hwlN2Qc9
         qC9MQZFJHUhWvMQ3aI0EpoUXtCCQgpo0+JnA5KB/P8pVnrO889irHcZjOVdBVpLwXgfI
         c42w==
X-Gm-Message-State: AOAM531UvpaOfG897p1exZkihJH6JI2SKQDvaIuE1VLiCu/W9Yk2syZd
        8/r47zwZmV/aLbb0s1wR1SRKEvJzFHa8agdrob0=
X-Google-Smtp-Source: ABdhPJy4cGcad8qU6V0a1+pzpdiZbuWuPIEulKPQ50bM2aCSrCcUha+LJiGxoZjLCKM76HpSCrBJjh9EpOWKwMQzUOw=
X-Received: by 2002:a37:c15:0:b0:67e:37f2:e691 with SMTP id
 21-20020a370c15000000b0067e37f2e691mr23517088qkm.722.1648638622450; Wed, 30
 Mar 2022 04:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220330102409.1290850-1-brauner@kernel.org> <20220330102409.1290850-21-brauner@kernel.org>
In-Reply-To: <20220330102409.1290850-21-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Mar 2022 14:10:11 +0300
Message-ID: <CAOQ4uxid3vxXpxL25XNp7OWy9OjumHtSm7Zw3TEXO5_UHFRjnA@mail.gmail.com>
Subject: Re: [PATCH v2] common: allow to run all tests on idmapped mounts
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 30, 2022 at 1:26 PM Christian Brauner <brauner@kernel.org> wrote:
>
> In addition to the generic and filesystem-specific idmapped mount
> testsuites that already exist upstream today add simple infrastructure
> so any test can be run on idmapped mounts simply by setting
> IDMAPPED_MOUNTS=true in the config file or section. The main user for
> now will be overlay to verify it works correctly on idmapped mounts.
>

It is not clear from this message how IDMAPPED_MOUNTS=true affects
non -overlay runs and the answer is complicated:

You handled the majority of cases using _test_mount and _scratch_mount
but there are still many tests that open code _mount and some helpers
like _dmthin_mount that are used quite often.

So either document that IDMAPPED_MOUNTS=true will idmapp the
fs mounts whenever it can as best effort, or restrict the use of
IDMAPPED_MOUNTS=true with OVERLAY=true for now.

> Cc: Eryu Guan <guaneryu@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: <fstests@vger.kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  common/config  |  1 +
>  common/overlay |  2 ++
>  common/rc      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>
> diff --git a/common/config b/common/config
> index 479e50d1..1033b890 100644
> --- a/common/config
> +++ b/common/config
> @@ -647,6 +647,7 @@ _overlay_config_override()
>         # Set fsck options, use default if user not set directly.
>         export FSCK_OPTIONS="$OVERLAY_FSCK_OPTIONS"
>         [ -z "$FSCK_OPTIONS" ] && _fsck_opts
> +       export IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"

This is odd.

The purpose of _overlay_config_override() and _overlay_config_restore()
is to allow different configurations for the base layers and for the overlay.
This will be relevant when you implement idmapping for the overlay itself -
you would want to test all combinations of idmapped layers/overlay.

So this should be:
       export OVERLAY_IDMAPPED_LAYERS="$IDMAPPED_MOUNTS"
       export IDMAPPED_MOUNTS="$OVERLAY_IDMAPPED_MOUNTS"

And I think it would be simpler and better understood to open code the check
if the var in callers like this:

[ $OVERLAY_IDMAPPED_LAYERS ] || _idmapped_mount $dev $mnt

and not inside _idmapped_mount()
It will may it easier for you to implement _overlay_mount() in the future.

To clarify, your test setup to test idmapped overlay layers would not
change, you would still set IDMAPPED_MOUNTS=true in config file
as described in commit message because as README.overlay tries to
explain, with ./check -overlay
MOUNT_OPTIONS= refers to the layers and
OVERLAY_MOUNT_OPTIONS= refers to the overlay

I guess adding the IDMAPPED_MOUNTS=true to README.overlay
multi section config example wouldn't hurt.

Thanks,
Amir.
