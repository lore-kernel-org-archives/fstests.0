Received: from mail-pg1-f194.google.com ([209.85.215.194]:35932 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfGNSAE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Jul 2019 14:00:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so6638950pgm.3
        for <fstests@vger.kernel.org>; Sun, 14 Jul 2019 11:00:04 -0700 (PDT)
Message-ID: <5d2b6da2.1c69fb81.dacaf.3941@mx.google.com>
Date: Mon, 15 Jul 2019 01:59:55 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 968c531cbe58
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nEBl3ocS5VKX"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--nEBl3ocS5VKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains various fixes and there should be
no new failures after this update. Note that kernel version is also printed
along with kernel release in the check output header.

Thanks,
Eryu

The new head of the master branch is commit:

968c531cbe58 xfs/119: fix MKFS_OPTIONS exporting

New commits:

Darrick J. Wong (3):
      [241c25a975f4] xfs: rework min log size helper
      [ee3677a86820] xfs/016: calculate minimum log size and end locations
      [968c531cbe58] xfs/119: fix MKFS_OPTIONS exporting

Eric Biggers (1):
      [856f357c6a5c] generic/399: don't rely on xfs_io exit status

Filipe Manana (1):
      [55cc523b0ec4] btrfs/189: make the test work on systems with a page size greater than 4Kb

Mauricio Faria de Oliveira (1):
      [a4c1696f8c4b] common/rc: print out kernel version too

Yang Xu (1):
      [f036a4da857c] generic/553[4]: correct kernel fix commit

Zorro Lang (1):
      [7ef6a36702b2] xfs/449: test xfs_info on a mounted block device


Code Diffstat:

 common/rc           |  2 +-
 common/xfs          | 25 ++++++++++++++++++--
 tests/btrfs/189     | 10 ++++----
 tests/btrfs/189.out |  4 ++--
 tests/generic/399   | 46 ++++++++++++++++++++++---------------
 tests/generic/553   |  2 +-
 tests/generic/554   |  2 +-
 tests/xfs/016       | 66 ++++++++++++++++++++++++++++++++++++++++++-----------
 tests/xfs/016.out   |  1 +
 tests/xfs/119       |  3 ++-
 tests/xfs/449       | 13 +++++++----
 11 files changed, 127 insertions(+), 47 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--nEBl3ocS5VKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl0rbR0ACgkQJlKqKVyP
52MSwhAAn07IlqPGD58NXiGnc9Xt9jOMJyYEpawtPpEVqCe9qnSEhjSWgTS8qDGv
mKDSPoroOyuC4YPh2K4/+89OJI3bOdQq8WwG1TEz328wnMNamlOYfAgW0wnRGlWs
knUhHbYIjhxy3BSKZiiW/DGQ3SuOt4rIP5Wl4tIzdC/2pL3ooqL0NQ3viH7U0M4r
jzvqptLIoOfprLpUsb9MQiUYBpr+T6Gf0gud0Bi4Vpl7pTV/E5Ni2ek7uyWkZTMb
4oWOVCLjgTv8mA+TwdXqxsjUOOj0QjgpW2VIIGJPR3VyECZ3DzgpKcnqDxpuD7bg
nWvEPf5ilP2NK9WLoWmkAwA2KjiUMdfm+upq7/bD48zx3LNUG7ZT0o3mF6gWJ1Pr
tRcWsFIMFnViJaQVkAYk8mT74ivnhaL3vEf+2F4CYycyCGI0EJ7Ud1QzppFpWIzF
vs562wNM/zQHMxWwkuUM9XwJ4S93hiSuyZunF0+J76kOKuhrCtfRVvaF48iwUh1A
MgvYsqJjMkQj0pjjbJB/L/v2dNv/Vwtd9XFMYDcxsPb3MpB/HCJGE3bYavHq6Pq4
3bgjYuBS1438mvo/hcKl1S/jU44mIUU5h2voDm1BDCjjzBzQF/jv0jJmQr7cV57u
3dgUuxAT7tpsFb8SHqZHNZZEDg0b4xVOojck1ffLlR95FtoPjLg=
=vOYb
-----END PGP SIGNATURE-----

--nEBl3ocS5VKX--
