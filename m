Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9566AC433FE
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Apr 2022 09:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiDPJXZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 16 Apr 2022 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiDPJXM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 16 Apr 2022 05:23:12 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857632AD3
        for <fstests@vger.kernel.org>; Sat, 16 Apr 2022 02:20:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r25so7232394qtp.8
        for <fstests@vger.kernel.org>; Sat, 16 Apr 2022 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ruaWyQzScXVVsPRR0xhKCUYs4l6eoP0PaQY8s2Iy+5Y=;
        b=BVTWkmNBdUkEi+P/Jf3/d8g9DSiT8Xxtc5DJGRzqQ2Zq/vpMMl2dXtUiQ+d3pYyCBR
         x93Q+ikUjt65+CctXyyywIGCN0tw37e3yQ7euQPqs7O166ONgSB4HQ4pFDEBFVwAFcFD
         svUN/5YqGUvQSmVEJeHqXPax28IBZG9hLKk53GlJQbA7+8lZ9itboBFPSK5E58H278xP
         KWZ9J/IDB1CP9pe4AKB/64aecbkp42qjSQwjuNDrngzu02nP91AgzPVTpBtjJoD6olxw
         z6DAx93CTu/LFE2B4OILe14vaB1SwJRP4qZWuUYZ07AY7DzM7XeiJcvb6QIaTxQzsual
         Pm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ruaWyQzScXVVsPRR0xhKCUYs4l6eoP0PaQY8s2Iy+5Y=;
        b=zoCnQPGzoamBcaPR+licbo3thIWW0JoFOc2XwAaERD5xxuUuLBVygwT6ht1m2MhPAK
         +ZWOI/cRIapQo9IW+N4zuL669G1ZnvPIcXB1THv4kLAQfDJJd3MTCjUsBUOGJtwSTQWy
         05kxUg1LutOPGeztWljtGhaYNiGgZufZK25du7vp8+gJyM0QpDSKK0uKvgSmh1rnjb1I
         8Tg5mJzdMiLGNGCz0U3UTA9+fBbk6g0+DQWlFPPTlFUBOh255AJJ8cEwMvik3Tu6GF4P
         w+Jx/HLTpanf1GExiXwvcZVUTRxZICcSkCQrGcNaOxz7+BVbdxd1j833lYqqO+rhV2rZ
         R8uQ==
X-Gm-Message-State: AOAM531iqBnUqFZvF/P9uYnR8YiCiLkUOGkVbghX70v2jVBjaag/H4n+
        pQ536Jp2CGLM68SsDSwxUE3EFNupUGLR4w4zMc4=
X-Google-Smtp-Source: ABdhPJyJfd1Ofbu5+ncYFY698ZAaEr9wVuf+l3YqcymX+gaDFN2dmHdCM1/A/yisWCHUqtTTDjSxFJhVI5TUNPSrCJ8=
X-Received: by 2002:ac8:5a4f:0:b0:2ed:d39b:5264 with SMTP id
 o15-20020ac85a4f000000b002edd39b5264mr1709092qta.477.1650100833958; Sat, 16
 Apr 2022 02:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220411054833.2157779-1-david@fromorbit.com> <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox> <20220413002656.GL1609613@dread.disaster.area>
 <20220414162544.kiesx5muc5ddtbzd@zlang-mailbox> <20220414191643.5udsx6kdarlumyfn@zlang-mailbox>
In-Reply-To: <20220414191643.5udsx6kdarlumyfn@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 16 Apr 2022 12:20:22 +0300
Message-ID: <CAOQ4uxhA7pnfRE6sSQkKOAJRDP1WmNWZBj7T_THQEjYrD7SaxQ@mail.gmail.com>
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
To:     Dave Chinner <david@fromorbit.com>,
        David Disseldorp <ddiss@suse.de>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 15, 2022 at 12:56 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Fri, Apr 15, 2022 at 12:25:44AM +0800, Zorro Lang wrote:
> > On Wed, Apr 13, 2022 at 10:26:56AM +1000, Dave Chinner wrote:
> > > On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> > > > On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > > > > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > > > >
> > > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > >
> > > > > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > > > > Kill them in the cleanup function so that they don't have to be
> > > > > > manually killed after interrupting the test.
> > > > > >
> > > > > > While touching the _cleanup() function, make it do everything that
> > > > > > the generic _cleanup function it overrides does and fix the
> > > > > > indenting.
> > > > > >
> > > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > > ---
> > > > > >  tests/generic/019 | 6 ++++--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/tests/generic/019 b/tests/generic/019
> > > > > > index db56dac1..cda107f4 100755
> > > > > > --- a/tests/generic/019
> > > > > > +++ b/tests/generic/019
> > > > > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > > > > >  # Override the default cleanup function.
> > > > > >  _cleanup()
> > > > > >  {
> > > > > > -    disallow_fail_make_request
> > > > > > -    rm -f $tmp.*
> > > > > > +     kill $fs_pid $fio_pid &> /dev/null
> > > > > > +     disallow_fail_make_request
> > > > > > +     cd /
> > > > > > +     rm -r -f $tmp.*
> > > > > >  }
> > > > > >
> > > > > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > > > >
> > > > > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > > > > wait, but should be fine as-is:
> > > >
> > > > I agree. Better to avoid killing other system processes. Or how about this place
> > > > does (avoid killing system useful processes):
> > > > $KILLALL_PROG -q $FSSTRESS_PROG
> > > > $KILLALL_PROG -q $FIO_PROG
> > > >
> > > > Another picky question is, do we need to use a while loop checking, until the
> > > > processes really get killed? :)
> > >
> > > Do we really need to paint the bikeshed over how best to kill a
> > > process? I don't have time to do that, this is just a drive-by fix
> > > that works for me....
> >
> > Sure Dave:) The while loop checking is a little picky, I just ask what do you think, no
> > objection if you don't like that. Due to quick cleanup and exit is a good reason too.
> >
> > I think it might be worth doing "$KILLALL_PROG -q $FSSTRESS_PROG $FIO_PROG" at least, to
> > avoid killing other processes might be useful.

That has much more likelihood to kill processes not spawn by the test
then pid wraparound.

Thanks,
Amir.

> > Or as David Disseldorp suggested "unset'ing
> > the "fs_pid" and "fio_pid" variables after the wait. If you're busy, I can help to make
> > this simple change, no push :-D
>
> Anyway, we'll change this a little bit when merge it.
>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>
> >
> > Thanks,
> > Zorro
> >
> > >
> > > -Dave.
> > > --
> > > Dave Chinner
> > > david@fromorbit.com
> > >
>
