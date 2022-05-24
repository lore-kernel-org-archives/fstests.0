Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2C5C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 10:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiEXKCL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiEXKCL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 06:02:11 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3088C65D04
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 03:02:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id b11so5246527qvv.4
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnDBZYgQTI2NQqh7rpCD/n2/ZkmSE/TlBKu9fA+gBK0=;
        b=kRVsEbdrniZmTtQIpi2J8hea1UriFMYBy3OOqX8xMEAlifNk1O/Ki8+WkefwtoxZcO
         bXWukHMcaFW5Q+66jh++kE3OBTDgIqYnZ66FPpb87Iipkf+bM2WqL4eMNiL9vlBboMaH
         YqTMIVbISxNR24zyEe0KlyBYcez6VVgSO41kClyDsRcDgowRsdYiORnuRrpT5QbSjlHB
         d0xOpHL0q0BLxUGYzqHSvB2+jwy0pJSWQCPMayz3f3NwQCyOb4++KROyZRifAzcE5gwq
         WPWM78JLj+cID4CTCSu02Q3HbfVwdUtgE8Hx0kKjYUGEf3U49sHK6qwNFuB148moJhn5
         SImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnDBZYgQTI2NQqh7rpCD/n2/ZkmSE/TlBKu9fA+gBK0=;
        b=0J/hN3cVkww7HVkBTA/kuZkq3YvgOHR2sHIuYjMBI4YI6TaNQnHsKNrdRm6ZBv0p8g
         5S27sIrP1y1cF0ukH+YgYjJmskW9NngP3RV+md3Ks7ujvZbitFqIR1UbnAbsGG+9Slp2
         2lroDlix0fm5uZ1Dx2At0P34mN78hlYm7gTZUW6J9jgq/e48FkNN42o4+w26tMFuD4/1
         5QVkEclyhRHrnn+LOojsddiZf/lnPOt/7U+7BP9TDmltrghKBXhuRSgzMdcEIByoKsAG
         mpPeM7kLCzufL/xTU4+Lm+n9iUhz4dHrbEcWWzyJ6lCt3+ZB+8dLzp8PodIeXeehxiL8
         SxSw==
X-Gm-Message-State: AOAM531LrLb58g9oM96p+v5TF/q2eDs43r5g5qF4GQ61WpC52NbUmt9t
        2K1sP5QneI+78sMssG2pU7wGd/Gxw4UerAmdYIQ=
X-Google-Smtp-Source: ABdhPJxyA2lPnghfI7813quF9nCVqFC74+UI36FcNz+OoZRKEZ19lTfrVXIuF0Qf6zPYAoZtuD/Bvx4aAknoIoXkN3Q=
X-Received: by 2002:a05:6214:2409:b0:432:bf34:362f with SMTP id
 fv9-20020a056214240900b00432bf34362fmr20563524qvb.66.1653386528390; Tue, 24
 May 2022 03:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <CAOQ4uxi9gFQ4Zr6pfvia8WgjzyQqc2LnAwamw_XDuyR0ndGjBQ@mail.gmail.com>
 <20220524095755.GH2306852@dread.disaster.area>
In-Reply-To: <20220524095755.GH2306852@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 13:01:57 +0300
Message-ID: <CAOQ4uxga7SqYFcYWMxD8bZxrU62Lk0G_3tZLU6m7sp5VPUtzmA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fstests: _cleanup() overrides are a mess
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 12:57 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, May 24, 2022 at 11:29:17AM +0300, Amir Goldstein wrote:
> > On Tue, May 24, 2022 at 11:01 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > Hi folks,
> > >
> > > I pulled on a string a couple of days ago, and it got out of
> > > control. It all started when I went to kill a test with ctrl-c and
> > > it, once again, left background processes running that I had to hunt
> > > down and kill manually.
> > >
> > > I then started looking a why this keeps happening, and realised that
> > > the way we clean up on test completion is messy, inconsistent and
> > > frequently buggy. So I started cleaning it all up, starting with the
> > > tests/xfs directory because I saw a lot of low hanging fruit there.
> > >
> > > Essentially, we use _cleanup() functions as a way of overriding the
> > > default trap handler we install in _begin_fstest(). Rather than
> > > register a new handler, we just redefine the common cleanup function
> > > and re-implement it (poorly) in every test that does an override.
> > > Often these overrides are completely unnecessary - I think I reduced
> > > the total number of overrides in tests/xfs by ~30% (~190 -> ~125),
> > > and I reudced the number of *unique overrides by a lot more than
> > > that.
> > >
> >
> > That looks like an awesome improvement!
> >
> > > The method for overriding changes to be "stacked cleanups" rather
> > > than "duplicated cleanups". That is, tests no longer open code:
> > >
> > >         cd /
> > >         rm -rf $tmp.*
> > >
> > > THis is what common/preamble::_cleanup() does. We should call that
> > > function to do this. Hence if we have a local cleanup that we need
> > > to do, it becomes:
> > >
> > > local_cleanup()
> > > {
> > >         rm -f $testfile
> > >         _cleanup
> > > }
> > > _register_cleanup local_cleanup
> >
> > While removing boilerplate code, we had better not create another boilerplate.
> > Instead of expecting test writers to always call _cleanup
> > if we always want _cleanup to be called we can always implicitly
> > chain it in _register_cleanup():
> >
> > --- a/common/preamble
> > +++ b/common/preamble
> > @@ -20,7 +20,7 @@ _register_cleanup()
> >         shift
> >
> >         test -n "$cleanup" && cleanup="${cleanup}; "
> > -       trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
> > +       trap "${cleanup}_cleanup; exit \$status" EXIT HUP INT QUIT TERM $*
> >  }
>
> I considered that, but then I found the _no_cleanup cases. IOWs,
> this doesn't work for the cases where we want to prevent the generic
> _cleanup function from being run on failure/test exit. Hence the
> cleanup function stacking behaviour rather than unconditional
> calling of _cleanup as per above.
>

I didn't know about those.
Since you went to all this trouble to find them, can you provide a reference.
I wonder, what could ever be the reason not to want to rm $tmp.*?

Thanks,
Amir.
