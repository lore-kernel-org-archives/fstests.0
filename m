Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:36253 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750780AbaLTH2b (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 20 Dec 2014 02:28:31 -0500
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Subject: [PATCH] xfs: add test for truncate/collapse range race
Date: Sat, 20 Dec 2014 15:25:01 +0800
Message-ID: <1419060301-26830-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, guaneryu@gmail.com, lczerner@redhat.com, Xing Gu <gux.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

This case tests truncate/collapse range race. If
the race occurs, it will trigger BUG_ON.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 tests/generic/039     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/039.out |  1 +
 tests/generic/group   |  1 +
 3 files changed, 77 insertions(+)
 create mode 100755 tests/generic/039
 create mode 100644 tests/generic/039.out

diff --git a/tests/generic/039 b/tests/generic/039
new file mode 100755
index 0000000..a09df43
--- /dev/null
+++ b/tests/generic/039
@@ -0,0 +1,75 @@
+#! /bin/bash
+# FS QA Test No. 039
+#
+# Test truncate/collapse range race.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Fujitsu.  All Rights Reserved.
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
+
+_cleanup()
+{
+    rm -f $tmp.*
+}
+
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs generic
+_require_scratch
+_require_xfs_io_command "fcollapse"
+
+rm -f $seqres.full
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+old_bug=`dmesg | grep -c "kernel BUG"`
+
+testfile=$SCRATCH_MNT/file.$seq
+# fcollapse/truncate continuously and simultaneously a same file
+for ((i=1; i <= 100; i++)); do
+	for ((i=1; i <= 1000; i++)); do
+		$XFS_IO_PROG -f -c 'truncate 100k' $testfile 2>> $seqres.full
+		$XFS_IO_PROG -f -c 'fcollapse 0 16k' $testfile 2>> $seqres.full
+	done &
+	for ((i=1; i <= 1000; i++)); do
+		$XFS_IO_PROG -f -c 'truncate 0' $testfile 2>> $seqres.full
+	done &
+done
+
+wait
+
+new_bug=`dmesg | grep -c "kernel BUG"`
+if [ $new_bug -ne $old_bug ]; then
+	_fail "kernel bug detected, check dmesg for more infomation."
+fi
+
+status=0
+exit
diff --git a/tests/generic/039.out b/tests/generic/039.out
new file mode 100644
index 0000000..0cacac7
--- /dev/null
+++ b/tests/generic/039.out
@@ -0,0 +1 @@
+QA output created by 039
diff --git a/tests/generic/group b/tests/generic/group
index 1e89848..5a3d13a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -41,6 +41,7 @@
 036 auto aio rw stress
 037 metadata auto quick
 038 auto stress
+039 auto metadata rw
 053 acl repair auto quick
 062 attr udf auto quick
 068 other auto freeze dangerous stress
-- 
1.9.3

