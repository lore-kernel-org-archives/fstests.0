Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852C1CCA47F
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 04:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiFXEhH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 00:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXEhF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 00:37:05 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611F662710
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 21:37:04 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id k25so1274154vso.6
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 21:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZm/7Iwh8Qs+Tyui3O/c8yCGaWI5PyUfL6vkmYB/hRg=;
        b=X1Kc2/S3Mowu2d1x3X8zDoF3j0qdq77kkMJLtxHjKYVp7tu8GujsP6cmdpWLCdyInN
         ZifwTvEMIZHRFvrM6JRFvzfhFhK0rYImsOZ9FlrQCGle2HMysKtR9neisV7AgbS4G/dI
         rQ6IUnJ8CInh72LdRrqsiR1cjgRSk00zkiT/K6qzRFEa0DHLF8cksv4S2gVMiMqftZfy
         Uq3GrhAwJOEiJz0dlggU7cMxFDikwjw7uKj1aUHAaW57PiDUdWy3xmMJwqLyY0EuzqkD
         nGXF0hSzh3CGbYU2othBVaOiMAgYjW1DJ8rg64QXRiS7JH3+lvuf98hTXkAUuE+80QIT
         8kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZm/7Iwh8Qs+Tyui3O/c8yCGaWI5PyUfL6vkmYB/hRg=;
        b=DrXUuh0FyZy74K15iVak0NDu+/4f+ZqP6vBcVmLpFYm+GdLbCktkAxtuqjyahMi5m8
         Jf4SCsIL4t8AmoNGb3T21/DElleFooCtt3HIzvgv7sucU3dvKefRtifaQd+VjHKJFO98
         B4bTsTurQKdTxjLtcxmrlA4bR0GLzVADh1Ip7XxPbaNWZnYuDwHSSplJLGR/BN6tWwor
         soqb3wbQtYtVW3zwW++eW2/rMBL6Z1Qe0tdP3J6VhKWl1sZmerfSV89nN13fHZ+ICdiR
         BrDqajR02tHQKS4IIqXstWyelaoaDNfhOBwyh0sW33aE/i60fTafFDRT6qmvUb2eL+Qs
         0zHA==
X-Gm-Message-State: AJIora+KjnB1kXi4+ldtv45j8/RE5Vl2RUEv60QIGUYCp34FPdECDR7R
        7pBISWtTNotcVXQF9/TIAbwnPS9QBqbE9Ymanho=
X-Google-Smtp-Source: AGRyM1uReLXYTh2YcOt05gkA8bZqf+nNJeOwwo7C318R3/lpA7S43dwsVhK9vHonpKU6H1nXqx++0BNuUy8+ioIgzrI=
X-Received: by 2002:a67:fa01:0:b0:354:3136:c62e with SMTP id
 i1-20020a67fa01000000b003543136c62emr12822809vsq.2.1656045423456; Thu, 23 Jun
 2022 21:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220619134657.1846292-1-amir73il@gmail.com> <20220619134657.1846292-4-amir73il@gmail.com>
 <CAOQ4uxj350-k2bzCSD_j35XCH5E-VcdtfHmW3d_ZrSzHxWA5CQ@mail.gmail.com> <YrSrLgU1OIgaaxiB@magnolia>
In-Reply-To: <YrSrLgU1OIgaaxiB@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Jun 2022 07:36:51 +0300
Message-ID: <CAOQ4uxiyWnLFe95YXQ-xzYyK4D50-6pbqpduyZZzttvuXvVETg@mail.gmail.com>
Subject: Re: [PATCH 3/4] xfs/{422,517}: add missing killall to _cleanup()
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 23, 2022 at 9:04 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Tue, Jun 21, 2022 at 07:02:02AM +0300, Amir Goldstein wrote:
> > On Sun, Jun 19, 2022 at 4:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Those tests failed to cleanup background jobs after test
> > > is interrupted.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  tests/xfs/422 | 8 ++++++++
> > >  tests/xfs/517 | 1 +
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/tests/xfs/422 b/tests/xfs/422
> > > index a83a66df..8e9a3576 100755
> > > --- a/tests/xfs/422
> > > +++ b/tests/xfs/422
> > > @@ -13,6 +13,14 @@ _begin_fstest dangerous_scrub dangerous_online_repair freeze
> > >
> > >  _register_cleanup "_cleanup" BUS
> > >
> > > +# Override the default cleanup function.
> > > +_cleanup()
> > > +{
> > > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> > > +       cd /
> > > +       rm -rf $tmp.*
> > > +}
> > > +
> > >  # Import common functions.
> > >  . ./common/filter
> > >  . ./common/fuzzy
> > > diff --git a/tests/xfs/517 b/tests/xfs/517
> > > index 961668e3..18404248 100755
> > > --- a/tests/xfs/517
> > > +++ b/tests/xfs/517
> > > @@ -14,6 +14,7 @@ _register_cleanup "_cleanup" BUS
> > >  # Override the default cleanup function.
> > >  _cleanup()
> > >  {
> > > +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> >
> > Besides the missing wait, this cleanup is still racy, because stress_loop
> > can spawn a new fstress process after killall /proc iteration.
> >
> > Worst, freeze_loop can freeze after killall /proc iteration.
> >
> > The correct solution (I think) is to record the pid of the XXX_loop
> > sub-shells and kill those, which should also solve the "Terminated"
> > false positive error.
> >
> > Will give that a shot.
>
> FWIW I already have patches reworking 422 and all the other
> scrub-related stress tests:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=race-scrub-and-mount-state-changes
>

That looks very nice.
The cleanup looks very similar to the one I posted for v2,
but instead of "killall xfs_io fsstress" you would be better off with
"kill  $__SCRUB_STRESS_FREEZE_PID"

killing the child process and waiting for its parent bash
process has the side effect of the bash parent emitting
"Terminated" or "Killed" message with breaks golden output
if the inner loop did not already exit, which is the behavior
that got me started on doing this cleanup.

> I swear I'll send all these some day, if I ever get caught up...
> Delegating LTS maintenance is a big help, but as it is I still can't
> stay abreast of all the mainline patchsets /and/ send my own stuff. :(
>

I will respond to that in another email.

Thanks,
Amir.
