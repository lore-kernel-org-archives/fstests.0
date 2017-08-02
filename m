Received: from mail-qt0-f193.google.com ([209.85.216.193]:35913 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbdHBU7T (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Aug 2017 16:59:19 -0400
Received: by mail-qt0-f193.google.com with SMTP id c15so5818522qta.3
        for <fstests@vger.kernel.org>; Wed, 02 Aug 2017 13:59:19 -0700 (PDT)
Date: Wed, 2 Aug 2017 17:59:14 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: Re: [PATCH v2] generic/449: make the test effective against xfs
Message-ID: <20170802205913.GA1272@debian.home>
References: <20170801045528.GA4696@debian.home>
 <20170802041933.GB7310@debian.home>
 <20170802070030.GT9167@eguan.usersys.redhat.com>
 <20170802154808.GA1239@debian.home>
 <20170802173334.GB4474@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802173334.GB4474@magnolia>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 02, 2017 at 10:33:34AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 02, 2017 at 12:48:09PM -0300, Ernesto A. Fern=C3=A1ndez wro=
te:
> > On Wed, Aug 02, 2017 at 03:00:30PM +0800, Eryu Guan wrote:
> > > On Wed, Aug 02, 2017 at 01:19:34AM -0300, Ernesto A. Fern=C3=A1ndez=
 wrote:
> > > > =20
> > > > +# The content of this file will be used as the value of the attr=
ibutes
> > > > +VFILE=3D$SCRATCH_MNT/valuefile
> > > > +touch $VFILE
> > > > +$XFS_IO_PROG -c "pwrite -S 0x2E 0 1k" $VFILE >>$seqres.full 2>&1
> > > > +
> > >=20
> > > I think this VFILE is not needed, because ..
> > >=20
> > > >  # Try to run out of space so setfacl will fail
> > > >  $XFS_IO_PROG -c "pwrite 0 50m" $TFILE >>$seqres.full 2>&1
> > > >  i=3D1
> > > > +while $SETFATTR_PROG -n trusted.$i -v $(cat $VFILE) $TFILE &>/de=
v/null; do
> > >=20
> > > we can use something like $(perl -e 'print "a"x1024') to generate 1=
k
> > > attr value.
>=20
> But we can do 60x better than that on xfs, which supports 64k attr valu=
es.
> ext4 is adding support for large values too.

Thanks for bringing this up. I did know that larger attr values were
supported; I set it to 1k on purpose, as I thought that made it more
likely to work for all. There are several filesystems I have not tried
yet that will probably fail this test.

> I guess the complicated part is having to experimentally determine the
> maximum attr value size for a given fs and then plugging that in... the
> gains for which aren't necessarily obvious aside from reducing test run=
time.

In this particular test the filesystem has already been mostly filled by
xfs_io, so I don't imagine we would see a big difference in runtime. I
wouldn't go through all that trouble unless you think other tests will
benefit from this.

Another thing: right after the filesystem runs out of space for large
attribute values, the test will start to set attrs without a value until
that fails as well. Otherwise there could still be some room left for the
acls. I'm guessing that, if we used 64k values, that could leave up to 64=
k
to be filled by those attributes with no value, which could actually wors=
en
the runtime, if only a bit.

Thanks,
Ernest
