Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbeGREXk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jul 2018 00:23:40 -0400
Date: Wed, 18 Jul 2018 11:47:49 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180718034749.GL4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180711163921.GI2780@desktop>
 <20180715054320.GZ2234@dastard>
 <20180715071110.GH2830@desktop>
 <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
 <20180717033214.GJ2830@desktop>
 <87muupipos.fsf@mid.deneb.enyo.de>
 <20180718031515.GK4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
In-Reply-To: <20180718031515.GK4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Eryu Guan <guaneryu@gmail.com>, Paul Smith <psmith@gnu.org>, bug-make@gnu.org, Jim Meyering <meyering@fb.com>, david@fromorbit.com, fw@deneb.enyo.de
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 18, 2018 at 11:15:15AM +0800, Zorro Lang wrote:
> On Tue, Jul 17, 2018 at 10:15:47PM +0200, Florian Weimer wrote:
> > * Eryu Guan:
> >=20
> > > This problem here doesn't seem the same as the bug above, Fedora 28=
 has
> > > glibc-2.27, which contains the fix for above bug, and the bug is ab=
out
> > > trailing "/". But the problem here is we're asking for all lower ca=
se
> > > filenames but wildcard returns upper case names too. e.g.
> > >
> > > [root@fedoravm tmp]# pwd
> > > /root/tmp
> > > [root@fedoravm tmp]# ls -l
> > > total 4
> > > -rw-r--r--. 1 root root   0 Jul 17 10:51 aaa
> > > -rw-r--r--. 1 root root   0 Jul 17 10:51 AAA
> > > -rw-r--r--. 1 root root 273 Jul 17 10:50 Makefile
> > > drwxr-xr-x. 1 root root   0 Jul 15 14:59 testdir
> > > [root@fedoravm tmp]# cat Makefile
> > > STRING1 =3D $(wildcard $(CURDIR)/[a-z]*/)
> > > STRING2 =3D $(wildcard ./[a-z]*/)
> > > STRING3 =3D $(wildcard $(CURDIR)/[a-z]*/.)
> > > STRING4 =3D $(wildcard $(CURDIR)/[a-z]*)
> > > default:
> > >         @echo STRING1=3D"$(STRING1)"
> > >         @echo STRING2=3D"$(STRING2)"
> > >         @echo STRING3=3D"$(STRING3)"
> > >         @echo STRING4=3D"$(STRING4)"
> > > [root@fedoravm tmp]# make
> > > STRING1=3D/root/tmp/aaa /root/tmp/AAA /root/tmp/testdir/ /root/tmp/=
Makefile
> > > STRING2=3D./aaa ./AAA ./testdir/ ./Makefile
> > > STRING3=3D/root/tmp/testdir/.
> > > STRING4=3D/root/tmp/aaa /root/tmp/AAA /root/tmp/testdir /root/tmp/M=
akefile
> > > [root@fedoravm tmp]#
> > >
> > > STRING4 is asking for all lower file names, but both "AAA" and
> > > "Makefile" are returned.
> >=20
> > This is related to this glibc bug:
> >=20
> >   https://sourceware.org/bugzilla/show_bug.cgi?id=3D23393

Hi Florian,

Sorry I just saw your internal reply in Red Hat. If you'd like to talk
about this issue at here, I have to say this change is radical.

Before, we can do this:
# echo abcd > testfile
# echo ABCD >> testfile
# egrep  [a-z] testfile
abcd

But now it becomes this suddently:
# echo abcd > testfile
# echo ABCD >> testfile
# egrep  [a-z] testfile
abcd
ABCD

I'm afraid that we will get many complaints from customers ... And of
course it will break many cases and tools.

Thanks,
Zorro

> >=20
> > The bug mentions the regular expression [0-9], but it also affects
> > patterns like [a-z].  I have not yet looked at fnmatch and glob in
> > detail, but based on the report here (and a quick test with =A1=B0ech=
o
> > [a-z]*=A1=B1), they are affected by the same issue.
> >=20
> > This is ultimately caused by a locale data update which was backporte=
d
> > into Fedora 28 (glibc 2.27) and its derivatives.  Upstream glibc only
> > has this change for version 2.28 (not yet released).  It's currently
> > not considered a release blocker, if it's even considered a bug at
> > all.
> >=20
> > I dimly recall earlier discussions regarding this matter quite some
> > time ago, perhaps in the POSIX context.  GNU grep appears to have a
> > workaround for [0-9], but not [a-z].  Cc:ing Jim Meyering in case he
> > has any insights.
>=20
> JFYI:
>=20
> I reported this bug to glibc bugzilla too, and I got some responses
> as below:
> https://sourceware.org/bugzilla/show_bug.cgi?id=3D23420#c1
>=20
> Hmm... is Fedora glibc much different with upstream ... Need more
> investigate.
>=20
> Thanks,
> Zorro
>=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
