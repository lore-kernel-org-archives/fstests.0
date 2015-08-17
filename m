Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:57551 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750731AbbHQFGP (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 17 Aug 2015 01:06:15 -0400
Date: Mon, 17 Aug 2015 15:06:12 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/084: check inotify limit before tail many files
Message-ID: <20150817050612.GB714@dastard>
References: <1439482592-29611-1-git-send-email-zlang@redhat.com>
 <20150817000336.GE20596@dastard>
 <55490920.9057342.1439773519504.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55490920.9057342.1439773519504.JavaMail.zimbra@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zirong Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Sun, Aug 16, 2015 at 09:05:19PM -0400, Zirong Lang wrote:
> Hi Dave,
>=20
> Thanks for your reply.
>=20
> ----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> > =E6=8A=84=E9=80=81: fstests@vger.kernel.org, eguan@redhat.com
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=80, 20=
15=E5=B9=B4 8 =E6=9C=88 17=E6=97=A5 =E4=B8=8A=E5=8D=88 8:03:36
> > =E4=B8=BB=E9=A2=98: Re: [PATCH] generic/084: check inotify limit befo=
re tail many files
> >=20
> > On Fri, Aug 14, 2015 at 12:16:32AM +0800, Zorro Lang wrote:
> > > generic/084 try to run 'tail' command, tail will use
> > > inotify, and there're some limit about inotify. I think
> > > the most important is fs.inotify.max_user_instances, then
> > > fs.inotify.max_user_watches is importand too.
> > >
> > > When I test on a machine with 154 cpu cores, this case
> > > run failed, and hit many warning likes:
> > >=20
> > >     tail: inotify cannot be used, reverting to polling: Too many
> > >     open files
> > >=20
> > > Because the fs.inotify.max_user_instances is 128, so if
> > > we try to tail 154 files, it will be failed.
> >=20
> > We use 'tail' all over the place in xfstests, so why is only
> > generic/084 affected?
>=20
> Because generic/084 use try to create $nr_cpu tail processes:
> for i in `seq 1 $nr_cpu`; do
>     ...
>     tail -f $testfile &
>     ...
> done
>=20
> And nr_cpu=3D`$here/src/feature -o`.
>=20
> Generally fs.inotify.max_user_instances is 128, when a machine
> have more than(or nearly the same) this number, this test will
> failed.

This information should have been in the patch description - it's
concurrently run tail commands that are the problem, not a single
execution of tail...

> Maybe other cases don't try to create so many tail processes, so
> they passed.

Exactly. The answer is obvious when you explain it fully :)

So, we have other tests that use hundreds of open unlinked files and
they don't have this problem. That means the issue is how
generic/084 is creating the unlinked files, not an issue with
inotify config.

Go look at src/multi_open_unlink.c and tests/xfs/1[28]1, and then
rewrite generic/084 to use multi_open_unlink to create and hold=20
open unlinked files for a specified amount of time.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
