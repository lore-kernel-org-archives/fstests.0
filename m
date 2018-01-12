Received: from mail.cn.fujitsu.com ([183.91.158.132]:36910 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750703AbeALGU0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Jan 2018 01:20:26 -0500
From: xiao yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 2/2] xfs: Regression test for invalid sb_logsunit
Date: Fri, 12 Jan 2018 14:16:23 +0800
Message-ID: <1515737783-2061-2-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1515737783-2061-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180111180734.GD1168@magnolia>
 <1515737783-2061-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, eguan@redhat.com, xiao yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

If log stripe unit isn't a multiple of the fs blocksize and mounting,
the invalid sb_logsunit leads to crash as soon as we try to write to
the log.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/437     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/437.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/xfs/437
 create mode 100644 tests/xfs/437.out

diff --git a/tests/xfs/437 b/tests/xfs/437
new file mode 100755
index 0000000..f2b84ad
--- /dev/null
+++ b/tests/xfs/437
@@ -0,0 +1,73 @@
+#! /bin/bash
+# FS QA Test No. 437
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
+# get standard environment and checks
+. ./common/rc
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs xfs
+_require_scratch
+
+rm -f "$seqres.full"
+
+# Format
+_scratch_mkfs > $seqres.full 2>&1 || _fail "mkfs failed"
+
+# Set logsunit to a value which is not a multiple of the fs blocksize
+blksz=$(_scratch_xfs_get_sb_field blocksize)
+_scratch_xfs_set_sb_field logsunit $((blksz - 1)) >> $seqres.full 2>&1 \
+	|| _notrun "failed to set sb_logsunit"
+
+# Mount and writing log may trigger a crash
+if _scratch_mount >> $seqres.full 2>&1; then
+	for i in $(seq 1 1000); do
+		touch ${SCRATCH_MNT}/$i
+	done
+	_scratch_unmount
+fi
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/437.out b/tests/xfs/437.out
new file mode 100644
index 0000000..4dcb607
--- /dev/null
+++ b/tests/xfs/437.out
@@ -0,0 +1,2 @@
+QA output created by 437
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index d230060..35d1b03 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -434,3 +434,4 @@
 434 auto quick clone fsr
 435 auto quick clone
 436 auto quick clone fsr
+437 auto quick log dangerous
-- 
1.8.3.1



