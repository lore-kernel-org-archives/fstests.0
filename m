Return-Path: <SRS0=+7JN=7R=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA1C433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 09:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8072075B
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 09:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tK6mZNnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgFDJsL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgFDJsK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Jun 2020 05:48:10 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C542C03E96D
        for <fstests@vger.kernel.org>; Thu,  4 Jun 2020 02:48:10 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o26so4181921edq.0
        for <fstests@vger.kernel.org>; Thu, 04 Jun 2020 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3r2btslnp4mMlhk1fCPtP5deoFXhxBN6BaRHOg6NLQI=;
        b=tK6mZNnhbwm3Sr4cNjnyMF8uV+kW9CWu+9DCcH+ybUFZYyOvrJsnrbId7xBh3ZXjcX
         2Q4h2kLG5+R18p5ei58SXS2yk3EmxfRDgfLzl74+6tq8XLET2cK6ym8N657VhO9f1k1U
         xvPI4bUGKYDvrqml+I1oY5kXisPas3UTRoQFvEBVb0H/7qK+8MGnGEoM0j02oGeJ747d
         aaQG+20CJQzG6SbkTk9go5cuLcYg/4nPX/h89u+wJ6WNyNlW2X3q6Hc6vSS9taezD+9O
         ttUcyaWIp0MyRTr7UES6d7S7YkD4ezZeB+4mfrXiWspar809BU5mlkUcoiD3AOKjv5L0
         jprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3r2btslnp4mMlhk1fCPtP5deoFXhxBN6BaRHOg6NLQI=;
        b=LFNFckVJSU4eK4nzgK7Y5QZn+DEhjI3uD8ls+k1ltmFGyzhl2fgFjlaWC7qEgIk8A1
         t5Lq9ChKVkeTUHuVjzTCvDDIxYdJ5SwBlGpClcOb5OlELJSrs/sB6OtTbenFB+cSKwlu
         Zy5i1IpAu22jnSJEhSnFoicg4PBiMm0nTBGAtoL8S38Lpa+xRrMyuHurmvql5hNnsm9g
         JwhuGW2nWb2X/LO9+qLKJRN8++mrVVtqaNMmBWofWaiJjvF6wghxxXPxTk1vCtPFO19m
         O2hJIhFp2RGbXHBLXzVfMnTuPj4n0UmZsH3NGJPfpsDyUuH6+ofhyekgUWUBT6dAZVgM
         MALg==
X-Gm-Message-State: AOAM530Ib3w1zZgqW28xhL2ZJCfZ+UtllvpN2SDJkWcm7oxMPIfRd+Nw
        N94JIDFl9GLBhQhGnfdLW5WKt1DQy7iAz3u+djU=
X-Google-Smtp-Source: ABdhPJzuMAJWh3RHKtUCT7eYrGnYNRgMpNYim7V1FsH3pKMrV3Y0voHsukRWOv4jztA5lpsoKfCZYwXH8fF9MJrNez8=
X-Received: by 2002:aa7:cd42:: with SMTP id v2mr3359846edw.360.1591264089089;
 Thu, 04 Jun 2020 02:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200603102035.552-1-yosun@suse.com> <20200604083023.GA26629@dell5510>
In-Reply-To: <20200604083023.GA26629@dell5510>
From:   Sun Yong <sunyong0511@gmail.com>
Date:   Thu, 4 Jun 2020 17:47:57 +0800
Message-ID: <CAAPJbvr4TXb2djMWq2BE6gjk83_MJZ48Zn+nd4HbypuV5Svgew@mail.gmail.com>
Subject: Re: [PATCH] fstests: modify user name beginning with non-digit
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org,
        Yong Sun <yosun@suse.com>, Eryu Guan <guaneryu@gmail.com>,
        Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Petr Vorel <pvorel@suse.cz> =E4=BA=8E2020=E5=B9=B46=E6=9C=884=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Sero,
>
> > openSUSE and SLE don't support username begin with digit, so it will
> > skip test generic/597 and generic/598 by lack of 123456-fsgqa user.
> > generic/597 and 598 are not test username begin with digit on purpose
> > (different with generic/381). It's will be helpful to use an username
> > begin with non-digit in this case.
>
> > Signed-off-by: Sun Yong <yosun@suse.com>
> > ---
> >  README            | 1 +
> >  tests/generic/597 | 4 ++--
> >  tests/generic/598 | 4 ++--
> >  3 files changed, 5 insertions(+), 4 deletions(-)
>
> > diff --git a/README b/README
> > index 094a7742..cffa0bc6 100644
> > --- a/README
> > +++ b/README
> > @@ -22,6 +22,7 @@ _______________________
> >  - create fsgqa test user ("sudo useradd -m fsgqa")
> >  - create fsgqa group ("sudo groupadd fsgqa")
> >  - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
> I thought fsgqa-123456 is replacement for 123456-fsgqa. Thus I'd delete t=
his
> line.
> > +- create fsgqa-123456 test user ("sudo useradd fsgqa-123456")
>
> Also test tests/generic/381 still uses 123456-fsgqa. Shouldn't be replace=
d as
> well?

As Zorro said, generic/381 is purpose to test digital started username, mod=
ify
it will make that test meaningless. So better leave it skip when system don=
't
support digital started username.

>
> >  ______________________
> >  USING THE FSQA SUITE
> > diff --git a/tests/generic/597 b/tests/generic/597
> > index 1d87a23a..c4d524b7 100755
> > --- a/tests/generic/597
> > +++ b/tests/generic/597
> > @@ -43,11 +43,11 @@ _require_sysctl_variable fs.protected_symlinks
> >  _require_sysctl_variable fs.protected_hardlinks
> >  # su in _require_user prints warnings about user name starts with a di=
git,
> >  # discard the warning
> > -_require_user 123456-fsgqa >/dev/null 2>&1
> > +_require_user fsgqa-123456 >/dev/null 2>&1
> I that redirection to /dev/null was due errors caused by starting with
> digits. As other _require_user calls don't have it, I'd remove the
> redirection. + remove that comment "su in _require_user prints warnings a=
bout
> user name starts with a digit," ... which is now useless/invalid.

Nice catch, then no need to redirection and comments also invalid.
I'll modify it in v2.

>
> Eric, was there a reson to use user name which starts with digit?
>
> >  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that acco=
unt
> >  _require_user fsgqa
>
> > -OWNER=3D123456-fsgqa
> > +OWNER=3Dfsgqa-123456
> >  OTHER=3Dfsgqa
>
> >  # Save current system state to reset when done
> > diff --git a/tests/generic/598 b/tests/generic/598
> > index 998b62cf..1cf9a3d1 100755
> > --- a/tests/generic/598
> > +++ b/tests/generic/598
> > @@ -43,11 +43,11 @@ _require_sysctl_variable fs.protected_regular
> >  _require_sysctl_variable fs.protected_fifos
> >  # su in _require_user prints warnings about user name starts with a di=
git,
> >  # discard the warning
> > -_require_user 123456-fsgqa >/dev/null 2>&1
> > +_require_user fsgqa-123456 >/dev/null 2>&1
> >  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that acco=
unt
> >  _require_user fsgqa
>
> > -USER1=3D123456-fsgqa
> > +USER1=3Dfsgqa-123456
> >  USER2=3Dfsgqa
>
> >  # Save current system state to reset when done
>
> Kind regards,
> Petr

Thanks,
Sero
