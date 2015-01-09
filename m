Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48860 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbbAICIp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 8 Jan 2015 21:08:45 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2 v2] xfs/087: test f2fs selectively
Date: Thu,  8 Jan 2015 18:08:37 -0800
Message-Id: <1420769318-81382-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch add the f2fs support for xfs/087 with goingdown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/xfs/087 | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tests/xfs/087 b/tests/xfs/087
index 3a3fb49..9dc81c7 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -54,13 +54,16 @@ _do_meta()
 }
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs xfs f2fs
 _supported_os IRIX Linux
 
 rm -f $seqres.full $tmp.*
 _require_scratch
-_require_v2log 
-_require_xfs_quota
+
+if [ "$FSTYP" == "xfs" ]; then
+    _require_v2log
+    _require_xfs_quota
+fi
 
 echo "*** init FS"
 umount $SCRATCH_DEV >/dev/null 2>&1
@@ -87,12 +90,15 @@ do
     fi
 
     echo "--- mkfs=$mkfs, mnt=$mnt ---"
-    export MKFS_OPTIONS="-l $mkfs"
-    export MOUNT_OPTIONS="-o $mnt"
+
+    if [ "$FSTYP" == "xfs" ]; then
+        export MKFS_OPTIONS="-l $mkfs"
+        export MOUNT_OPTIONS="-o $mnt"
+    fi
 
     # mkfs the FS
     _echofull "mkfs"
-    _scratch_mkfs_xfs >>$seqres.full 2>&1
+    _scratch_mkfs >>$seqres.full 2>&1
     if [ $? -ne 0 ] ; then 
 	_echofull "mkfs failed: $MKFS_OPTIONS"
 	continue
@@ -100,7 +106,7 @@ do
 
     # mount the FS
     _echofull "mount"
-    if ! _scratch_mount -o uquota >>$seqres.full 2>&1; then
+    if ! _scratch_mount >>$seqres.full 2>&1; then
 	_echofull "mount failed: $MOUNT_OPTIONS"
 	continue
     fi
@@ -120,13 +126,19 @@ do
 	|| _fail "umount failed"
 
     _echofull "logprint after going down..."
-    _print_logstate
+    if [ "$FSTYP" == "xfs" ]; then
+        _print_logstate
+    else
+	echo "dirty log"
+    fi
 
     _full "logprint headers"
-    _scratch_xfs_logprint -n >>$seqres.full 2>&1
+    if [ "$FSTYP" == "xfs" ]; then
+        _scratch_xfs_logprint -n >>$seqres.full 2>&1
+    fi
 
     _echofull "mount with replay"
-    _scratch_mount -o uquota >>$seqres.full 2>&1 \
+    _scratch_mount >>$seqres.full 2>&1 \
 	|| _fail "mount failed: $MOUNT_OPTIONS"
 
     # check on what FS looks like after log recovery
@@ -140,7 +152,11 @@ do
     umount $SCRATCH_MNT
 
     _echofull "logprint after mount and replay..."
-    _print_logstate
+    if [ "$FSTYP" == "xfs" ]; then
+        _print_logstate
+    else
+	echo "clean log"
+    fi
 
     if _check_scratch_fs; then
 	_echofull "filesystem is checked ok"
-- 
2.1.1

