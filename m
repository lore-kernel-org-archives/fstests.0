Received: from cn.fujitsu.com ([59.151.112.132]:64519 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1037683AbdDUKKz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Apr 2017 06:10:55 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 1/2] ext4: check mount's handling for very large s_first_meta_bg
Date: Fri, 21 Apr 2017 18:10:39 +0800
Message-ID: <1492769440-12413-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On ext4 filesystem, the kernel carshes at mount time when
s_first_meta_bg's value exceeds the largest possible meta_bg
number.  This kernel bug has been fixed in:

3a4b77c ext4: validate s_first_meta_bg at mount time

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/ext4/025     | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/025.out |  4 ++++
 tests/ext4/group   |  1 +
 3 files changed, 74 insertions(+)
 create mode 100755 tests/ext4/025
 create mode 100644 tests/ext4/025.out

diff --git a/tests/ext4/025 b/tests/ext4/025
new file mode 100755
index 0000000..085c52f
--- /dev/null
+++ b/tests/ext4/025
@@ -0,0 +1,69 @@
+#! /bin/bash
+# FS QA Test ext4/025
+#
+# Regression test for commit:
+# 3a4b77c ("ext4: validate s_first_meta_bg at mount time").
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
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	rm -f $tmp.*
+}
+
+# get standard environment and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+_require_scratch
+_require_scratch_nocheck
+_require_command "$DEBUGFS_PROG" debugfs
+_require_ext4_mkfs_feature "bigalloc,meta_bg,^resize_inode"
+
+echo "Create ext4 fs and modify first_meta_bg's value"
+$MKFS_EXT4_PROG -F -b 4096 -O bigalloc,meta_bg,^resize_inode $SCRATCH_DEV 16m >> $seqres.full 2>&1 \
+	|| _notrun "Could not create ext4 filesystem"
+
+$DEBUGFS_PROG -w -R "ssv first_meta_bg 842150400" $SCRATCH_DEV >> $seqres.full 2>&1
+
+# check whether debugfs succeeds to set first_meta_bg to 842150400 or not
+$DEBUGFS_PROG -R "show_super_stats" $SCRATCH_DEV 2>&1 | grep -q "First meta block group:   842150400" \
+	|| _notrun "Could not set first_meta_bg to 842150400 successfully, skip test."
+
+echo "Try to mount a modified ext4 fs"
+_scratch_mount >> $seqres.full 2>&1 || echo "Fail to mount ext4 fs expectedly"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/025.out b/tests/ext4/025.out
new file mode 100644
index 0000000..f9a76bb
--- /dev/null
+++ b/tests/ext4/025.out
@@ -0,0 +1,4 @@
+QA output created by 025
+Create ext4 fs and modify first_meta_bg's value
+Try to mount a modified ext4 fs
+Fail to mount ext4 fs expectedly
diff --git a/tests/ext4/group b/tests/ext4/group
index cac5aa5..c42a4d5 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -27,6 +27,7 @@
 022 auto quick attr dangerous
 023 auto quick scrub
 024 auto quick encrypt dangerous
+025 auto quick dangerous
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
1.8.3.1



