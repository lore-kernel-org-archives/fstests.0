Received: from userp1040.oracle.com ([156.151.31.81]:39856 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbdHBRdl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Aug 2017 13:33:41 -0400
Date: Wed, 2 Aug 2017 10:33:34 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] generic/449: make the test effective against xfs
Message-ID: <20170802173334.GB4474@magnolia>
References: <20170801045528.GA4696@debian.home>
 <20170802041933.GB7310@debian.home>
 <20170802070030.GT9167@eguan.usersys.redhat.com>
 <20170802154808.GA1239@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170802154808.GA1239@debian.home>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Ernesto =?iso-8859-1?Q?A=2E_Fern=E1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 02, 2017 at 12:48:09PM -0300, Ernesto A. Fern=E1ndez wrote:
> On Wed, Aug 02, 2017 at 03:00:30PM +0800, Eryu Guan wrote:
> > On Wed, Aug 02, 2017 at 01:19:34AM -0300, Ernesto A. Fern=E1ndez wrot=
e:
> > > =20
> > > +# The content of this file will be used as the value of the attrib=
utes
> > > +VFILE=3D$SCRATCH_MNT/valuefile
> > > +touch $VFILE
> > > +$XFS_IO_PROG -c "pwrite -S 0x2E 0 1k" $VFILE >>$seqres.full 2>&1
> > > +
> >=20
> > I think this VFILE is not needed, because ..
> >=20
> > >  # Try to run out of space so setfacl will fail
> > >  $XFS_IO_PROG -c "pwrite 0 50m" $TFILE >>$seqres.full 2>&1
> > >  i=3D1
> > > +while $SETFATTR_PROG -n trusted.$i -v $(cat $VFILE) $TFILE &>/dev/=
null; do
> >=20
> > we can use something like $(perl -e 'print "a"x1024') to generate 1k
> > attr value.

But we can do 60x better than that on xfs, which supports 64k attr values.
ext4 is adding support for large values too.

I guess the complicated part is having to experimentally determine the
maximum attr value size for a given fs and then plugging that in... the
gains for which aren't necessarily obvious aside from reducing test runti=
me.

--D

>=20
> All right.
>=20
> > I can fix it at commit time if this looks OK to you.
>=20
> That's great, thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
