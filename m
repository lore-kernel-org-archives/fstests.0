Received: from mx1.redhat.com ([209.132.183.28]:38278 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbbLKIfu (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 11 Dec 2015 03:35:50 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id C7380C0C0F92
	for <fstests@vger.kernel.org>; Fri, 11 Dec 2015 08:35:50 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/4] fstests: rudimentary overlayfs testing support
Date: Fri, 11 Dec 2015 16:35:05 +0800
Message-Id: <1449822907-31197-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1449822907-31197-1-git-send-email-eguan@redhat.com>
References: <1449822907-31197-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Adding basic overlayfs support to fstests, it doesn't test anything
overlayfs specific, but runs existing tests on top of overlayfs. It's
following the path from Eric's patchset and Zab's review back in Mar.

A new fstype "overlay" is added, and TEST_DEV/SCRATCH_DEV are required
to be fs paths, and overlayfs is mounted at TEST_DIR/SCRATCH_MNT, so
tests can be run there.

To test overlayfs, setup config as something like the following

TEST_DEV=/mnt/ovl/test
TEST_DIR=/mnt/testarea/test
SCRATCH_DEV=/mnt/ovl/scratch
SCRATCH_MNT=/mnt/testarea/scratch

then run

./check -overlay -g auto

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 check         |  22 +++++----
 common/config |  14 +++++-
 common/rc     | 153 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 155 insertions(+), 34 deletions(-)

diff --git a/check b/check
index f0f2cdc..135a9fb 100755
--- a/check
+++ b/check
@@ -53,13 +53,6 @@ timestamp=${TIMESTAMP:=false}
 
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist
 
-# we need common/config
-if ! . ./common/config
-then
-    echo "$iam: failed to source common/config"
-    exit 1
-fi
-
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
 
@@ -70,6 +63,7 @@ usage()
 check options
     -nfs                test NFS
     -cifs               test CIFS
+    -overlay		test overlay
     -tmpfs              test TMPFS
     -l			line mode diff
     -udiff		show unified diff (default)
@@ -207,9 +201,10 @@ while [ $# -gt 0 ]; do
 	case "$1" in
 	-\? | -h | --help) usage ;;
 
-	-nfs)	FSTYP=nfs ;;
-	-cifs)	FSTYP=cifs ;;
-	-tmpfs)	FSTYP=tmpfs ;;
+	-nfs)		FSTYP=nfs ;;
+	-cifs)		FSTYP=cifs ;;
+	-overlay)	FSTYP=overlay ;;
+	-tmpfs)		FSTYP=tmpfs ;;
 
 	-g)	group=$2 ; shift ;
 		GROUP_LIST="$GROUP_LIST ${group//,/ }"
@@ -260,6 +255,13 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
+# we need common/config, source it after processing args, overlay needs FSTYP
+# set before sourcing common/config
+if ! . ./common/config; then
+	echo "$iam: failed to source common/config"
+	exit 1
+fi
+
 # Process tests from command line now.
 if $have_test_arg; then
 	while [ $# -gt 0 ]; do
diff --git a/common/config b/common/config
index dca7aad..9953a24 100644
--- a/common/config
+++ b/common/config
@@ -246,6 +246,7 @@ case "$HOSTOS" in
         export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
         export MKFS_NFS_PROG="false"
         export MKFS_CIFS_PROG="false"
+        export MKFS_OVERLAY_PROG="false"
         export MKFS_REISER4_PROG="`set_prog_path mkfs.reiser4`"
         ;;
 esac
@@ -284,6 +285,9 @@ _mount_opts()
 	cifs)
 		export MOUNT_OPTIONS=$CIFS_MOUNT_OPTIONS
 		;;
+	overlay)
+		export MOUNT_OPTIONS=$OVERLAY_MOUNT_OPTIONS
+		;;
 	ext2|ext3|ext4|ext4dev)
 		# acls & xattrs aren't turned on by default on ext$FOO
 		export MOUNT_OPTIONS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
@@ -485,9 +489,12 @@ get_next_config() {
 	fi
 
 	echo $TEST_DEV | grep -qE ":|//" > /dev/null 2>&1
-	if [ ! -b "$TEST_DEV" -a "$?" != "0" ]; then
+	if [ ! -b "$TEST_DEV" -a "$?" != "0" -a "$FSTYP" != "overlay" ]; then
 		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem"
 		exit 1
+	elif [ "$FSTYP" == "overlay" -a ! -d "$TEST_DEV" ]; then
+		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a directory for overlay"
+		exit 1
 	fi
 
 	if [ ! -d "$TEST_DIR" ]; then
@@ -508,9 +515,12 @@ get_next_config() {
 	fi
 
 	echo $SCRATCH_DEV | grep -qE ":|//" > /dev/null 2>&1
-	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" ]; then
+	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" -a "$FSTYP" != "overlay" ]; then
 		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem"
 		exit 1
+	elif [ ! -z "$SCRATCH_DEV" -a "$FSTYP" == "overlay" -a ! -d "$SCRATCH_DEV" ]; then
+		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a directory for overlay"
+		exit 1
 	fi
 
 	if [ ! -z "$SCRATCH_MNT" -a ! -d "$SCRATCH_MNT" ]; then
diff --git a/common/rc b/common/rc
index 9a12deb..3ce328e 100644
--- a/common/rc
+++ b/common/rc
@@ -147,6 +147,8 @@ case "$FSTYP" in
 	 ;;
     cifs)
 	 ;;
+    overlay)
+	 ;;
     reiser4)
 	 [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
 	 ;;
@@ -240,22 +242,85 @@ _common_dev_mount_options()
 	echo $MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS $*
 }
 
+_overlay_basic_mount_options()
+{
+	echo "-o lowerdir=$1/lower,upperdir=$1/upper,workdir=$1/work"
+}
+
+_overlay_mount_options()
+{
+	echo `_common_dev_mount_options` \
+	     `_overlay_basic_mount_options $1` \
+	     $OVERLAY_MOUNT_OPTIONS
+}
+
 _scratch_mount_options()
 {
 	_scratch_options mount
 
+	if [ "$FSTYP" == "overlay" ]; then
+		echo `_overlay_mount_options $SCRATCH_DEV`
+		return 0
+	fi
 	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
 					$SCRATCH_DEV $SCRATCH_MNT
 }
 
+# Given a dir, set up 3 subdirectories and mount on the given mnt.
+# The dir is used as the mount device so it can be seen from df or mount
+_overlay_mount()
+{
+	local dir=$1
+	local mnt=$2
+	shift 2
+	mkdir -p $dir/upper
+	mkdir -p $dir/lower
+	mkdir -p $dir/work
+
+	$MOUNT_PROG -t overlay $SELINUX_MOUNT_OPTIONS \
+		    -o lowerdir=$dir/lower \
+		    -o upperdir=$dir/upper \
+		    -o workdir=$dir/work   \
+		    $OVERLAY_MOUNT_OPTIONS $* \
+		    $dir $mnt
+}
+
+_overlay_test_mount()
+{
+	_overlay_mount $TEST_DEV $TEST_DIR $*
+}
+
+_overlay_scratch_mount()
+{
+	_overlay_mount $SCRATCH_DEV $SCRATCH_MNT $*
+}
+
+_overlay_test_unmount()
+{
+	$UMOUNT_PROG $TEST_DIR
+}
+
+_overlay_scratch_unmount()
+{
+	$UMOUNT_PROG $SCRATCH_MNT
+}
+
 _scratch_mount()
 {
+    if [ "$FSTYP" == "overlay" ]; then
+        _overlay_scratch_mount $*
+        return $?
+    fi
     _mount -t $FSTYP `_scratch_mount_options $*`
 }
 
 _scratch_unmount()
 {
-    $UMOUNT_PROG $SCRATCH_DEV
+	if [ "$FSTYP" == "overlay" ]; then
+		_overlay_scratch_unmount
+	else
+		$UMOUNT_PROG $SCRATCH_DEV
+	fi
 }
 
 _scratch_remount()
@@ -266,13 +331,21 @@ _scratch_remount()
 
 _test_mount()
 {
+    if [ "$FSTYP" == "overlay" ]; then
+        _overlay_test_mount $*
+        return $?
+    fi
     _test_options mount
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
 }
 
 _test_unmount()
 {
-	$UMOUNT_PROG $TEST_DEV
+	if [ "$FSTYP" == "overlay" ]; then
+		_overlay_test_unmount
+	else
+		$UMOUNT_PROG $TEST_DEV
+	fi
 }
 
 _test_remount()
@@ -571,6 +644,9 @@ _test_mkfs()
     cifs)
 	# do nothing for cifs
 	;;
+    overlay)
+	# do nothing for overlay
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
@@ -592,6 +668,9 @@ _mkfs_dev()
     nfs*)
 	# do nothing for nfs
 	;;
+    overlay)
+	# do nothing for overlay
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* 2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
 	;;
@@ -643,6 +722,11 @@ _scratch_mkfs()
 	# avoid EEXIST caused by the leftover files created in previous runs
         _scratch_cleanup_files
 	;;
+    overlay)
+	# unable to re-create overlay, remove all files in $SCRATCH_MNT to
+	# avoid EEXIST caused by the leftover files created in previous runs
+        _scratch_cleanup_files
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* $SCRATCH_DEV > /dev/null
 	;;
@@ -1142,6 +1226,14 @@ _require_scratch_nocheck()
 		     _notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+	overlay)
+		if [ -z "$SCRATCH_DEV" -o ! -d "$SCRATCH_DEV" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV as ovl base dir"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		;;
 	tmpfs)
 		if [ -z "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
 		then
@@ -1216,6 +1308,14 @@ _require_test()
 		     _notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	overlay)
+		if [ -z "$TEST_DEV" -o ! -d "$TEST_DEV" ]; then
+			_notrun "this test requires a valid \$TEST_DEV as ovl base dir"
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	tmpfs)
 		if [ -z "$TEST_DEV" -o ! -d "$TEST_DIR" ];
 		then
@@ -1796,27 +1896,29 @@ _umount_or_remount_ro()
 
 _mount_or_remount_rw()
 {
-    if [ $# -ne 3 ]
-    then
-	echo "Usage: _mount_or_remount_rw <opts> <device> <mountpoint>" 1>&2
-	exit 1
-    fi
-    mount_opts=$1
-    device=$2
-    mountpoint=$3
+	if [ $# -ne 3 ]; then
+		echo "Usage: _mount_or_remount_rw <opts> <dev> <mnt>" 1>&2
+		exit 1
+	fi
+	mount_opts=$1
+	device=$2
+	mountpoint=$3
 
-    if [ $USE_REMOUNT -eq 0 ]
-    then
-        if ! _mount -t $FSTYP $mount_opts $device $mountpoint
-        then
-            echo "!!! failed to remount $device on $mountpoint"
-            return 0 # ok=0
-        fi
-    else
-        _remount $device rw
-    fi
+	if [ $USE_REMOUNT -eq 0 ]; then
+		if [ "$FSTYP" != "overlay" ]; then
+			_mount -t $FSTYP $mount_opts $device $mountpoint
+		else
+			_overlay_mount $device $mountpoint
+		fi
+		if [ $? -ne 0 ]; then
+			echo "!!! failed to remount $device on $mountpoint"
+			return 0 # ok=0
+		fi
+	else
+		_remount $device rw
+	fi
 
-    return 1 # ok=1
+	return 1 # ok=1
 }
 
 # Check a generic filesystem in no-op mode; this assumes that the
@@ -2110,6 +2212,9 @@ _check_test_fs()
     cifs)
 	# no way to check consistency for cifs
 	;;
+    overlay)
+	# no way to check consistency for overlay
+	;;
     udf)
 	# do nothing for now
 	;;
@@ -2151,6 +2256,9 @@ _check_scratch_fs()
     cifs)
 	# Don't know how to check a CIFS filesystem, yet.
 	;;
+    overlay)
+	# no way to check consistency for overlay
+	;;
     btrfs)
 	_check_btrfs_filesystem $device
 	;;
@@ -3108,7 +3216,8 @@ init_rc()
 	if [ "`_fs_type $TEST_DEV`" != "$FSTYP" ]
 	then
 		echo "common/rc: Error: \$TEST_DEV ($TEST_DEV) is not a MOUNTED $FSTYP filesystem"
-		$DF_PROG $TEST_DEV
+		# raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
+		_df_device $TEST_DEV
 		exit 1
 	fi
 	# Figure out if we need to add -F ("foreign", deprecated) option to xfs_io
-- 
2.5.0

