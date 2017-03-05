Received: from mx1.redhat.com ([209.132.183.28]:38756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbdCEFwS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Mar 2017 00:52:18 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12F2161BB4
        for <fstests@vger.kernel.org>; Sun,  5 Mar 2017 05:52:18 +0000 (UTC)
Received: from localhost (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v255qG9Y027893
        for <fstests@vger.kernel.org>; Sun, 5 Mar 2017 00:52:17 -0500
Message-Id: <201703050552.v255qG9Y027893@int-mx13.intmail.prod.int.phx2.redhat.com>
Date: Sun, 05 Mar 2017 13:52:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to de86b2851707
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DJ7NLaxoQMNk"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--DJ7NLaxoQMNk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The way to test overlayfs has been improved in this
update, the ability to mount/umount base filesystem underlying overlayfs is
added, the main purpose is to help catch overlayfs bugs related to leaking
objects in underlying (base) fs. The way to config overlayfs tests is also
changed, but the old way is still supported but not deprecated and might be
removed some day. For more details you can see README.overlay file. This is not
a small update to fstests and may break your tests and configs, though Amir and
I have done quite some testings. Please report bugs and/or contribute patches
if you hit problems.

As usual, there're also new tests and bug fixes in this update, please see
detailed commit logs below.

New failures I've noticed in this update:
- generic/414 fails on btrfs, extents are not merged properly on reflinks

Thanks,
Eryu

The new head of the master branch is commit:

de86b2851707 ext4: add _require_ext4_mkfs_feature to check different features

New commits:

Amir Goldstein (10):
      [64343ded7d85] fstests: sanity check that test partitions are not mounted elsewhere
      [5e33bfcf232e] fstests: use _test_mount() consistently
      [f20654ac4a74] fstests: canonicalize mount points on every config section
      [4e965d851602] fstests: fix test and scratch filters for overlapping DEV/MNT paths
      [db24846eb379] fstests: allow overlay SCRATCH_DEV to be a base fs mount point
      [7626c8534176] generic/064: access SCRATCH_MNT after _scratch_mount
      [6f5ba68b7b22] overlay: rename OVERLAY_LOWER/UPPER/WORK_DIR
      [bcba40e3df09] overlay: configure TEST/SCRATCH vars to base fs
      [2ab614524d61] overlay: mount/unmount base fs before/after running tests
      [33e41998959e] overlay: use OVL_BASE_SCRATCH_MNT instead of SCRATCH_DEV

Christoph Hellwig (1):
      [5fa3e61cc220] xfs/004: relax freespace check

Darrick J. Wong (4):
      [58a0630b2bb3] xfs/348: classify this as a fuzzer test
      [47bef98866f8] xfs: minor fixes to the fsmap tests
      [7927c5c94c51] reflink: test adjacency of reflinked blocks
      [161ba4c1b794] xfs: stress test xfs_scrub

Eric Biggers (1):
      [8cb6ef62cc42] common/rc: accept "localdomain" to mean YP/NIS disabled

Nave Vardy (1):
      [c024334d132b] generic: reflink concurrent operations

Xiao Yang (1):
      [de86b2851707] ext4: add _require_ext4_mkfs_feature to check different features

Zorro Lang (1):
      [5f9cbd7089fe] common/xfs: fix unexpected failure on real 4k sector device


Code Diffstat:

 README                |  16 ++--
 README.overlay        |  46 ++++++++++
 check                 |  18 ++--
 common/config         | 162 ++++++++++++++++++++++++++++++-----
 common/filter         |  33 +++++++-
 common/rc             | 228 ++++++++++++++++++++++++++++++++++++--------------
 common/xfs            |   2 +-
 tests/ext4/003        |   2 +-
 tests/ext4/306        |   1 +
 tests/generic/064     |  10 ++-
 tests/generic/414     | 106 +++++++++++++++++++++++
 tests/generic/414.out |  11 +++
 tests/generic/415     |  93 ++++++++++++++++++++
 tests/generic/415.out |   2 +
 tests/generic/group   |   2 +
 tests/overlay/001     |   7 +-
 tests/overlay/002     |   2 +-
 tests/overlay/003     |   5 +-
 tests/overlay/004     |   7 +-
 tests/overlay/005     |  30 +++----
 tests/overlay/006     |  10 +--
 tests/overlay/008     |   8 +-
 tests/overlay/009     |   2 +-
 tests/overlay/010     |  10 +--
 tests/overlay/011     |   6 +-
 tests/overlay/012     |   4 +-
 tests/overlay/013     |   4 +-
 tests/overlay/014     |  19 +++--
 tests/overlay/015     |   2 +-
 tests/overlay/016     |   2 +-
 tests/overlay/017     |   2 +-
 tests/overlay/018     |   2 +-
 tests/overlay/019     |   2 +-
 tests/overlay/020     |   2 +-
 tests/overlay/021     |   6 +-
 tests/overlay/022     |   2 +-
 tests/overlay/023     |   4 +-
 tests/overlay/023.out |   2 +-
 tests/overlay/024     |   2 +-
 tests/overlay/027     |   2 +-
 tests/overlay/028     |   2 +-
 tests/overlay/029     |   4 +-
 tests/xfs/004         |   7 +-
 tests/xfs/262         |  70 ++++++++++++++++
 tests/xfs/262.out     |   3 +
 tests/xfs/273         |   3 +-
 tests/xfs/275         |   4 +-
 tests/xfs/276         |   2 +-
 tests/xfs/285         |  85 +++++++++++++++++++
 tests/xfs/285.out     |   4 +
 tests/xfs/286         |  87 +++++++++++++++++++
 tests/xfs/286.out     |   4 +
 tests/xfs/group       |   5 +-
 53 files changed, 963 insertions(+), 193 deletions(-)
--
Eryu Guan
eguan@redhat.com

--DJ7NLaxoQMNk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYu6YDAAoJECZSqilcj+djdA4QAKO4LbZci2uOTDSo2jYuYecq
DqZ6u7/GAaq1brrMJ02RMvRjsRKzRRCcnOSzokBi6G4kG49iyPLlTfjOQ2fvIWVS
UbTKtQGwFdERWaUGcUroHMtYSxfOWYuIDJAh7HsjRoRkg7m1jsYPQzE6CtD8FqY2
ejaR3XADiPWZGmv+KBiTxjwaCDpSqSKLdd9BoNUKinEdztlG92GZ1KSHonqdaKk3
iyEOlcyKFzA7RL4mcoBA1kYWLR8SrmgE3NLTCiZClIUHEyuNbep/YXl7SNS2TZTt
6lmBz3a7cy0Pm2QNsXcnAjSUH+/tXWA76hEEISb1LRyQQ6HTdu/HyalCwAb+6R9W
JlvtEHJQ4yuhtgW8gvnqVRlQRN8rsr1lg+iD3Ri6XwxSZw+uy+1vS5/nHuo7R/D4
MwJrbSz8+ehCN0BOZPAJZv0++sifMdN3PkHw+YWwk3E+E4B/bfV0/d6ajooQi/iV
b7xv6V645NYRp18Xx6+bxtEJCgbtJAV/Nhdccu5URMghzvZg10toryk9uqtDEa65
PY0WDmu84A82+4hEU8sQ0uf9xRTcnROEpFImHlJ66pjCiIjSqC5q0XmAYBaNvbda
R6F1KdmyKbJtHNgjAZ3fbCYNTB/OZ8pf3uE2q66eFmwVZyVJv6N7qzaGCWJ4BioX
L3yf5ITvFZtugICvlxQ7
=F+PI
-----END PGP SIGNATURE-----

--DJ7NLaxoQMNk--
