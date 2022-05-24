Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C0BC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 12:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiEXM5w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 08:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbiEXM4C (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 08:56:02 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260FE91553
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:56:00 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id r84so3498304qke.10
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fRjmYA90cJWPl+LTv/ewiTdt6Z2MzN3bt4ZuYtCAeQ=;
        b=DGZAeXrj02/k56qi+P8Tdee05oWeSFcDNKIK/rUT7E8zsFOmrMVJD3A8gGkuR1PpCY
         twhNG9VBKFungKw6vc/AOMBbUUZfnlndYUSeSQFnGzSxvZrII4Jh0zm9rzUe65o+Hqdj
         cQG11CIO/2hki3J2Yy6ucjeNa+iFtFCgm7cilhiJSlaQ4HaSwl6K5ZYyyarfYUkq6lTk
         /0SxzPZwpl7BgKa2Ini9JaVqLWyJGXykibPKUBTqi/UbqYDVqwcmoRVqPTTzkVIfhULU
         um68Y2cgpDPGh27dPtfGigDe+vaPEJM9+BchGBo6ugmndN1KQlVAesmlGxpDDiRk2k3u
         +6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fRjmYA90cJWPl+LTv/ewiTdt6Z2MzN3bt4ZuYtCAeQ=;
        b=XE8j7O0DARL68TNQlItJib2wZeEACyBl9nbarcDUzjLAI2r2rcqbOzyZ4lNK3HSHM+
         F3pExlCgjv21Wigd+qsbfddyIdlQ+dfdAmZAzWwTKS0Qj6AjvF4KxHQo4sCF8B1AQ8z+
         zJ0F1WETUSVJi8L+IKrPfd8igwG1WevLgDSloG8gp0MlpvDIbkAR+Di6pzT9ODZjUrgs
         s4CPexBBNw/FrBlYcwTVzSiZqPtSDy2rbFLcYr/XUENK59JN8EaLY3d8iBI3DtjNeR+x
         iFkscn190R9qMHINWZ+OQ5csu/fzC+InPFvsE3HMgD1BSNYBMpxkHa6FuJQzdFwbHrTt
         Y5pg==
X-Gm-Message-State: AOAM530E6gQkm0gv0tUQYfyaFd6ugNYPZUl5u8F6MBPWlUfQJ36bc6TI
        9/b5wIiQ0mEbg3DbCc4JZ0N0j5l7I3nkSCK2rL118tSiKKSG9A==
X-Google-Smtp-Source: ABdhPJwYejVvyM0Yu+Oje6eYerVHMNdOH9VgHZm/V/w7N6Iy7lsIg3yYk4Hxs3zfUql0SPJALVS61w3cmPJTnom/KhI=
X-Received: by 2002:a37:9381:0:b0:69f:62c6:56a7 with SMTP id
 v123-20020a379381000000b0069f62c656a7mr17147325qkd.643.1653396959178; Tue, 24
 May 2022 05:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com> <20220524122703.GL2306852@dread.disaster.area>
In-Reply-To: <20220524122703.GL2306852@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 15:55:47 +0300
Message-ID: <CAOQ4uxifd8gee1JLG1FN9fF3aSsVeSEuxFqjAf4D8ruCciXWYg@mail.gmail.com>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> > > diff --git a/tests/xfs/008 b/tests/xfs/008
> > > index a53f6c92..5bef44bb 100755
> > > --- a/tests/xfs/008
> > > +++ b/tests/xfs/008
> > > @@ -12,13 +12,6 @@ _begin_fstest rw ioctl auto quick
> > >  status=0       # success is the default!
> > >  pgsize=`$here/src/feature -s`
> > >
> > > -# Override the default cleanup function.
> > > -_cleanup()
> > > -{
> > > -    rm -f $tmp.*
> > > -    rm -rf $TEST_DIR/randholes.$$.*
> >
> > It's fine to keep the test files behind, but maybe
> > make that change more clear in commit message
> > because it was not clear to me that there was a change of
> > behavior when I read the commit message.
> >
> > Sorry to drop this extra burden on you, but this seems
> > important to me and I cannot add this information after the fact.
>
> The  point of TEST_DIR is it gathers cruft from tests so exercises
> filesystem aging. If the file is tiny, there's no point in removing
> it - all we have to do is ensure it is removed in the test setup so
> we have known initial state. So If that's the case, I removed the
> cleanup of it altogether.
>
> Like I said, I have time to do a single classification pass across
> all these tests, but if I have to document every single little
> change I make in doing these cleanups, I'm not going to bother
> trying because it's too hard and takes too long.
>
> Do you want perfect commits or do you want better infrastructure?

I want better infrastructure.

>
> > Also, it was very hard to see in this review if the test files
> > that are not cleaned in cleanup() are cleaned in the beginning
> > of the test or if it is not important to clean them because they
> > are overwritten.
>
> All tests are required to control their initial state on the test
> device as many tests use the same file names and locations and there
> is no guarantee that the test device is clean. Hence tests must
> clean up during startup to ensure they have a known initial state
> to begin the test from.
>
> > I did my best to try and I think there is a missing cleanup of
> > ${OUTPUT_DIR} in the beginning of xfs/253.
> > Although that may already be considered a test bug, removing
> > the cleanup of ${OUTPUT_DIR} from cleanup() will expose this bug.
>
> OUTPUT_DIR="${SCRATCH_MNT}/test_${seq}"
>
> No cleanup is needed for tests that use the scratch device.
>

Ah, I missed that.

> > > diff --git a/tests/xfs/051 b/tests/xfs/051
> > > index ea70cb50..4718099d 100755
> > > --- a/tests/xfs/051
> > > +++ b/tests/xfs/051
> > > @@ -11,14 +11,13 @@
> > >  . ./common/preamble
> > >  _begin_fstest shutdown auto log metadata
> > >
> > > -# Override the default cleanup function.
> > > -_cleanup()
> > > +_fsstress_cleanup()
> > >  {
> > > -       cd /
> > > -       rm -f $tmp.*
> > >         $KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
> > > -       _scratch_unmount > /dev/null 2>&1
> > > +       wait
> >
> > All right. I see that cleanup helpers are not consistent
> > in calling wait after kill and in using SIGKILL.
> > I guess we could go either way. So be it.
>
> That's the whole point of these cleanups - they will be collapsed
> down to a single helper and then we can apply the same behaviour
> consistently across them all.

Excellent.


>
> > > diff --git a/tests/xfs/310 b/tests/xfs/310
> > > index 3214e04b..c635b39a 100755
> > > --- a/tests/xfs/310
> > > +++ b/tests/xfs/310
> > > @@ -9,14 +9,12 @@
> > >  . ./common/preamble
> > >  _begin_fstest auto clone rmap
> > >
> > > -# Override the default cleanup function.
> > > -_cleanup()
> > > +_dmhuge_cleanup()
> > >  {
> > > -       cd /
> > > -       umount $SCRATCH_MNT > /dev/null 2>&1
> > >         _dmhugedisk_cleanup
> > > -       rm -rf $tmp.*
> > > +       _cleanup
> > >  }
> > > +_register_cleanup _dmhuge_cleanup
> >
> > Maybe it's just me, but if the intention is to maybe make this
> > function global someday then the difference with the name
> > _dmhugedisk_cleanup() is confusing.
>
> The names I used here are for classification, so I can grep over
> the _register_cleanup line and easily determine all the tests use
> loop devices, dmflakey, dmerror, etc and then consolidate them all
> into a single cleanup function that works for them all. This is just
> the first step in that process.
>
> > I'd rather keep the local function name local_cleanup
> > in unclear cases like this one.
>
> And that defeats the entire purpose of giving them a descriptive
> name at this point in time.

I understand. It makes a lot of sense to do that.
It is still VERY confusing that there is a helper _dmhugedisk_cleanup
that SHOULD NOT be used as a trap and a helper _dmhuge_cleanup
that SHOULD be used as a trap, so a better convention is needed.

I suggest that all consolidated helpers for trap will be called
either _cleanup_* (like cleanup_dump) or _*_cleanup (like _fsstress_cleanup)

The problem is that there is no convetion in the common/* helpers.
there are _dmhugedisk_cleanup() _dmerror_cleanup() and there are
_cleanup_dump() _cleanup_delay().

Since you already converted _cleanup_dump() to be a trap trigger itself
it looks like the easier way to go is to have _cleanup_* as the convention
to trap callbacks, which seems like the more clear choice to me.

Hence in this patch that would be _cleanup_dmhugedisk.

Thanks,
Amir.
