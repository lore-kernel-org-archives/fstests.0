Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:33529 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750945AbaI3Jwu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 30 Sep 2014 05:52:50 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8U9qoTq005392
	for <fstests@vger.kernel.org>; Tue, 30 Sep 2014 17:52:50 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Subject: [PATCH v3] xfstests: add test for truncate/collapse range race
Date: Tue, 30 Sep 2014 17:50:17 +0800
Message-ID: <1412070617-17136-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1403157004-25112-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1403157004-25112-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xing Gu <gux.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

This case tests truncate/collapse range race. If
the race occurs, it will trigger BUG_ON.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 tests/generic/326     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/326.out |  1 +
 tests/generic/group   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100755 tests/generic/326
 create mode 100644 tests/generic/326.out

diff --git a/tests/generic/326 b/tests/generic/326
new file mode 100755
index 0000000..c24e3ba
--- /dev/null
+++ b/tests/generic/326
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FS QA Test No. 326
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
+	for ((i=1; i <= 1000; i++))
+	do
+		$XFS_IO_PROG -f -c 'truncate 100k' $testfile 2>> $seqres.full
+		$XFS_IO_PROG -f -c 'fcollapse 0 16k' $testfile 2>> $seqres.full
+	done &
+	for ((i=1; i <= 1000; i++))
+	do
+		$XFS_IO_PROG -f -c 'truncate 0' $testfile 2>> $seqres.full
+	done &
+done
+
+wait
+
+new_bug=`dmesg | grep -c "kernel BUG"`
+if [ $new_bug -ne $old_bug ]; then
+	echo "kernel bug detected, check dmesg for more infomation."
+fi
+
+status=0 ; exit
diff --git a/tests/generic/326.out b/tests/generic/326.out
new file mode 100644
index 0000000..90a76cc
--- /dev/null
+++ b/tests/generic/326.out
@@ -0,0 +1 @@
+QA output created by 326
diff --git a/tests/generic/group b/tests/generic/group
index 799bfd8..5ef8acb 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -151,3 +151,4 @@
 323 auto aio stress
 324 auto fsr quick
 325 auto quick data log
+326 auto
-- 
1.9.3

