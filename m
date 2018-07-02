Received: from mail-pl0-f65.google.com ([209.85.160.65]:40234 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933184AbeGBHUC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Jul 2018 03:20:02 -0400
Received: by mail-pl0-f65.google.com with SMTP id t6-v6so7504677plo.7
        for <fstests@vger.kernel.org>; Mon, 02 Jul 2018 00:20:02 -0700 (PDT)
Date: Mon, 2 Jul 2018 15:19:57 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 42b851446ff1
Message-ID: <20180702071957.GY2780@desktop>
References: <5b38d22b.1c69fb81.4b6b6.8ebb@mx.google.com>
 <20180702022054.GU4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <CALS+E5C6RZgyb7+1ZBg6B=GVMfs=M-rEP7MZJc6+WsdMBsCgWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALS+E5C6RZgyb7+1ZBg6B=GVMfs=M-rEP7MZJc6+WsdMBsCgWg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Lu Fengqi <curiouslfq@gmail.com>, zlang@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 02, 2018 at 10:42:19AM +0800, Lu Fengqi wrote:
> Zorro Lang <zlang@redhat.com> =E4=BA=8E2018=E5=B9=B47=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:25=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sun, Jul 01, 2018 at 09:07:51PM +0800, Eryu Guan wrote:
> > > Hi all,
> > >
> > > The master branch of the xfstests repository at:
> > >
> > >       git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> > > have just been updated. This update contains 8 new tests mainly for=
 xfs and
> > > btrfs, but they all should pass with latest Linus tree. Others are =
random
> > > updates including license update to src/log-writes/* and fixes to b=
uild
> > > infrastructure.
> > >
> > > Thanks,
> > > Eryu
> > >
> > > The new head of the master branch is commit:
> > >
> > > 42b851446ff1 build: remove <attr/xattr.h> check
> > >
> > > New commits:
> > >
> > > Darrick J. Wong (2):
> > >       [e04c7b7e3021] xfs/365: fuzz inobt in ag 1
> > >       [494b07e34015] xfs: regression test for rmapbt fdblocks accou=
nting problems
> > >
> > > Filipe Manana (1):
> > >       [89ee377df5f2] btrfs: test power failure while qgroups rescan=
 is in progress
> > >
> > > Josef Bacik (1):
> > >       [a0f89557ca46] fstests: add SPDX license comments for src/log=
-writes/*
> > >
> > > Lu Fengqi (3):
> > >       [d61c29d32fab] fsstress: remove include <attr/xattr.h>
> > >       [652fda3ee172] src/t_immutable: use sys/xattr.h instead of at=
tr/xattr.h
> > >       [42b851446ff1] build: remove <attr/xattr.h> check
> >
> > The current xfstests-dev always fails on building time:
> >
> > configure.ac:56: error: possibly undefined macro: AC_PACKAGE_NEED_GET=
XATTR_LIBATTR
> >       If this token and others are legitimate, please use m4_pattern_=
allow.
> >       See the Autoconf documentation.
> > make: *** [configure] Error 1
> >
> > After reverting "[42b851446ff1] build: remove <attr/xattr.h> check", =
everything
> > goes well.
> >
> > Is there following fix about this? Or did I do something wrong?

That's weird, I didn't see compiling errors in my release testing on any
of the three distros I tested (CentOS7.4, Debian sid and Fedora 28). But
now I did see the errors..

>=20
> Sorry, that's all my wrong. I will send the fix.

My fault, I folded removing getxattr check into your patch. Thanks for
the following-up patch!

Eryu

>=20
> -------------------------------------------------------------
> Thanks,
> Lu
>=20
> >
> > Thanks,
> > Zorro
> >
> > >
> > > Luis R. Rodriguez (1):
> > >       [103258a566b4] build: fix install target using sudo
> > >
> > > Marco Benatto (1):
> > >       [6a98def59ca9] xfs: Test root inode parent pointer repairing
> > >
> > > Qu Wenruo (1):
> > >       [73576ea71e1a] btrfs: test if btrfs will corrupt nodatasum co=
mpressed extent when replacing device
> > >
> > > Xiao Yang (1):
> > >       [f86ce7cc4b2b] common: Add _dmsetup_create and _dmsetup_remov=
e helpers
> > >
> > > Zorro Lang (4):
> > >       [f74e7e186c97] shared: dedupe a single big file and verify in=
tegrity
> > >       [e1f4b06edbd7] shared: iterate dedupe integrity test
> > >       [6b6ff4a005a1] shared: dedupe with random io race test
> > >       [c6ded48a3141] xfs: test bad character in xfs_db field list s=
elector string
> > >
> > >
> > > Code Diffstat:
> > >
> > >  common/config               |   1 +
> > >  common/dmdelay              |   9 +---
> > >  common/dmerror              |   9 ++--
> > >  common/dmflakey             |  14 ++----
> > >  common/dmhugedisk           |  15 +++----
> > >  common/dmlogwrites          |   9 +---
> > >  common/dmthin               |  19 ++++----
> > >  common/rc                   |  14 ++++++
> > >  configure.ac                |   1 -
> > >  ltp/fsstress.c              |   3 --
> > >  m4/package_attrdev.m4       |  25 -----------
> > >  src/log-writes/log-writes.c |   1 +
> > >  src/log-writes/log-writes.h |   1 +
> > >  src/log-writes/replay-log.c |   1 +
> > >  src/t_immutable.c           |   2 +-
> > >  tests/Makefile              |   2 +-
> > >  tests/btrfs/166             |  57 ++++++++++++++++++++++++
> > >  tests/btrfs/166.out         |   2 +
> > >  tests/btrfs/167             |  76 ++++++++++++++++++++++++++++++++
> > >  tests/btrfs/167.out         |   2 +
> > >  tests/btrfs/group           |   2 +
> > >  tests/generic/085           |  11 ++---
> > >  tests/shared/008            |  64 +++++++++++++++++++++++++++
> > >  tests/shared/008.out        |   3 ++
> > >  tests/shared/009            | 104 ++++++++++++++++++++++++++++++++=
++++++++++++
> > >  tests/shared/009.out        |   4 ++
> > >  tests/shared/010            |  94 ++++++++++++++++++++++++++++++++=
+++++++
> > >  tests/shared/010.out        |   2 +
> > >  tests/shared/group          |   3 ++
> > >  tests/xfs/365               |   2 +-
> > >  tests/xfs/450               |  64 +++++++++++++++++++++++++++
> > >  tests/xfs/450.out           |   2 +
> > >  tests/xfs/451               |  57 ++++++++++++++++++++++++
> > >  tests/xfs/451.out           |   2 +
> > >  tests/xfs/452               |  49 +++++++++++++++++++++
> > >  tests/xfs/452.out           |   7 +++
> > >  tests/xfs/group             |   3 ++
> > >  37 files changed, 646 insertions(+), 90 deletions(-)
> > > --
> > > Eryu Guan
> > > guaneryu@gmail.com
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
