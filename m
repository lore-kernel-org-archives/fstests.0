Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2513FC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 12:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiEXMOy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 08:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbiEXMOx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 08:14:53 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885E093464
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:14:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 11so12288967qtp.9
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qaw3Bmer+MqNqMxBAtIHue00gmFk5XECvAMQ8MVjAZA=;
        b=qzRZdWpUSAILFPMkMp+or2Lgs1aznkT3FgaCqLhpxToT+aaEeWwV9KOWhJXJGE77bl
         zs8APAXyusolmKJ6KhMWXl0eH9RYaJK6JqDa2XQhU5ROdb25Iqu+cz/oksBXpw2TkLkV
         FIRWMO3OOJiZiLjxNcvtWBjvMFOI9a2q/+XKy0jHo8P6dZppnHcd0Dcw+wbgW0TOA1oY
         3j1dJSXay9qpw5to/EuIINhC+GDJlozYT/xlTwWztVgHRcvBECvcLRWrqYoR2v6sGQwv
         ihA/NL3BuhUXceL7KwR+am+16IdgxKEmEcfp3YpySd8zwj5Ts2wK7D4Z4c3PtEWYSDma
         jsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qaw3Bmer+MqNqMxBAtIHue00gmFk5XECvAMQ8MVjAZA=;
        b=k2VL3fVDLtScal5di1Z/pvtOwlMsBOaevKSXLM+Q1PsUhpatO0AhNhfvHCLNZ0oboM
         3z92Gg8litT30avyBcsR3MNalwmBCGiYnDl8t9W9TF6DKMY9wCgiV3dxCLPDK30WHmJx
         Q2U+TXOfBnZ7Lupz2E5AgsQawPjB34J+hV/Kpg3CwoZFDn7b6vDRGMZAT4sNBOeLDnZv
         Fql1TD920NfL5BzQIy7W0vtqu1n0yEN8xJbDLt6IcV6EAQrE5hXXG6uJX0oHQKtx/QvY
         s+9QAYEdQoyylm3lQTXVsXUiEgqohxZGP07eOc2PKSBTRHgwGuzQP4bDreobhp9uDbcF
         NKWQ==
X-Gm-Message-State: AOAM530UcNlPIsTCa+SgyiWcXg1KUODtG5aXKCMblUAH+VwJWo/F8WWp
        YokarI6QVNGw1x01yJGBM7MnzPjCKzcsEuoJGPdHiIzluVa5gA==
X-Google-Smtp-Source: ABdhPJyfnGedtSu9WeXJHk/aVM7uT9LBy6ox7ZbYUSp6lq6E9OX9QnCnWJdsJhlZiIlC5+HVNv4y2uH1Q/F5F1ZLhy8=
X-Received: by 2002:a05:622a:1a9c:b0:2f3:d873:4acc with SMTP id
 s28-20020a05622a1a9c00b002f3d8734accmr19994312qtc.424.1653394490600; Tue, 24
 May 2022 05:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <CAOQ4uxi9gFQ4Zr6pfvia8WgjzyQqc2LnAwamw_XDuyR0ndGjBQ@mail.gmail.com>
 <20220524095755.GH2306852@dread.disaster.area> <CAOQ4uxga7SqYFcYWMxD8bZxrU62Lk0G_3tZLU6m7sp5VPUtzmA@mail.gmail.com>
 <20220524101320.GJ2306852@dread.disaster.area>
In-Reply-To: <20220524101320.GJ2306852@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 15:14:39 +0300
Message-ID: <CAOQ4uxiZ3jQ7oBhAvgGexid8OT8Z223ynop7NdFGF9FRC-ueiA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fstests: _cleanup() overrides are a mess
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 1:13 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, May 24, 2022 at 01:01:57PM +0300, Amir Goldstein wrote:
> > On Tue, May 24, 2022 at 12:57 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Tue, May 24, 2022 at 11:29:17AM +0300, Amir Goldstein wrote:
> > > > On Tue, May 24, 2022 at 11:01 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > Hi folks,
> > > > >
> > > > > I pulled on a string a couple of days ago, and it got out of
> > > > > control. It all started when I went to kill a test with ctrl-c and
> > > > > it, once again, left background processes running that I had to hunt
> > > > > down and kill manually.
> > > > >
> > > > > I then started looking a why this keeps happening, and realised that
> > > > > the way we clean up on test completion is messy, inconsistent and
> > > > > frequently buggy. So I started cleaning it all up, starting with the
> > > > > tests/xfs directory because I saw a lot of low hanging fruit there.
> > > > >
> > > > > Essentially, we use _cleanup() functions as a way of overriding the
> > > > > default trap handler we install in _begin_fstest(). Rather than
> > > > > register a new handler, we just redefine the common cleanup function
> > > > > and re-implement it (poorly) in every test that does an override.
> > > > > Often these overrides are completely unnecessary - I think I reduced
> > > > > the total number of overrides in tests/xfs by ~30% (~190 -> ~125),
> > > > > and I reudced the number of *unique overrides by a lot more than
> > > > > that.
> > > > >
> > > >
> > > > That looks like an awesome improvement!
> > > >
> > > > > The method for overriding changes to be "stacked cleanups" rather
> > > > > than "duplicated cleanups". That is, tests no longer open code:
> > > > >
> > > > >         cd /
> > > > >         rm -rf $tmp.*
> > > > >
> > > > > THis is what common/preamble::_cleanup() does. We should call that
> > > > > function to do this. Hence if we have a local cleanup that we need
> > > > > to do, it becomes:
> > > > >
> > > > > local_cleanup()
> > > > > {
> > > > >         rm -f $testfile
> > > > >         _cleanup
> > > > > }
> > > > > _register_cleanup local_cleanup
> > > >
> > > > While removing boilerplate code, we had better not create another boilerplate.
> > > > Instead of expecting test writers to always call _cleanup
> > > > if we always want _cleanup to be called we can always implicitly
> > > > chain it in _register_cleanup():
> > > >
> > > > --- a/common/preamble
> > > > +++ b/common/preamble
> > > > @@ -20,7 +20,7 @@ _register_cleanup()
> > > >         shift
> > > >
> > > >         test -n "$cleanup" && cleanup="${cleanup}; "
> > > > -       trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
> > > > +       trap "${cleanup}_cleanup; exit \$status" EXIT HUP INT QUIT TERM $*
> > > >  }
> > >
> > > I considered that, but then I found the _no_cleanup cases. IOWs,
> > > this doesn't work for the cases where we want to prevent the generic
> > > _cleanup function from being run on failure/test exit. Hence the
> > > cleanup function stacking behaviour rather than unconditional
> > > calling of _cleanup as per above.
> > >
> >
> > I didn't know about those.
> > Since you went to all this trouble to find them, can you provide a reference.
> > I wonder, what could ever be the reason not to want to rm $tmp.*?
>
> [PATCH 6/8] fstests: consolidate no cleanup test setup
>

Ah I see.
It might have been better to explicitly opt-out of cleanup
only for those tests via _register_no_cleanup or _unregister_cleanup

similar to the common _require_scratch and the exceptions of
_require_scratch_nocheck

But that could be done by followup cleanup and someone has
an itch to scratch ;)

Thanks,
Amir.
