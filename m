Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:44919 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S932538AbcKHJaZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 8 Nov 2016 04:30:25 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: btrfs: Check false ENOSPC bug caused by incorrect metadata reserve
Date: Tue,  8 Nov 2016 17:15:15 +0800
Message-Id: <20161108091515.20867-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Due to the fact that btrfs uses different max extent size for
compressed and non-compressed write, it calculates metadata reservation
incorrectly.

This can leads to false ENOSPC alert for compressed write.

This test case will check it by using small fs and large nodesize, and
do parallel compressed write to trigger it.

The fix is not merged and may change in the future, but the function is
good enough:
btrfs: improve inode's outstanding_extents computation
btrfs: fix false enospc for compression

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/132     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/132.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 92 insertions(+)
 create mode 100755 tests/btrfs/132
 create mode 100644 tests/btrfs/132.out

diff --git a/tests/btrfs/132 b/tests/btrfs/132
new file mode 100755
index 0000000..95c21ea
--- /dev/null
+++ b/tests/btrfs/132
@@ -0,0 +1,89 @@
+#! /bin/bash
+# FS QA Test 132
+#
+# Check if false ENOSPC will happen when parallel buffer write happens
+# The problem is caused by incorrect metadata reservation.
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
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+
+# Use small filesystem with maximum nodesize.
+# Since the false ENOSPC happens due to incorrect metadata reservation,
+# larger nodesize and small fs will make it much easier to reproduce
+_scratch_mkfs -b 512M -n 64k >> $seqres.full 2>&1
+_scratch_mount "-o compress"
+
+sleep_time=$(($TIME_FACTOR * 15))
+loop_writer()
+{
+	offset=$1
+	len=$2
+	file=$3
+
+	while true;
+	do
+		# Only need stderr, and we need to specify small block size
+		# but still trigger compression
+		xfs_io -c "pwrite -b 8K $offset $len" $file 2>&1 > /dev/null
+	done
+}
+
+touch $SCRATCH_MNT/testfile
+
+# Start 2 writter writting into the same file
+# The file is 142M, which is smaller than 1/2 of the filesystem,
+# so no other cause can lead to ENOSPC.
+loop_writer 0 128M $SCRATCH_MNT/testfile &
+loop_writer 128M 16M $SCRATCH_MNT/testfile &
+
+sleep $sleep_time
+
+kill 0
+sleep
+
+status=0
+exit
diff --git a/tests/btrfs/132.out b/tests/btrfs/132.out
new file mode 100644
index 0000000..b096312
--- /dev/null
+++ b/tests/btrfs/132.out
@@ -0,0 +1,2 @@
+QA output created by 132
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index c090604..ec8ad80 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -134,3 +134,4 @@
 129 auto quick send
 130 auto clone send
 131 auto quick
+132 auto compress
-- 
2.7.4



