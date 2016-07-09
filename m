Received: from mx1.redhat.com ([209.132.183.28]:42342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbcGIG7o (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 9 Jul 2016 02:59:44 -0400
Message-Id: <201607090659.u696xgKq027545@int-mx11.intmail.prod.int.phx2.redhat.com>
Date: Sat, 09 Jul 2016 14:59:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-07-09
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? Notably, it
contains the richacl tests from Andreas Gruenbacher, and new reflink tests &
fixes from Darrick J. Wong.

This pull request contains updates in last two weeks, since my last pull
request (on 2016-07-02) was not pushed to upstream.

Thanks,
Eryu

The following changes since commit 54774d4bb5f8b5756913034cf9fdd28ba5bee03c:

  ext4/271: _notrun if there are journal related mount options (2016-06-24 12:54:04 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 024bdaea1c5741d37bf62b0fcb5a581ede5a5682:

  ext4/021: add _require_metadata_journaling (2016-07-08 10:51:54 +0800)

----------------------------------------------------------------

fstests: update on 2016-07-09

This update contains:
o New richacl tests
o New reflink tests and fixes
o dm-delay support
o New tests for xfs, btrfs and overlay
o Other bug fixes and enhancements

----------------------------------------------------------------
Anand Jain (6):
      btrfs: add functions to set and reset required number of SCRATCH_DEV_POOL
      btrfs: add functions to get and put a device for replace target
      btrfs/027: make use of new device get and put helper functions
      btrfs: add helper function to check if btrfs is module
      btrfs: test RAID1 device reappear and balance
      btrfs: test RAID5 device reappear and balance

Andreas Gruenbacher (2):
      fstests: Add / use _require_runas and _runas
      generic: Add richacl tests

Brian Foster (2):
      common: support dm-delay to introduce I/O delays
      xfs: test for post umount readahead completion panic

Christoph Hellwig (1):
      generic/042: remove from quick group

Darrick J. Wong (7):
      xfs/122: fix test output to reflect latest xfsprogs
      xfs/235: fix logic errors when checking rmap usage after failures
      xfs/229: require 3GB of space
      generic/204: increase log size for rmap/reflink
      xfs/128: use $XFS_FSR_PROG instead of xfs_fsr directly
      xfs: inject errors at various parts of the deferred op completion
      xfs: test clearing reflink inode flag

Eric Whitney (1):
      ext4/021: add _require_metadata_journaling

Eryu Guan (2):
      overlay: dentry leak for default_permissions mount option
      overlay: remove dir which contains whiteout from lower dir

Jeff Mahoney (1):
      btrfs/048: extend _filter_btrfs_prop_error to handle additional errors

Omer Zilberberg (1):
      generic/294: filter quotes from mknod

Qu Wenruo (1):
      btrfs: EDQUOTA leaks reserved data space

Theodore Ts'o (3):
      common/rc: ext4 doesn't support O_DIRECT with encryption
      generic/082: rename _filter_project_quota to a avoid function name conflict
      quota: fix generic/244 on 32-bit platforms

Zorro Lang (2):
      common/dmerror: fix nonsensical arguments handling
      xfs: configurable behavior on errors at unmount time

 common/config         |   2 +
 common/dmdelay        |  90 ++++++++++++++++
 common/dmerror        |  14 ++-
 common/filter         |   7 ++
 common/filter.btrfs   |  10 +-
 common/inject         |  93 ++++++++++++++++
 common/log            |  28 +++++
 common/rc             | 289 ++++++++++++++++++++++++++++++++++++++++++++++++--
 src/test-nextquota.c  |   7 +-
 tests/btrfs/027       |  24 +++--
 tests/btrfs/048       |   6 +-
 tests/btrfs/048.out   |   4 +-
 tests/btrfs/124       | 166 +++++++++++++++++++++++++++++
 tests/btrfs/124.out   |   7 ++
 tests/btrfs/125       | 182 +++++++++++++++++++++++++++++++
 tests/btrfs/125.out   |   7 ++
 tests/btrfs/126       |  73 +++++++++++++
 tests/btrfs/126.out   |   2 +
 tests/btrfs/group     |   3 +
 tests/ext4/021        |   1 +
 tests/generic/082     |   6 +-
 tests/generic/093     |  14 ++-
 tests/generic/099     |  45 ++++----
 tests/generic/204     |   6 +-
 tests/generic/237     |   6 +-
 tests/generic/294     |   2 +-
 tests/generic/294.out |   2 +-
 tests/generic/362     | 125 ++++++++++++++++++++++
 tests/generic/362.out |  94 ++++++++++++++++
 tests/generic/363     | 118 +++++++++++++++++++++
 tests/generic/363.out | 139 ++++++++++++++++++++++++
 tests/generic/364     |  98 +++++++++++++++++
 tests/generic/364.out |  39 +++++++
 tests/generic/365     |  93 ++++++++++++++++
 tests/generic/365.out |   9 ++
 tests/generic/366     |  86 +++++++++++++++
 tests/generic/366.out |  11 ++
 tests/generic/367     |  85 +++++++++++++++
 tests/generic/367.out |  11 ++
 tests/generic/368     |  85 +++++++++++++++
 tests/generic/368.out |   7 ++
 tests/generic/369     | 126 ++++++++++++++++++++++
 tests/generic/369.out |  24 +++++
 tests/generic/370     |  90 ++++++++++++++++
 tests/generic/370.out |  19 ++++
 tests/generic/group   |  11 +-
 tests/overlay/009     |  68 ++++++++++++
 tests/overlay/009.out |   2 +
 tests/overlay/010     |  78 ++++++++++++++
 tests/overlay/010.out |   2 +
 tests/overlay/group   |   2 +
 tests/shared/051      |  48 ++++-----
 tests/xfs/006         | 116 ++++++++++++++++++++
 tests/xfs/006.out     |   7 ++
 tests/xfs/122.out     |   4 +-
 tests/xfs/128         |   8 +-
 tests/xfs/229         |   1 +
 tests/xfs/235         |   4 +-
 tests/xfs/235.out     |   1 -
 tests/xfs/311         |  91 ++++++++++++++++
 tests/xfs/311.out     |   2 +
 tests/xfs/312         | 102 ++++++++++++++++++
 tests/xfs/312.out     |  18 ++++
 tests/xfs/313         | 102 ++++++++++++++++++
 tests/xfs/313.out     |  18 ++++
 tests/xfs/314         | 106 ++++++++++++++++++
 tests/xfs/314.out     |  18 ++++
 tests/xfs/315         |  99 +++++++++++++++++
 tests/xfs/315.out     |  16 +++
 tests/xfs/316         | 100 +++++++++++++++++
 tests/xfs/316.out     |  16 +++
 tests/xfs/317         |  95 +++++++++++++++++
 tests/xfs/317.out     |  16 +++
 tests/xfs/318         |  93 ++++++++++++++++
 tests/xfs/318.out     |  15 +++
 tests/xfs/319         |  97 +++++++++++++++++
 tests/xfs/319.out     |  19 ++++
 tests/xfs/320         |  95 +++++++++++++++++
 tests/xfs/320.out     |  18 ++++
 tests/xfs/321         |  94 ++++++++++++++++
 tests/xfs/321.out     |  17 +++
 tests/xfs/322         |  97 +++++++++++++++++
 tests/xfs/322.out     |  17 +++
 tests/xfs/323         |  94 ++++++++++++++++
 tests/xfs/323.out     |  17 +++
 tests/xfs/324         | 101 ++++++++++++++++++
 tests/xfs/324.out     |  17 +++
 tests/xfs/325         |  95 +++++++++++++++++
 tests/xfs/325.out     |  15 +++
 tests/xfs/326         | 109 +++++++++++++++++++
 tests/xfs/326.out     |  18 ++++
 tests/xfs/327         |  93 ++++++++++++++++
 tests/xfs/327.out     |  20 ++++
 tests/xfs/group       |  18 ++++
 94 files changed, 4562 insertions(+), 103 deletions(-)
--
Eryu Guan
eguan@redhat.com
