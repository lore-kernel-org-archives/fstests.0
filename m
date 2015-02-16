Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:6345 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751446AbbBPAkg (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 15 Feb 2015 19:40:36 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1YN9jm-0001ii-38
	for fstests@vger.kernel.org; Mon, 16 Feb 2015 11:40:34 +1100
Date: Mon, 16 Feb 2015 11:40:34 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to a8607c1
Message-ID: <20150216004034.GH12722@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--WhfpMioaduB5tiZL
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

a8607c1 generic: test for fsync after punching hole

New Commits:

Anna Schumaker (1):
      [3de543f] fsx: check for filesystem support of FALLOCATE_FL_KEEP_SIZE

Brian Foster (1):
      [ed48b42] xfs: xfs_repair secondary sb verification regression test

David Sterba (1):
      [2b2fe1a] common: helper to print raw byte output from qgroup show

Eric Sandeen (1):
      [4046dd9] shared/032: handle mkfs.* in either /sbin or /usr/sbin

Filipe Manana (3):
      [5a3ce97] generic: add test for fsync after creating hard link
      [7e03b71] generic: Another fsync after adding hard link test
      [a8607c1] generic: test for fsync after punching hole

Iustin Pop (1):
      [75d2b0f] xfs: add test for XFS_IOC_FSSETXATTR behaviour

Jaegeuk Kim (9):
      [e2b7ec9] common: add _require_scratch_shtudown
      [f713275] common: use fiemap to count extents and holes
      [bc7cf7b] common: add _require_norecovery
      [9db4da5] generic: relocate xfs shutdown tests into tests/generic/
      [234c38b] common: define _require_logstate
      [56c0dac] xfs/086,087: remove specific testing options in output
      [fca6b88] common/log: add _get_log_configs for testing options
      [72d0a11] xfs/087: give quota mount option per filesystem
      [dd8a4b3] generic: relocate log recovery tests into tests/generic/

Xiaoguang Wang (1):
      [aa4efc9] ext4/304: ignore EINVAL and ENODATA error

Xing Gu (1):
      [5e8b9e6] btrfs: add regression test for remount with thread_pool res=
ized


Code Diffstat:

 common/config                          |   1 +
 common/filter                          |   4 ++
 common/log                             |  98 +++++++++++++++++++++++++--
 common/rc                              |  45 +++++++++++++
 common/repair                          |   4 ++
 ltp/fsx.c                              |  18 +++--
 tests/btrfs/017                        |   3 +-
 tests/btrfs/022                        |  12 ++--
 tests/btrfs/057                        |   3 +-
 tests/btrfs/082                        |  65 ++++++++++++++++++
 tests/btrfs/082.out                    |   2 +
 tests/btrfs/group                      |   1 +
 tests/ext4/304                         |   2 +
 tests/{xfs/053 =3D> generic/042}         |   5 +-
 tests/{xfs/053.out =3D> generic/042.out} |   2 +-
 tests/{xfs/137 =3D> generic/043}         |  18 ++---
 tests/generic/043.out                  |   1 +
 tests/{xfs/138 =3D> generic/044}         |  18 ++---
 tests/generic/044.out                  |   1 +
 tests/{xfs/139 =3D> generic/045}         |  18 ++---
 tests/generic/045.out                  |   1 +
 tests/{xfs/140 =3D> generic/046}         |  14 ++--
 tests/generic/046.out                  |   1 +
 tests/{xfs/179 =3D> generic/047}         |  12 ++--
 tests/generic/047.out                  |   1 +
 tests/{xfs/180 =3D> generic/048}         |  12 ++--
 tests/generic/048.out                  |   1 +
 tests/{xfs/182 =3D> generic/049}         |  12 ++--
 tests/generic/049.out                  |   1 +
 tests/{xfs/200 =3D> generic/050}         |  10 +--
 tests/{xfs/200.out =3D> generic/050.out} |   2 +-
 tests/{xfs/306 =3D> generic/051}         |   5 +-
 tests/{xfs/306.out =3D> generic/051.out} |   2 +-
 tests/{xfs/085 =3D> generic/052}         |   8 ++-
 tests/{xfs/085.out =3D> generic/052.out} |   2 +-
 tests/{xfs/086 =3D> generic/054}         |  36 ++++------
 tests/{xfs/086.out =3D> generic/054.out} |  22 +-----
 tests/{xfs/087 =3D> generic/055}         |  52 +++++++-------
 tests/{xfs/087.out =3D> generic/055.out} |  53 ++++++++++++---
 tests/generic/056                      |  99 +++++++++++++++++++++++++++
 tests/generic/056.out                  |  11 +++
 tests/generic/057                      | 112 ++++++++++++++++++++++++++++++
 tests/generic/057.out                  |  17 +++++
 tests/generic/059                      | 120 +++++++++++++++++++++++++++++=
++++
 tests/generic/059.out                  |  31 +++++++++
 tests/generic/group                    |  16 +++++
 tests/shared/032                       |   2 +-
 tests/xfs/069                          |  83 +++++++++++++++++++++++
 tests/xfs/069.out                      |   4 ++
 tests/xfs/070                          | 110 ++++++++++++++++++++++++++++++
 tests/xfs/070.out                      |  27 ++++++++
 tests/xfs/137.out                      |   1 -
 tests/xfs/138.out                      |   1 -
 tests/xfs/139.out                      |   1 -
 tests/xfs/140.out                      |   1 -
 tests/xfs/179.out                      |   1 -
 tests/xfs/180.out                      |   1 -
 tests/xfs/182.out                      |   1 -
 tests/xfs/group                        |  15 +----
 59 files changed, 1043 insertions(+), 179 deletions(-)
 create mode 100755 tests/btrfs/082
 create mode 100644 tests/btrfs/082.out
 rename tests/{xfs/053 =3D> generic/042} (97%)
 rename tests/{xfs/053.out =3D> generic/042.out} (92%)
 rename tests/{xfs/137 =3D> generic/043} (89%)
 create mode 100644 tests/generic/043.out
 rename tests/{xfs/138 =3D> generic/044} (89%)
 create mode 100644 tests/generic/044.out
 rename tests/{xfs/139 =3D> generic/045} (89%)
 create mode 100644 tests/generic/045.out
 rename tests/{xfs/140 =3D> generic/046} (92%)
 create mode 100644 tests/generic/046.out
 rename tests/{xfs/179 =3D> generic/047} (92%)
 create mode 100644 tests/generic/047.out
 rename tests/{xfs/180 =3D> generic/048} (92%)
 create mode 100644 tests/generic/048.out
 rename tests/{xfs/182 =3D> generic/049} (92%)
 create mode 100644 tests/generic/049.out
 rename tests/{xfs/200 =3D> generic/050} (95%)
 rename tests/{xfs/200.out =3D> generic/050.out} (97%)
 rename tests/{xfs/306 =3D> generic/051} (97%)
 rename tests/{xfs/306.out =3D> generic/051.out} (60%)
 rename tests/{xfs/085 =3D> generic/052} (94%)
 rename tests/{xfs/085.out =3D> generic/052.out} (94%)
 rename tests/{xfs/086 =3D> generic/054} (81%)
 rename tests/{xfs/086.out =3D> generic/054.out} (93%)
 rename tests/{xfs/087 =3D> generic/055} (79%)
 rename tests/{xfs/087.out =3D> generic/055.out} (89%)
 create mode 100755 tests/generic/056
 create mode 100644 tests/generic/056.out
 create mode 100755 tests/generic/057
 create mode 100644 tests/generic/057.out
 create mode 100755 tests/generic/059
 create mode 100644 tests/generic/059.out
 create mode 100755 tests/xfs/069
 create mode 100644 tests/xfs/069.out
 create mode 100755 tests/xfs/070
 create mode 100644 tests/xfs/070.out
 delete mode 100644 tests/xfs/137.out
 delete mode 100644 tests/xfs/138.out
 delete mode 100644 tests/xfs/139.out
 delete mode 100644 tests/xfs/140.out
 delete mode 100644 tests/xfs/179.out
 delete mode 100644 tests/xfs/180.out
 delete mode 100644 tests/xfs/182.out
--=20
Dave Chinner
david@fromorbit.com

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJU4TyBAAoJEK3oKUf0dfodts0P/3Expqb1QZNC0S+P8yNXIivc
ZZeqN0VZYKMzNAtwLJ8uF8CvzsegYeUeOHj9lRQZr0u3w+xJHgJq03rmIYRM+7D8
51VIIccLQfEyH5enwB0EQEtOckUC8S51V5hPWM01XpItdC7NbpBpkkqKIexnmOXR
iKX9azXd8CMwXRytz3XIITxzwRwoENFFawwvin+vT90N1xEjFYuAbQLeNpeLbUGf
U07A4TesdFsgvzdqaG2ezE3FEXE8+7uvabKP6zwqm3ORyHhPkCCJW690i6UtutTg
9zWrHa/ykZKhw0ni1lSpJwRSCI7+q5wmGdb2dWq0Et+nICkDb8QDTIQJgWsh4MDC
xsf0jWOIx8aLz2q4hy+RM5NKMZ3UCbm6KaWsStakGdcgkU111qIsqUdjl4DzwLn4
xU6AiUwtOeikl1g0d2XL8rQz1Z7cLCEEPNJQYrDmxyilncrCvEMJ4O/DB7D8ZuLa
1TCCzeLmyQiu8ZUi+QEIiKvnriangsetClIp2fO9Kl1PVP8/U8pG4XJ9uQwj71L6
WMMmBaUUJHgRcnWXEJk4RSRZtO73VSFv6Rpu7TtzvqJ0oz4OBFm8KiFXFQ20AF1u
idCVLh+82MDzOxQSMlIWfu3z4ISaAZrQGepXlL5Z0hRnN7eOd/xdG6+kQ8cKUujI
aXYo4QqxkYrR3z/OEIhR
=YvrZ
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
