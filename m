Received: from cn.fujitsu.com ([222.73.24.84]:54338 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1753460AbcLHCHL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Dec 2016 21:07:11 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 2/2] fstests: btrfs: Use _require_btrfs_qgroup_report to replace open code
Date: Thu,  8 Dec 2016 10:04:56 +0800
Message-Id: <20161208020456.16116-2-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161208020456.16116-1-quwenruo@cn.fujitsu.com>
References: <20161208020456.16116-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Introduce new _require_btrfs_qgroup_report function, which will check
the accessibility to "btrfs check --qgroup-report", then set a global
flag to info _check_scratch_fs() to do extra qgroup check.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 common/rc       | 22 ++++++++++++++++++++++
 tests/btrfs/022 |  5 +++++
 tests/btrfs/028 |  5 ++---
 tests/btrfs/042 |  6 ++----
 tests/btrfs/099 |  1 +
 tests/btrfs/104 | 20 +++++---------------
 tests/btrfs/122 | 10 +++-------
 tests/btrfs/123 |  5 ++---
 8 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/common/rc b/common/rc
index 1703232..bce3a09 100644
--- a/common/rc
+++ b/common/rc
@@ -2624,6 +2624,20 @@ _check_btrfs_filesystem()
         mountpoint=`_umount_or_remount_ro $device`
     fi
 
+    # Check qgroup numbers
+    if [ "$BTRFS_NEED_QGROUP_REPORT" == "yes" ];then
+	    btrfsck $device --qgroup-report > $tmp.qgroup_report 2>&1
+	    if grep -qE "Counts for qgroup.*are different" $tmp.qgroup_report ; then
+	        echo "_check_btrfs_filesystem: filesystem on $device has wrong qgroup numbers (see $seqres.full)"
+	        echo "_check_btrfs_filesystem: filesystem on $device has wrong qgroup numbers" \
+			>> $seqres.full
+		echo "*** qgroup_report.$FSTYP output ***"	>>$seqres.full
+		cat $tmp.qgroup_report				>>$seqres.full
+		echo "*** qgroup_report.$FSTYP output ***"	>>$seqres.full
+            fi
+    fi
+    rm -f $tmp.qgroup_report
+
     btrfsck $device >$tmp.fsck 2>&1
     if [ $? -ne 0 ]
     then
@@ -3049,6 +3063,14 @@ _require_btrfs_subcommand()
 	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd $param)"
 }
 
+# Require "btrfs check --qgroup-report" fucntion and will check the qgroup
+# numbers at _check_scratch_fs()
+_require_btrfs_qgroup_report()
+{
+	_require_btrfs_subcommand check --qgroup-report
+	export BTRFS_NEED_QGROUP_REPORT="yes"
+}
+
 # Check that fio is present, and it is able to execute given jobfile
 _require_fio()
 {
diff --git a/tests/btrfs/022 b/tests/btrfs/022
index 56d4f3d..2f21a78 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -43,6 +43,7 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 rm -f $seqres.full
 
@@ -125,20 +126,24 @@ _scratch_mkfs > /dev/null 2>&1
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
 _limit_test_noexceed
+_check_scratch_fs
 
 # success, all done
 echo "Silence is golden"
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
index 82252ab..212571f 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -49,6 +49,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
+_require_btrfs_qgroup_report
 
 rm -f $seqres.full
 
@@ -78,11 +79,6 @@ _run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/snap2"
 
 _scratch_unmount
 
-# generate a qgroup report and look for inconsistent groups
-$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 | \
-			grep -q -E "Counts for qgroup.*are different"
-if [ $? -ne 0 ]; then
-	status=0
-fi
-
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
-- 
2.7.4



