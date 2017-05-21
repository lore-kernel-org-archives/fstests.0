Received: from mail-pg0-f68.google.com ([74.125.83.68]:34159 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbdEUISU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 May 2017 04:18:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id u187so14250550pgb.1
        for <fstests@vger.kernel.org>; Sun, 21 May 2017 01:18:20 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id i68sm28474416pfi.72.2017.05.21.01.18.18
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 May 2017 01:18:19 -0700 (PDT)
Message-ID: <59214d4b.4722620a.9134b.10b8@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 21 May 2017 16:18:16 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 9000551d9b78
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rDrWlvioMOjO"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--rDrWlvioMOjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update is a bit bigger than usual, it contains 12
commits from 6 authors, many thanks to all of them!

There're new encryption, SEEK_DATA/HOLE, dax and btrfs tests added, aio related
tests are not running if CONFIG_AIO isn't enabled. Xiao Yang helped clean up
the _require_xfs_io_command() function, there should be no behavior change.

New failures I've noticed in this update:
- generic/436: new SEEK_HOLE test fails on current (4.12-rc1) XFS and ext4

Thanks,
Eryu

The new head of the master branch is commit:

9000551d9b78 fstests: skip AIO-related tests when CONFIG_AIO=n

New commits:

Eric Biggers (2):
      [b245c5e43f28] generic: test that encrypted filenames are presented without collisions
      [9000551d9b78] fstests: skip AIO-related tests when CONFIG_AIO=n

Jan Kara (1):
      [2508d61b63ed] generic: Add more SEEK_HOLE tests

Liu Bo (5):
      [7453987aaa65] common/filter: add _filter_filefrag
      [4f2ea4abc1d6] btrfs: regression test for btrfs dio read repair
      [d3a1eb354e4f] btrfs: regression test for btrfs buffered read's repair
      [495d11cd2da0] btrfs: regression test for nocsum dio read's repair
      [aaf96798d84a] btrfs: regression test for nocsum buffered read's repair

Ross Zwisler (1):
      [44f649f632a8] generic: add regression test for DAX PTE/PMD races

Xiao Yang (2):
      [eaa2d30dbaa1] common: use _require_xfs_io_command() directly to check fiemap
      [704c27f69fa1] common: cleanup _require_xfs_io_command

Zorro Lang (1):
      [5a1b35a74352] fsstress: cleanup flist with test directory together


Code Diffstat:

 .gitignore             |   1 +
 common/filter          |  19 ++++
 common/rc              |  46 ++++++----
 common/reflink         |   2 +-
 ltp/fsstress.c         |  21 +++++
 src/Makefile           |   4 +-
 src/feature.c          |  42 ++++++++-
 src/seek_sanity_test.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++-
 src/t_mmap_cow_race.c  | 106 ++++++++++++++++++++++
 tests/btrfs/140        | 117 ++++++++++++++++++++++++
 tests/btrfs/140.out    |  39 ++++++++
 tests/btrfs/141        | 118 ++++++++++++++++++++++++
 tests/btrfs/141.out    |  39 ++++++++
 tests/btrfs/142        | 140 ++++++++++++++++++++++++++++
 tests/btrfs/142.out    |  39 ++++++++
 tests/btrfs/143        | 150 ++++++++++++++++++++++++++++++
 tests/btrfs/143.out    |  39 ++++++++
 tests/btrfs/group      |   4 +
 tests/generic/043      |   2 +-
 tests/generic/044      |   2 +-
 tests/generic/045      |   2 +-
 tests/generic/046      |   2 +-
 tests/generic/047      |   2 +-
 tests/generic/048      |   2 +-
 tests/generic/049      |   2 +-
 tests/generic/092      |   2 +-
 tests/generic/112      |   1 +
 tests/generic/113      |   1 +
 tests/generic/301      |   2 +-
 tests/generic/302      |   2 +-
 tests/generic/305      |   2 +-
 tests/generic/326      |   2 +-
 tests/generic/327      |   2 +-
 tests/generic/328      |   2 +-
 tests/generic/352      |   2 +-
 tests/generic/353      |   2 +-
 tests/generic/372      |   2 +-
 tests/generic/414      |   2 +-
 tests/generic/425      |   2 +-
 tests/generic/435      |  99 ++++++++++++++++++++
 tests/generic/435.out  |   4 +
 tests/generic/436      |  64 +++++++++++++
 tests/generic/436.out  |   2 +
 tests/generic/437      |  61 +++++++++++++
 tests/generic/437.out  |   2 +
 tests/generic/group    |   3 +
 tests/xfs/180          |   2 +-
 tests/xfs/182          |   2 +-
 tests/xfs/184          |   2 +-
 tests/xfs/192          |   2 +-
 tests/xfs/193          |   2 +-
 tests/xfs/198          |   2 +-
 tests/xfs/200          |   2 +-
 tests/xfs/204          |   2 +-
 tests/xfs/207          |   2 +-
 tests/xfs/208          |   2 +-
 tests/xfs/209          |   2 +-
 tests/xfs/210          |   2 +-
 tests/xfs/211          |   2 +-
 tests/xfs/212          |   2 +-
 tests/xfs/213          |   2 +-
 tests/xfs/214          |   2 +-
 tests/xfs/231          |   2 +-
 tests/xfs/232          |   2 +-
 tests/xfs/240          |   3 +-
 tests/xfs/241          |   3 +-
 tests/xfs/344          |   2 +-
 tests/xfs/345          |   2 +-
 tests/xfs/346          |   2 +-
 tests/xfs/347          |   2 +-
 70 files changed, 1420 insertions(+), 73 deletions(-)
--
Eryu Guan
eguan@redhat.com

--rDrWlvioMOjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZIUwqAAoJECZSqilcj+djdO0QAMCBKU/cFpSMEV0hHAkAaRqg
PuYjNe8DSCYHgWwKJoYNyMLNeSGirAD68draJWDRlgTkxKXxOnKjKluZqiHhtm+Z
VDvA8YDLonabvJVW/nFCt5ZCsgIemuCINXJYt6X4n0PStoHCaZQRC4MR8YoCZLY4
PRHOhcuE/X2qsWoDh7wTzdfAh6AKAUE8Eu6r9MIK2mfAt8fbHoBIeQJVuEM4kYi1
ExA989t3dE1254zXKHYzSYGprL8ZC3rRmzOk6DWNOpuUMu965NANoW1yqnNbUR7p
qv8h5yOQLSN/M3qffbu2XNAX0xdSpnXB8BbbLbvpMcR9133naZnidvo8I2DVkknO
pARl35nGDDTW5kAvS7uoj8QVWLSa70jGsXd4w2gy2ziT2/iJ1z5Xz1oenO4fYzpA
1chig+p/UI+gBktDf2EM/3MxlyjprErPMHLcWik+XS5cquqTB4FTwEFPI+MclKqf
pGBllf/V4Quv6EiEaB3yAqIC6I1DrUkgdRpdboGwKfpm4Dvc7e+zRu+hQvFw3ICO
l9/77TBF414I2AQ/Bd98stD9RoOTrF9amb7RWohfDTrF08olUf4gwwW/w3fAH77+
MNA6kftMk6pjSSqQOvcfUDH+3JxxeIMAi+lyvuz3C4Jkpv4RZA5koz65fGQOtGs5
pPCEyHpEcU4v7rBrlkQZ
=u7wW
-----END PGP SIGNATURE-----

--rDrWlvioMOjO--
