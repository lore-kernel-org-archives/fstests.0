Received: from mx1.redhat.com ([209.132.183.28]:33756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbdBEKGV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Feb 2017 05:06:21 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5AF34E4CD
        for <fstests@vger.kernel.org>; Sun,  5 Feb 2017 10:06:21 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v15A6K4M019304
        for <fstests@vger.kernel.org>; Sun, 5 Feb 2017 05:06:21 -0500
Message-Id: <201702051006.v15A6K4M019304@int-mx14.intmail.prod.int.phx2.redhat.com>
Date: Sun, 05 Feb 2017 18:06:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to a9915de6628b
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Z4yagEmUbxTV"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Z4yagEmUbxTV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. As usual, there're new generic and btrfs tests added in
this update, as well as various bug fixes, and a new 'shutdown' group is added
to all tests that shutdown the filesystems on purpose.

I haven't gone through all the backlogs yet, I'll try to do that in next week.

New failures I've noticed in this update:
- generic/407 fails on reflink-enabled XFS, there's an XFS patch in review

Thanks,
Eryu

The new head of the master branch is commit:

a9915de6628b generic: check that destination timestamps are not updated on dedupe

New commits:

Amir Goldstein (1):
      [080446d64f72] generic/007: cleanup $TEST_DIR/$seq dir

Christoph Hellwig (2):
      [de89357bad06] generic: check that destination timestamps are updated on clone
      [a9915de6628b] generic: check that destination timestamps are not updated on dedupe

Darrick J. Wong (3):
      [baaa392c8838] xfs/263: don't hardcode inode numbers in output
      [c83c12e89e5f] xfs/299: don't chmod the underlying mountpoints prior to mounting
      [6c0aa31ff174] xfs/030: ignore lost rmapbt blocks

Lakshmipathi.G (1):
      [34d728d280d8] btrfs: check btrfs-convert with extent and non-extent source

Omar Sandoval (1):
      [caae8cb393ff] xfs/014: fix typo in xfs_quota command

Theodore Ts'o (3):
      [3d99741cebfa] generic/388: use the src/godown program instead of xfs_io
      [781bf49055d8] generic/398: update errors to be returned when doing cross renames w/o keys
      [4a2e9b0c0560] generic: add shutdown group


Code Diffstat:

 common/config         |   3 ++
 tests/btrfs/012       |   3 --
 tests/btrfs/136       | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/136.out   |   2 +
 tests/btrfs/group     |   1 +
 tests/generic/007     |   1 +
 tests/generic/388     |   2 +-
 tests/generic/398.out |   4 +-
 tests/generic/407     |  84 ++++++++++++++++++++++++++++++++++
 tests/generic/407.out |   2 +
 tests/generic/408     |  84 ++++++++++++++++++++++++++++++++++
 tests/generic/408.out |   2 +
 tests/generic/group   |  32 ++++++-------
 tests/overlay/007     |   1 +
 tests/xfs/014         |   2 +-
 tests/xfs/030         |   3 +-
 tests/xfs/263         |   6 ++-
 tests/xfs/263.out     |  52 ++++++++++-----------
 tests/xfs/299         |   7 +--
 tests/xfs/group       |  10 ++---
 20 files changed, 365 insertions(+), 58 deletions(-)
--
Eryu Guan
eguan@redhat.com

--Z4yagEmUbxTV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYlvfPAAoJECZSqilcj+djNC8P/Ax28CbbjQDnGNMyHsXgyr18
sD1Y48NNRa0Ye21Onwg1UodAeCyYeDDutiEK0lPalfyHfRpbKbBqZR6ChBP2cxns
i6JxHf/ns2o99GNXrads1S0r9F2/HHtqsSspalLgMtEXu+JkNpQCXDU4eP1To06l
mBS+Ulea23cN3Lx19/lZrfufwB+m/Rycd1FYJKutlP46kU9G2nMXWB98gt2aze8q
jvb54YUUJlHgz0qTlZwm86RDfzj9DyJfapk5U9XcLtcmULB17D8QCOnM3aY+85O7
nIPvLHeJYryu7CowADO16B+T0Gp8+kZDjKCOqmfA0UXwD7DuRjC15Eqbz6XifLG0
IO/lrmkOtfiSazv+xqynyFXhTMMAV/BxAbEJBii0h1a27SYMfx3ukJWesL7NPSBG
CE99ZWrokGY0Yfvp7hSLSo9f3p1mMPX8F4Tp2lk0wCMJS1Ri1tMU6IyM/E2kgSU2
9UtL4JYEP86fYYxIsu+BvQv+Vugj3yyX8n1ta48/U1xw7sTcviwc6Kja1CcGDQ20
XAV7kDYreo/Zbr7b5ePeLUHV0ysFEY1h3RmOX8YQG3Qnq0PI60V/MxlFSnnmE69Z
PAmS/sfG3gCX/EjHUvaaoZTG+68M5NYGfj1qs36R6uoh5XVxjSQqh8oTt8t34wBg
Q4T2ZimX2B/JqBebSg6R
=F3io
-----END PGP SIGNATURE-----

--Z4yagEmUbxTV--
