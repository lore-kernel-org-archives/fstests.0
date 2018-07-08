Received: from mail-pl0-f45.google.com ([209.85.160.45]:41637 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932757AbeGHNac (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Jul 2018 09:30:32 -0400
Received: by mail-pl0-f45.google.com with SMTP id w8-v6so4833757ply.8
        for <fstests@vger.kernel.org>; Sun, 08 Jul 2018 06:30:32 -0700 (PDT)
Message-ID: <5b4211f6.1c69fb81.a1632.43a6@mx.google.com>
Date: Sun, 08 Jul 2018 21:30:26 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 0804dc173618
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J1vGGdE0cT9h"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--J1vGGdE0cT9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in another pile of xfs fuzz
tests from Darrick and fixes a build failure introduced in last release. My
apology again for breaking the build without noticing it in release testing,
and thanks to Lu Fengqi's fix!

Thanks,
Eryu

The new head of the master branch is commit:

0804dc173618 xfs: fuzz every field of every structure and test kernel crashes

New commits:

Darrick J. Wong (2):
      [a125b86c8632] generic: mread past eof shows nonzero contents
      [0804dc173618] xfs: fuzz every field of every structure and test kernel crashes

Liu Yiding (1):
      [4d2a860d0434] xfs/262: remove -y parameter

Lu Fengqi (1):
      [9b846275d61a] build: fix undefined macro: AC_PACKAGE_NEED_GETXATTR_LIBATTR

Scott Mayhew (1):
      [0f849ea13f95] nfs/001: ignore the header in nfs4_getfacl output

Zorro Lang (1):
      [9374c74733fe] xfs: skip copy fs test on large device


Code Diffstat:

 common/fuzzy          | 54 +++++++++++++++++++++++++++---------------------
 configure.ac          |  2 +-
 m4/package_attrdev.m4 |  4 ++--
 tests/generic/499     | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/499.out |  2 ++
 tests/generic/group   |  1 +
 tests/nfs/001         |  2 +-
 tests/xfs/077         |  1 +
 tests/xfs/262         |  2 +-
 tests/xfs/284         |  1 +
 tests/xfs/453         | 46 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/453.out     |  4 ++++
 tests/xfs/454         | 46 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/454.out     |  4 ++++
 tests/xfs/455         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/455.out     |  6 ++++++
 tests/xfs/456         | 46 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/456.out     |  4 ++++
 tests/xfs/457         | 46 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/457.out     |  4 ++++
 tests/xfs/458         | 46 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/458.out     |  4 ++++
 tests/xfs/459         | 46 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/459.out     |  4 ++++
 tests/xfs/460         | 46 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/460.out     |  4 ++++
 tests/xfs/461         | 47 ++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/461.out     |  4 ++++
 tests/xfs/462         | 47 ++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/462.out     |  4 ++++
 tests/xfs/463         | 47 ++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/463.out     |  4 ++++
 tests/xfs/464         | 48 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/464.out     |  4 ++++
 tests/xfs/465         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/465.out     |  5 +++++
 tests/xfs/466         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/466.out     |  5 +++++
 tests/xfs/467         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/467.out     |  5 +++++
 tests/xfs/468         | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/468.out     |  5 +++++
 tests/xfs/469         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/469.out     |  5 +++++
 tests/xfs/470         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/470.out     |  5 +++++
 tests/xfs/471         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/471.out     |  5 +++++
 tests/xfs/472         | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/472.out     |  5 +++++
 tests/xfs/473         | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/473.out     |  5 +++++
 tests/xfs/474         | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/474.out     |  5 +++++
 tests/xfs/475         | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/475.out     |  5 +++++
 tests/xfs/476         | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/476.out     |  5 +++++
 tests/xfs/477         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/477.out     |  5 +++++
 tests/xfs/478         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/478.out     |  5 +++++
 tests/xfs/479         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/479.out     |  5 +++++
 tests/xfs/480         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/480.out     |  5 +++++
 tests/xfs/481         | 50 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/481.out     |  4 ++++
 tests/xfs/482         | 48 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/482.out     |  4 ++++
 tests/xfs/483         | 48 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/483.out     |  4 ++++
 tests/xfs/484         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/484.out     |  5 +++++
 tests/xfs/485         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/485.out     |  5 +++++
 tests/xfs/486         | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/486.out     |  5 +++++
 tests/xfs/487         | 49 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/487.out     |  4 ++++
 tests/xfs/488         | 49 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/488.out     |  4 ++++
 tests/xfs/489         | 49 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/489.out     |  4 ++++
 tests/xfs/group       | 37 +++++++++++++++++++++++++++++++++
 85 files changed, 2139 insertions(+), 28 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--J1vGGdE0cT9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbQhFFAAoJECZSqilcj+dj0/8QAIRX0G+bvemIc/loPLlETKf7
Kdd9lOX/Crd+bw1Q5Fp4oloufZXP9EfIX4zd+0WsNgVnEdTUKR2dPjEtokptp6Nd
jbj/aH1JDhgpU42/FFpifv18oLXBXBA1+maZlu54A+JW2FsB3Mo7cOMLJjf9W4Sp
r0MNex+LmTOfypm0NbRfn2WdAm6H/QYDVuUlrmbIu6CG3QblVunCqdfpa7e+kbsr
ehm3BYldHyQUEda5q5B6ipUROPUcnyUgzWUVY5oiB9LibEKRLYqs6tsO2k0VZQZ/
gMK+n2W27nBGyj4UESgTW3HoHII2hYShfLmsIMg+undoKQt+V4GszNt3tR7oPpwn
ReQW4SzChK0aFPa3e2YSMVD/2c3q7exWqLkRQGDmxKV2akmb3ecvXtd8YRyBTedb
20VR7t2oJxYYT8M32aqR4/BJw7XDn9Fd1aMORgu39x/y+zK9yFnH59aurEkjXVhy
GbNkxjwdtmCTG+F8S3csjbK035jjSLqRWWTMUqFoW1AjkJu9zQx0DutJEIbyUY20
fayKMv3DeA3zmh7qsLPIktau1i/KNogiSphCjoHsyX3C8zb6hPvm0u2/sgi5Wey+
8hLlVmU5Va5tbXfiC6DwOMuD4IrH+B/agd46r6HZp8vbv4XJEKQ+7LNmfUx3urna
kNIyOp+3a9ti4Vd41HL5
=kIWH
-----END PGP SIGNATURE-----

--J1vGGdE0cT9h--
