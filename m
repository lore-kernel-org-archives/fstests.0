Received: from mail-pl0-f66.google.com ([209.85.160.66]:33329 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932123AbeFQOpD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Jun 2018 10:45:03 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so7135591plb.0
        for <fstests@vger.kernel.org>; Sun, 17 Jun 2018 07:45:02 -0700 (PDT)
Message-ID: <5b2673ed.1c69fb81.edb93.99d8@mx.google.com>
Date: Sun, 17 Jun 2018 22:44:53 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to f15f05a9ba87
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6nISXdb8B1p"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--d6nISXdb8B1p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal update with two new tests (for btrfs
and generic) and other bug fixes.

New failures I've noticed in this update:
- generic/498 fails on btrfs with v4.18-rc1 kernel, the fix should be on btrfs
  list

Thanks,
Eryu

The new head of the master branch is commit:

f15f05a9ba87 xfs/170: increase agsize for bigger internal log size

New commits:

Darrick J. Wong (1):
      [16be889bc92b] generic/223: port t_stripealign to FIEMAP

Filipe Manana (1):
      [8e38c06860f4] generic: add test for fsync of directory after creating hard link

Hou Tao (1):
      [9618c0adca1a] ltp/fsx: output the seed value after logid is initialized

Jakob Unterwurzacher (1):
      [072ff808cf9c] generic/391: add _require_odirect

Misono Tomohiro (1):
      [e1ca827f833b] btrfs: Add test that checks rmdir(2) can delete a subvolume

Zorro Lang (2):
      [9b07c2d4fd52] common: improve regex in _check_dmesg
      [f15f05a9ba87] xfs/170: increase agsize for bigger internal log size


Code Diffstat:

 common/rc             |   2 +-
 ltp/fsx.c             |   4 +-
 src/Makefile          |   4 +-
 src/t_stripealign.c   |  72 ++++++++++++++++++++++++-----
 tests/btrfs/165       | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/165.out   |   2 +
 tests/btrfs/group     |   1 +
 tests/generic/391     |   1 +
 tests/generic/498     |  65 ++++++++++++++++++++++++++
 tests/generic/498.out |   2 +
 tests/generic/group   |   1 +
 tests/xfs/170         |   9 ++--
 tests/xfs/170.out     |   8 ++--
 13 files changed, 270 insertions(+), 25 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--d6nISXdb8B1p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbJnNjAAoJECZSqilcj+dj2qUP/j9aWsq/CSdARMzUnLBHS5nn
5l0QRCD66elbZl3Nz2qnByBpGsODvx3KeWM8f5NmJrZv+UhUY8x+LYEPdlPFA3HU
llJSe8mgpetrkgkenwAZXXjPURwUVU8PZptn+RAfu8Ox3ozkd7UvlWfV82pb6v+i
tRBLa3tiTCAKrR/9IAXDv8aoO003ufO++ZPLRA4CrvjDGPScbdlZf77DR1EAH5gK
6a8larO2za35dTTOwdGI8VxSEuDfxMB5Yaa1G/n1OLKDEnu4fVQlBWeFfkcVyXX9
9g8u+xr/CKOoP7W2u4LBGFv8zG4boHfi6Mdh50+PO5hTDi8aNzyMnBz8YOCHvhUp
KBgn+X5DOqn1yFDtMosW379r7nLno6CcXtkS7hD3G6pseIaSa174LI1ZFgmUgCOe
UehBGV/K5Cnm3vFY/kZJCSMcV87RVoDtaAoyRirKNXNfFxV9QHA3m2QnoGwtnB8A
fJ+uPQOI03juCSBcoNVDlZjbuz15DlJriUamYdjH3K4L9fGe0LCIYg4SgzRKh/HJ
C7aiu2aBQCI0E00ColkIqa9mco9hfWqby4M5W0fRRoeoha7TUspBUXY8CnZnehNc
fNpWflixANwNbhJAX85iF+iy8Ik4ICxyuWq+LF3ekzuyb1Zr075bmjeZV7E6Q8eG
8bM35mtoHgxYTwqe1Mu/
=mRl4
-----END PGP SIGNATURE-----

--d6nISXdb8B1p--
