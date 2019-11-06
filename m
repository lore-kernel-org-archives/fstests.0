Return-Path: <SRS0=RANT=Y6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1193C5DF62
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Nov 2019 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC18206A3
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Nov 2019 11:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB4GhmFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfKFL0U (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:26:20 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46954 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfKFL0U (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Nov 2019 06:26:20 -0500
Received: by mail-yb1-f193.google.com with SMTP id g17so1279735ybd.13;
        Wed, 06 Nov 2019 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bJzPoD1kU1q/ea/9T/DwmvZTAlmNUtP7MMO3lNAiP0c=;
        b=aB4GhmFXXiFXq3azN7BMKa5TlO2MJiDIv6xtNsqJopfxzRZ4BHnFkCPYpoNRgUNS/E
         VDzJGf7Uyo8gVN6eKlCZ5rjUG51CqQ5TEdYShZJ1ZRtCu39Vc+yoDxkc+jicf5Oz+hev
         TgGqOdOurpn2nG9xXF8zqBeroNpoYhvx5Hf0hk6wsoqU9koYFqDZTn+IHArBg7eg0j09
         wBZb33U5/SvI9o0oEKcg6kPehjbAaS8ILxWVInRMVeYrBTSmMEwm/TMsdGb9YyyUCb9u
         GYCA2zQ2y7pf7q4d7GPFoOYTWnL+MykBs7QGJuQFLS3JdxeZEDNV/HNdmSc0qJx1cz9d
         9fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bJzPoD1kU1q/ea/9T/DwmvZTAlmNUtP7MMO3lNAiP0c=;
        b=R3oWGmMbLnJ8hrWSB15ngCs50m23rpl5v+AnWkSGLbIBFEDne3Zj3Z/N3H+khZIWuF
         800BZ+eoc+xHNnjk/+wKSzTnqLne4XxwovVjqxqy1rRlTvUFGA1z7JdjSD31qPG+toyH
         C2bLHopglip+aZnoj/L24maPYootNG9FxCwa4sBd8L5xCLSk4QxSxmxgUEPR6GoBeb8b
         WV9tkfYhM6nGMajvFVhl/nK8S02MkvPpgFxAzM4RskoQbirgSgF/WzckxeuT4rI9fV9c
         bADYtxvUSZ0vuR3BmY56aeB98wbSAQCBdBXZcUZ9CH1PYRvb4wzZRIV9DviAp0GsgX5J
         GcIA==
X-Gm-Message-State: APjAAAWZSJN9TUywCIvSZ6kzr2A99Sb0vN8pRfO6lroTMyN9bnXQ2HoH
        6dZNoQ30UZwpxnhWQS2LnK8H8GNBvken7+Q81cs=
X-Google-Smtp-Source: APXvYqx6TkDEuthYkKNUmdg7qEUpusT3BLn/sT/HKmvUtlUIv74NnV72CfZhX7+AL9+BPN/AWvdKYeB61N54yGY7qiM=
X-Received: by 2002:a25:3344:: with SMTP id z65mr1503795ybz.439.1573039579004;
 Wed, 06 Nov 2019 03:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20191106073945.12015-1-cgxu519@mykernel.net> <CAOQ4uxgBO6zZVJsa2uor5kwa1jp05Xrte6fifZdOsX=yF=v0-g@mail.gmail.com>
 <16e403ebe86.e4a465d3522.6312283139717764767@mykernel.net>
In-Reply-To: <16e403ebe86.e4a465d3522.6312283139717764767@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 6 Nov 2019 13:26:07 +0200
Message-ID: <CAOQ4uxjWjjMw7o32JaG_nuqw4oXw_Qo+jWjhRXkQ9pd9o1QjmQ@mail.gmail.com>
Subject: Re: [PATCH v3] overlay/066: adjust test file size && add more test patterns
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     fstests <fstests@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 6, 2019 at 12:24 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 18:01:54 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > On Wed, Nov 6, 2019 at 9:40 AM Chengguang Xu <cgxu519@mykernel.net> wr=
ote:
>  > >
>  > > Making many small holes in 10M test file seems not very
>  > > helpful for test coverage and it takes too much time on
>  > > creating test files. In order to improve test speed we
>  > > adjust test file size to (10 * iosize) for iosize aligned
>  > > hole files and meanwhile add more test patterns for small
>  > > random holes and small empty file.
>  > >
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>  >
>  > Please send me a plain text version of the patch so I can test it.
>  >
>
> Hi Amir,
>
> Sorry for that again but I really don't know what was wrong for this patc=
h.
> I sent using 'git send-email' and there was nothing broken or unusual com=
pare
> to other normal patches. So I have to send this patch in attachment again=
.
>

Test runs fine, except big random file has a single chunk 32MB of data:

Big random hole test write scenarios ---

/root/xfstests/bin/xfs_io -i -fc "pwrite 1024K 30862K"
/vdf/ovl-lower/copyup_sparse_test_random_big
wrote 31602688/31602688 bytes at offset 1048576
30 MiB, 7716 ops; 0.1295 sec (232.614 MiB/sec and 59553.1201 ops/sec)

That is because of this typo:

@@ -133,7 +133,7 @@ file_size=3D102400
 min_hole=3D1024
 max_hole=3D5120
 pos=3D$min_hole
-max_hole=3D$(($file_size - 2*$max_hole))
+max_pos=3D$(($file_size - 2*$max_hole))

If you re-submit, please add my Reviewed-by tag.

Thanks,
Amir.
