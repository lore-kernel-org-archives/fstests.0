Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:42010 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794AbcGKW3D (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 11 Jul 2016 18:29:03 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1bMjhD-0006DV-5h
	for fstests@vger.kernel.org; Tue, 12 Jul 2016 08:28:59 +1000
Date: Tue, 12 Jul 2016 08:28:59 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 024bdae
Message-ID: <20160711222859.GP12670@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Thanks again to Eryu for putting together
this update.

Patches may get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

024bdae ext4/021: add _require_metadata_journaling

New Commits:

Anand Jain (6):
      [3dc4411] btrfs: add functions to set and reset required number of SC=
RATCH_DEV_POOL
      [030c355] btrfs: add functions to get and put a device for replace ta=
rget
      [a1747a7] btrfs/027: make use of new device get and put helper functi=
ons
      [595c9c8] btrfs: add helper function to check if btrfs is module
      [610a748] btrfs: test RAID1 device reappear and balance
      [e78540a] btrfs: test RAID5 device reappear and balance

Andreas Gruenbacher (2):
      [9d93ce7] fstests: Add / use _require_runas and _runas
      [73f9e47] generic: Add richacl tests

Brian Foster (2):
      [781fc5b] common: support dm-delay to introduce I/O delays
      [9490edd] xfs: test for post umount readahead completion panic

Christoph Hellwig (1):
      [00a1397] generic/042: remove from quick group

Darrick J. Wong (7):
      [f5187c4] xfs/122: fix test output to reflect latest xfsprogs
      [8ed5571] xfs/235: fix logic errors when checking rmap usage after fa=
ilures
      [13eeb94] xfs/229: require 3GB of space
      [58dc199] generic/204: increase log size for rmap/reflink
      [219d4cd] xfs/128: use $XFS_FSR_PROG instead of xfs_fsr directly
      [872ccc5] xfs: inject errors at various parts of the deferred op comp=
letion
      [1103003] xfs: test clearing reflink inode flag

Eric Whitney (1):
      [024bdae] ext4/021: add _require_metadata_journaling

Eryu Guan (2):
      [4ae7290] overlay: dentry leak for default_permissions mount option
      [a1c4e17] overlay: remove dir which contains whiteout from lower dir

Jeff Mahoney (1):
      [2831b8b] btrfs/048: extend _filter_btrfs_prop_error to handle additi=
onal errors

Omer Zilberberg (1):
      [78f071b] generic/294: filter quotes from mknod

Qu Wenruo (1):
      [5bde258] btrfs: EDQUOTA leaks reserved data space

Theodore Ts'o (3):
      [9b154b2] common/rc: ext4 doesn't support O_DIRECT with encryption
      [12132c4] generic/082: rename _filter_project_quota to a avoid functi=
on name conflict
      [76eb2b1] quota: fix generic/244 on 32-bit platforms

Zorro Lang (2):
      [4cd659b] common/dmerror: fix nonsensical arguments handling
      [2a7b77a] xfs: configurable behavior on errors at unmount time


Code Diffstat:

 common/config         |   2 +
 common/dmdelay        |  90 +++++++++++++++++
 common/dmerror        |  14 ++-
 common/filter         |   7 ++
 common/filter.btrfs   |  10 +-
 common/inject         |  93 +++++++++++++++++
 common/log            |  28 ++++++
 common/rc             | 289 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++--
 src/test-nextquota.c  |   7 +-
 tests/btrfs/027       |  24 +++--
 tests/btrfs/048       |   6 +-
 tests/btrfs/048.out   |   4 +-
 tests/btrfs/124       | 166 ++++++++++++++++++++++++++++++
 tests/btrfs/124.out   |   7 ++
 tests/btrfs/125       | 182 +++++++++++++++++++++++++++++++++
 tests/btrfs/125.out   |   7 ++
 tests/btrfs/126       |  73 ++++++++++++++
 tests/btrfs/126.out   |   2 +
 tests/btrfs/group     |   3 +
 tests/ext4/021        |   1 +
 tests/generic/082     |   6 +-
 tests/generic/093     |  14 ++-
 tests/generic/099     |  45 ++++-----
 tests/generic/204     |   6 +-
 tests/generic/237     |   6 +-
 tests/generic/294     |   2 +-
 tests/generic/294.out |   2 +-
 tests/generic/362     | 125 +++++++++++++++++++++++
 tests/generic/362.out |  94 +++++++++++++++++
 tests/generic/363     | 118 ++++++++++++++++++++++
 tests/generic/363.out | 139 ++++++++++++++++++++++++++
 tests/generic/364     |  98 ++++++++++++++++++
 tests/generic/364.out |  39 ++++++++
 tests/generic/365     |  93 +++++++++++++++++
 tests/generic/365.out |   9 ++
 tests/generic/366     |  86 ++++++++++++++++
 tests/generic/366.out |  11 ++
 tests/generic/367     |  85 ++++++++++++++++
 tests/generic/367.out |  11 ++
 tests/generic/368     |  85 ++++++++++++++++
 tests/generic/368.out |   7 ++
 tests/generic/369     | 126 +++++++++++++++++++++++
 tests/generic/369.out |  24 +++++
 tests/generic/370     |  90 +++++++++++++++++
 tests/generic/370.out |  19 ++++
 tests/generic/group   |  11 +-
 tests/overlay/009     |  68 +++++++++++++
 tests/overlay/009.out |   2 +
 tests/overlay/010     |  78 +++++++++++++++
 tests/overlay/010.out |   2 +
 tests/overlay/group   |   2 +
 tests/shared/051      |  48 +++++----
 tests/xfs/006         | 116 +++++++++++++++++++++
 tests/xfs/006.out     |   7 ++
 tests/xfs/122.out     |   4 +-
 tests/xfs/128         |   8 +-
 tests/xfs/229         |   1 +
 tests/xfs/235         |   4 +-
 tests/xfs/235.out     |   1 -
 tests/xfs/311         |  91 +++++++++++++++++
 tests/xfs/311.out     |   2 +
 tests/xfs/312         | 102 +++++++++++++++++++
 tests/xfs/312.out     |  18 ++++
 tests/xfs/313         | 102 +++++++++++++++++++
 tests/xfs/313.out     |  18 ++++
 tests/xfs/314         | 106 ++++++++++++++++++++
 tests/xfs/314.out     |  18 ++++
 tests/xfs/315         |  99 ++++++++++++++++++
 tests/xfs/315.out     |  16 +++
 tests/xfs/316         | 100 ++++++++++++++++++
 tests/xfs/316.out     |  16 +++
 tests/xfs/317         |  95 ++++++++++++++++++
 tests/xfs/317.out     |  16 +++
 tests/xfs/318         |  93 +++++++++++++++++
 tests/xfs/318.out     |  15 +++
 tests/xfs/319         |  97 ++++++++++++++++++
 tests/xfs/319.out     |  19 ++++
 tests/xfs/320         |  95 ++++++++++++++++++
 tests/xfs/320.out     |  18 ++++
 tests/xfs/321         |  94 +++++++++++++++++
 tests/xfs/321.out     |  17 ++++
 tests/xfs/322         |  97 ++++++++++++++++++
 tests/xfs/322.out     |  17 ++++
 tests/xfs/323         |  94 +++++++++++++++++
 tests/xfs/323.out     |  17 ++++
 tests/xfs/324         | 101 +++++++++++++++++++
 tests/xfs/324.out     |  17 ++++
 tests/xfs/325         |  95 ++++++++++++++++++
 tests/xfs/325.out     |  15 +++
 tests/xfs/326         | 109 ++++++++++++++++++++
 tests/xfs/326.out     |  18 ++++
 tests/xfs/327         |  93 +++++++++++++++++
 tests/xfs/327.out     |  20 ++++
 tests/xfs/group       |  18 ++++
 94 files changed, 4562 insertions(+), 103 deletions(-)
 create mode 100644 common/dmdelay
 create mode 100644 common/inject
 create mode 100755 tests/btrfs/124
 create mode 100644 tests/btrfs/124.out
 create mode 100755 tests/btrfs/125
 create mode 100644 tests/btrfs/125.out
 create mode 100755 tests/btrfs/126
 create mode 100644 tests/btrfs/126.out
 create mode 100755 tests/generic/362
 create mode 100644 tests/generic/362.out
 create mode 100755 tests/generic/363
 create mode 100644 tests/generic/363.out
 create mode 100755 tests/generic/364
 create mode 100644 tests/generic/364.out
 create mode 100755 tests/generic/365
 create mode 100644 tests/generic/365.out
 create mode 100755 tests/generic/366
 create mode 100644 tests/generic/366.out
 create mode 100755 tests/generic/367
 create mode 100644 tests/generic/367.out
 create mode 100755 tests/generic/368
 create mode 100644 tests/generic/368.out
 create mode 100755 tests/generic/369
 create mode 100644 tests/generic/369.out
 create mode 100755 tests/generic/370
 create mode 100644 tests/generic/370.out
 create mode 100755 tests/overlay/009
 create mode 100644 tests/overlay/009.out
 create mode 100755 tests/overlay/010
 create mode 100644 tests/overlay/010.out
 create mode 100755 tests/xfs/006
 create mode 100644 tests/xfs/006.out
 create mode 100755 tests/xfs/311
 create mode 100644 tests/xfs/311.out
 create mode 100755 tests/xfs/312
 create mode 100644 tests/xfs/312.out
 create mode 100755 tests/xfs/313
 create mode 100644 tests/xfs/313.out
 create mode 100755 tests/xfs/314
 create mode 100644 tests/xfs/314.out
 create mode 100755 tests/xfs/315
 create mode 100644 tests/xfs/315.out
 create mode 100755 tests/xfs/316
 create mode 100644 tests/xfs/316.out
 create mode 100755 tests/xfs/317
 create mode 100644 tests/xfs/317.out
 create mode 100755 tests/xfs/318
 create mode 100644 tests/xfs/318.out
 create mode 100755 tests/xfs/319
 create mode 100644 tests/xfs/319.out
 create mode 100755 tests/xfs/320
 create mode 100644 tests/xfs/320.out
 create mode 100755 tests/xfs/321
 create mode 100644 tests/xfs/321.out
 create mode 100755 tests/xfs/322
 create mode 100644 tests/xfs/322.out
 create mode 100755 tests/xfs/323
 create mode 100644 tests/xfs/323.out
 create mode 100755 tests/xfs/324
 create mode 100644 tests/xfs/324.out
 create mode 100755 tests/xfs/325
 create mode 100644 tests/xfs/325.out
 create mode 100755 tests/xfs/326
 create mode 100644 tests/xfs/326.out
 create mode 100755 tests/xfs/327
 create mode 100644 tests/xfs/327.out
--=20
Dave Chinner
david@fromorbit.com

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXhB2qAAoJEK3oKUf0dfodpMQQAMxrbUJ3nWqrVoxF9N/tUaJi
LcUX16hi08WzF5qLw0+fiYbBAMiscKBm7XNju1DPhUqPMZoQjU9KYKrqbqF5Ne7i
qGoyOffqHdy+KGGSLz16YSqKzI6iobI/N4hwBhSEqqt8ez8VpQ2uIMCC/Ujby7Cd
dR8Hvc96JzAoCGmMvcnT7e6/F+Sr9WCPi2IN4L1JciD8wK8oFy5opOTPhbm0DJi6
RXkmbubqnfFyNYzwKPDAZB5H2b9pyRf3bPW6Hp/WuK061rjTe+63hj1QToJP8wSA
713kJq7m+4WDIuTQHNjRyDPmZoEcdacuRrx8pmsgcq15hvaCHv2IwAFP+umigMzW
l7Nu5gebrksbmwe6PD6KBf6Kb9fM79TLMsNJ/2dQZ427Lwdq+mGBqrvAXo5sdo2R
J5Ds7hCAeKe6Qb9+SwrtcF3Z6OyjwZt4yghppM8ztdm9Leoh6pxqwEBpGy7+T0oJ
/hUfhBrUh09U1nc0I+Ym70C0P3OIXLvT71PzAiLmk8gZQWG40UzC7SWISXbQ5wEH
Fg7Nx85nS7ZRVEMs2P4k8bYJQWV5qbyxbGf+CWn3BanNXxqQ1y7B+2On1Q0pTbKi
t9jrBoXQe0xyL2OVrBpSLGiC2fXY78wT13VedZPlNHemkCMu7cTs6m0akuqoRnfM
tcjtV/m5CN0Eoyt2R0mc
=Qv16
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--
