Received: from mail.cn.fujitsu.com ([183.91.158.132]:27829 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752660AbdK2MCj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Nov 2017 07:02:39 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 1477B487F179
        for <fstests@vger.kernel.org>; Wed, 29 Nov 2017 20:02:34 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/473: test return EBUSY from BLKRRPART for mounted whole-dev
Date: Wed, 29 Nov 2017 20:02:26 +0800
Message-ID: <1511956946-16667-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

If the entire block device is formatted with a filesystem and
mounted, running "blockdev --rereadpt" should fail and return
EBUSY instead of pass.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/473     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/473.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/generic/473
 create mode 100644 tests/generic/473.out

diff --git a/tests/generic/473 b/tests/generic/473
new file mode 100755
index 0000000..d7998cd
--- /dev/null
+++ b/tests/generic/473
@@ -0,0 +1,83 @@
+#! /bin/bash
+# FS QA Test No. 473
+#
+# Regression test for commit:
+# 77032ca ("Return EBUSY from BLKRRPART for mounted whole-dev fs")
+#
+# If the entire block device is formatted with a filesystem and
+# mounted, running "blockdev --rereadpt" should fail and return
+# EBUSY.  On buggy kernel, it passes unexpectedly.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
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
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmpdir=`mktemp -d`
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 7 15
+
+_cleanup()
+{
+	# Umount
+	$UMOUNT_PROG $tmpdir >>$seqres.full 2>&1
+	# Destroy device
+        _put_scsi_debug_dev
+	rm -rf $tmpdir
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/scsi_debug
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_os Linux
+_require_scsi_debug
+
+# Create and format
+test_dev=`_get_scsi_debug_dev`
+_mkfs_dev $test_dev >>$seqres.full 2>&1
+
+# Mount and check mounted whole-dev
+_mount $test_dev $tmpdir
+
+out=$(blockdev --rereadpt $test_dev 2>&1)
+res=$?
+
+echo $out | grep -q "Unknown command" && \
+	_notrun "blockdev --rereadpt was not supported"
+
+[ $res -eq 0 ] && _fail "blockdev --rereadpt passed when checking mounted whole-dev"
+
+echo $out | grep -q "Device or resource busy" || \
+	_fail "blockdev --rereadpt returned unexpected error when checking mounted whole-dev"
+
+echo $out >> $seqres.full
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/473.out b/tests/generic/473.out
new file mode 100644
index 0000000..854fbcd
--- /dev/null
+++ b/tests/generic/473.out
@@ -0,0 +1,2 @@
+QA output created by 473
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 6c3bb03..54b9404 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -472,3 +472,4 @@
 467 auto quick exportfs
 468 shutdown auto quick metadata
 469 auto quick
+473 auto quick blockdev
-- 
1.8.3.1



