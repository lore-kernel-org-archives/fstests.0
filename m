Received: from mail-yw1-f66.google.com ([209.85.161.66]:45218 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLCJXG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Dec 2018 04:23:06 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so5082442ywd.12
        for <fstests@vger.kernel.org>; Mon, 03 Dec 2018 01:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20181203064256.26768-1-david@fromorbit.com> <20181203064256.26768-4-david@fromorbit.com>
 <CAOQ4uxgddSnVGC6+JmpiseAGKcKVjSq6nYOD4tAMUx5y8Yx3XA@mail.gmail.com> <20181203081743.GX19305@dastard>
In-Reply-To: <20181203081743.GX19305@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Dec 2018 11:22:41 +0200
Message-ID: <CAOQ4uxjhADY2Eb8+ubcs-F5xqJvHptQyx0W0=Dfa=oUodsbWxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] generic: copy_file_range bounds test
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>, Olga Kornievskaia <kolga@netapp.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 3, 2018 at 10:17 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Dec 03, 2018 at 09:25:19AM +0200, Amir Goldstein wrote:
> > On Mon, Dec 3, 2018 at 8:43 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > From: Dave Chinner <dchinner@redhat.com>
> > >
> > > Test that copy_file_range will return the correct errors for various
> > > error conditions and boundary constraints.
> ....
> >
> > All the test cases above check for bugs, which I presume your kernel patch
> > series is aimed at fixing(?)
>
> Yes. Document the API (I have a man page patch) write the tests to
> exercise correct API behaviour (these patches), fix the API
> implementation until the tests start passing (still to be posted as
> I wait for these to hit mailing list archives so I can point at
> them).
>
> > This one last test case tests for new functionality that is not
> > currently available
> > for any filesystem in upstream kernel.
>
> Yup.
>
> > Does your kernel patch set also add this functionality to xfs? to generic?
>
> Yes and yes. overlay works, too, but I gave up caring about it
> because it doesn't support the ioctls xfs_io uses in this test to
> change open file state....

Oh, not a problem. I can add FS_IOC_FS[SG]ETXATTR
to the overlayfs white list of ioctls.

That raises the issue that the test is missing:

_require_xfs_io_command "chattr" "-i"

and the chattr -i in cleanup().

>
> > IMO, it would be better to split this test case for new functionality to a new
> > test, so that this one can pass on stable kernels once all the bug
> > fixes have been
> > applied.
>
> Whatever. I'm tired, I've already put in 13 hours on this today and
> I'm on the back of four 100+ hour weeks working on nothing but this
> broken heap of crap.
>
> Take it or leave it, because I'm just about burnt out on this
> right now...
>

I hear you.

I personally have no problem with declaring the cross fs copy_range an
interface bug fix that can also go to stable. It's probably going to be harder
to get your interface fixes without it.

I will leave the call about insisting on separate test to Eryu.
If you want me to submit that separate test, I can do that.

Thanks,
Amir.
