Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:1086 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753147AbaHMCZi (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 12 Aug 2014 22:25:38 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1XHOFN-00033n-96
	for fstests@vger.kernel.org; Wed, 13 Aug 2014 12:25:05 +1000
Date: Wed, 13 Aug 2014 12:25:05 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to f7d0a30
Message-ID: <20140813022505.GN26465@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.

The new head of the master branch is commit:

f7d0a30 generic/225: Require fiemap support

New Commits:

Anand Jain (2):
      [ffd3c2b] common: _devmgt_add() to check if the device is back online
      [6bcae5c] btrfs: check for matching kernel send stream

Dmitry Monakhov (3):
      [2f87a77] defrag: add options to _defrag helper
      [5eedd36] generic: add new defragment test
      [677d7e1] ext4: add new compacting defragmentation test

Eric Sandeen (1):
      [ddd55d5] xfs/291: use xfs_repair -f when repairing a fs image

Eryu Guan (3):
      [36e1af6] xfs: test inode allocations in post-growfs disk space
      [0750068] shared/006: use _get_free_inode helper
      [31da012] xfs: test strided xfs_repair on large filesystems

Filipe Manana (1):
      [e454903] btrfs: add regression test for btrfs send with orphans

Jan Kara (1):
      [f7d0a30] generic/225: Require fiemap support

Jeff Moyer (1):
      [73bea92] aio: test closing the fd before destroying the ioctx

Jie Liu (1):
      [b8cac56] xfs/007: add project quota Q_XQUOTARM test

Lukas Czerner (2):
      [ab1d756] common: Check the file system consistency on SCRATCH_DEV
      [83ef157] common: Check fs consistency on TEST_DEV only when needed

Theodore Ts'o (4):
      [1202207] config: allow chacl to be in any directory in $PATH
      [2345aae] build: Fix test for libgdbm_compat when building statically
      [c4a6eb0] generic/077: fall back to /usr if /lib/modules doesn't exist
      [2e0960f] common: allow dmflakey tests to work without udev

Wang Shilong (1):
      [736a5b0] btrfs: add qgroup rescan stress test

Xiaoguang Wang (1):
      [313db9f] ext4: regression test for wrong assert in ext4_mb_normalize_request()

Xing Gu (2):
      [8a19bf2] xfs/292: fix format of expected message
      [d8cee80] xfs/300: redirect mkfs output to results/xfs directory


Code Diffstat:

 check                                         |    5 +-
 common/attr                                   |    4 +-
 common/config                                 |    1 +
 common/defrag                                 |  101 +-
 common/dmflakey                               |    2 +
 common/rc                                     |  152 +-
 m4/package_gdbmdev.m4                         |   10 +-
 new                                           |    1 +
 src/Makefile                                  |    2 +-
 src/aio-dio-regress/aio-last-ref-held-by-io.c |  239 +++
 src/e4compact.c                               |  206 ++
 tests/btrfs/008                               |    1 +
 tests/btrfs/016                               |    1 +
 tests/btrfs/019                               |    1 +
 tests/btrfs/020                               |    1 +
 tests/btrfs/024                               |    1 -
 tests/btrfs/026                               |    1 +
 tests/btrfs/027                               |    1 +
 tests/btrfs/028                               |    1 +
 tests/btrfs/029                               |    1 +
 tests/btrfs/031                               |    1 +
 tests/btrfs/041                               |    1 +
 tests/btrfs/043                               |    2 -
 tests/btrfs/044                               |    2 -
 tests/btrfs/045                               |    2 -
 tests/btrfs/046                               |    3 +-
 tests/btrfs/047                               |    3 +-
 tests/btrfs/048                               |    3 +-
 tests/btrfs/050                               |    3 +-
 tests/btrfs/051                               |    3 +-
 tests/btrfs/053                               |    3 +-
 tests/btrfs/054                               |    3 +-
 tests/btrfs/057                               |   81 +
 tests/btrfs/057.out                           |    3 +
 tests/btrfs/058                               |   84 +
 tests/btrfs/058.out                           |    1 +
 tests/btrfs/group                             |    2 +
 tests/ext4/001                                |    1 +
 tests/ext4/002                                |    1 +
 tests/ext4/003                                |   54 +
 tests/ext4/003.out                            |    3 +
 tests/ext4/271                                |    3 +-
 tests/ext4/301                                |    3 +-
 tests/ext4/302                                |    3 +-
 tests/ext4/303                                |    3 +-
 tests/ext4/304                                |    3 +-
 tests/ext4/307                                |   73 +
 tests/ext4/307.out                            |    6 +
 tests/ext4/group                              |    2 +
 tests/generic/001                             |    1 +
 tests/generic/002                             |    1 +
 tests/generic/004                             |    1 +
 tests/generic/005                             |    1 +
 tests/generic/006                             |    1 +
 tests/generic/007                             |    1 +
 tests/generic/008                             |    1 +
 tests/generic/009                             |    1 +
 tests/generic/010                             |    1 +
 tests/generic/011                             |    1 +
 tests/generic/012                             |    1 +
 tests/generic/013                             |    1 +
 tests/generic/014                             |    1 +
 tests/generic/016                             |    1 +
 tests/generic/018                             |   12 +-
 tests/generic/019                             |    1 -
 tests/generic/020                             |    1 +
 tests/generic/021                             |    1 +
 tests/generic/022                             |    1 +
 tests/generic/023                             |    1 +
 tests/generic/024                             |    1 +
 tests/generic/025                             |    1 +
 tests/generic/026                             |    1 +
 tests/generic/027                             |    1 -
 tests/generic/028                             |    1 +
 tests/generic/068                             |    2 -
 tests/generic/070                             |    1 +
 tests/generic/074                             |    1 +
 tests/generic/075                             |    1 +
 tests/generic/076                             |    1 -
 tests/generic/077                             |    3 +
 tests/generic/083                             |    1 -
 tests/generic/088                             |    1 +
 tests/generic/089                             |    1 +
 tests/generic/091                             |    1 +
 tests/generic/093                             |    1 +
 tests/generic/097                             |    8 +-
 tests/generic/099                             |    8 +-
 tests/generic/100                             |    2 +-
 tests/generic/112                             |    1 +
 tests/generic/113                             |    1 +
 tests/generic/117                             |    2 -
 tests/generic/123                             |    1 +
 tests/generic/124                             |    4 +-
 tests/generic/125                             |    1 +
 tests/generic/126                             |    1 +
 tests/generic/127                             |    1 +
 tests/generic/131                             |    1 +
 tests/generic/133                             |    1 +
 tests/generic/184                             |    1 +
 tests/generic/192                             |    1 +
 tests/generic/193                             |    1 +
 tests/generic/198                             |    1 +
 tests/generic/204                             |    2 -
 tests/generic/207                             |    1 +
 tests/generic/208                             |    1 +
 tests/generic/209                             |    1 +
 tests/generic/210                             |    1 +
 tests/generic/211                             |    1 +
 tests/generic/212                             |    1 +
 tests/generic/213                             |    1 +
 tests/generic/214                             |    1 +
 tests/generic/215                             |    1 +
 tests/generic/221                             |    1 +
 tests/generic/225                             |    1 +
 tests/generic/228                             |    1 +
 tests/generic/236                             |    1 +
 tests/generic/237                             |    1 +
 tests/generic/239                             |    1 +
 tests/generic/240                             |    1 +
 tests/generic/241                             |    1 +
 tests/generic/245                             |    1 +
 tests/generic/246                             |    1 +
 tests/generic/247                             |    1 +
 tests/generic/248                             |    1 +
 tests/generic/249                             |    1 +
 tests/generic/255                             |    1 +
 tests/generic/256                             |    1 +
 tests/generic/257                             |    1 +
 tests/generic/258                             |    1 +
 tests/generic/263                             |    1 +
 tests/generic/269                             |    3 +-
 tests/generic/270                             |    3 +-
 tests/generic/273                             |    3 +-
 tests/generic/285                             |    1 +
 tests/generic/286                             |    1 +
 tests/generic/299                             |    3 +-
 tests/generic/300                             |    3 +-
 tests/generic/306                             |    1 +
 tests/generic/308                             |    1 +
 tests/generic/309                             |    1 +
 tests/generic/310                             |    1 +
 tests/generic/312                             |    1 -
 tests/generic/313                             |    1 +
 tests/generic/314                             |    1 +
 tests/generic/315                             |    1 +
 tests/generic/316                             |    1 +
 tests/generic/320                             |    1 -
 tests/generic/321                             |    2 -
 tests/generic/322                             |    2 -
 tests/generic/323                             |   68 +
 tests/generic/323.out                         |   11 +
 tests/generic/324                             |   81 +
 tests/generic/324.out                         | 2530 +++++++++++++++++++++++++
 tests/generic/group                           |    2 +
 tests/shared/006                              |    3 +-
 tests/shared/051                              |    1 +
 tests/shared/272                              |    3 +-
 tests/shared/298                              |    1 +
 tests/xfs/003                                 |    1 +
 tests/xfs/007                                 |   24 +
 tests/xfs/007.out                             |    9 +
 tests/xfs/008                                 |    1 +
 tests/xfs/010                                 |    1 -
 tests/xfs/011                                 |    1 -
 tests/xfs/012                                 |    1 +
 tests/xfs/013                                 |    1 -
 tests/xfs/014                                 |    1 -
 tests/xfs/015                                 |  105 +
 tests/xfs/015.out                             |    2 +
 tests/xfs/019                                 |    3 -
 tests/xfs/019.out                             |    1 -
 tests/xfs/020                                 |   58 +
 tests/xfs/020.out                             |    2 +
 tests/xfs/034                                 |    2 -
 tests/xfs/042                                 |    1 -
 tests/xfs/042.out                             |    1 -
 tests/xfs/045                                 |    1 +
 tests/xfs/048                                 |    1 +
 tests/xfs/066                                 |    1 +
 tests/xfs/073                                 |    1 +
 tests/xfs/078                                 |    1 +
 tests/xfs/080                                 |    1 +
 tests/xfs/084                                 |    1 +
 tests/xfs/085                                 |    6 -
 tests/xfs/085.out                             |    1 -
 tests/xfs/104                                 |    1 -
 tests/xfs/110                                 |    2 -
 tests/xfs/121                                 |    3 -
 tests/xfs/134                                 |    1 +
 tests/xfs/164                                 |    1 +
 tests/xfs/165                                 |    1 +
 tests/xfs/181                                 |    3 -
 tests/xfs/195                                 |    1 +
 tests/xfs/197                                 |    1 +
 tests/xfs/206                                 |    1 +
 tests/xfs/222                                 |    1 +
 tests/xfs/229                                 |    1 +
 tests/xfs/242                                 |    1 +
 tests/xfs/250                                 |    1 +
 tests/xfs/252                                 |    1 +
 tests/xfs/253                                 |    1 +
 tests/xfs/259                                 |    1 +
 tests/xfs/278                                 |    5 -
 tests/xfs/290                                 |    1 +
 tests/xfs/291                                 |    2 +-
 tests/xfs/292                                 |   10 +-
 tests/xfs/292.out                             |   10 +-
 tests/xfs/297                                 |    1 -
 tests/xfs/300                                 |    2 +-
 tests/xfs/306                                 |    1 -
 tests/xfs/group                               |    2 +
 211 files changed, 4073 insertions(+), 145 deletions(-)
 create mode 100644 src/aio-dio-regress/aio-last-ref-held-by-io.c
 create mode 100644 src/e4compact.c
 create mode 100644 tests/btrfs/057
 create mode 100644 tests/btrfs/057.out
 create mode 100644 tests/btrfs/058
 create mode 100644 tests/btrfs/058.out
 create mode 100755 tests/ext4/003
 create mode 100644 tests/ext4/003.out
 create mode 100755 tests/ext4/307
 create mode 100644 tests/ext4/307.out
 mode change 100644 => 100755 tests/generic/009
 mode change 100644 => 100755 tests/generic/026
 mode change 100644 => 100755 tests/generic/315
 mode change 100644 => 100755 tests/generic/321
 mode change 100644 => 100755 tests/generic/322
 create mode 100644 tests/generic/323
 create mode 100644 tests/generic/323.out
 create mode 100644 tests/generic/324
 create mode 100644 tests/generic/324.out
 create mode 100755 tests/xfs/015
 create mode 100644 tests/xfs/015.out
 create mode 100755 tests/xfs/020
 create mode 100644 tests/xfs/020.out
-- 
Dave Chinner
david@fromorbit.com
