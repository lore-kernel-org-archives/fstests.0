Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757BEEB64D7
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jun 2023 13:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFUNB4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFUNBz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Jun 2023 09:01:55 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D60B10D5
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2023 06:01:55 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-440c368b4e2so826253137.2
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2023 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687352514; x=1689944514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yE4Juiria3oxXWUWnD/EnDlcpZ9coUHCBvuz35pZ8o=;
        b=DWH2nxqqlBaNg21QnfGTiaNpyurklYVFoA6Hn+XwNqC6+kRzGOt10Detp0tYXvqNeh
         3K21x75/Xc2MGqn7qItfgjMr2f9d0ehdl84epP2exIcJxKdoX2/FFwunQGbIkSmDFTOD
         mnMJcMCf1e+3IPnn0ZOANYPSynxspXZs/UXCXjXARu2Cr6DJ2YOa8NaRCfYFe8jAtB7k
         jE236Wc/AwC3W+TNR/1pYlAvWv9ZrjlDeiILlWh/+qB5wx3NDjdUh6HaaeWgnmhxhka7
         3C5JUPvMusVupUe9zsjTSj+3eydy9nwtXLGfNHGjF0Acxwfa4Ux44g1QDs/3UJiol1Ae
         EH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687352514; x=1689944514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yE4Juiria3oxXWUWnD/EnDlcpZ9coUHCBvuz35pZ8o=;
        b=WBuGVVXEdJIvaplV2/D8Ce79hCGdw5hJ3gTsIKKDj8/Q1BOGqi2M+mS4L0bm3s6wn8
         QceM4TI4xKcyz3W9IYV5Mby5y5vpgVoFhUc9TfPgIeTT1ZTRwjLu9DziFy/XcTNMQGBi
         XDeODK3FHvxWiPfX3KVD4NtsPukHYX3dHk5rFF2SdBS8mhPKG+VEhRPW7+/V2nGPvQBL
         DI2VaVsXk+QXZlqeTnh+pVL9X7kvWOIabWR161/fj34Ud2x4pnni9g8r8Oo0yhQZgIkc
         wHCT26e1itUuAUm4YSaLZkAz/wIfDq8AQ3/tIEqYK36bF55XspXvYLU3bQwP0UPeOsDj
         HyRA==
X-Gm-Message-State: AC+VfDwYMpSZeb9gnAM8vzxkw1owHIjgbv80A/yXwlsU1kqSHTFBKCSe
        0987OOj5Xv5nD13mOl7XVwIcrbgZzDP8sxA4V1A=
X-Google-Smtp-Source: ACHHUZ5KvrerlFcrmOCmftp5zDU41ti9U5HoGHcF+lm3t2pC2NwRXIyohMlevzUnL9YJH1atxmepNai9SNOsZg05iP4=
X-Received: by 2002:a67:de08:0:b0:440:c6ad:52a4 with SMTP id
 q8-20020a67de08000000b00440c6ad52a4mr3101521vsk.9.1687352514093; Wed, 21 Jun
 2023 06:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230619105058.2711467-1-amir73il@gmail.com> <20230621022355.yk7dy2e6sghcuzrp@zlang-mailbox>
 <20230621112656.2efac042@echidna.fritz.box> <CAOQ4uxiwS8GZkgr6KYx9_+uCgv2Z11pdWxV3Qr6tu9cNP_Pwyw@mail.gmail.com>
 <20230621144252.2c3b5e7f@echidna.fritz.box>
In-Reply-To: <20230621144252.2c3b5e7f@echidna.fritz.box>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Jun 2023 16:01:42 +0300
Message-ID: <CAOQ4uxgw0Y-7gf0YM0kDFBxzDqAAxKQYnnV2qY_Hzc9GcXT71A@mail.gmail.com>
Subject: Re: [PATCH] fstests: reduce runtime of check -n
To:     David Disseldorp <ddiss@suse.de>
Cc:     Zorro Lang <zlang@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 21, 2023 at 3:40=E2=80=AFPM David Disseldorp <ddiss@suse.de> wr=
ote:
>
> On Wed, 21 Jun 2023 15:09:35 +0300, Amir Goldstein wrote:
>
> > On Wed, Jun 21, 2023 at 12:24=E2=80=AFPM David Disseldorp <ddiss@suse.d=
e> wrote:
> ...
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
> >
> > I didn't want to drop it because I didn't want to change legacy behavio=
r.
> > When user's cwd is fstests root directory, it may be natural for some
> > users to use bash auto completion to run the command
> > ./check tests/generic/001
> >
> > so there may well be users out these that pass test names including
> > the tests/ prefix and check has always trimmed this prefix.
>
> Ah, yes, understood.
>
> > There is something a bit confusing about expanding of bash
> > patterns:
> >
> > When the user uses this syntax:
> > ./check tests/generic/00?
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
>
> The example I gave was "../tests/xfs/00?", which does get broken by this
> change. It's relative to SRC_DIR and independent of check parameter
> expansion. As mentioned, I think it's obscure enough usage that this
> breakage shouldn't be worth bothering about.
>

I agree.
Users of tests/xfs/* may be out there (due to bash auto complete)
Any other prefix, including ../tests/ is far less likely to exist in the wi=
ld
(famous last words)

Thanks,
Amir.
