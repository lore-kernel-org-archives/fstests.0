Received: from albireo.enyo.de ([5.158.152.32]:44828 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeGRGkT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jul 2018 02:40:19 -0400
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: xfstests can't be installed by running make install
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <20180711163921.GI2780@desktop> <20180715054320.GZ2234@dastard>
        <20180715071110.GH2830@desktop>
        <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
        <20180717033214.GJ2830@desktop> <87muupipos.fsf@mid.deneb.enyo.de>
        <20180718031515.GK4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <20180718034749.GL4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <20180718040540.GM4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
Date: Wed, 18 Jul 2018 08:04:05 +0200
In-Reply-To: <20180718040540.GM4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        (Zorro Lang's message of "Wed, 18 Jul 2018 12:05:40 +0800")
Message-ID: <87601dhyga.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>, Paul Smith <psmith@gnu.org>, bug-make@gnu.org, Jim Meyering <meyering@fb.com>, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

* Zorro Lang:

>> > > This is related to this glibc bug:
>> > >=20
>> > >   https://sourceware.org/bugzilla/show_bug.cgi?id=3D23393
>>=20

> A stranger thing is:
> egrep [A-Z] match ABCD and bcd, but not match 'a'...

That's the same issue as [0-9] not matching =EF=BC=99.

> I already can't understand the new rules ...

The range operator matches characters according to their collation
weight, and sincce the weight of 'a' is less than the weight of 'A',
'a' is not included in the [A-Z] range.

This could be fixed by including all characters with the same primary
weight as the endpoints (so that [=C4=81-=E1=BA=91] and [a-z] would end u=
p being
the same).  It makes the behavior more logical, but it doesn't fix
existing scripts.
