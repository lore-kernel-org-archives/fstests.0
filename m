Received: from cn.fujitsu.com ([59.151.112.132]:59829 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933300AbcFMJHM (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 13 Jun 2016 05:07:12 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id 9D25041C0B9C
	for <fstests@vger.kernel.org>; Mon, 13 Jun 2016 17:07:04 +0800 (CST)
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Subject: [PATCH] ext4: regression test for hang when processing corrupted orphaned inode list
Date: Mon, 13 Jun 2016 17:09:12 +0800
Message-ID: <1465808952-9606-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
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
 tests/ext4/022     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/022.out |  1 +
 tests/ext4/group   |  1 +
 3 files changed, 57 insertions(+)
 create mode 100755 tests/ext4/022
 create mode 100644 tests/ext4/022.out

diff --git a/tests/ext4/022 b/tests/ext4/022
new file mode 100755
index 0000000..a3cc094
--- /dev/null
+++ b/tests/ext4/022
@@ -0,0 +1,55 @@
+#! /bin/bash
+# FS QA Test 022
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
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+_require_scratch
+_require_debugfs
+
+_scratch_mkfs >>$seqres.full 2>&1
+debugfs -w -R "ssv last_orphan 5" $SCRATCH_DEV >>$seqres.full 2>&1
+_scratch_mount
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/022.out b/tests/ext4/022.out
new file mode 100644
index 0000000..0266a8a
--- /dev/null
+++ b/tests/ext4/022.out
@@ -0,0 +1 @@
+QA output created by 022
diff --git a/tests/ext4/group b/tests/ext4/group
index 9e28159..3e0146b 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -23,6 +23,7 @@
 018 fuzzers
 019 fuzzers
 020 auto quick ioctl rw
+022 auto quick
 271 auto rw quick
 301 aio auto ioctl rw stress
 302 aio auto ioctl rw stress
-- 
1.8.4.2



