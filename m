Received: from albireo.enyo.de ([5.158.152.32]:46278 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbeGRJYD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jul 2018 05:24:03 -0400
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: xfstests can't be installed by running make install
References: <20180715054320.GZ2234@dastard> <20180715071110.GH2830@desktop>
        <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
        <20180717033214.GJ2830@desktop> <87muupipos.fsf@mid.deneb.enyo.de>
        <20180718031515.GK4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <20180718034749.GL4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <20180718040540.GM4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <87601dhyga.fsf@mid.deneb.enyo.de>
        <20180718083126.GP4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
Date: Wed, 18 Jul 2018 10:47:09 +0200
In-Reply-To: <20180718083126.GP4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        (Zorro Lang's message of "Wed, 18 Jul 2018 16:31:26 +0800")
Message-ID: <87pnzlexrm.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>, Paul Smith <psmith@gnu.org>, bug-make@gnu.org, Jim Meyering <meyering@fb.com>, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

* Zorro Lang:

> On Wed, Jul 18, 2018 at 08:04:05AM +0200, Florian Weimer wrote:
>> * Zorro Lang:
>>=20
>> >> > > This is related to this glibc bug:
>> >> > >=20
>> >> > >   https://sourceware.org/bugzilla/show_bug.cgi?id=3D23393
>> >>=20
>>=20
>> > A stranger thing is:
>> > egrep [A-Z] match ABCD and bcd, but not match 'a'...
>>=20
>> That's the same issue as [0-9] not matching =EF=BC=99.
>>=20
>> > I already can't understand the new rules ...
>>=20
>> The range operator matches characters according to their collation
>> weight, and sincce the weight of 'a' is less than the weight of 'A',
>> 'a' is not included in the [A-Z] range.
>
> How to define/calculate the *weight* in your context? Why you say the
> weight of 'a' is less than the weight of 'A'

This is a concept from POSIX collation, based on a locale definition:

I hope this link is reasonably stable:

<http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap07.html#=
tag_07_03_02>

Basically, collation is in alternative way of sorting strings,
different from codepoint order, and it is specifically designed to
take cultural conventions into account.  Traditionally, most regular
expression range expression such as [a-z] follow collation order,
although this is not required by POSIX for non-C/non-POSIX locales.

>> This could be fixed by including all characters with the same primary
>> weight as the endpoints (so that [=C4=81-=E1=BA=91] and [a-z] would en=
d up being
>> the same).  It makes the behavior more logical, but it doesn't fix
>> existing scripts.
>
> We find that the $LANG will affect how glibc deal with the wildcard.
> We all test on LANG=3Den_US.UTF=3D8, but if I set export LANG=3DC, then
> [a-z] and [A-Z] are all as expected, and xfstests make install works.

Right, this is expected: POSIX requires the behavior you need for the
"C" locale.
