Received: from mail-pg0-f41.google.com ([74.125.83.41]:32816 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdHTI0q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Aug 2017 04:26:46 -0400
Received: by mail-pg0-f41.google.com with SMTP id t3so55663218pgt.0
        for <fstests@vger.kernel.org>; Sun, 20 Aug 2017 01:26:46 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id 15sm19719536pfo.57.2017.08.20.01.26.44
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Aug 2017 01:26:44 -0700 (PDT)
Message-ID: <599947c4.8f0e620a.5d257.d2c2@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 20 Aug 2017 16:26:42 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 1cc5517771ed
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="igzEVgb0uUbd"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--igzEVgb0uUbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal update with mainly new tests added,
we're having new tests for xfs, btrfs and overlay, also a new generic test.
Thanks a lot for writing new tests and contributing bug fixes!

New failures I've noticed in this update:
- btrfs/149 is a new btrfs send/receive regression test, and it fails with
  current Linus tree (v4.13-rc5)

Thanks,
Eryu

The new head of the master branch is commit:

1cc5517771ed xfs: test for log recovery failure after tail overwrite

New commits:

Amir Goldstein (1):
      [e4caca53e280] overlay: test mount error cases with index=on

Brian Foster (1):
      [1cc5517771ed] xfs: test for log recovery failure after tail overwrite

Filipe Manana (1):
      [80bd724d020a] btrfs: test incremental send with compression and extent cloning

Lu Fengqi (1):
      [4dbba416d98a] btrfs/142: enhance regression test for nocsum dio read's repair

Xiao Yang (1):
      [70076b939417] xfs/424: add check for finobt && update comments

Zorro Lang (1):
      [4939477f3fee] generic: test read around EOF


Code Diffstat:

 tests/btrfs/142       |  19 +++---
 tests/btrfs/149       | 113 ++++++++++++++++++++++++++++++++++
 tests/btrfs/149.out   |  14 +++++
 tests/btrfs/group     |   1 +
 tests/generic/450     | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/450.out |  11 ++++
 tests/generic/group   |   1 +
 tests/overlay/037     |  94 +++++++++++++++++++++++++++++
 tests/overlay/037.out |   3 +
 tests/overlay/group   |   1 +
 tests/xfs/057         | 116 +++++++++++++++++++++++++++++++++++
 tests/xfs/057.out     |   2 +
 tests/xfs/424         |  28 ++++++---
 tests/xfs/group       |   1 +
 14 files changed, 551 insertions(+), 16 deletions(-)
--
Eryu Guan
eguan@redhat.com

--igzEVgb0uUbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZmUcVAAoJECZSqilcj+djv7IP/3hjCMELe4rq4Zbk3sX43plH
EKWVL41Md8QELkdDNXnO6lyIgbaHIqcGRHSyg729sPt050epSoMcelKSlkzfBn93
rsQCBJlMU2BSMkKz7AWdWMssgxddeI9WTUigsB0COKmAvcf3PExWtvVQi9hVjG+m
XTt5o/BQ3X2gVnGGuK4zpkI6wNeHu5Oft7dab4DoJeTdKYMT/mND8hSzNbaCLMHl
t+oM85nAat/EqUatfg2e6ObfJXUPHSUostkB6H8+Gx4oKAOPfDBrx7mNHwgRdN8T
z1e6jO2cE8hx5iNXkDt8KHwRo4bxuSlB9LVCE2zPUCHXGcLntYJ0k1rDXazCxuid
si9zRBnthWPQE/RtZNMoYZ8bL3piQFNoC/3nyi0NVkRe190nHRZkkQBFgaphQIK5
V9vofnesernGhb5itO8BGFCXO9Gg+WHwsqbVoEtmVMgbOu0sjiTTxuRAPVvZwm1N
6fBCFDtF1KKKghE2VjmXD7h7YWOqzLdXkPB2MJVhFc8MYR0J/FJHagBy/4gXRKh6
q1kkPIkPJsMtkA5leXd7L3giia0CCjhcUc9prw4UyyLlli0/na4D5g8a1TcHcbKY
ZW84lQe9kqi1G0QapFPTZeRg1HyZlVkJ7ipN4GQBwnLwFqzahkOGfHw3dL6qMDiC
T+lmZKOmxYd/kDXZ4P7j
=2ghX
-----END PGP SIGNATURE-----

--igzEVgb0uUbd--
