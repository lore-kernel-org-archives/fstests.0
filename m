Received: from mail-pg1-f170.google.com ([209.85.215.170]:35117 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfCJQWk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Mar 2019 12:22:40 -0400
Received: by mail-pg1-f170.google.com with SMTP id e17so2113333pgd.2
        for <fstests@vger.kernel.org>; Sun, 10 Mar 2019 09:22:39 -0700 (PDT)
Message-ID: <5c8539cd.1c69fb81.ea32.c908@mx.google.com>
Date: Mon, 11 Mar 2019 00:22:32 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 6be9a7861854
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WsIuq9LdUcDv"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--WsIuq9LdUcDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're two new tests to exercise fs consistency after
fsync and a power failure, and one of the tests generic/534 currently fails on
btrfs. Also, various bugs have been fixed as usual.

Thanks,
Eryu

The new head of the master branch is commit:

6be9a7861854 xfs/42[01]: don't disturb unwritten status with md5sum

New commits:

Chao Yu (1):
      [ead024c292fe] generic: test i_mode recovery after power failure

Christoph Hellwig (1):
      [6be9a7861854] xfs/42[01]: don't disturb unwritten status with md5sum

Darrick J. Wong (6):
      [86d99a8225f2] common/rc: fix get_max_lfs_filesize
      [cd508feb01fa] xfs/010: use correct type for finobt corrupting
      [6f157d593afb] shared/298: unmount filesystem before examining underlying storage
      [20d7818417ae] ext4/032: SCRATCH_DIR -> SCRATCH_MNT
      [0ff18d3679f7] generic: test statx attribute_mask setting
      [c2d149681c12] populate: force large finobt creation on xfs

Filipe Manana (1):
      [8694a9b144d6] generic: add test for fsync after shrinking truncate and rename

Ronnie Sahlberg (1):
      [2780486bdd99] generic/097: split user.* xattr tests to new test


Code Diffstat:

 common/populate       |  17 ++++++
 common/rc             |   2 +-
 tests/ext4/032        |   4 +-
 tests/generic/097     |  84 -----------------------------
 tests/generic/097.out | 105 ------------------------------------
 tests/generic/532     |  70 ++++++++++++++++++++++++
 tests/generic/532.out |   2 +
 tests/generic/533     | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/533.out | 108 ++++++++++++++++++++++++++++++++++++++
 tests/generic/534     |  66 +++++++++++++++++++++++
 tests/generic/534.out |   8 +++
 tests/generic/535     | 105 ++++++++++++++++++++++++++++++++++++
 tests/generic/535.out |   2 +
 tests/generic/group   |   4 ++
 tests/shared/298      |  18 +++++++
 tests/xfs/010         |   6 +--
 tests/xfs/420         |   6 +++
 tests/xfs/421         |   6 +++
 18 files changed, 561 insertions(+), 195 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--WsIuq9LdUcDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJchTkGAAoJECZSqilcj+djsLYP/3yr4besK0NrzGhAp/13SI2c
TAmDJs69aJQIGwKSBajCvGAQ99fAMblDQ6YSi+PwXZzDQBFEkf2eoiK9Lh93VYhg
Vx523XtMcYuw92HbxhXTVK00JJH7D8ezUA8ojXQha6fWvbxWL2Aee4eGeI4rnDWS
dKsdFFKEFazfGxS2Qu/92ZGqucZsC91HeYLXaA+2PNiB9FLxPK43PNHyoP19E8f8
fkp+tYXQ2lA4d40nz7AHL/dR7mtnpyC2WUW3EDLeHeVGxoeaiMhBTiPSZLZeYoAx
01uwzg0u2462QYfdzdZ9A0NDiOLYyatVMK9ZlAhCPeHgOZnaRx24/eYquTohsN1m
rhjQe95hrJSmiy59xghK9fBbKjsGHv1PRih69bhFcGZrb1yFJT05ud3ZBsqcYdjY
jpueZni7PlGeAEKnSkhIDkfNNJdlC4OW0sRYPPeYAfWG5f+5Wnh6JOsHbqOWpq9t
CkqmIkca1u3c+tkCDsvnOjbmqlmbpYNvEUZr2wfChCaYob2zL+mEzG2Nh/hijTSn
Bjy8vwnoedaGATYzU6hRhR7goqMNleVPygYqD0xEkADsH732PwUrA2bL+Pc7E1s8
qAI79i1FS1megsAfAbHxGtwvWtmqzcUjsoMTRwT0IXIfrO3rsdOUkH8vGAqTvV43
StWVbjTZ22ufbcESlr9y
=Hdnt
-----END PGP SIGNATURE-----

--WsIuq9LdUcDv--
