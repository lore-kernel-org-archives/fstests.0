Received: from mx1.redhat.com ([209.132.183.28]:33358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeGRJIO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jul 2018 05:08:14 -0400
Date: Wed, 18 Jul 2018 16:31:26 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180718083126.GP4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180715054320.GZ2234@dastard>
 <20180715071110.GH2830@desktop>
 <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
 <20180717033214.GJ2830@desktop>
 <87muupipos.fsf@mid.deneb.enyo.de>
 <20180718031515.GK4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180718034749.GL4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180718040540.GM4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <87601dhyga.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87601dhyga.fsf@mid.deneb.enyo.de>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Florian Weimer <fw@deneb.enyo.de>
Cc: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>, Paul Smith <psmith@gnu.org>, bug-make@gnu.org, Jim Meyering <meyering@fb.com>, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 18, 2018 at 08:04:05AM +0200, Florian Weimer wrote:
> * Zorro Lang:
>=20
> >> > > This is related to this glibc bug:
> >> > >=20
> >> > >   https://sourceware.org/bugzilla/show_bug.cgi?id=3D23393
> >>=20
>=20
> > A stranger thing is:
> > egrep [A-Z] match ABCD and bcd, but not match 'a'...
>=20
> That's the same issue as [0-9] not matching =EF=BC=99.
>=20
> > I already can't understand the new rules ...
>=20
> The range operator matches characters according to their collation
> weight, and sincce the weight of 'a' is less than the weight of 'A',
> 'a' is not included in the [A-Z] range.

How to define/calculate the *weight* in your context? Why you say the
weight of 'a' is less than the weight of 'A'

>=20
> This could be fixed by including all characters with the same primary
> weight as the endpoints (so that [=C4=81-=E1=BA=91] and [a-z] would end=
 up being
> the same).  It makes the behavior more logical, but it doesn't fix
> existing scripts.

We find that the $LANG will affect how glibc deal with the wildcard.
We all test on LANG=3Den_US.UTF=3D8, but if I set export LANG=3DC, then
[a-z] and [A-Z] are all as expected, and xfstests make install works.

Thanks,
Zorro

> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
