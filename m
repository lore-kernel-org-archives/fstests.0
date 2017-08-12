Received: from mail-pg0-f54.google.com ([74.125.83.54]:36474 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbdHLAOX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Aug 2017 20:14:23 -0400
Received: by mail-pg0-f54.google.com with SMTP id v77so21025678pgb.3
        for <fstests@vger.kernel.org>; Fri, 11 Aug 2017 17:14:23 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] fstests: add sdcardfs support
Date: Fri, 11 Aug 2017 17:14:16 -0700
Message-Id: <20170812001416.36127-1-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Add ability to run generic test on a sdcardfs filesystem.
sdcardfs replaces fuse daemon to emulate a sdcard on Android.
It is based on wrapfs, a passthru filesystem.

Add -sdcardfs option to prevent check from doing mkfs, cleanup of
the underlying device.

Given sdcardfs does not support links, add _require_test_link to tests
that use links.

TEST=Check we don't have any kernel crashes when running:
export TEST_DEV='/usr/local/autotest/tmp/xfstests_TEST'
export SCRATCH_DEV='/usr/local/autotest/tmp/xfstests_SCRATCH'
export SHELL='/bin/bash'
export SCRATCH_MNT='/usr/local/autotest/tmp/xfstests_sdcarfs_SCRATCH'
export PWD='/root'
export PATH='/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin'
export TEST_DIR='/usr/local/autotest/tmp/xfstests_sdcarfs_TEST'
export SELINUX_MOUNT_OPTIONS=' '
export HOME='/root'
export SDCARDFS_MOUNT_OPTIONS='-o fsuid=4444,fsgid=4444,gid=4445,multiuser,mask=23,noatime'
mkdir -p "${TEST_DEV}" "${SCRATCH_DEV}" "${SCRATCH_MNT}" "${TEST_DIR}"
./check -sdcardfs generic/*

Using Android AOSP 4.4 sdcardfs code:
In generic directory, 365 tests excluded, 84 ran and 8 failed:
generic/087 generic/088 generic/126 generic/184 generic/257 generic/260 generic/306 generic/448

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 check             |  2 ++
 common/config     |  5 ++++-
 common/rc         | 38 +++++++++++++++++++++++++-------------
 tests/generic/002 |  1 +
 tests/generic/062 |  1 +
 tests/generic/079 |  1 +
 tests/generic/089 |  1 +
 tests/generic/109 |  1 +
 tests/generic/236 |  1 +
 tests/generic/294 |  1 +
 tests/generic/360 |  1 +
 tests/generic/401 |  1 +
 12 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/check b/check
index f8db3cd6..0de3d907 100755
--- a/check
+++ b/check
@@ -69,6 +69,7 @@ check options
     -cifs               test CIFS
     -overlay		test overlay
     -pvfs2          test PVFS2
+    -sdcardfs		test sdcardfs
     -tmpfs              test TMPFS
     -ubifs              test ubifs
     -l			line mode diff
@@ -267,6 +268,7 @@ while [ $# -gt 0 ]; do
 	-cifs)		FSTYP=cifs ;;
 	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
 	-pvfs2)		FSTYP=pvfs2 ;;
+	-sdcardfs)	FSTYP=sdcardfs ;;
 	-tmpfs)		FSTYP=tmpfs ;;
 	-ubifs)		FSTYP=ubifs ;;
 
diff --git a/common/config b/common/config
index 80598d06..6ec24e01 100644
--- a/common/config
+++ b/common/config
@@ -308,6 +308,9 @@ _mount_opts()
 		# acls aren't turned on by default on gfs2
 		export MOUNT_OPTIONS="-o acl $GFS2_MOUNT_OPTIONS"
 		;;
+	sdcardfs)
+		export MOUNT_OPTIONS=$SDCARDFS_MOUNT_OPTIONS
+		;;
 	tmpfs)
 		# We need to specify the size at mount, use 1G by default
 		export MOUNT_OPTIONS="-o size=1G $TMPFS_MOUNT_OPTIONS"
@@ -451,7 +454,7 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
-	overlay)
+	overlay|sdcardfs)
 		if [ ! -d "$dev" ]; then
 			_fatal "common/config: $name ($dev) is not a directory for overlay"
 		fi
diff --git a/common/rc b/common/rc
index 9c5f54aa..6ba4e435 100644
--- a/common/rc
+++ b/common/rc
@@ -479,7 +479,7 @@ _scratch_unmount()
 	overlay)
 		_overlay_scratch_unmount
 		;;
-	btrfs)
+	btrfs|sdcardfs)
 		$UMOUNT_PROG $SCRATCH_MNT
 		;;
 	*)
@@ -524,11 +524,17 @@ _test_mount()
 
 _test_unmount()
 {
-	if [ "$FSTYP" == "overlay" ]; then
-		_overlay_test_unmount
-	else
-		$UMOUNT_PROG $TEST_DEV
-	fi
+    case "$FSTYP" in
+    "overlay")
+        _overlay_test_unmount
+        ;;
+    "sdcardfs")
+        $UMOUNT_PROG $TEST_DIR
+        ;;
+    *)
+        $UMOUNT_PROG $TEST_DEV
+        ;;
+    esac
 }
 
 _test_cycle_mount()
@@ -714,8 +720,8 @@ _test_mkfs()
     glusterfs)
 	# do nothing for glusterfs
 	;;
-    overlay)
-	# do nothing for overlay
+    overlay|sdcardfs)
+	# do nothing for overlay|sdcardfs
 	;;
     pvfs2)
 	# do nothing for pvfs2
@@ -742,8 +748,8 @@ _mkfs_dev()
     nfs*)
 	# do nothing for nfs
 	;;
-    overlay)
-	# do nothing for overlay
+    overlay|sdcardfs)
+	# do nothing for overlay|sdcardfs
 	;;
     pvfs2)
 	# do nothing for pvfs2
@@ -803,7 +809,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2)
+	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|sdcardfs)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1595,7 +1601,7 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
-	tmpfs)
+	tmpfs|sdcardfs)
 		if [ -z "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
 		then
 		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
@@ -1698,7 +1704,7 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
-	tmpfs)
+	tmpfs|sdcardfs)
 		if [ -z "$TEST_DEV" -o ! -d "$TEST_DIR" ];
 		then
 		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
@@ -2621,6 +2627,9 @@ _check_test_fs()
     btrfs)
 	_check_btrfs_filesystem $TEST_DEV
 	;;
+    sdcardfs)
+	# no way to check consistency for sdcardfs
+	;;
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
@@ -2673,6 +2682,9 @@ _check_scratch_fs()
     btrfs)
 	_check_btrfs_filesystem $device
 	;;
+    sdcardfs)
+	# no way to check consistency for sdcardfs
+	;;
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
diff --git a/tests/generic/002 b/tests/generic/002
index d8cffeaa..990d69c2 100755
--- a/tests/generic/002
+++ b/tests/generic/002
@@ -44,6 +44,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_test_symlinks
 
 rm -f $seqres.full
 
diff --git a/tests/generic/062 b/tests/generic/062
index 643f02c3..8333dbc3 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -75,6 +75,7 @@ _supported_os Linux
 
 _require_scratch
 _require_attrs
+_require_test_symlinks
 
 rm -f $tmp.backup1 $tmp.backup2 $seqres.full
 
diff --git a/tests/generic/079 b/tests/generic/079
index c2db6bf1..897a52a6 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -50,6 +50,7 @@ _supported_os Linux
 _require_chattr ia
 _require_test_program "t_immutable"
 _require_scratch
+_require_test_symlinks
 
 # real QA test starts here
 _scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
diff --git a/tests/generic/089 b/tests/generic/089
index 4324f83a..2a387198 100755
--- a/tests/generic/089
+++ b/tests/generic/089
@@ -52,6 +52,7 @@ addentries()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_test_symlinks
 
 rm -f $seqres.full
 [ "X$TEST_DIR" = "X" ] && exit 1
diff --git a/tests/generic/109 b/tests/generic/109
index 9fbaf1f4..0bae3097 100755
--- a/tests/generic/109
+++ b/tests/generic/109
@@ -45,6 +45,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_test_symlinks
 
 rm -f $seqres.full
 
diff --git a/tests/generic/236 b/tests/generic/236
index 12ea0bc6..4b5c85e1 100755
--- a/tests/generic/236
+++ b/tests/generic/236
@@ -44,6 +44,7 @@ _supported_fs generic
 # only Linux supports fallocate
 _supported_os Linux
 _require_test
+_require_test_symlinks
 
 rm -f $TEST_DIR/ouch*
 
diff --git a/tests/generic/294 b/tests/generic/294
index fb5d9aa8..25309191 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -47,6 +47,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_test_symlinks
 
 rm -f $seqres.full
 _scratch_mkfs > $seqres.full 2>&1 || _fail "Could not mkfs scratch device"
diff --git a/tests/generic/360 b/tests/generic/360
index cc5623f5..caf8908e 100755
--- a/tests/generic/360
+++ b/tests/generic/360
@@ -46,6 +46,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_test_symlinks
 
 linkfile=$TEST_DIR/$seq.symlink
 rm -f $linkfile
diff --git a/tests/generic/401 b/tests/generic/401
index 74f2bea5..6f58389a 100755
--- a/tests/generic/401
+++ b/tests/generic/401
@@ -56,6 +56,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_test_program "t_dir_type"
+_require_test_symlinks
 
 rm -f $seqres.full
 
-- 
2.12.2

