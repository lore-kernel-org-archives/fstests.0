Received: from mail-pl1-f182.google.com ([209.85.214.182]:35403 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfDGQzs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Apr 2019 12:55:48 -0400
Received: by mail-pl1-f182.google.com with SMTP id w24so5914934plp.2
        for <fstests@vger.kernel.org>; Sun, 07 Apr 2019 09:55:48 -0700 (PDT)
Message-ID: <5caa2b92.1c69fb81.21dc.3eb2@mx.google.com>
Date: Mon, 08 Apr 2019 00:55:39 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to f3c1bca7fb25
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xtwG2K4jGF1V"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--xtwG2K4jGF1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. We're being more strict with SEEK_DATA/HOLE sanity
tests in this update by not allowing default behavior (see commit 340810877483
for what is the default behavior) for filesystems that are known to implement
non-default behavior SEEK_DATA/HOLE operations. This will help catch
regressions if such fs falls back to default behavior silently.

Also, we're having more btrfs tests and fixes, and one more aio test to
exercise unaligned direct write.

You'll see overlayfs fails the tests in 'seek' group with v5.1-rc3 kernel if
the underlying filesystem supports non-default SEEK_DATA/HOLE.

Thanks,
Eryu

The new head of the master branch is commit:

f3c1bca7fb25 generic: Test that SEEK_HOLE can find a punched hole

New commits:

Amir Goldstein (2):
      [340810877483] fstests: Add more sanity to seek_sanity_test
      [f3c1bca7fb25] generic: Test that SEEK_HOLE can find a punched hole

Anand Jain (2):
      [1f139bbe0140] fstests: btrfs verify hardening agaist duplicate fsid
      [cbae878f4110] btrfs: try use forget to unregister device

Nikolay Borisov (1):
      [0cd952cb4259] btrfs/003: enable test with virtio_blk devices in VM

Zorro Lang (1):
      [ed8463509b01] generic: unaligned direct AIO write test


Code Diffstat:

 .gitignore                                 |   1 +
 common/btrfs                               |  20 ++
 common/rc                                  |  59 ++++-
 src/aio-dio-regress/aio-dio-write-verify.c | 341 +++++++++++++++++++++++++++++
 src/seek_sanity_test.c                     |  77 ++++++-
 tests/btrfs/003                            |  19 +-
 tests/btrfs/124                            |   6 +-
 tests/btrfs/125                            |   6 +-
 tests/btrfs/154                            |   6 +-
 tests/btrfs/164                            |   4 +-
 tests/btrfs/185                            |  81 +++++++
 tests/btrfs/185.out                        |   2 +
 tests/btrfs/group                          |   1 +
 tests/generic/285                          |   2 +-
 tests/generic/436                          |   2 +-
 tests/generic/445                          |   2 +-
 tests/generic/448                          |   2 +-
 tests/generic/490                          |   2 +-
 tests/generic/538                          |  95 ++++++++
 tests/generic/538.out                      |   2 +
 tests/generic/539                          |  46 ++++
 tests/generic/539.out                      |   2 +
 tests/generic/group                        |   2 +
 23 files changed, 745 insertions(+), 35 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--xtwG2K4jGF1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcqisuAAoJECZSqilcj+djfIwP+gJ82RfJ604sngB6wD2FsqSq
PJlBlXMEnld4HOaVjTYdAmip/Kv2uBprCREeCJ/rALg6uAJhP7Oy9USth3PuHlHl
eDZB5LUN79EML3yTcuI7WRXCgkzICpW/HJ8UIv+AuSXiyLS/gF/4HdXw7zOerGrV
iIr8Cj2dZTZgMWpQbwJjpG8xcU3IWggfPEQ8RZ95Huklw9LarYbTq5v3eWB85K6d
XioERvOAkxOooNrtwkjNHDXp7DIhTx4syndnUv2zN8AH8RtibT9vxCmIymNE4LVg
57IjYV/DFS9y7LLwzY4qtXXTIWHgLd5uZfJ0U/suNxgh023m+nVnXlA2Nv3A8z1F
KW2GDCGe7ojZYY0r6etE8ArcwbU9JeOB8DKRNdoKxFjtzUWiIii1XXNnRi6QQbO9
hFTgKfTZXIThfxZGRVS7ojoc5pYP7Vy2Qkb+Pw6HOcprECpH0HEGyFDCVlNO4c2h
b5HER0WTybwD0CKjbNCEC1sJ0KQ2J7XDNxvoBY7Nsa5zSlD/O4UXIGH4p6YfR/e7
Vh1ZHUMxNtm4Krf5YDcOEGD7JBteEwZ4Ry7Rh+neMmJhwyo9uCIyZg320CVv6seX
uSDecfBXabkO2nQvgPq9y5ZQqBaOQa6Kbr2Oa1uD/ORCnqliCIgrtaYFBMPoiIef
AXFuiGpKlLNjcV1MJ2dx
=3ikw
-----END PGP SIGNATURE-----

--xtwG2K4jGF1V--
