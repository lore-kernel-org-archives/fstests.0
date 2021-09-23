Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328F7C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 12:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCD86054F
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 12:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbhIWMjN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Sep 2021 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhIWMjN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Sep 2021 08:39:13 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FB4C061574
        for <fstests@vger.kernel.org>; Thu, 23 Sep 2021 05:37:41 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id w8so4030415qvu.1
        for <fstests@vger.kernel.org>; Thu, 23 Sep 2021 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zg3sHLUSs6tP3dbq1AzPROZbv+pWQfhrY6i9mtLvZkY=;
        b=kTFBVHgRZTklyw95rPU8/sd7EAow4DsdOS8ETgwV5oAo2oqUSqlgop+zSNeta2R6xy
         5aKE28srzJswnKi1WkFk0ZRiGyADOv1IOD+ieb/tbrZ6/zPYWTgoetfZUu6MkHDm75xJ
         tPxd8yB6EVBtHQ/GG+A3CDjp6InJ7RDyx3AkrSRCp9a8g6SHttYhr4MIkqXJBksVCWk+
         ctTfZgZ4v6VwrZubiT/JMjnFTGqZxyyAIEFOpOlX0vozkU5l8QNNV2LBNo8cjzVp1XWy
         kUn2q572CZTvMZGQlC8GR1Vk2FY5to50FjnmHwo4uIhAtXgwvpYW+lKxUGp79ZPmXAVp
         51NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zg3sHLUSs6tP3dbq1AzPROZbv+pWQfhrY6i9mtLvZkY=;
        b=M7a2ipNOeTK3GmFpWnbtWB4BaPZglfX+WDqHgbMh0+rSU1nCNt12hK+EVU2PrUbjMN
         owSePtsiEMFRMlRoKWNRifJnzL8PzuJJTBxXKHrZcOC7ko48mrUmyxtnDy2sw7ETCowl
         shEDQeCXyuiCAfW/pNi/RnZoYGTZ1wz78akDJ6NaMK8ngsmGgLuLjj0O6j4atttER8+e
         U+xaPmo1507Vh5BAEoaoDJ+1tjpjPtX/63cN3+qnc7oZ69ZfM31c490euZ4Ur9w1pHCM
         WTGj5KlcVJYLGBvndn3qILo2OOjDUu8C70UFR/P/sDIzSNyle5u8BJJHpNcPoZNH1WsV
         VdbQ==
X-Gm-Message-State: AOAM531qhPOSPISpYDw6GZjAczp4gnZQYQ4/OOhsBZofzQ8QEaNL3Iqt
        N+Ie1ghHleouO4P+Z5QzAB1GI7DTIJVUIUOuJdQ=
X-Google-Smtp-Source: ABdhPJywxGmgAddrkgRx50B4IRQyRf/gNIhyXAagKi2di5RrKCTihcYyL/i5/dxhZ8OluuxMDE1ZxBAQ82T40VPDg1c=
X-Received: by 2002:ad4:4aad:: with SMTP id i13mr3859289qvx.27.1632400660829;
 Thu, 23 Sep 2021 05:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210921175035.1286786-1-mcgrof@kernel.org> <CAL3q7H4hvwDcio3qqTbQj0BK9GbEeGhfbx2F32WBpB3D5nKL8Q@mail.gmail.com>
 <YUuM/h7zGaAsPggl@bombadil.infradead.org>
In-Reply-To: <YUuM/h7zGaAsPggl@bombadil.infradead.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 23 Sep 2021 13:37:04 +0100
Message-ID: <CAL3q7H6yykw_roQvF-vS3DHyMh9hLmagq1ZamQqqWJWLwafsYA@mail.gmail.com>
Subject: Re: [PATCH] fsstress: improve error message on check_cwd() error
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 22, 2021 at 9:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Sep 22, 2021 at 11:15:08AM +0100, Filipe Manana wrote:
> > On Tue, Sep 21, 2021 at 6:51 PM Luis Chamberlain <mcgrof@kernel.org> wr=
ote:
> > >
> > > I ran into an error with generic/083 with xfs due to check_cwd() but
> > > why it failed is not clear because there are two types of
> > > failures:
> > >
> > >   o stat64() failed (likely -ENOMEM is my guess)
> > >   o the inode actually changed
> > >
> > > Thow a bone out to developers so that in case en error does happen
> > > they know which rabbit hole to go down on.
> > >
> > > Cc: Anthony Iliopoulos <ailiopoulos@suse.de>
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  ltp/fsstress.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > > index b4ddf5e2..d2f09901 100644
> > > --- a/ltp/fsstress.c
> > > +++ b/ltp/fsstress.c
> > > @@ -9,6 +9,7 @@
> > >  #include <sys/uio.h>
> > >  #include <stddef.h>
> > >  #include <stdbool.h>
> > > +#include <string.h>
> > >  #include "global.h"
> > >
> > >  #ifdef HAVE_BTRFSUTIL_H
> > > @@ -943,9 +944,21 @@ check_cwd(void)
> > >  {
> > >  #ifdef DEBUG
> > >         struct stat64   statbuf;
> > > +       int ret;
> > > +
> > > +       ret =3D stat64(".", &statbuf);
> > > +       if (ret !=3D0) {
> > > +               fprintf(stderr, "fsstress: check_cwd stat64 failed wi=
th: %d (%s)\n",
> > > +                       ret, strerror(ret));
> >
> > The error is not in 'ret' but instead in 'errno', so it should print
> > errno and strerror(errno).
>
> Good call will fix.
>
> > > +               goto out;
> > > +       }
> > >
> > > -       if (stat64(".", &statbuf) =3D=3D 0 && statbuf.st_ino =3D=3D t=
op_ino)
> > > +       if (statbuf.st_ino =3D=3D top_ino)
> > >                 return;
> > > +
> > > +       fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%ld) !=
=3D top_ino (%ld)\n",
> > > +               (long)statbuf.st_ino, (long)top_ino);
> >
> > ino_t is guaranteed to be an unsigned integer, and can be either 64 or
> > 32 bits wide [1].
> > Casting to unsigned 64 bits would be better imo.
>
> There are other similar mi-uses in the code, should I fix those to
> then?

If you want to, as a separate patch.
Noticing now that since the code is using struct stat64, using %llu
for the printfs without any casts should be fine [1].

Thanks.

[1] https://www.mkssoftware.com/docs/man5/struct_stat.5.asp

>
>   Luis
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
