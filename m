Received: from imap.thunk.org ([74.207.234.97]:51035 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755914AbcBJBuM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Feb 2016 20:50:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 00/12] xfstests: fix up various tmpfs failures
Date: Tue,  9 Feb 2016 20:49:49 -0500
Message-Id: <1455069001-17846-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

I've been trying to sync up our internal xfststs tree at $WORK with
the latest upstream xfstests tree, and have been cleaning up the
patches so that they will hopefully be suitable for upstream merging.
This is most of the changes we have for tmpfs support.  I've left out
a few that I suspect should be fixed in other ways (e.g., in our
automated test framework).

With these changes all of the auto group tests are passing with tmpfs
with a the exception of generic/80 (which looks like a genuine test
failure) and generic/269 and generic/273 which are causing an OOM
kill (tmpfs allows an infinite number of inodes to be created until
kmalloc() fails or the test or the test runner gets killed with an OOM
kill).

I've disabled generic/027 for tmpfs for similar ENOSPC-related
reasons; we may want to do something similar for generic/269 and
generic/273 but I want to do a more in-depth examination of those
tests to be sure that there isn't an easy way to fix those tests for
tmpfs.

Hugh Dickins (8):
  common: _scratch_mkfs_sized() for tmpfs
  generic: use mount point instead of device name
  generic: add _require_odirect to three more tests
  generic: require fiemap for generic/009
  xfstests: fix generic/312 on tmpfs, ignore /proc/partitions
  xfstests: generic/079 requires chattr, not xattrs
  xfstests: add executable permission to tests
  xfstests: increase tmpfs memory size

Junho Ryu (2):
  xfstests: do not unmount tmpfs during remount
  generic: do not unmount before calling _check_scratch_fs()

Theodore Ts'o (2):
  check: avoid error messages of tests/$FS does not exist
  generic: disable generic/027 for tmpfs

 check                 |  6 ++++++
 common/config         |  4 ++--
 common/rc             | 35 ++++++++++++++++++++++++++++++-----
 tests/generic/003     | 12 ++++--------
 tests/generic/009     |  2 ++
 tests/generic/027     |  1 +
 tests/generic/053     |  2 --
 tests/generic/053.out |  2 --
 tests/generic/058     |  0
 tests/generic/060     |  0
 tests/generic/061     |  0
 tests/generic/063     |  0
 tests/generic/079     |  2 +-
 tests/generic/113     |  1 +
 tests/generic/125     |  1 +
 tests/generic/135     | 17 +++--------------
 tests/generic/169     | 20 ++++++--------------
 tests/generic/169.out |  6 ++----
 tests/generic/192     |  3 +--
 tests/generic/214     |  1 +
 tests/generic/226     |  3 +--
 tests/generic/258     |  3 +--
 tests/generic/273     |  2 +-
 tests/generic/306     |  3 +--
 tests/generic/312     | 11 ++++++-----
 tests/generic/317     |  3 +--
 tests/generic/318     |  3 +--
 27 files changed, 73 insertions(+), 70 deletions(-)
 mode change 100644 => 100755 tests/generic/058
 mode change 100644 => 100755 tests/generic/060
 mode change 100644 => 100755 tests/generic/061
 mode change 100644 => 100755 tests/generic/063

-- 
2.5.0

