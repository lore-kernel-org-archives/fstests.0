Received: from mail-pf1-f169.google.com ([209.85.210.169]:42524 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfESRFU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 May 2019 13:05:20 -0400
Received: by mail-pf1-f169.google.com with SMTP id 13so6031281pfw.9
        for <fstests@vger.kernel.org>; Sun, 19 May 2019 10:05:20 -0700 (PDT)
Message-ID: <5ce17857.1c69fb81.eee25.1b5c@mx.google.com>
Date: Sun, 19 May 2019 23:37:53 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 1879a65466c8
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ih1zl07vc9nc"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--ih1zl07vc9nc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. We have one fsync fuzz tester in this update, you may
see test failures with btrfs and ext4. Also, we have bug fixes to generic/530
when testing with overlayfs, and seek_data/hole tests when testing with NFSv4.

Again, many thanks to Amir Goldstein for helping review patches!

Thanks,
Eryu

The new head of the master branch is commit:

1879a65466c8 generic: fsync fuzz tester with fsstress

New commits:

Filipe Manana (1):
      [1879a65466c8] generic: fsync fuzz tester with fsstress

Jeffle Xu (2):
      [f8f57747222d] generic/530: fix shutdown failure of generic/530 in overlay
      [b6908c6e23d4] common/rc: improve _fstyp_has_non_default_seek_data_hole()


Code Diffstat:

 common/rc             |  9 ++++++-
 src/t_open_tmpfiles.c | 19 --------------
 tests/generic/530     |  4 ++-
 tests/generic/547     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/547.out |  2 ++
 tests/generic/group   |  1 +
 tests/xfs/501         |  4 ++-
 7 files changed, 90 insertions(+), 22 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--ih1zl07vc9nc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJc4WXZAAoJECZSqilcj+djTWUQAJ6lxeV8yinGSz8bZoRWb94c
Nio39WXvV5vQT86tiUcfVEVo/+7UaFAoOZ33YjaKHuA/15Tp/3+UdxnyHm3miGLB
jwdHxDJ8HHBDeGGciOWmMAc8+T/JYOFYy7OpOv+DvYk1n7joQh3QomCoxGDJJAbE
osXtwzJEOh205vvO5wH5iD/VHeTRWatYGyvTMzhp5KNFrHOCjaQcStOxGd/CcqIB
pvsxjVFZGQF0mjYsjunc9qeECbm1+15IOh1p8aCIDEOpQIYheX164VETnqzX+DSt
Im1YGUQEnIe1DFY9L/0/U+tEZLe7dzOsPsG+R6K3fH8NKMTNLBQk1PcTlh75K7rW
6MtY9fdVRsAXMwv5zTS24fFMfmsb4Hj7XvDcDO+dU60qIQNwyvM+05rqi6LheR8v
cyTT+YpEeZHZOA4V50ypvYiYoHKzNjAfK7q+OPTFJ31Y1M1LtwIBb64ZUlUJthcw
+Z4lRlDGv/JStPmVEnhql+3aLzchvM2+JmmB0ZxIviekA2UGEr4n0qdFmijKqeYS
pNzFGTO04ADo2DIa5QjJeztVpYPLbrE7/Yh0xi3RHqBttOnGNHW/tED3MjO+7znr
nkwcJ7BYjLxuHIOnmfVHL/UHCVdgFNY3kH21QsE+9KUkvqMl2coTIdUYfhCl2Xfz
Z6HJKkjZLye0J2P86Fzm
=6azI
-----END PGP SIGNATURE-----

--ih1zl07vc9nc--
