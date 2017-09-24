Received: from mail-pg0-f50.google.com ([74.125.83.50]:49674 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbdIXRYg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Sep 2017 13:24:36 -0400
Received: by mail-pg0-f50.google.com with SMTP id m30so2813201pgn.6
        for <fstests@vger.kernel.org>; Sun, 24 Sep 2017 10:24:36 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id 184sm7467334pfg.18.2017.09.24.10.24.34
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Sep 2017 10:24:34 -0700 (PDT)
Message-ID: <59c7ea52.c106620a.572ea.29c0@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Mon, 25 Sep 2017 01:24:32 +0800
Subject: [ANNOUNCE] fstests: master branch updated to ea817058b0bc
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qJ8oYlIuVzpZ"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--qJ8oYlIuVzpZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal bug fixes and improvements update,
with only one new test for XFS, and I didn't see any new failures introduced.

Thanks,
Eryu

The new head of the master branch is commit:

ea817058b0bc xfs: Add test for CVE-2017-14340

New commits:

Amir Goldstein (3):
      [de5925929857] overlay/038: fix impure xattr test
      [5052c432b558] overlay/014: correct comment relating to workdir reuse
      [a21f34f87f8e] overlay/031: fix test with inodes index enabled

Andreas Gruenbacher (1):
      [e04905eba73a] common/rc: Improve gfs2 support

Christoph Hellwig (1):
      [b88444413a0f] xfs/310: relax extent count check

Richard Wareing (1):
      [ea817058b0bc] xfs: Add test for CVE-2017-14340

xiao yang (1):
      [7ef45e8a3856] xfs/115: add missing 115 into group file


Code Diffstat:

 common/rc         |  6 ++++
 tests/overlay/014 |  7 ++---
 tests/overlay/031 | 23 ++++++++++-----
 tests/overlay/038 | 12 ++++----
 tests/xfs/310     |  5 ++--
 tests/xfs/431     | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/431.out |  3 ++
 tests/xfs/group   |  2 ++
 8 files changed, 123 insertions(+), 19 deletions(-)
--
Eryu Guan
eguan@redhat.com

--qJ8oYlIuVzpZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZx+mWAAoJECZSqilcj+djl6YQALBGBixUOzr0r44MiX5i6zK0
Dhp810rgKvgVQKmM/L8SMrAl0vcUErwf7Vkf6MAK2ZQCOBMkly7//FkHU0JTnlEP
iW8TGa5528hddiNq3cMbxHh+aXyza/We71Nw7qYRVcNKVchnJYx9w6Pmleog3u5b
Cji6xTSW6Re/eG3Suu2cCehucOFRZIVEtrfFGeFKBbnCNdTvMRqirXwH5BScXGeu
3nBPID5jl1yYWFcvHbV7PAaUqHTFC7s+XTBHTjPyy1dx+CyzN1yLvB0+ysCRnK0D
a9+Qr9/CTipwF81M4tekhhOedqCSZVByS9dMzA5fLmCdAvidr1k0+tDElXH2mq8/
8nZzuvgzHY+A/bZ02S6hrGtv2XNXxiUDHNmDID1k695jZxKmBGPNgQNQe/HElcTM
9TlUK2Nz2KCcZWtOU6chGGSmVJG9ffnDQ7GetrErUB+lSSS+nAZE0jIUrQ2R1ELA
lg33sI1gXIFrR7wFL1dGsIpKJ+IkI+kAU6XEtZNOT8OHBFve5K2nhcQj7wt1nzr/
K5jSsev9U8K1dIbcQzpE2F/lTB00ZN17hCiWElJw6lYqsLIKHWrplPChqJOh0r9D
lfnQ9M2d6Me69Xkkhh4XpqaEM/d44StmWCHiV9quofVaZmLex9T79zBos1qCTCqH
U3HqIxcWoFHEHh8xVoG2
=2VPk
-----END PGP SIGNATURE-----

--qJ8oYlIuVzpZ--
