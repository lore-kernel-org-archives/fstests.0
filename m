Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:15494 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750898AbdLAVnX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Dec 2017 16:43:23 -0500
Date: Sat, 2 Dec 2017 08:43:20 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
Message-ID: <20171201214320.GU4094@dastard>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net>
 <20171201041301.GB2749@eguan.usersys.redhat.com>
 <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net>
 <CAOQ4uxgOyPy9w96_HaUtM1thHcajn1LuHkiFSOtMZw0f-=HR8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgOyPy9w96_HaUtM1thHcajn1LuHkiFSOtMZw0f-=HR8g@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chengguang Xu <cgxu@mykernel.net>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 01, 2017 at 09:21:15AM +0200, Amir Goldstein wrote:
> On Fri, Dec 1, 2017 at 8:38 AM, Chengguang Xu <cgxu@mykernel.net> wrote=
:
> >
> >> =E5=9C=A8 2017=E5=B9=B412=E6=9C=881=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=
=8812:13=EF=BC=8CEryu Guan <eguan@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Fri, Dec 01, 2017 at 12:04:44PM +0800, Chengguang Xu wrote:
> >>> Hi Eryu,
> >>>
> >>> Actually, in my another test case generic/470 will need to check wh=
ether fs supports syncfs or not.
> >>> I make shared infrastructure for checking that, and because it is c=
ommon component
> >>> I post as an individual patch instead of including in the case of g=
eneric/470.
> >>
> >> I think "_require_xfs_io_command syncfs" should be fine, there's no =
need
> >> & not encouraged to add new binary & usage like this. If you want to=
 run
> >> syncfs(2) to make sure the kernel actually supports it, you can add =
a
> >> new 'syncfs' switch case in _require_xfs_io_command.
> >>
> >
> > Failure of _require_xfs_io_command check leads to notrun, if we have =
several
> > sync patterns(combination of fsync/fdatasync/syncfs/sync) in an actua=
l test case,
> > the case will lose downward compatibility for old kernel.
> > In this situation, we have to split test case though they look simila=
r.
> >
>=20
> You have 2 options:
> Easy - split 2 tests - 1 requires syncfs and tests syncfs, 1 does not
> require and does not test syncfs
> Work - re-factor  _require_xfs_io_command to _check_xfs_io_command
> that returns the error
> message but does not _notrun. use that hepler in your test to
> conditionally test syncfs.
>=20
> Anyway, I see people are not so fond of the delalloc "canary test".
> Perhaps a still simple and quick test would be to do small buffered
> write; sync; small direct io read?

No, because the direct IO read can flush dirty buffers across the
range the IO is being done on. IOWs, you don't know if the sync
actually flushed it, the direct IO read flushed it, or the direct IO
read fell back to buffered IO and simply read the in memory copy.

Let's step back a moment: What bug/regression are you actually
trying to expose/reproduce here? Why is it not already covered by at
least one of the other generic sync/fsync tests we already have?

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
