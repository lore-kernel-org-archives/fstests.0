Received: from aserp1040.oracle.com ([141.146.126.69]:26273 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbdJPRx0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Oct 2017 13:53:26 -0400
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH v2 RESEND] Fstest: btrfs/151: test if device delete ends up with losing raid profile
Date: Mon, 16 Oct 2017 10:51:20 -0600
Message-Id: <20171016165120.11304-1-bo.li.liu@oracle.com>
In-Reply-To: <20171009173921.12569-1-bo.li.liu@oracle.com>
References: <20171009173921.12569-1-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Currently running 'btrfs device delete' can end up with losing data raid
profile (if any), this test is to reproduce the problem.

The fix is
     "Btrfs: avoid losing data raid profile when deleting a device"

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---

v2: - Add _require_btrfs_dev_del_by_devid and limit the test to use only 3 devices.
    - Avoid storing output in local variables which could end up subtle problems.
    - Use tee instead of running 'btrfs fi df' twice.

 tests/btrfs/151     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/151.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 83 insertions(+)
 create mode 100755 tests/btrfs/151
 create mode 100644 tests/btrfs/151.out

diff --git a/tests/btrfs/151 b/tests/btrfs/151
new file mode 100755
index 0000000..40b248c
--- /dev/null
+++ b/tests/btrfs/151
@@ -0,0 +1,80 @@
+#! /bin/bash
+# FS QA Test 151
+#
+# Test if it's losing data chunk's raid profile after 'btrfs device
+# remove'.
+#
+# The fix is
+#	Btrfs: avoid losing data raid profile when deleting a device
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Oracle.  All Rights Reserved.
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
+_require_scratch_dev_pool 3
+_require_btrfs_dev_del_by_devid
+
+# We need exactly 3 disks to form a fixed stripe layout for this test.
+_scratch_dev_pool_get 3
+
+# create raid1 for data
+_scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
+
+# we need an empty data chunk, so nospace_cache is required.
+_scratch_mount -onospace_cache
+
+# if data chunk is empty, 'btrfs device remove' can change raid1 to
+# single.
+$BTRFS_UTIL_PROG device delete 2 $SCRATCH_MNT >> $seqres.full 2>&1
+
+# save btrfs filesystem df output for debug purpose
+$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT 2>&1 | \
+    tee -a $seqres.full | $AWK_PROG -F ':' '/Data,/ {print $1}'
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/151.out b/tests/btrfs/151.out
new file mode 100644
index 0000000..0a1de06
--- /dev/null
+++ b/tests/btrfs/151.out
@@ -0,0 +1,2 @@
+QA output created by 151
+Data, RAID1
diff --git a/tests/btrfs/group b/tests/btrfs/group
index e73bb1b..a7ff7b0 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -153,3 +153,4 @@
 148 auto quick rw
 149 auto quick send compress
 150 auto quick dangerous
+151 auto quick
-- 
2.5.0

