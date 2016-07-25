Received: from cn.fujitsu.com ([222.73.24.84]:50899 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbcGYHq0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 25 Jul 2016 03:46:26 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH v2] generic/371: run write(2) and fallocate(2) in parallel
Date: Mon, 25 Jul 2016 15:43:30 +0800
Message-Id: <20160725074330.30081-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Currently in btrfs, there is something wrong with fallocate(2)'s data
space reservation, it'll temporarily occupy more data space thant it
really needs, which in turn will impact other operations' data request.

In this test case, it runs write(2) and fallocate(2) in parallel and the
total needed data space for these two operations don't exceed whole fs
free data space, to see whether we will get any unexpected ENOSPC error.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
v2: adopt Eryu Guan's suggestions to make this reproducer cleaner, thanks
---
 tests/generic/371     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/371.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 78 insertions(+)
 create mode 100755 tests/generic/371
 create mode 100644 tests/generic/371.out

diff --git a/tests/generic/371 b/tests/generic/371
new file mode 100755
index 0000000..7955856
--- /dev/null
+++ b/tests/generic/371
@@ -0,0 +1,75 @@
+#! /bin/bash
+# FS QA Test 371
+#
+# Run write(2) and fallocate(2) in parallel and the total needed data space
+# for these operations don't exceed whole fs free data space, to see whether
+# we will get any unexpected ENOSPC error.
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
+here=`pwd`
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
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_xfs_io_command "falloc"
+
+_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+
+testfile1=$SCRATCH_MNT/testfile1
+testfile2=$SCRATCH_MNT/testfile2
+
+echo "Silence is golden"
+for ((i=0; i<100; i++)); do
+	$XFS_IO_PROG -fc "pwrite 0 80M" $testfile1 >/dev/null
+	rm -f $testfile1
+done &
+pids=$!
+
+for ((i=0; i<100; i++)); do
+	$XFS_IO_PROG -fc "falloc 0 80M" $testfile2 >/dev/null
+	rm -f $testfile2
+done &
+pids="$pids $!"
+
+wait $pids
+status=0
+exit
diff --git a/tests/generic/371.out b/tests/generic/371.out
new file mode 100644
index 0000000..22ec8a2
--- /dev/null
+++ b/tests/generic/371.out
@@ -0,0 +1,2 @@
+QA output created by 371
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 97ecb65..1236281 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -373,3 +373,4 @@
 368 auto quick richacl
 369 auto quick richacl
 370 auto quick richacl
+371 auto quick enospc prealloc
-- 
2.9.0



