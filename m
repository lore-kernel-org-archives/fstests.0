Received: from cn.fujitsu.com ([59.151.112.132]:19736 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751685AbbFZFVW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 26 Jun 2015 01:21:22 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5Q5Jfpc028850
	for <fstests@vger.kernel.org>; Fri, 26 Jun 2015 13:19:41 +0800
From: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
Subject: [PATCH] btrfs: add a test of replace missing dev in diff raid
Date: Fri, 26 Jun 2015 13:21:03 +0800
Message-ID: <1435296063-10695-1-git-send-email-wangyf-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Test of missing device replace in different raid modes.  This
test requires SCRATCH_DEV_POOL contain 5 same size devices.

This issue has been fixed by Omar's patch:
	Btrfs: RAID 5/6 missing device scrub+replace

Signed-off-by: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
---
 tests/btrfs/095     | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/095.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 96 insertions(+)
 create mode 100755 tests/btrfs/095
 create mode 100644 tests/btrfs/095.out

diff --git a/tests/btrfs/095 b/tests/btrfs/095
new file mode 100755
index 0000000..012c327
--- /dev/null
+++ b/tests/btrfs/095
@@ -0,0 +1,93 @@
+#! /bin/bash
+# FS QA Test No. btrfs/095
+#
+# Test of missing device replace in different raid mode
+#
+# Be sure $SCRATCH_DEV_POOL including 5 devices. And all
+# devices in pool must be in the same size.
+# 
+# To check the fs after replacing a dev, a scrub run is performed.
+#
+# This issue has been fixed by Omar Sandoval's patch:
+# 	Btrfs: RAID 5/6 missing device scrub+replace
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Fujitsu.  All Rights Reserved.
+# Author: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
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
+status=1
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_need_to_be_root
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_scratch_dev_pool 5
+
+rm -f $seqres.full
+
+REPLACE_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $5}'`
+export SCRATCH_DEV_POOL=`echo $SCRATCH_DEV_POOL | awk '{print $1,$2,$3,$4}'`
+
+_test () {
+	export MKFS_OPTIONS="-m $1 -d $1"
+	_scratch_pool_mkfs >>$seqres.full || _fail "mkfs failed"
+	_scratch_mount
+
+	PRUNE_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
+	PRUNE_DEV_ID=`$BTRFS_UTIL_PROG fi show $SCRATCH_MNT | grep $PRUNE_DEV | awk '{print $2}'`
+
+	# dd some data
+	dd if=/dev/urandom of="$SCRATCH_MNT"/file1 bs=1M count=1 \
+ >>$seqres.full 2>&1 || _fail "dd failed"
+	dd if=/dev/urandom of="$SCRATCH_MNT"/file2 bs=1M count=2 \
+ >>$seqres.full 2>&1 || _fail "dd failed"
+	dd if=/dev/urandom of="$SCRATCH_MNT"/file3 bs=1M count=4 \
+ >>$seqres.full 2>&1 || _fail "dd failed"
+
+	# prune the device PRUNE_DEV && remount by degraded mode
+	umount $SCRATCH_MNT
+	dd if=/dev/zero of=$PRUNE_DEV bs=1M count=1 >>$seqres.full 2>&1 \
+ || _fail "dd failed"
+	mount -o degraded $SCRATCH_DEV $SCRATCH_MNT
+
+	# replace the missing dev $PRUNE_DEV with $REPLACE_DEV and scrub it
+	$BTRFS_UTIL_PROG  replace start -B -r $PRUNE_DEV_ID $REPLACE_DEV \
+ $SCRATCH_MNT  -f >>$seqres.full 2>&1 || _fail "replace failed"
+	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1 \
+ || _fail "scrub failed"
+
+	umount $SCRATCH_MNT
+}
+
+_test "raid1"
+_test "raid10"
+_test "raid5"
+_test "raid6"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/095.out b/tests/btrfs/095.out
new file mode 100644
index 0000000..80ad3b9
--- /dev/null
+++ b/tests/btrfs/095.out
@@ -0,0 +1,2 @@
+QA output created by 095
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index ffe18bf..f20a191 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -96,3 +96,4 @@
 092 auto quick send
 093 auto quick clone
 094 auto quick send
+095 auto
-- 
1.9.1

