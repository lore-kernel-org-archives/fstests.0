Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F3C77B72
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Apr 2023 20:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDQUJA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDQUJA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2023 16:09:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141097
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2023 13:08:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-504dfc87927so5000750a12.0
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2023 13:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681762137; x=1684354137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzAasmnyFEdfyZ0dIZhiMAqVpIC/uO3MWMj65WZVCDI=;
        b=a+j7lGLC0CtXZTBFCvYBgY1TzLzFdpSeKAc13uylk4jRztovI6ZtQX9eX4XEc8+JD8
         VQuaFRAKzOuuSAjADCISyd2ig+cd6x5iAwAHMmrfxQnTN/xtoaramOBJas25kX/50ezK
         lP9YezfI50K74nCfDBwBb2h53kR3/9FFjd8pnCnO9rWJz+mTY865ORTOIDxQ76Wcxbwn
         h6nfoTb1oRbxeLFfi8g1NMwnujKyZ6Rr6EDagD1efE9WZSoDDTL4JRCLYzDdJnBMuVtc
         4eUHbo5iJcpysWxJBOl6xAaVPRBSsYKvxTU6iyUvHtL1zwuWdFfNsLY0AW27/1jzwDcA
         T8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681762137; x=1684354137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzAasmnyFEdfyZ0dIZhiMAqVpIC/uO3MWMj65WZVCDI=;
        b=g20D5GFzY7AxUIZxuViFiHIbXB2vrvQulJP5w7bI+ohYRz6CwMkauBDFcafqqCMh89
         y+fuwXykXSFhP4BseK4nNWwQK9mHSNXkrwl/O5ORTeeLeBbsCuSpE374IZ9ds6wDG/sH
         1aTRRjNx1mYT0AD6aUO/r6j+4EuDC7bLlrFZ3O/HR0Y98ur8fTju17K32UeHKRoByS3O
         8/n26X8RRjtrswtPjj59OzwYSSGLySm7Imezq56QpgsnFiE6H1RMm644nW24wEsL5Tiv
         W5F6VzB9JxRaxZeYtYv081VojAlO1vugmBPEc5GzNF+6cVLfE2dohtX4wOK+1b99n4Fh
         v+uw==
X-Gm-Message-State: AAQBX9eotn2n5ihTnGgMXQ5WhTRp8wMiPq9FUxqEFPQXRjLKAYTZ9wIb
        opVg+CgfAydwbWeX3nWGjAcFsm/mAqdMi0EKUFIvTw==
X-Google-Smtp-Source: AKy350YIfB/1Nxc6iTsgf/QeM4jc8ocDCOXaiAlhasshgx+zyNqb2yRnD6emcIOUwOOO3014mHWEBZoor5mEIohRiRE=
X-Received: by 2002:a50:8758:0:b0:4bb:e549:a2ad with SMTP id
 24-20020a508758000000b004bbe549a2admr79452edv.4.1681762137193; Mon, 17 Apr
 2023 13:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230414221133.3431400-1-leah.rumancik@gmail.com>
 <20230414221133.3431400-2-leah.rumancik@gmail.com> <20230415004131.GC360885@frogsfrogsfrogs>
 <CAMxqPXVGGOn6A5ijRwaw7k0JfYD2gHftDWOVBVq=jrE3JW9gDQ@mail.gmail.com>
In-Reply-To: <CAMxqPXVGGOn6A5ijRwaw7k0JfYD2gHftDWOVBVq=jrE3JW9gDQ@mail.gmail.com>
From:   Leah Rumancik <lrumancik@google.com>
Date:   Mon, 17 Apr 2023 13:08:20 -0700
Message-ID: <CAMxqPXVo4aadFwLFZLkEoBXCPk=RPe1yjXraSjsN1PN0jXZLKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] check: _check_filesystems for errors even if test failed
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Well actually, if you are using DUMP_CORRUPT_FS, you'd probably want
_check_filesystems to run on the scratch fs as well. This shouldn't
add that much time if most of your tests are passing :) but I could
make this only run for scratch fs on failure only if DUMP_CORRUPT_FS
is set?


On Mon, Apr 17, 2023 at 10:19=E2=80=AFAM Leah Rumancik <lrumancik@google.co=
m> wrote:
>
> Sure, will send out another set. Thanks!
>
> On Fri, Apr 14, 2023 at 5:41=E2=80=AFPM Darrick J. Wong <djwong@kernel.or=
g> wrote:
> >
> > On Fri, Apr 14, 2023 at 03:11:33PM -0700, Leah Rumancik wrote:
> > > Previously, we would only run _check_filesystems to ensure that a tes=
t
> > > that appeared to pass did not have any filesystem corruption. However=
,
> > > in _check_filesystems, we also repair any errors found in the filesys=
tem.
> > > Let's do this even if we already know the test failed so that subsequ=
ent
> > > tests aren't affected.
> > >
> > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > ---
> > >  check | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/check b/check
> > > index befbf465..c18f02ca 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -972,6 +972,7 @@ function run_section()
> > >                       # Even though we failed, there may be something=
 interesting in
> > >                       # dmesg which can help debugging.
> > >                       _check_dmesg
> > > +                     (_adjust_oom_score 250; _check_filesystems)
> >
> > Seeing as the test failed, do we care about the state of the scratch fs=
?
> > Would it be sufficient only to clean up the test fs to avoid cascading
> > damage?
> >
> > (Asking as someone who knows how impactful slow filesystem checking can
> > be on fstests runtimes... ;))
> >
> > --D
> >
> > >                       tc_status=3D"fail"
> > >               else
> > >                       # The test apparently passed, so check for corr=
uption
> > > --
> > > 2.40.0.634.g4ca3ef3211-goog
> > >
