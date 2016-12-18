Received: from mx1.redhat.com ([209.132.183.28]:56110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbcLRHIT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 18 Dec 2016 02:08:19 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1BA180F98
        for <fstests@vger.kernel.org>; Sun, 18 Dec 2016 07:08:18 +0000 (UTC)
Received: from localhost (vpn1-6-32.pek2.redhat.com [10.72.6.32])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBI78GRO017851
        for <fstests@vger.kernel.org>; Sun, 18 Dec 2016 02:08:17 -0500
Message-Id: <201612180708.uBI78GRO017851@int-mx14.intmail.prod.int.phx2.redhat.com>
Date: Sun, 18 Dec 2016 15:08:15 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to c1cd6b1d57e1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ff3Wq8RiX8RN"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--ff3Wq8RiX8RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're new generic and overlay tests in this update,
as well as generic, overlay and reflink test fixes, and improvements on
excluding tests. Many thanks to Amir who has contributed 5 patches, including
new overlay tests and fixes and bug fix to check, also many thanks to others
who has contributed patches and reviewed patches!

New failure I noticed in this update:
- overlay/017,8 are new cases that fail on current Linus tree (4.9)

Thanks,
Eryu

The new head of the master branch is commit:

c1cd6b1d57e1 generic: make sure file size resource limit is honored by fs

New commits:

Amir Goldstein (5):
      [2257d91fe4a5] check: fix excluding test groups
      [131db6b27139] overlay/016: do not cd into $SCRATCH_MNT
      [fa8ec339e6cf] overlay: test unstable inode number
      [f69c41e5df58] overlay: associate tests to copyup group
      [d6e6c05c45bc] overlay: test hardlink breakage on copy up

Darrick J. Wong (1):
      [f613638308c9] reflink: don't test disjoint block sharing sets

Eric Biggers (1):
      [84db46e3d327] generic/062: don't assume same readdir order after re-creating directory

Eryu Guan (1):
      [c1cd6b1d57e1] generic: make sure file size resource limit is honored by fs

Wang Xiaoguang (1):
      [815015e9ee82] generic: make 17[1-4] work well when btrfs compression is enabled


Code Diffstat:

 check                 | 29 ++++++++-------
 common/populate       | 67 ++++++++++++++++++++++++++++++++++
 common/reflink        |  9 +++++
 tests/generic/062     |  7 ++--
 tests/generic/119     |  1 +
 tests/generic/171     |  4 +--
 tests/generic/172     |  5 +--
 tests/generic/173     |  4 +--
 tests/generic/174     |  4 +--
 tests/generic/256     | 66 ++++------------------------------
 tests/generic/394     | 73 +++++++++++++++++++++++++++++++++++++
 tests/generic/394.out |  2 ++
 tests/generic/group   |  1 +
 tests/overlay/016     | 13 ++++---
 tests/overlay/016.out |  4 +--
 tests/overlay/017     | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/017.out |  7 ++++
 tests/overlay/018     | 89 +++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/018.out |  2 ++
 tests/overlay/group   |  6 ++--
 20 files changed, 399 insertions(+), 93 deletions(-)
--
Eryu Guan
eguan@redhat.com

--ff3Wq8RiX8RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYVjSQAAoJECZSqilcj+djndoQAJyg73L5wXzPKpMYk0A0vSC/
xQDemMct2j89ZOb0Dp0B6Vus/qu0Lw/ezxrz9LJsM/hhewnpmCXtVlBWFT7VRzLv
k8/YtbDdPIJZ49HEwrFefCRS8bllgX4s+Znw56tXy1pj+d8fOOuoxyVN7kt9UlQu
Bj1hdeC7JiGY8NZqecr/v/TD2na3CaPi0dBortitFISRL5HGuGKmzI8x5GEPo9YF
gRH0rQJS9DtFpFoMe8c8UCZ6taDgK3iM4t5XoUtxYcdwymD6wGaXdWiir4Nayrbj
kEkdINu07GXxz7O/vH7Yb6D8qYo3bchmqPv+VYkoxazb2sAfi/9Xr4S+zatY0l4N
wtuuGIHHvXTDV3tz/KTDAyPNKLYkSMwb9k2xpeKPjA45I5JCdLi0LC6HIYWkc6uy
vuU7soLOwxqR3cimZedOPY4ug11bwc5aVthCnX+nmht0F/6/29g60/pNbT9rugSp
egLqTRNBV5i/S4musNYuIsD75cGbUSGJV0p1sWIVXRVTJGoYsHCJFBFfHq+klaNe
VFtqcekwX1XA2vH88HHZdZQWNyfO2MoAdVPgVa85XXhATzKYLIDuFypMkEJ2ImEJ
p8bcYhtQZ60+IARPijzwYWdTyIUMw4Ht2kOybcxz2G5bbXJxNT3Yljf3lncVWPg9
aAnhuG4JGM4tAVpJ7yyO
=mK4k
-----END PGP SIGNATURE-----

--ff3Wq8RiX8RN--
