Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:59608 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbcINBzi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Sep 2016 21:55:38 -0400
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH v6 1/6] fstests: common: Introduce _post_mount_hook for btrfs
Date: Wed, 14 Sep 2016 09:55:22 +0800
Message-Id: <20160914015527.10274-2-quwenruo@cn.fujitsu.com>
In-Reply-To: <20160914015527.10274-1-quwenruo@cn.fujitsu.com>
References: <20160914015527.10274-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc: fdmanana@gmail.com, mfasheh@suse.de
List-ID: <fstests@vger.kernel.org>

Introduce _post_mount_hook(), which will be executed after mounting
scratch/test.

It's quite useful for fs(OK, only btrfs yet, again) which needs to
use ioctl other than mount option to enable some of its feature.

Now only btrfs quota needs this hook to allow enabling quota to be
enabled for *ALL* existing test cases.

This should dramatically improve the test coverage to expose quota
related bugs.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 common/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/rc b/common/rc
index 23c007a..631397f 100644
--- a/common/rc
+++ b/common/rc
@@ -321,6 +321,27 @@ _overlay_scratch_unmount()
 	$UMOUNT_PROG $SCRATCH_MNT
 }
 
+_run_btrfs_post_mount_hook()
+{
+	mnt_point=$1
+	for n in $ALWAYS_ENABLE_BTRFS_FEATURE; do
+		if [ $n == "quota" -o $n == "qgroup" ]; then
+			# Quota can be enabled for several times
+			# and won't cause bug
+			_run_btrfs_util_prog quota enable $mnt_point
+		fi
+	done
+}
+
+_post_mount_hook()
+{
+	mnt_point=$1
+
+	if [ $FSTYP == "btrfs" -a -v ALWAYS_ENABLE_BTRFS_FEATURE ]; then
+		_run_btrfs_post_mount_hook $mnt_point
+	fi
+}
+
 _scratch_mount()
 {
     if [ "$FSTYP" == "overlay" ]; then
@@ -328,6 +349,7 @@ _scratch_mount()
         return $?
     fi
     _mount -t $FSTYP `_scratch_mount_options $*`
+    _post_mount_hook $SCRATCH_MNT
 }
 
 _scratch_unmount()
@@ -377,6 +399,7 @@ _test_mount()
     fi
     _test_options mount
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    _post_mount_hook $TEST_DIR
 }
 
 _test_unmount()
-- 
2.7.4



