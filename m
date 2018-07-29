Received: from mail-pg1-f173.google.com ([209.85.215.173]:40710 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbeG2Odm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Jul 2018 10:33:42 -0400
Received: by mail-pg1-f173.google.com with SMTP id x5-v6so5739465pgp.7
        for <fstests@vger.kernel.org>; Sun, 29 Jul 2018 06:03:18 -0700 (PDT)
Message-ID: <5b5dbb15.1c69fb81.1fd91.cce3@mx.google.com>
Date: Sun, 29 Jul 2018 21:03:13 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to d2f9bf265f14
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r2pCZOVfdiNB"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--r2pCZOVfdiNB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. It's been a quiet week again, there're only two new
tests in the update, one is for btrfs and another is a generic one.

New failures I've noticed:
- btrfs/168 fails with current Linus tree

Thanks,
Eryu

The new head of the master branch is commit:

d2f9bf265f14 generic: test DAX DMA vs truncate/hole-punch

New commits:

Filipe Manana (1):
      [6eab1aafe259] btrfs: test send with snapshots that have files deleted while open

Ross Zwisler (1):
      [d2f9bf265f14] generic: test DAX DMA vs truncate/hole-punch


Code Diffstat:

 .gitignore             |   1 +
 src/Makefile           |   2 +-
 src/t_mmap_collision.c | 235 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/168        | 136 ++++++++++++++++++++++++++++
 tests/btrfs/168.out    |  13 +++
 tests/btrfs/group      |   1 +
 tests/generic/503      |  64 ++++++++++++++
 tests/generic/503.out  |   2 +
 tests/generic/group    |   1 +
 9 files changed, 454 insertions(+), 1 deletion(-)
--
Eryu Guan
guaneryu@gmail.com

--r2pCZOVfdiNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbXbq1AAoJECZSqilcj+dj92AP/0aYLK3Bl+GTqQAGe1hC42pZ
8B1R9SYXuBWJ4TbnBFwlNjRvSXIlPKdUldNdI59spyr8jQmY7+ITqLZ7qsFmkp4+
NrBdFiedD1469MWy+vaZ54GTkCpJmcwEZ/zAUSn42atrXpDf0pD7vovErLz6eeiA
KQJd8hucVrdziEidnbf47MSSW5MWKdKZWZ2JrTXGcnCLa7hMehExZmg9hmJoaMMW
aUCiPXoT4++YpE+KtwzwR6mK1k6du+BbvZXbMVnPIlrQ0xEerizE1WUTMn3ORdeg
c31G0au+qaZNn6acL/P5ADznfrPAp24dvT6c2aexG02zn/TbEbntE2VOdmlUzp2W
T2tfpAYUXzvtcBrbWquNr7S/5ozrHaDBQJqqXNLaXq2ZxNv5Jq6feg5ZUAzNjAUf
xWkXReX26tLC8aLsv9Aafg80TM241T6iIgaEXvnCZr3xa9jfxk2g9+Zhmgc9PRr+
PsD+rNiKBQvz24cWa0wng+7lTYVG0lPw/OCBOB/MEp8+ZJA5e5isXMSa1GLV332B
Iu9GWrj+SIO8chvfthsFqlVcxLJRee+xxVpQ952PIyMWJwvo+7kdqlKxjlPhKR7M
xx+MYdSKarAWlOPWUrJOtXKyUGKd+lAkA8jRIze27ZVdO6FEfyVZUniiVJAkbrg7
/9YMz2hVGd8A+B6nLcQw
=MEe8
-----END PGP SIGNATURE-----

--r2pCZOVfdiNB--
