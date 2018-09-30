Received: from mail-pg1-f182.google.com ([209.85.215.182]:44202 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeI3UIA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Sep 2018 16:08:00 -0400
Received: by mail-pg1-f182.google.com with SMTP id g2-v6so7585574pgu.11
        for <fstests@vger.kernel.org>; Sun, 30 Sep 2018 06:34:56 -0700 (PDT)
Message-ID: <5bb0d0ff.1c69fb81.f2e79.edf7@mx.google.com>
Date: Sun, 30 Sep 2018 21:34:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 84cbe4d0dddb
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G2STNHQZSE9B"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--G2STNHQZSE9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in Chandan Rajendra's patches
to make tests work with 64k block size. These patches has been tested with
various block size configurations on x86_64 and ppc64 hosts by Chandan, Zorro
and me, so they should work just fine. Many thanks to Zorro for helping test
the changes!

Thanks,
Eryu

The new head of the master branch is commit:

84cbe4d0dddb generic/108: work with 64k block size

New commits:

Chandan Rajendra (20):
      [a97909b3f95e] xfs/009: work with 64k block size
      [05802a3a8a86] xfs/050: Fix "Push past soft inode limit" case
      [371cf4cf16d1] xfs/050: work with 64k block size
      [204974ec0733] xfs/074: work with 64k block size
      [d06c2700b261] xfs/127: work with 64k block size
      [0e2b99951fa1] xfs/139: work with 64k block size
      [7a7641063ac3] xfs/140: work with 64k block size
      [42389505f9ff] xfs/190: work with 64k block size
      [8758c0065fc4] xfs/299: Fix "Push past soft inode limit" case
      [dac07d081642] xfs/299: work with 64k block size
      [8039c7cd3c49] xfs/325: Inject free_extent error after CoW operation
      [ec6c4e7f857e] generic/102: work with 64k block size
      [b1180a9f7510] generic/172: work with 64k block size
      [4ba5b5073556] common/punch: Filter fiemap output by FS block size
      [b206b62abc1d] generic/177: work with 64k block size
      [5eb645e8b633] generic/230: work with 64k block size
      [4f4b89cdf353] generic/235: work with 64k block size
      [d3a02a6e8a51] generic/459: work with 64k block size
      [743bd85bfe76] generic/018: to work with 64k block size
      [84cbe4d0dddb] generic/108: work with 64k block size

Chao Yu (1):
      [c01e04888139] generic: test uid/gid recovery after power failure

Eric Sandeen (1):
      [9437a0343211] xfs/270: allow corrupted xfs_db write


Code Diffstat:

 common/punch          | 19 ++++++++---
 tests/generic/018     |  2 +-
 tests/generic/102     |  4 +--
 tests/generic/102.out | 20 +++++------
 tests/generic/108     |  4 +--
 tests/generic/172     |  4 +--
 tests/generic/177     | 20 ++++++-----
 tests/generic/177.out | 23 ++++++++-----
 tests/generic/230     | 23 +++++++------
 tests/generic/230.out | 16 ++++-----
 tests/generic/235     |  2 +-
 tests/generic/235.out |  4 +--
 tests/generic/459     | 14 ++++----
 tests/generic/505     | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/505.out |  2 ++
 tests/generic/group   |  1 +
 tests/xfs/009         | 92 +++++++++++++++++++++++++++++++++++++++++--------
 tests/xfs/009.out     | 66 ++++++++++++++++++------------------
 tests/xfs/050         | 26 +++++++++-----
 tests/xfs/050.out     | 60 ++++++++++++++++----------------
 tests/xfs/074         | 23 ++++++++++---
 tests/xfs/127         |  2 +-
 tests/xfs/139         | 15 ++++----
 tests/xfs/139.out     |  8 +++--
 tests/xfs/140         | 12 ++++---
 tests/xfs/190         | 26 +++++++++-----
 tests/xfs/270         |  3 +-
 tests/xfs/299         | 29 ++++++++++------
 tests/xfs/299.out     | 48 +++++++++++++-------------
 tests/xfs/325         |  5 +--
 tests/xfs/325.out     |  2 +-
 31 files changed, 451 insertions(+), 218 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--G2STNHQZSE9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbsNCGAAoJECZSqilcj+djX0YQAKSmEmCyjfOts6Rstm+WxaSZ
IKUGtddWH5Q80aEvLDajWCMJkh644RtaUhUJnDzqYchR2BpX9IZnqFbxoWl/byN7
+GH26PaRvzTkms/8U3tRGa93w7+X3jU/CNt/NhPiAfSKahH2v2Ne67jkTTL0G2WS
ruQ0Uwv9M3Z/GgGHOc6YGHkXyTocmEnReLCzs+Z6NOlwtGHRzGv+XF3HeiE5X8HS
4JWcfhS6PPO5VV0NriIn0lDq4BxfX9idc5AUQmtuqNfbEuabTziCno88F4g+JvCl
Krx5PsBB9flOcEvSOTGc9JbapRNfKCmscBS8loTUm81D4/9wtAQqaiDOAaIsu6n+
cn0XByeuyGtGzEyJ9zcnIdd4ux0at3OZGb71KuR5TyHLg51g+RUb8xFsGuMmTEav
e4ou/5E9Y8SvzvYlFfOvmB8X5BeV+sEi72E1eYzsyT4IBvWZZ9zfHonRthhC0+1i
spsUNfIFhUJaactu1F0kHuBhNtwP5Yn0adpsoeD4WCpHuMAi56j1FXBCx393dazg
XtFlw4GaaZ3Z0rQVGkewy3846DR8AI3+TP9unu8IYlzNjqTb35xytwRcWpZeC4jF
QPk39GzrwjCZLTdXf80EFrsmY2jAq0qZiJe6fg6FNoDXv9pdV6kqooRqOHTmG+Hj
dMMyxeGRIRWZAsT67Q3P
=jDlT
-----END PGP SIGNATURE-----

--G2STNHQZSE9B--
