Received: from cn.fujitsu.com ([59.151.112.132]:9395 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423237AbcFNC4y (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 13 Jun 2016 22:56:54 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id D8A67409257A
	for <fstests@vger.kernel.org>; Tue, 14 Jun 2016 10:56:48 +0800 (CST)
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Subject: [PATCH v2] shared: regression test for hang when processing corrupted orphaned inode list
Date: Tue, 14 Jun 2016 10:58:59 +0800
Message-ID: <1465873139-8724-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
In-Reply-To: <20160613093350.GJ5140@eguan.usersys.redhat.com>
References: <20160613093350.GJ5140@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Commit c9eb13a fixed this bug:
	ext4: fix hang when processing corrupted orphaned inode list

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 common/config        |  1 +
 tests/shared/004     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/shared/004.out |  2 ++
 tests/shared/group   |  1 +
 4 files changed, 66 insertions(+)
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
index 0000000..213fba2
--- /dev/null
+++ b/tests/shared/004
@@ -0,0 +1,62 @@
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
+for i in {1..10}
+do
+	_scratch_mkfs >>$seqres.full 2>&1
+	debugfs -w -R "ssv last_orphan $i" $SCRATCH_DEV >>$seqres.full 2>&1
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



