Received: from mx4-phx2.redhat.com ([209.132.183.25]:38630 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948016AbcBSPGe convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 19 Feb 2016 10:06:34 -0500
Date: Fri, 19 Feb 2016 10:06:32 -0500 (EST)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <340759829.19718794.1455894392526.JavaMail.zimbra@redhat.com>
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
> =20
>=20
> Can you see if you can reproduce it?

Hi Dave,

Thanks for review this patch:)

I can't reproduce that problem. It shows xfs_quota report one more strang=
e
line, I can't sure what cause it by read xfs/133.

xfs/133 only set one project quota for 123456-project, I don't think it w=
ill
report one more project quota message.

I can add 'grep 123456-project' to make sure it will only report 123456-p=
roject.
But I can't do that before I sure that problem you met is not a xfsprogs =
bug.

So would you please give me more information about your test environment,=
 especially
about xfs project quota?

I will do more exception test, try to reproduce it.

Thanks,
Zorro Lang



>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>=20
