Received: from cn.fujitsu.com ([222.73.24.84]:7198 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbcGTHhp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jul 2016 03:37:45 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] btrfs: test whether fallocate(2) can preallocate half of the whole fs space
Date: Wed, 20 Jul 2016 15:34:50 +0800
Message-Id: <20160720073450.8952-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Currently in btrfs, there is something wrong with data space reservation.
For example, if we try to preallocate more than haf of whole fs space,
ENOSPC will occur, but indeed fs still has free space to satisfy this
request.

To easily reproduce this bug, this test case needs fs is mixed mode(btrfs
specific), so put this test case in btrfs group, not generic group.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 tests/btrfs/127     | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/127.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 64 insertions(+)
 create mode 100755 tests/btrfs/127
 create mode 100644 tests/btrfs/127.out

diff --git a/tests/btrfs/127 b/tests/btrfs/127
new file mode 100755
index 0000000..f95c72f
--- /dev/null
+++ b/tests/btrfs/127
@@ -0,0 +1,61 @@
+#! /bin/bash
+# FS QA Test 127
+#
+# Test whether fallocate(2) can preallocate half of the whole fs space.
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
+MKFS_OPTIONS="-M"
+_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+
+$XFS_IO_PROG -f -c "falloc 0 128M" $SCRATCH_MNT/testfile | _filter_xfs_io
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/127.out b/tests/btrfs/127.out
new file mode 100644
index 0000000..0af84c0
--- /dev/null
+++ b/tests/btrfs/127.out
@@ -0,0 +1,2 @@
+QA output created by 127
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index a21a80a..4c3ac00 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -129,3 +129,4 @@
 124 auto replace
 125 auto replace
 126 auto quick qgroup
+127 auto quick metadata enospc
-- 
2.9.0



