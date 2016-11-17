Received: from mail.kernel.org ([198.145.29.136]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752375AbcKQD2x (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Nov 2016 22:28:53 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] generic/391: check inode metadata on f{data}sync after power-cut
Date: Wed, 16 Nov 2016 19:27:53 -0800
Message-Id: <20161117032753.69315-1-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch adds tests/generic/391 to test fsync and fdatasync with power-cuts.

The rule to check is:
1) fsync should guarantee all the inode metadata after power-cut,
2) fdatasync should guarantee i_size and i_blocks at least after power-cut.

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/generic/391     | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/391.out |  11 +++++
 tests/generic/group   |   1 +
 3 files changed, 137 insertions(+)
 create mode 100644 tests/generic/391
 create mode 100644 tests/generic/391.out

diff --git a/tests/generic/391 b/tests/generic/391
new file mode 100644
index 0000000..17c3fd3
--- /dev/null
+++ b/tests/generic/391
@@ -0,0 +1,125 @@
+#! /bin/bash
+# FS QA Test 391
+#
+# Test inode's metadata after fsync or fdatasync calls.
+# In the case of fsync, filesystem should recover all the inode metadata, while
+# recovering i_blocks and i_size at least for fdatasync.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Jaegeuk Kim.  All Rights Reserved.
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
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/punch
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+rm -f $seqres.full
+_require_scratch
+_require_scratch_shutdown
+_require_xfs_io_command "fpunch"
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+
+# check inode metadata after shutdown
+_check_inode_metadata()
+{
+	src/godown $SCRATCH_MNT >> $seqres.full
+	$XFS_IO_PROG -r -c "stat -v" $1 >$tmp.before
+	_scratch_cycle_mount
+	$XFS_IO_PROG -r -c "stat -v" $1 >$tmp.after
+	diff $tmp.before $tmp.after >>$tmp.diff
+
+	if [ "$2" = "fdatasync" ]; then
+		cat $tmp.diff | grep stat.size
+		cat $tmp.diff | grep stat.blocks
+	else
+		cat $tmp.diff
+	fi
+	cat $tmp.before >> $seqres.full
+	cat $tmp.after >> $seqres.full
+}
+
+# append XX KB with f{data}sync, followed by power-cut
+_test_i_size()
+{
+	echo "==== i_size $2 test with $1 ===="
+	$XFS_IO_PROG -f -c "pwrite 0 4M"	\
+			-c "fsync"		\
+			-c "pwrite 4M $2"	\
+			-c "$1"			\
+			$testfile >/dev/null
+	_check_inode_metadata $testfile $1
+}
+
+# update times with f{data}sync, followed by power-cut
+_test_i_time()
+{
+	echo "==== i_time test with $1 ===="
+	$XFS_IO_PROG -f -c "pwrite 0 4M"	\
+			-c "fsync"		\
+			$testfile >/dev/null
+	sleep 1
+	touch $testfile
+	$XFS_IO_PROG -c "$1"			\
+			$testfile >/dev/null
+	_check_inode_metadata $testfile $1
+}
+
+# punch XX KB with f{data}sync, followed by power-cut
+_test_punch()
+{
+	echo "==== fpunch $2 test with $1 ===="
+	$XFS_IO_PROG -f -c "pwrite 0 4202496"	\
+			-c "fsync"		\
+			-c "fpunch 4194304 $2"\
+			-c "$1"			\
+			$testfile >/dev/null
+
+	_check_inode_metadata $testfile $1
+}
+
+for i in fsync fdatasync
+do
+	_test_i_size $i 1024
+	_test_i_size $i 4096
+	_test_i_time $i
+	_test_punch $i 1024
+	_test_punch $i 4096
+done
+
+rm -f $tmp.*
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/391.out b/tests/generic/391.out
new file mode 100644
index 0000000..7c66776
--- /dev/null
+++ b/tests/generic/391.out
@@ -0,0 +1,11 @@
+QA output created by 391
+==== i_size 1024 test with fsync ====
+==== i_size 4096 test with fsync ====
+==== i_time test with fsync ====
+==== fpunch 1024 test with fsync ====
+==== fpunch 4096 test with fsync ====
+==== i_size 1024 test with fdatasync ====
+==== i_size 4096 test with fdatasync ====
+==== i_time test with fdatasync ====
+==== fpunch 1024 test with fdatasync ====
+==== fpunch 4096 test with fdatasync ====
diff --git a/tests/generic/group b/tests/generic/group
index 08007d7..9de3415 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -392,3 +392,4 @@
 387 auto clone
 388 auto log metadata
 389 auto quick acl
+391 auto quick metadata
-- 
2.8.3

