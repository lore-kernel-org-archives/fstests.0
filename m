Received: from mail-pl1-f194.google.com ([209.85.214.194]:38561 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfGGNY2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Jul 2019 09:24:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id 9so6842904ple.5
        for <fstests@vger.kernel.org>; Sun, 07 Jul 2019 06:24:28 -0700 (PDT)
Message-ID: <5d21f28b.1c69fb81.189a3.d3a9@mx.google.com>
Date: Sun, 07 Jul 2019 21:24:19 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 7d059370d24a
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SAv9JhAoT2ib"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--SAv9JhAoT2ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update moves most of the extN tests in shared
directory to ext4 dir, which is done by Theodore Ts'o, and ext4 tests will also
be run when testing ext2/3.

The only new test is generic/562, and it currently fails on btrfs.

Thanks,
Eryu

The new head of the master branch is commit:

7d059370d24a generic: test cloning large exents to a file with many small extents

New commits:

Eric Biggers (1):
      [3eb73bbda3b5] common/encrypt: check that contents encryption is usable

Filipe Manana (1):
      [7d059370d24a] generic: test cloning large exents to a file with many small extents

Theodore Ts'o (5):
      [f736b1c257ca] shared,ext4: move ext4-specific tests out of shared/
      [43df23e1b553] check: add ext4 group list when testing ext2 and ext3
      [6cbaba4a08b7] shared,ext4: move ext[234]-specific tests out of shared/
      [a9868eb48d62] shared,generic: move shared/006 to generic/
      [c3cb6fbde713] shared,generic: move tests using duperemove to generic/


Code Diffstat:

 check                                     |  6 ++-
 common/encrypt                            |  4 +-
 common/rc                                 |  7 +++
 common/reflink                            | 18 +++++++
 tests/{shared/001 => ext4/036}            |  6 +--
 tests/ext4/036.out                        |  2 +
 tests/{shared/003 => ext4/037}            |  6 +--
 tests/ext4/037.out                        |  2 +
 tests/{shared/004 => ext4/038}            |  4 +-
 tests/ext4/038.out                        |  2 +
 tests/{shared/272 => ext4/039}            |  2 +-
 tests/{shared/272.out => ext4/039.out}    |  2 +-
 tests/{shared/005 => ext4/040}            |  2 +-
 tests/{shared/005.out => ext4/040.out}    |  2 +-
 tests/{shared/007 => ext4/041}            |  2 +-
 tests/{shared/007.out => ext4/041.out}    |  2 +-
 tests/{shared/289 => ext4/042}            |  2 +-
 tests/{shared/289.out => ext4/042.out}    |  2 +-
 tests/ext4/group                          |  7 +++
 tests/{shared/006 => generic/558}         |  7 ++-
 tests/generic/558.out                     |  2 +
 tests/{shared/008 => generic/559}         | 10 ++--
 tests/{shared/008.out => generic/559.out} |  2 +-
 tests/{shared/009 => generic/560}         | 10 ++--
 tests/{shared/009.out => generic/560.out} |  2 +-
 tests/{shared/010 => generic/561}         | 10 ++--
 tests/generic/561.out                     |  2 +
 tests/generic/562                         | 78 +++++++++++++++++++++++++++++++
 tests/generic/562.out                     |  5 ++
 tests/generic/group                       |  5 ++
 tests/shared/001.out                      |  2 -
 tests/shared/003.out                      |  2 -
 tests/shared/004.out                      |  2 -
 tests/shared/006.out                      |  2 -
 tests/shared/010.out                      |  2 -
 tests/shared/group                        | 11 -----
 36 files changed, 168 insertions(+), 66 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--SAv9JhAoT2ib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl0h8kAACgkQJlKqKVyP
52PJUxAAkXv87X0JWu+hsL2Skhdlj1mGiojyu7QohVN7b+G4ZoraBjZ9q7sQfCZz
E1w2xJsnRf7fepQ6ZXPeVqLfrJLeQC/LHVi3QOHWFllYg0X4Gc+BJGxXXrZBXdwD
HsF4zoZUCgYITIEsYE/lcq3yAxAfGv355zV0/ZcWpsWkE3ujE907POa9sUrlv8OL
pXZnthCbonigErW5egu6/vH6BHyJBntVjionkjGOm7s5k2L2/LOAnT3dDE2Y6+dw
L0uJSuosNPVufQLGoTkN2mDuBh0YkZ79oL1UTjRRGqdKlkfWhZ+8So5SoYwYKmPc
EWPQFOnxM6KFT6oVCIBoqHClvo3l+vI1x8JGQ0/TXbIW3k9yHMKBrVhEOuh32KRC
VerAZw6TW9/3aZmH0jfB/Djw/behIQ1TUjuW0t+cyM9Ds/iHXJ+xjGd4uULEhJFy
9PMoKqz5xSQg5k5JFoPFOWUIFxSSS62qLCHC5zaO7gAcPe2uVZFa/LLmkixz+MYP
BnGS3k8HvHIMlONGnv/LyEF7dMPJlECXDTAufMGv1ZNB4ShktKYCkDOEkHG1DCqF
HfpxS+XH6IWtrJ8R6jS7hPHesJy2p+Tq/Y26xBnCGU60+VrFGV2XE45+Z5nDJTpm
PTQs5yLwmm959XB+tIlBIoMUGvBgEND51SPpsmX+eERwnDsTdOo=
=XHBj
-----END PGP SIGNATURE-----

--SAv9JhAoT2ib--
