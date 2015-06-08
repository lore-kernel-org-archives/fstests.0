Received: from mx1.redhat.com ([209.132.183.28]:42118 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbbFHMgW (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 8 Jun 2015 08:36:22 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 3C84DB5C00
	for <fstests@vger.kernel.org>; Mon,  8 Jun 2015 12:36:22 +0000 (UTC)
Date: Mon, 8 Jun 2015 14:36:16 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH] generic: concurrent IO test with mixed IO types
In-Reply-To: <20150608115947.GT3672@dhcp-13-216.nay.redhat.com>
Message-ID: <alpine.LFD.2.00.1506081435290.1273@localhost.localdomain>
References: <1433760101-25540-1-git-send-email-eguan@redhat.com> <alpine.LFD.2.00.1506081300400.1273@localhost.localdomain> <20150608115947.GT3672@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2052355393-1433766981=:1273"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2052355393-1433766981=:1273
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userv0021.oracle.com id t58CbOF4025157

On Mon, 8 Jun 2015, Eryu Guan wrote:

> Date: Mon, 8 Jun 2015 19:59:47 +0800
> From: Eryu Guan <eguan@redhat.com>
> To: Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com>
> Cc: fstests@vger.kernel.org
> Subject: Re: [PATCH] generic: concurrent IO test with mixed IO types
>=20
> On Mon, Jun 08, 2015 at 01:02:48PM +0200, Luk=C3=A1=C5=A1 Czerner wrote=
:
> > On Mon, 8 Jun 2015, Eryu Guan wrote:
> >=20
> > > Date: Mon,  8 Jun 2015 18:41:41 +0800
> > > From: Eryu Guan <eguan@redhat.com>
> > > To: fstests@vger.kernel.org
> > > Cc: lczerner@redhat.com, Eryu Guan <eguan@redhat.com>
> > > Subject: [PATCH] generic: concurrent IO test with mixed IO types
> > >=20
> > > Test concurrent buffered I/O, DIO, AIO, mmap I/O and splice I/O on =
the
> > > same files.
> >=20
> > Hi Eryu,
> >=20
> > Great! Thanks for turning it into a test. Couple of comments below.
> >=20
> > >=20
> > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > > ---
> > >=20
> > > This fio job file has been proven to be potent, it triggers WARNING=
s on ext4
> > > and xfs with 4.1-rc6 kernel.
> > >=20
> > > ext4: WARNING: at fs/ext4/inode.c:1328
> > > xfs: WARNING: CPU: 7 PID: 3090 at fs/xfs/xfs_file.c:726 xfs_file_di=
o_aio_write+0x176/0x2a8 [xfs]()
> > >=20
> > > The ext4 issue should be fixed by Lukas's patch
> > > ext4: fix reservation release on invalidatepage for delalloc fs
> > >=20
> > > And it ever paniced kernel in mm code and hung xfs.
> > >=20
> > > I reduced the numjobs and iodepth to reduce the test time(~25s on m=
y test host)
> > > and scale them by $LOAD_FACTOR. And it still could trigger the warn=
ing on ext4
> > > and xfs with reduced workload.
> > >=20
> > >  tests/generic/090     | 121 ++++++++++++++++++++++++++++++++++++++=
++++++++++++
> > >  tests/generic/090.out |   2 +
> > >  tests/generic/group   |   1 +
> > >  3 files changed, 124 insertions(+)
> > >  create mode 100755 tests/generic/090
> > >  create mode 100644 tests/generic/090.out
> > >=20
> > > diff --git a/tests/generic/090 b/tests/generic/090
> > > new file mode 100755
> > > index 0000000..748e935
> > > --- /dev/null
> > > +++ b/tests/generic/090
> > > @@ -0,0 +1,121 @@
> > > +#! /bin/bash
> > > +# FS QA Test generic/090
> > > +#
> > > +# Concurrent mixed I/O (buffer I/O, aiodio, mmap, splice) on the s=
ame files
> > > +#
> > > +#-----------------------------------------------------------------=
------
> > > +# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
> > > +#
> > > +# This program is free software; you can redistribute it and/or
> > > +# modify it under the terms of the GNU General Public License as
> > > +# published by the Free Software Foundation.
> > > +#
> > > +# This program is distributed in the hope that it would be useful,
> > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > +# GNU General Public License for more details.
> > > +#
> > > +# You should have received a copy of the GNU General Public Licens=
e
> > > +# along with this program; if not, write the Free Software Foundat=
ion,
> > > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > > +#-----------------------------------------------------------------=
------
> > > +#
> > > +
> > > +seq=3D`basename $0`
> > > +seqres=3D$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=3D`pwd`
> > > +tmp=3D/tmp/$$
> >=20
> > Not a big deal, but using mktemp woud probably be better.
>=20
> Will do in v2.
>=20
> >=20
> > > +fio_config=3D$tmp.fio
> > > +status=3D1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +_require_scratch
> > > +
> > > +iodepth=3D$((16 * LOAD_FACTOR))
> > > +iodepth_batch=3D$((8 * LOAD_FACTOR))
> > > +numjobs=3D$((5 * LOAD_FACTOR))
> > > +cat >$fio_config <<EOF
> > > +[global]
> > > +bs=3D8k
> > > +iodepth=3D$iodepth
> > > +iodepth_batch=3D$iodepth_batch
> > > +randrepeat=3D1
> > > +size=3D1m
> > > +directory=3D$SCRATCH_MNT
> > > +numjobs=3D$numjobs
> > > +[job1]
> > > +ioengine=3Dsync
> > > +bs=3D1k
> > > +direct=3D1
> > > +rw=3Drandread
> > > +filename=3Dfile1:file2
> > > +[job2]
> > > +ioengine=3Dlibaio
> > > +rw=3Drandwrite
> > > +direct=3D1
> > > +filename=3Dfile1:file2
> > > +[job3]
> > > +bs=3D1k
> > > +ioengine=3Dposixaio
> > > +rw=3Drandwrite
> > > +direct=3D1
> > > +filename=3Dfile1:file2
> > > +[job4]
> > > +ioengine=3Dsplice
> > > +direct=3D1
> > > +rw=3Drandwrite
> > > +filename=3Dfile1:file2
> > > +[job5]
> > > +bs=3D1k
> > > +ioengine=3Dsync
> > > +rw=3Drandread
> > > +filename=3Dfile1:file2
> > > +[job6]
> > > +ioengine=3Dposixaio
> > > +rw=3Drandwrite
> > > +filename=3Dfile1:file2
> > > +[job7]
> > > +ioengine=3Dsplice
> > > +rw=3Drandwrite
> > > +filename=3Dfile1:file2
> > > +[job8]
> > > +ioengine=3Dmmap
> > > +rw=3Drandwrite
> > > +bs=3D1k
> > > +filename=3Dfile1:file2
> > > +[job9]
> > > +ioengine=3Dmmap
> > > +rw=3Drandwrite
> > > +direct=3D1
> > > +filename=3Dfile1:file2
> > > +EOF
> > > +# with ioengine=3Dmmap and direct=3D1, fio requires bs to be at le=
ast pagesize,
> > > +# which is a fio built-in var.
> > > +echo 'bs=3D$pagesize' >> $fio_config
> >=20
> > Can't this be part of the the fio script creation above ?
>=20
> The 'here-document' replaces every var to its value, e.g. $numjobs =3D>=
 10
> (if LOAD_FACTOR is 1), so we don't have $pagesize set, and it'll be
> empty in the fio config file, that's not what we want.
>=20
> "bs=3D$pagesize" is literally what we want in the config file, $pagesiz=
e
> is a special var for fio, it will be replaced by real pagesize
> internally by fio.
>=20
> cat >file <<'EOF'
> text
> EOF
>=20
> This kind of 'here-document' ('' around EOF) won't do any variable
> expansion, but we need $numjobs to be expanded. So they can't be merged
> together.
>=20
> Thanks,
> Eryu

Ah right :) I missed the quotes, sorry.

Thanks!
-Lukas


>=20
> >=20
> > Thanks!
> > -Lukas
> >=20
> > > +
> > > +rm -f $seqres.full
> > > +
> > > +_require_fio $fio_config
> > > +
> > > +echo "Silence is golden"
> > > +$FIO_PROG $fio_config >>$seqres.full 2>&1
> > > +
> > > +# all done, expect no hang no oops no fs corruption,
> > > +# _check_dmesg and _check_filesystems will do the check work for u=
s
> > > +status=3D0
> > > +exit
> > > diff --git a/tests/generic/090.out b/tests/generic/090.out
> > > new file mode 100644
> > > index 0000000..2b5100d
> > > --- /dev/null
> > > +++ b/tests/generic/090.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 090
> > > +Silence is golden
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index 0c8964c..2e534a5 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -92,6 +92,7 @@
> > >  087 perms auto quick
> > >  088 perms auto quick
> > >  089 metadata auto
> > > +090 auto rw stress
> > >  091 rw auto quick
> > >  092 auto quick prealloc
> > >  093 attr cap udf auto
> > >=20
>=20
--8323328-2052355393-1433766981=:1273--
