Received: from mail-yw1-f66.google.com ([209.85.161.66]:44116 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbeIRUvi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Sep 2018 16:51:38 -0400
Received: by mail-yw1-f66.google.com with SMTP id l9-v6so919133ywc.11
        for <fstests@vger.kernel.org>; Tue, 18 Sep 2018 08:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180918104456.12778-1-amir73il@gmail.com> <20180918142940.GA4594@magnolia>
In-Reply-To: <20180918142940.GA4594@magnolia>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 18 Sep 2018 18:18:24 +0300
Message-ID: <CAOQ4uxhE3bgE1KuFKOdPPVifjCWaZ5LmmqPJ3Ui7pDM8WaAPWw@mail.gmail.com>
Subject: Re: [PATCH][BROKEN] common/rc: fix check for disabled kmemleak
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 18, 2018 at 5:29 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Sep 18, 2018 at 01:44:56PM +0300, Amir Goldstein wrote:
> > With kernel commit b353756b2b71 ("kmemleak: always register debugfs file")
> > that was merged to v4.19-rc3, the kmemleak debugfs knob exists even if
> > kmemleak is disabled, but returns EBUSY on write.
> >
> > Suppress EBUSY errors from _check_kmemleak() by removing write permission
> > from knob on failure to initialize kmemleak.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Ewww, but I guess it works... :)
>

Ewww indeed, but what I wrote below is that it doesn't work,
but I couldn't figure out why.
In manual tests the method works, but some elusive detail
in the scripts must have escaped me and I still get some EBUSY
errors when running with this patch and kmemleak disabled.

Thanks,
Amir.

>
> --D
>
> > ---
> >
> > Guys,
> >
> > With kernel v4.19-rc3, tests started printing noisy messages about failure
> > to write to kmemleak knob.
> >
> > Problem is that kmemleak was disabled on my system but the test for
> > kmemleak enabled we have in place was broken by the kernel change.
> >
> > I tried this patch to hack around the new kernel behavior, but something
> > is broken in this patch as it doesn't suppress all errors.
> > For me, I prefer to have kmemleak enabled anyway, so I gave up on this
> > hack and enabled kmemleak.
> >
> > If someone is interested in taking over, be my guest.
> >
> > FYI, to enable kmemleak on kvm-xfstests I needed to configure
> > CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=5000
> > # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> >
> > Thanks,
> > Amir.
> >
> >  common/rc | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/rc b/common/rc
> > index ec631ad9..cafc83b4 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3514,8 +3514,14 @@ _init_kmemleak()
> >
> >       # Disable the automatic scan so that we can control it completely,
> >       # then dump all the leaks recorded so far.
> > -     echo "scan=off" > "$kern_knob"
> > -     _capture_kmemleak /dev/null
> > +     if echo "scan=off" > "$kern_knob" 2>/dev/null; then
> > +             _capture_kmemleak /dev/null
> > +     else
> > +             # Since kernel v4.19-rc3, the knob exists even if kmemleak is
> > +             # disabled, but returns EBUSY on write. Suppress EBUSY errors
> > +             # from _check_kmemleak() by removing write permission from knob
> > +             chmod a-w "$kern_knob"
> > +     fi
> >  }
> >
> >  # check kmemleak log
> > --
> > 2.17.1
> >
