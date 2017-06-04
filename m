Received: from mail-pf0-f172.google.com ([209.85.192.172]:36418 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFDKIG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Jun 2017 06:08:06 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so70338850pfg.3
        for <fstests@vger.kernel.org>; Sun, 04 Jun 2017 03:08:06 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id b1sm9424462pfl.70.2017.06.04.03.08.04
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Jun 2017 03:08:04 -0700 (PDT)
Message-ID: <5933dc04.81d9620a.d2a7b.5610@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 04 Jun 2017 18:08:02 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 0f15de779527
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TS2m2ERt8aSb"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--TS2m2ERt8aSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relatively small update, which contains two
new generic tests and other minor bug fixes. There're a few patches pending in
the list, I really appreciate if anyone could help review patches.

New failures I noticed in this update:
- generic/438 fails on ext4
- generic/439 triggers WARNINGs on btrfs

Thanks,
Eryu

The new head of the master branch is commit:

0f15de779527 common/rc: Fix wrong word in _require_group

New commits:

Eryu Guan (1):
      [ab6cd253daeb] build: workaround build failures with old autoconf version

Filipe Manana (1):
      [234806344211] generic: hole punching followed by writes in the same range

Jan Kara (1):
      [f12193300a13] generic: Add regression test for tail page zeroing

Nikolay Borisov (2):
      [63a912525aab] src/listxattr: Fix reading past the end of the user buffer
      [0f15de779527] common/rc: Fix wrong word in _require_group


Code Diffstat:

 .gitignore             |  1 +
 Makefile               | 10 +++---
 common/rc              |  2 +-
 src/Makefile           |  2 +-
 src/listxattr.c        |  6 ++--
 src/t_mmap_fallocate.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/438      | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/438.out  |  2 ++
 tests/generic/439      | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/439.out  | 31 +++++++++++++++++++
 tests/generic/group    |  2 ++
 11 files changed, 278 insertions(+), 9 deletions(-)
--
Eryu Guan
eguan@redhat.com

--TS2m2ERt8aSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZM9stAAoJECZSqilcj+djIfAQAIcvV9Duv+Skd1mX4IIGikL+
/XgdrXWsVvifYmw/9rWK0rMY4U1bmRzuWlajjYSe8w/eeYVDvwlM7/Kk2ntwYmVB
jeZmioPFg10p/yCANXnqi4hrqH10PFuP9UwRu+mCU549/7eBrxFD8jGZ5dMqpG7H
E/7d0DKHpztwbV5L5jw6vwr+ixKbT4K21qDve8XvJ0y4CT0hfqoB2B8sj/lWjowz
PglUbMu/geewg85WeIAxLRrdHUEsNtNbGjL6X8Ubb7Pt11iQe+OCblCrBu6vsakc
UIGJUuzXSfSknHWZktdDBjkx/9WY0xWNIvD17qiO52MHb0wWKMTIHKwpRmEVaKqJ
F/UWbeooAM2C5BuBw6keDQFR4CkEZlsB+WI8F28ibKnLiNjEOoBsglMzTRnIVIL+
gbVKQb8yI8qrHvyugcrGdqnr59q4+DJW5OKthD4DSjlyh5Wt75iBKar0eN6Ee1TU
khw40mUmhFqzoocEf1m0nkdsP9EdtFGNCiTaaT8QfwctYh8bgHLmbuL8JPnj+pxH
PtnYqFfFrc81UJjDz0DIJccdqjL3tUvXxf4mMJTcxVYT95GH1Yjq3oPkiYUBf/e9
leyybv0aO1wTYNfnrf73RzRVO7PCAdGvRKvILyv4Ra8DGvVDk6dpVGzG5TKcp2ba
RL4ebBDktQj87M2JuCMb
=VahK
-----END PGP SIGNATURE-----

--TS2m2ERt8aSb--
