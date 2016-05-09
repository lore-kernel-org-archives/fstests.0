Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:36866 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941AbcEIGS0 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 9 May 2016 02:18:26 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1azeVl-0004Kn-AA
	for fstests@vger.kernel.org; Mon, 09 May 2016 16:17:45 +1000
Date: Mon, 9 May 2016 16:17:45 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to 048edf0
Message-ID: <20160509061745.GV18496@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--ReaqsoxgOBHFXBhH
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

048edf0 generic: renumber tests after merge

New Commits:

Chandan Rajendra (1):
      [9cafe2a] generic/273: Remove hard coded block size

Darrick J. Wong (1):
      [45da5f5] block: test fallocate for block devices

Dave Chinner (2):
      [9ad045a] config: git should ignore config files in config directory
      [048edf0] generic: renumber tests after merge

Eric Sandeen (2):
      [4b52fff] dm-thinp helpers in common/dmthin
      [1c29986] dm-thinp demo test

Eryu Guan (2):
      [7898fdf] xfs/259: test more block sizes and handle minimum block siz=
e correctly
      [598600c] fstests: fix various $seqres.full issues

Filipe Manana (2):
      [31247b3] generic: test fsync after adding a link and moving other in=
ode
      [238397d] generic: test creating a symlink and then fsync its parent =
directory

Jan Kara (5):
      [ea99149] generic/340: Remove second fallocate test
      [96a3ad1] generic: Test races between mmap and normal writes
      [9e8b4e2] generic: Test races between mmap and normal write for prefa=
ulted ranges
      [507d315] generic: Test races between processes doing mmap writes
      [d0ec5f5] generic/038: Avoid EBUSY errors on umount

Mark Fasheh (2):
      [c9be5ca] btrfs: test snapshot create with invalid parent qgroup
      [5da816d] btrfs: Test that qgroup counts are valid after snapshot cre=
ation

Omar Sandoval (2):
      [0a9b318] btrfs: add replace missing and replace RAID 5/6 to profile =
configs
      [29d3a3e] btrfs: add test for replacing a missing device

Omer Zilberberg (1):
      [96c8c4d] gitignore: add src/holetest

Qu Wenruo (1):
      [b4e06bf] btrfs/091: Disable compress to avoid output dismatch

Xiaoguang Wang (1):
      [f614c27] common/populate: remove unnecessary devices directory creat=
ion

Xiong Zhou (3):
      [a175556] overlay: test basic whiteout
      [8582e24] overlay: notrun if upper fs does not support d_type
      [bf46f47] overlay: test copy up by changing mode bits

Zorro Lang (1):
      [40442d1] xfs/299: fix variable name typo


Code Diffstat:

 .gitignore            |   4 +
 common/dmthin         | 239 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 common/populate       |   2 -
 common/rc             | 111 ++++++++++++++-----------
 common/scsi_debug     |   6 +-
 src/holetest.c        | 183 ++++++++++++++++++++++++++--------------
 tests/btrfs/027       | 119 ++++++++++++++++++++++++++
 tests/btrfs/027.out   |   2 +
 tests/btrfs/091       |   3 +-
 tests/btrfs/121       |  68 +++++++++++++++
 tests/btrfs/121.out   |   2 +
 tests/btrfs/122       |  88 ++++++++++++++++++++
 tests/btrfs/122.out   |   1 +
 tests/btrfs/group     |   3 +
 tests/ext4/301        |   1 +
 tests/ext4/302        |   1 +
 tests/ext4/303        |   1 +
 tests/ext4/304        |   1 +
 tests/ext4/307        |   1 +
 tests/generic/038     |  15 +++-
 tests/generic/161     |   2 +-
 tests/generic/162     |   2 +-
 tests/generic/163     |   2 +-
 tests/generic/164     |   2 +-
 tests/generic/165     |   2 +-
 tests/generic/166     |   2 +-
 tests/generic/167     |   2 +-
 tests/generic/168     |   2 +-
 tests/generic/170     |   2 +-
 tests/generic/231     |   1 +
 tests/generic/273     |   8 +-
 tests/generic/333     |   2 +-
 tests/generic/334     |   2 +-
 tests/generic/340     |   1 -
 tests/generic/340.out |  18 ----
 tests/generic/343     |  86 +++++++++++++++++++
 tests/generic/343.out |  11 +++
 tests/generic/344     |  60 ++++++++++++++
 tests/generic/344.out |  73 ++++++++++++++++
 tests/generic/345     |  59 +++++++++++++
 tests/generic/345.out |  73 ++++++++++++++++
 tests/generic/346     |  58 +++++++++++++
 tests/generic/346.out |  55 ++++++++++++
 tests/generic/347     |  83 +++++++++++++++++++
 tests/generic/347.out |   2 +
 tests/generic/348     |  84 +++++++++++++++++++
 tests/generic/348.out |   4 +
 tests/generic/349     |  89 ++++++++++++++++++++
 tests/generic/349.out |  11 +++
 tests/generic/350     |  86 +++++++++++++++++++
 tests/generic/350.out |  10 +++
 tests/generic/351     | 130 +++++++++++++++++++++++++++++
 tests/generic/351.out |  32 +++++++
 tests/generic/group   |   9 ++
 tests/overlay/003     |  98 ++++++++++++++++++++++
 tests/overlay/003.out |   2 +
 tests/overlay/004     |  97 ++++++++++++++++++++++
 tests/overlay/004.out |   5 ++
 tests/overlay/group   |   2 +
 tests/xfs/104         |   2 +
 tests/xfs/109         |   1 +
 tests/xfs/122         |   2 +
 tests/xfs/164         |   1 +
 tests/xfs/227         |   2 -
 tests/xfs/244         |   1 +
 tests/xfs/259         |  47 +++++------
 tests/xfs/259.out     |  20 ++++-
 tests/xfs/261         |   1 +
 tests/xfs/278         |   3 +-
 tests/xfs/299         |   2 +-
 tests/xfs/304         |   1 +
 tests/xfs/305         |   1 +
 72 files changed, 2023 insertions(+), 181 deletions(-)
 create mode 100644 common/dmthin
 create mode 100755 tests/btrfs/027
 create mode 100644 tests/btrfs/027.out
 create mode 100755 tests/btrfs/121
 create mode 100644 tests/btrfs/121.out
 create mode 100755 tests/btrfs/122
 create mode 100644 tests/btrfs/122.out
 create mode 100755 tests/generic/343
 create mode 100644 tests/generic/343.out
 create mode 100644 tests/generic/344
 create mode 100644 tests/generic/344.out
 create mode 100644 tests/generic/345
 create mode 100644 tests/generic/345.out
 create mode 100644 tests/generic/346
 create mode 100644 tests/generic/346.out
 create mode 100755 tests/generic/347
 create mode 100644 tests/generic/347.out
 create mode 100755 tests/generic/348
 create mode 100644 tests/generic/348.out
 create mode 100755 tests/generic/349
 create mode 100644 tests/generic/349.out
 create mode 100755 tests/generic/350
 create mode 100644 tests/generic/350.out
 create mode 100755 tests/generic/351
 create mode 100644 tests/generic/351.out
 create mode 100755 tests/overlay/003
 create mode 100644 tests/overlay/003.out
 create mode 100755 tests/overlay/004
 create mode 100644 tests/overlay/004.out
--=20
Dave Chinner
david@fromorbit.com

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXMCuIAAoJEK3oKUf0dfodMlIQAM5SyKEBeDt5ENPN0qn9Bwgn
6MALD10e2CP5ujB58m2kAkW6iQ0z01jMswYnrC9uKQsKrs2CemFW+9n9yNczR/8e
rixD+59+OB2Jayr6Uj+rn83UiZAlru7MS4Otp7VIJ+3CB+N9DWNpberxQmiGuKAr
a0FfojiYES7k1Jq2toPr5/Hp2nKN+pLeTurfQwyD0XiL4HlsI8/WRuBXWDWrC5yR
QzYmOlUYg4I4brjWIYXdAarH8JVjgUHnYC2BP1f+sJfaWDz0DuG2enJE+Yl+Eo6V
FFZuHjY80PphSom+W3SyL/mLWJQqr3BaMp9X/9JZj8xbxFjmiNgH0FYrE3KWn4tC
V1ywcMEPOdJoXqLLLoHMWkgGydHuZBsvddq+dvWisrHTIBOdC0E78iJOpTJCxBst
8XGCos8zYnROaS5/WeASOk7BNW4aSnfnU+ddyL3q7m2BiO/Q9qB+KPW0lLh/dLua
uJ7UZmDpAC1vgNKsujjdIQS676eMDMo+MY3lc172FzEl3D1cmb4sABBMeoOXSV19
kZpzfVyBNRGCMMuWZKqR2JvkFDRi7Rud5M/QMJZ8vYG6VCi2UeRYXe1QUmOSyOvu
TGyNlQA91PCYnd5areZ/L34C9s2egGUQGgdB6nRiBfAf4Z7hAUqPMUj3qJFzDTax
MKMS1T+zl0tO3qFZEu80
=ore9
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
