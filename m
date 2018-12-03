Received: from mail-yb1-f194.google.com ([209.85.219.194]:39867 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCNQU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Dec 2018 08:16:20 -0500
Received: by mail-yb1-f194.google.com with SMTP id w17-v6so5235229ybl.6
        for <fstests@vger.kernel.org>; Mon, 03 Dec 2018 05:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20181203064256.26768-1-david@fromorbit.com> <20181203064256.26768-4-david@fromorbit.com>
 <CAOQ4uxgddSnVGC6+JmpiseAGKcKVjSq6nYOD4tAMUx5y8Yx3XA@mail.gmail.com>
 <20181203081743.GX19305@dastard> <CAOQ4uxjhADY2Eb8+ubcs-F5xqJvHptQyx0W0=Dfa=oUodsbWxA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjhADY2Eb8+ubcs-F5xqJvHptQyx0W0=Dfa=oUodsbWxA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Dec 2018 15:15:08 +0200
Message-ID: <CAOQ4uxgUmrmMhz5UTY1cibhODPGCV_gz5qhYpZ6Szqq=0WTiFg@mail.gmail.com>
Subject: Re: [PATCH 3/3] generic: copy_file_range bounds test
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>, Olga Kornievskaia <kolga@netapp.com>
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


Hmm.
_require_xfs_io_command "chattr" "+/-x"
is documented in doc/requirement-checking.txt, but that seems like
fake news.
Nevermind. I'll add support for it after implementing
FS_IOC_FS[SG]ETXATTR for overlayfs.

> and the chattr -i in cleanup().
>

That's still important of course.


Thanks,
Amir.
