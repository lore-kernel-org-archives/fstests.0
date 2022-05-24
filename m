Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D50C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 12:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiEXMac (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiEXMac (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 08:30:32 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C071A93981
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:30:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id l82so10184197qke.3
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+20g5xC18yXi8CalhNsCVYWeXFy2NvmI0XV8Ug50k8=;
        b=CNBoXZSWiI3RdnWrLvJSJRSc33Qadbnok8c+ZtceFg8oDg/mJA1cFYetDyttamaL6j
         aGdexGxkmlpBJ+O7C2ZQ/RcBP9n5fcs6+y8caXNKIFyFVO7p6TdH1rR5rhHGHpeBg/qu
         TcxlY7E7410Z+rfrE+6r4h6pPA6cA1DoZJ0r0z1mJTKrw0qEw3Mw70G7G+0tMTxx8H+F
         YRpZtRhCQUdrFustsgELCRTiim1qUmFxFr5Bp+uOggqvvEIh1yjYWwusX0QRtVMVPOZV
         eSCDZDiVzhJVyLsCL1+Jl7lt7woD107IyvzjyraUdOWEg2JqgfWirZ1wbDzOW6UDx/qu
         xGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+20g5xC18yXi8CalhNsCVYWeXFy2NvmI0XV8Ug50k8=;
        b=1SeLWtudrYb+SmeZx24QSLf0fojaG9pXxrza9cQwZs9D+ymKbeo0EdCrCF/Wjzu+Ad
         3XSvwobKih3lyPW6zSI8vQc7TRUwCpKQFyAHpHgyTsHtAnGp+gM21A4Xmmv3bXpr3FsW
         qdiYNNlCgMu6FF4wvngyrpzodEUdo3WCfIkOe5tdOQUMWAczKonrEWxievS9g3PX+zas
         p6F7f/zHBqwRbzc06FvXF3Yk9UfycOCat7WQ1NKpa8Rvm0ZYzdgI5xWzxi5KYNlmozrJ
         tY4KiIak4kFSLSQ9hsUGeY4CCdaX6mdoXBT18M8mlTJo1Rv7b+RISZ8yoqilYIbBJT9v
         +qNA==
X-Gm-Message-State: AOAM5306oBt9eGALmtY+rTVpuHCld+cpyQen/cnNOvP/G19pVW0JLyqe
        CcqtIIpW8VoREig28Ilwv2JZxsUwK+8VfnY4dM0=
X-Google-Smtp-Source: ABdhPJwn7lyMfXRSKkn1Mqs96Z9Hlu/nD+5PdFzYUMFKTp8KZzZYn6UeuhdSJaJrJAmFTgETZznTeu4jIIo+fhZRXWM=
X-Received: by 2002:a37:9381:0:b0:69f:62c6:56a7 with SMTP id
 v123-20020a379381000000b0069f62c656a7mr17069720qkd.643.1653395429791; Tue, 24
 May 2022 05:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-2-david@fromorbit.com>
 <CAOQ4uxhqGEYgMYGuFsFV_AtuwyJhpzRrZw2rYDo-Dn_xziOYZw@mail.gmail.com> <20220524121001.GK2306852@dread.disaster.area>
In-Reply-To: <20220524121001.GK2306852@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 15:30:18 +0300
Message-ID: <CAOQ4uxj1YptwkBRXhpsX6cCc2QSazZo9H=-HGjznCVjt0Ct76w@mail.gmail.com>
Subject: Re: [PATCH 1/8] generic/038: kill background threads on interrupt
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 3:10 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, May 24, 2022 at 12:41:25PM +0300, Amir Goldstein wrote:
> > On Tue, May 24, 2022 at 12:12 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > From: Dave Chinner <dchinner@redhat.com>
> > >
> > > When I ctrl-c g/038, it either does nothing or it leaves processes
> > > running in the background. It is not cleaning up it's background
> > > processes correctly, so add kill vectors into the cleanup. Make sure
> > > we only kill in the cleanup trap if the background processes are
> > > running.
> > >
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  tests/generic/038 | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tests/generic/038 b/tests/generic/038
> > > index c6cea94e..0462ea13 100755
> > > --- a/tests/generic/038
> > > +++ b/tests/generic/038
> > > @@ -36,6 +36,10 @@ _begin_fstest auto stress trim
> > >  # Override the default cleanup function.
> > >  _cleanup()
> > >  {
> > > +       [ -n "${create_pids}" ] && kill ${create_pids[@]}
> > > +       [ -n "${fallocate_pids}" ] && kill ${fallocate_pids[@]}
> > > +       [ -n "${trim_pids}" ] && kill ${trim_pids[@]}
> > > +       wait
> >
> > Following the pattern of recently fixed generic/019,
> > Please redirect stderr of kill to /dev/null
>
> No. Redirecting errors to /dev/null to hide them is poor behaviour
> - g/019 does not test if the pids variables are still valid even
> though they get unset. Hence the normal exit trap
> runs an empty `kill` command which outputs a help message. The
> redirect to /dev/null hides this broken behaviour - it's poor,
> buggy code, and an example how buggy and broken a lot of the cleanup
> code actually is.
>
> The code above will not run kill with an empty pid list, hence it
> should not fail when it is run. If it does fail then we've got a
> problem that needs to be captured and analysed and so redirecting
> that error to /dev/null is exactly the wrong thing to be doing.
>
> > and I think we would rather not wait in cleanup callbacks
> > which could potentially block forever?
>
> We do that in many, many tests - that's how we stop the test leaving

Yes, I've seen that.

> background processes running after the test exits. And if it hangs
> here waiting on a hung process, then as a developer using this to
> find bugs in my code, I really do want the test to hang hard so I
> notice it and can capture the failure and analyse it.

Makes sense to me, but I think the practice for cleanup should be
(like in fsstress_cleanup) to send SIGKILL and wait in case
the processes are ignoring or already handling SIGTERM.

>
> Leaving a warm corpse to post-morten is the desired behaviour of a
> failed test.
>
> > >         rm -fr $tmp
> >
> > I suppose another patch is going to replace that with the proper _cleanup()?
> > Patches from vger have been VERY slowly trickling into my mailbox.
>
> Not in this patch series. When I tackle the generic tests I'll
> address these bugs. This patch is just fixing broken ctrl-c
> behaviour.
>

Great.
So w.r.t this patch there are only minor comments of kill -9
and move unset of create_pids.
Take it or leave it, either way you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
