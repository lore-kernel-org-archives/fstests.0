Received: from mx5-phx2.redhat.com ([209.132.183.37]:35123 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbcBSPfY convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 19 Feb 2016 10:35:24 -0500
Date: Fri, 19 Feb 2016 10:35:23 -0500 (EST)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <254524291.19728857.1455896123254.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160219013316.GW14668@dastard>
References: <1455208656-16637-1-git-send-email-zlang@redhat.com> <20160219013316.GW14668@dastard>
Subject: Re: [PATCH] xfs: change return value check to golden image check
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=8A=84=E9=80=81: fstests@vger.kernel.org, eguan@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=BA=94, 2016=
=E5=B9=B4 2 =E6=9C=88 19=E6=97=A5 =E4=B8=8A=E5=8D=88 9:33:16
> =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs: change return value check to golde=
n image check
>=20
> On Fri, Feb 12, 2016 at 12:37:36AM +0800, Zorro Lang wrote:
> > xfs/133 and xfs/138 use too much code to do "return value" check,
> > it's not necessary. For the code can be more readable and clear,
> > I change "return value" check to golden image check.
> >=20
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/133     | 20 +++++++-------------
> >  tests/xfs/133.out |  7 +++++++
> >  tests/xfs/138     | 26 ++++++++++++--------------
> >  tests/xfs/138.out | 12 ++++++++++++
> >  4 files changed, 38 insertions(+), 27 deletions(-)
>=20
> This cause a xfs/133 failure like this on my systems:
>=20
> --- tests/xfs/133.out   2016-02-19 10:40:57.043131919 +1100
> +++ /home/dave/src/xfstests-dev/results//xfs/xfs/133.out.bad    2016-02=
-19
> 12:24:53.173589432 +1100
> @@ -4,5 +4,6 @@
>  Filesystem Blocks Quota Limit Warn/Time Mounted on
>  SCRATCH_DEV 0 102400 204800 00 [--------] SCRATCH_MNT
>  =3D=3D=3D report command output =3D=3D=3D
> +(null) 0 0 0 00 [--------]
>  123456-project 0 102400 204800 00 [--------]

Wow, I reproduce this problem after I updated my xfsprogs-dev from:

12dd365 xfs_quota: modify commands which can't handle multiple types

to:

1abecda xfsprogs: Release v4.5.0-rc1

That's your newest Release recently. I need more check for this new failu=
re.

Thanks,
Zorro

> =20
>=20
> Can you see if you can reproduce it?
>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>=20
