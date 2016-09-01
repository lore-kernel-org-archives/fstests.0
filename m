Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:18068 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754609AbcIAAuM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 Aug 2016 20:50:12 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1bfGCm-0007xu-2I
        for fstests@vger.kernel.org; Thu, 01 Sep 2016 10:50:08 +1000
Date: Thu, 1 Sep 2016 10:50:08 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 21eb9d3
Message-ID: <20160901005008.GC30056@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Thanks to Eryu for putting this all
together. Delays in getting the updates out to you all have been on
my side, so blame me for that.

There are a few new tests in this update and not all the fixes are
upstream, so don't be surprised if you see the new tests fail
initially.

-Dave.

The new head of the master branch is commit:

21eb9d3 fstests: add punch, collapse, insert, zero test groups

New Commits:

Andreas Gruenbacher (1):
      [d8fe99a] generic: Check clearing of SGID in chmod and acl_set_file

Eric Sandeen (2):
      [478b969] common/quota: add prjquota to _qmount_option() filter
      [397c6eb] xfs: test xfs_quota "state" command

Eric Whitney (2):
      [758f71a] generic/135: redirect stderr from _scratch_mkfs
      [991b809] common/rc: improve _require_metadata_journaling() for ext4

Filipe Manana (1):
      [94cec74] generic: fsync after file rename

Omar Sandoval (1):
      [2a084ec] src/test-nextquota: fix build failure with glibc 2.24

Theodore Ts'o (1):
      [21eb9d3] fstests: add punch, collapse, insert, zero test groups

Xiao Yang (1):
      [6e21e45] xfs/191: skip tests on older xfsprogs

Zorro Lang (3):
      [9c03808] xfs/033: source mkfs output again if isize less than 512
      [d88e01f] xfs/006: refactor reset error handling code to common/rc
      [d6a6cf5] xfs: EIO error handling test


Code Diffstat:

 common/quota                |   1 +
 common/rc                   |  55 +++++++++++--
 src/test-nextquota.c        |   9 ++-
 tests/btrfs/group           |   2 +-
 tests/ext4/group            |   4 +-
 tests/generic/135           |   2 +-
 tests/generic/375           |  81 +++++++++++++++++++
 tests/generic/375.out       |   9 +++
 tests/generic/376           |  77 ++++++++++++++++++
 tests/generic/376.out       |   5 ++
 tests/generic/group         |  90 ++++++++++-----------
 tests/xfs/006               |  27 ++-----
 tests/xfs/006.out           |   1 +
 tests/xfs/033               |   8 +-
 tests/xfs/033.out.crc.linux |   6 --
 tests/xfs/033.out.irix      |   6 --
 tests/xfs/033.out.linux     |   6 --
 tests/xfs/263               |  97 +++++++++++++++++++++++
 tests/xfs/263.out           | 199 ++++++++++++++++++++++++++++++++++++++++=
+++++++
 tests/xfs/264               | 126 ++++++++++++++++++++++++++++++
 tests/xfs/264.out           |  21 +++++
 tests/xfs/group             |  24 +++---
 22 files changed, 746 insertions(+), 110 deletions(-)
 create mode 100755 tests/generic/375
 create mode 100644 tests/generic/375.out
 create mode 100755 tests/generic/376
 create mode 100644 tests/generic/376.out
 create mode 100755 tests/xfs/263
 create mode 100644 tests/xfs/263.out
 create mode 100755 tests/xfs/264
 create mode 100644 tests/xfs/264.out
--=20
Dave Chinner
david@fromorbit.com

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXx3s/AAoJEK3oKUf0dfod6zoP/jUM/MxANueS/aKfdbQzRJ/3
naDOZHu8nGhmeljOyLzWXplnVAxVAnNsE9Fw4iQLJe53Y1xZr2V/U0lWyqyLD2I4
fy44/jb5AqMbFdG+plwCHpL01XUjvyZA1qgYuMNbyjj2/XTeaAMiEi/sdAgnMK3b
iwsTBCQNx0C+7PObgngRiA4Xut//Zqww5rgW/RHqMqb+tQTv8d0ILflJ4qW8JgIb
b+ZzwXoP3MiWuG+/BX3oBHGk4vF5TcnzAaq2w5B1WHRkKec8ddIsucgH5QSkJA6e
3Hwpo40/sJ0gor//YDMvdaoUmpV5I9rOsFFhhb7Y93XGiJnjA2rUp+ac+qlEFQGt
4Vqaj5lmAnxbd9uZzSIDWy+GO7neEQbkv43qRvAgcrDrZiRCX7pQkOy8zPi06FsR
3t6As4ZYsPEvsoChvctW+nDBea/tgcWInvCATj8qsDvrEq9aJqfOCdEeoZsyH3XV
kXXwgOqy/HvNLsutp9++UqpdlEdgnJb1accVo+8/aauHOxwz/Fx38fpiKbGqEGs7
vfi2F6t4XqFteYGvhWlsPRSAm4I39dQjVIH/ywwq5zPMRhXGjehJ0gZzdlXbVviX
bOdmMmxIxpgzo5Ou1Eh+whEnvFKA09MXGFlk71sbnRnOz9w4p50X6KMFFLZtbAHb
ZqK4CQRldeu6YNSX2W9f
=NKUU
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
