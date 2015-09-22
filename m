Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:58323 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932753AbbIVBV4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2015 21:21:56 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1ZeCHJ-00077Q-2x
	for fstests@vger.kernel.org; Tue, 22 Sep 2015 11:21:53 +1000
Date: Tue, 22 Sep 2015 11:21:53 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to ed731fe
Message-ID: <20150922012153.GZ3902@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I3tAPq1Rm2pUxvsp"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--I3tAPq1Rm2pUxvsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
	git://oss.sgi.com/xfs/cmds/xfstests

have just been updated.

Notably, I have committed Darrick's ext4 and xfs fuzzing patches.
They won't do anything yet on xfs, as the xfsprogs support isn't
there yet (will be in a couple of days). If you want to run it on
ext4, run the fuzzers group - it should at least run the tests, but
no guarantees on how many broken bits you end up with. :P

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

ed731fe generic/014: Fix wrong return value in output

New Commits:

Anand Jain (3):
      [e3a43a8] dm-error: add functions to create dm-error device
      [6a4f7e0] btrfs: test device replace, with EIO on the src dev
      [7dc0112] btrfs: test device delete with EIO on src dev

Ari Sundholm (2):
      [dbbaa6d] compat: use stat -c instead of stat --format
      [d3046b5] generic/067: Add a missing symlinks requirement

Darrick J. Wong (7):
      [6b56308] common: add routines to fuzz filesystems
      [bf16cde] fuzz: randomly fuzz XFS and ext4 filesystems
      [e953517] ext4: test block group metadata corruption checking and rep=
air
      [fc4dd61] ext4: test file/dir/symlink metadata corruption checking an=
d repair
      [d492bcd] xfs: test allocation group metadata corruption checking and=
 repair
      [c8e6dbc] xfs: test directory metadata corruption checking and repair
      [fd6df1f] xfs: test file/symlink metadata corruption checking and rep=
air

Dave Chinner (3):
      [c9b9d5f] generic/038: speed up file creation
      [86c1b55] xfs/042: reduce runtime of the test
      [3038de2] xfs/199: fix breakage every time mkfs defaults change.

Eric Sandeen (1):
      [c0fbe33] xfs/077: fix test for userspace meta_uuid support

Eric Whitney (1):
      [4fbcbdf] generic/064: allow room for unexpected allocation behavior

Eryu Guan (6):
      [e1efba7] ext4/005: add missing out file back
      [f610380] xfs/074: specify filesystem size in terms of size not block=
 count
      [6c5493b] ext4/305: reduce runtime by limiting mount/umount cycles
      [d7ae613] generic: test partial block device failure
      [80b4861] src/t_truncate_cmtime: test truncate up too
      [6714b6f] xfs/167: remove duplicated _require_fs_space

Filipe Manana (4):
      [1bea79d] generic: fsync files with multiple links
      [83288d5] btrfs: fsync after extent cloning
      [da82741] btrfs: ENOSPC test for a btrfs
      [694db0c] btrfs: read corruption of compressed extents

Jan Kara (1):
      [ed2732f] fstests: Add test of rename

Qu Wenruo (2):
      [ccdcf12] new: Add seqres.full cleanup to template
      [04188a6] fstests: btrfs: Add reserved space leak check for rewrite d=
irty page

Zhao Lei (2):
      [4861383] _filter_uuid: Fix output regression for btrfs/006
      [ed731fe] generic/014: Fix wrong return value in output

Zorro Lang (4):
      [1d29577] generic/084: use src/multi_open_unlink to replace tail comm=
and
      [505ca93] xfs: use -f option for xfs_repair a fs image
      [4039096] xfs/201: use min_dio_alignment size to replace 512b
      [e5aa688] xfs/194: fix the exception when run on 4k sector drives


Code Diffstat:

 common/dmerror          |  79 +++++++
 common/filter           |   2 +-
 common/populate         | 546 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 common/rc               |  56 ++++-
 new                     |   3 +
 src/t_truncate_cmtime.c |  43 +++-
 tests/btrfs/098         | 123 +++++++++++
 tests/btrfs/098.out     |   7 +
 tests/btrfs/099         |  88 ++++++++
 tests/btrfs/099.out     |  13 ++
 tests/btrfs/100         |  81 +++++++
 tests/btrfs/100.out     |  11 +
 tests/btrfs/101         |  82 ++++++++
 tests/btrfs/101.out     |  11 +
 tests/btrfs/102         |  82 ++++++++
 tests/btrfs/102.out     |   2 +
 tests/btrfs/103         | 109 ++++++++++
 tests/btrfs/103.out     |  41 ++++
 tests/btrfs/group       |   6 +
 tests/ext4/005.out      |   2 +
 tests/ext4/006          | 161 ++++++++++++++
 tests/ext4/006.out      |   3 +
 tests/ext4/007          | 122 +++++++++++
 tests/ext4/007.out      |  13 ++
 tests/ext4/008          | 103 +++++++++
 tests/ext4/008.out      |  10 +
 tests/ext4/009          | 113 ++++++++++
 tests/ext4/009.out      |  12 ++
 tests/ext4/010          | 102 +++++++++
 tests/ext4/010.out      |  12 ++
 tests/ext4/011          |  88 ++++++++
 tests/ext4/011.out      |  10 +
 tests/ext4/012          |  87 ++++++++
 tests/ext4/012.out      |  10 +
 tests/ext4/013          | 126 +++++++++++
 tests/ext4/013.out      |  15 ++
 tests/ext4/014          | 124 +++++++++++
 tests/ext4/014.out      |  15 ++
 tests/ext4/015          | 103 +++++++++
 tests/ext4/015.out      |  12 ++
 tests/ext4/016          |  96 +++++++++
 tests/ext4/016.out      |  12 ++
 tests/ext4/017          |  99 +++++++++
 tests/ext4/017.out      |  12 ++
 tests/ext4/018          |  97 +++++++++
 tests/ext4/018.out      |  12 ++
 tests/ext4/019          |  95 +++++++++
 tests/ext4/019.out      |  11 +
 tests/ext4/305          |  19 +-
 tests/ext4/group        |  14 ++
 tests/generic/014       |  11 +-
 tests/generic/038       |  26 ++-
 tests/generic/040       |   4 +-
 tests/generic/041       |   2 +-
 tests/generic/064       |  16 +-
 tests/generic/064.out   |   2 +-
 tests/generic/067       |   1 +
 tests/generic/084       |  15 +-
 tests/generic/104       |   4 +-
 tests/generic/107       |  99 +++++++++
 tests/generic/107.out   |   3 +
 tests/generic/108       |  98 +++++++++
 tests/generic/108.out   |   2 +
 tests/generic/109       |  96 +++++++++
 tests/generic/109.out   |   2 +
 tests/generic/group     |   3 +
 tests/xfs/020           |   2 +-
 tests/xfs/032           |   2 +-
 tests/xfs/042           |  58 ++---
 tests/xfs/042.out       |   2 +-
 tests/xfs/074           |   2 +-
 tests/xfs/077.out       |   2 +-
 tests/xfs/083           | 174 +++++++++++++++
 tests/xfs/083.out       |   3 +
 tests/xfs/085           | 115 ++++++++++
 tests/xfs/085.out       |  15 ++
 tests/xfs/086           | 147 +++++++++++++
 tests/xfs/086.out       |  20 ++
 tests/xfs/087           | 124 +++++++++++
 tests/xfs/087.out       |  15 ++
 tests/xfs/088           | 146 +++++++++++++
 tests/xfs/088.out       |  20 ++
 tests/xfs/089           | 147 +++++++++++++
 tests/xfs/089.out       |  20 ++
 tests/xfs/091           | 147 +++++++++++++
 tests/xfs/091.out       |  20 ++
 tests/xfs/093           | 124 +++++++++++
 tests/xfs/093.out       |  15 ++
 tests/xfs/097           | 127 +++++++++++
 tests/xfs/097.out       |  15 ++
 tests/xfs/098           | 118 +++++++++++
 tests/xfs/098.out       |  14 ++
 tests/xfs/099           | 111 ++++++++++
 tests/xfs/099.out       |  14 ++
 tests/xfs/100           | 116 ++++++++++
 tests/xfs/100.out       |  14 ++
 tests/xfs/101           | 111 ++++++++++
 tests/xfs/101.out       |  14 ++
 tests/xfs/102           | 116 ++++++++++
 tests/xfs/102.out       |  14 ++
 tests/xfs/105           | 116 ++++++++++
 tests/xfs/105.out       |  14 ++
 tests/xfs/112           | 120 +++++++++++
 tests/xfs/112.out       |  14 ++
 tests/xfs/113           | 116 ++++++++++
 tests/xfs/113.out       |  14 ++
 tests/xfs/117           | 132 ++++++++++++
 tests/xfs/117.out       |  15 ++
 tests/xfs/120           | 111 ++++++++++
 tests/xfs/120.out       |  13 ++
 tests/xfs/123           |  96 +++++++++
 tests/xfs/123.out       |  11 +
 tests/xfs/124           | 114 ++++++++++
 tests/xfs/124.out       |  14 ++
 tests/xfs/125           | 114 ++++++++++
 tests/xfs/125.out       |  14 ++
 tests/xfs/126           | 118 +++++++++++
 tests/xfs/126.out       |  14 ++
 tests/xfs/167           |   6 -
 tests/xfs/194           |   7 +-
 tests/xfs/199           |  32 +--
 tests/xfs/199.out       |   7 -
 tests/xfs/201           |  20 +-
 tests/xfs/group         |  23 ++
 124 files changed, 6702 insertions(+), 136 deletions(-)
 create mode 100644 common/dmerror
 create mode 100644 common/populate
 create mode 100755 tests/btrfs/098
 create mode 100644 tests/btrfs/098.out
 create mode 100755 tests/btrfs/099
 create mode 100644 tests/btrfs/099.out
 create mode 100755 tests/btrfs/100
 create mode 100644 tests/btrfs/100.out
 create mode 100755 tests/btrfs/101
 create mode 100644 tests/btrfs/101.out
 create mode 100755 tests/btrfs/102
 create mode 100644 tests/btrfs/102.out
 create mode 100755 tests/btrfs/103
 create mode 100644 tests/btrfs/103.out
 create mode 100644 tests/ext4/005.out
 create mode 100755 tests/ext4/006
 create mode 100644 tests/ext4/006.out
 create mode 100755 tests/ext4/007
 create mode 100644 tests/ext4/007.out
 create mode 100755 tests/ext4/008
 create mode 100644 tests/ext4/008.out
 create mode 100755 tests/ext4/009
 create mode 100644 tests/ext4/009.out
 create mode 100755 tests/ext4/010
 create mode 100644 tests/ext4/010.out
 create mode 100755 tests/ext4/011
 create mode 100644 tests/ext4/011.out
 create mode 100755 tests/ext4/012
 create mode 100644 tests/ext4/012.out
 create mode 100755 tests/ext4/013
 create mode 100644 tests/ext4/013.out
 create mode 100755 tests/ext4/014
 create mode 100644 tests/ext4/014.out
 create mode 100755 tests/ext4/015
 create mode 100644 tests/ext4/015.out
 create mode 100755 tests/ext4/016
 create mode 100644 tests/ext4/016.out
 create mode 100755 tests/ext4/017
 create mode 100644 tests/ext4/017.out
 create mode 100755 tests/ext4/018
 create mode 100644 tests/ext4/018.out
 create mode 100755 tests/ext4/019
 create mode 100644 tests/ext4/019.out
 mode change 100644 =3D> 100755 tests/generic/064
 create mode 100755 tests/generic/107
 create mode 100644 tests/generic/107.out
 create mode 100755 tests/generic/108
 create mode 100644 tests/generic/108.out
 create mode 100755 tests/generic/109
 create mode 100644 tests/generic/109.out
 create mode 100755 tests/xfs/083
 create mode 100644 tests/xfs/083.out
 create mode 100755 tests/xfs/085
 create mode 100644 tests/xfs/085.out
 create mode 100755 tests/xfs/086
 create mode 100644 tests/xfs/086.out
 create mode 100755 tests/xfs/087
 create mode 100644 tests/xfs/087.out
 create mode 100755 tests/xfs/088
 create mode 100644 tests/xfs/088.out
 create mode 100755 tests/xfs/089
 create mode 100644 tests/xfs/089.out
 create mode 100755 tests/xfs/091
 create mode 100644 tests/xfs/091.out
 create mode 100755 tests/xfs/093
 create mode 100644 tests/xfs/093.out
 create mode 100755 tests/xfs/097
 create mode 100644 tests/xfs/097.out
 create mode 100755 tests/xfs/098
 create mode 100644 tests/xfs/098.out
 create mode 100755 tests/xfs/099
 create mode 100644 tests/xfs/099.out
 create mode 100755 tests/xfs/100
 create mode 100644 tests/xfs/100.out
 create mode 100755 tests/xfs/101
 create mode 100644 tests/xfs/101.out
 create mode 100755 tests/xfs/102
 create mode 100644 tests/xfs/102.out
 create mode 100755 tests/xfs/105
 create mode 100644 tests/xfs/105.out
 create mode 100755 tests/xfs/112
 create mode 100644 tests/xfs/112.out
 create mode 100755 tests/xfs/113
 create mode 100644 tests/xfs/113.out
 create mode 100755 tests/xfs/117
 create mode 100644 tests/xfs/117.out
 create mode 100755 tests/xfs/120
 create mode 100644 tests/xfs/120.out
 create mode 100755 tests/xfs/123
 create mode 100644 tests/xfs/123.out
 create mode 100755 tests/xfs/124
 create mode 100644 tests/xfs/124.out
 create mode 100755 tests/xfs/125
 create mode 100644 tests/xfs/125.out
 create mode 100755 tests/xfs/126
 create mode 100644 tests/xfs/126.out
--=20
Dave Chinner
david@fromorbit.com

--I3tAPq1Rm2pUxvsp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJWAK0wAAoJEK3oKUf0dfoduCcP/1USUXuLBX/I0rTVmBYYNghW
Q/2n5tcD2BnbAY4Dv2CWHupU10az4WnGn7g1VHbckwcshsocR6Twfe3DB9tHeetL
lVgqR5112VuK1lAZUD9KzUGeWPiGKCpTBPQ6V1ACmOO6aUR9ezbZMUpaOSIYTj7e
XMA7ba9pkzhNyo6YErxcL+8L0RjKQbboQoOfxNQ97QpmTpiZVbp3PaLUexGL5gph
uuc8deNW/FhJENvWPRnj3nkCmn5CD9bbU01HtybCgtUXKxchAHTVZCZdBCxxk8x/
BYR8gNruwIqHhj2c+ECPdq7ObMl6OY0pkG4UMud/ElEp/V+JmXMdSzrUvxBSSYIy
TvA+W2UVpRrTNRSOrRneHezRSbYw9cdRDzp+QImXez5cB73PlZJVPpDIUqFQNAYR
cIrgoLj00tDJYSWRO/JsaS1OvmA/TMpF+GaxVIVRBAiXqAeA5p/7YW3MrrFD2fyu
KMgBnUnLNRze6m/eckJXUaPxVSO8ZFz15aJyPIkhEntG1e1DQv0JRNjJocW68+dI
Og49yCRZd/BZyb7CNFIOnER/kGUgj7TZhUgUYYSBQFRlAlgBonltS/C2+P8IDYbi
GPa8tR8tkY8YoNSSUEJuJSo8akf/TG6TOsb9wJxd7J0NiFaz/HWqnFs4Y9B/dDNf
1GD5SnURwu/+GZ0s4RUS
=V3TM
-----END PGP SIGNATURE-----

--I3tAPq1Rm2pUxvsp--
