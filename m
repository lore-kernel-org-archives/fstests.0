Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:12872 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbbLUILz (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 21 Dec 2015 03:11:55 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1aAvZO-0007kZ-Ht
	for fstests@vger.kernel.org; Mon, 21 Dec 2015 19:11:50 +1100
Date: Mon, 21 Dec 2015 19:11:50 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to b7fd3f0
Message-ID: <20151221081150.GP19802@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

This update contains a lot - there's f2fs support, overlay support,
a heap of new reflink/dedupe tests, stuf to make btrs tests work non
4k blocksize filesystems, and so on. In short: it'll probably break
everything. Happy holidays!

-Dave.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

b7fd3f0 common/punch: handle bmap output for unaligned extents

New Commits:

Brian Foster (2):
      [876161d] xfs: test xfsprogs log formatting infrastructure
      [2274eb5] xfs: verify invalid metadata LSN detection

Chandan Rajendra (13):
      [dedf2c7] filter: Filter xfs_io and od's output in units of FS block =
size
      [b9d31da] btrfs/017: work on non-4k block sized filesystems
      [ea8a0d9] btrfs/055: work on non-4k block sized filesystems
      [603045c] btrfs/056: to work on non-4k block sized filesystems
      [d5cb320] btrfs/096: work on non-4k block sized filesystems
      [3b845a5] filter: filter xfs_io's output in units of page size
      [fec16b9] btrfs/052:  work on non-4k block sized filesystems
      [0b21062] btrfs/094: work on non-4k block sized filesystems
      [5514417] btrfs/095: work on non-4k block sized filesystems
      [b7318fa] btrfs/097: work on non-4k block sized filesystems
      [2099e00] btrfs/098: work on non-4k block sized filesystems
      [e2c432c] btrfs/103: work on non-4k block sized filesystems
      [a9e4022] btrfs/106: work on non-4k page sized machines

Darrick J. Wong (11):
      [2084222] test-scripts: test migration scripts
      [26aad2e] tests: don't leave cruft behind on the TEST_MNT
      [11dd995] generic/15[78]: fix error messages in the golden output
      [e4375bf] xfs/128: allow larger margin for disk space usage
      [e8c1ee1] xfs/129: require loop
      [1b3dc46] reflink: more tests
      [877d1da] reflink: test ENOSPC when expanding btrees during reflink o=
perations
      [c8a13e5] reflink: more CoW tests for reflink and dedupe
      [8ceac6e] reflink: test CoW with blocksize < pagesize
      [2a88596] reflink: test a big CoW operation
      [44f59bd] generic: create a dedupe group

Eric Sandeen (5):
      [84f4814] defrag: loosen input file requirements
      [7317a09] xfs/242: remove open-coded check for "zero" command
      [cd372aa] xfs/293: tighten up checks for documented xfs_io commands
      [27d077e] common: use mount/umount helpers everywhere
      [b7fd3f0] common/punch: handle bmap output for unaligned extents

Eryu Guan (3):
      [ed5d3c7] overlayfs: rudimentary test support
      [55f6116] generic/062: don't create WHITEOUT_DEV
      [6a85506] generic/079: _notrun if fs doesn't support ioctl

Filipe Manana (3):
      [e834156] btrfs: test direct IO write against compressed extent
      [2694697] btrfs/091: fix missing common/reflink include
      [069442d] common: Add more checks to _check_dmesg

Jaegeuk Kim (3):
      [a687688] common: support f2fs for _scratch_mkfs_sized
      [10b00c4] common: add mkfs options for f2fs
      [c61588a] f2fs/001: test for -ENOSPC with inline operation

Jan Kara (3):
      [9420351] common: Factor out function to get OS name
      [254360f] common: Improve _link_output_file to be more versatile
      [2674015] ext4/001: Select different output based on mount options

Jeff Moyer (3):
      [a3d2994] xfs: make sure to _require_attrs when necessary
      [7721b85] generic/042: remove from the 'auto' group
      [7c8afd7] dmflakey: don't run for dax mounts

Xiaoguang Wang (1):
      [f2f13c3] generic/275: add to the 'enospc' group

Zhao Lei (2):
      [aa60a2a] generic/081: Support old version of lvm
      [7a33e85] common: mkfs.btrfs now requires --mixed for small filesyste=
ms

Zorro Lang (2):
      [3235a95] xfs: test project quota name beginning with digits
      [4545386] xfs: test user and group quota names beginning with digits


Code Diffstat:

 README                                             |   1 +
 check                                              |  32 +-
 common/attr                                        |   2 +-
 common/config                                      |  17 +-
 common/defrag                                      |  17 +-
 common/dmflakey                                    |   5 +
 common/dump                                        |   2 +-
 common/filestreams                                 |   2 +-
 common/filter                                      |  53 ++
 common/log                                         |   6 +-
 common/punch                                       |  11 +-
 common/quota                                       |   2 +-
 common/rc                                          | 280 ++++++--
 common/reflink                                     |  30 +
 common/repair                                      |   4 +-
 soak                                               |   6 +-
 tests/btrfs/002                                    |   2 +-
 tests/btrfs/003                                    |  16 +-
 tests/btrfs/004                                    |   6 +-
 tests/btrfs/005                                    |   4 +-
 tests/btrfs/007                                    |   6 +-
 tests/btrfs/011                                    |   6 +-
 tests/btrfs/017                                    |  16 +-
 tests/btrfs/017.out                                |   3 +-
 tests/btrfs/026                                    | 108 +++
 tests/btrfs/026.out                                |  15 +
 tests/btrfs/029                                    |   4 +-
 tests/btrfs/031                                    |   2 +-
 tests/btrfs/052                                    | 122 ++--
 tests/btrfs/052.out                                | 744 ++++++++++++-----=
----
 tests/btrfs/055                                    | 128 ++--
 tests/btrfs/055.out                                | 378 +++++------
 tests/btrfs/056                                    |  51 +-
 tests/btrfs/056.out                                | 152 ++---
 tests/btrfs/091                                    |   1 +
 tests/btrfs/094                                    |  75 ++-
 tests/btrfs/094.out                                |  71 +-
 tests/btrfs/095                                    | 110 +--
 tests/btrfs/095.out                                |  42 +-
 tests/btrfs/096                                    |  45 +-
 tests/btrfs/096.out                                |  15 +-
 tests/btrfs/097                                    |  41 +-
 tests/btrfs/097.out                                |  23 +-
 tests/btrfs/098                                    |  67 +-
 tests/btrfs/098.out                                |  27 +-
 tests/btrfs/103                                    |  44 +-
 tests/btrfs/103.out                                | 132 +++-
 tests/btrfs/106                                    |  36 +-
 tests/btrfs/106.out                                |  30 +-
 tests/btrfs/group                                  |   1 +
 tests/ext4/001                                     |   4 +
 tests/ext4/001.cfg                                 |   2 +
 tests/ext4/{001.out =3D> 001.out.default}            |   0
 tests/ext4/001.out.nozero                          | 333 +++++++++
 tests/ext4/002                                     |   2 +-
 tests/ext4/301                                     |   2 +-
 tests/ext4/302                                     |   2 +-
 tests/ext4/303                                     |   2 +-
 tests/ext4/304                                     |   2 +-
 tests/ext4/305                                     |   4 +-
 tests/f2fs/001                                     |  86 +++
 tests/f2fs/001.out                                 |  21 +
 tests/f2fs/group                                   |   6 +
 tests/generic/014                                  |   2 +-
 tests/generic/015                                  |   2 +-
 tests/generic/018                                  |   4 +-
 tests/generic/018.out                              |   2 +-
 tests/generic/019                                  |   2 +-
 tests/generic/043                                  |   4 +-
 tests/generic/044                                  |   4 +-
 tests/generic/045                                  |   4 +-
 tests/generic/046                                  |   4 +-
 tests/generic/047                                  |   4 +-
 tests/generic/048                                  |   4 +-
 tests/generic/049                                  |   4 +-
 tests/generic/050                                  |   8 +-
 tests/generic/050.out                              |   2 +-
 tests/generic/051                                  |  10 +-
 tests/generic/052                                  |   4 +-
 tests/generic/053                                  |   2 +-
 tests/generic/054                                  |   6 +-
 tests/generic/055                                  |   6 +-
 tests/generic/062                                  |   4 +-
 tests/generic/067                                  |   2 +-
 tests/generic/068                                  |   2 +-
 tests/generic/069                                  |   2 +-
 tests/generic/076                                  |   4 +-
 tests/generic/077                                  |   4 +-
 tests/generic/079                                  |   4 +-
 tests/generic/081                                  |   4 +-
 tests/generic/083                                  |   4 +-
 tests/generic/088                                  |   2 +-
 tests/generic/088.cfg                              |   2 +
 tests/generic/105                                  |   2 +-
 tests/generic/108                                  |   4 +-
 tests/generic/110                                  |   2 +-
 tests/generic/111                                  |   2 +-
 tests/generic/115                                  |   2 +-
 tests/generic/117                                  |   4 +-
 tests/generic/120                                  |   2 +-
 tests/generic/124                                  |   2 +-
 tests/generic/128                                  |   2 +-
 tests/generic/135                                  |   2 +-
 tests/generic/157                                  |  20 +-
 tests/generic/157.out                              |   6 +-
 tests/generic/158                                  |  20 +-
 tests/generic/158.out                              |   8 +-
 tests/generic/159                                  |   2 +-
 tests/generic/160                                  |   2 +-
 tests/generic/166                                  |   2 +-
 tests/generic/167                                  |   2 +-
 tests/generic/169                                  |   4 +-
 tests/generic/178                                  |  77 +++
 tests/generic/178.out                              |   8 +
 tests/generic/179                                  |  96 +++
 tests/generic/179.out                              |  11 +
 tests/generic/180                                  |  96 +++
 tests/generic/180.out                              |  11 +
 tests/generic/181                                  |  80 +++
 tests/generic/181.out                              |   6 +
 tests/generic/182                                  | 117 ++++
 tests/generic/182.out                              |  17 +
 tests/generic/183                                  | 101 +++
 tests/generic/183.out                              |  15 +
 tests/generic/185                                  | 101 +++
 tests/generic/185.out                              |  15 +
 tests/generic/186                                  | 146 ++++
 tests/generic/186.out                              |  15 +
 tests/generic/187                                  | 146 ++++
 tests/generic/187.out                              |  15 +
 tests/generic/188                                  |  96 +++
 tests/generic/188.out                              |  13 +
 tests/generic/189                                  |  96 +++
 tests/generic/189.out                              |  13 +
 tests/generic/190                                  |  96 +++
 tests/generic/190.out                              |  13 +
 tests/generic/191                                  |  96 +++
 tests/generic/191.out                              |  13 +
 tests/generic/192                                  |   2 +-
 tests/generic/194                                  | 101 +++
 tests/generic/194.out                              |  13 +
 tests/generic/195                                  | 101 +++
 tests/generic/195.out                              |  13 +
 tests/generic/196                                  |  96 +++
 tests/generic/196.out                              |  13 +
 tests/generic/197                                  |  96 +++
 tests/generic/197.out                              |  13 +
 tests/generic/199                                  | 125 ++++
 tests/generic/199.out                              |  13 +
 tests/generic/200                                  | 125 ++++
 tests/generic/200.out                              |  13 +
 tests/generic/201                                  |  86 +++
 tests/generic/201.out                              |   9 +
 tests/generic/202                                  |  86 +++
 tests/generic/202.out                              |  13 +
 tests/generic/203                                  |  86 +++
 tests/generic/203.out                              |  13 +
 tests/generic/205                                  | 102 +++
 tests/generic/205.out                              |   7 +
 tests/generic/206                                  | 102 +++
 tests/generic/206.out                              |   7 +
 tests/generic/216                                  | 103 +++
 tests/generic/216.out                              |   7 +
 tests/generic/217                                  | 103 +++
 tests/generic/217.out                              |   7 +
 tests/generic/218                                  |  97 +++
 tests/generic/218.out                              |   7 +
 tests/generic/219                                  |   8 +-
 tests/generic/220                                  |  97 +++
 tests/generic/220.out                              |   7 +
 tests/generic/222                                  | 103 +++
 tests/generic/222.out                              |   7 +
 tests/generic/226                                  |   6 +-
 tests/generic/227                                  | 103 +++
 tests/generic/227.out                              |   7 +
 tests/generic/229                                  | 163 +++++
 tests/generic/229.out                              |  83 +++
 tests/generic/230                                  |   6 +-
 tests/generic/231                                  |  14 +-
 tests/generic/232                                  |   6 +-
 tests/generic/233                                  |   6 +-
 tests/generic/234                                  |   2 +-
 tests/generic/235                                  |   6 +-
 tests/generic/238                                  | 163 +++++
 tests/generic/238.out                              |  83 +++
 tests/generic/242                                  |  99 +++
 tests/generic/242.out                              |  13 +
 tests/generic/243                                  |  99 +++
 tests/generic/243.out                              |  13 +
 tests/generic/256                                  |   2 +-
 tests/generic/258                                  |   2 +-
 tests/generic/269                                  |   2 +-
 tests/generic/274                                  |   2 +-
 tests/generic/275                                  |   2 +-
 tests/generic/280                                  |   4 +-
 tests/generic/299                                  |   2 +-
 tests/generic/300                                  |   2 +-
 tests/generic/317                                  |   8 +-
 tests/generic/318                                  |   8 +-
 tests/generic/group                                |  54 +-
 tests/shared/289                                   |   4 +-
 tests/udf/098                                      |   6 +-
 tests/udf/101                                      |   2 +-
 tests/xfs/004                                      |   4 +-
 tests/xfs/006                                      |   2 +-
 tests/xfs/007                                      |   4 +-
 tests/xfs/009                                      |   2 +-
 tests/xfs/010                                      |   4 +-
 tests/xfs/011                                      |   4 +-
 tests/xfs/013                                      |   4 +-
 tests/xfs/014                                      |   4 +-
 tests/xfs/016                                      |   4 +-
 tests/xfs/017                                      |   4 +-
 tests/xfs/018                                      |   6 +-
 tests/xfs/018.cfg                                  |   2 +
 tests/xfs/019                                      |   6 +-
 tests/xfs/021                                      |   6 +-
 tests/xfs/022                                      |   2 +-
 tests/xfs/022.cfg                                  |   2 +
 tests/xfs/023                                      |   2 +-
 tests/xfs/023.cfg                                  |   2 +
 tests/xfs/030                                      |   6 +-
 tests/xfs/030.cfg                                  |   2 +
 tests/xfs/031                                      |   2 +-
 tests/xfs/031.cfg                                  |   2 +
 tests/xfs/033                                      |  10 +-
 tests/xfs/033.cfg                                  |   3 +
 tests/xfs/{033.crc.out.linux =3D> 033.out.crc.linux} |   0
 tests/xfs/034                                      |   4 +-
 tests/xfs/035                                      |   2 +-
 tests/xfs/035.cfg                                  |   2 +
 tests/xfs/036                                      |   2 +-
 tests/xfs/036.cfg                                  |   2 +
 tests/xfs/039                                      |   2 +-
 tests/xfs/039.cfg                                  |   2 +
 tests/xfs/041                                      |   6 +-
 tests/xfs/042                                      |   4 +-
 tests/xfs/043                                      |   2 +-
 tests/xfs/043.cfg                                  |   2 +
 tests/xfs/044                                      |   2 +-
 tests/xfs/050                                      |   4 +-
 tests/xfs/052                                      |   4 +-
 tests/xfs/054                                      |   6 +-
 tests/xfs/055                                      |   2 +-
 tests/xfs/065                                      |   4 +-
 tests/xfs/071                                      |   2 +-
 tests/xfs/072                                      |   4 +-
 tests/xfs/073                                      |   6 +-
 tests/xfs/076                                      |   2 +-
 tests/xfs/081                                      |   6 +-
 tests/xfs/082                                      |   6 +-
 tests/xfs/082.cfg                                  |   2 +
 tests/xfs/104                                      |   2 +-
 tests/xfs/106                                      |   2 +-
 tests/xfs/108                                      |  10 +-
 tests/xfs/109                                      |   6 +-
 tests/xfs/110                                      |   2 +-
 tests/xfs/111                                      |   6 +-
 tests/xfs/116                                      |  10 +-
 tests/xfs/121                                      |   4 +-
 tests/xfs/128                                      |   2 +-
 tests/xfs/129                                      |   3 +-
 tests/xfs/133                                      | 101 +++
 tests/xfs/133.out                                  |   1 +
 tests/xfs/134                                      |   2 +-
 tests/xfs/135                                      |  71 ++
 tests/xfs/135.out                                  |   6 +
 tests/xfs/136                                      |   6 +-
 tests/xfs/137                                      |  90 +++
 tests/xfs/137.out                                  |   3 +
 tests/xfs/138                                      |  83 +++
 tests/xfs/138.out                                  |   1 +
 tests/xfs/139                                      |  82 +++
 tests/xfs/139.out                                  |   8 +
 tests/xfs/140                                      |  89 +++
 tests/xfs/140.out                                  |   7 +
 tests/xfs/146                                      |   2 +-
 tests/xfs/146.cfg                                  |   2 +
 tests/xfs/148                                      |   4 +-
 tests/xfs/175                                      |   2 +-
 tests/xfs/176                                      |   2 +-
 tests/xfs/177                                      |   4 +-
 tests/xfs/181                                      |   4 +-
 tests/xfs/189                                      |  12 +-
 tests/xfs/196                                      |   2 +-
 tests/xfs/199                                      |   6 +-
 tests/xfs/201                                      |   2 +-
 tests/xfs/220                                      |   6 +-
 tests/xfs/227                                      |   4 +-
 tests/xfs/242                                      |   9 +-
 tests/xfs/244                                      |   4 +-
 tests/xfs/287                                      |   6 +-
 tests/xfs/293                                      |   2 +-
 tests/xfs/295                                      |   2 +
 tests/xfs/299                                      |   6 +-
 tests/xfs/304                                      |   6 +-
 tests/xfs/group                                    |   6 +
 tools/mvtest                                       |  55 ++
 tools/nextid                                       |   1 +
 tools/sort-group                                   | 112 ++++
 300 files changed, 7557 insertions(+), 1393 deletions(-)
 create mode 100644 tests/btrfs/026
 create mode 100644 tests/btrfs/026.out
 create mode 100644 tests/ext4/001.cfg
 rename tests/ext4/{001.out =3D> 001.out.default} (100%)
 create mode 100644 tests/ext4/001.out.nozero
 create mode 100755 tests/f2fs/001
 create mode 100644 tests/f2fs/001.out
 create mode 100644 tests/f2fs/group
 create mode 100644 tests/generic/088.cfg
 create mode 100755 tests/generic/178
 create mode 100644 tests/generic/178.out
 create mode 100755 tests/generic/179
 create mode 100644 tests/generic/179.out
 create mode 100755 tests/generic/180
 create mode 100644 tests/generic/180.out
 create mode 100755 tests/generic/181
 create mode 100644 tests/generic/181.out
 create mode 100755 tests/generic/182
 create mode 100644 tests/generic/182.out
 create mode 100755 tests/generic/183
 create mode 100644 tests/generic/183.out
 create mode 100755 tests/generic/185
 create mode 100644 tests/generic/185.out
 create mode 100755 tests/generic/186
 create mode 100644 tests/generic/186.out
 create mode 100755 tests/generic/187
 create mode 100644 tests/generic/187.out
 create mode 100755 tests/generic/188
 create mode 100644 tests/generic/188.out
 create mode 100755 tests/generic/189
 create mode 100644 tests/generic/189.out
 create mode 100755 tests/generic/190
 create mode 100644 tests/generic/190.out
 create mode 100755 tests/generic/191
 create mode 100644 tests/generic/191.out
 create mode 100755 tests/generic/194
 create mode 100644 tests/generic/194.out
 create mode 100755 tests/generic/195
 create mode 100644 tests/generic/195.out
 create mode 100755 tests/generic/196
 create mode 100644 tests/generic/196.out
 create mode 100755 tests/generic/197
 create mode 100644 tests/generic/197.out
 create mode 100755 tests/generic/199
 create mode 100644 tests/generic/199.out
 create mode 100755 tests/generic/200
 create mode 100644 tests/generic/200.out
 create mode 100755 tests/generic/201
 create mode 100644 tests/generic/201.out
 create mode 100755 tests/generic/202
 create mode 100644 tests/generic/202.out
 create mode 100755 tests/generic/203
 create mode 100644 tests/generic/203.out
 create mode 100755 tests/generic/205
 create mode 100644 tests/generic/205.out
 create mode 100755 tests/generic/206
 create mode 100644 tests/generic/206.out
 create mode 100755 tests/generic/216
 create mode 100644 tests/generic/216.out
 create mode 100755 tests/generic/217
 create mode 100644 tests/generic/217.out
 create mode 100755 tests/generic/218
 create mode 100644 tests/generic/218.out
 create mode 100755 tests/generic/220
 create mode 100644 tests/generic/220.out
 create mode 100755 tests/generic/222
 create mode 100644 tests/generic/222.out
 create mode 100755 tests/generic/227
 create mode 100644 tests/generic/227.out
 create mode 100755 tests/generic/229
 create mode 100644 tests/generic/229.out
 create mode 100755 tests/generic/238
 create mode 100644 tests/generic/238.out
 create mode 100755 tests/generic/242
 create mode 100644 tests/generic/242.out
 create mode 100755 tests/generic/243
 create mode 100644 tests/generic/243.out
 create mode 100644 tests/xfs/018.cfg
 create mode 100644 tests/xfs/022.cfg
 create mode 100644 tests/xfs/023.cfg
 create mode 100644 tests/xfs/030.cfg
 create mode 100644 tests/xfs/031.cfg
 create mode 100644 tests/xfs/033.cfg
 rename tests/xfs/{033.crc.out.linux =3D> 033.out.crc.linux} (100%)
 create mode 100644 tests/xfs/035.cfg
 create mode 100644 tests/xfs/036.cfg
 create mode 100644 tests/xfs/039.cfg
 create mode 100644 tests/xfs/043.cfg
 create mode 100644 tests/xfs/082.cfg
 create mode 100755 tests/xfs/133
 create mode 100644 tests/xfs/133.out
 create mode 100755 tests/xfs/135
 create mode 100644 tests/xfs/135.out
 create mode 100755 tests/xfs/137
 create mode 100644 tests/xfs/137.out
 create mode 100755 tests/xfs/138
 create mode 100644 tests/xfs/138.out
 create mode 100644 tests/xfs/139
 create mode 100644 tests/xfs/139.out
 create mode 100644 tests/xfs/140
 create mode 100644 tests/xfs/140.out
 create mode 100644 tests/xfs/146.cfg
 create mode 100755 tools/mvtest
 create mode 120000 tools/nextid
 create mode 100755 tools/sort-group
--=20
Dave Chinner
david@fromorbit.com

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJWd7RGAAoJEK3oKUf0dfodeBMP/A82UATZqi5HBs79jcwpnucK
RMEI0ZxZD3U5zTOoe0fC791APeJMzK80dv62laTjsYmQo4NXfjluigUG1pCRaojt
Rs6YrdBa4ebO5n3c7EtqkEVloBl/ruAL3GekkFQEwFO89VxfX0BHQOdY1ZZb6F37
W5hUNrQV0lCZpIBtfe69MKc0A2ZurhQn2Fi6nqxw+O5m1cuxcURSxVMwzachVAeQ
iQxZ41fidxxsPQib74GIV50cA6edhGuqpZACdQqx3lC4DLLaZaaw0rVDXbCI7u8l
h9aFcz6mnUCjnqYm4am07GRHTMYnhLvINGM/vOH8/yji4+uUjX/5tgG2ys1OD49w
G5+04fB544Kj+fxVO98xxJUYXm38iZlQJUNvADAqwXTnue1MefzA1MiGu7GEoRRi
Oqx2O9Vdc/3IhjaY+7cIzY66w6hvJHITBEn1TFZm7U5oWIXgYvYafekPwrFA0YR0
J90MwKhVU5SLXt9rLc9tK3+BA5fqydz7rjl/6McNrfGv8mmlsGYtfp5GSDIXlZ4G
ZzFY9Z3KyqY/wyVwGYt2FFRkjn3F2z174jURjSJpQBleveQ3QNKZYYFOO41RCG+R
H2sB9nCQDjcCkQBsgalLuXMd3FgkLP52cpwSuCqrROLbDC+5EYeJFJrmWNEAP2l5
mZxJ+e+znwD3m4j1gKA+
=PsPH
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
