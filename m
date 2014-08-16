Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:36731 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbaHPNNc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 16 Aug 2014 09:13:32 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 1/6] common: add _mkfs_dev helper
Date: Sat, 16 Aug 2014 17:13:06 +0400
Message-Id: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

It is not good practice to directly use MKFS_PROG.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 common/rc        |   28 ++++++++++++++++++++++++++++
 tests/btrfs/020  |    4 ++--
 tests/shared/298 |    4 ++--
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 16da898..84fef35 100644
--- a/common/rc
+++ b/common/rc
@@ -509,6 +509,34 @@ _test_mkfs()
     esac
 }
 
+_mkfs_dev()
+{
+    case $FSTYP in
+    nfs*)
+	# do nothing for nfs
+	;;
+    udf)
+        $MKFS_UDF_PROG $MKFS_OPTIONS $* 2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
+	;;
+    btrfs)
+        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* 2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
+	;;
+    *)
+	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
+		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
+	;;
+    esac
+
+    if [ $? -ne 0 ]; then
+	# output stored mkfs output
+	cat $tmp_dir.mkfserr >&2
+	cat $tmp_dir.mkfsstd
+	status=1
+	exit 1
+    fi
+    rm -f $tmp_dir.mkfserr $tmp_dir.mkfsstd
+}
+
 _scratch_mkfs()
 {
     case $FSTYP in
diff --git a/tests/btrfs/020 b/tests/btrfs/020
index 5a928dd..84251f3 100755
--- a/tests/btrfs/020
+++ b/tests/btrfs/020
@@ -73,8 +73,8 @@ loop_dev1=`_create_loop_device $fs_img1`
 loop_dev2=`_create_loop_device $fs_img2`
 loop_dev3=`_create_loop_device $fs_img3`
 
-$MKFS_BTRFS_PROG -m raid1 -d raid1 $loop_dev1 $loop_dev2 >>$seqres.full 2>&1
-$MOUNT_PROG -o ro $loop_dev1 $loop_mnt
+_mkfs_dev -m raid1 -d raid1 $loop_dev1 $loop_dev2 >>$seqres.full 2>&1
+_mount -o ro $loop_dev1 $loop_mnt
 
 # Fail the second device and replace with the third
 _destroy_loop_device $loop_dev2
diff --git a/tests/shared/298 b/tests/shared/298
index 372fd02..2b7fdd1 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -134,8 +134,8 @@ mkdir $loop_mnt
 
 [ "$FSTYP" = "xfs" ] && MKFS_OPTIONS="-f $MKFS_OPTIONS"
 
-$MKFS_PROG -t $FSTYP $MKFS_OPTIONS $loop_dev &> /dev/null
-$MOUNT_PROG $loop_dev $loop_mnt
+_mkfs_dev $loop_dev
+_mount $loop_dev $loop_mnt
 
 echo -n "Generating garbage on loop..."
 # Goal is to fill it up, ignore any errors.
-- 
1.7.1

