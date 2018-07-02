Received: from mail-yb0-f194.google.com ([209.85.213.194]:45976 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbeGBH11 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Jul 2018 03:27:27 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so4738301ybg.12
        for <fstests@vger.kernel.org>; Mon, 02 Jul 2018 00:27:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702071957.GY2780@desktop>
References: <5b38d22b.1c69fb81.4b6b6.8ebb@mx.google.com> <20180702022054.GU4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <CALS+E5C6RZgyb7+1ZBg6B=GVMfs=M-rEP7MZJc6+WsdMBsCgWg@mail.gmail.com> <20180702071957.GY2780@desktop>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 2 Jul 2018 10:27:25 +0300
Message-ID: <CAOQ4uxhbOq_J1RL=iKhmcWqfo=Fz5CJXqHmeakw-vqMfUqCoag@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 42b851446ff1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Lu Fengqi <curiouslfq@gmail.com>, Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 2, 2018 at 10:19 AM, Eryu Guan <guaneryu@gmail.com> wrote:
> On Mon, Jul 02, 2018 at 10:42:19AM +0800, Lu Fengqi wrote:
>> Zorro Lang <zlang@redhat.com> =E4=BA=8E2018=E5=B9=B47=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:25=E5=86=99=E9=81=93=EF=BC=9A
>> >
>> > On Sun, Jul 01, 2018 at 09:07:51PM +0800, Eryu Guan wrote:
>> > > Hi all,
>> > >
>> > > The master branch of the xfstests repository at:
>> > >
>> > >       git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>> > >
>> > > have just been updated. This update contains 8 new tests mainly for =
xfs and
>> > > btrfs, but they all should pass with latest Linus tree. Others are r=
andom
>> > > updates including license update to src/log-writes/* and fixes to bu=
ild
>> > > infrastructure.
>> > >
>> > > Thanks,
>> > > Eryu
>> > >
>> > > The new head of the master branch is commit:
>> > >
>> > > 42b851446ff1 build: remove <attr/xattr.h> check
>> > >
>> > > New commits:
>> > >
>> > > Darrick J. Wong (2):
>> > >       [e04c7b7e3021] xfs/365: fuzz inobt in ag 1
>> > >       [494b07e34015] xfs: regression test for rmapbt fdblocks accoun=
ting problems
>> > >
>> > > Filipe Manana (1):
>> > >       [89ee377df5f2] btrfs: test power failure while qgroups rescan =
is in progress
>> > >
>> > > Josef Bacik (1):
>> > >       [a0f89557ca46] fstests: add SPDX license comments for src/log-=
writes/*
>> > >
>> > > Lu Fengqi (3):
>> > >       [d61c29d32fab] fsstress: remove include <attr/xattr.h>
>> > >       [652fda3ee172] src/t_immutable: use sys/xattr.h instead of att=
r/xattr.h
>> > >       [42b851446ff1] build: remove <attr/xattr.h> check
>> >
>> > The current xfstests-dev always fails on building time:
>> >
>> > configure.ac:56: error: possibly undefined macro: AC_PACKAGE_NEED_GETX=
ATTR_LIBATTR
>> >       If this token and others are legitimate, please use m4_pattern_a=
llow.
>> >       See the Autoconf documentation.
>> > make: *** [configure] Error 1
>> >
>> > After reverting "[42b851446ff1] build: remove <attr/xattr.h> check", e=
verything
>> > goes well.
>> >
>> > Is there following fix about this? Or did I do something wrong?
>
> That's weird, I didn't see compiling errors in my release testing on any
> of the three distros I tested (CentOS7.4, Debian sid and Fedora 28). But
> now I did see the errors..
>

My experience is that 'make' failed but 'make clean; make' did fine.

Thanks,
Amir.
