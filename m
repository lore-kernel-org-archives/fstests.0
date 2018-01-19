Received: from mail.cn.fujitsu.com ([183.91.158.132]:50661 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751026AbeASFq4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Jan 2018 00:46:56 -0500
From: xiao yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v6 3/3] xfs: Regression test for invalid sb_logsunit
Date: Fri, 19 Jan 2018 13:38:06 +0800
Message-ID: <1516340286-21331-2-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1516340286-21331-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180118182915.GI5606@magnolia>
 <1516340286-21331-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: darrick.wong@oracle.com, eguan@redhat.com
Cc: david@fromorbit.com, bfoster@redhat.com, fstests@vger.kernel.org, xiao yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

If log stripe unit isn't a multiple of the fs blocksize and mounting,
the invalid sb_logsunit leads to crash as soon as we try to write to
the log.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/439     | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/439.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 89 insertions(+)
 create mode 100755 tests/xfs/439
 create mode 100644 tests/xfs/439.out

diff --git a/tests/xfs/439 b/tests/xfs/439
new file mode 100755
index 0000000..dbf654a
--- /dev/null
+++ b/tests/xfs/439
@@ -0,0 +1,86 @@
+#! /bin/bash
+# FS QA Test No. 439
+#
+# Regression test for commit:
+# 9c92ee2 ("xfs: validate sb_logsunit is a multiple of the fs blocksize")
+#
+# If log stripe unit isn't a multiple of the fs blocksize and mounting,
+# the invalid sb_logsunit leads to crash as soon as we try to write to
+# the log.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 FUJITSU.  All Rights Reserved.
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
+seq=`basename "$0"`
+seqres="$RESULT_DIR/$seq"
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
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs xfs
+_require_scratch
+# We corrupt XFS on purpose, and check if assert failures would crash system.
+_require_no_xfs_bug_on_assert
+
+rm -f "$seqres.full"
+
+# Format
+_scratch_mkfs > $seqres.full 2>&1 || _fail "mkfs failed"
+
+# Set logsunit to a value which is not a multiple of the fs blocksize
+blksz=$(_scratch_xfs_get_sb_field blocksize)
+_scratch_xfs_set_sb_field logsunit $((blksz - 1)) >> $seqres.full 2>&1
+
+# Check if logsunit is set correctly
+lsunit=$(_scratch_xfs_get_sb_field logsunit)
+[ $lsunit -ne $((blksz - 1)) ] && _notrun "failed to set sb_logsunit"
+
+# Mount and writing log may trigger a crash on buggy kernel
+# The fix applied kernel refuses to mount, so a mount failure is
+# expected
+if _scratch_mount >> $seqres.full 2>&1; then
+	for i in $(seq 1 1000); do
+		echo > ${SCRATCH_MNT}/$i
+	done
+	_scratch_unmount
+fi
+
+# We may trigger assert related WARNINGs if we corrupt log on a
+# CONFIG_XFS_WARN or CONFIG_XFS_DEBUG (CONFIG_XFS_ASSERT_FATAL is 
+# disabled) build, so filter them.
+_check_dmesg _filter_assert_dmesg
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/439.out b/tests/xfs/439.out
new file mode 100644
index 0000000..9712295
--- /dev/null
+++ b/tests/xfs/439.out
@@ -0,0 +1,2 @@
+QA output created by 439
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index 04a63b7..0b281a8 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -436,3 +436,4 @@
 436 auto quick clone fsr
 437 auto quick other
 438 auto quick quota dangerous
+439 auto quick dangerous_fuzzers log
-- 
1.8.3.1



