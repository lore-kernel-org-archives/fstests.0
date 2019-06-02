Received: from mail-pl1-f194.google.com ([209.85.214.194]:34472 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfFBNxt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 2 Jun 2019 09:53:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so1572350plt.1
        for <fstests@vger.kernel.org>; Sun, 02 Jun 2019 06:53:48 -0700 (PDT)
Message-ID: <5cf3d4ea.1c69fb81.df197.f615@mx.google.com>
Date: Sun, 02 Jun 2019 21:53:44 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 5543924d1378
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8RApo2TLr4UT"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--8RApo2TLr4UT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is another huge update that mainly pulls in the
fscrypt patchset from Eric Biggers and some overlay fixes/improvements and new
test from Amir Goldstein and zhangyi (F).

The new overlay test (overlay/065) currently fails with latest Linus tree
(v5.2-rc2). And as it's a big update, please report and/or contribute patches
if you hit any new bugs, thanks!

Thanks,
Eryu

The new head of the master branch is commit:

5543924d1378 overlay: Test mount error cases with overlapping layers

New commits:

Amir Goldstein (4):
      [84fbcec4ec17] common/rc: fix _repair_scratch_fs error reporting
      [16b7039194d4] fstests: define constants for fsck exit codes
      [d9f4cb727142] overlay: fix _repair_scratch_fs
      [5543924d1378] overlay: Test mount error cases with overlapping layers

Anthony Iliopoulos (1):
      [81d4ff4e23d1] xfs/278: use _scratch_xfs_repair helper instead of xfs_repair

Eric Biggers (7):
      [881eccda8222] common/encrypt: introduce helpers for set_encpolicy and get_encpolicy
      [f68bd53129ef] fscrypt-crypt-util: add utility for reproducing fscrypt encrypted data
      [35525fb5ed79] common/encrypt: support requiring other encryption settings
      [04224f38e09a] common/encrypt: add helper for ciphertext verification tests
      [97d114d23e5a] generic: verify ciphertext of v1 encryption policies with AES-256
      [726b41e3e76d] generic: verify ciphertext of v1 encryption policies with AES-128
      [7758756cb144] generic: verify ciphertext of v1 encryption policies with Adiantum

Qu Wenruo (1):
      [5eec120ca007] btrfs/190: Fix a typo for seqres.full

Yang Xu (1):
      [51d449643842] ext4: regression test for online resizing maximum blocks

Zorro Lang (1):
      [d6f88082b4df] generic: aio random write and verify stress test

zhangyi (F) (2):
      [af3a63c4dcdd] overlay: correct fsck.overlay exit code
      [2815cda6ac22] overlay: fix exit code for some fsck.overlay valid cases


Code Diffstat:

 .gitignore               |    1 +
 common/config            |   11 +
 common/encrypt           |  479 +++++++++++++-
 common/overlay           |   36 +
 common/rc                |   17 +-
 src/Makefile             |    3 +-
 src/fscrypt-crypt-util.c | 1633 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/190          |    2 +-
 tests/ext4/024           |    3 +-
 tests/ext4/035           |   54 ++
 tests/ext4/035.out       |    3 +
 tests/ext4/group         |    1 +
 tests/generic/395        |   26 +-
 tests/generic/395.out    |    2 +-
 tests/generic/396        |   15 +-
 tests/generic/397        |    3 +-
 tests/generic/398        |    5 +-
 tests/generic/399        |    3 +-
 tests/generic/419        |    3 +-
 tests/generic/421        |    3 +-
 tests/generic/429        |    3 +-
 tests/generic/435        |    3 +-
 tests/generic/440        |    5 +-
 tests/generic/548        |   41 ++
 tests/generic/548.out    |    5 +
 tests/generic/549        |   41 ++
 tests/generic/549.out    |    5 +
 tests/generic/550        |   43 ++
 tests/generic/550.out    |   10 +
 tests/generic/551        |   87 +++
 tests/generic/551.out    |    2 +
 tests/generic/group      |    4 +
 tests/overlay/045        |   46 +-
 tests/overlay/046        |   49 +-
 tests/overlay/056        |    9 +-
 tests/overlay/065        |  154 +++++
 tests/overlay/065.out    |   21 +
 tests/overlay/group      |    1 +
 tests/xfs/278            |    2 +-
 39 files changed, 2731 insertions(+), 103 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--8RApo2TLr4UT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJc89STAAoJECZSqilcj+djkQYQALFlCHCrtxrBEF+q+vX8Nv9K
oZAx6ghIf6wvCByD3H7vmI+HcUN8x84k1zS84E7fJQKpyluOZFUBj87jtH0+B2Db
+vdzDVIfBBi4nGbKHGLxQm6ggmiuLLWazLFVG5//noVEn+Mb3JTKclH12X/ZU3WO
n6qbUvjN54Sp+ca2H1u7CrFCIP7yBDhGfZuVUicb0eITkj7qKdNUq7G29J+3FIem
R4zYcAlUe+Ns6fxCajwPxV9B3BiGHvmIl7tEVU06Lv3jz/hTvlcoHfDQcYl/pjxl
rWVhH1kar84yS+zPgQnhNLCtt2l1Dd25HthLQ8hSLByDaS2XYAd6u87458w0c16v
nwwVQfz0oppBRKZtuAGiLVX/AOy0Am3f3uq25VKQnqmqL6wqnadJctm8xVoTn2jT
4yrR0q1I7J3eprtmtpTF2t63SpAvTP9zR0cqknJuPDm/0o7VHrvXgbQsVvsQylbK
H8sFZCfDXTYMuk5VRQZC0mg3LGPHtAv2RDY0VsnsGpRyJQ5nWpjq0wf2rMBI8wjU
IpAdkH/UkY00MwXXtX2npm1Y60xF8xQeS4mWLill46NBy3Sw9LCvAyHlXuAs0/W9
R+20QQgWmZbPkp7t21lzii5HzcQYzqh17noOd6X52Wruy5HzzD2gwupvErZCCwcl
nxvlDk1oWiwZq4nxUX1r
=77ye
-----END PGP SIGNATURE-----

--8RApo2TLr4UT--
