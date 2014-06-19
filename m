Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:25861 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752215AbaFSFvL (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 19 Jun 2014 01:51:11 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5J5p5bW001055
	for <fstests@vger.kernel.org>; Thu, 19 Jun 2014 13:51:05 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Subject: [PATCH] xfstests: add test for ext4 fallocate collapse range check
Date: Thu, 19 Jun 2014 13:50:04 +0800
Message-ID: <1403157004-25112-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xing Gu <gux.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

This is a test to verify the procedure which checks whether
offset + len is bigger than i_size is removed from do_fallocate
in collapse range to the file system, and ensure that i_size is
not going to change.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 tests/ext4/307     | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/307.out |  1 +
 tests/ext4/group   |  1 +
 3 files changed, 82 insertions(+)
 create mode 100755 tests/ext4/307
 create mode 100644 tests/ext4/307.out

diff --git a/tests/ext4/307 b/tests/ext4/307
new file mode 100755
index 0000000..595c7c1
--- /dev/null
+++ b/tests/ext4/307
@@ -0,0 +1,80 @@
+#! /bin/bash
+# FS QA Test No. 307
+#
+# Regression test for commit:
+# 23fffa9 fs: move falloc collapse range check into the filesystem methods
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
+PIDS=""
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	kill $PIDS >/dev/null 2>&1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+_require_scratch
+_require_xfs_io_command "fcollapse"
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+old_bug=`dmesg | grep -c "kernel BUG"`
+
+testfile=$SCRATCH_MNT/file.$seq
+# fcollapse/truncate continuously and simultaneously
+# a same file
+for ((i=1; i <= 100; i++))
+do
+	while true;do
+		$XFS_IO_PROG -f -c 'truncate 100k' $testfile 2>> $seqres.full
+		$XFS_IO_PROG -f -c 'fcollapse 0 16k' $testfile 2>> $seqres.full
+	done &
+	PIDS="$PIDS $!"
+	while true;do
+		$XFS_IO_PROG -f -c 'truncate 0' $testfile 2>> $seqres.full
+	done &
+	PIDS="$PIDS $!"
+done
+# sleep for 180s, BUG_ON is triggered within 3 minutes
+# in most case
+sleep 180
+
+new_bug=`dmesg | grep -c "kernel BUG"`
+if [ $new_bug -ne $old_bug ]; then
+	echo "kernel bug detected, check dmesg for more infomation."
+fi
+
+kill $PIDS >/dev/null 2>&1
+wait
+status=0
+exit
diff --git a/tests/ext4/307.out b/tests/ext4/307.out
new file mode 100644
index 0000000..260c17c
--- /dev/null
+++ b/tests/ext4/307.out
@@ -0,0 +1 @@
+QA output created by 307
diff --git a/tests/ext4/group b/tests/ext4/group
index 7e66035..0f1852f 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -12,3 +12,4 @@
 304 aio dangerous ioctl rw stress
 305 auto
 306 auto rw resize quick
+307 auto
-- 
1.9.3

