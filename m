Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:45111 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729907AbeGQXdV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Jul 2018 19:33:21 -0400
Date: Wed, 18 Jul 2018 08:58:01 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180717225801.GA19934@dastard>
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180711163921.GI2780@desktop>
 <20180715054320.GZ2234@dastard>
 <20180715071110.GH2830@desktop>
 <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
 <20180717033214.GJ2830@desktop>
 <87muupipos.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87muupipos.fsf@mid.deneb.enyo.de>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Eryu Guan <guaneryu@gmail.com>, Paul Smith <psmith@gnu.org>, Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, bug-make@gnu.org, Jim Meyering <meyering@fb.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 17, 2018 at 10:15:47PM +0200, Florian Weimer wrote:
> * Eryu Guan:
>=20
> > This problem here doesn't seem the same as the bug above, Fedora 28 h=
as
> > glibc-2.27, which contains the fix for above bug, and the bug is abou=
t
> > trailing "/". But the problem here is we're asking for all lower case
> > filenames but wildcard returns upper case names too. e.g.
> >
> > [root@fedoravm tmp]# pwd
> > /root/tmp
> > [root@fedoravm tmp]# ls -l
> > total 4
> > -rw-r--r--. 1 root root   0 Jul 17 10:51 aaa
> > -rw-r--r--. 1 root root   0 Jul 17 10:51 AAA
> > -rw-r--r--. 1 root root 273 Jul 17 10:50 Makefile
> > drwxr-xr-x. 1 root root   0 Jul 15 14:59 testdir
> > [root@fedoravm tmp]# cat Makefile
> > STRING1 =3D $(wildcard $(CURDIR)/[a-z]*/)
> > STRING2 =3D $(wildcard ./[a-z]*/)
> > STRING3 =3D $(wildcard $(CURDIR)/[a-z]*/.)
> > STRING4 =3D $(wildcard $(CURDIR)/[a-z]*)
> > default:
> >         @echo STRING1=3D"$(STRING1)"
> >         @echo STRING2=3D"$(STRING2)"
> >         @echo STRING3=3D"$(STRING3)"
> >         @echo STRING4=3D"$(STRING4)"
> > [root@fedoravm tmp]# make
> > STRING1=3D/root/tmp/aaa /root/tmp/AAA /root/tmp/testdir/ /root/tmp/Ma=
kefile
> > STRING2=3D./aaa ./AAA ./testdir/ ./Makefile
> > STRING3=3D/root/tmp/testdir/.
> > STRING4=3D/root/tmp/aaa /root/tmp/AAA /root/tmp/testdir /root/tmp/Mak=
efile
> > [root@fedoravm tmp]#
> >
> > STRING4 is asking for all lower file names, but both "AAA" and
> > "Makefile" are returned.
>=20
> This is related to this glibc bug:
>=20
>   https://sourceware.org/bugzilla/show_bug.cgi?id=3D23393
>=20
> The bug mentions the regular expression [0-9], but it also affects
> patterns like [a-z].  I have not yet looked at fnmatch and glob in
> detail, but based on the report here (and a quick test with =E2=80=9Cec=
ho
> [a-z]*=E2=80=9D), they are affected by the same issue.
>=20
> This is ultimately caused by a locale data update which was backported
> into Fedora 28 (glibc 2.27) and its derivatives.  Upstream glibc only
> has this change for version 2.28 (not yet released).  It's currently
> not considered a release blocker, if it's even considered a bug at
> all.

So what you are saying (i.e. "not a bug") is that we should expect
widespread regex breakage in custom scripts when distros roll out
glibc 2.28 because it will break assumptions people have coded into
their scripts and custom code for the past 20+ years?

That sounds like fun. :/

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
