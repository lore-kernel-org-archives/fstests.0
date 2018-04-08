Received: from mail-pl0-f54.google.com ([209.85.160.54]:43379 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeDHIG1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Apr 2018 04:06:27 -0400
Received: by mail-pl0-f54.google.com with SMTP id a39-v6so3249803pla.10
        for <fstests@vger.kernel.org>; Sun, 08 Apr 2018 01:06:27 -0700 (PDT)
Message-ID: <5ac9cd81.caa0620a.d20bb.d992@mx.google.com>
Date: Sun, 08 Apr 2018 16:06:20 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 4cabd42a78d2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MPfVkKkpva5o"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--MPfVkKkpva5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the new log-writes test
from Qu Wenruo, which checks for fs consistency after each FUA write using
dm-logwrites. Please note that the new test (generic/482) fails on XFS and ext4
sometimes, not sure if it's a filesystem issue or a dm-logwrites issue yet.

New failures I've noticed in this update
- generic/482 sometimes fails on XFS and ext4, please see above 

Thanks,
Eryu

The new head of the master branch is commit:

4cabd42a78d2 generic: Check the fs after each FUA writes

New commits:

Benjamin Coddington (1):
      [43374a62325e] common/rc: improve checks for YP/NIS

Qu Wenruo (3):
      [00b6ad8f265e] log-writes: Add support to output human readable flags
      [5311ba16c6e8] log-writes: Add support for METADATA flag
      [4cabd42a78d2] generic: Check the fs after each FUA writes


Code Diffstat:

 common/dmlogwrites          |  56 +++++++++++++++++++++++
 common/rc                   |   3 +-
 src/log-writes/log-writes.c |  71 ++++++++++++++++++++++++++---
 src/log-writes/log-writes.h |   9 ++--
 tests/generic/482           | 108 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/482.out       |   2 +
 tests/generic/group         |   1 +
 7 files changed, 238 insertions(+), 12 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--MPfVkKkpva5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaycuNAAoJECZSqilcj+djywUP/RPrH21spUWkcLS9jO5m7G/T
baCx6FI9OH9tUqu7evoQ+W/ssF9Xiwz8K82dd42p8SnOWFfkRuulGGaCICabO/Lz
U3shLusbEN2KLA8o8wVyF2ledOsMap4O+3Iw0gPw/11ojKxBerTZWM/4LDmCgbRH
91zzM+dOdqxeG3Mhb/xGIjvukVmY4thZe+x1jsc/nNGmge/DgHZ/ZcjCO9PAV5TH
V2lG6jiBevXDRDqPYYB/GGOVAblnB9HuItLt/yIgGBYT0lOE4RtpEnci9/e4KHYx
uvVrFd2wTSozycszvtHwix/Bx8eATB74B3OL5EpCGFy+c/ErskHoapGT8xqLur7V
LBu/VbD5LKk6kHBWreQBm019bQhmYuw1RU0yfGfJV3jinU6+SGWh2gxCcYbWJ3SJ
Q8qhx92vXbBDpiHOcDAAWIJaS+AcIfWd40foZIlEGRP0+ZqzNFO2HXdhCblToR01
rWCsZ+Ko7xz3HJiOUe0eQ9HAWzoOZehdyTM7YUhQD6T/qhSItq8rbcE9PKI5ZvGf
ZaCCEEgWowFiXnYTux2suZUcHRvQU+oxii6UAoGAppDRRgF0dkWz1NjFG+scBtl0
yBTecVKghAkJTIr6IONLDXcbSvOPkPlMPfU/VGpQDZ1v9uybZqj0y+NqjzKiFZpa
7j+oi0Vy6a7Yj1I1KFRq
=9MlA
-----END PGP SIGNATURE-----

--MPfVkKkpva5o--
