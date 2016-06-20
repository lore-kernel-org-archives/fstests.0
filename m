Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:60811 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753309AbcFTW75 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2016 18:59:57 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1bF8AG-0006sk-C9
	for fstests@vger.kernel.org; Tue, 21 Jun 2016 08:59:32 +1000
Date: Tue, 21 Jun 2016 08:59:32 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to 5f02db6
Message-ID: <20160620225932.GP12670@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I'm pleased to announce that I've just pushed the first set of
commits from Eryu Guan - our new Maintainer - to the upstream
repositories.

If you find any problems in this update, then please shout at me
rather than Eryu because it means I didn't find all the things I
should have when reviewing his first public pull request.

-Dave.

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

5f02db6 btrfs: qgroup handling on data extents balance

New Commits:

Brian Foster (1):
      [c8c0cfc] xfs: discontiguous multi-block buffer logging test

Christoph Hellwig (2):
      [f971863] generic/346: add to the quick and rw groups
      [80ff43c] generic/186-7: fix unreferenced variables

Darrick J. Wong (8):
      [b5e26de] xfs/104: don't enospc when ag metadata overhead grows
      [478f75b] generic: don't put loop control files on the scratch mount
      [b1e1b5f] xfs: recover copy-on-write leftover
      [0199ca7] xfs: check accounting during refcountbt expansion
      [12c5657] reflink: avoid reflink on swap files
      [ffad912] xfs: map multiple bmbt records to a single rmapbt record
      [44b9337] reflink: change block sharing with constant refcount
      [c0c6e54] xfs/122: don't break on old xfsprogs

Eric Sandeen (2):
      [cf00fec] dmerror: exclude dmerror tests with mount -o dax
      [dddc12b] xfs: filter stripe width details from repair

Eryu Guan (4):
      [86e7366] generic/250: ignore xfs_io IO errors when writing to dmerro=
r device
      [6f54d81] generic: clear of suid/sgid on direct write
      [782bd26] generic: check symlink to very long path
      [3cd0566] generic: check remount on I/O errors

Guangwen Feng (1):
      [4de189a] shared: check corrupted orphaned inode list handling

Jan Kara (1):
      [2400133] generic: Test handling of private file mappings

Jeffrey Bastian (1):
      [ca7c8bc] build: avoid struct fsxattr redefinition

Lu Fengqi (1):
      [c8868d9] btrfs: check qgroup on extent de-reference

Masayoshi Mizuma (1):
      [2fb853c] fstests: add _require_command check to killall

Qu Wenruo (3):
      [6df776b] generic: extent map search on dedupe file
      [5c2fbcc] generic: check fiemap SHARED flag on sync
      [5f02db6] btrfs: qgroup handling on data extents balance

Tahsin Erdogan (1):
      [b936f63] generic/131: dynamically allocate tcp listen port to avoid =
port clashes

Theodore Ts'o (3):
      [850bc06] defrag: test $TEST_DEV for extents for ext4 defrag
      [2d59a75] generic: mark tests that require O_DIRECT
      [795ea36] shared/272: don't try to use O_DIRECT

Wang Xiaoguang (2):
      [a3d11fa] generic/015,274: add to the 'enospc' group
      [1f800db] ext4: regression test for fsync transaction ids initializat=
ion

Xiong Zhou (1):
      [8b8cdb0] overlay: test memleak in copy-up error handling path

Zorro Lang (2):
      [8469a8c] xfs/133-4: filter redundant projid 0 quota report info out
      [a6f6e59] common/rc: teach _require_xfs_io_command accept multi-param=
eters


Code Diffstat:

 common/config           |   1 +
 common/defrag           |   2 +-
 common/dmerror          |   5 ++
 common/dmhugedisk       |  60 +++++++++++++++++
 common/filter           |   9 +++
 common/punch            |  17 +++++
 common/rc               |   7 +-
 common/repair           |   2 +
 ltp/fsstress.c          |   2 +-
 src/holetest.c          | 121 +++++++++++++++++++++++++---------
 src/locktest.c          |  16 ++++-
 src/t_immutable.c       |   4 +-
 tests/btrfs/028         |  95 +++++++++++++++++++++++++++
 tests/btrfs/028.out     |   2 +
 tests/btrfs/123         |  85 ++++++++++++++++++++++++
 tests/btrfs/123.out     |  67 +++++++++++++++++++
 tests/btrfs/group       |   2 +
 tests/ext4/021          | 106 ++++++++++++++++++++++++++++++
 tests/ext4/021.out      |   2 +
 tests/ext4/group        |   1 +
 tests/generic/051       |   5 +-
 tests/generic/094       |   1 +
 tests/generic/131       |  17 ++---
 tests/generic/162       |   8 ++-
 tests/generic/163       |   8 ++-
 tests/generic/164       |   8 ++-
 tests/generic/165       |   8 ++-
 tests/generic/166       |   8 ++-
 tests/generic/167       |   8 ++-
 tests/generic/168       |   8 ++-
 tests/generic/170       |   8 ++-
 tests/generic/186       |   2 +-
 tests/generic/187       |   2 +-
 tests/generic/225       |   1 +
 tests/generic/250       |   5 +-
 tests/generic/250.out   |   3 +-
 tests/generic/270       |   3 +-
 tests/generic/310       |   5 +-
 tests/generic/311       |   1 +
 tests/generic/333       |  20 +++---
 tests/generic/334       |  20 +++---
 tests/generic/352       |  98 ++++++++++++++++++++++++++++
 tests/generic/352.out   |   5 ++
 tests/generic/353       |  92 ++++++++++++++++++++++++++
 tests/generic/353.out   |  15 +++++
 tests/generic/354       |  60 +++++++++++++++++
 tests/generic/354.out   |  73 +++++++++++++++++++++
 tests/generic/355       |  98 ++++++++++++++++++++++++++++
 tests/generic/355.out   |  14 ++++
 tests/generic/356       |  74 +++++++++++++++++++++
 tests/generic/356.out   |   6 ++
 tests/generic/357       |  73 +++++++++++++++++++++
 tests/generic/357.out   |   5 ++
 tests/generic/358       |  80 +++++++++++++++++++++++
 tests/generic/358.out   |  69 ++++++++++++++++++++
 tests/generic/359       |  94 +++++++++++++++++++++++++++
 tests/generic/359.out   |  20 ++++++
 tests/generic/360       |  63 ++++++++++++++++++
 tests/generic/360.out   |   2 +
 tests/generic/361       |  78 ++++++++++++++++++++++
 tests/generic/361.out   |   2 +
 tests/generic/group     |  16 ++++-
 tests/overlay/005       | 115 ++++++++++++++++++++++++++++++++
 tests/overlay/005.out   |   2 +
 tests/overlay/group     |   1 +
 tests/shared/004        |  64 ++++++++++++++++++
 tests/shared/004.out    |   2 +
 tests/shared/272        |   4 +-
 tests/shared/group      |   1 +
 tests/xfs/011           |   5 +-
 tests/xfs/013           |   5 +-
 tests/xfs/030.out.linux |   4 +-
 tests/xfs/051           |   5 +-
 tests/xfs/070           |   3 +-
 tests/xfs/079           |   3 +-
 tests/xfs/104           |   9 ++-
 tests/xfs/122           |  17 ++---
 tests/xfs/122.out       |   1 +
 tests/xfs/133           |   2 +-
 tests/xfs/134           |  20 ++++--
 tests/xfs/141           |   3 +-
 tests/xfs/148.out       |   4 +-
 tests/xfs/167           |   2 +-
 tests/xfs/178.out       |   4 +-
 tests/xfs/297           |   3 +-
 tests/xfs/305           |   3 +-
 tests/xfs/306           | 121 ++++++++++++++++++++++++++++++++++
 tests/xfs/306.out       |   2 +
 tests/xfs/307           | 179 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/xfs/307.out       |  13 ++++
 tests/xfs/308           | 180 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 tests/xfs/308.out       |  13 ++++
 tests/xfs/309           |  95 +++++++++++++++++++++++++++
 tests/xfs/309.out       |  10 +++
 tests/xfs/310           | 119 ++++++++++++++++++++++++++++++++++
 tests/xfs/310.out       |  13 ++++
 tests/xfs/group         |   5 ++
 97 files changed, 2678 insertions(+), 146 deletions(-)
 create mode 100644 common/dmhugedisk
 create mode 100755 tests/btrfs/028
 create mode 100644 tests/btrfs/028.out
 create mode 100755 tests/btrfs/123
 create mode 100644 tests/btrfs/123.out
 create mode 100755 tests/ext4/021
 create mode 100644 tests/ext4/021.out
 create mode 100755 tests/generic/352
 create mode 100644 tests/generic/352.out
 create mode 100755 tests/generic/353
 create mode 100644 tests/generic/353.out
 create mode 100644 tests/generic/354
 create mode 100644 tests/generic/354.out
 create mode 100755 tests/generic/355
 create mode 100644 tests/generic/355.out
 create mode 100755 tests/generic/356
 create mode 100644 tests/generic/356.out
 create mode 100755 tests/generic/357
 create mode 100644 tests/generic/357.out
 create mode 100755 tests/generic/358
 create mode 100644 tests/generic/358.out
 create mode 100755 tests/generic/359
 create mode 100644 tests/generic/359.out
 create mode 100755 tests/generic/360
 create mode 100644 tests/generic/360.out
 create mode 100755 tests/generic/361
 create mode 100644 tests/generic/361.out
 create mode 100755 tests/overlay/005
 create mode 100644 tests/overlay/005.out
 create mode 100755 tests/shared/004
 create mode 100644 tests/shared/004.out
 create mode 100755 tests/xfs/306
 create mode 100644 tests/xfs/306.out
 create mode 100755 tests/xfs/307
 create mode 100644 tests/xfs/307.out
 create mode 100755 tests/xfs/308
 create mode 100644 tests/xfs/308.out
 create mode 100755 tests/xfs/309
 create mode 100644 tests/xfs/309.out
 create mode 100755 tests/xfs/310
 create mode 100644 tests/xfs/310.out
--=20
Dave Chinner
david@fromorbit.com

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXaHVTAAoJEK3oKUf0dfod4XMP/RRmqceV22hU5GCh5osSJIJb
Wz+swTj5Y0oLBoGKx8qPe0x0eY4NE62IyfeJCuUXPt7j/bYjCK2ksceqV1DZK0sn
9JPUHEi5Jtt0bzaNYX88mD2rJ/L7ts56uLUWhGtDuyoKXBsFpVwtQi3NfNMXb/nx
QcKGMedk+j1qhKWAXxE/MCb3tE9tj+FrhPLsNRtFPFmoV3/509MXlxgT7dTQdcia
OCARlQBOu7X2Z4gEyQpA7aiSGvrsHf6Xammy4l84m2egyW9jdliQlru7NbkFhfsA
4NnEcEbSJ+E3mGiVHgm5ZLDYgyD3IR8xXmX/dbubbDwyi+iFyFF6k9gJGjcVFYEl
pkOawxFquu2z49SAQdYzGr0ATuddVZVYxrkylsHVZw9Bx1tLDPEeZFxXxnC1/2V+
ZX8iFBUrSnhb566KCGgZiKIbgkjFV3AZOaGgm4cUL/9UFN0YS+kuOf9YTbhOQJIT
5fKR8PU1+mHrwgzzbqGyCccef237zVDH7jWlXK9q4pnXj4PAoFTKzCgHarwiJTzv
rWwXTQsTYocXQayDIaiCZDtUaP7HO6/UDLndeE9MtgoNFXMHRMq1rg0CyLiLFQr8
KvJ1CfT8WRLoHUx1GlVxCCLK+3c7jyRCuuaLSlYRGui9xwv1XUEEpEgFoc9Z+lyP
HaLqSdZjUL539OAnmavI
=ZSaw
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
