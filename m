Received: from cn.fujitsu.com ([59.151.112.132]:38155 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751612AbdF2Ggu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Jun 2017 02:36:50 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] generic: test a race between dio reads and mapped writes
Date: Thu, 29 Jun 2017 14:36:41 +0800
Message-ID: <1498718201-3629-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170629053943.GK23360@eguan.usersys.redhat.com>
References: <20170629053943.GK23360@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

This test reproduces a race between a direct I/O read and
a mapped write to a hole in a file.  On xfs filesystem, it
will trigger a BUG_ON(), and this XFS bug has been fixed by:

04197b3 ("xfs: don't BUG() on mixed direct and mapped I/O")

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/445     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/445.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 92 insertions(+)
 create mode 100755 tests/generic/445
 create mode 100644 tests/generic/445.out

diff --git a/tests/generic/445 b/tests/generic/445
new file mode 100755
index 0000000..28dfcbe
--- /dev/null
+++ b/tests/generic/445
@@ -0,0 +1,89 @@
+#! /bin/bash
+# FS QA Test No. 445
+#
+# Regression test for commit:
+# 04197b3 ("xfs: don't BUG() on mixed direct and mapped I/O")
+#
+# This case tests a race between a direct I/O read and a
+# mapped write to a hole in a file.  On xfs filesystem, it
+# will trigger a BUG_ON().
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Fujitsu.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
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
+_require_scratch
+_require_xfs_io_command "truncate"
+_require_xfs_io_command "fpunch"
+
+rm -f $seqres.full
+
+# format and mount
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+filesz=$((65536 * 2))
+
+# create a test file with a hole
+$XFS_IO_PROG -f -c "truncate $((filesz * 2))" $SCRATCH_MNT/file >> $seqres.full
+
+# run a background dio read to a hole in a loop
+while true; do
+	$XFS_IO_PROG -d -c "pread 0 $filesz" $SCRATCH_MNT/file > /dev/null 2>&1
+done &
+
+dread_pid=$!
+
+# run mapped write to the same hole as dio read
+for i in `seq 0 999`; do
+	$XFS_IO_PROG -c "mmap 0 $filesz" -c "mwrite 0 $filesz" $SCRATCH_MNT/file \
+		> /dev/null
+	$XFS_IO_PROG -c "fpunch 0 $filesz" $SCRATCH_MNT/file > /dev/null
+done
+
+kill -9 $dread_pid > /dev/null 2>&1
+wait $dread_pid > /dev/null 2>&1
+
+echo "Silence is golden"
+
+# check dmesg, filtering out expected XFS warnings about mixed mmap/dio
+if [ "$FSTYP" == "xfs" ]; then
+	_check_dmesg _filter_xfs_dmesg
+else
+	_check_dmesg
+fi
+status=$?
+exit
diff --git a/tests/generic/445.out b/tests/generic/445.out
new file mode 100644
index 0000000..44e55d2
--- /dev/null
+++ b/tests/generic/445.out
@@ -0,0 +1,2 @@
+QA output created by 445
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index ced111c..39991b1 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -447,3 +447,4 @@
 442 blockdev
 443 auto quick rw
 444 auto quick acl
+445 auto quick dangerous
-- 
1.8.3.1



