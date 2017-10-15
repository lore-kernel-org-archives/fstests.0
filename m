Received: from mail-pf0-f195.google.com ([209.85.192.195]:50689 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdJOLvi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Oct 2017 07:51:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id b6so5335204pfh.7
        for <fstests@vger.kernel.org>; Sun, 15 Oct 2017 04:51:38 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id u7sm4934018pfh.142.2017.10.15.04.51.35
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Oct 2017 04:51:36 -0700 (PDT)
Message-ID: <59e34bc8.07ed620a.9d1bf.b097@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 15 Oct 2017 19:50:21 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 954d9953c545
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RrvsO5DbMQ2l"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--RrvsO5DbMQ2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is the biggest update I've ever made, which
contains 23 commitst including several new tests, various improvements and bug
fixes:

- rework of OVERLAY_MOUNT_OPTIONS handling, now it works as expected
- turn _filter_xfs_dmesg() into a generic helper to filter intentional warnings
  on mixed DIO/buffer I/O
- 3 new generic tests, 1 new test for xfs and 1 for overlay
- misc bug fixes and minor improvements

Many thanks to those who contributed new tests, fixes & enhancements and/or
helped review patches!

New failures I've noticed in this update:
- generic/464 fails as fs corruption on XFS, a fix was posted to XFS list
- overlay/041 fails with current v4.14-rc4 tree, the fixes are pending on merge

Thanks,
Eryu

The new head of the master branch is commit:

954d9953c545 xfs: test for NULL xattr buffer problem during unlink

New commits:

Amir Goldstein (7):
      [8cbd341fb41d] overlay: remove stale implementation of _scratch_mount_options
      [510ea2920102] overlay: use default overlay mount options _overlay_mount_dirs()
      [371f7f52f295] overlay: create helper _overlay_scratch_mount_dirs()
      [8df8ad0cd253] overlay: fix _overlay_config_override of MOUNT_OPTIONS
      [766e711f8466] overlay: move _overlay helpers to common/overlay
      [ca5b89eb90fb] overlay: deduplicate code in overlay mount helpers
      [44f438c84020] overlay/036: expect EBUSY for dir inuse only when mounting with index=on

Andreas Gruenbacher (2):
      [602b27e93537] common/rc: Further improve gfs2 support
      [76ddf492fb04] generic/422: Do not hardcode space used by files

Brian Foster (1):
      [954d9953c545] xfs: test for NULL xattr buffer problem during unlink

Chandan Rajendra (2):
      [46a4c2b0edf1] overlay/038: Miscellaneous fixes
      [2acbc4f07ab2] overlay: Test consistent d_ino feature for non-samefs setup

Christoph Hellwig (1):
      [080570c002a3] generic: add a new test for racing AIO COW writes

Dave Chinner (1):
      [132f37916d2c] generic/166: speed up on slow disks

Eryu Guan (1):
      [a6479f764670] generic: test race between block map change and writeback

Hans Holmberg (1):
      [d565ff1d5a72] xfs/246: add _require_scratch

Ilya Dryomov (3):
      [ca93e26865ab] common: move _filter_xfs_dmesg() to common/filter
      [5aa662733ab0] common: turn _filter_xfs_dmesg() into _filter_aiodio_dmesg()
      [228aee780f13] generic/036,208: whitelist [iomap_]dio_complete() WARNs

Rostislav Skudnov (2):
      [cca45d1b9237] holetest: Use pid_t type for fork(2) return value
      [c4ccc3498eff] bulkstat_unlink_test_modified: Remove extraneous if statement

Theodore Ts'o (1):
      [0b6f8ab93c42] ext4: skip project quota tests if the kernel does not support them

Zheng Liu (1):
      [21db51dd980c] generic: test race when checking i_size on direct i/o read


Code Diffstat:

 .gitignore                                         |   2 +
 common/config                                      |   4 +
 common/filter                                      |  25 +++
 common/overlay                                     | 152 ++++++++++++++
 common/quota                                       |   3 +
 common/rc                                          | 172 ++-------------
 common/xfs                                         |  22 --
 .../aio-dio-append-write-read-race.c               | 230 +++++++++++++++++++++
 src/aio-dio-regress/aio-dio-cow-race.c             | 115 +++++++++++
 src/bulkstat_unlink_test_modified.c                |  13 +-
 src/holetest.c                                     |  11 +-
 tests/generic/036                                  |   2 +
 tests/generic/095                                  |   7 +-
 tests/generic/166                                  |  11 +
 tests/generic/208                                  |   2 +
 tests/generic/224                                  |   9 +-
 tests/generic/247                                  |   9 +-
 tests/generic/422                                  |  51 ++---
 tests/generic/422.out                              |  23 +--
 tests/generic/446                                  |  10 +-
 tests/generic/463                                  |  59 ++++++
 tests/generic/463.out                              |   2 +
 tests/generic/464                                  | 131 ++++++++++++
 tests/generic/464.out                              |   2 +
 tests/generic/465                                  |  75 +++++++
 tests/generic/465.out                              |   3 +
 tests/generic/group                                |   3 +
 tests/overlay/005                                  |   2 +-
 tests/overlay/010                                  |   3 +-
 tests/overlay/014                                  |   8 +-
 tests/overlay/031                                  |  11 +-
 tests/overlay/035                                  |   3 +-
 tests/overlay/036                                  |  37 +++-
 tests/overlay/037                                  |  14 +-
 tests/overlay/038                                  |  11 +-
 tests/overlay/041                                  | 193 +++++++++++++++++
 tests/overlay/041.out                              |   2 +
 tests/overlay/group                                |   1 +
 tests/xfs/246                                      |   1 +
 tests/xfs/433                                      |  90 ++++++++
 tests/xfs/433.out                                  |   2 +
 tests/xfs/group                                    |   1 +
 42 files changed, 1232 insertions(+), 295 deletions(-)
--
Eryu Guan
eguan@redhat.com

--RrvsO5DbMQ2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZ40nZAAoJECZSqilcj+djmLsP/3CLFLe+mxNwKllJeF6UUKht
NdsogKhm+ST9FdETmhl+swvt/tIiH8yXFt7CJDFENb+i2pLz+yyUmzBVCOb/1u1S
6F1YmknV69YBLx05W8FmXhRWMlZSpfN1Ac3xeJsfDqPBHuh92XC9uF2zjL4GF6Sv
ijDd47SonNv9qN4eVollXZ7D4zOIxlVtKYQKBSGnqHPNZgU67cROZhoZv0PHObIf
8DhdnnfG7R9rqqjWm3D0WH7AlJ5jm1BEurjhRvz90gjz//gd4DFdp1LC3Staxdgd
ivbuvOw+8j94NJCqXkGPenUhuBaJC3gujsdnU/X3skp0DhAgILBxR8hktb4Ms32w
nJPqkWig8WigCQfMdHcZSgmXeoinpf533j6IQVtPCcPx8LGyFpHSJqfMeurjkWcC
1CqgGMIgyCmnIcWlXSz7T7KGOKIxuaiUnQ7bZmhi2+IfomWUlCN7UwCAb9vxG5lf
P/SX2BBTi1xeAflwKbjNwTD/VkbNTJvHa8EQR8DmNkNjQZRrM/jeXm1MLtu33nUk
XpMP/tZeMRnbuxWe+4gEyX52YqQ6LrsgP5hfPAlfuQQE0QWNspShGZcY+q4+j0AH
kMSPQBXgzNCcScCZo41dE2R3h6hzwTdAFSVTsWMx3EbXwYsh7VtSxnExZYauVFof
Ldjg260kJO1MU/UrxWUd
=AUJF
-----END PGP SIGNATURE-----

--RrvsO5DbMQ2l--
