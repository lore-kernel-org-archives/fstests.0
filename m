Received: from mail-pg1-f171.google.com ([209.85.215.171]:38378 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXPlH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Mar 2019 11:41:07 -0400
Received: by mail-pg1-f171.google.com with SMTP id j26so2700773pgl.5
        for <fstests@vger.kernel.org>; Sun, 24 Mar 2019 08:41:07 -0700 (PDT)
Message-ID: <5c97a511.1c69fb81.15ca3.8692@mx.google.com>
Date: Sun, 24 Mar 2019 23:40:59 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 1bdf7c350840
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PdA05SM1z0DN"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--PdA05SM1z0DN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the patches from Darrick J.
Wong, which includes a new xfs_copy/xfs_metadump test and various fixes &
improvements. (Many thanks, Darrick!) And there should be no new failures after
this update.

Thanks,
Eryu

The new head of the master branch is commit:

1bdf7c350840 xfs: test xfs_copy and xfs_mdrestore on the populate images

New commits:

Chandan Rajendra (1):
      [0ead9a42fda9] _require_prjquota: Disable tests only when using realtime fs

Darrick J. Wong (10):
      [07094a9652c0] check: improve test list randomization
      [97fd33c76740] check: really improve test list randomization
      [5144d265fd60] generic/042: fix stale disk contents check
      [42d6e34f3fbc] generic/032: fix unwritten extent checks
      [1321879c826e] generic/454: stop the test if we run out of space
      [54a148574f2b] ext4/023: don't require scrub for ext4 populated image creation
      [5034ff6c1f55] common/populate: refactor _scratch_populate_cached
      [c2cda723f666] common/populate: support multiple cached images
      [8309b39a8ad8] fstests: fix broken _require_scratch usage
      [1bdf7c350840] xfs: test xfs_copy and xfs_mdrestore on the populate images

zhangxiaoxu 00467499 (1):
      [2caa208e3ab5] generic/131: Create server.out manually.


Code Diffstat:

 check             | 16 +++++----
 common/populate   | 71 +++++++++++++++++++++++++---------------
 common/quota      |  6 ++--
 randomize.awk     | 12 ++++---
 tests/ext4/023    |  1 -
 tests/generic/026 |  1 -
 tests/generic/032 | 17 ++++++----
 tests/generic/042 | 10 ++++--
 tests/generic/100 |  3 --
 tests/generic/131 |  3 ++
 tests/generic/454 |  7 +++-
 tests/generic/506 |  2 +-
 tests/xfs/065     |  2 +-
 tests/xfs/108     |  1 +
 tests/xfs/109     |  2 +-
 tests/xfs/194     |  4 ++-
 tests/xfs/261     |  2 ++
 tests/xfs/284     |  1 +
 tests/xfs/503     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/503.out | 12 +++++++
 tests/xfs/group   |  1 +
 21 files changed, 213 insertions(+), 58 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--PdA05SM1z0DN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcl6R1AAoJECZSqilcj+djAQ0QAIvX5LG0ZUTIGeNhEdYQW3dI
OzySI3TsCF29gQSUtbPrmfanmHIN+HlcB2oIfsiyusfXDpr3jmMwZkgxn15vUcDo
WrFupS9sY+ZhXNINj31rdwkWopE2ZYFT2ajnso9yJzWRm6kso7M4GZW5aGEHhlSo
0mOi8b7/I6vDjemWJHtkr0KnIDPHZODpNqiN/rnTo/SeSRavDYIJw19LCC1YCXGG
EwaQnvnsTT/57wIOuYr7bMRz9smTy2xaLciuVH7L/GB0abauWptQ1AMZuep7Svq/
/+vWUVCUZS+Vg6DMi6bHEYO3/c/3pQXFriLOa5G519vTKTRH7XFOueIbVd7cbT94
uf7+Jjtu6xD9VLdPTpGGyUTNeVnLIzaAoMTk2DfzGIfv45FcGmF1Q1z5VC73lzFS
ZG9pG4bnF1EbQxXYCNHuHAL9waGf5cV5QJR4osyhHgCy2BP+noTQQ4+dSQeF0kz6
WKQQ4dp6qPvPK2csnCSVvUu646kE5JR54nYBMGiMIqTA5caqN3+8TU9Z3DACLsNa
WgqpS96W/gn6Y1sZ3WRK1iMQJXq8DcSSENvfaZ9nw6DempxccymY7qfyGMvwxZLi
HyE0pqfgndc8mAfu/m+RcMOb3cDkQK1i6+243V5V6YY4mpG+svkCe5ouisHuOrmn
TtNwWe6t7ilJXGxN2pL0
=1scV
-----END PGP SIGNATURE-----

--PdA05SM1z0DN--
