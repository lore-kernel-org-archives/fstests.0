Return-Path: <SRS0=Qan3=6O=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D420DC83000
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Apr 2020 00:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FB620787
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Apr 2020 00:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUEZPeT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD3ALh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3ALh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Apr 2020 20:11:37 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A6C03C1AE
        for <fstests@vger.kernel.org>; Wed, 29 Apr 2020 17:11:37 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c16so4293205ilr.3
        for <fstests@vger.kernel.org>; Wed, 29 Apr 2020 17:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNX36MfJk7IBpK5o4Rtr9c0ugSNR6OMpPTQH/YguY6g=;
        b=tUEZPeT54KIItlr+a8zUXJ88rxldGLUjvIvJkcc7ePf8hCbCFlTHHSkg/K0vaBAtt7
         9YiM5e+PaZZcsD24gZnbGhjlst3NSTG1woJrnK/6Uj8j64v8DGc8IZpA9JvindBL1aQd
         kaIEb+U7MPWVvxKCrHQMoFWviCwOKM4sKHvP6dO8AFV2mDog5LknRNGDagVz84JiaGXe
         WAFUjBPfK+JkS4QBlLdoneyRPdBNhLHjCGPgvmVnA9lZ4WEyItbYse+Ts68gZKFlVILV
         +wEvSUP0XVMBVwdqr83+CMZ1rzbBrdkdPZdEseSHuAiZHylIQPqlU1JhBBWAKA/xarox
         lrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNX36MfJk7IBpK5o4Rtr9c0ugSNR6OMpPTQH/YguY6g=;
        b=YOuFI2yiz1EC6nKvhKiCMZq8QB2FEMm+aTAy8wHSYfHKlpykU0f6YZZuAwJxh6X/+B
         JK1yQ3E1brskvlgOaWH7wDgBblAg//gRNgLjZHFK09McWL0KVOonII8XU+Rx+Mi/95fq
         X4V305za9fdqsTS2DSaUainJY1+WYafvSPhUmu7GaWAMo321JbXOtnDIbqU0X+wqR7Q3
         P5bWmTc7SGOKp37sodKxBjow/6ly2NvITOVuAJ4GtGu4jmfitfWIypO2ht3azA9rfPCm
         Or17sxB07TZSV+8akOuZhhEZZL0j3qqsGq4qbTZeQHfmCYE9mBLqhtxjCloht9qGO9b+
         uqUw==
X-Gm-Message-State: AGi0PuZb5+kEkX1XcwWxD0Nv379BR4W20H9lFkosquWr9jEPUYERj1gt
        2Bp5bnnLVXIqEuqm5m/gw4nIzBzzPs8LdGGbQ3P/qkLYwg==
X-Google-Smtp-Source: APiQypJ6mUjBH5Rcb0AJ/QugsCII4TlUGMR8t/cLeHvn6QlZN53QJUIiSStzXfiNa5G4PyLLVHd5zbpgEKmYlQhZyb8=
X-Received: by 2002:a92:bb01:: with SMTP id w1mr979610ili.233.1588205496213;
 Wed, 29 Apr 2020 17:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200428075300.3037-1-raghavan.arvind@gmail.com>
In-Reply-To: <20200428075300.3037-1-raghavan.arvind@gmail.com>
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
Date:   Wed, 29 Apr 2020 19:11:25 -0500
Message-ID: <CAM2wg3S0GMWBa06kmDS+FT6Di_Ygz3zaQyfT4JmyVppWHAaxYg@mail.gmail.com>
Subject: Re: [PATCH] fstests: Fix duplicate CLI arguments in fssum
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looking around the xfstest repo, I realized that there are in fact
test cases that use the '-x' flag in fssum to exclude paths, so
this patch breaks them. I'll send out a V2 that preserves the
behavior of '-x' and renames the other flag.

On Tue, Apr 28, 2020 at 1:28 PM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> fssum currently has a duplicate '-x' flag. This patch renames one of the
> duplicate flags and makes the appropriate doc changes.
>
> Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
> ---
>  src/fssum.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/src/fssum.c b/src/fssum.c
> index a243839a..b49ba59b 100644
> --- a/src/fssum.c
> +++ b/src/fssum.c
> @@ -150,9 +150,9 @@ usage(void)
>         fprintf(stderr, "    -[UGOAMCDXES]: exclude respective field from calculation\n");
>         fprintf(stderr, "    -n          : reset all flags\n");
>         fprintf(stderr, "    -N          : set all flags\n");
> -       fprintf(stderr, "    -x path     : exclude path when building checksum (multiple ok)\n");
> +       fprintf(stderr, "    -i path     : ignore path when building checksum (multiple ok)\n");
>         fprintf(stderr, "    -h          : this help\n\n");
> -       fprintf(stderr, "The default field mask is ugoamCdES. If the checksum/manifest is read from a\n");
> +       fprintf(stderr, "The default field mask is ugoamCdxES. If the checksum/manifest is read from a\n");
>         fprintf(stderr, "file, the mask is taken from there and the values given on the command line\n");
>         fprintf(stderr, "are ignored.\n");
>         exit(-1);
> @@ -713,7 +713,7 @@ main(int argc, char *argv[])
>         int plen;
>         int elen;
>         int n_flags = 0;
> -       const char *allopts = "heEfuUgGoOaAmMcCdDsSnNw:r:vx:";
> +       const char *allopts = "heEfuUgGoOaAmMcCdDxXsSnNw:r:vi:";
>
>         out_fp = stdout;
>         while ((c = getopt(argc, argv, allopts)) != EOF) {
> @@ -735,6 +735,8 @@ main(int argc, char *argv[])
>                 case 'C':
>                 case 'd':
>                 case 'D':
> +               case 'x':
> +               case 'X':
>                 case 'e':
>                 case 'E':
>                 case 's':
> @@ -768,7 +770,7 @@ main(int argc, char *argv[])
>                                 exit(-1);
>                         }
>                         break;
> -               case 'x':
> +               case 'i':
>                         ++n_excludes;
>                         excludes = realloc(excludes,
>                                            sizeof(*excludes) * n_excludes);
> --
> 2.20.1
>
