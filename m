Received: from mail-pg1-f182.google.com ([209.85.215.182]:42679 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeHLR5T (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Aug 2018 13:57:19 -0400
Received: by mail-pg1-f182.google.com with SMTP id y4-v6so6420670pgp.9
        for <fstests@vger.kernel.org>; Sun, 12 Aug 2018 08:18:58 -0700 (PDT)
Message-ID: <5b704fe0.1c69fb81.4f152.ebd0@mx.google.com>
Date: Sun, 12 Aug 2018 23:18:51 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to c2c34214652a
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PZQgelyzEg9P"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--PZQgelyzEg9P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal update that contains two new tests
(generic and btrfs test) and three minor bug fixes. Please note that the two
new tests both fail currently, hopefully the fixes all will be landed in 4.19
kernel.

Thanks,
Eryu

The new head of the master branch is commit:

c2c34214652a generic: show locks info owned by dead process

New commits:

Filipe Manana (1):
      [7931e0696c8e] btrfs: test writing into unwritten extent right before snapshotting

Lu Fengqi (1):
      [aa0b82a9fd97] src/stat_test: fix undefined reference to `xfstests_statx'

Omar Sandoval (1):
      [ed6826096002] generic/228: fix restoration of kernel.core_pattern sysctl

Xiong Murphy Zhou (1):
      [c2c34214652a] generic: show locks info owned by dead process

Zorro Lang (1):
      [a4f1e0a585fd] xfs/288: notrun if xfs_db write command fails


Code Diffstat:

 src/statx.h           |  2 +-
 tests/btrfs/170       | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/170.out   |  8 ++++++
 tests/btrfs/group     |  1 +
 tests/generic/228     |  2 +-
 tests/generic/504     | 59 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/504.out |  2 ++
 tests/generic/group   |  1 +
 tests/xfs/288         |  8 ++++++
 9 files changed, 156 insertions(+), 2 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--PZQgelyzEg9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbcE9eAAoJECZSqilcj+dj7LwP/182q+ZcJQRe6rPngSLmqScf
9EZdGc306ajDu87Rh+Ol3S34ZjcFvxdJ74Ck6w6U9QhzrVWNxu5/NdAdiDO7Cvio
xmQTqDof7aFyMUHUioWt1J73UJqr2UQKkpWgJEkBtMOcWezeuGIMPrfNFa8mCgkp
sY9Exhc+kPEl8RytY6mwqnj5itZSG112OJfXml8lFrx0DcvUCbob7e8Bd3DELI85
8iEMWE5YNdxgcR0LLAOq9cnuBRCXNoW17dlwd5Tpdwho6PjYFDRHzuiA2/dEaB7t
4XbVI7e4FPnlQO5P+nhdJIH5t+2Pj3DPMoshxqMXkcm5lKskxoRHknjHA1Y5k8TA
1Rayt4hoqK78TzbnrH9DJE6FabhuGeuPW2ze7K7Zpnlh0C5dhOUcQCyNpWPxcAfe
1Cqg3IYwGA2cBPVRjPn2Ill3DI3KEzaPLj0IzNUACqTy4Tl1xk4qFqt6O9BdwvfO
bMicHMshGDdttGekzcojTzpxboNTkboa2wa+m+4F2hZ/mptcBLUAyofqAb2OeNUB
DZMyuLHPvG9L4IO6aSZP7LMB65x4nN7WHD9uvkvM2InE1wKzz2REOqH5Rkr6lD6T
GSfC1ZCI/6busphk4MW+F5zzeUQTkeeHt0mBcUcJM2hMSy7JVZddpHcjbt8k30+S
Im3EkXwsI4pXxEZ6j35c
=Xk8F
-----END PGP SIGNATURE-----

--PZQgelyzEg9P--
