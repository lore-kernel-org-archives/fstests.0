Received: from mail-qt0-f173.google.com ([209.85.216.173]:36067 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdHBPsP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Aug 2017 11:48:15 -0400
Received: by mail-qt0-f173.google.com with SMTP id v29so29322890qtv.3
        for <fstests@vger.kernel.org>; Wed, 02 Aug 2017 08:48:14 -0700 (PDT)
Date: Wed, 2 Aug 2017 12:48:09 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: Re: [PATCH v2] generic/449: make the test effective against xfs
Message-ID: <20170802154808.GA1239@debian.home>
References: <20170801045528.GA4696@debian.home>
 <20170802041933.GB7310@debian.home>
 <20170802070030.GT9167@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802070030.GT9167@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 02, 2017 at 03:00:30PM +0800, Eryu Guan wrote:
> On Wed, Aug 02, 2017 at 01:19:34AM -0300, Ernesto A. Fern=C3=A1ndez wro=
te:
> > =20
> > +# The content of this file will be used as the value of the attribut=
es
> > +VFILE=3D$SCRATCH_MNT/valuefile
> > +touch $VFILE
> > +$XFS_IO_PROG -c "pwrite -S 0x2E 0 1k" $VFILE >>$seqres.full 2>&1
> > +
>=20
> I think this VFILE is not needed, because ..
>=20
> >  # Try to run out of space so setfacl will fail
> >  $XFS_IO_PROG -c "pwrite 0 50m" $TFILE >>$seqres.full 2>&1
> >  i=3D1
> > +while $SETFATTR_PROG -n trusted.$i -v $(cat $VFILE) $TFILE &>/dev/nu=
ll; do
>=20
> we can use something like $(perl -e 'print "a"x1024') to generate 1k
> attr value.

All right.

> I can fix it at commit time if this looks OK to you.

That's great, thanks.
