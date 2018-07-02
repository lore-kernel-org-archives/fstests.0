Received: from mail-wm0-f68.google.com ([74.125.82.68]:34874 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGBIS0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Jul 2018 04:18:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id z137-v6so7721962wmc.0
        for <fstests@vger.kernel.org>; Mon, 02 Jul 2018 01:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <5b38d22b.1c69fb81.4b6b6.8ebb@mx.google.com> <20180702022054.GU4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <CALS+E5C6RZgyb7+1ZBg6B=GVMfs=M-rEP7MZJc6+WsdMBsCgWg@mail.gmail.com>
 <20180702071957.GY2780@desktop> <CAOQ4uxhbOq_J1RL=iKhmcWqfo=Fz5CJXqHmeakw-vqMfUqCoag@mail.gmail.com>
In-Reply-To: <CAOQ4uxhbOq_J1RL=iKhmcWqfo=Fz5CJXqHmeakw-vqMfUqCoag@mail.gmail.com>
From: Lu Fengqi <curiouslfq@gmail.com>
Date: Mon, 2 Jul 2018 16:18:12 +0800
Message-ID: <CALS+E5CyXe3S5kjd61-eefj8xAzzogX7g5xx5-pN67V0jLQzZw@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 42b851446ff1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: amir73il@gmail.com
Cc: guaneryu@gmail.com, zlang@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Amir Goldstein <amir73il@gmail.com> =E4=BA=8E2018=E5=B9=B47=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 2, 2018 at 10:19 AM, Eryu Guan <guaneryu@gmail.com> wrote:
> > On Mon, Jul 02, 2018 at 10:42:19AM +0800, Lu Fengqi wrote:
> >> Zorro Lang <zlang@redhat.com> =E4=BA=8E2018=E5=B9=B47=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:25=E5=86=99=E9=81=93=EF=BC=9A
> >> >
> >> > On Sun, Jul 01, 2018 at 09:07:51PM +0800, Eryu Guan wrote:
> >> > > Hi all,
> >> > >
> >> > > The master branch of the xfstests repository at:
> >> > >
> >> > >       git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> >> > >
> >> > > have just been updated. This update contains 8 new tests mainly fo=
r xfs and
> >> > > btrfs, but they all should pass with latest Linus tree. Others are=
 random
> >> > > updates including license update to src/log-writes/* and fixes to =
build
> >> > > infrastructure.
> >> > >
> >> > > Thanks,
> >> > > Eryu
> >> > >
> >> > > The new head of the master branch is commit:
> >> > >
> >> > > 42b851446ff1 build: remove <attr/xattr.h> check
> >> > >
> >> > > New commits:
> >> > >
> >> > > Darrick J. Wong (2):
> >> > >       [e04c7b7e3021] xfs/365: fuzz inobt in ag 1
> >> > >       [494b07e34015] xfs: regression test for rmapbt fdblocks acco=
unting problems
> >> > >
> >> > > Filipe Manana (1):
> >> > >       [89ee377df5f2] btrfs: test power failure while qgroups resca=
n is in progress
> >> > >
> >> > > Josef Bacik (1):
> >> > >       [a0f89557ca46] fstests: add SPDX license comments for src/lo=
g-writes/*
> >> > >
> >> > > Lu Fengqi (3):
> >> > >       [d61c29d32fab] fsstress: remove include <attr/xattr.h>
> >> > >       [652fda3ee172] src/t_immutable: use sys/xattr.h instead of a=
ttr/xattr.h
> >> > >       [42b851446ff1] build: remove <attr/xattr.h> check
> >> >
> >> > The current xfstests-dev always fails on building time:
> >> >
> >> > configure.ac:56: error: possibly undefined macro: AC_PACKAGE_NEED_GE=
TXATTR_LIBATTR
> >> >       If this token and others are legitimate, please use m4_pattern=
_allow.
> >> >       See the Autoconf documentation.
> >> > make: *** [configure] Error 1
> >> >
> >> > After reverting "[42b851446ff1] build: remove <attr/xattr.h> check",=
 everything
> >> > goes well.
> >> >
> >> > Is there following fix about this? Or did I do something wrong?
> >
> > That's weird, I didn't see compiling errors in my release testing on an=
y
> > of the three distros I tested (CentOS7.4, Debian sid and Fedora 28). Bu=
t
> > now I did see the errors..
> >
>
> My experience is that 'make' failed but 'make clean; make' did fine.
>
The btrfs-progs have the following targets to check build infrastructure,
may we create the similar target for xfstests?

test-build: test-build-pre test-build-real

test-build-pre:
        $(MAKE) $(MAKEOPTS) clean-all
        ./autogen.sh
        ./configure

test-build-real:
        $(MAKE) $(MAKEOPTS) library-test
        -$(MAKE) $(MAKEOPTS) library-test.static
        $(MAKE) $(MAKEOPTS) -j 8 all
        -$(MAKE) $(MAKEOPTS) -j 8 static
        $(MAKE) $(MAKEOPTS) -j 8 $(progs_extra)
-------------------------------------------------------------
Thanks,
Lu

> Thanks,
> Amir.
