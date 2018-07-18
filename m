Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbeGRKtT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jul 2018 06:49:19 -0400
Date: Wed, 18 Jul 2018 18:12:05 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180718101205.GT4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
 <20180717033214.GJ2830@desktop>
 <87muupipos.fsf@mid.deneb.enyo.de>
 <20180718031515.GK4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180718034749.GL4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180718040540.GM4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <87601dhyga.fsf@mid.deneb.enyo.de>
 <20180718083126.GP4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <87pnzlexrm.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnzlexrm.fsf@mid.deneb.enyo.de>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: guaneryu@gmail.com, david@fromorbit.com
Cc: fstests@vger.kernel.org, Paul Smith <psmith@gnu.org>, bug-make@gnu.org, Jim Meyering <meyering@fb.com>, fw@deneb.enyo.de
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 18, 2018 at 10:47:09AM +0200, Florian Weimer wrote:
> * Zorro Lang:
>=20
> > On Wed, Jul 18, 2018 at 08:04:05AM +0200, Florian Weimer wrote:
> >> * Zorro Lang:
> >>=20
> >> >> > > This is related to this glibc bug:
> >> >> > >=20
> >> >> > >   https://sourceware.org/bugzilla/show_bug.cgi?id=3D23393
> >> >>=20
> >>=20
> >> > A stranger thing is:
> >> > egrep [A-Z] match ABCD and bcd, but not match 'a'...
> >>=20
> >> That's the same issue as [0-9] not matching =EF=BC=99.
> >>=20
> >> > I already can't understand the new rules ...
> >>=20
> >> The range operator matches characters according to their collation
> >> weight, and sincce the weight of 'a' is less than the weight of 'A',
> >> 'a' is not included in the [A-Z] range.
> >
> > How to define/calculate the *weight* in your context? Why you say the
> > weight of 'a' is less than the weight of 'A'
>=20
> This is a concept from POSIX collation, based on a locale definition:
>=20
> I hope this link is reasonably stable:
>=20
> <http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap07.htm=
l#tag_07_03_02>
>=20
> Basically, collation is in alternative way of sorting strings,
> different from codepoint order, and it is specifically designed to
> take cultural conventions into account.  Traditionally, most regular
> expression range expression such as [a-z] follow collation order,
> although this is not required by POSIX for non-C/non-POSIX locales.
>=20
> >> This could be fixed by including all characters with the same primar=
y
> >> weight as the endpoints (so that [=C4=81-=E1=BA=91] and [a-z] would =
end up being
> >> the same).  It makes the behavior more logical, but it doesn't fix
> >> existing scripts.
> >
> > We find that the $LANG will affect how glibc deal with the wildcard.
> > We all test on LANG=3Den_US.UTF=3D8, but if I set export LANG=3DC, th=
en
> > [a-z] and [A-Z] are all as expected, and xfstests make install works.
>=20
> Right, this is expected: POSIX requires the behavior you need for the
> "C" locale.

I was trying to change all these things to [:digit:], [:lower:], [:upper:=
],
[:alpha:] and [:alnum:]. But there're many, and the worse thing is there'=
re
many things like [1-9], [3-8], [1-9a-f], [0-9a-f-] etc...

So I have to stop, and think about if there's a better way? How about we
fix the Makefile issue by change [a-z] to [[:lower:]], then export LANG=3D=
C
in xfstests/check file, and recommand export it in local.file?

Please tell me, if you have better idea.

Thanks so much,
Zorro

> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
