Received: from imap.thunk.org ([74.207.234.97]:56692 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758069AbcIWUGG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Sep 2016 16:06:06 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common: add support for the "local" file system type
Date: Fri, 23 Sep 2016 16:05:26 -0400
Message-Id: <20160923200526.29674-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

It is sometimes useful to be able to test the local file system
provided in a restricted execution environment (such as that which is
provided by Docker, for example) where it is not possible to mount and
unmount the file system under test.

To support this test case, add support for a new file system type
called "local".  The TEST_DEV and SCRATCH_DEV should be have a
non-block device format (e.g., local:/test or local:/scratch), and the
TEST_DIR and SCRATCH_MNT directories should be pre-existing
directories provided by the execution environment.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc         | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 tests/generic/027 |  2 +-
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 70d79c9..c03b132 100644
--- a/common/rc
+++ b/common/rc
@@ -330,12 +330,29 @@ _overlay_scratch_unmount()
 	$UMOUNT_PROG $SCRATCH_MNT
 }
 
+_local_validate_mount_opt()
+{
+    case "$*" in
+	ro|ro,*|*,ro) _notrun "ro mount option not supported" ;;
+	*nosuid*) _notrun "nosuid mount option not supported" ;;
+	*noatime*) _notrun "noatime mount option not supported" ;;
+	*relatime*) _notrun "relatime mount option not supported" ;;
+	*diratime*) _notrun "diratime mount option not supported" ;;
+	*strictatime*) _notrun "strictatime mount option not supported" ;;
+    esac
+}
+
 _scratch_mount()
 {
     if [ "$FSTYP" == "overlay" ]; then
         _overlay_scratch_mount $*
         return $?
     fi
+    if [ "$FSTYP" == "local" ]; then
+	_local_validate_mount_opt "$*"
+        mkdir -p $SCRATCH_MNT
+	return $?
+    fi
     _mount -t $FSTYP `_scratch_mount_options $*`
 }
 
@@ -348,6 +365,9 @@ _scratch_unmount()
 	btrfs)
 		$UMOUNT_PROG $SCRATCH_MNT
 		;;
+	local)
+                rm -rf $SCRATCH_MNT/*
+                ;;
 	*)
 		$UMOUNT_PROG $SCRATCH_DEV
 		;;
@@ -358,6 +378,10 @@ _scratch_remount()
 {
     local opts="$1"
 
+    if [ "$FSTYP" = "local" ]; then
+	_local_validate_mount_opt "$*"
+	return 0;
+    fi
     if test -n "$opts"; then
 	mount -o "remount,$opts" $SCRATCH_MNT
     fi
@@ -367,7 +391,7 @@ _scratch_cycle_mount()
 {
     local opts="$1"
 
-    if [ "$FSTYP" = tmpfs ]; then
+    if [ "$FSTYP" = "tmpfs" -o "$FSTYP" = "local" ] ; then
 	_scratch_remount "$opts"
 	return
     fi
@@ -384,6 +408,10 @@ _test_mount()
         _overlay_test_mount $*
         return $?
     fi
+    if [ "$FSTYP" == "local" ]; then
+        mkdir -p $TEST_DIR
+	return $?
+    fi
     _test_options mount
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
 }
@@ -392,7 +420,7 @@ _test_unmount()
 {
 	if [ "$FSTYP" == "overlay" ]; then
 		_overlay_test_unmount
-	else
+	elif [ "$FSTYP" != "local" ]; then
 		$UMOUNT_PROG $TEST_DEV
 	fi
 }
@@ -811,6 +839,9 @@ _scratch_mkfs()
     tmpfs)
 	# do nothing for tmpfs
 	;;
+    local)
+        _scratch_cleanup_files
+	;;
     f2fs)
         $MKFS_F2FS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV > /dev/null
 	;;
@@ -1031,6 +1062,13 @@ _scratch_mkfs_sized()
 	fi
 	export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
 	;;
+    local)
+        _scratch_cleanup_files
+	free_space=$(_df_dir $SCRATCH_MNT | $AWK_PROG '{ print $5 }')
+	if [ "$(expr $free_space * 1024)" -lt "$fssize" ] ; then
+	   _notrun "Not enough space ($free_space) for local with $fssize bytes"
+	fi
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;
@@ -1517,6 +1555,13 @@ _require_scratch_nocheck()
 		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
 		fi
 		;;
+	local)
+		if [ -z "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
+		then
+		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
+		fi
+		return 0
+		;;
 	*)
 		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
 		 then
@@ -1602,6 +1647,13 @@ _require_test()
 		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
 		fi
 		;;
+	local)
+		if [ -z "$TEST_DEV" -o ! -d "$TEST_DIR" ];
+		then
+		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
+		fi
+		return 0
+		;;
 	*)
 		 if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
 		 then
@@ -2264,6 +2316,10 @@ _remount()
     device=$1
     mode=$2
 
+    if [ "$FSTYP" == "local" ] ; then
+       return 0
+    fi
+
     if ! mount -o remount,$mode $device
     then
         echo "_remount: failed to remount filesystem on $device as $mode"
@@ -2309,6 +2365,10 @@ _mount_or_remount_rw()
 	device=$2
 	mountpoint=$3
 
+	if [ "$FSTYP" == "local" ] ; then
+	    return 0
+	fi
+
 	if [ $USE_REMOUNT -eq 0 ]; then
 		if [ "$FSTYP" != "overlay" ]; then
 			_mount -t $FSTYP $mount_opts $device $mountpoint
@@ -2666,6 +2726,9 @@ _check_test_fs()
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
+    local)
+	# no way to check consistency for local
+	;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -2707,6 +2770,9 @@ _check_scratch_fs()
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
+    local)
+	# no way to check consistency for local
+	;;
     *)
 	_check_generic_filesystem $device
 	;;
@@ -3784,7 +3850,7 @@ init_rc()
 		fi
 	fi
 
-	if [ "`_fs_type $TEST_DEV`" != "$FSTYP" ]
+	if [ "$FSTYP" != "local" -a "`_fs_type $TEST_DEV`" != "$FSTYP" ]
 	then
 		echo "common/rc: Error: \$TEST_DEV ($TEST_DEV) is not a MOUNTED $FSTYP filesystem"
 		# raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
diff --git a/tests/generic/027 b/tests/generic/027
index d2e59d6..73565fc 100755
--- a/tests/generic/027
+++ b/tests/generic/027
@@ -77,7 +77,7 @@ rm -f $SCRATCH_MNT/testfile
 
 loop=100
 # btrfs takes much longer time, reduce the loop count
-if [ "$FSTYP" == "btrfs" ]; then
+if [ "$FSTYP" == "btrfs" -o "$FSTYP" == "local" ]; then
 	loop=10
 fi
 
-- 
2.9.0.243.g5c589a7.dirty

