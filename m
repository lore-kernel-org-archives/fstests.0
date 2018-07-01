Received: from mail-pl0-f50.google.com ([209.85.160.50]:43876 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbeGANH5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Jul 2018 09:07:57 -0400
Received: by mail-pl0-f50.google.com with SMTP id c41-v6so6650665plj.10
        for <fstests@vger.kernel.org>; Sun, 01 Jul 2018 06:07:57 -0700 (PDT)
Message-ID: <5b38d22b.1c69fb81.4b6b6.8ebb@mx.google.com>
Date: Sun, 01 Jul 2018 21:07:51 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 42b851446ff1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BExkXyoZrmS7"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--BExkXyoZrmS7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains 8 new tests mainly for xfs and
btrfs, but they all should pass with latest Linus tree. Others are random
updates including license update to src/log-writes/* and fixes to build
infrastructure.

Thanks,
Eryu

The new head of the master branch is commit:

42b851446ff1 build: remove <attr/xattr.h> check

New commits:

Darrick J. Wong (2):
      [e04c7b7e3021] xfs/365: fuzz inobt in ag 1
      [494b07e34015] xfs: regression test for rmapbt fdblocks accounting problems

Filipe Manana (1):
      [89ee377df5f2] btrfs: test power failure while qgroups rescan is in progress

Josef Bacik (1):
      [a0f89557ca46] fstests: add SPDX license comments for src/log-writes/*

Lu Fengqi (3):
      [d61c29d32fab] fsstress: remove include <attr/xattr.h>
      [652fda3ee172] src/t_immutable: use sys/xattr.h instead of attr/xattr.h
      [42b851446ff1] build: remove <attr/xattr.h> check

Luis R. Rodriguez (1):
      [103258a566b4] build: fix install target using sudo

Marco Benatto (1):
      [6a98def59ca9] xfs: Test root inode parent pointer repairing

Qu Wenruo (1):
      [73576ea71e1a] btrfs: test if btrfs will corrupt nodatasum compressed extent when replacing device

Xiao Yang (1):
      [f86ce7cc4b2b] common: Add _dmsetup_create and _dmsetup_remove helpers

Zorro Lang (4):
      [f74e7e186c97] shared: dedupe a single big file and verify integrity
      [e1f4b06edbd7] shared: iterate dedupe integrity test
      [6b6ff4a005a1] shared: dedupe with random io race test
      [c6ded48a3141] xfs: test bad character in xfs_db field list selector string


Code Diffstat:

 common/config               |   1 +
 common/dmdelay              |   9 +---
 common/dmerror              |   9 ++--
 common/dmflakey             |  14 ++----
 common/dmhugedisk           |  15 +++----
 common/dmlogwrites          |   9 +---
 common/dmthin               |  19 ++++----
 common/rc                   |  14 ++++++
 configure.ac                |   1 -
 ltp/fsstress.c              |   3 --
 m4/package_attrdev.m4       |  25 -----------
 src/log-writes/log-writes.c |   1 +
 src/log-writes/log-writes.h |   1 +
 src/log-writes/replay-log.c |   1 +
 src/t_immutable.c           |   2 +-
 tests/Makefile              |   2 +-
 tests/btrfs/166             |  57 ++++++++++++++++++++++++
 tests/btrfs/166.out         |   2 +
 tests/btrfs/167             |  76 ++++++++++++++++++++++++++++++++
 tests/btrfs/167.out         |   2 +
 tests/btrfs/group           |   2 +
 tests/generic/085           |  11 ++---
 tests/shared/008            |  64 +++++++++++++++++++++++++++
 tests/shared/008.out        |   3 ++
 tests/shared/009            | 104 ++++++++++++++++++++++++++++++++++++++++++++
 tests/shared/009.out        |   4 ++
 tests/shared/010            |  94 +++++++++++++++++++++++++++++++++++++++
 tests/shared/010.out        |   2 +
 tests/shared/group          |   3 ++
 tests/xfs/365               |   2 +-
 tests/xfs/450               |  64 +++++++++++++++++++++++++++
 tests/xfs/450.out           |   2 +
 tests/xfs/451               |  57 ++++++++++++++++++++++++
 tests/xfs/451.out           |   2 +
 tests/xfs/452               |  49 +++++++++++++++++++++
 tests/xfs/452.out           |   7 +++
 tests/xfs/group             |   3 ++
 37 files changed, 646 insertions(+), 90 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--BExkXyoZrmS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbONG2AAoJECZSqilcj+djkYwP/Ap1+vNQFo7OO2DgoTcU/WTt
fke9iw7NxzGIWOAFFzFPVq/5ESyzmgzDPdbWOIR9Ic5AWu9685HzdpkMGBJCfjoz
glQQ4rcJS9gA+a2JGe5IXF2bcFgrz2F9s8FMfQepdNv1CDvow975fQ1CqfWqPkun
Lqy5TQgIs+xGU05W5NYW+1X44Ho1qHoSrzChO1WD/YHnx9xyiuWRfpcrvBH3BzK/
rLDTMleM1dczGexgPa0LS/HYeHFV9F0ppnkJRy/h0LsgW0WXORoNo9oMM4QbFYgJ
0uA4X1VR6t6j5ig39M2WZLywuJoP2vhTOhpSo94Q7DZPBGcU5sc122wYz9nAu3vQ
sVmPn4l84kEFds2mklzOAHqTZxNvJXJFdfn0ENbxaA1gI+sQrjEnmbAb4ezCemD1
8CPM6tLne6pAsjTIpKSNg4KRUWtR4FCBIQdkD6ikTHZIkP8nu2bwNit01HrN5Ern
qYDD0h5yL+YROdsLm4xfPOHH8lf3SxvXKLu5Wzur9ykA2Q2MeaIqB9vtCIbuSEBT
SNuza1IhwMwnsYFL/BqImUvm1S3cVTBLn01NWD1itCg8moFy5VgTgvnSYpLZ2RA9
C/zDBQHsHaQKp5eC30EHlqynbWH0IuXi0OydTPwUcKBLW9/m6vMeCiktpHNEYhUN
Qisa4GhVA+ta++QL6yMH
=Xmvg
-----END PGP SIGNATURE-----

--BExkXyoZrmS7--
