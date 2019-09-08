Received: from mail-pf1-f196.google.com ([209.85.210.196]:43279 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfIHOwl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Sep 2019 10:52:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id d15so7527324pfo.10
        for <fstests@vger.kernel.org>; Sun, 08 Sep 2019 07:52:40 -0700 (PDT)
Message-ID: <5d7515b7.1c69fb81.39894.6119@mx.google.com>
Date: Sun, 08 Sep 2019 22:52:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 0837e907988a
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IyU0PVLmC86b"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--IyU0PVLmC86b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Again, this is a bugfix only update, you should see no
new failures after pulling updates.

Thanks,
Eryu

The new head of the master branch is commit:

0837e907988a btrfs/048: fix test failure when fs mounted with v2 space cache option

New commits:

Filipe Manana (1):
      [0837e907988a] btrfs/048: fix test failure when fs mounted with v2 space cache option

Ira Weiny (3):
      [54c5fcc72fd7] src/locktest: Remove D_flag
      [25d6ac5323f7] src/locktest: Update test header comment
      [c14b4d65c694] src/locktest: Remove unused buf allocation

Nikolay Borisov (1):
      [306291e75554] generic/25[02]: Increase fs size to 196 mb


Code Diffstat:

 src/locktest.c      | 49 +++----------------------------------------------
 tests/btrfs/048     |  5 +++--
 tests/btrfs/048.out |  2 --
 tests/generic/250   |  2 +-
 tests/generic/252   |  2 +-
 5 files changed, 8 insertions(+), 52 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--IyU0PVLmC86b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl11FXQACgkQJlKqKVyP
52NjKQ/+OlALX/O2ltCTNbdJGWHiyG1zkOUN8Dl2L/uHHlK7bOSKEIHrEAXP/4RC
St1kfY4beeQk87fb7sY2G4pYCuYgkJyOjllAWbQEqgYETXpE3753JvI83g23//Fi
wTflvZL0jpzoiXIkRtbmW993hKKsZpvSA+tR4HjymkDWZ0RrdIIkqTpPR6fbmi88
udYJ5O+z+AHNfzqlRRX71MddqrL17zDzVMYdFg/jbxv8SgamMGULAK6xMc9xTVmb
JzR0VuhbKTsFFBY7eI7hY/QAZtT1pVBBKWHUsXZWZfebEoyAtB3ybCsLyUiLA4Wz
AJicN9djDzT+1A+OFoSCp2nxLt/W6kCxst8224jDghDXV6tD6naa+oCZ6T6dRA6r
cN/SOZpHcc0TXuP6wqRfTgoyuOWd2FfN31oZPVbiGNs/so7QGRwmLl3AFyou5q45
1MovktN4zVqHocNFjnRXoBL8ZNbDShBjiR5zocMcSI37+h8DeF5YX9xUAq3tuo3L
sh84SWgLEXIL70E/ZXOU8jH2lkG2VME/MZS9Rd/0qRSD43Ua39OKFSRTqZ+YATKa
T1oXz/qN0vKZ5LVLRGo2eGLAhK/knbg8DFsJOBcJHDlaBDnwx4KQ/a+cO1jyGvIK
nRrbKN1WnRSIgim8Bn7eHhmerf8eiSDcu2OiEXr81WxsVYxMh0Y=
=G7yg
-----END PGP SIGNATURE-----

--IyU0PVLmC86b--
