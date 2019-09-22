Received: from mail-pg1-f193.google.com ([209.85.215.193]:40989 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfIVPZA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Sep 2019 11:25:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so5313683pgv.8
        for <fstests@vger.kernel.org>; Sun, 22 Sep 2019 08:25:00 -0700 (PDT)
Message-ID: <5d87924a.1c69fb81.11deb.056a@mx.google.com>
Date: Sun, 22 Sep 2019 23:24:51 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 0fd43f3f4bd7
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v9P6clQ9eUjz"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--v9P6clQ9eUjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Instead of adding new tests, two xfs tests have been
removed. And _require_renameat2 gains ability to check for specific rename
flag. 

Thanks,
Eryu

The new head of the master branch is commit:

0fd43f3f4bd7 xfs/14[89]: Remove xfs_prepair64 and xfs_prepair tests

New commits:

Qu Wenruo (1):
      [8e5bf2d06fdc] btrfs/028: Don't pollute golden output for killing already finished process

Yang Xu (1):
      [0fd43f3f4bd7] xfs/14[89]: Remove xfs_prepair64 and xfs_prepair tests

kaixuxia (1):
      [4908565469c5] common: check if a given rename flag is supported in _require_renameat2


Code Diffstat:

 common/renameat2  |  33 +++++-
 tests/btrfs/028   |   2 +-
 tests/generic/023 |   2 +-
 tests/generic/024 |  13 +--
 tests/generic/025 |  13 +--
 tests/generic/078 |  13 +--
 tests/generic/398 |   2 +-
 tests/generic/419 |   2 +-
 tests/xfs/148     |  93 -----------------
 tests/xfs/148.out | 299 ------------------------------------------------------
 tests/xfs/149     | 112 --------------------
 tests/xfs/149.out | 123 ----------------------
 tests/xfs/group   |   2 -
 13 files changed, 44 insertions(+), 665 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--v9P6clQ9eUjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl2HkcMACgkQJlKqKVyP
52PslQ//VjXmfw1LkF4oHL4AWubBYk10u0ZaTPzXuad6U1QKV8I8WMrVnxaCLn5o
abUsT2IkSjuxvvsOElM+w6JE67qkh/E325pBNUqeGX8+wN79ay8tS9GhKeSLMuSV
qWLyPK760vUHktG8MXh8ljTbJqxG7OIJYviCXfZ+jFQANr0VltcBqGlEgTqEWwqJ
XY7xuBR7prCibRvBDayI1z9TJWAsv2SqwJRpIyAumVqq80gqK1XqygAmAy5v3qSr
k71HzYZUicRBsvlZzMzd4Jq9VZDknviJKXGFiaJqqWkCayRNP9so0FJyZtvW2zXb
qNJMFDrWa4X39HYRLudhnrpPhrSvXTUDYGWuB53iRFJWR8eR2YZeWQqgkF0Z6i6X
6kyUyQmpS2MBJPDuDvgB/6evaQNJRlT4touJOjLCJwfIvzbk7cEr0RXZ9vw9VdGJ
iw4IUw4XKUbtAjHU55aTNyM/funrAXSoIuhRw49abbd7tebtVTZMClQzzm4qFA4T
ypwZ2t5HhpKO3Iv0V0RXCPN5CvBZYboskRHoK+KlnpvWJHu0ioF6fKk6WcwFH2U1
7AVC32Pse3ETxR3x3yD5zqUYNQTHbNCMWcY54uQYvdYokpaK5WNLZInspxfZqYed
ZDKmHxS2k6yUCWHhJsVPXHbMblaTp4ya8AftCuseuXli5X2K51A=
=hzwv
-----END PGP SIGNATURE-----

--v9P6clQ9eUjz--
