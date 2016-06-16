Received: from cn.fujitsu.com ([59.151.112.132]:58804 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753270AbcFPDkT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 15 Jun 2016 23:40:19 -0400
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Subject: [PATCH v4] shared: regression test for hang when processing corrupted orphaned inode list
Date: Thu, 16 Jun 2016 11:41:45 +0800
Message-ID: <1466048505-13938-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
In-Reply-To: <20160615225559.GH12670@dastard>
References: <20160615225559.GH12670@dastard>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com
Cc: fstests@vger.kernel.org, Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Kernel commit c9eb13a fixed this bug:
	ext4: fix hang when processing corrupted orphaned inode list

Bug description:
	If the orphaned inode list contains inode #5, ext4_iget()
	returns a bad inode (since the bootloader inode should never
	be referenced directly). Because of the bad inode, we end up
	processing the inode repeatedly and this hangs the machine.

Test description:
	We manually set the superblock field last_orphan to 1~10
	(although the bug only happens when last_orphan is set to 5
	it is better to test all reserved inode numbers 1~10 here)
	and mount the fs in a loop to trigger the bug.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 common/config        |  1 +
 tests/shared/004     | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/shared/004.out |  2 ++
 tests/shared/group   |  1 +
 4 files changed, 68 insertions(+)
 create mode 100755 tests/shared/004
 create mode 100644 tests/shared/004.out

diff --git a/common/config b/common/config
index cacd815..c25b1ec 100644
--- a/common/config
+++ b/common/config
@@ -195,6 +195,7 @@ export DUMP_PROG="`set_prog_path dump`"
 export RESTORE_PROG="`set_prog_path restore`"
 export LVM_PROG="`set_prog_path lvm`"
 export CHATTR_PROG="`set_prog_path chattr`"
+export DEBUGFS_PROG="`set_prog_path debugfs`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/tests/shared/004 b/tests/shared/004
new file mode 100755
index 0000000..b9eaa15
--- /dev/null
+++ b/tests/shared/004
@@ -0,0 +1,64 @@
+#! /bin/bash
+# FS QA Test 004
+#
+# Regression test for commit:
+# c9eb13a ext4: fix hang when processing corrupted orphaned inode list
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
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
+
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+
+# real QA test starts here
+_supported_fs ext2 ext3 ext4
+_supported_os Linux
+_require_scratch
+_require_command "$DEBUGFS_PROG" debugfs
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+echo "Silence is golden"
+
+# although the bug only happens when last_orphan is set to 5
+# it is better to test all reserved inode numbers 1-10 here
+for i in {1..10}; do
+	# create smaller filesystems to save test time
+	_scratch_mkfs_sized $((16 * 1024 * 1024)) >>$seqres.full 2>&1
+	$DEBUGFS_PROG -w -R "ssv last_orphan $i" $SCRATCH_DEV >>$seqres.full 2>&1
+	_scratch_mount
+	_scratch_unmount
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/shared/004.out b/tests/shared/004.out
new file mode 100644
index 0000000..af8614a
--- /dev/null
+++ b/tests/shared/004.out
@@ -0,0 +1,2 @@
+QA output created by 004
+Silence is golden
diff --git a/tests/shared/group b/tests/shared/group
index ba8a3f0..55bb594 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -6,6 +6,7 @@
 001 auto quick
 002 auto metadata quick
 003 auto quick
+004 auto quick
 006 auto enospc
 032 mkfs auto quick
 051 acl udf auto quick
-- 
1.8.4.2



