Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:43646 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750718AbaLXECQ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 23 Dec 2014 23:02:16 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1Y3d9J-0003e0-GK
	for fstests@vger.kernel.org; Wed, 24 Dec 2014 15:02:13 +1100
Date: Wed, 24 Dec 2014 15:02:13 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 521cc6f
Message-ID: <20141224040213.GM24183@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.

The new head of the master branch is commit:

521cc6f xfstests: f2fs support

New Commits:

Dushan Tcholich (1):
      [469ec09] Reiser4 initial implementation

Eryu Guan (3):
      [974e2ba] common: exit only if tests find corruption
      [fe10af5] common: return failure if _check_xxx_filesystem find corrup=
tion
      [d3e4857] check: treat _check_{test,scratch}_fs failures as test fail=
ures

Jaegeuk Kim (1):
      [521cc6f] xfstests: f2fs support

Liu Bo (1):
      [e4aa15b] btrfs: add test case for qgroup account on shared extents

Theodore Ts'o (1):
      [08e57cd] ext4/004: limit the amount of data written so test runs fas=
ter

Xing Gu (1):
      [04312bb] xfs/111: fix cp of missing file


Code Diffstat:

 check               | 24 ++++++++++------
 common/config       | 17 ++++++++++-
 common/rc           | 30 +++++++++++++++++---
 tests/btrfs/017     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/btrfs/017.out |  5 ++++
 tests/btrfs/group   |  1 +
 tests/ext4/004      |  2 +-
 tests/xfs/111       |  2 +-
 8 files changed, 147 insertions(+), 16 deletions(-)
 create mode 100755 tests/btrfs/017
 create mode 100644 tests/btrfs/017.out
--=20
Dave Chinner
david@fromorbit.com

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUmjrEAAoJEK3oKUf0dfodiiMP/2y2+73yg4+wwEHUvTv/u6DC
NWAj8H+8ScxnmKSCc2o+OlCL9vzBx6UUrEwtl+hrK0iN27FjXkwASXPGmDIxezyN
xoV8ogb2ZJQjAkTSlSKEfYD2IszGMLTpMpd8y6NMLTuUAyVZv8m2SBguJS6TaBy+
nf1BAvaeJ8uYGT9txW7Myn/0nIIipszWq8emtR4i0KdJKdTwVgeFBgG/SYzKP4+8
Y7Sk4qFsYMRLOcaG2v/ZQfvuuP19qB4n8wd/8oRL4Cj5ksGe+haP1/5DZJ2v+SjZ
frRpbrY5omTbTtJbppefFt8NQ1eT2zwSbIRMbR9gbgef731BbK4qEhVHWyBoNiX5
+x7oUISIarOKv2GMAM0xlNAWOZ24ppKWCGNyDTD4oUAHASuf8XAu85SYvVsbA1kz
uA11zYQQCwC/CNugDxIG+eYT8+CZjnHlhTMN+xqEsM0DCBELyIXyej2+XEVzKieK
fs0gdghxBzAbRes+JlUl6wcflSG0PaKKXkTG0imvUGNAVe91dHbOvcKnKaPDHkFR
xL0C5vV70xmkHrs+AkRh7nwJPAsjgQu6YmsOnvyvrKWniIMU5hrOa6AQA5hHAtkS
RaL9ZtRXPgVij9C6uQ2nskWxJUi7ddb7b/lrPEWhfdDobRvd9H5zmf4h4W0bAi2D
YW0JSGKAEgyZ6HFEFoJL
=6gew
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
