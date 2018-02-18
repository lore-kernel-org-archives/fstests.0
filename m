Received: from mail-pg0-f48.google.com ([74.125.83.48]:35495 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeBRMbj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Feb 2018 07:31:39 -0500
Received: by mail-pg0-f48.google.com with SMTP id l131so4882098pga.2
        for <fstests@vger.kernel.org>; Sun, 18 Feb 2018 04:31:39 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id q11sm20905985pgc.60.2018.02.18.04.31.36
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Feb 2018 04:31:37 -0800 (PST)
Message-ID: <5a897229.0b75630a.31e2d.70a6@mx.google.com>
Date: Sun, 18 Feb 2018 20:31:31 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 5f73d8719d04
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JsEEz5fM3kX9"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--JsEEz5fM3kX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. It was a quiet week and this update only contains one
new OFD lock test and one minor bug fix of xfs/015.

Thanks,
Eryu

The new head of the master branch is commit:

5f73d8719d04 xfs/015: enlarge the initial fs size

New commits:

Eryu Guan (1):
      [5f73d8719d04] xfs/015: enlarge the initial fs size

Xiong Zhou (1):
      [4a6d40ad6865] generic: add OFD lock tests


Code Diffstat:

 .gitignore            |   1 +
 common/rc             |  11 ++
 src/Makefile          |   3 +-
 src/t_ofd_locks.c     | 444 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/478     | 250 ++++++++++++++++++++++++++++
 tests/generic/478.out |  91 +++++++++++
 tests/generic/group   |   1 +
 tests/xfs/015         |   6 +-
 8 files changed, 803 insertions(+), 4 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--JsEEz5fM3kX9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaiXFCAAoJECZSqilcj+djomUP/30DYmic+smViih8CH0XWZBO
YNVCVvnvrGu/0Dc1eY0HMKDYcscRt6MX+f0anqLHClR+0qMZG3eZIeSMeBUrCbEI
PTNLlz2x7Nzckio9FSaFyothfG6ST99U8QSj9lVTJx/8Z1nr7C0C80MRrCCw+5Qc
Y5Fuyas+UDyvQLzuPjBWvSkbh5PIYbF76yRezOJbyXV3vxKb823Z8j5fTS/VsF4f
GPSl2wRGrj3jbp7i45Uca/RpMfVHd4gdao1yWd83AOnr3MBiruQQfzupCTXmuzam
wk4LP0MDnGPXjeSV+2bcDmbYI2oyxMH7Klg3rXrHX6DSMPMmEJACLTYqIN+xjgsj
DYNf/V9giM6hIWhCiB86czXpZZzksvt2UmgYTgaw2tVDHLJCUUqOKBJSt/j1wwHe
e4Pa5DyoTeM4r1kukqFGJY/iogNaAGsV72bjCHgAGyt8Q2jsMKEtuz5kbqPdwDkT
6PBsNPCGiVm/yQVXbd6asvySiP3T7TIrI7xXnCLjRoX6DqT6O3yUEmiUfzlQRKyL
M+y+LtzwThxfhhlqM909PmqqK9xrsb1/lzI9YPuM94DdwM0N+OClaJn1c38yHlDW
5IywH2A7Vo1PSz8rmwpy+xTW2rURhjU4B6eT8iNp/h7MszWV3Mm/ofT4XHXgZFCL
dLPIqAVi31TcIqWyV0zt
=ijuy
-----END PGP SIGNATURE-----

--JsEEz5fM3kX9--
