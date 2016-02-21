Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:54108 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759901AbcBUATc (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 20 Feb 2016 19:19:32 -0500
Date: Sun, 21 Feb 2016 11:18:39 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: change return value check to golden image check
Message-ID: <20160221001839.GY14668@dastard>
References: <1455208656-16637-1-git-send-email-zlang@redhat.com>
 <20160219013316.GW14668@dastard>
 <340759829.19718794.1455894392526.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <340759829.19718794.1455894392526.JavaMail.zimbra@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zirong Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 19, 2016 at 10:06:32AM -0500, Zirong Lang wrote:
>=20
>=20
> ----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> > =E6=8A=84=E9=80=81: fstests@vger.kernel.org, eguan@redhat.com
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=BA=94, 20=
16=E5=B9=B4 2 =E6=9C=88 19=E6=97=A5 =E4=B8=8A=E5=8D=88 9:33:16
> > =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs: change return value check to gol=
den image check
> >=20
> > On Fri, Feb 12, 2016 at 12:37:36AM +0800, Zorro Lang wrote:
> > > xfs/133 and xfs/138 use too much code to do "return value" check,
> > > it's not necessary. For the code can be more readable and clear,
> > > I change "return value" check to golden image check.
> > >=20
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >  tests/xfs/133     | 20 +++++++-------------
> > >  tests/xfs/133.out |  7 +++++++
> > >  tests/xfs/138     | 26 ++++++++++++--------------
> > >  tests/xfs/138.out | 12 ++++++++++++
> > >  4 files changed, 38 insertions(+), 27 deletions(-)
> >=20
> > This cause a xfs/133 failure like this on my systems:
> >=20
> > --- tests/xfs/133.out   2016-02-19 10:40:57.043131919 +1100
> > +++ /home/dave/src/xfstests-dev/results//xfs/xfs/133.out.bad    2016-=
02-19
> > 12:24:53.173589432 +1100
> > @@ -4,5 +4,6 @@
> >  Filesystem Blocks Quota Limit Warn/Time Mounted on
> >  SCRATCH_DEV 0 102400 204800 00 [--------] SCRATCH_MNT
> >  =3D=3D=3D report command output =3D=3D=3D
> > +(null) 0 0 0 00 [--------]
> >  123456-project 0 102400 204800 00 [--------]
> > =20
> >=20
> > Can you see if you can reproduce it?
>=20
> Hi Dave,
>=20
> Thanks for review this patch:)
>=20
> I can't reproduce that problem. It shows xfs_quota report one more stra=
nge
> line, I can't sure what cause it by read xfs/133.
>=20
> xfs/133 only set one project quota for 123456-project, I don't think it=
 will
> report one more project quota message.

I suspect it is the default quota limit changes that are causing
this, causing a dquot for project ID 0 to be created.

> I can add 'grep 123456-project' to make sure it will only report 123456=
-project.
> But I can't do that before I sure that problem you met is not a xfsprog=
s bug.
>=20
> So would you please give me more information about your test environmen=
t, especially
> about xfs project quota?

Everything is at current top of tree.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
