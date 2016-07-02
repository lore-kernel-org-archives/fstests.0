Received: from mx1.redhat.com ([209.132.183.28]:41466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbcGBGMi (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 2 Jul 2016 02:12:38 -0400
Message-Id: <201607020612.u626CZLD006482@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Sat, 02 Jul 2016 14:12:35 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-07-02
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? Notably, it
contains the richacl tests from Andreas, but the tests won't run for now
without kernel & userspace tools support.

Thanks,
Eryu

The following changes since commit 54774d4bb5f8b5756913034cf9fdd28ba5bee03c:

  ext4/271: _notrun if there are journal related mount options (2016-06-24 12:54:04 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 5bde2583c38ce401b4cff81c182dcd49985dbe22:

  btrfs: EDQUOTA leaks reserved data space (2016-07-01 23:12:50 +0800)

----------------------------------------------------------------

fstests: update on 2016-07-02

This update contains:
o New richacl tests
o dm-delay support
o New tests for xfs, btrfs and overlay
o Various bug fixes and enhancements

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

Eryu Guan (2):
      overlay: dentry leak for default_permissions mount option
      overlay: remove dir which contains whiteout from lower dir

Jeff Mahoney (1):
      btrfs/048: extend _filter_btrfs_prop_error to handle additional errors

Omer Zilberberg (1):
      generic/294: filter quotes from mknod

Qu Wenruo (1):
      btrfs: EDQUOTA leaks reserved data space

Theodore Ts'o (2):
      common/rc: ext4 doesn't support O_DIRECT with encryption
      generic/082: rename _filter_project_quota to a avoid function name conflict

 common/config         |   2 +
 common/dmdelay        |  90 +++++++++++++++++++++
 common/filter         |   7 ++
 common/filter.btrfs   |  10 ++-
 common/rc             | 214 ++++++++++++++++++++++++++++++++++++++++++++++++--
 tests/btrfs/027       |  24 ++++--
 tests/btrfs/048       |   6 +-
 tests/btrfs/048.out   |   4 +-
 tests/btrfs/124       | 166 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/124.out   |   7 ++
 tests/btrfs/125       | 182 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/125.out   |   7 ++
 tests/btrfs/126       |  73 +++++++++++++++++
 tests/btrfs/126.out   |   2 +
 tests/btrfs/group     |   3 +
 tests/generic/082     |   6 +-
 tests/generic/093     |  14 ++--
 tests/generic/099     |  45 +++++------
 tests/generic/237     |   6 +-
 tests/generic/294     |   2 +-
 tests/generic/294.out |   2 +-
 tests/generic/362     | 125 +++++++++++++++++++++++++++++
 tests/generic/362.out |  94 ++++++++++++++++++++++
 tests/generic/363     | 118 ++++++++++++++++++++++++++++
 tests/generic/363.out | 139 ++++++++++++++++++++++++++++++++
 tests/generic/364     |  98 +++++++++++++++++++++++
 tests/generic/364.out |  39 +++++++++
 tests/generic/365     |  93 ++++++++++++++++++++++
 tests/generic/365.out |   9 +++
 tests/generic/366     |  86 ++++++++++++++++++++
 tests/generic/366.out |  11 +++
 tests/generic/367     |  85 ++++++++++++++++++++
 tests/generic/367.out |  11 +++
 tests/generic/368     |  85 ++++++++++++++++++++
 tests/generic/368.out |   7 ++
 tests/generic/369     | 126 +++++++++++++++++++++++++++++
 tests/generic/369.out |  24 ++++++
 tests/generic/370     |  90 +++++++++++++++++++++
 tests/generic/370.out |  19 +++++
 tests/generic/group   |  11 ++-
 tests/overlay/009     |  68 ++++++++++++++++
 tests/overlay/009.out |   2 +
 tests/overlay/010     |  78 ++++++++++++++++++
 tests/overlay/010.out |   2 +
 tests/overlay/group   |   2 +
 tests/shared/051      |  48 ++++++-----
 tests/xfs/311         |  91 +++++++++++++++++++++
 tests/xfs/311.out     |   2 +
 tests/xfs/group       |   1 +
 49 files changed, 2348 insertions(+), 88 deletions(-)
--
Eryu Guan
eguan@redhat.com
