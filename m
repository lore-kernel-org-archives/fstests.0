Return-Path: <fstests-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:33357 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbbEYUaL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 25 May 2015 16:30:11 -0400
From: Matthew Wilcox <matthew.r.wilcox@intel.com>
Subject: [PATCH] Fix sysfs paths for partitions
Date: Mon, 25 May 2015 16:29:58 -0400
Message-Id: <1432585798-3630-1-git-send-email-matthew.r.wilcox@intel.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Matthew Wilcox <willy@linux.intel.com>
List-ID: <fstests@vger.kernel.org>

From: Matthew Wilcox <willy@linux.intel.com>

generic/019 was failing with:

./tests/generic/019: line 65: /sys/block/pmem0p2/make-it-fail: No such file or directory

When using a partition, the file needed is located at
/sys/block/pmem0/pmem0p2/make-it-fail.

Rather than attempt to deduce whether a block device is a partition
or not, use the symlinks located in /sys/dev/block/ to find the right
location for the make-it-fail file.

Also change btrfs/088 to use the new _sysfs_dev function.

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
---
 common/rc         | 10 ++++++++++
 tests/btrfs/088   |  6 +++---
 tests/generic/019 | 12 +++++-------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/common/rc b/common/rc
index 6ea107e..90463f6 100644
--- a/common/rc
+++ b/common/rc
@@ -2995,6 +2995,16 @@ _short_dev()
 	echo `basename $(_real_dev $1)`
 }
 
+_sysfs_dev()
+{
+	local _dev=$1
+	local _maj=$(stat -c%t $_dev | tr [:lower:] [:upper:])
+	local _min=$(stat -c%T $_dev | tr [:lower:] [:upper:])
+	_maj=$(echo "ibase=16; $_maj" | bc)
+	_min=$(echo "ibase=16; $_min" | bc)
+	echo /sys/dev/block/$_maj:$_min
+}
+
 get_block_size()
 {
 	if [ -z $1 ] || [ ! -d $1 ]; then
diff --git a/tests/btrfs/088 b/tests/btrfs/088
index 8206ecc..ca11c25 100755
--- a/tests/btrfs/088
+++ b/tests/btrfs/088
@@ -53,19 +53,19 @@ _require_scratch
 _require_fail_make_request
 _need_to_be_root
 
-SCRATCH_BDEV=`_short_dev $SCRATCH_DEV`
+SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
 
 enable_io_failure()
 {
 	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
 	echo 1000 > $DEBUGFS_MNT/fail_make_request/times
 	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
-	echo 1 > /sys/block/$SCRATCH_BDEV/make-it-fail
+	echo 1 > $SYSFS_BDEV/make-it-fail
 }
 
 disable_io_failure()
 {
-	echo 0 > /sys/block/$SCRATCH_BDEV/make-it-fail
+	echo 0 > $SYSFS_BDEV/make-it-fail
 	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
 	echo 0 > $DEBUGFS_MNT/fail_make_request/times
 }
diff --git a/tests/generic/019 b/tests/generic/019
index b387507..ca196ca 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -41,7 +41,7 @@ _need_to_be_root
 _require_scratch
 _require_fail_make_request
 
-SCRATCH_BDEV=`_short_dev $SCRATCH_DEV`
+SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
 
 allow_fail_make_request()
 {
@@ -61,17 +61,15 @@ disallow_fail_make_request()
 start_fail_scratch_dev()
 {
     echo "Force SCRATCH_DEV device failure"
-    echo " echo 1 > /sys/block/$SCRATCH_BDEV/make-it-fail" >> $seqres.full
-    echo 1 > /sys/block/$SCRATCH_BDEV/make-it-fail
-
+    echo " echo 1 > $SYSFS_BDEV/make-it-fail" >> $seqres.full
+    echo 1 > $SYSFS_BDEV/make-it-fail
 }
 
 stop_fail_scratch_dev()
 {
     echo "Make SCRATCH_DEV device operable again"
-    echo " echo 0 > /sys/block/$SCRATCH_BDEV/make-it-fail" >> $seqres.full
-    echo 0 > /sys/block/$SCRATCH_BDEV/make-it-fail
-
+    echo " echo 0 > $SYSFS_BDEV/make-it-fail" >> $seqres.full
+    echo 0 > $SYSFS_BDEV/make-it-fail
 }
 
 _cleanup()
-- 
2.1.4

