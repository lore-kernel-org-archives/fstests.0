Received: from mail.cn.fujitsu.com ([183.91.158.132]:50372 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752125AbdIRILd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Sep 2017 04:11:33 -0400
From: Gu Jinxiang <gujx@cn.fujitsu.com>
Subject: [PATCH 1/2] xfstests: Split MOUNT_OPTIONS to TEST_FS_MOUNT_OPTS and MOUNT_OPTIONS
Date: Mon, 18 Sep 2017 16:11:09 +0800
Message-ID: <1505722270-24648-1-git-send-email-gujx@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Resovle the inconsistent of mount option.
Btrfs use MOUNT_OPTIONS for both scrath_dev and test_dev. Change to
MOUNT_OPTIONS for scratch mount, and TEST_FS_MOUNT_OPTS for test dev
mount.

Signed-off-by: Gu Jinxiang <gujx@cn.fujitsu.com>
---
As mentioned by https://patchwork.kernel.org/patch/9742039/, the usage
of MOUNT_OPTIONS is inconsistent.

 common/btrfs | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 common/rc    |  2 +-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index fd762ef..2a1cfaf 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -89,6 +89,62 @@ _require_btrfs_fs_feature()
 		_notrun "Feature $feat not supported by the available btrfs version"
 }
 
+_check_test_btrfs_filesystem()
+{
+	device=$1
+
+	# If type is set, we're mounted
+	type=`_fs_type $device`
+	ok=1
+
+	if [ "$type" = "$FSTYP" ]; then
+		# mounted ...
+		mountpoint=`_umount_or_remount_ro $device`
+	fi
+
+	if [ -f ${RESULT_DIR}/require_scratch.require_qgroup_report ]; then
+		$BTRFS_UTIL_PROG check $device --qgroup-report > $tmp.qgroup_report 2>&1
+		if grep -qE "Counts for qgroup.*are different" $tmp.qgroup_report ; then
+			_log_err "_check_btrfs_filesystem: filesystem on $device has wrong qgroup numbers"
+			echo "*** qgroup_report.$FSTYP output ***"	>>$seqres.full
+			cat $tmp.qgroup_report				>>$seqres.full
+			echo "*** qgroup_report.$FSTYP output ***"	>>$seqres.full
+		fi
+		rm -f $tmp.qgroup_report
+	fi
+
+	$BTRFS_UTIL_PROG check $device >$tmp.fsck 2>&1
+	if [ $? -ne 0 ]; then
+		_log_err "_check_btrfs_filesystem: filesystem on $device is inconsistent"
+		echo "*** fsck.$FSTYP output ***"	>>$seqres.full
+		cat $tmp.fsck				>>$seqres.full
+		echo "*** end fsck.$FSTYP output"	>>$seqres.full
+
+		ok=0
+	fi
+	rm -f $tmp.fsck
+
+	if [ $ok -eq 0 ]; then
+		echo "*** mount output ***"		>>$seqres.full
+		_mount					>>$seqres.full
+		echo "*** end mount output"		>>$seqres.full
+	elif [ "$type" = "$FSTYP" ]; then
+		# was mounted ...
+		_mount_or_remount_rw "$TEST_FS_MOUNT_OPTS" $device $mountpoint
+		ok=$?
+	fi
+
+	if [ $ok -eq 0 ]; then
+		status=1
+		if [ "$iam" != "check" ]; then
+			exit 1
+		fi
+		return 1
+	fi
+
+	return 0
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1
diff --git a/common/rc b/common/rc
index cd53a37..eb9c469 100644
--- a/common/rc
+++ b/common/rc
@@ -2624,7 +2624,7 @@ _check_test_fs()
 	# do nothing for now
 	;;
     btrfs)
-	_check_btrfs_filesystem $TEST_DEV
+	_check_test_btrfs_filesystem $TEST_DEV
 	;;
     tmpfs)
 	# no way to check consistency for tmpfs
-- 
1.9.1



