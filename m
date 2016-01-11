Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:37991 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758252AbcAKEdH (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 10 Jan 2016 23:33:07 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1aIUAC-0001it-60
	for fstests@vger.kernel.org; Mon, 11 Jan 2016 15:33:04 +1100
Date: Mon, 11 Jan 2016 15:33:04 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to dfe582d
Message-ID: <20160111043304.GI10456@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

dfe582d fstests: canonicalize the mount points by removing the trailing "/"

New Commits:

Andreas Gruenbacher (6):
      [3597757] fsx: Small improvements and fixes
      [c8ba071] fsx: Fix hex numbers in operation dump
      [6b7be00] fsx: Report number of successful operations
      [e1598eb] fsx: Generate test parameters in test()
      [ed49ff0] fsx: Improve operation logging
      [2a78c1d] fsx: Add mechanism to replay failed operations

Brian Foster (1):
      [05754e6] xfs: test XFS torn log write detection

Eryu Guan (1):
      [ef19328] common/scsi_debug: fix removal of scsi_debug module

Filipe Manana (4):
      [7a9cfc2] fstests: cleanup test btrfs/029
      [a6630c0] fstests: cleanup test btrfs/031
      [cc2dce7] fstests: fix cleanup of test btrfs/003
      [315e6b4] fstests: btrfs, verify fitrim does not discard reserved dev=
ice area

Jia He (1):
      [dfe582d] fstests: canonicalize the mount points by removing the trai=
ling "/"

Xiao Yang (1):
      [37de4bf] f2fs: add Makefile for f2fs

Xiong Zhou (1):
      [20516cd] shared: test mount needs_recovery extN partition with noloa=
d option


Code Diffstat:

 common/config         |   5 +
 common/rc             |  14 ++
 common/scsi_debug     |  10 +-
 ltp/fsx.c             | 415 +++++++++++++++++++++++++++++++++++++---------=
----
 tests/btrfs/003       |  10 +-
 tests/btrfs/029       |  45 +++---
 tests/btrfs/029.out   |  12 +-
 tests/btrfs/031       | 102 ++++++-------
 tests/btrfs/116       |  76 +++++++++
 tests/btrfs/116.out   |  12 ++
 tests/btrfs/group     |   1 +
 tests/f2fs/Makefile   |  21 +++
 tests/generic/091     |  12 --
 tests/generic/127.out |  12 +-
 tests/generic/231.out |  12 +-
 tests/generic/263     |  12 --
 tests/shared/003      |  70 +++++++++
 tests/shared/003.out  |   2 +
 tests/shared/group    |   1 +
 tests/xfs/141         |  85 +++++++++++
 tests/xfs/141.out     |   2 +
 tests/xfs/group       |   1 +
 22 files changed, 698 insertions(+), 234 deletions(-)
 create mode 100755 tests/btrfs/116
 create mode 100644 tests/btrfs/116.out
 create mode 100644 tests/f2fs/Makefile
 create mode 100755 tests/shared/003
 create mode 100644 tests/shared/003.out
 create mode 100755 tests/xfs/141
 create mode 100644 tests/xfs/141.out
--=20
Dave Chinner
david@fromorbit.com

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJWkzB/AAoJEK3oKUf0dfodW+gP/3Q3YEXIAXF/NZWWGFJbA1Xv
efwhsLcHc+NFDffesQM4agq72l9VFSwg976FK6sQ/7g6anBLgCq/rrkcrOiG/147
It+Csj2mebWGf9YMnw4vyknttsK/zH83UqpX1GaZJqx82Hn7p2Pp3+EERHnzEn+c
lMcG8jagU5G/UyYF+PR/yvp4IKs2MbUaDsb7h5rOPQoQsBK1X6vyj8UvNTR9c9Xn
3WUqKOP+nrc22KkCP1b6Zypsb+LndAMaBy3z/NN/tbBL9jVl69h2/ReRwh/YEXsI
JaaOv82t97vBai14uFn2GnUJUbWGaFNWJIlx8Sv3VIsuFBVCP96xn9jt+xl+39K7
BUIA+xw33zlXh9nhn6ZJVyidkfk1xW7fdRCApC/XbJ5f9woRUWGaDgdFtA72dfs/
l/n08lEqrwqHWjtDOaskSJMgdVvK+Zcz/Qy2tNQiRzMA3vVyPYU0Ia8xw3hZUBeP
NH2lTpb28HFnZ8oqUcjqpataN2MyL9woI2YM+U/DxxU7GOmJ6NZyOflkugBqp35s
g+Tl6PQnnQuMwhYDRDVu9IB/a9ZEs0ieFnchKlwSFqlNqZuQkpL7C8uJY2VcNqKY
OzPFaUQ9s7Q9O20ze4bSXgBE03EOVp0SVLoXsyt2FHcbHexZSU2nOg6y2k978vkv
nz/m/i4h1pTl0J3AOEbR
=bTQy
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
