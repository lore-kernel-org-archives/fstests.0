Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BF4C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 11:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiEXLLa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 07:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiEXLL3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 07:11:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42D327FE2
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 04:11:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x7so11248076qta.6
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2QJncI9JuaKXfibrMgMrghlKqu8rbjP8Aj+bM6MPQY=;
        b=WPxM2R00fNlZ+emhG2ppJ+qOvK8Ha4L68MLLr3tuiDVnfyFd4Dc8gZnjePFv1wBlRQ
         ZM+zHAhYQc5n2wx5WYwGS3RwLXC6Ol9BOnccUrUAIhrnE7ytA1CHFF5ZZuvbkiMIlRut
         lvbz/8zoFJIcViB8WEWISy/E+LxTNjvkNCJIONTNom/cj2udd1ejG6Yc5AQqXsK5xzDB
         1kgyYVS4xZP/067/gx6f3Nv+JNha500bE3piltUCCoAls/SrSKXL/yMW36sCq7DKSLLx
         g9cFpO4sAcMSfeAJ2T64cXbQR6WkGahRsy2l1kQXRGFzAcPzlvQK3jazhxVVJ0jcRCwj
         FAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2QJncI9JuaKXfibrMgMrghlKqu8rbjP8Aj+bM6MPQY=;
        b=a8RM6k9JVXgmjOHSWD+HHjW5nwnAFSF+wr/FgdxINkkH6HZKB4NsVZp/d121Pw7uqh
         E6Mgr914QIQOKtadKKgSGFpGAOZ+F4y1nuVVpEe+xCOQPBF7sdCo8rFUlIGEcAfK8jG0
         +bme+31JM66u6uvsH/Nf+maDHQJxgdIa+Lgo+0wkIBHUWZp26uui9MrIOGYCum1NaNSu
         bPNwPY3ZzmIK94fL0Ww9dA/Oq5znM/s6OOBki+aV68mNzm6/vnkwynHTddJDFbg1Bb99
         23GBIp99DDryDSSzJRnPNyNOMBVutJIICnEZOkgCWzzFmA1c5dGhHTIFgz7/iLDkelSV
         jfPA==
X-Gm-Message-State: AOAM532HeLM8p8FXFmSrldhC/k/ru5fqlRCGPwS8Dw4ppYTWVtU8HaCm
        EKq1j9ObHb++pVT3LPVC+ECUoJqdxXuwcy9e+N0lUgc142+RoQ==
X-Google-Smtp-Source: ABdhPJyfi1BTJB70V7Tl4MecjscQ7uE//YZvCjNdELkJrctEqn0Qanm/7EtkV8MdEGR5G3zGC45650Ea5EgiN5OYWeI=
X-Received: by 2002:ac8:5f0a:0:b0:2f9:3b64:b5ba with SMTP id
 x10-20020ac85f0a000000b002f93b64b5bamr4677896qta.2.1653390684848; Tue, 24 May
 2022 04:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-9-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-9-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 14:11:13 +0300
Message-ID: <CAOQ4uxi2bYzX0TPXbkSt=Pq-+ddum01vuA05EMUMjQQMWVV_hQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] fstests: cleanup _cleanup usage in shared
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 1:17 PM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> To match the cleanup of tests/xfs
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/shared/002 |  7 ++++---
>  tests/shared/298 | 22 +++++++++++-----------
>  2 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/tests/shared/002 b/tests/shared/002
> index d99539c9..0a92dcc2 100755
> --- a/tests/shared/002
> +++ b/tests/shared/002
> @@ -15,12 +15,13 @@
>  . ./common/preamble
>  _begin_fstest auto metadata quick log
>
> -# Override the default cleanup function.
> -_cleanup()
> +_dmflakey_cleanup()
>  {
> +       _unmount_flakey
>         _cleanup_flakey

Wait a minute, why was _unmount_flakey() added here?
I see that most dmflakey cleaners do not call unmount_flakey
and it could be for a good reason.
_cleanup_flakey already doesn umount only after doing:

_cleanup_flakey()
{
        # If dmsetup load fails then we need to make sure to do resume here
        # otherwise the umount will hang

Thanks,
Amir.
