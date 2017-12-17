Received: from mail-pg0-f46.google.com ([74.125.83.46]:37591 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbdLQM5Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Dec 2017 07:57:24 -0500
Received: by mail-pg0-f46.google.com with SMTP id y6so8120769pgp.4
        for <fstests@vger.kernel.org>; Sun, 17 Dec 2017 04:57:24 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id m15sm16439897pga.45.2017.12.17.04.57.20
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Dec 2017 04:57:21 -0800 (PST)
Message-ID: <5a3669b1.0f3f630a.52997.cd04@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 17 Dec 2017 20:57:15 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 3d04948b8238
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WYxbKOPYRSky"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--WYxbKOPYRSky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal new tests + bug fixes update.
Currently the new ranged fiemap test (generic/473) fails on XFS, because
there's no final decision on the expected behavior yet and discussion has
stalled somehow. And the test is in its 7th revision and has been pushed back
and forth many times, I think it's better to take the test for now with the
hope that the failure will drive further discussion and result in a fix either
in the test or in the kernel or both.

And it's near the end of year, I'll take most of the rest of year off, so the
review and response from me will be slow. I'll try to keep the weekly update on
track, but no promise for the next two weeks :)

New failures I've noticed in this update:
- generic/472 fails on most filesystems, which is a partial direct write test,
  and the fix is still under review.
- generic/473 fails on XFS, see above for details.

Thanks,
Eryu

The new head of the master branch is commit:

3d04948b8238 README: document group fsgqa is required

New commits:

Darrick J. Wong (3):
      [9d5ea22aea6b] common/xfs: fix scrub support probing again
      [88b65cf51e82] generic/45[34]: test line draw characters in file/attr names
      [d69d223dfa90] xfs: fix tests to handle removal of no-alloc create nonfeature

Goldwyn Rodrigues (3):
      [eef2209b4fdb] common/rc: Check pwrite parameters in _require_xfs_io_command
      [6a2fd57fb821] generic: Test RWF_NOWAIT
      [1ed1aad2f879] generic: Partial direct write test

Luis R. Rodriguez (3):
      [07350fc7583d] generic/group: add 304 to dedupe group
      [2353022e570f] build: update AC_PACKAGE_WANT_GDBM() and src/dbtest.c to build
      [3d04948b8238] README: document group fsgqa is required

Nikolay Borisov (1):
      [1a377268b0d1] generic: initial fiemap range query test

Theodore Ts'o (2):
      [be341e36fd02] common: rework _require_ext4_mkfs_feature
      [c71205ec949f] common/populate: fix S_IFDIR.FMT_BLOCK and ATTR.FMT_LOCAL for ext4 encryption


Code Diffstat:

 README                |   1 +
 common/populate       |   4 +-
 common/rc             |  61 +++++++++-------
 common/xfs            |   2 +-
 m4/package_gdbmdev.m4 |   8 +++
 src/dbtest.c          |   1 +
 tests/ext4/003        |   3 +-
 tests/ext4/025        |   2 +-
 tests/ext4/026        |   2 +-
 tests/ext4/306        |   7 +-
 tests/generic/453     |   5 ++
 tests/generic/454     |   5 ++
 tests/generic/471     |  75 +++++++++++++++++++
 tests/generic/471.out |  13 ++++
 tests/generic/472     |  96 +++++++++++++++++++++++++
 tests/generic/472.out |   9 +++
 tests/generic/473     | 107 +++++++++++++++++++++++++++
 tests/generic/473.out | 196 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |   5 +-
 tests/xfs/013         |   6 +-
 tests/xfs/014         |   3 +
 tests/xfs/104         |   2 +-
 tests/xfs/109         |   2 +-
 23 files changed, 575 insertions(+), 40 deletions(-)
--
Eryu Guan
eguan@redhat.com

--WYxbKOPYRSky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaNmj5AAoJECZSqilcj+djfgQQAIYySAGyNrXKuvDOu8D7QaEh
KZUj+AVCdQSI/U4mItHI3RZGiEW+W+fJv6SSumojtr2JEwznuVLlfvU4B7hHUZc3
Qwg2rZ0t+aR+HBr7dYYAapivsMJw8z2EdlJ4e91L7BnvWmsRNfsIfZWWQ6I9WiBn
nK24jkebobGuGxMCfjfribJANI7zj071Z3+8X/cmGvROWD46zr/dYrpgLPpMiN4M
7QZOM99Z2X26GHJZs+w6EN7PFTzprBd29hsI/qdcMYiYYa+7qFhkcyLXq0y+S5Ep
Vz1UZSxqZe3VXtfktJ+SfdsZ4POZTtjq8CL1kkYWoI0tPWrwWsc8KHC++z1QbCkV
gsVDhinzILjlRVEyXS647JAtl0eZzKzfsptkJRMM27fAOBUnZNx5SBKQxnXei27I
S1Y4D/lGMrzyPPKWVCOkqPmFmprzCmSj//aDCh6dz7MPPWeiiYLgUdHayWAebsv1
edQ1pt+zM7ysJJTkOQX+hTEOS6dJUz6GbGq4A7Hz0zHsHSV7yTduft/kTmTOoXI/
cOkJuV6uoVFVtQwSMYopYlrfa0S4sEfwu6vZOf/YPVijlNjd7PNSNy4lA8YMNIQe
ZO1Tx4uQ3+4cK1DiUHb0QeLvtFu/GsGvtRdKKZ2bRbXUj9JhbJSnteVU9gOkZmNJ
DJZ2m2tWeBF9+5HlsEDg
=DdcT
-----END PGP SIGNATURE-----

--WYxbKOPYRSky--
