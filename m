Received: from cn.fujitsu.com ([222.73.24.84]:39199 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbcLHINB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Dec 2016 03:13:01 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH v2 2/2] fstests: btrfs: Use _require_btrfs_qgroup_report to replace open code
Date: Thu,  8 Dec 2016 16:12:13 +0800
Message-Id: <20161208081213.19675-2-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161208081213.19675-1-quwenruo@cn.fujitsu.com>
References: <20161208081213.19675-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Introduce new _require_btrfs_qgroup_report function, which will check
the accessibility to "btrfs check --qgroup-report", then set a global
flag to info _check_scratch_fs() to do extra qgroup check.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
v2:
  Use "${RESULT_DIR}/require_scratch.require_qgroup_report" instead of
  global variant
  Rebased to latest master
  Replace btrfsck with $BTRFS_UTIL_PROG check.
---
 check           |  4 ++--
 common/btrfs    | 22 +++++++++++++++++++++-
 common/rc       |  5 +++--
 tests/btrfs/022 |  4 ++++
 tests/btrfs/028 |  5 ++---
 tests/btrfs/042 |  6 ++----
 tests/btrfs/099 |  1 +
 tests/btrfs/104 | 20 +++++---------------
 tests/btrfs/122 |  9 +++------
 tests/btrfs/123 |  5 ++---
 tests/btrfs/126 |  1 +
 11 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/check b/check
index 8f2a1bb..76eb054 100755
--- a/check
+++ b/check
@@ -405,11 +405,11 @@ _check_filesystems()
 {
 	if [ -f ${RESULT_DIR}/require_test ]; then
 		_check_test_fs || err=true
-		rm -f ${RESULT_DIR}/require_test
+		rm -f ${RESULT_DIR}/require_test*
 	fi
 	if [ -f ${RESULT_DIR}/require_scratch ]; then
 		_check_scratch_fs || err=true
-		rm -f ${RESULT_DIR}/require_scratch
+		rm -f ${RESULT_DIR}/require_scratch*
 	fi
 }
 
diff --git a/common/btrfs b/common/btrfs
index 302edc6..a860228 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -40,6 +40,13 @@ _require_btrfs_command()
 	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd $param)"
 }
 
+# Require extra check on btrfs qgroup numbers
+_require_btrfs_qgroup_report()
+{
+	_require_btrfs_command check --qgroup-report
+	touch ${RESULT_DIR}/require_scratch.require_qgroup_report
+}
+
 _run_btrfs_util_prog()
 {
 	run_check $BTRFS_UTIL_PROG $*
@@ -97,7 +104,20 @@ _check_btrfs_filesystem()
 		mountpoint=`_umount_or_remount_ro $device`
 	fi
 
-	btrfsck $device >$tmp.fsck 2>&1
+	if [ -f ${RESULT_DIR}/require_scratch.require_qgroup_report ]; then
+		$BTRFS_UTIL_PROG check $device --qgroup-report > $tmp.qgroup_report 2>&1
+		if grep -qE "Counts for qgroup.*are different" $tmp.qgroup_report ; then
+			echo "_check_btrfs_filesystem: filesystem on $device has wrong qgroup numbers (see $seqres.full)"
+			echo "_check_btrfs_filesystem: filesystem on $device has wrong qgroup numbers" \
+				>> $seqres.full
+			echo "*** qgroup_report.$FSTYP output ***"	>>$seqres.full
+			cat $tmp.qgroup_report				>>$seqres.full
+			echo "*** qgroup_report.$FSTYP output ***"	>>$seqres.full
+		fi
+		rm -f $tmp.qgroup_report
+	fi
+
+	$BTRFS_UTIL_PROG check $device >$tmp.fsck 2>&1
 	if [ $? -ne 0 ]; then
 		echo "_check_btrfs_filesystem: filesystem on $device is inconsistent (see $seqres.full)"
 
diff --git a/common/rc b/common/rc
index 2719b23..b50283c 100644
--- a/common/rc
+++ b/common/rc
@@ -1222,8 +1222,9 @@ _notrun()
 {
     echo "$*" > $seqres.notrun
     echo "$seq not run: $*"
-    rm -f ${RESULT_DIR}/require_test
-    rm -f ${RESULT_DIR}/require_scratch
+    rm -f ${RESULT_DIR}/require_test*
+    rm -f ${RESULT_DIR}/require_scratch*
+
     status=0
     exit
 }
diff --git a/tests/btrfs/022 b/tests/btrfs/022
index 56d4f3d..9abad6c 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -43,6 +43,7 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 rm -f $seqres.full
 
@@ -125,16 +126,19 @@ _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _basic_test
 _scratch_unmount
+_check_scratch_fs
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _rescan_test
 _scratch_unmount
+_check_scratch_fs
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _limit_test_exceed
 _scratch_unmount
+_check_scratch_fs
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
diff --git a/tests/btrfs/028 b/tests/btrfs/028
index 1425609..a3d9a27 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -51,6 +51,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 _scratch_mkfs
 _scratch_mount
@@ -86,9 +87,7 @@ _run_btrfs_util_prog filesystem sync $SCRATCH_MNT
 
 _scratch_unmount
 
-# generate a qgroup report and look for inconsistent groups
-$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 | \
-	grep -E "Counts for qgroup.*are different"
+# qgroup will be checked at _check_scratch_fs() by fstest.
 echo "Silence is golden"
 status=0
 
diff --git a/tests/btrfs/042 b/tests/btrfs/042
index 498ccc9..dc9b762 100755
--- a/tests/btrfs/042
+++ b/tests/btrfs/042
@@ -43,6 +43,7 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 rm -f $seqres.full
 
@@ -84,10 +85,7 @@ for i in `seq 10 -1 1`; do
 	total_written=$(($total_written+$filesize))
 done
 
-#check if total written exceeds limit
-if [ $total_written -gt $LIMIT_SIZE ];then
-	_fail "total written should be less than $LIMIT_SIZE"
-fi
+# qgroup will be checked automatically at _check_scratch_fs() by fstest
 
 # success, all done
 echo "Silence is golden"
diff --git a/tests/btrfs/099 b/tests/btrfs/099
index 70f07b5..65ea79b 100755
--- a/tests/btrfs/099
+++ b/tests/btrfs/099
@@ -46,6 +46,7 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 # Use big blocksize to ensure there is still enough space left for metadata
 # space reserve.
diff --git a/tests/btrfs/104 b/tests/btrfs/104
index 6afaa02..e6a6d3b 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -58,6 +58,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 rm -f $seqres.full
 
@@ -145,21 +146,10 @@ _scratch_cycle_mount
 # referenced above.
 _run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap1
 
-# There is no way from userspace to force btrfs_drop_snapshot to run
-# at a given time (even via mount/unmount). We must wait for it to
-# start and complete. This is the shortest time on my tests systems I
-# have found which always allows drop_snapshot to run to completion.
-sleep 45
+# "btrfs filesystem sync" will trigger subvolume deletion
+_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
 
-_scratch_unmount
-
-# generate a qgroup report and look for inconsistent groups
-#  - don't use _run_btrfs_util_prog here as it captures the output and
-#    we need to grep it.
-$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 | \
-			grep -E -q "Counts for qgroup.*are different"
-if [ $? -ne 0 ]; then
-	status=0
-fi
+# Qgroup will be checked by fstest at _check_scratch_fs()
 
+status=0
 exit
diff --git a/tests/btrfs/122 b/tests/btrfs/122
index 82252ab..6a7f17f 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -49,6 +49,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 rm -f $seqres.full
 
@@ -78,11 +79,7 @@ _run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/snap2"
 
 _scratch_unmount
 
-# generate a qgroup report and look for inconsistent groups
-$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 | \
-			grep -q -E "Counts for qgroup.*are different"
-if [ $? -ne 0 ]; then
-	status=0
-fi
 
+# qgroup will be checked by fstest at _check_scratch_fs()
+status=0
 exit
diff --git a/tests/btrfs/123 b/tests/btrfs/123
index e89d541..52d87fb 100755
--- a/tests/btrfs/123
+++ b/tests/btrfs/123
@@ -53,6 +53,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 _scratch_mkfs
 # Need to use inline extents to fill metadata rapidly
@@ -76,9 +77,7 @@ _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
 _run_btrfs_util_prog balance start -d $SCRATCH_MNT
 
 _scratch_unmount
-# generate a qgroup report and look for inconsistent groups
-$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 | \
-		grep -E "Counts for qgroup.*are different"
+# qgroup will be check at _check_scratch_fs() by fstest
 
 # success, all done
 status=0
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index cc51f4a..c06c00b 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -49,6 +49,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 _scratch_mkfs
 # Use enospc_debug mount option to trigger restrict space info check
-- 
2.7.4



