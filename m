Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D60BC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 07:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiDMHQI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 03:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiDMHQH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 03:16:07 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4AC35247
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 00:13:47 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id e22so952166qvf.9
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cO+Byhu0G7BUlPSIhFKwCZ82UaOsZif8yjZglQ39Fmw=;
        b=Ad5piIdTRI4s+cgw4MRSlTmMqcpV5mstlu1KfLS6SwyIcV5YWe3thPpp5OmBOvPOMY
         Ptq2nrvT/e9T7jWFnlq33ofN1KNpNGefVV1RVnIYdkeaREm2JRhv5z4on9vi2vRAyTbR
         n1BW/fu3V5FEN7off8r5YNzH9UgxfEcj+miTvH2efMjftcqjLnqC3OOsuImoi3rMwPX0
         2+6jLbVBhLl4fy9QHlZciNVVvwYpeArF9IpGwWf3HYUIINqPyswthAW0IY7+v/JVG/WD
         z4kHstt5Oq+dzW9G2gUKPRTM8nmYO0vQfHO/6MaMFkpAMwkKsasJTfmN8mHv/l5couXh
         RSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cO+Byhu0G7BUlPSIhFKwCZ82UaOsZif8yjZglQ39Fmw=;
        b=B2d4fV5PikFXWr8vK3I7fZW0u5d+YEA5OVilxDHULCgRSMmZ6IZ7/p+z5JrXfdzCON
         a24UXXxYySXjsdvWi6v7R/pnqlVeBx18NSQWgpWpsfSE5ltLGRYqTup0/D245AWPIG7J
         SiHyanoDFC0A+QS7uUQ4fSlw6VL+5E/gj6NAqWBKOWG5dvmRUARyQJaYPFwPvEXN28Tg
         r3Mq8aCBjbMSLuazIn3ay160u1UgyDhQWO2CPkWBI2jF1uZXQJjlDPE4WLal9DC842TL
         mT1+Tmwt8arsI3ieMXsFiIA0XEyQ149/z8FmFIfEaIfdpfNsQX7JHmUix5DesRfZGu9C
         uXlA==
X-Gm-Message-State: AOAM532d0XI9sgDd/pL9UNgGvPIwc/Rv/+Y4WWmg2ulKrGyjhYEXjeml
        UZgDHLuWaEERnP7Gq04wSrj4jSCggQ1xcuXmWUdjOKl8Fhs=
X-Google-Smtp-Source: ABdhPJz4pZ63uitj90AlIBo4oAjXVCJ3NVwliILquG3N8zSmAueOdQ3+dNqBoYOdf58IizuEC6Aw4qe23Zye2WgunoY=
X-Received: by 2002:a05:6214:1c83:b0:443:6749:51f8 with SMTP id
 ib3-20020a0562141c8300b00443674951f8mr33792184qvb.74.1649834026704; Wed, 13
 Apr 2022 00:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220411054833.2157779-1-david@fromorbit.com> <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox> <20220413002656.GL1609613@dread.disaster.area>
In-Reply-To: <20220413002656.GL1609613@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Apr 2022 10:13:35 +0300
Message-ID: <CAOQ4uxi_YY2fBTAoQz4W_jOFvySUWGG0UFhtKjptgiiM1jg7Bg@mail.gmail.com>
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
To:     Dave Chinner <david@fromorbit.com>
Cc:     David Disseldorp <ddiss@suse.de>, fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 13, 2022 at 4:53 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> > On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > >
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > >
> > > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > > Kill them in the cleanup function so that they don't have to be
> > > > manually killed after interrupting the test.
> > > >
> > > > While touching the _cleanup() function, make it do everything that
> > > > the generic _cleanup function it overrides does and fix the
> > > > indenting.
> > > >
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > ---
> > > >  tests/generic/019 | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tests/generic/019 b/tests/generic/019
> > > > index db56dac1..cda107f4 100755
> > > > --- a/tests/generic/019
> > > > +++ b/tests/generic/019
> > > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > > >  # Override the default cleanup function.
> > > >  _cleanup()
> > > >  {
> > > > -    disallow_fail_make_request
> > > > -    rm -f $tmp.*
> > > > + kill $fs_pid $fio_pid &> /dev/null
> > > > + disallow_fail_make_request
> > > > + cd /
> > > > + rm -r -f $tmp.*
> > > >  }
> > > >
> > > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > >
> > > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > > wait, but should be fine as-is:
> >
> > I agree. Better to avoid killing other system processes. Or how about this place
> > does (avoid killing system useful processes):
> > $KILLALL_PROG -q $FSSTRESS_PROG
> > $KILLALL_PROG -q $FIO_PROG
> >
> > Another picky question is, do we need to use a while loop checking, until the
> > processes really get killed? :)
>
> Do we really need to paint the bikeshed over how best to kill a
> process? I don't have time to do that, this is just a drive-by fix
> that works for me....
>

This is not a kind response to reviewers.
Does a "drive-by fix" get exempt from the review process?
The review comments are legit even if they could be dismissed
on technical grounds, because the risk of pid wraparound is quite low.

I don't think this is about "bikeshed over how best to kill a process"
I think this is about how to have better test cleanup practices.
It would have been nice to have better isolation by having fstests
run a test without a control group and cleanup the control group
processes after the test if someone wants to take on this task.

I personally prefer the pattern of dedicated cleanup trap for aborting the test
like generic/251 that leaves the generic _cleanup on EXIT instead of
duplicating _cleanup (which generic/251 also duplicate incorrectly),
but no strong feeling about that, so as a "drive-by fix" you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
