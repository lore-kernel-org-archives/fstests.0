Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:55133 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759193AbaLLEKi (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 11 Dec 2014 23:10:38 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1XzHYV-0003Vr-5K
	for fstests@vger.kernel.org; Fri, 12 Dec 2014 15:10:15 +1100
Date: Fri, 12 Dec 2014 15:10:15 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to c947ef4
Message-ID: <20141212041015.GI9756@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.

The new head of the master branch is commit:

c947ef4 ext4: the _require checks for bigalloc need a larger fs size

New Commits:

Dave Chinner (1):
      [c7aa9d3] xfs/096: strip log stripe warnings from mkfs.xfs

David Disseldorp (2):
      [20bde4f] common: rename _require_btrfs_cloner to _require_cloner
      [28da761] cifs: add server-side copy sanity test

Eric Sandeen (2):
      [b3db9ca] xfs: test xfs_copy for various sector and block sizes
      [ca28228] generic: use xfs_io falloc, not fallocate

Eryu Guan (5):
      [3de9ad0] common: enable tests that require scratch device on CIFS
      [67cf62f] xfs/071: remove xfs/071.out from git
      [dd3c7a6] fstests: change mode of test files to 0755
      [8d03c12] btrfs/017: remove duplicate test
      [7b7e449] common: fix comment about _require_test

Filipe Manana (1):
      [038401d] btrfs: add test to stress chunk allocation/removal and fstr=
im

Steve French (1):
      [595b93e] common: update README to list build dependencies

Vishal Verma (1):
      [c947ef4] ext4: the _require checks for bigalloc need a larger fs size

Xiaoguang Wang (1):
      [bf1b82f] ext4: add dump/restore test


Code Diffstat:

 README                        |   6 ++
 common/config                 |   2 +
 common/rc                     |  20 ++++--
 tests/btrfs/010               |   0
 tests/btrfs/013               |   0
 tests/btrfs/015               |   0
 tests/btrfs/017.out           |   2 -
 tests/btrfs/018               |   0
 tests/btrfs/026               |   0
 tests/btrfs/027               |   0
 tests/btrfs/028               |   0
 tests/btrfs/029               |   0
 tests/btrfs/031               |   0
 tests/btrfs/035               |   2 +-
 tests/btrfs/043               |   0
 tests/btrfs/044               |   0
 tests/btrfs/046               |   0
 tests/btrfs/049               |   0
 tests/btrfs/052               |   2 +-
 tests/btrfs/055               |   2 +-
 tests/btrfs/056               |   2 +-
 tests/btrfs/057               |   0
 tests/btrfs/058               |   0
 tests/btrfs/076               |   0
 tests/btrfs/077               |   0
 tests/btrfs/group             |   1 -
 tests/{btrfs/017 =3D> cifs/001} |  40 ++++++-----
 tests/cifs/001.out            |  21 ++++++
 tests/cifs/group              |   6 ++
 tests/ext4/004                |  89 ++++++++++++++++++++++++
 tests/ext4/004.out            |   2 +
 tests/ext4/group              |   3 +-
 tests/generic/029             |   0
 tests/generic/030             |   0
 tests/generic/031             |   0
 tests/generic/032             |   0
 tests/generic/033             |   0
 tests/generic/038             | 153 ++++++++++++++++++++++++++++++++++++++=
++++
 tests/generic/038.out         |   2 +
 tests/generic/299             |   8 ++-
 tests/generic/315             |   4 +-
 tests/generic/323             |   0
 tests/generic/324             |   0
 tests/generic/group           |   1 +
 tests/xfs/032                 |  80 ++++++++++++++++++++++
 tests/xfs/032.out             |   2 +
 tests/xfs/071.out             | 107 -----------------------------
 tests/xfs/096                 |   4 +-
 tests/xfs/096.external        |   2 -
 tests/xfs/096.internal        |   4 --
 tests/xfs/298                 |   0
 tests/xfs/306                 |   0
 tests/xfs/group               |   1 +
 53 files changed, 420 insertions(+), 148 deletions(-)
 mode change 100644 =3D> 100755 tests/btrfs/010
 mode change 100644 =3D> 100755 tests/btrfs/013
 mode change 100644 =3D> 100755 tests/btrfs/015
 delete mode 100644 tests/btrfs/017.out
 mode change 100644 =3D> 100755 tests/btrfs/018
 mode change 100644 =3D> 100755 tests/btrfs/026
 mode change 100644 =3D> 100755 tests/btrfs/027
 mode change 100644 =3D> 100755 tests/btrfs/028
 mode change 100644 =3D> 100755 tests/btrfs/029
 mode change 100644 =3D> 100755 tests/btrfs/031
 mode change 100644 =3D> 100755 tests/btrfs/043
 mode change 100644 =3D> 100755 tests/btrfs/044
 mode change 100644 =3D> 100755 tests/btrfs/046
 mode change 100644 =3D> 100755 tests/btrfs/049
 mode change 100644 =3D> 100755 tests/btrfs/057
 mode change 100644 =3D> 100755 tests/btrfs/058
 mode change 100644 =3D> 100755 tests/btrfs/076
 mode change 100644 =3D> 100755 tests/btrfs/077
 rename tests/{btrfs/017 =3D> cifs/001} (59%)
 mode change 100644 =3D> 100755
 create mode 100644 tests/cifs/001.out
 create mode 100644 tests/cifs/group
 create mode 100755 tests/ext4/004
 create mode 100644 tests/ext4/004.out
 mode change 100644 =3D> 100755 tests/generic/029
 mode change 100644 =3D> 100755 tests/generic/030
 mode change 100644 =3D> 100755 tests/generic/031
 mode change 100644 =3D> 100755 tests/generic/032
 mode change 100644 =3D> 100755 tests/generic/033
 create mode 100755 tests/generic/038
 create mode 100644 tests/generic/038.out
 mode change 100644 =3D> 100755 tests/generic/323
 mode change 100644 =3D> 100755 tests/generic/324
 create mode 100755 tests/xfs/032
 create mode 100644 tests/xfs/032.out
 delete mode 100644 tests/xfs/071.out
 mode change 100644 =3D> 100755 tests/xfs/298
 mode change 100644 =3D> 100755 tests/xfs/306
--=20
Dave Chinner
david@fromorbit.com

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUimqmAAoJEK3oKUf0dfod5asP/3t/CmUbXbiYBwcX8+DoQqXX
PEVVkDQOpYNDLX7v6gOsUYkHxk4jbKbGlXfgRFtmq2B/HzqBgbxo7Zm+C3dfVRZE
PnGtn9H1MTqSs9CCf2fDtPfmnxTSHRdLLEOhT+Xy3sHAfozFihUz3ihuQfmeUeN4
JifEvpCFHEz9v5wdxqeuJayMVi7QTPy4YQOT+k0jbrlcQDO1YxGSc3pbNvpCGFpj
2KK8N1P3SvMhdupNVL8nF1ge1BeQ6V9TTEoq5oEJjMKoAwkWqMo+seiAeRFnWHQF
JGKucyb+JreqX0my7CkkBeO+n2iNenKbtj64wUcIwWnEfnx4O2S9U1sWAKkij6FG
J6DxqIKRZlRXj0HF6YhupqcVPjjVSLS3pI3Jwy4acN6DFkv90iFB4vrcMTyHhk3Y
8Mz17KBeNXnqm7F8DZZj4kHpisdmHPXLyYFk2H077yfoPidNq9UvjR7Gi1yBZmhd
9eWr2nrzDus9rhPYFBSrBax8u+XJRgmueVWPiJanmmxbpwBcwRpSLDYsS+BYt9P0
aoo9S9vB83CldzeqQlukitaCgi2O7WtOeEBOp+Rdefku+d+3VjNPKgsSf7hJ++gc
ZIUMdFARd/8MfikGDgD7hmxVHQDIZJXF7AY0woHGr6tV+BABiko7CfjhJXRMT7/h
xKqCpNVweLOimyawh1ub
=jI0V
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
