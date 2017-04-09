Received: from mail-pf0-f196.google.com ([209.85.192.196]:34131 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbdDIJst (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Apr 2017 05:48:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id o126so5743989pfb.1
        for <fstests@vger.kernel.org>; Sun, 09 Apr 2017 02:48:49 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id k190sm18527464pge.5.2017.04.09.02.48.46
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Apr 2017 02:48:48 -0700 (PDT)
Message-ID: <58ea0380.c78e630a.22dd3.a5d5@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 09 Apr 2017 17:48:38 +0800
Subject: [ANNOUNCE] fstests: master branch updated to a589a208405d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jJHH9RzQyZKg"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--jJHH9RzQyZKg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal update that has two new tests added,
one generic test and one overlay test, and other improvements and bug fixes.
Note that IRIX support is removed in the new test template, eventually we may
want to remove whole IRIX support.

New failures I've noticed in this update:
- overlay/030 fails as append-only dirs are not honored in truncate operation

Thanks,
Eryu

The new head of the master branch is commit:

a589a208405d src/t_immutable: add ftruncate to append only tests

New commits:

Amir Goldstein (4):
      [e1a49994e579] fstests: _require_chattr() must get an input arg
      [8a8a4b95b25c] generic/079: use _require_test_program
      [941ea73ec3c5] overlay: test immutable and append-only upper files
      [a589a208405d] src/t_immutable: add ftruncate to append only tests

Filipe Manana (3):
      [a62c85dbabf3] common/rc: check fs supports xfs_io falloc's specific flags
      [c7cbc1cd614a] generic: test for number of bytes used by files after buffered writes
      [f3c84f3d553e] generic/071: check if fs supports fallocate KEEP_SIZE flag

Qu Wenruo (1):
      [073b2def71ff] fstests: Remove IRIX os support from template


Code Diffstat:

 common/rc             |  27 ++++++-----
 new                   |   2 +-
 src/t_immutable.c     |  15 ++++++
 tests/generic/071     |   2 +-
 tests/generic/079     |   6 +--
 tests/generic/422     | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/422.out |  41 ++++++++++++++++
 tests/generic/group   |   1 +
 tests/overlay/027     |   2 +-
 tests/overlay/030     |  73 +++++++++++++++++++++++++++++
 tests/overlay/030.out |   5 ++
 tests/overlay/group   |   1 +
 12 files changed, 283 insertions(+), 19 deletions(-)
--
Eryu Guan
eguan@redhat.com

--jJHH9RzQyZKg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJY6gCzAAoJECZSqilcj+dj9zUP+waSHGrz6dX2OJTcRRyoTNeN
Bp81mufyaDXPrVIaI18u31qbul9OcfedSLFwziIYxvMJxQ+LfjM9AdzqmnTUHBFJ
J7JER9/9HSlC/qad7WAF5AOHvWBhviLBC3qHTTw6VPtbuP6p1YF9Gty15f7LCurk
ju9fhTv6rAWAG5oAPzF04XZ2hMkgWzLbTrmgC/gorOyOesXlsW5Zjfat0br2EDAq
Ep1bMftSeXTjVkOR175md3nn7Y8yLo0OZiRwWu2Dn0qIMEomPEb1PWjlRS/0ZX5h
yFTJkE8zboRBe9fc36El+tj1bEqBpyjIHuTcqh0nceDcZ/HYgtRM6pg0ifSIow3L
B3MX9UzWzZ9jisa4FW7wUx3uTba4PIIxSI6zv4FQZnJu//lzIYstRu6VAOExGQOw
gEmeNioC3PfkTDwkbBe055YNQUUiwWZCRlpBYj4ofXEGa77p9mNF5l4N6FrbntaD
MOdElCYbuAyUuU5Iqdl2wtQaraNFxPcDo2XQCiSTbQE5LxMG0PAMNAecUr3E8ccG
oF4mElhnXtl7fCARPN2jUihlrcIe2MMWPInsLYq/fnd3f6KAHQr9XT4h3BVIkKas
IMq+2d5nxfUMI1IKYEebtmyYDu4mWxBRXeq+w6grZ6ifD2uzFsX4mhBua4+tXtp0
8QRoP2zGxCM3/8zaxJPE
=mCEC
-----END PGP SIGNATURE-----

--jJHH9RzQyZKg--
