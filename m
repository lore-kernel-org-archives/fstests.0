Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:54187 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143AbcGTXyg (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2016 19:54:36 -0400
Date: Thu, 21 Jul 2016 09:54:33 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 6/6] xfstests: Add mkfs input validation tests
Message-ID: <20160720235433.GA12670@dastard>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
 <1468500214-6237-7-git-send-email-jtulak@redhat.com>
 <20160716093358.GL2432@eguan.usersys.redhat.com>
 <20160717233003.GX1922@dastard>
 <CACj3i73TdnUcDT0J2QEBKQhoMsyYFVz6hBb_=bC99rL2ZbkCYQ@mail.gmail.com>
 <20160718114723.GG27776@eguan.usersys.redhat.com>
 <CACj3i71VOC8i_11hFn_fphsMfGqduHB6on5UawUHm6mtAaVRhQ@mail.gmail.com>
 <CACj3i73hdbW4iAWufvxc_aJn1dj+UGzuud7Cj-qMiwe7aLeNxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACj3i73hdbW4iAWufvxc_aJn1dj+UGzuud7Cj-qMiwe7aLeNxQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jan Tulak <jtulak@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, xfs-oss <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 18, 2016 at 02:33:29PM +0200, Jan Tulak wrote:
> On Mon, Jul 18, 2016 at 1:54 PM, Jan Tulak <jtulak@redhat.com> wrote:
> > On Mon, Jul 18, 2016 at 1:47 PM, Eryu Guan <eguan@redhat.com> wrote:
> >> On Mon, Jul 18, 2016 at 01:29:47PM +0200, Jan Tulak wrote:
> >>> On Mon, Jul 18, 2016 at 1:30 AM, Dave Chinner <david@fromorbit.com>=
 wrote:
> >>> > On Sat, Jul 16, 2016 at 05:33:58PM +0800, Eryu Guan wrote:
> >>> >> On Thu, Jul 14, 2016 at 02:43:34PM +0200, Jan Tulak wrote:
> >>> >> > +do_mkfs_fail -l lazy-count=3D1garbage $SCRATCH_DEV
> >>> >> > +do_mkfs_fail -l lazy-count=3D2 $SCRATCH_DEV
> >>> >> > +do_mkfs_fail -l lazy-count=3D0 -m crc=3D1 $SCRATCH_DEV
> >>> >> > +do_mkfs_fail -l version=3D1 -m crc=3D1 $SCRATCH_DEV
> >>> >>
> >>> >> This test fails in my DAX testing, where SCRATCH_DEV is ramdisk.=
 The
> >>> >> mkfs itself should fail, but it passed. Log version 2 was used
> >>> >> automatically, instead of prompting "V2 logs always enabled for =
CRC
> >>> >> enabled filesytems"
> >>> >>
> >>> >> [root@dhcp-66-86-11 xfstests]# mkfs -t xfs -f -l version=3D1 -m =
crc=3D1 /dev/ram0
> >>> >> meta-data=3D/dev/ram0              isize=3D512    agcount=3D1, a=
gsize=3D4096 blks
> >>> >>          =3D                       sectsz=3D4096  attr=3D2, proj=
id32bit=3D1
> >>> >>          =3D                       crc=3D1        finobt=3D1, sp=
arse=3D0
> >>> >> data     =3D                       bsize=3D4096   blocks=3D4096,=
 imaxpct=3D25
> >>> >>          =3D                       sunit=3D0      swidth=3D0 blk=
s
> >>> >> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0 f=
type=3D1
> >>> >> log      =3Dinternal log           bsize=3D4096   blocks=3D1605,=
 version=3D2
> >>> >>          =3D                       sectsz=3D4096  sunit=3D1 blks=
, lazy-count=3D1
> >>> >> realtime =3Dnone                   extsz=3D4096   blocks=3D0, rt=
extents=3D0
> >>> >>
> >>> >> Is it a mkfs.xfs bug or the test case should handle the special =
case?
> >>> >
> >>> > Looks like it might be a side effect of using a 4k sector size. v=
1
> >>> > logs only supported 512 byte sectors, so it's entirely possible t=
hat
> >>> > the sector size is silently overriding the log version
> >>> > specification. Probably should be fixed in mkfs.
> >>> >
> >>> >
> >>>
> >>> I tried to duplicate this, but in my config it didn't failed - how =
did
> >>> you create the ramdisk?
> >>
> >> I think you need to test on a 4k sector size disk. I use scsi_debug =
to
> >> simulate physical 4k sector disk to reproduce this:
> >>
> >> [root@dhcp-66-86-11 xfsprogs-dev]# modprobe -r scsi_debug
> >> [root@dhcp-66-86-11 xfsprogs-dev]# modprobe scsi_debug dev_size_mb=3D=
128 physblk_exp=3D3
> >> [root@dhcp-66-86-11 xfsprogs-dev]# blockdev --getbsz --getpbsz --get=
ss /dev/sdc
> >> 4096
> >> 4096
> >> 512
> >> [root@dhcp-66-86-11 xfsprogs-dev]# mkfs -t xfs -l version=3D1 -m crc=
=3D1 /dev/sdc

So this is an invalid filesystem configuration. It should be
detected as such during command line parsing and rejected before we
get anywhere near checking topology constraints. In mkfs
terms, it's a conflicting option set.

> And the culprit is in mkfs, some forty lines before the crc & log versi=
on check:
>=20
> 2026 =E2=87=A5       } else if (lsectorsize > XFS_MIN_SECTORSIZE && !ls=
u && !lsunit) {
> 2027 =E2=87=A5       =E2=87=A5       lsu =3D blocksize;
> 2028 =E2=87=A5       =E2=87=A5       sb_feat.log_version =3D 2;
> 2029 =E2=87=A5       }
>=20
> The possible solutions I can think of are:

None of which really appeal because, IMO, they are trying to solve
the wrong problem.

The whole point of moving to table based command line option parsing
is that we can encode these sorts of conflicts into the option
table. The conflict resolution in the option table is currently not
complete - it can only encode and detect conflicts within a
suboption type, but not across suboption types (e.g. within -d
suboptions, but not between -d and -l suboptions).

This is simply because I never got as far as implementing this level
of conflict encoding/resolution. In essence, the conflict array
needs to define the sub option type, the suboption that is
in conflict and the value that it conflicts against. Hence the
conflicts table can then encode such things as "version 1 logs are
invalid for CRC enabled filesystems" and vice versa.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
