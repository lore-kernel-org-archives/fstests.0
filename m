Received: from mx4-phx2.redhat.com ([209.132.183.25]:42443 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbbHSCZC convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 18 Aug 2015 22:25:02 -0400
Date: Tue, 18 Aug 2015 22:24:59 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <1350742947.10406170.1439951099309.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150818222832.GF3902@dastard>
References: <1439918511-2859-1-git-send-email-zlang@redhat.com> <20150818222832.GF3902@dastard>
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=8A=84=E9=80=81: fstests@vger.kernel.org, sandeen@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=89, 2015=
=E5=B9=B4 8 =E6=9C=88 19=E6=97=A5 =E4=B8=8A=E5=8D=88 6:28:32
> =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs/194: fix the exception when run on =
4k sector drives
>=20
> On Wed, Aug 19, 2015 at 01:21:51AM +0800, Zorro Lang wrote:
> > The below command in "Test 4":
> >=20
> >     xfs_io -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512"
> >=20
> > will run failed on 4k sector drives. So I use min_alignment size
> > to replace the hard-code 512.
> >=20
> > Also I make sure the blksize won't less than min_alignment size,
> > after blksize=3D`expr $pgsize / 8`.
> >=20
> > If blksize really less than min_alignment size, I set blksize =3D
> > min_alignment size, and for sure the consistency of test result,
> > I repair pgsize(already not real page size) number according to
> > the new blksize.
> >=20
> > Because IRIX can't use _min_dio_alignment(), so remove it from
> > supported os list.
>=20
> Not true - that's what the 'feature -s' branch in
> _min_dio_alignment() is supposed to be for. Just add another check
> for "$HOSTOS" =3D=3D "Linux"....

Do you mean change _min_dio_alignment() to:
_min_dio_alignment()
{
    dev=3D$1

    if [ -b "$dev" -a $HOSTOS" =3D=3D "Linux" ]; then
        blockdev --getss $dev
    else
        $here/src/feature -s
    fi
}

I really don't understand why page size will be the minimum dio alignment=
?
Do you mean in other OS(except linux), the sector size =3D page size?

Thanks,
Zorro


>=20
>=20
> > At last, make the crc flag be disabled only when blksize=3D512.
>=20
> That makes things unnecessarily complex. I'd prefer to leave it as
> it is (i.e. with -m crc=3D0), as CRCs do not affect what is being
> tested at all.

Yes, you're right:)

>=20
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/194 | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tests/xfs/194 b/tests/xfs/194
> > index e11b459..4491dd4 100755
> > --- a/tests/xfs/194
> > +++ b/tests/xfs/194
> > @@ -42,7 +42,7 @@ _cleanup()
> > =20
> >  # only xfs supported due to use of xfs_bmap
> >  _supported_fs xfs
> > -_supported_os IRIX Linux
> > +_supported_os Linux
> > =20
> >  # real QA test starts here
> >  rm -f $seqres.full
> > @@ -50,6 +50,16 @@ rm -f $seqres.full
> >  # For this test we use block size =3D 1/8 page size
> >  pgsize=3D`$here/src/feature -s`
> >  blksize=3D`expr $pgsize / 8`
> > +secsize=3D`_min_dio_alignment $SCRATCH_DEV`
> > +
> > +# The minimal blksize can't less than sector size, So if
> > +# blksize < secsize, we should adjust blksize and pgsize number.
> > +# Of course, if we adjust pgsize, pgsize won't equal to the
> > +# real page size of system.
> > +if [ $blksize -lt $secsize ];then
> > +        blksize=3D$secsize
> > +        pgsize=3D`expr $blksize \* 8`
> > +fi
>=20
> No, this is wrong. the page size stays fixed at the machine page
> size. We are testing *sub-page block sizes* here and the sector size
> must be <=3D page size. Increasing the "page size" to larger than the
> machine page size does not make the kernel use larger page sizes.
>=20
> IOWs, if you've got sector size =3D page size (e.g. 4k sector device)
> then no matter what you say $pgsize is, the kernel will see a block
> size =3D page size test.
>=20
> This whole chunk of code can simply be replaced with:
>=20
> blksize=3D`_min_dio_alignment $SCRATCH_DEV`
>=20
> Because that's what we actually need to test...
>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>=20
