Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5AFEB64DA
	for <linux-fstests@archiver.kernel.org>; Sat, 24 Jun 2023 05:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFXFcr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 24 Jun 2023 01:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjFXFcp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 24 Jun 2023 01:32:45 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14B92696
        for <fstests@vger.kernel.org>; Fri, 23 Jun 2023 22:32:43 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4718ddce780so585436e0c.1
        for <fstests@vger.kernel.org>; Fri, 23 Jun 2023 22:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687584763; x=1690176763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu0KBYhfBkBNunwiFXYT6mw0grylUJPP10E7jpGHYU4=;
        b=KkZJvHTOEQX1oP28TVzsjwvUAynDpzWOcCx5b4GJ5GnKS0MhDKhiTfIgD9QsGhrech
         tPFwFlWo91U95VXtvmHGIE3//55QGyOO/IpfZL6ThicRtB8GlohSdhW/9kpx2uHKXbv8
         DRyN7XnTSWS9gYlFFPcSPgpzHfMTvDeA4GGjGTiAL1LgUTyLIfyFxkL9yt6MPlnYSKos
         LZ+MxzkHz2XFILw+CQBYrGYEqYylGMt7N6fw6Mp/k72XLw+0gPtzH93vYH7DVB9dIQTr
         N8U+IO9hV1ugeCV6V4dCEIP0OMWTfpTSHFUvHS9mcVWLJTHh4bY+HTO+XaD3VDv9fn4B
         O2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687584763; x=1690176763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu0KBYhfBkBNunwiFXYT6mw0grylUJPP10E7jpGHYU4=;
        b=Ixk8xsI7M+tfUgrIAYhxsp8jl5t9GI6NFyqs8CseS2myGAT5tr9ViaYKzmcyG4/uQm
         SEB/VnIKWTsC/wqMY6N2izts+2oEJSh1vnZ2sy1866IywoF/y49Sqp+yFbwlDNLGibiG
         LTvLAJT/05YZpBMcWamycHFNlUBRrssuz6zScAvHyPYRfsbcBoyi4NZEfKuxbvmkdgL5
         EH4z7oHq1+fepjT1egNJxNyHfbXtCb0Q2vAFrbSFeDyhrGkIUKfJW+RmKaZ1F+KCj1hm
         cOsDZw02sMkZ4WHbTp3aeSo+0OF3jOqFUbKDHsVj7CCItOk2ucwWrnmJCIDem6ReP06V
         Z74g==
X-Gm-Message-State: AC+VfDzadqBtA7waBRrNEt7yhyb5q+I5RiEUgCUxKTg5WoR/skPuVt0N
        3ikjXOuqPJWLR3jhxxxC8NkhOlvIHGLFBiAlEQpMXjJe
X-Google-Smtp-Source: ACHHUZ4dU2KjAkfQuRKQMwQlaM3iW8dP43OEHbbQkPZB+0ncFreskOTiZccDU+Hj9cO1nkC/FKUHDKpo+LLb+68nLtw=
X-Received: by 2002:a1f:450e:0:b0:471:549e:c1ff with SMTP id
 s14-20020a1f450e000000b00471549ec1ffmr12505774vka.7.1687584762763; Fri, 23
 Jun 2023 22:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230619105058.2711467-1-amir73il@gmail.com> <20230621022355.yk7dy2e6sghcuzrp@zlang-mailbox>
 <20230621112656.2efac042@echidna.fritz.box> <CAOQ4uxiwS8GZkgr6KYx9_+uCgv2Z11pdWxV3Qr6tu9cNP_Pwyw@mail.gmail.com>
 <20230623152931.plfuztmlzsazpt3a@zlang-mailbox>
In-Reply-To: <20230623152931.plfuztmlzsazpt3a@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 24 Jun 2023 08:32:31 +0300
Message-ID: <CAOQ4uxiOo6xHZdSjqFTdRgqNOvoEKjfw57Qdk8G5JrTtejcaNQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: reduce runtime of check -n
To:     Zorro Lang <zlang@redhat.com>
Cc:     David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 23, 2023 at 6:29=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Wed, Jun 21, 2023 at 03:09:35PM +0300, Amir Goldstein wrote:
> > On Wed, Jun 21, 2023 at 12:24=E2=80=AFPM David Disseldorp <ddiss@suse.d=
e> wrote:
> > >
> > > Hi Zorro and Amir,
> > >
> > > On Wed, 21 Jun 2023 10:23:55 +0800, Zorro Lang wrote:
> > >
> > > > On Mon, Jun 19, 2023 at 01:50:58PM +0300, Amir Goldstein wrote:
> > > > > kvm-xfstests invokes check -n twice to pre-process and generate t=
he
> > > > > tests-to-run list, which is then being passed as a long list of t=
ests
> > > > > for invkoing check in the command line.
> > > > >
> > > > > check invokes dirname, basename and sed several times per test ju=
st
> > > > > for doing basic string prefix/suffix trimming.
> > > > > Use bash string pattern matching instead which is much faster.
> > > > >
> > > > > Note that the following pattern matching expression change:
> > > > > < test_dir=3D${test_dir#$SRC_DIR/*}
> > > > > > t=3D${t#$SRC_DIR/}
> > > > > does not change the meaning of the expression, because the
> > > > > shortest match of "$SRC_DIR/*" that is being trimmed is "$SRC_DIR=
/"
> > > > > and removing the tests/ prefix is what this code intended to do.
> > > > >
> > > > > With check -n, there is no need to cleanup the results dir,
> > > > > but check -n is doing that for every single listed test.
> > > > > Move the cleanup of results dir to before actually running the te=
st.
> > > > >
> > > > > These improvements to check pre-test code cut down several minute=
s
> > > > > from the time until tests actually start to run with kvm-xfstests=
.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Zorro,
> > > > >
> > > > > Just to clarify, this change is not expected to change behavior -
> > > > > only to improve runtime of check -n and the things that happen
> > > > > before the first test is invoked.
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > > >
> > > > >  check | 22 +++++++++-------------
> > > > >  1 file changed, 9 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/check b/check
> > > > > index e36978c1..1a16eccb 100755
> > > > > --- a/check
> > > > > +++ b/check
> > > > > @@ -399,9 +399,9 @@ if $have_test_arg; then
> > > > >             *)      # Expand test pattern (e.g. xfs/???, *fs/001)
> > > > >                     list=3D$(cd $SRC_DIR; echo $1)
> > > > >                     for t in $list; do
> > > > > -                           test_dir=3D`dirname $t`
> > > > > -                           test_dir=3D${test_dir#$SRC_DIR/*}
> > > > > -                           test_name=3D`basename $t`
> > > > > +                           t=3D${t#$SRC_DIR/}
> > > >
> > > > Actually I'm not sure what's this line for. We get $list by "cd $SR=
C_DIR; echo $1",
> > > > is there any chance to have "$SRC_DIR" in $t (or $test_dir) ?
> > >
> > > Indeed, this line can be dropped. One minor change in behaviour here =
is
> > > that a test pattern with a wacky path prefix e.g. ../tests/xfs/00? wi=
ll
> > > no longer work. I think breaking such patterns is okay, but it could
> > > also be resolved by more carefully extracting the last two path
> > > components.
> > >
>
> Hi Amir and David,
>
> Sorry for the late reply, I'm on a holiday of Dragon Boat Festival recent=
ly,
> will be back tomorrow :)
>
> >
> > I didn't want to drop it because I didn't want to change legacy behavio=
r.
>
> Sure, I didn't want to remove this line in this patch, due to it's not
> match the target of this patch. Just speak out to check with you and
> others :)
>
> As we agree this line is useless, we can deal with it in later patch
> which improves ./check.
>
> > When user's cwd is fstests root directory, it may be natural for some
> > users to use bash auto completion to run the command
> > ./check tests/generic/001
> >
> > so there may well be users out these that pass test names including
> > the tests/ prefix and check has always trimmed this prefix.
> >
> > There is something a bit confusing about expanding of bash
> > patterns:
> >
> > When the user uses this syntax:
> > ./check tests/generic/00?
>
> I think the "tests/" prefix is not necessary to support :)
>

Fine by me.

> >
> > the shell expands that pattern to a list of 9 arguments passed to
> > ./check tests/generic/001  tests/generic/002 ...
> >
> > But when the user uses the documented syntax:
> > ./check generic/00?
> > check gets a single argument and $(cd $SRC_DIR; echo $1)
> > expands this single argument to a list
> >
> > All the above is existing behavior which my patch should
> > not have changed.
> >
> > > > > +                           test_dir=3D${t%/*}
> > > > > +                           test_name=3D${t#*/}
> > > >
> >
> > You may change the above to:
> > +                           test_dir=3D${t%%/*}
> > +                           test_name=3D${t##*/}
>
> OK, this makes more sense to me. I'll give this a test, and merge this
> change if no regression. Or you'd like to send a V2 to change more.
>

I have no plans to send v2 with more changes.
Please make this change on merge.

Thanks,
Amir.
