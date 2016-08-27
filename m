Received: from mx1.redhat.com ([209.132.183.28]:50732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754676AbcH0P2h (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 27 Aug 2016 11:28:37 -0400
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] fstests: test xfs rw remount with unknown ro-compat features
Date: Sat, 27 Aug 2016 23:28:33 +0800
Message-Id: <1472311713-12992-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

Although ro-compat features cannot be mounted rw, a bug allows
an ro->rw remount transition, and this will corrupt the filesystem
if it contains ro-compat features unknown to the running kernel.

This bug has been fix on linux kernel (d0a58e8 xfs: disallow rw
remount on fs with unknown ro-compat features), this case is
the regression testcase of that bug.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

V2 fix some mistakes of golden image(.out) file.

Thanks,
Zorro

 tests/xfs/263     | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/263.out |  6 ++++
 tests/xfs/group   |  1 +
 3 files changed, 106 insertions(+)
 create mode 100755 tests/xfs/263
 create mode 100644 tests/xfs/263.out

diff --git a/tests/xfs/263 b/tests/xfs/263
new file mode 100755
index 0000000..a46e250
--- /dev/null
+++ b/tests/xfs/263
@@ -0,0 +1,99 @@
+#! /bin/bash
+# FS QA Test 263
+#
+# Test upstream d0a58e8:
+#   xfs: disallow rw remount on fs with unknown ro-compat features
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+	# Due to we've broken the superblock of SCRATCH_DEV by
+	# xfs_db, so clean bad superblock at the end
+	_scratch_unmount
+	_scratch_mkfs >/dev/null 2>&1
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
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_xfs_crc
+
+# Only V5 XFS disallow rw mount/remount with unknown ro-compat
+# features
+MKFS_OPTIONS="-m crc=1"
+_scratch_mkfs_xfs >>$seqres.full 2>&1
+
+# set the highest bit of features_ro_compat, use it as an unknown
+# feature bit. If one day this bit become known feature, please
+# change this case.
+$XFS_DB_PROG -x -c "sb 0" \
+                -c "write features_ro_compat $((2**31))" \
+		$SCRATCH_DEV
+
+echo "rw mount test"
+# Maybe this mount will fail by bad superblock
+# But keep testing this anyway
+MOUNT_OPTIONS="-o rw"
+_scratch_mount 2>>$seqres.full
+if [ $? -eq 0 ]; then
+	_fail "rw mount test failed"
+fi
+
+echo "ro mount test"
+MOUNT_OPTIONS="-o ro"
+_scratch_mount
+if [ $? -ne 0 ]; then
+	_fail "ro mount test failed"
+else
+	# no hang/panic is fine
+	$FSSTRESS_PROG -d $SCRATCH_MNT -p 4 -n 400 >>$seqres.full 2>&1
+fi
+
+dmesg -c >/dev/null
+echo "rw remount test"
+MOUNT_OPTIONS="-o rw,remount"
+_scratch_mount 2>>$seqres.full
+if [ $? -eq 0 ]; then
+	_fail "rw,remount test failed"
+fi
+dmesg -c | sed -n -e "s/.*XFS.*: \(ro->rw transition prohibited.*\)/\1/p"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/263.out b/tests/xfs/263.out
new file mode 100644
index 0000000..440ed32
--- /dev/null
+++ b/tests/xfs/263.out
@@ -0,0 +1,6 @@
+QA output created by 263
+features_ro_compat = 0x80000000
+rw mount test
+ro mount test
+rw remount test
+ro->rw transition prohibited on unknown (0x80000000) ro-compat filesystem
diff --git a/tests/xfs/group b/tests/xfs/group
index 6905a62..ec3c022 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -260,6 +260,7 @@
 260 auto quick quota
 261 auto quick quota
 262 auto quick quota
+263 auto quick mount
 265 auto clone
 266 dump ioctl auto quick
 267 dump ioctl tape
-- 
2.7.4

