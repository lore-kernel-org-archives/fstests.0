Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46394 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbaGUEMQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 21 Jul 2014 00:12:16 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs: new test to test xfs_repair segfault issue
Date: Mon, 21 Jul 2014 12:11:49 +0800
Message-Id: <1405915909-31383-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Test segfault issue when repairing large xfs.

Regression test for xfsprogs commit
7f2d6b8 xfs_repair: avoid segfault if reporting progress early in repair

The original test is from the commit log, written by Eric Sandeen.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/020     | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/020.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 60 insertions(+)
 create mode 100755 tests/xfs/020
 create mode 100644 tests/xfs/020.out

diff --git a/tests/xfs/020 b/tests/xfs/020
new file mode 100755
index 0000000..3405b38
--- /dev/null
+++ b/tests/xfs/020
@@ -0,0 +1,57 @@
+#! /bin/bash
+# FS QA Test No. xfs/020
+#
+# Test segfault issue when repairing large xfs.
+#
+# Regression test for xfsprogs commit
+# 7f2d6b8 xfs_repair: avoid segfault if reporting progress early in repair
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Red Hat Inc.  All Rights Reserved.
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
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+    rm -f $tmp.*
+    rm -f $TEST_DIR/fsfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs xfs
+_supported_os Linux
+
+echo "Silence is golden"
+
+$MKFS_PROG -t xfs -d size=60t,file,name=$TEST_DIR/fsfile >/dev/null
+$XFS_REPAIR_PROG -o ag_stride=32 -t 1 $TEST_DIR/fsfile >/dev/null 2>&1
+
+status=$?
+exit
diff --git a/tests/xfs/020.out b/tests/xfs/020.out
new file mode 100644
index 0000000..20d7944
--- /dev/null
+++ b/tests/xfs/020.out
@@ -0,0 +1,2 @@
+QA output created by 020
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index 0aab336..4d35df5 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -17,6 +17,7 @@
 017 mount auto quick stress
 018 deprecated # log logprint v2log
 019 mkfs auto quick
+020 auto repair
 021 db attr auto quick
 022 dump ioctl tape
 023 dump ioctl tape
-- 
1.9.3

