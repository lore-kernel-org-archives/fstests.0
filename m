Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752924AbeB1P6F (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Feb 2018 10:58:05 -0500
From: fdmanana@kernel.org
Subject: [PATCH] generic: test fsync new file after removing hard link
Date: Wed, 28 Feb 2018 15:58:00 +0000
Message-Id: <20180228155800.5965-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if we have a file with two hard links in the same parent
directory, then remove of the links, create a new file in the same
parent directory and with the name of the link removed, fsync the new
file and have a power loss, mounting the filesystem succeeds.

This test is motivated by a bug found in btrfs, which is fixed by
the linux kernel patch titled:

  "Btrfs: fix log replay failure after unlink and link combination"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/480     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/480.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/generic/480
 create mode 100644 tests/generic/480.out

diff --git a/tests/generic/480 b/tests/generic/480
new file mode 100755
index 00000000..a287684b
--- /dev/null
+++ b/tests/generic/480
@@ -0,0 +1,83 @@
+#! /bin/bash
+# FSQA Test No. 480
+#
+# Test that if we have a file with two hard links in the same parent directory,
+# then remove of the links, create a new file in the same parent directory and
+# with the name of the link removed, fsync the new file and have a power loss,
+# mounting the filesystem succeeds.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+# Author: Filipe Manana <fdmanana@suse.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmflakey
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+mkdir $SCRATCH_MNT/testdir
+touch $SCRATCH_MNT/testdir/foo
+ln $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/bar
+
+# Make sure everything done so far is durably persisted.
+sync
+
+# Now remove of the links of our file and create a new file with the same name
+# and in the same parent directory, and finally fsync this new file.
+unlink $SCRATCH_MNT/testdir/bar
+touch $SCRATCH_MNT/testdir/bar
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/bar
+
+# Simulate a power failure and mount the filesystem to check that replaying the
+# the fsync log/journal succeeds, that is the mount operation does not fail.
+_flakey_drop_and_remount
+
+_unmount_flakey
+_cleanup_flakey
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/480.out b/tests/generic/480.out
new file mode 100644
index 00000000..a40a718e
--- /dev/null
+++ b/tests/generic/480.out
@@ -0,0 +1,2 @@
+QA output created by 480
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 3b9b47e3..ea2056b1 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -482,3 +482,4 @@
 477 auto quick exportfs
 478 auto quick
 479 auto quick metadata
+480 auto quick metadata
-- 
2.11.0

