Received: from imap.thunk.org ([74.207.234.97]:35997 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbcBKF41 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 00:56:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH-v2 00/13] fix up various tmpfs failures
Date: Thu, 11 Feb 2016 00:56:09 -0500
Message-Id: <1455170182-32587-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

This patch series should address all of the review comments from v1.

In particular, I've added a sanity check to make sure there is enough
memory available for creating the scratch file system in
_scratch_mkfs_sized.  I've also removed generic/125, and dropped the
patch to disable generic/027 for tmpfs.

Hugh Dickins (7):
  common: _scratch_mkfs_sized() for tmpfs
  generic: use mount point instead of device name
  generic: require fiemap for generic/009
  xfstests: remove dependency on /proc/partitions for generic/312
  xfstests: generic/079 and generic/277 requires chattr, not xattrs
  xfstests: add executable permission to tests
  xfstests: increase tmpfs memory size

Junho Ryu (2):
  xfstests: do not unmount tmpfs during remount
  generic: do not unmount before calling _check_scratch_fs()

Theodore Ts'o (4):
  check: avoid spurious complaints that tests/$FSTYP/group does not
    exist
  generic: remove the generic/125 test
  generic: add _require_odirect to generic/113 and generic/214
  common: remove unneeded mount options for ext4

 check                 |  6 +++++
 common/config         |  7 ++++--
 common/rc             | 54 +++++++++++++++++++++++++++++++++++++++-
 tests/btrfs/026       |  0
 tests/btrfs/104       |  0
 tests/btrfs/114       |  0
 tests/generic/003     | 12 +++------
 tests/generic/009     |  2 ++
 tests/generic/053     |  2 --
 tests/generic/053.out |  2 --
 tests/generic/058     |  0
 tests/generic/060     |  0
 tests/generic/061     |  0
 tests/generic/063     |  0
 tests/generic/079     |  2 +-
 tests/generic/092     |  0
 tests/generic/094     |  0
 tests/generic/103     |  0
 tests/generic/113     |  1 +
 tests/generic/125     | 68 ---------------------------------------------------
 tests/generic/135     | 17 +++----------
 tests/generic/169     | 20 +++++----------
 tests/generic/169.out |  6 ++---
 tests/generic/192     |  3 +--
 tests/generic/214     |  1 +
 tests/generic/226     |  3 +--
 tests/generic/258     |  3 +--
 tests/generic/273     |  2 +-
 tests/generic/277     |  2 +-
 tests/generic/306     |  3 +--
 tests/generic/312     | 13 ++++++----
 tests/generic/317     |  3 +--
 tests/generic/318     |  3 +--
 tests/generic/group   |  1 -
 tests/xfs/140         |  0
 35 files changed, 100 insertions(+), 136 deletions(-)
 mode change 100644 => 100755 tests/btrfs/026
 mode change 100644 => 100755 tests/btrfs/104
 mode change 100644 => 100755 tests/btrfs/114
 mode change 100644 => 100755 tests/generic/058
 mode change 100644 => 100755 tests/generic/060
 mode change 100644 => 100755 tests/generic/061
 mode change 100644 => 100755 tests/generic/063
 mode change 100644 => 100755 tests/generic/092
 mode change 100644 => 100755 tests/generic/094
 mode change 100644 => 100755 tests/generic/103
 delete mode 100755 tests/generic/125
 mode change 100644 => 100755 tests/xfs/140

-- 
2.5.0

