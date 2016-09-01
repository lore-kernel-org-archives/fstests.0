Received: from mx1.redhat.com ([209.132.183.28]:51514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbcIAFIA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 1 Sep 2016 01:08:00 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DFA41303
        for <fstests@vger.kernel.org>; Thu,  1 Sep 2016 05:07:50 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v3 1/2] common/rc: introduce _overlay_mount_dirs helper
Date: Thu,  1 Sep 2016 13:06:23 +0800
Message-Id: <1472706384-12262-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Introduce a new _overlay_mount_dirs() helper to do the actual
overlay mount operation and factor _overlay_scratch_mount and
_overlay_mount code to use a single implemention of
_overlay_mount_dirs(). Also convert all bare mount of overlay in
tests to use it.

Suggested-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v3:
- mount with SELINUX_MOUNT_OPTIONS in _overlay_mount_dirs

 common/rc         | 21 +++++++++++++++------
 tests/overlay/005 |  5 +----
 tests/overlay/010 |  5 ++---
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/common/rc b/common/rc
index 04039a4..899bef4 100644
--- a/common/rc
+++ b/common/rc
@@ -266,6 +266,18 @@ _scratch_mount_options()
 					$SCRATCH_DEV $SCRATCH_MNT
 }
 
+# helper function to do the actual overlayfs mount operation
+_overlay_mount_dirs()
+{
+	local lowerdir=$1
+	local upperdir=$2
+	local workdir=$3
+	shift 3
+
+	$MOUNT_PROG -t overlay -o lowerdir=$lowerdir -o upperdir=$upperdir \
+		    -o workdir=$workdir $*
+}
+
 # Given a dir, set up 3 subdirectories and mount on the given mnt.
 # The dir is used as the mount device so it can be seen from df or mount
 _overlay_mount()
@@ -293,12 +305,9 @@ _overlay_mount()
 	mkdir -p $dir/$OVERLAY_LOWER_DIR
 	mkdir -p $dir/$OVERLAY_WORK_DIR
 
-	$MOUNT_PROG -t overlay $SELINUX_MOUNT_OPTIONS \
-		    -o lowerdir=$dir/$OVERLAY_LOWER_DIR \
-		    -o upperdir=$dir/$OVERLAY_UPPER_DIR \
-		    -o workdir=$dir/$OVERLAY_WORK_DIR   \
-		    $OVERLAY_MOUNT_OPTIONS $* \
-		    $dir $mnt
+	_overlay_mount_dirs $dir/$OVERLAY_LOWER_DIR $dir/$OVERLAY_UPPER_DIR \
+			    $dir/$OVERLAY_WORK_DIR $OVERLAY_MOUNT_OPTIONS \
+			    $SELINUX_MOUNT_OPTIONS $* $dir $mnt
 }
 
 _overlay_test_mount()
diff --git a/tests/overlay/005 b/tests/overlay/005
index 495e7b5..baadb69 100755
--- a/tests/overlay/005
+++ b/tests/overlay/005
@@ -93,10 +93,7 @@ $XFS_IO_PROG -f -c "truncate 48m" ${lowerd}/test_file \
 	>>$seqres.full 2>&1
 
 # mount new overlayfs
-$MOUNT_PROG -t overlay $SELINUX_MOUNT_OPTIONS \
-	    -o lowerdir=$lowerd -o upperdir=$upperd \
-	    -o workdir=$workd \
-	    $SCRATCH_DEV $SCRATCH_MNT
+_overlay_mount_dirs $lowerd $upperd $workd $SCRATCH_DEV $SCRATCH_MNT
 
 # the open call triggers copy-up and it will fail ENOSPC
 $XFS_IO_PROG -f -c "o" ${SCRATCH_MNT}/test_file \
diff --git a/tests/overlay/010 b/tests/overlay/010
index 5d1c2bd..a302d74 100755
--- a/tests/overlay/010
+++ b/tests/overlay/010
@@ -67,9 +67,8 @@ touch $lowerdir1/testdir/a $lowerdir1/testdir/b
 mknod $lowerdir2/testdir/a c 0 0
 
 # Mount overlayfs and remove testdir, which led to kernel crash
-$MOUNT_PROG -t overlay -o lowerdir=$lowerdir2:$lowerdir1 \
-	    -o upperdir=$upperdir,workdir=$workdir \
-	    $SCRATCH_DEV $SCRATCH_MNT
+_overlay_mount_dirs "$lowerdir2:$lowerdir1" $upperdir $workdir \
+		    $SCRATCH_DEV $SCRATCH_MNT
 rm -rf $SCRATCH_MNT/testdir
 
 # success, all done
-- 
2.7.4

