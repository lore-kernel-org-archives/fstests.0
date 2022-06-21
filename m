Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4D7C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 02:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiFUC5t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 22:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiFUC5s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 22:57:48 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466461C907
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:57:47 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id x21so3519731uat.2
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwGkr9GmfBi3FxsPVhNS3tPPFGgvRk2HpQhL9UEdY50=;
        b=pmGDkgpWMAnWo0JLKVZSmlOUuNeaCwnpyT236VsrYMS48wrOWVYoucsCkeZKV8LvEk
         MT6ojApG6p44mnyKL33gXxnjbFF3NAcx/EWT5gEjwOV23LuTLn/sIdkz9Gt2zUj5rT3K
         sUMa3+4i12C9qt/AwAc4GCTGSM8C2BxcJZNZqGvf5L+CODZRwQlDjaNFnH8D2gWzVvWe
         Pr6aeDzxLxK65hT2/8wKubdrPbI+ddrOwOb8cQgDh7H1btcw3EmGyvTByLqhz8KciQr7
         YKMP40x6aTrS0+ct1r3UKVI93rm01g1D3ZtflCvlc600J4rOnkU/XpW+23pXEG6gl12N
         YJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwGkr9GmfBi3FxsPVhNS3tPPFGgvRk2HpQhL9UEdY50=;
        b=lhSDGDHrqRN0Ril1MpDdbnigfMhaEbNdNKhBKMCboiK7/dIXs43ZAAWgSQCkXstQsa
         u0dsFUWtxXWmWD5Jnsfp3o9npueTsGDckvtRFpctbHIsTMrvQ3GzetFmp5DEO0obBVjk
         elztuqXaCPZtkW1/y6zCOWIWUlp6WXhKg0V1vKD8J6KYHjeUtBKDMHfOQmVxZ8yUHOWd
         XFrBrrzl6AaT6Gr9VY8t7FzD1UbofT6H2T7KJfwEf/WWnsuFSkLsoCvOgK/csp9LNDiJ
         mBYve64H6XkZRghqHjNVm7TSi+Nu4h1NrjugoCQTmnjVgzLqi5yfXZWhgQfFGj/+rHlY
         tiAQ==
X-Gm-Message-State: AJIora8Q4hKMyBNrR5NVvhaqInb+8vD2hCz3qWDLfP717++oclCwplbH
        UWlON9fX91ZDze9ve/eoynFS5neLrRYWSd0nu+I=
X-Google-Smtp-Source: AGRyM1u9VtRczJ462hIAdpI/MHaDhdNqIfvrMWGeD8mjklTIvbfYR/xdohqDpXBmNPGFMbFwfInsxBJR1PpU0zfnUSw=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr9133357uao.114.1655780266374; Mon, 20
 Jun 2022 19:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220619134657.1846292-1-amir73il@gmail.com> <20220619134657.1846292-3-amir73il@gmail.com>
 <20220620220614.GB1098723@dread.disaster.area>
In-Reply-To: <20220620220614.GB1098723@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jun 2022 05:57:41 +0300
Message-ID: <CAOQ4uxieK3QsifNE2sL71cT1Nsfd+8DyD8-UrnMi3uZgRDTazg@mail.gmail.com>
Subject: Re: [PATCH 2/4] fstests: make sure to unfreeze test and scratch mounts
To:     Dave Chinner <david@fromorbit.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 21, 2022 at 1:06 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sun, Jun 19, 2022 at 04:46:55PM +0300, Amir Goldstein wrote:
> > Almost all of the tests that _require_freeze() fail to unfreeze
> > scratch mount in case the test is interrupted while fs is frozen.
> >
> > Move the handling of unfreeze to generic check code.
> > For now, tests only freeze scratch fs, but to be more robust, unfreeze
> > both test and scratch fs following a call to _require_freeze().
> >
> > Tests could still hang if thier private _cleanup() routine tries
> > to modify the frozen fs or wait for a blocked process. Fix the
> > _cleanup() routine of xfs/011 to avoid that.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  check             | 14 ++++++++------
> >  common/rc         |  5 +++--
> >  tests/generic/390 |  2 --
> >  tests/xfs/011     |  2 --
> >  tests/xfs/517     |  1 -
> >  5 files changed, 11 insertions(+), 13 deletions(-)
> >
> > diff --git a/check b/check
> > index de11b37e..d6ee71aa 100755
> > --- a/check
> > +++ b/check
> > @@ -527,17 +527,21 @@ _check_filesystems()
> >  {
> >       local ret=0
> >
> > +     # Make sure both test and scratch are unfrozen post _require_freeze()
> > +     if [ -f ${RESULT_DIR}/require_freeze ]; then
> > +             xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
> > +             xfs_freeze -u "$SCRATCH_MNT" >/dev/null 2>&1
> > +     fi
>
> A test leaving a filesystem frozen on exit is a test bug. There can
> still be background test processes sitting blocked on a frozen
> filesystem when the test exits with a frozen filesystem, and that
> has the potential to cause problems in the next few operations
> because of "busy filesystem" errors trying to unmount the fs...
>
> IOWs, think this is the wrong way to address this problem. tests
> that freeze filesystems need to ensure that everything is cleaned up
> properly in the test _cleanup() function where the right thing can
> be done and blocked processes can be waited on once the fs has been
> thawed.
>

ok.

> > diff --git a/tests/generic/390 b/tests/generic/390
> > index 20c66e22..0f2b86fa 100755
> > --- a/tests/generic/390
> > +++ b/tests/generic/390
> > @@ -14,8 +14,6 @@ _begin_fstest auto freeze stress
> >  _cleanup()
> >  {
> >       cd /
> > -     # Make sure $SCRATCH_MNT is unfreezed
> > -     xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> >       rm -f $tmp.*
> >  }
>
> This test is already doing the right thing.
>
> > diff --git a/tests/xfs/011 b/tests/xfs/011
> > index d6e9099e..351a574e 100755
> > --- a/tests/xfs/011
> > +++ b/tests/xfs/011
> > @@ -17,9 +17,7 @@ _begin_fstest auto freeze log metadata quick
> >  _cleanup()
> >  {
> >       $KILLALL_PROG -9 fsstress 2>/dev/null
> > -     wait
> >       cd /
> > -     _scratch_unmount 2>/dev/null
> >       rm -f $tmp.*
> >  }
>
> This is wrong. We have to wait for background fsstress processes to
> exit, otherwise unmount can fail randomly. What it is missing is the
> thaw before killing the fsstress processes and waiting for them to
> complete.
>

I didn't remember if your position was that _cleanup()
should wait or not . I guess from your answer that you think
that it should and it makes sense to me, so  I will also fix xfs/517
to wait.

Thanks,
Amir.
