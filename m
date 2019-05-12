Received: from mail-pl1-f171.google.com ([209.85.214.171]:40025 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfELNHu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 May 2019 09:07:50 -0400
Received: by mail-pl1-f171.google.com with SMTP id b3so5042555plr.7
        for <fstests@vger.kernel.org>; Sun, 12 May 2019 06:07:50 -0700 (PDT)
Message-ID: <5cd81aa5.1c69fb81.430cc.187f@mx.google.com>
Date: Sun, 12 May 2019 21:07:42 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to d123585ea0d0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="40Gt4VguYL9l"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--40Gt4VguYL9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Along with other random fixes, this update mainly adds
two new generic tests and fixes test failures on XFS when reflink is enabled by
default. Thanks to Amir Goldstein and Filipe Manana for reviewing the patches!

generic/545 currently fails on overlayfs, and generic/546 fails on btrfs.

Thanks,
Eryu

The new head of the master branch is commit:

d123585ea0d0 xfs/294: calculate space to reserve for fragmentation test

New commits:

Darrick J. Wong (3):
      [2fd273886b52] xfs: refactor minimum log size formatting code
      [3f5941585839] xfs/216: always disable rmap and reflink when creating log size test fs
      [d123585ea0d0] xfs/294: calculate space to reserve for fragmentation test

Jiufei Xue (1):
      [80bac2129b06] generic: check CAP_LINUX_IMMUTABLE capability

Murphy Zhou (1):
      [d349b37c113e] generic/532: do not break golden silence if attributes_mask is 0

Qu Wenruo (1):
      [2bb2dd24cc9e] generic: do operations which doesn't take data space on full fs

Xiao Yang (1):
      [9820d643ea37] ext4/018: Match the value of File ACL accurately


Code Diffstat:

 common/config         |  1 +
 common/xfs            | 36 ++++++++++++++++++++++
 tests/ext4/018        |  2 +-
 tests/generic/532     |  1 -
 tests/generic/545     | 74 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/545.out |  9 ++++++
 tests/generic/546     | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/546.out |  3 ++
 tests/generic/group   |  2 ++
 tests/xfs/104         |  3 +-
 tests/xfs/119         |  3 +-
 tests/xfs/216         |  8 ++++-
 tests/xfs/291         |  3 +-
 tests/xfs/294         | 11 ++++---
 tests/xfs/295         |  5 +--
 tests/xfs/297         |  3 +-
 16 files changed, 234 insertions(+), 14 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--40Gt4VguYL9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJc2BpaAAoJECZSqilcj+djfUQP/R4b/QQEfsBKNB+rvRW/ahrr
uu2/LLM1oRCWpsRoHpHEhJmUs1icrjNhu8tJfN+yjkbW2buG9u87664N8np2g2Bh
HraDbuHKjRkNS8FzJaWw781+TsrXuMLR64X3KJDsS+pUa2tw34PPEX6tUXOZiFmj
6qrKATT9uIhgN7ZNKXl9NWM2jSRZy2skuvTTWnMe2JUq0D3giz9rS9IYgix2Eogs
eMTyYhYuhaz8nHHHra1d+Ahb0auBh9ilf3vzE9rjnQz2sMylL5jdN40pvVKbE1vC
OVn3E5AMQKbLP8qGFyX3v2q9oyovWPclDFvDWc+ag1M9greAR4wavlWb0/mvkXzh
9xMahR5QemArqmqcDzqnHmMLcexorqoVy2z5zW+pTqKt96FQ1godmXRCUyDRHxKL
tFeFrO27+Z90pBR+f/eUFYcD7KxgIgCVyXcLrPXZLnu6Ty7sz/d+mpL82stl2emW
kCNEpnvRq304cn6jX2j6fx0dpDozsZIpGpMHNebqeM7nUDWi/v9pTmMh/4Y8aG45
4XReglpYQLt59DG1B6Jb2j638cIhQ+quDjQlZpJGxjDROR271ZQ0lkLER33KD5eL
psf3JPEYcpXIXVWOUth78cTzIVRacvyCAXh8A1xN81vVxrQ21utHtbdx2U8gqxSo
6phBdy6y21FiSl7Oxu/t
=H4ot
-----END PGP SIGNATURE-----

--40Gt4VguYL9l--
