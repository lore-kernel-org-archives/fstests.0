Received: from mail.cn.fujitsu.com ([183.91.158.132]:50372 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752704AbdIRILf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Sep 2017 04:11:35 -0400
From: Gu Jinxiang <gujx@cn.fujitsu.com>
Subject: [PATCH 2/2] xfstests: Add echo logic to show the information of TEST_FS_MOUNT_OPTS
Date: Mon, 18 Sep 2017 16:11:10 +0800
Message-ID: <1505722270-24648-2-git-send-email-gujx@cn.fujitsu.com>
In-Reply-To: <1505722270-24648-1-git-send-email-gujx@cn.fujitsu.com>
References: <1505722270-24648-1-git-send-email-gujx@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

There is message to show user the scrath mount, but no message to
point TEST_FS_MOUNT_OPTS of test mount.
Add logic to show test mount.

Signed-off-by: Gu Jinxiang <gujx@cn.fujitsu.com>
---
 check     |  1 +
 common/rc | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/check b/check
index f8db3cd..676b16c 100755
--- a/check
+++ b/check
@@ -579,6 +579,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	# print out our test configuration
 	echo "FSTYP         -- `_full_fstyp_details`"
 	echo "PLATFORM      -- `_full_platform_details`"
+	echo "TEST_FS_MOUNT_OPTS -- `_test_mount_options`"
 	if [ ! -z "$SCRATCH_DEV" ]; then
 	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
 	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
diff --git a/common/rc b/common/rc
index eb9c469..1e7fee2 100644
--- a/common/rc
+++ b/common/rc
@@ -312,6 +312,19 @@ _overlay_mount_options()
 	     $OVERLAY_MOUNT_OPTIONS
 }
 
+_test_mount_options()
+{
+	_test_options mount
+
+	if [ "$FSTYP" == "overlay" ]; then
+		echo `_overlay_mount_options`
+		return 0
+	fi
+
+	echo $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* \
+		$TEST_DEV $TEST_DIR
+}
+
 _scratch_mount_options()
 {
 	_scratch_options mount
-- 
1.9.1



