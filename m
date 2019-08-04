Received: from mail-pf1-f195.google.com ([209.85.210.195]:45107 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfHDPhz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Aug 2019 11:37:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so38325779pfq.12
        for <fstests@vger.kernel.org>; Sun, 04 Aug 2019 08:37:55 -0700 (PDT)
Message-ID: <5d46fbd1.1c69fb81.d3d84.0552@mx.google.com>
Date: Sun, 04 Aug 2019 23:37:41 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to cda9817fbbe4
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zGk6i8dtmiTZ"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--zGk6i8dtmiTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly contains xfs improvements and new
tests from Darrick J. Wong, many thanks to Brian Foster for reviewing these xfs
patches! And, thouth there're three new tests, I don't see any new failures
introduced by this update.

Thanks,
Eryu

The new head of the master branch is commit:

cda9817fbbe4 common/quota: enable project quota correctly on f2fs

New commits:

Chao Yu (1):
      [cda9817fbbe4] common/quota: enable project quota correctly on f2fs

Darrick J. Wong (5):
      [5b9305f2faff] xfs/122: ignore inode geometry structure
      [31f219d3e58c] xfs/122: mask wonky ioctls
      [a5a31b791315] xfs/122: add the new v5 bulkstat/inumbers ioctl structures
      [0c92d38b7bd2] common/xfs: refactor agcount calculation for mounted filesystems
      [42987d766097] xfs: test new v5 bulkstat commands

Zorro Lang (1):
      [1191a2aa1713] xfs: test statfs on project quota directory


Code Diffstat:

 .gitignore                 |   1 +
 common/quota               |  17 ++-
 common/xfs                 |   6 +
 src/Makefile               |   2 +-
 src/bulkstat_null_ocount.c |  61 ++++++++++
 tests/xfs/085              |   2 +-
 tests/xfs/086              |   2 +-
 tests/xfs/087              |   2 +-
 tests/xfs/088              |   2 +-
 tests/xfs/089              |   2 +-
 tests/xfs/091              |   2 +-
 tests/xfs/093              |   2 +-
 tests/xfs/097              |   2 +-
 tests/xfs/122              |   4 +
 tests/xfs/122.out          |   5 +
 tests/xfs/130              |   2 +-
 tests/xfs/235              |   2 +-
 tests/xfs/271              |   2 +-
 tests/xfs/509              | 215 ++++++++++++++++++++++++++++++++
 tests/xfs/509.out          | 297 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/510              |  47 +++++++
 tests/xfs/510.out          |   2 +
 tests/xfs/511              |  61 ++++++++++
 tests/xfs/511.out          |   3 +
 tests/xfs/group            |   3 +
 25 files changed, 728 insertions(+), 18 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--zGk6i8dtmiTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl1G+04ACgkQJlKqKVyP
52N1AxAA4LS9we3KyoZ/M/O6LHI4oBBm68/FWuzh7CbhzyC8TOR5bkRL9lZy0VRn
Kk5a0QOdCF3l4tXplucDUKqh0FvM48JQFOUrTvHZB5zI+xorfy3EiwL8CXkBny7d
vwzLa9Yesmln04DkEnv21eV4YzqObYa46uMG9u4aSt9VhXpGEKv3jztYMvlXibtM
S70j99WDo0bzhQIoLi941wp+6XwVUFKncq0ujGw5fslEMi/7NddGfvzcoNzs1C3B
ESZIy+IUzX8O/kC6ynHphmyqwxGlhPdTR2Zt6V5gXrfN8ML+q/4Ix351CPocrwwv
H8ov4fr9qv4odyX6FQMKZgzVkWhFdYMrqPGcgbGYgEseuxivRJPmLj6xRPJ4H3tj
p/WVi7wly3IuXgW+zLfKBn/J2fx7vM3M+aYe882BtcbS9INIp+3697Q3P0IzO9nb
kLxI7IpaaaXRyDh5nPGPkDwKK6kh1kdRQ+qrq9fNv9kiY0jgVL/7RKSfnTzkmcXP
m0ZdGTDI4nmUBeH3MAlx2bJaTBBAaNpOaUmJedF6jnP04/eojo8zgohQGx+XWUIi
/YrDhYbfncZgS4+n96UmqlbT/cKreJAzt+goHB0JEOviD7NdKSKlqwwHOeqwmmyz
zbpkZ9tQQHdi6N2K5mOIF740nEpr3a1o13+o0zehQLY7hg+Xldc=
=ITyM
-----END PGP SIGNATURE-----

--zGk6i8dtmiTZ--
