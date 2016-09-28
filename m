Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:58373 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932455AbcI1AKp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Sep 2016 20:10:45 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1bp2SP-0004yK-AO
        for fstests@vger.kernel.org; Wed, 28 Sep 2016 10:10:41 +1000
Date: Wed, 28 Sep 2016 10:10:41 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 0bbd20b10476
Message-ID: <20160928001041.GD9806@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There's a bunch of changes to quota tests in
this update - previously XFS specific tests have been made generic.
Don't be surprised if there's some new failures reported for these
quota tests on filesystems other than XFS - they may be real
filesystem issues or they may be issues from porting the tests
across to be generic....

-Dave.

The new head of the master branch is commit:

0bbd20b10476 btrfs: test free space tree mount options

New Commits:

Eric Sandeen (4):
      [bda2cdea400d] xfs/260: fix output to match actions
      [ee25b89d8c26] xfs: modify quota tests to work on generic filesystems
      [fe901ccaa7bb] fstests: move now-generic quota tests to generic
      [7369e9c7f90f] xfs: make some xfs project quota tests generic

Eryu Guan (3):
      [88d00424cff1] overlay: sgid inheritance over whiteout
      [a68323584dc6] fstests: require scratch dev in tests using dm targets
      [c27a67f0e7e7] fstests: move now-generic xfs project quota tests gene=
ric

Omar Sandoval (1):
      [0bbd20b10476] btrfs: test free space tree mount options

Wang Xiaoguang (1):
      [73ca62e997ce] generic: truncate heavily reflinked file

Xiao Yang (2):
      [f4a4c64c296e] xfs/098: fix xfs_repair on newer xfsprogs
      [e35b2df320ec] common/rc: fix fsmap check

Zorro Lang (1):
      [81dc4bc7280c] xfs: various operations on mounted fs


Code Diffstat:

 common/quota                           |  55 +++++++++++--
 common/rc                              |  10 ++-
 tests/btrfs/131                        | 153 +++++++++++++++++++++++++++++=
+++++++
 tests/btrfs/131.out                    |  20 +++++
 tests/btrfs/group                      |   1 +
 tests/generic/347                      |   1 +
 tests/{xfs/054 =3D> generic/379}         |  20 ++---
 tests/{xfs/054.out =3D> generic/379.out} |   2 +-
 tests/{xfs/118 =3D> generic/380}         |  11 +--
 tests/{xfs/118.out =3D> generic/380.out} |   2 +-
 tests/{xfs/138 =3D> generic/381}         |   7 +-
 tests/{xfs/138.out =3D> generic/381.out} |   2 +-
 tests/{xfs/260 =3D> generic/382}         |  19 ++---
 tests/{xfs/260.out =3D> generic/382.out} |  12 +--
 tests/{xfs/133 =3D> generic/383}         |  18 +++--
 tests/generic/383.out                  |   8 ++
 tests/{xfs/134 =3D> generic/384}         |  28 +++----
 tests/{xfs/134.out =3D> generic/384.out} |   2 +-
 tests/{xfs/196 =3D> generic/385}         |  15 ++--
 tests/{xfs/196.out =3D> generic/385.out} |   2 +-
 tests/{xfs/262 =3D> generic/386}         |  14 ++--
 tests/generic/386.out                  |   2 +
 tests/generic/387                      |  81 +++++++++++++++++++
 tests/generic/387.out                  |   2 +
 tests/generic/group                    |   9 +++
 tests/overlay/015                      |  97 +++++++++++++++++++++++
 tests/overlay/015.out                  |   6 ++
 tests/overlay/group                    |   1 +
 tests/xfs/006                          |   2 +-
 tests/xfs/098                          |  16 +++-
 tests/xfs/133.out                      |   8 --
 tests/xfs/262.out                      |   2 -
 tests/xfs/264                          |   2 +-
 tests/xfs/284                          | 107 +++++++++++++++++++++++++
 tests/xfs/284.out                      |   8 ++
 tests/xfs/group                        |   9 +--
 36 files changed, 648 insertions(+), 106 deletions(-)
 create mode 100755 tests/btrfs/131
 create mode 100644 tests/btrfs/131.out
 rename tests/{xfs/054 =3D> generic/379} (90%)
 rename tests/{xfs/054.out =3D> generic/379.out} (99%)
 rename tests/{xfs/118 =3D> generic/380} (93%)
 rename tests/{xfs/118.out =3D> generic/380.out} (97%)
 rename tests/{xfs/138 =3D> generic/381} (95%)
 rename tests/{xfs/138.out =3D> generic/381.out} (93%)
 rename tests/{xfs/260 =3D> generic/382} (84%)
 rename tests/{xfs/260.out =3D> generic/382.out} (65%)
 rename tests/{xfs/133 =3D> generic/383} (81%)
 create mode 100644 tests/generic/383.out
 rename tests/{xfs/134 =3D> generic/384} (84%)
 rename tests/{xfs/134.out =3D> generic/384.out} (78%)
 rename tests/{xfs/196 =3D> generic/385} (89%)
 rename tests/{xfs/196.out =3D> generic/385.out} (99%)
 rename tests/{xfs/262 =3D> generic/386} (94%)
 create mode 100644 tests/generic/386.out
 create mode 100755 tests/generic/387
 create mode 100644 tests/generic/387.out
 create mode 100755 tests/overlay/015
 create mode 100644 tests/overlay/015.out
 delete mode 100644 tests/xfs/133.out
 delete mode 100644 tests/xfs/262.out
 create mode 100755 tests/xfs/284
 create mode 100644 tests/xfs/284.out
--=20
Dave Chinner
david@fromorbit.com

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX6wqAAAoJEK3oKUf0dfodc4UQALjXDbTo+YrQYitqzqb1G5d2
06C+SRkt4O4H7x7XS7SBh07AfGQprxi0HQOqKjMBvd7MPha4504uSEi30KzWA6ap
BOKNS+3C39quzhon6bBV/F1PxlIZ1ll8PrgYcS8RC1SWlrYq9TlgL9wvtUhtRGna
4TNcOBqofxSzcRTckBrowrPhkhEzOcJOR7z0dPK96Z2fStIVALS7HZBcCxX2x4Yi
XMLVkX0+iwFLvGN78V1RtOCzZolJjqqhtk9RlSwU66DyV8G9HCxCawOtvh2tiLcK
wiShEuETkDlFFUr9vtD7T/TWjhhfjjrshXllH5rm+E+XjP9HB5NIwwfb1jc4IkRm
ie0wHDX9jNkxVu9vKFrUtGuWjJFClnIXRiicL1S9BlTY4mfChJcvii11im2xK/L8
2lts1qlB8Yd2xwbhM8TP0wJ2TYRJpzgPXhQbsKlo9kq8QISAk5qxCIU3S4OPUsJo
ipXu6kgco+vA67WTsjxmFnn1qRmoZR9uVRbkjD8gEJetUziLdeFd/OqOgnSeEYqL
zUngn71o+M+rowtiZN2/mCKbxZKjtVUaeLeqME1HlB1hamTa6pEuBi9+tG4eZsnq
QhmEP7+TZTFvCnXDYyB3k6gXqZDssxtvaklY+OKxjwmiceBrMVtgqYkubiAvq0Z1
bK7IOdFIIT1AKvg41zfj
=vf/l
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
