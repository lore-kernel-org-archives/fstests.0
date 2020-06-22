Return-Path: <SRS0=/J1n=AD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE1AC433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Jun 2020 06:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D617B251F3
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Jun 2020 06:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTZdGRsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgFVG5H (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgFVG5H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Jun 2020 02:57:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7965C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 23:57:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id a12so4668497ion.13
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QePiEtlDyLJSpfmuFFNvuITAAC8QSziUR9Cqgt/B5vA=;
        b=GTZdGRsPDGeDSIv3nH7+CkxcFljLHze1Hjjf8/ndfcZWG/MdOxL5mGW0iz1WapzF0t
         lHAQa7b1uD/CMtqHHp3KgD78+sI2J85KqhMVy5Eor2vhDvGpUI2eXnPb10WOCPescqlb
         MPHq1ZHSeCByR9KNQQmbxqZcIWuc4q+VUjxh64IPSAK+B/u4lG2s3/iE8/vr8u4ArlKD
         euW6rmGcLnWiWDVkLtnhlTXidiKVMUHTArKxc5kBnIkN8QURPm6/M0yZ95McjHtlXr9y
         0RXq5+vyNyqcXZ2IEYDzpxoktU8olbPbeq2MLr+abO6UaWod+X4iKjpOgwvS4y3X5qzz
         4JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QePiEtlDyLJSpfmuFFNvuITAAC8QSziUR9Cqgt/B5vA=;
        b=sRZksjsnTQlbsrlBF5FQnAWxzSwXZJtB8iO59dAV1zpAuoMneliyDrnZZchylVQdz8
         Epj7VkIIMPGSlBBp0m3pGkE2p/aQ8nBGUb59mzxnVE7c/9JGdea17sJ4FYiYwKpfZGJM
         IhbCt923gEzOLIRwn6ttD/leRPOFMEzDojXrow+3VLDsH3o8jp5ySPUkyRXcWC4FYJq3
         8KugySwT6TPY9FPgozvcDIYqYp0KE/4sbn6ptoCe8UAJCI+vq7vKimexCFSrHwynIOSo
         jbpZGfYx06NPf7FJnYZjA0uuOXvOerihfqUGHBzwuhvUl1elaXh6CcvOEXgKCCVf8Lmb
         89Ww==
X-Gm-Message-State: AOAM5323QF6p+rr9CHqXWpap4xMUFHRnpscSisU6NpoodpNYLYepntJF
        STAZyLXa7HjRJuZ1Gek8zgQp7VjgpmhmiqFKD74=
X-Google-Smtp-Source: ABdhPJwVAGvdTbuHda9TlHj5aRN5xl27cE1RidRpjc5f2ZpqWyON/HngNNK/mf9DQIXmKRtbe8uGl/bFxiiLklB8HlI=
X-Received: by 2002:a05:6602:5c8:: with SMTP id w8mr17871092iox.64.1592809026294;
 Sun, 21 Jun 2020 23:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592779555.git.raghavan.arvind@gmail.com> <4d2fa44b88c5f4f7aa53074220abba7beafa4fe8.1592779555.git.raghavan.arvind@gmail.com>
In-Reply-To: <4d2fa44b88c5f4f7aa53074220abba7beafa4fe8.1592779555.git.raghavan.arvind@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Jun 2020 09:56:55 +0300
Message-ID: <CAOQ4uxhx3NfTY_xF1TKXba3Sur2ZRcF3Okfyk38O+F1FPu8neg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] src/fssum: Allow single file input
To:     Arvind Raghavan <raghavan.arvind@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 22, 2020 at 2:16 AM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> Allow regular links and symlinks to be passed as input to fssum.
>
> Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> ---
> Since v1:
>         - Simplified logic by using sum_one
>  src/fssum.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/src/fssum.c b/src/fssum.c
> index 26b0096c..c5c27486 100644
> --- a/src/fssum.c
> +++ b/src/fssum.c
> @@ -29,6 +29,7 @@
>  #include <inttypes.h>
>  #include <assert.h>
>  #include <endian.h>
> +#include <libgen.h>
>

Is this needed by this patch? needed at all?
Should it have been added in a previous patch?

Thanks,
Amir.
