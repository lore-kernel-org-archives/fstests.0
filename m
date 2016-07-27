Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:55020 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752229AbcG0EUN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 27 Jul 2016 00:20:13 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1bSGKF-0008Ip-BB
	for fstests@vger.kernel.org; Wed, 27 Jul 2016 14:20:07 +1000
Date: Wed, 27 Jul 2016 14:20:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 6721ab0
Message-ID: <20160727042007.GI12670@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The change summary from Eryu's pull request:

	This update contains:

	o Improvements in extended test names handling
	o The first test with an extended name (xfs/191-input-validation)
	o New test cases for xfs and btrfs
	o Other bug fixes and improvements

The full list of changes merged is below.

-Dave.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

6721ab0 generic/235: Fix false failures for some quota formats

New Commits:

Christoph Hellwig (1):
      [b62a0b3] generic/120: requires working *atime mount options

Eric Sandeen (1):
      [cf94bc8] generic/075,112: fix up fsx error handling

Eryu Guan (2):
      [58bff72] common/rc: avoid mkfs option conflicts in _scratch_mkfs_xfs=
_supported
      [a4cafa0] xfs: fix wrong seq order in group file

Jan Kara (3):
      [9b06a9f] generic/294: Filter backquotes from mknod error output
      [e1f9441] common/filter: Improve xfs_io filter
      [6721ab0] generic/235: Fix false failures for some quota formats

Jan Tulak (4):
      [cb15a45] build: Fix installation for extended names
      [1fd02fd] check: fix extended names handling
      [27daf0c] check: remove unused variable
      [9a8bdd8] xfs: Add mkfs input validation tests

Qu Wenruo (2):
      [a4f0a9b] btrfs: send on fully deduped file
      [fc2b488] btrfs: Update quick and auto tag for btrfs group

Xiao Yang (1):
      [b659460] xfs/083: disable dmesg check


Code Diffstat:

 check                              |  26 ++--
 common/filter                      |   6 +-
 common/rc                          |  11 +-
 include/buildrules                 |  32 ++++
 tests/btrfs/130                    |  89 +++++++++++
 tests/btrfs/130.out                |   3 +
 tests/btrfs/Makefile               |   4 +-
 tests/btrfs/group                  |   9 +-
 tests/cifs/Makefile                |   4 +-
 tests/ext4/Makefile                |   4 +-
 tests/f2fs/Makefile                |   4 +-
 tests/generic/075                  |   4 +-
 tests/generic/112                  |   2 +-
 tests/generic/120                  |   2 +
 tests/generic/235                  |   9 +-
 tests/generic/235.out              |   8 -
 tests/generic/Makefile             |   4 +-
 tests/overlay/Makefile             |   4 +-
 tests/shared/Makefile              |   4 +-
 tests/udf/Makefile                 |   4 +-
 tests/xfs/083                      |   4 +
 tests/xfs/191-input-validation     | 338 +++++++++++++++++++++++++++++++++=
+++++++
 tests/xfs/191-input-validation.out |   2 +
 tests/xfs/Makefile                 |   4 +-
 tests/xfs/group                    |   3 +-
 25 files changed, 533 insertions(+), 51 deletions(-)
 create mode 100755 tests/btrfs/130
 create mode 100644 tests/btrfs/130.out
 create mode 100755 tests/xfs/191-input-validation
 create mode 100644 tests/xfs/191-input-validation.out
--=20
Dave Chinner
david@fromorbit.com

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXmDZ2AAoJEK3oKUf0dfod4+gQAITx4lZiqc/1eyHxc7PgiJCn
DaHraf2tczZU0oht10mJHOMb4LZhDrOdFf6MHe6AZjf9MJ4f/leSYocwKUELG1nz
KJVbj7GGRG2FM4FPKBIoj4nDEO1lu+KxRHkvuvrp2vMX35mzne05eVprakjZZY3b
LUu/lh6rpioiwMIRqnUl4ORTtjlzv7X6WT7KhVsiVeRSV0Bt0kyHKSQt8OyI+FJg
0fd9+nLWMUs0wpRr/W3KWbDeziC6Xa9ugsWdhMhioI0R7DmzvChmzgz/jbN/gbkx
NhSc9H92M8x1/YjxU2Yjd3e+ODJBW7A+m5yYvZSlohVoLgUk8KFPIxdfa46f8yqo
qpXWCOwVHgNxdOuRTofwOAwV12MxV558poCBgR2yHry8XTLtQhvL/tx1OWF82187
rMlztM8kq3M2IVRtG2pWvEmnea+Jqx8SPdQmwnh1T8vq0STzuzah7tIlqKGZGXxM
FdXUjxgzSczodTu2oRsiLhFvNAKR56SouGnV2MU4q7HrFmIwf9XRLO209gSDcnxv
mZ/3qjxi6/a+/IaL5vACUbCO4SS0iaBchS+jA/YrVR+hG+CLzGLAcl66uNwWChQf
LTg19L7E6Z2U7FTrFkHdIlRHWrPoOj1clI/WEM+k4020ZxV8HCAwjnOXiegznukp
XTfGlAlp2cfDmrWQByjI
=MIKN
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--
