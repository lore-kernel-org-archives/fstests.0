Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:54140 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbbCTQWm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 12:22:42 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.4])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 08C0263C3A21
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 11:22:42 -0500 (CDT)
Message-ID: <550C4951.1030804@sandeen.net>
Date: Fri, 20 Mar 2015 11:22:41 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: [PATCH 2/2] fstests: Add overlayfs support
References: <550C46B2.8060407@sandeen.net>
In-Reply-To: <550C46B2.8060407@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

If OVERLAYFS=1 is set, then every time we mount the scratch or
test device, set up overlayfs directories under it, and switch
the directory under test to the upper directory.

This doesn't specifically or directly test overlayfs, it simply
runs the existing tests over it.  As such, a few tests fail,
and may be expected to fail due to overlayfs limitations and
caveats.  I haven't sorted through the results yet.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/README b/README
index 0c9449a..2b1d023 100644
--- a/README
+++ b/README
@@ -78,6 +78,8 @@ Preparing system for tests (IRIX and Linux):
                added to the end of fsstresss and fsx invocations, respectively,
                in case you wish to exclude certain operational modes from these
                tests.
+             - setenv OVERLAYFS "1" to set up an overlay directory after each
+               test or scratch mount, and run all tests in the upper directory,
 
         - or add a case to the switch in common/config assigning
           these variables based on the hostname of your test
diff --git a/common/rc b/common/rc
index 22b9a6c..aeca679 100644
--- a/common/rc
+++ b/common/rc
@@ -200,6 +200,33 @@ _mount_ops_filter()
 
 }
 
+# Given a directory, set up 4 subdirectories and create an overlay mount
+# on $DIRECTORY/merged
+_overlayfs_mount()
+{
+	local DIR=$1
+	# No mkdir -p $DIR/lowerdir; see below
+	mkdir -p $DIR/upperdir
+	mkdir -p $DIR/workdir
+	mkdir -p $DIR/merged
+	# We make lowerdir the root dir, because at least for the test dev,
+	# it stands a chance of having content, making overlayfs a bit more
+	# interesting
+	mount -t overlay none $SELINUX_MOUNT_OPTIONS \
+		-o lowerdir=$DIR/		\
+		-o upperdir=$DIR/upperdir	\
+		-o workdir=$DIR/workdir		\
+		$DIR/merged
+}
+
+# Expects to get a $DIR which contains the /merged mountpoint
+_overlayfs_unmount()
+{
+	local DIR=$1
+	$UMOUNT_PROG $DIR/merged
+}
+
+
 _scratch_mount_options()
 {
     _scratch_options mount
@@ -210,10 +237,15 @@ _scratch_mount_options()
 _scratch_mount()
 {
     _mount -t $FSTYP `_scratch_mount_options $*`
+    if [ -n "$OVERLAYFS" ]; then
+	_overlayfs_mount $SCRATCH_MNT && SCRATCH_MNT=$SCRATCH_MNT/upperdir
+    fi
 }
 
 _scratch_unmount()
 {
+    SCRATCH_MNT=${SCRATCH_MNT%/upperdir}
+    _overlayfs_unmount $SCRATCH_MNT
     $UMOUNT_PROG $SCRATCH_DEV
 }
 
@@ -227,10 +259,15 @@ _test_mount()
 {
     _test_options mount
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    if [ -n "$OVERLAYFS" ]; then
+	_overlayfs_mount $TEST_DIR && TEST_DIR=$TEST_DIR/upperdir
+    fi
 }
 
 _test_unmount()
 {
+    TEST_DIR=${TEST_DIR%/upperdir}
+    _overlayfs_unmount $TEST_DIR
     $UMOUNT_PROG $TEST_DEV
 }
 
@@ -1679,6 +1716,9 @@ _umount_or_remount_ro()
     mountpoint=`_is_mounted $device`
 
     if [ $USE_REMOUNT -eq 0 ]; then
+        if [ -n "$OVERLAYFS" ]; then
+            _overlayfs_unmount $mountpoint
+        fi
         $UMOUNT_PROG $device
     else
         _remount $device ro
@@ -1704,6 +1744,9 @@ _mount_or_remount_rw()
             echo "!!! failed to remount $device on $mountpoint"
             return 0 # ok=0
         fi
+        if [ -n "$OVERLAYFS" ]; then
+            _overlayfs_mount $mountpoint
+        fi
     else
         _remount $device rw
     fi


