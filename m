Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:4251 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750971AbaJNVAp (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 14 Oct 2014 17:00:45 -0400
Date: Wed, 15 Oct 2014 08:00:35 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 481c28f
Message-ID: <20141014210035.GA7169@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.

-Dave.

The new head of the master branch is commit:

481c28f xfs: test larger dump/restore to/from file

New Commits:

Anna Schumaker (1):
      [19c805e] common: Re-enable testing over NFS

Brian Foster (1):
      [cf14382] xfs/053: test for stale data exposure via falloc/writeback =
interaction

Dave Chinner (1):
      [13c2dcb] xfs/007: check correct quota inodes

Eric Sandeen (1):
      [481c28f] xfs: test larger dump/restore to/from file

Eryu Guan (17):
      [edc2d65] btrfs: new test to run btrfs balance and subvolume test sim=
ultaneously
      [dcc48fa] btrfs: new test to run btrfs balance and scrub simultaneous=
ly
      [e6170fd] btrfs: new test to run btrfs balance and defrag operations =
simultaneously
      [ff2435a] btrfs: new case to run btrfs balance and remount with diffe=
rent compress algorithms
      [3712e70] btrfs: new case to run btrfs balance and device replace ope=
rations simultaneously
      [ca8d3f5] btrfs: new case to run btrfs subvolume create/delete operat=
ions and device replace simultaneously
      [0eed4e6] btrfs: new case to run btrfs subvolume create/delete operat=
ions and scrub simultaneously
      [4799f24] btrfs: new case to run btrfs subvolume create/delete and de=
frag operations simultaneously
      [067578b] btrfs: new case to run subvolume create/delete and remount =
with defferent compress algorithms
      [8dc3354] btrfs: new case to run device replace and scrub operations =
simultaneously
      [87c32f6] btrfs: new case to run device replace and defrag operations=
 simultaneously
      [5160c14] btrfs: new case to run device replace and remount with diff=
erent compress algorithms simultaneously
      [1e18397] btrfs: new case to run btrfs scrub and defrag operations si=
multaneously
      [5398fca] btrfs: new case to run btrfs scrub and remount with differe=
nt compress algorithms simultaneously
      [a1a9f6e] btrfs: new case to run defrag and remount with different co=
mpress algorithms simultaneously
      [b675ef7] btrfs: test mount btrfs subvolume with selinux context
      [50f2346] xfs/262: update filter to deal with long device name correc=
tly

Filipe Manana (1):
      [edaea8a] btrfs: regression test for btrfs incremental send

Jan Kara (1):
      [82b6904] xfs/287: Make test fail graciously when xfsdump isn't insta=
lled

Lukas Czerner (2):
      [a2a1fc6] common: Introduce get_block_size() helper
      [448efe1] generic/017: Do not create file systems with different bloc=
k sizes

Miklos Szeredi (1):
      [de161cb] generic: check overwriting rename

Wang Shilong (4):
      [5bdda3d] common: fix test for ltp/fsstress
      [562af5d] btrfs: add regression for inode bad compression ratio detec=
tion
      [cbf5cd2] btrfs/010: use _extent_count() helper
      [b5830f4] shared/032: fix fsck failure


Code Diffstat:

 .gitignore               |   1 +
 common/attr              |   4 +-
 common/config            |   2 +-
 common/dump              |   9 +-
 common/punch             |   2 +-
 common/rc                | 245 +++++++++++++++++++++++++++++++++++++++++++=
++--
 src/Makefile             |   2 +-
 src/t_rename_overwrite.c |  39 ++++++++
 tests/btrfs/010          |   8 +-
 tests/btrfs/060          | 115 ++++++++++++++++++++++
 tests/btrfs/060.out      |   2 +
 tests/btrfs/061          | 114 ++++++++++++++++++++++
 tests/btrfs/061.out      |   2 +
 tests/btrfs/062          | 116 ++++++++++++++++++++++
 tests/btrfs/062.out      |   2 +
 tests/btrfs/063          | 114 ++++++++++++++++++++++
 tests/btrfs/063.out      |   2 +
 tests/btrfs/064          | 122 +++++++++++++++++++++++
 tests/btrfs/064.out      |   2 +
 tests/btrfs/065          | 123 ++++++++++++++++++++++++
 tests/btrfs/065.out      |   2 +
 tests/btrfs/066          | 115 ++++++++++++++++++++++
 tests/btrfs/066.out      |   2 +
 tests/btrfs/067          | 117 ++++++++++++++++++++++
 tests/btrfs/067.out      |   2 +
 tests/btrfs/068          | 116 ++++++++++++++++++++++
 tests/btrfs/068.out      |   2 +
 tests/btrfs/069          | 123 ++++++++++++++++++++++++
 tests/btrfs/069.out      |   2 +
 tests/btrfs/070          | 125 ++++++++++++++++++++++++
 tests/btrfs/070.out      |   2 +
 tests/btrfs/071          | 123 ++++++++++++++++++++++++
 tests/btrfs/071.out      |   2 +
 tests/btrfs/072          | 116 ++++++++++++++++++++++
 tests/btrfs/072.out      |   2 +
 tests/btrfs/073          | 114 ++++++++++++++++++++++
 tests/btrfs/073.out      |   2 +
 tests/btrfs/074          | 116 ++++++++++++++++++++++
 tests/btrfs/074.out      |   2 +
 tests/btrfs/075          |  70 ++++++++++++++
 tests/btrfs/075.out      |   2 +
 tests/btrfs/076          |  74 ++++++++++++++
 tests/btrfs/076.out      |   3 +
 tests/btrfs/077          | 148 ++++++++++++++++++++++++++++
 tests/btrfs/077.out      |   2 +
 tests/btrfs/group        |  18 ++++
 tests/generic/017        |  46 ++++-----
 tests/generic/017.out    |   2 -
 tests/generic/035        |  72 ++++++++++++++
 tests/generic/035.out    |   3 +
 tests/generic/240        |   2 +-
 tests/generic/256        |   2 +-
 tests/generic/308        |   2 +-
 tests/generic/group      |   1 +
 tests/shared/032         |   2 +-
 tests/shared/298         |   2 +-
 tests/xfs/007            |  78 +++++++--------
 tests/xfs/007.out        |   4 +-
 tests/xfs/053            | 101 +++++++++++++++++++
 tests/xfs/053.out        |  10 ++
 tests/xfs/068            |  50 ++++++++++
 tests/xfs/068.out        |  47 +++++++++
 tests/xfs/262            |  12 ++-
 tests/xfs/287            |   1 +
 tests/xfs/group          |   2 +
 65 files changed, 2768 insertions(+), 99 deletions(-)
 create mode 100644 src/t_rename_overwrite.c
 mode change 100755 =3D> 100644 tests/btrfs/010
 create mode 100755 tests/btrfs/060
 create mode 100644 tests/btrfs/060.out
 create mode 100755 tests/btrfs/061
 create mode 100644 tests/btrfs/061.out
 create mode 100755 tests/btrfs/062
 create mode 100644 tests/btrfs/062.out
 create mode 100755 tests/btrfs/063
 create mode 100644 tests/btrfs/063.out
 create mode 100755 tests/btrfs/064
 create mode 100644 tests/btrfs/064.out
 create mode 100755 tests/btrfs/065
 create mode 100644 tests/btrfs/065.out
 create mode 100755 tests/btrfs/066
 create mode 100644 tests/btrfs/066.out
 create mode 100755 tests/btrfs/067
 create mode 100644 tests/btrfs/067.out
 create mode 100755 tests/btrfs/068
 create mode 100644 tests/btrfs/068.out
 create mode 100755 tests/btrfs/069
 create mode 100644 tests/btrfs/069.out
 create mode 100755 tests/btrfs/070
 create mode 100644 tests/btrfs/070.out
 create mode 100755 tests/btrfs/071
 create mode 100644 tests/btrfs/071.out
 create mode 100755 tests/btrfs/072
 create mode 100644 tests/btrfs/072.out
 create mode 100755 tests/btrfs/073
 create mode 100644 tests/btrfs/073.out
 create mode 100755 tests/btrfs/074
 create mode 100644 tests/btrfs/074.out
 create mode 100755 tests/btrfs/075
 create mode 100644 tests/btrfs/075.out
 create mode 100644 tests/btrfs/076
 create mode 100644 tests/btrfs/076.out
 create mode 100644 tests/btrfs/077
 create mode 100644 tests/btrfs/077.out
 create mode 100755 tests/generic/035
 create mode 100644 tests/generic/035.out
 create mode 100755 tests/xfs/053
 create mode 100644 tests/xfs/053.out
 create mode 100755 tests/xfs/068
 create mode 100644 tests/xfs/068.out
--=20
Dave Chinner
david@fromorbit.com

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUPY7yAAoJEK3oKUf0dfodz2IQANSMwsfH0nQ160gfMGoXSIH7
r6hbexzzG8eEAM5lajJQxlJSOIrPVsmDKgEPtunv+Hm2/5xR/72F6heOxOs2GDlE
mg5OnDPik132kj14qvHrYAQiKiQZ8c+wkWBqJ5nlXzmcJGpABT0eiITK/QrOX+cV
BYfjNTM3M1UeqSuvyct4VCtjgJFINldvLEJ6e4zc6A+CONgSrw/XaxLfT5TcZsVa
kw9ocnucigxc3ALK/jeB13SwnlOOwRFIZEdBQaVuvCMbevE1TFQoC7hnfKFGj59o
xQT0HEHVqIGAiDCTCk7f4NGO8eWBXtbw4hBj0N1oA5p6Cdjxu8kIx8iSeu66qDqe
P/HBGqNxg6CcoKB3p4EQv/64BuGhklIP1ssZauuu/NPg7UkNH+pUVpzej3ScN1kt
jhvgH/1GwHpSuOy0ihMsQBL33TVX+uyEl4nnOS1VXYesEAHQMvAc5VierNJiRTAS
b9pqk9MKofxIAC1896TTnXQPaVG9cqjqCa0ejHS9uGMQ2Bb+Y+v1nKHpxoIZWMBk
Vy+ubGi+M0Ish/R2517y5MtHJtg41qgTKwch/NfVVLPWtuKTd2i6AICWNd61VJhW
mtdqfyZbF79jvpuWDnxRpOv71at5ZWPLoyaevX9SUeT6kThYTo9enI3d6Whg1/eT
xvyn7TrKwDcy4zkLoIPA
=RlpU
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
