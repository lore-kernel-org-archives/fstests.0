Received: from mail-yw1-f65.google.com ([209.85.161.65]:35586 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfEMGDR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 May 2019 02:03:17 -0400
Received: by mail-yw1-f65.google.com with SMTP id n188so10105993ywe.2
        for <fstests@vger.kernel.org>; Sun, 12 May 2019 23:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181203064256.26768-1-david@fromorbit.com> <20181203064256.26768-4-david@fromorbit.com>
 <CAOQ4uxgddSnVGC6+JmpiseAGKcKVjSq6nYOD4tAMUx5y8Yx3XA@mail.gmail.com>
 <20181203081743.GX19305@dastard> <CAOQ4uxjhADY2Eb8+ubcs-F5xqJvHptQyx0W0=Dfa=oUodsbWxA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjhADY2Eb8+ubcs-F5xqJvHptQyx0W0=Dfa=oUodsbWxA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 May 2019 09:03:05 +0300
Message-ID: <CAOQ4uxhzOK-5UecV8fJsYrzW=6Re445XJixSOHHaB2xY8EFrng@mail.gmail.com>
Subject: Re: [PATCH 3/3] generic: copy_file_range bounds test
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>, Olga Kornievskaia <kolga@netapp.com>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 3, 2018 at 11:22 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 3, 2018 at 10:17 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Dec 03, 2018 at 09:25:19AM +0200, Amir Goldstein wrote:
> > > On Mon, Dec 3, 2018 at 8:43 AM Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > >
> > > > Test that copy_file_range will return the correct errors for various
> > > > error conditions and boundary constraints.
> > ....
> > >
> > > All the test cases above check for bugs, which I presume your kernel patch
> > > series is aimed at fixing(?)
> >
> > Yes. Document the API (I have a man page patch) write the tests to
> > exercise correct API behaviour (these patches), fix the API
> > implementation until the tests start passing (still to be posted as
> > I wait for these to hit mailing list archives so I can point at
> > them).
> >
> > > This one last test case tests for new functionality that is not
> > > currently available
> > > for any filesystem in upstream kernel.
> >
> > Yup.
> >
> > > Does your kernel patch set also add this functionality to xfs? to generic?
> >
> > Yes and yes. overlay works, too, but I gave up caring about it
> > because it doesn't support the ioctls xfs_io uses in this test to
> > change open file state....
>
> Oh, not a problem. I can add FS_IOC_FS[SG]ETXATTR
> to the overlayfs white list of ioctls.
>
> That raises the issue that the test is missing:
>
> _require_xfs_io_command "chattr" "-i"
>
> and the chattr -i in cleanup().
>
> >
> > > IMO, it would be better to split this test case for new functionality to a new
> > > test, so that this one can pass on stable kernels once all the bug
> > > fixes have been
> > > applied.
> >
> > Whatever. I'm tired, I've already put in 13 hours on this today and
> > I'm on the back of four 100+ hour weeks working on nothing but this
> > broken heap of crap.
> >
> > Take it or leave it, because I'm just about burnt out on this
> > right now...
> >
>
> I hear you.
>
> I personally have no problem with declaring the cross fs copy_range an
> interface bug fix that can also go to stable. It's probably going to be harder
> to get your interface fixes without it.
>
> I will leave the call about insisting on separate test to Eryu.
> If you want me to submit that separate test, I can do that.
>

Getting back to this (how time flies...)

Dave, if you don't mind I am going to re-post your tests splitting the
cross device copy test, since Darrick also echoed this request.

Cheers,
Amir.
