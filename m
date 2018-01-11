From: xiao yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs: Regression test for invalid sb_logsunit
Date: Thu, 11 Jan 2018 16:25:08 +0800
Message-ID: <1515659108-2222-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, xiao yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

If log stripe unit isn't a multiple of the fs blocksize and mounting,
the invalid sb_logsunit leads to crash as soon as we try to write to
the log.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/437     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/437.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/xfs/437
 create mode 100644 tests/xfs/437.out

diff --git a/tests/xfs/437 b/tests/xfs/437
new file mode 100755
index 0000000..96cec25
--- /dev/null
+++ b/tests/xfs/437
@@ -0,0 +1,73 @@
+#! /bin/bash
+# FS QA Test No. 437
+#
+# Regression test for commit:
+# 9c92ee2 ("xfs: validate sb_logsunit is a multiple of the fs blocksize")
+#
+# If log stripe unit isn't a multiple of the fs blocksize and mounting,
+# the invalid sb_logsunit leads to crash as soon as we try to write to
+# the log.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 FUJITSU.  All Rights Reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+
+seq=`basename "$0"`
+seqres="$RESULT_DIR/$seq"
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	rm -rf $tmp.*
+}
+
+# get standard environment and checks
+. ./common/rc
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs xfs
+_require_scratch
+
+rm -f "$seqres.full"
+
+# Format
+_scratch_mkfs > $seqres.full 2>&1 || _fail "mkfs failed"
+
+# Set logsunit to a value which is not a multiple of the fs blocksize
+blksz=$(_scratch_xfs_db -x -c "sb 0" -c "p blocksize")
+_scratch_xfs_db -x -c "sb 0" -c "write logsunit $((blksz - 1))" \
+	>> $seqres.full 2>&1 || _notrun "Failed to set sb_logsunit"
+
+# Mount and writing log may trigger a crash
+if _scratch_mount >> $seqres.full 2>&1; then
+	for i in $(seq 1 1000); do
+		touch ${SCRATCH_MNT}/$i
+	done
+	_scratch_unmount
+fi
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/437.out b/tests/xfs/437.out
new file mode 100644
index 0000000..4dcb607
--- /dev/null
+++ b/tests/xfs/437.out
@@ -0,0 +1,2 @@
+QA output created by 437
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index d230060..35d1b03 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -434,3 +434,4 @@
 434 auto quick clone fsr
 435 auto quick clone
 436 auto quick clone fsr
+437 auto quick log dangerous
-- 
1.8.3.1
