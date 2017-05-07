Received: from mail-pf0-f195.google.com ([209.85.192.195]:36678 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdEGX6g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 May 2017 19:58:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id v14so7629718pfd.3
        for <fstests@vger.kernel.org>; Sun, 07 May 2017 16:58:35 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id l185sm10590988pfl.106.2017.05.07.00.23.52
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 May 2017 00:23:53 -0700 (PDT)
Message-ID: <590ecb89.c225620a.b2144.8203@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 07 May 2017 15:23:47 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 52f9ebbda94d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DuaSAlWLvlxE"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--DuaSAlWLvlxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're mainly new tests added in this update. The
overlay consistent inode tests has been improved extensively, new encryption
and xfs tests has been added. And _check_dmesg now could catch new "suspicious
RCU usage" message in dmesg, cephfs gained better attr test support. Many
thanks to all who have contributed and/or helped reviewed patches!

New failures I've noticed in this update:
- xfs/294 hangs (soft lockup) v4.11 kernel, which should be fixed in 4.12-rc1

Thanks,
Eryu

The new head of the master branch is commit:

52f9ebbda94d generic: test revalidation of encrypted dentries

New commits:

Amir Goldstein (6):
      [c2c9d7ef1adb] overlay/017: silence test output
      [3813cafb81db] overlay/017: fix some comments
      [8a76c404454f] overlay/017: use af_unix to create socket test file
      [dca98801ed2e] overlay/017: create helpers to record and check inode numbers
      [08253234856c] overlay/017: verify constant inode number after rename
      [cf0e25209dcc] overlay/017: test persistent inode numbers after mount cycle

Eric Biggers (2):
      [3c309f26fbd7] common/rc: catch updated suspicious RCU usage message in _check_dmesg()
      [52f9ebbda94d] generic: test revalidation of encrypted dentries

Eric Sandeen (2):
      [9343320e6788] xfs: test fragmented multi-fsb readdir
      [54ac0dd3086d] punch-alternating: add some options

Luis Henriques (1):
      [5fcc706aab43] attr: add support for cephfs


Code Diffstat:

 .gitignore                     |   1 +
 common/attr                    |  24 +++++--
 common/encrypt                 |  42 ++++++++---
 common/rc                      |   4 +-
 src/Makefile                   |   2 +-
 src/punch-alternating.c        |  47 ++++++++++---
 src/t_encrypted_d_revalidate.c | 122 ++++++++++++++++++++++++++++++++
 tests/generic/429              | 154 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/429.out          |  37 ++++++++++
 tests/generic/group            |   1 +
 tests/overlay/017              |  86 ++++++++++++++++++-----
 tests/overlay/017.out          |   7 +-
 tests/xfs/294                  | 118 +++++++++++++++++++++++++++++++
 tests/xfs/294.out              |   2 +
 tests/xfs/group                |   1 +
 15 files changed, 598 insertions(+), 50 deletions(-)
--
Eryu Guan
eguan@redhat.com

--DuaSAlWLvlxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZDsqwAAoJECZSqilcj+djcp0P/2/Vs+pUcO+ZA6Zn0di5GQzQ
pEBVLmRdrYeQ6U4n2mErlWU5XxFEH6yhPxtANeo2bJM75A48hB1ertF9HwsGkAbC
ubq6va54HUUHFi6elarnYLfQcKxzPvH7uUJwn4yX02JkqyWh0dswDBg61Nc79pGT
US22xEsEB4Y+xDVYcJq6VhQ8x7/a815h3Bokf3O43bbDEyjtqQX6NuM8pFwIef8q
7vKlYgo+vXxjFmjvSk5U3Sjp8cVPfkR1Z2oLdMQVAUr7NtI/CP3l3wT5CFOmr5iv
GRz5zC9wZGByzqqTriB9vGtVKV+floNjl+BILjVZRlxdipgvM06JyHJeiGspaUT/
kTETRSB15hbIfW98Bv294OiERPidixKj8hTb1VobntusNLfHPKBKK5NtcFZfJKiS
GtMJWVHH5Qvo5go+bfBUpN9pkIFUhxKBU6+/x9aYGJnFah9CUyvPzL96FFLKxp5G
lqi4KafkF9TxwRPWOyPFF774wd/Yx+B3/yUxvEel0Dt7LmtXta9i+IXgzNR5d3BI
D1hwzsu6pDUfbXNXhH3UYgJAmlvV1ksvwQTAO6LDd4q3DwWhVEQtX+TNP1X/U7JY
IOIXecWtwXU706rogoqrfNpGaVPv1dwc1e4WpTx/mRXVRwlsgtPFENwG9mbwjw+r
Mjl7ro3FrA1+7oF7x9oL
=iAhq
-----END PGP SIGNATURE-----

--DuaSAlWLvlxE--
