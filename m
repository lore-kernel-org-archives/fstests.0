Received: from mail-pg1-f194.google.com ([209.85.215.194]:40172 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfG1M0K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Jul 2019 08:26:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so26866087pgj.7
        for <fstests@vger.kernel.org>; Sun, 28 Jul 2019 05:26:10 -0700 (PDT)
Message-ID: <5d3d945f.1c69fb81.1617.eeb1@mx.google.com>
Date: Sun, 28 Jul 2019 20:26:02 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to ea7ab13c6190
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hBWsuDqeySWh"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--hBWsuDqeySWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a bugfix-only update that contains xfs,
overlay, f2fs and ceph related fixes. But note that the overlay/065 fix
actually adds more test coverage and you may see test failure when testing on
latest v5.3-rc1 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

ea7ab13c6190 xfs/194: unmount forced v4 fs during cleanup

New commits:

Amir Goldstein (1):
      [04d08996e950] overlay/065: adjust test to expect EBUSY only with index=on

Chao Yu (2):
      [7431fe2c4650] common/quota: support f2fs in _require_quota() and _check_quota_usage()
      [6fc5fd1eefab] common/rc: check quota sysfile feature for f2fs

Darrick J. Wong (6):
      [a96e77e7a428] xfs/504: fix bogus test description
      [2405d4bc0b4b] generic/561: kill duperemove after sleep_time
      [d67b78bd9eef] generic/506: mount scratch fs before testing for prjquota presence
      [36da2c651ac4] fstests: disable quotas before running test
      [139f9a16307e] xfs/033: filter out root inode nlink repair
      [ea7ab13c6190] xfs/194: unmount forced v4 fs during cleanup

Jeff Layton (1):
      [6a04d0f74eb2] common/rc: ceph only supports default SEEK_HOLE behavior


Code Diffstat:

 common/quota              |  9 +++++---
 common/rc                 |  2 +-
 tests/generic/384         |  4 ++--
 tests/generic/506         |  2 ++
 tests/generic/561         |  1 +
 tests/overlay/065         | 56 ++++++++++++++++++++++++++++++++---------------
 tests/overlay/065.out     | 12 +++++-----
 tests/xfs/030             |  2 ++
 tests/xfs/033             | 14 ++++++++++--
 tests/xfs/033.out.crc     |  2 --
 tests/xfs/033.out.default |  2 --
 tests/xfs/065             |  2 ++
 tests/xfs/194             |  5 +++++
 tests/xfs/504             |  8 +++----
 14 files changed, 81 insertions(+), 40 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--hBWsuDqeySWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl09lCoACgkQJlKqKVyP
52PFcg/+M+3z0hdbGSaLF5uLWiGlu1rYh7Y43OFKuuh3cLMjbDHtXxuqgCsCilMJ
Ky+3KgME6GPIhs0TxNpTDErOhA3xTQH1AN5Qx+a9NFxzFmjPcAj+2TZ0TKlaT/Ax
4yFJd3mKCrS93JpQKwvToTalsSITGDm/zOZCMciFLJru9uM5aULVNiaM3DrwEa6e
4oVhvc6f12/mKRjxNNnonv1nGKemM6HpIhrk6FRSlgGxZIRvTAu9AacJOb4V3ZBG
CXKrNHihlj3F+kQIFxBLtFsVfyc3NKG+UvIDjnDJhYP6993VIOBGjVGX0xwTcf6T
6wpKDB33Pkw5SstYxTMKah7XlB2PhlIvhYhHKU4bR6CRl/vYnJ0uE9tYEeLKAkka
4WzZ9Y9TWnPEyqc9GaLYOONfo9+0bPEqWp3B41facXMIok63TxECNNbNKhQ8r93G
GNS+J6ILNVkDYkQpKMNdCzwOFEC3z+fiMmnX3ZLXR2b0vRmxhRxkrbbYjP4RQ1kV
VlKAXN9CJJ8auJPPRBAYRJXWgJ3srA5u+875Opa90tMT5X2QW5KEhyh4kjxzoPqG
Rw/+5+2cbxOgGJTdc5A986eoMKleICuOEdV1Lz8hPHSEek8FxvqtXw8Otz0GzZFF
UpMlq+YjIsmGIFWn+LVpJ4q2GU/SmFPifWL+fzADdBEsAwccrZ0=
=ego4
-----END PGP SIGNATURE-----

--hBWsuDqeySWh--
