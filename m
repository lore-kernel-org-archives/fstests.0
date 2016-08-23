Received: from mail.kernel.org ([198.145.29.136]:41230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754911AbcHXI6C (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Aug 2016 04:58:02 -0400
From: fdmanana@kernel.org
Subject: [PATCH] fstests: generic test for fsync after file rename
Date: Tue, 23 Aug 2016 21:14:23 +0100
Message-Id: <1471983263-3013-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if we rename a file, without changing its parent directory,
create a new file that has the old name of the file we renamed, doing an
fsync against the file we renamed works correctly and after a power
failure both files exists.

This is motivated by an issue found in btrfs, introduced in the linux
kernel 4.8-rc2, that caused lockdep to report a deadlock scenario. The
btrfs issue is fixed by the patch titled:

  "Btrfs: fix lockdep warning on deadlock against an inode's log mutex"

Tested against ext3/4, xfs, f2fs and reiserfs as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/375     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/375.out |  5 ++++
 tests/generic/group   |  1 +
 3 files changed, 83 insertions(+)
 create mode 100755 tests/generic/375
 create mode 100644 tests/generic/375.out

diff --git a/tests/generic/375 b/tests/generic/375
new file mode 100755
index 0000000..4c33655
--- /dev/null
+++ b/tests/generic/375
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FSQA Test No. 375
+#
+# Test that if we rename a file, without changing its parent directory, create
+# a new file that has the old name of the file we renamed, doing an fsync
+# against the file we renamed works correctly and after a power failure both
+# files exists.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (C) 2016 SUSE Linux Products GmbH. All Rights Reserved.
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
+_require_metadata_journaling $SCRATCH_DEV
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_init_flakey
+_mount_flakey
+
+# Create our test directories and files.
+mkdir $SCRATCH_MNT/dir
+touch $SCRATCH_MNT/dir/foo
+# Make sure everything is durably persisted.
+sync
+mv $SCRATCH_MNT/dir/foo $SCRATCH_MNT/dir/bar
+touch $SCRATCH_MNT/dir/foo
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir/bar
+
+_flakey_drop_and_remount
+
+echo "Filesystem contents after log replay:"
+ls -R $SCRATCH_MNT/dir | _filter_scratch
+
+_unmount_flakey
+status=0
+exit
diff --git a/tests/generic/375.out b/tests/generic/375.out
new file mode 100644
index 0000000..dee14f3
--- /dev/null
+++ b/tests/generic/375.out
@@ -0,0 +1,5 @@
+QA output created by 375
+Filesystem contents after log replay:
+SCRATCH_MNT/dir:
+bar
+foo
diff --git a/tests/generic/group b/tests/generic/group
index ef38c35..3068510 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -377,3 +377,4 @@
 372 auto quick clone
 373 auto quick clone
 374 auto quick clone dedupe
+375 auto quick metadata
-- 
2.7.0.rc3

