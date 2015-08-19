Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:47564 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750923AbbHSCsr (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 18 Aug 2015 22:48:47 -0400
Date: Wed, 19 Aug 2015 12:48:42 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
Message-ID: <20150819024842.GI3902@dastard>
References: <1439918511-2859-1-git-send-email-zlang@redhat.com>
 <20150818222832.GF3902@dastard>
 <1350742947.10406170.1439951099309.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1350742947.10406170.1439951099309.JavaMail.zimbra@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zirong Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 18, 2015 at 10:24:59PM -0400, Zirong Lang wrote:
>=20
>=20
> ----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> > =E6=8A=84=E9=80=81: fstests@vger.kernel.org, sandeen@redhat.com
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=89, 20=
15=E5=B9=B4 8 =E6=9C=88 19=E6=97=A5 =E4=B8=8A=E5=8D=88 6:28:32
> > =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs/194: fix the exception when run o=
n 4k sector drives
> >=20
> > On Wed, Aug 19, 2015 at 01:21:51AM +0800, Zorro Lang wrote:
> > > The below command in "Test 4":
> > >=20
> > >     xfs_io -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512"
> > >=20
> > > will run failed on 4k sector drives. So I use min_alignment size
> > > to replace the hard-code 512.
> > >=20
> > > Also I make sure the blksize won't less than min_alignment size,
> > > after blksize=3D`expr $pgsize / 8`.
> > >=20
> > > If blksize really less than min_alignment size, I set blksize =3D
> > > min_alignment size, and for sure the consistency of test result,
> > > I repair pgsize(already not real page size) number according to
> > > the new blksize.
> > >=20
> > > Because IRIX can't use _min_dio_alignment(), so remove it from
> > > supported os list.
> >=20
> > Not true - that's what the 'feature -s' branch in
> > _min_dio_alignment() is supposed to be for. Just add another check
> > for "$HOSTOS" =3D=3D "Linux"....
>=20
> Do you mean change _min_dio_alignment() to:
> _min_dio_alignment()
> {
>     dev=3D$1
>=20
>     if [ -b "$dev" -a $HOSTOS" =3D=3D "Linux" ]; then
>         blockdev --getss $dev
>     else
>         $here/src/feature -s
>     fi
> }

Yes.

> I really don't understand why page size will be the minimum dio alignme=
nt?
> Do you mean in other OS(except linux), the sector size =3D page size?

No. It means that on other platforms the page size will be used as
alignment restrictions. If those platforms need anything different,
then they can add a similar 'elif [ "$HOSTOS" =3D=3D "foo" ];' branch in
there to call the appropriate function. You don't need to worry
about that.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
