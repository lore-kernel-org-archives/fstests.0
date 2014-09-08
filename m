Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:1792 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755102AbaIHXKy (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 8 Sep 2014 19:10:54 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1XR85B-0002pb-NM
	for fstests@vger.kernel.org; Tue, 09 Sep 2014 09:10:49 +1000
Date: Tue, 9 Sep 2014 09:10:49 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to cef4713
Message-ID: <20140908231049.GQ30012@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.  If your patches haven't been
committed because nobody has reviewed them, please organise for
someone to review your patches - don't assume the maintainer will
have the time to review your patches in a timely manner.

The new head of the master branch is commit:

cef4713 xfs/051: test buffer use after free race on I/O failure in XFS log =
recovery

New Commits:

Brian Foster (2):
      [7746b99] xfstests/common: don't assume sysfs attrs all reside under =
test dev
      [cef4713] xfs/051: test buffer use after free race on I/O failure in =
XFS log recovery

Dave Chinner (2):
      [c941f15] common: don't check scratch dev on all tests
      [f007c2b] filter: update xfs_repair filter for new sunit/swidth warni=
ng

Dmitry Monakhov (6):
      [c931376] common: add _mkfs_dev helper
      [072a845] common: _scratch_mkfs_sized inherent default block size fro=
m MKFS_OPTIONS
      [3727a19] src/e4compact cleanup
      [8c0fe78] src/e4compact: handle various block_size correctly
      [c4b1218] src/e4compact: add sparse file optimization
      [29b679e] ext4/308: add new defrag compact test case

Filipe Manana (1):
      [aaab9f3] xfstests: generic: add test for double msync, motivated by =
a btrfs bug

Pavel Shilovsky (3):
      [cf02f80] generic/013: encapsulate remount during cleanup
      [0e9141e] common: add cifs support
      [beb2114] cifs: skip tests that need POSIX support for nounix mounts

Theodore Ts'o (1):
      [1a28589] ext4: require fallocate support to run ext4/307


Code Diffstat:

 README                |   5 +-
 check                 |   2 +
 common/config         |  31 ++-
 common/rc             | 122 ++++++++-
 common/repair         |   3 +
 src/e4compact.c       | 110 ++++++--
 tests/btrfs/020       |   4 +-
 tests/ext4/307        |   1 +
 tests/ext4/308        | 103 ++++++++
 tests/ext4/308.out    | 681 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/ext4/group      |   3 +-
 tests/generic/005     |   8 +-
 tests/generic/013     |   2 +-
 tests/generic/023     |   1 +
 tests/generic/024     |   1 +
 tests/generic/025     |   1 +
 tests/generic/131     |   1 +
 tests/generic/311     |   2 +-
 tests/generic/321     |   2 +-
 tests/generic/322     |   2 +-
 tests/generic/325     | 106 ++++++++
 tests/generic/325.out |  19 ++
 tests/generic/group   |   1 +
 tests/shared/298      |   4 +-
 tests/xfs/001         |   2 +-
 tests/xfs/002         |   2 +-
 tests/xfs/005         |   2 +-
 tests/xfs/011         |   2 +-
 tests/xfs/045         |   2 +-
 tests/xfs/049         |   3 +-
 tests/xfs/051         |  95 +++++++
 tests/xfs/051.out     |   2 +
 tests/xfs/202         |   4 +-
 tests/xfs/205         |   3 +-
 tests/xfs/group       |   1 +
 35 files changed, 1281 insertions(+), 52 deletions(-)
 create mode 100755 tests/ext4/308
 create mode 100644 tests/ext4/308.out
 create mode 100755 tests/generic/325
 create mode 100644 tests/generic/325.out
 create mode 100755 tests/xfs/051
 create mode 100644 tests/xfs/051.out
--=20
Dave Chinner
david@fromorbit.com

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUDjd4AAoJEK3oKUf0dfod1IkP/3Hv5el+AJvbh8z9FEmdpL8T
bSRDW0DKmxLnrGS9tDuKr1NLfunJca92ix9gp/aYNPatQTbGkQVvPJ2ZqUDOCt+S
+QwcBWTuGqZCDqaeZoUQVT9cVfDOwR98COXP6LPgpIEFlQ37AzOjiJKl+XytTFUA
zArEjPsTK66P3FLw8l4aDu2wNulDjifWEVR9vDYoXclcOQEMFi8oWTlaLPG3NRiT
/BoFQ27/BEwbzr6HS/ourR9x/GIO8tB44LBgKrZHb1aJ66V3meNhusDm3qJtQseS
mGCkpy6gNwuPQNe52s59cWDMErG49GgqCjDwNN9e2nKpGK3C/NZKqokgl6ia1xjv
AcbGTlFh+YztcSygnhs0umnzYRTzpW1MGGwoKQLn7PMHNmbWgdRu5Vzkuk84ZAc5
E9atLttxBvd3wBK7j15elnEwmauiJfe7aTIguC3YllFQ2HCxGPhNnONvn/Q/Svi6
JU9gu2HJYHgazXcthfv1PjP1tRRDC0E4Dw/Zm0LJcDJcbJRSLJN/jwsvhYkcRx1K
KJNXzTJZl0S3FgYPo8HrxnTwptK0AtFRGHFB/l99VmbtWvgXUoXHc6YBTsVdIuyD
1wNuGz6iLi8qUc4BOQYjIyYjC1M+14nJgxVBkbduYsBCgEXoumkX/bdMQqdbYMmK
Tsn9/8YRT5j+YXvgrsqL
=17mC
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
