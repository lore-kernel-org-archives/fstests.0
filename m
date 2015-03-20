Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:53970 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbbCTQNt (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 12:13:49 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.4])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 125A263C3A21
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 11:13:48 -0500 (CDT)
Message-ID: <550C473B.5010004@sandeen.net>
Date: Fri, 20 Mar 2015 11:13:47 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: [PATCH 1/2] fstests: use mount/umount helpers everywhere
References: <550C46B2.8060407@sandeen.net>
In-Reply-To: <550C46B2.8060407@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Replace every explicit mount/umount of scratch or test devices
with helper functions.  This allows the next patch to add in hooks
to these functions in order to set up & tear down overlayfs on
every mount/umount.

(also adds _test_unmount(), which didn't exist prior)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/check b/check
index 0830e0c..1bdfa69 100755
--- a/check
+++ b/check
@@ -461,7 +461,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
 		echo "RECREATING    -- $FSTYP on $TEST_DEV"
-		umount $TEST_DEV 2> /dev/null
+		_test_unmount 2> /dev/null
 		if ! _test_mkfs >$tmp.err 2>&1
 		then
 			echo "our local _test_mkfs routine ..."
@@ -476,7 +476,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		fi
 		_prepare_test_list
 	elif [ "$OLD_MOUNT_OPTIONS" != "$MOUNT_OPTIONS" ]; then
-		umount $TEST_DEV 2> /dev/null
+		_test_unmount 2> /dev/null
 		out=`_mount_or_remount_rw "$MOUNT_OPTIONS" $TEST_DEV $TEST_DIR`
 		if [ $? -ne 1 ]; then
 			echo $out
@@ -505,7 +505,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	needwrap=true
 
 	if [ ! -z "$SCRATCH_DEV" ]; then
-	  umount $SCRATCH_DEV 2>/dev/null
+	  _scratch_unmount 2>/dev/null
 	  # call the overridden mkfs - make sure the FS is built
 	  # the same as we'll create it later.
 
@@ -677,8 +677,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	_wrapup
 	echo
 
-	umount $TEST_DEV 2> /dev/null
-	umount $SCRATCH_DEV 2> /dev/null
+	_test_unmount 2> /dev/null
+	_scratch_unmount 2> /dev/null
 done
 
 interrupt=false
diff --git a/common/attr b/common/attr
index 48c81cc..b416524 100644
--- a/common/attr
+++ b/common/attr
@@ -233,7 +233,7 @@ _require_noattr2()
 {
 	_scratch_mkfs_xfs > /dev/null 2>&1 \
 		|| _fail "_scratch_mkfs_xfs failed on $SCRATCH_DEV"
-	_mount -o noattr2 $SCRATCH_DEV > /dev/null 2>&1 \
+	_scratch_mount -o noattr2 > /dev/null 2>&1 \
 		|| _notrun "noattr2 mount option not supported on $SCRATCH_DEV"
 	_scratch_unmount
 }
diff --git a/common/dump b/common/dump
index c42eb2c..2db7378 100644
--- a/common/dump
+++ b/common/dump
@@ -288,7 +288,7 @@ _cleanup()
 _stable_fs()
 {
     _saveddir=`pwd`; cd /
-    umount $SCRATCH_MNT >>$seqres.full || _fail "unmount failed"
+    _scratch_unmount >>$seqres.full || _fail "unmount failed"
     _scratch_mount >>$seqres.full || _fail "mount failed"
     cd $_saveddir
 }
diff --git a/common/filestreams b/common/filestreams
index 590fa7f..4d14664 100644
--- a/common/filestreams
+++ b/common/filestreams
@@ -225,5 +225,5 @@ _cleanup_streams_umount()
 {
 	cd /
 	rm -rf ${SCRATCH_MNT}/stream*
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 }
diff --git a/common/log b/common/log
index 5be5411..cb687d2 100644
--- a/common/log
+++ b/common/log
@@ -339,7 +339,7 @@ _create_log()
 	
     # unmount the FS
     _full "umount"
-    umount $SCRATCH_DEV >>$seqres.full 2>&1
+    _scratch_unmount >>$seqres.full 2>&1
     if [ $? -ne 0 ] ; then 
 	_echofull "umount failed"
 	return 1
@@ -370,7 +370,7 @@ _create_log_sync()
 
     # unmount the FS
     _full "umount"
-    umount $SCRATCH_DEV >>$seqres.full 2>&1
+    _scratch_unmount >>$seqres.full 2>&1
     if [ $? -ne 0 ] ; then 
 	_echofull "umount failed"
 	return 1
@@ -482,7 +482,7 @@ _require_v2log()
     # check after unmount to see if it is clean
     # i.e. it is not a 6.5.25 buggy version checking kernel
     touch $SCRATCH_MNT/file
-    umount $SCRATCH_DEV >>$seqres.full 2>&1
+    _scratch_unmount >>$seqres.full 2>&1
     if _scratch_xfs_logprint -t | tee -a $seqres.full \
         | head | grep -q "<DIRTY>"; then
         _notrun "kernel does not support v2 logs"
diff --git a/common/quota b/common/quota
index b320cf2..08916e6 100644
--- a/common/quota
+++ b/common/quota
@@ -167,7 +167,7 @@ _choose_prid()
 
 _qmount()
 {
-    umount $SCRATCH_DEV >/dev/null 2>&1
+    _scratch_unmount >/dev/null 2>&1
     _scratch_mount || _fail "qmount failed"
     chmod ugo+rwx $SCRATCH_MNT
 }
diff --git a/common/rc b/common/rc
index 1ed9df5..22b9a6c 100644
--- a/common/rc
+++ b/common/rc
@@ -229,9 +229,15 @@ _test_mount()
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
 }
 
-_test_remount()
+_test_unmount()
 {
     $UMOUNT_PROG $TEST_DEV
+}
+
+
+_test_remount()
+{
+    _test_unmount
     _test_mount
 }
 
@@ -285,7 +291,7 @@ _setup_large_xfs_fs()
 		$SCRATCH_MNT/.use_space 2>&1 > /dev/null
 	export NUM_SPACE_FILES=1
 	status=$?
-	umount $SCRATCH_MNT
+	_scratch_unmount
 	if [ $status -ne 0 ]; then
 		echo "large file prealloc failed"
 		cat $tmp_dir/mnt.err >&2
@@ -452,7 +458,7 @@ _setup_large_ext4_fs()
 	fi
 	export NUM_SPACE_FILES=$nfiles
 
-	umount $SCRATCH_MNT
+	_scratch_unmount
 	if [ $status -ne 0 ]; then
 		echo "large file prealloc failed"
 		cat $tmp_dir/mnt.err >&2
@@ -1120,7 +1126,7 @@ _require_scratch_nocheck()
             exit 1
         fi
         # and then unmount it
-        if ! $UMOUNT_PROG $SCRATCH_DEV
+        if ! _scratch_unmount
         then
             echo "failed to unmount $SCRATCH_DEV"
             exit 1
@@ -1340,7 +1346,7 @@ _require_xfs_crc()
 	_scratch_mkfs_xfs -m crc=1 >/dev/null 2>&1
 	_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Kernel doesn't support crc feature"
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 # this test requires the bigalloc feature to be available in mkfs.ext4
@@ -1358,7 +1364,7 @@ _require_ext4_bigalloc()
 	$MKFS_EXT4_PROG -F -O bigalloc $SCRATCH_DEV 512m >/dev/null 2>&1
 	_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Ext4 kernel doesn't support bigalloc feature"
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 # this test requires the finobt feature to be available in mkfs.xfs
@@ -1376,7 +1382,7 @@ _require_xfs_finobt()
 	_scratch_mkfs_xfs -m crc=1,finobt=1 >/dev/null 2>&1
 	_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Kernel doesn't support finobt feature"
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 # this test requires xfs sysfs attribute support
diff --git a/common/repair b/common/repair
index 7a99546..3cb503f 100644
--- a/common/repair
+++ b/common/repair
@@ -113,7 +113,7 @@ _check_repair()
 	dd if=/bin/bash of=$SCRATCH_MNT/sh 2>&1 |_filter_dd
 	sync
 	rm -f $SCRATCH_MNT/sh
-	umount $SCRATCH_MNT
+	_scratch_unmount
 
 	_zero_position $value "$structure"
 	_scratch_xfs_repair 2>&1 | _filter_repair
@@ -126,7 +126,7 @@ _check_repair()
 	POSIXLY_CORRECT=yes \
 	dd if=$SCRATCH_MNT/sh of=/dev/null 2>&1 |_filter_dd #read
 	rm -f $SCRATCH_MNT/sh                               #unlink
-	umount $SCRATCH_MNT                                 #umount
+	_scratch_unmount                                    #umount
 }
 
 # make sure this script returns success
diff --git a/tests/btrfs/002 b/tests/btrfs/002
index 19a62c6..35e857b 100755
--- a/tests/btrfs/002
+++ b/tests/btrfs/002
@@ -185,7 +185,7 @@ _save_checksum $SNAPNAME $tmp.$tname.sum
 \rm -rf $firstvol/*
 _verify_checksum $SNAPNAME $tmp.$tname.sum
 
-umount $SCRATCH_DEV || _fail "unmount failed"
+_scratch_unmount || _fail "unmount failed"
 
 echo "Silence is golden"
 status=0; exit
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index d559f8e..7342bd8 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -36,7 +36,7 @@ _cleanup()
     cd /
     rm -f $tmp.*
     if [ $dev_removed == 1 ]; then
-        umount $SCRATCH_MNT
+        _scratch_unmount
         _devmgt_add "${DEVHTL}"
     fi
 }
@@ -63,7 +63,7 @@ _test_raid0()
 	_scratch_mount
 	dirp=`mktemp -duq $SCRATCH_MNT/dir.XXXXXX`
 	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 _test_raid1()
@@ -73,7 +73,7 @@ _test_raid1()
 	_scratch_mount
 	dirp=`mktemp -duq $SCRATCH_MNT/dir.XXXXXX`
 	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 _test_raid10()
@@ -83,7 +83,7 @@ _test_raid10()
 	_scratch_mount
 	dirp=`mktemp -duq $SCRATCH_MNT/dir.XXXXXX`
 	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 _test_single()
@@ -93,7 +93,7 @@ _test_single()
 	_scratch_mount
 	dirp=`mktemp -duq $SCRATCH_MNT/dir.XXXXXX`
 	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 _test_add()
@@ -115,7 +115,7 @@ _test_add()
 		$BTRFS_UTIL_PROG device add ${devs[$i]} $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "device add failed"
 	done
 	$BTRFS_UTIL_PROG filesystem balance $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "balance failed"
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 _test_replace()
@@ -161,7 +161,7 @@ _test_replace()
 	$BTRFS_UTIL_PROG filesystem balance $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "dev balance failed"
 
 	# cleaup. add the removed disk
-	umount $SCRATCH_MNT
+	_scratch_unmount
 	_devmgt_add "${DEVHTL}"
 	dev_removed=0
 }
@@ -177,7 +177,7 @@ _test_remove()
 	dev_del=`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`
 	$BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs device delete failed"
 	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV 2>&1 | grep $dev_del >> $seqres.full && _fail "btrfs still shows the deleted dev"
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 _test_raid0
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 1d5b816..382620b 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -180,7 +180,7 @@ workout()
 	snap_name=$4
 	do_bg_noise=$5
 
-	umount $SCRATCH_DEV >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
 	echo "*** mkfs -dsize=$fsz"    >>$seqres.full
 	echo ""                                     >>$seqres.full
 	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
@@ -193,7 +193,7 @@ workout()
 	_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT \
 		$SCRATCH_MNT/$snap_name
 
-	run_check umount $SCRATCH_DEV >/dev/null 2>&1
+	run_check _scratch_unmount >/dev/null 2>&1
 	run_check _scratch_mount "-o compress=lzo"
 
 	# make some noise but ensure we're not touching existing data
@@ -207,7 +207,7 @@ workout()
 	# now make more files to get a higher tree
 	run_check $FSSTRESS_PROG -d $clean_dir -w -p $procs -n 2000 \
 		$FSSTRESS_AVOID
-	run_check umount $SCRATCH_DEV >/dev/null 2>&1
+	run_check _scratch_unmount >/dev/null 2>&1
 	run_check _scratch_mount "-o atime"
 
 	if [ $do_bg_noise -ne 0 ]; then
diff --git a/tests/btrfs/005 b/tests/btrfs/005
index 7639635..c048ab5 100755
--- a/tests/btrfs/005
+++ b/tests/btrfs/005
@@ -106,12 +106,12 @@ _checksum()
 
 _cleanup_defrag()
 {
-	umount $SCRATCH_MNT > /dev/null 2>&1
+	_scratch_unmount > /dev/null 2>&1
 }
 
 _setup_defrag()
 {
-	umount $SCRATCH_MNT > /dev/null 2>&1
+	_scratch_unmount > /dev/null 2>&1
 	_scratch_mkfs > /dev/null 2>&1
 	_scratch_mount
 	_create_file $1
diff --git a/tests/btrfs/007 b/tests/btrfs/007
index f7f7423..82d093a 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -37,7 +37,7 @@ status=1
 _cleanup()
 {
 	echo "*** unmount"
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -61,7 +61,7 @@ workout()
 	fsz=$1
 	ops=$2
 
-	umount $SCRATCH_DEV >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
 	echo "*** mkfs -dsize=$fsz"    >>$seqres.full
 	echo ""                                     >>$seqres.full
 	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
@@ -87,7 +87,7 @@ workout()
 	run_check $FSSUM_PROG -A -f -w $tmp/incr.fssum -x $SCRATCH_MNT/incr/base \
 		$SCRATCH_MNT/incr
 
-	umount $SCRATCH_DEV >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
 	echo "*** mkfs -dsize=$fsz"    >>$seqres.full
 	echo ""                                     >>$seqres.full
 	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 0207057..1063d87 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -151,7 +151,7 @@ workout()
 	sync; sync
 
 	btrfs_replace_test $source_dev $target_dev "" $with_cancel $quick
-	umount $SCRATCH_MNT > /dev/null 2>&1
+	_scratch_unmount > /dev/null 2>&1
 
 	if echo $mkfs_options | egrep -qv "raid1|raid5|raid6|raid10" || \
 	   [ "${with_cancel}Q" = "cancelQ" ]; then
@@ -201,7 +201,7 @@ workout()
 	fi
 
 	btrfs_replace_test $source_dev $target_dev "-r" $with_cancel $quick
-	umount $SCRATCH_MNT > /dev/null 2>&1
+	_scratch_unmount > /dev/null 2>&1
 }
 
 btrfs_replace_test()
@@ -264,7 +264,7 @@ btrfs_replace_test()
 	# because in /proc/mounts the 2nd device of the filesystem is
 	# shown after the replace operation. Let's just do the mount
 	# test manually after _check_btrfs_filesystem is finished.
-	umount $SCRATCH_MNT > /dev/null 2>&1
+	_scratch_unmount > /dev/null 2>&1
 	if [ "${with_cancel}Q" != "cancelQ" ]; then
 		# after the replace operation, use the target_dev for everything
 		_check_btrfs_filesystem $target_dev
diff --git a/tests/btrfs/029 b/tests/btrfs/029
index 0b77b33..292692c 100755
--- a/tests/btrfs/029
+++ b/tests/btrfs/029
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    umount $SCRATCH_MNT &>/dev/null
+    _scratch_unmount &>/dev/null
     cd /
     rm -f $tmp.*
 }
@@ -103,7 +103,7 @@ _scratch_unmount
 echo "test reflinks across different mountpoints of same device"
 mount $TEST_DEV $SCRATCH_MNT || _fail "Couldn't double-mount $TEST_DEV"
 _create_reflinks_to $DUAL_MOUNT_DIR
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # success, all done
 status=0
diff --git a/tests/btrfs/031 b/tests/btrfs/031
index bcd332c..502ad09 100755
--- a/tests/btrfs/031
+++ b/tests/btrfs/031
@@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    umount $SCRATCH_MNT
+    _scratch_unmount
     rm -rf $TESTDIR1
     rm -rf $TESTDIR2
     $BTRFS_UTIL_PROG subvolume delete $SUBVOL1 >> $seqres.full
diff --git a/tests/ext4/002 b/tests/ext4/002
index 035ea7b..255a18f 100755
--- a/tests/ext4/002
+++ b/tests/ext4/002
@@ -78,7 +78,7 @@ _check_ext4_eof_flag()
     bit_set=1
 
     # Unmount the ${TEST_DEV}
-    umount ${TEST_DEV}
+    _test_unmount
 
     # Run debugfs to gather file_parameters - specifically iflags.
     file_params=`debugfs ${TEST_DEV} -R "stat ${1}" 2>&1 | grep -e Flags:`
diff --git a/tests/ext4/301 b/tests/ext4/301
index 568327d..d6547c5 100755
--- a/tests/ext4/301
+++ b/tests/ext4/301
@@ -112,7 +112,7 @@ _scratch_mkfs  >> $seqres.full 2>&1
 _scratch_mount
 
 if ! _workout; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	exit
 fi
 
diff --git a/tests/ext4/302 b/tests/ext4/302
index c604c8f..45cd28c 100755
--- a/tests/ext4/302
+++ b/tests/ext4/302
@@ -130,7 +130,7 @@ _scratch_mkfs  >> $seqres.full 2>&1
 _scratch_mount
 
 if ! _workout; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	exit
 fi
 
diff --git a/tests/ext4/303 b/tests/ext4/303
index 2d01f0f..64a6405 100755
--- a/tests/ext4/303
+++ b/tests/ext4/303
@@ -140,7 +140,7 @@ _scratch_mkfs  >> $seqres.full 2>&1
 _scratch_mount
 
 if ! _workout; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	exit
 fi
 
diff --git a/tests/ext4/304 b/tests/ext4/304
index 01c51a4..cc03190 100755
--- a/tests/ext4/304
+++ b/tests/ext4/304
@@ -117,7 +117,7 @@ _scratch_mkfs  >> $seqres.full 2>&1
 _scratch_mount
 
 if ! _workout; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	exit
 fi
 
diff --git a/tests/ext4/305 b/tests/ext4/305
index 860d0a6..466ce38 100755
--- a/tests/ext4/305
+++ b/tests/ext4/305
@@ -55,7 +55,7 @@ _scratch_mkfs >>$seqres.full 2>&1
 
 while true;do
 	mount $SCRATCH_DEV $SCRATCH_MNT
-	umount $SCRATCH_DEV
+	_scratch_unmount
 done &
 PIDS=$!
 
diff --git a/tests/generic/014 b/tests/generic/014
index 7961961..a3271a8 100755
--- a/tests/generic/014
+++ b/tests/generic/014
@@ -52,7 +52,7 @@ _require_sparse_files
 # by limiting the amount of preallocation and therefore the amount of blocks
 # zeroed during the truncfile test run.
 if [ "$FSTYP" == "xfs" ]; then
-	umount $TEST_DIR
+	_test_unmount
 	_test_mount -o allocsize=64k
 fi
 
diff --git a/tests/generic/015 b/tests/generic/015
index 8d3fd5f..66c33c2 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -36,7 +36,7 @@ status=1	# success is the default!
 
 _cleanup()
 {
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/019 b/tests/generic/019
index b387507..818d0c7 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -162,7 +162,7 @@ _workout()
 	wait $fio_pid
 
 	# We expect that broken FS still can be umounted
-	run_check umount $SCRATCH_DEV
+	run_check _scratch_unmount
 	# Once filesystem was umounted no one is able to write to block device
 	# It is now safe to bring device back to normal state
 	stop_fail_scratch_dev
diff --git a/tests/generic/043 b/tests/generic/043
index 47bc766..bd8eef8 100755
--- a/tests/generic/043
+++ b/tests/generic/043
@@ -64,9 +64,9 @@ sleep 10
 
 src/godown $SCRATCH_MNT
 
-umount $SCRATCH_MNT
+_scratch_unmount
 _scratch_mount
-umount $SCRATCH_MNT
+_scratch_unmount
 if [ ! _check_scratch_fs ]
 then
 	echo error detected in filesystem
diff --git a/tests/generic/044 b/tests/generic/044
index c59aaf3..f46e828 100755
--- a/tests/generic/044
+++ b/tests/generic/044
@@ -70,9 +70,9 @@ sleep 10
 
 src/godown $SCRATCH_MNT
 
-umount $SCRATCH_MNT
+_scratch_unmount
 _scratch_mount
-umount $SCRATCH_MNT
+_scratch_unmount
 if [ ! _check_scratch_fs ]
 then
 	echo error detected in filesystem
diff --git a/tests/generic/045 b/tests/generic/045
index 6c601a6..4ec7650 100755
--- a/tests/generic/045
+++ b/tests/generic/045
@@ -70,9 +70,9 @@ sleep 10
 
 src/godown $SCRATCH_MNT
 
-umount $SCRATCH_MNT
+_scratch_unmount
 _scratch_mount
-umount $SCRATCH_MNT
+_scratch_unmount
 if [ ! _check_scratch_fs ]
 then
 	echo error detected in filesystem
diff --git a/tests/generic/046 b/tests/generic/046
index 76993d4..08f1137 100755
--- a/tests/generic/046
+++ b/tests/generic/046
@@ -70,9 +70,9 @@ sleep 10
 
 src/godown $SCRATCH_MNT
 
-umount $SCRATCH_MNT
+_scratch_unmount
 _scratch_mount
-umount $SCRATCH_MNT
+_scratch_unmount
 if [ ! _check_scratch_fs ]
 then
 	echo error detected in filesystem
diff --git a/tests/generic/047 b/tests/generic/047
index 0418a3b..b894ee6 100755
--- a/tests/generic/047
+++ b/tests/generic/047
@@ -92,9 +92,9 @@ done
 
 # shutdown immediately after, then remount and test
 src/godown $SCRATCH_MNT
-umount $SCRATCH_MNT
+_scratch_unmount
 _scratch_mount
-umount $SCRATCH_MNT
+_scratch_unmount
 if [ ! _check_scratch_fs ]
 then
 	echo error detected in filesystem
diff --git a/tests/generic/048 b/tests/generic/048
index 558fe5f..6f5f444 100755
--- a/tests/generic/048
+++ b/tests/generic/048
@@ -96,9 +96,9 @@ done
 # sync, then shutdown immediately after, then remount and test
 sync
 src/godown $SCRATCH_MNT
-umount $SCRATCH_MNT
+_scratch_unmount
 _scratch_mount
-umount $SCRATCH_MNT
+_scratch_unmount
 if [ ! _check_scratch_fs ]
 then
 	echo error detected in filesystem
diff --git a/tests/generic/049 b/tests/generic/049
index 646d39e..320318e 100755
--- a/tests/generic/049
+++ b/tests/generic/049
@@ -93,9 +93,9 @@ done
 # sync, then shutdown immediately after, then remount and test
 sync
 src/godown $SCRATCH_MNT
-umount $SCRATCH_MNT
+_scratch_unmount
 _scratch_mount
-umount $SCRATCH_MNT
+_scratch_unmount
 if [ ! _check_scratch_fs ]
 then
 	echo error detected in filesystem
diff --git a/tests/generic/050 b/tests/generic/050
index a32e049..5fa28a7 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -70,7 +70,7 @@ touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
 #	http://oss.sgi.com/bugzilla/show_bug.cgi?id=807
 #
 echo "unmounting read-only filesystem"
-umount $SCRATCH_MNT 2>&1 | _filter_scratch
+_scratch_unmount 2>&1 | _filter_scratch
 
 echo "setting device read-write"
 blockdev --setrw $SCRATCH_DEV
@@ -85,7 +85,7 @@ echo "going down:"
 src/godown -f $SCRATCH_MNT
 
 echo "unmounting shutdown filesystem:"
-umount $SCRATCH_MNT 2>&1 | _filter_scratch
+_scratch_unmount 2>&1 | _filter_scratch
 
 echo "setting device read-only"
 blockdev --setro $SCRATCH_DEV
@@ -98,7 +98,7 @@ echo "mounting filesystem that needs recovery on a read-only device:"
 _scratch_mount 2>&1 | _filter_scratch | _filter_ro_mount
 
 echo "unmounting read-only filesystem"
-umount $SCRATCH_MNT 2>&1 | _filter_scratch
+_scratch_unmount 2>&1 | _filter_scratch
 
 #
 # This is the way out if the underlying device really is read-only.
@@ -109,7 +109,7 @@ echo "mounting filesystem with -o norecovery on a read-only device:"
 _scratch_mount -o norecovery 2>&1 | _filter_scratch | _filter_ro_mount
 
 echo "unmounting read-only filesystem"
-umount $SCRATCH_MNT 2>&1 | _filter_scratch
+_scratch_unmount 2>&1 | _filter_scratch
 
 echo "setting device read-write"
 blockdev --setrw $SCRATCH_DEV
diff --git a/tests/generic/051 b/tests/generic/051
index 614939f..d620807 100755
--- a/tests/generic/051
+++ b/tests/generic/051
@@ -39,7 +39,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -67,7 +67,7 @@ sleep $SLEEP_TIME
 killall -q $FSSTRESS_PROG
 wait
 sync
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # now mount again, run the load again, this time with a shutdown.
 _scratch_mount
@@ -84,11 +84,11 @@ wait
 
 # for some reason fsstress processes manage to live on beyond the wait?
 sleep 5
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # now recover, check the filesystem for consistency
 _scratch_mount
-umount $SCRATCH_MNT
+_scratch_unmount
 _check_scratch_fs
 
 # now clean up.
@@ -97,7 +97,7 @@ for d in $load_dir/*; do
         rm -rf $d > /dev/null 2>&1 &
 done
 wait
-umount $SCRATCH_MNT
+_scratch_unmount
 
 echo "No output is good. Failures are loud."
 
diff --git a/tests/generic/052 b/tests/generic/052
index 3430b65..a81885b 100755
--- a/tests/generic/052
+++ b/tests/generic/052
@@ -65,7 +65,7 @@ echo "godown"
 src/godown -v -f $SCRATCH_MNT >> $seqres.full
 
 echo "unmount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 echo "logprint after going down..."
 _print_logstate
@@ -85,7 +85,7 @@ echo "ls SCRATCH_MNT"
 ls $SCRATCH_MNT
 
 echo "unmount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 echo "logprint after mount and replay..."
 _print_logstate
diff --git a/tests/generic/053 b/tests/generic/053
index b8bd9e6..a0e7280 100755
--- a/tests/generic/053
+++ b/tests/generic/053
@@ -81,7 +81,7 @@ list_acls()
 
 echo "acls before repair:"
 list_acls
-_do 'unmount $SCRATCH_DEV' 'umount $SCRATCH_DEV'
+_do 'unmount $SCRATCH_DEV' '_scratch_unmount'
 _do 'repair filesystem' '_check_scratch_fs'
 _do 'mount filesytem' '_scratch_mount'
 echo "acls after repair: "
diff --git a/tests/generic/054 b/tests/generic/054
index 6cb0122..238741c 100755
--- a/tests/generic/054
+++ b/tests/generic/054
@@ -48,7 +48,7 @@ _require_scratch_shutdown
 _require_logstate
 
 echo "*** init FS"
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 
 _get_log_configs > $tmp.seq.params
 
@@ -108,7 +108,7 @@ for s in sync nosync ; do
 	src/godown -v -f $SCRATCH_MNT >> $seqres.full
 
 	_echofull "unmount"
-	umount $SCRATCH_DEV >>$seqres.full 2>&1 \
+	_scratch_unmount >>$seqres.full 2>&1 \
 	    || _fail "umount failed"
 
 	_echofull "logprint after going down..."
@@ -123,7 +123,7 @@ for s in sync nosync ; do
 	ls $SCRATCH_MNT
 
 	_echofull "unmount"
-	umount $SCRATCH_MNT
+	_scratch_unmount
 
 	_echofull "logprint after mount and replay..."
 	_print_logstate
diff --git a/tests/generic/055 b/tests/generic/055
index 82ec331..207c007 100755
--- a/tests/generic/055
+++ b/tests/generic/055
@@ -77,7 +77,7 @@ _require_logstate
 QUOTA_OPTION=`_get_quota_option`
 
 echo "*** init FS"
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 
 _get_log_configs > $tmp.seq.params
 
@@ -118,7 +118,7 @@ do
     src/godown -v -f $SCRATCH_MNT >> $seqres.full
 
     _echofull "unmount"
-    umount $SCRATCH_DEV >>$seqres.full 2>&1 \
+    _scratch_unmount >>$seqres.full 2>&1 \
 	|| _fail "umount failed"
 
     _echofull "logprint after going down..."
@@ -139,7 +139,7 @@ do
     diff -us $tmp.ls1 $tmp.ls2 | sed "s#$tmp#TMP#g"
 
     _echofull "unmount"
-    umount $SCRATCH_MNT
+    _scratch_unmount
 
     _echofull "logprint after mount and replay..."
     _print_logstate
diff --git a/tests/generic/058 b/tests/generic/058
old mode 100644
new mode 100755
diff --git a/tests/generic/060 b/tests/generic/060
old mode 100644
new mode 100755
diff --git a/tests/generic/061 b/tests/generic/061
old mode 100644
new mode 100755
diff --git a/tests/generic/062 b/tests/generic/062
index 047c930..90fcbda 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -40,7 +40,7 @@ _cleanup()
 {
         cd /
 	echo; echo "*** unmount"
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/063 b/tests/generic/063
old mode 100644
new mode 100755
diff --git a/tests/generic/064 b/tests/generic/064
old mode 100644
new mode 100755
diff --git a/tests/generic/068 b/tests/generic/068
index 7794326..f9f5f5a 100755
--- a/tests/generic/068
+++ b/tests/generic/068
@@ -57,7 +57,7 @@ _require_freeze
 echo "*** init FS"
 
 rm -f $seqres.full
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs                               >>$seqres.full 2>&1 \
diff --git a/tests/generic/069 b/tests/generic/069
index c3fa862..aaf6bbf 100755
--- a/tests/generic/069
+++ b/tests/generic/069
@@ -42,7 +42,7 @@ _supported_os IRIX Linux
 _require_scratch
 rm -f $seqres.full
 
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 
 echo "*** mkfs"
 _scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
diff --git a/tests/generic/076 b/tests/generic/076
index aa0aae0..181416e 100755
--- a/tests/generic/076
+++ b/tests/generic/076
@@ -42,7 +42,7 @@ _lets_get_pidst()
 _cleanup()
 {
 	echo "*** unmount"
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	_lets_get_pidst
 }
 trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
@@ -61,7 +61,7 @@ _require_block_device $SCRATCH_DEV
 echo "*** init fs"
 
 rm -f $seqres.full
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs                               >>$seqres.full 2>&1 \
diff --git a/tests/generic/077 b/tests/generic/077
index 0d6aec7..f220ff0 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -39,7 +39,7 @@ _cleanup()
 {
 	cd /
 	echo "*** unmount"
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 }
 trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
 
@@ -61,7 +61,7 @@ _require_user
 echo "*** create filesystem"
 
 rm -f $seqres.full
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 SIZE=`expr 50 \* 1024 \* 1024`
diff --git a/tests/generic/079 b/tests/generic/079
index a533484..939c817 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -37,7 +37,7 @@ _cleanup()
     cd /
     echo "*** cleaning up"
     $timmutable -r $SCRATCH_MNT/$seq
-    umount $SCRATCH_MNT
+    _scratch_unmount
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/083 b/tests/generic/083
index 61316bf..2f8c4a0 100755
--- a/tests/generic/083
+++ b/tests/generic/083
@@ -42,7 +42,7 @@ status=1
 _cleanup()
 {
 	echo "*** unmount"
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -67,7 +67,7 @@ workout()
 	procs=$3
 	nops=$4
 
-	umount $SCRATCH_DEV >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
 	echo "*** mkfs -dsize=$fsz,agcount=$ags"    >>$seqres.full
 	echo ""                                     >>$seqres.full
 	if [ $FSTYP = xfs ]
diff --git a/tests/generic/105 b/tests/generic/105
index 2f99401..9b7beb4 100755
--- a/tests/generic/105
+++ b/tests/generic/105
@@ -57,7 +57,7 @@ _require_acls
 
 _acl_setup_ids
 
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs                               >>$seqres.full 2>&1 \
diff --git a/tests/generic/117 b/tests/generic/117
index 935dcaf..b634861 100755
--- a/tests/generic/117
+++ b/tests/generic/117
@@ -82,7 +82,7 @@ _require_scratch
 _require_attrs
 
 rm -f $seqres.full
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs                               >>$seqres.full 2>&1 \
@@ -105,7 +105,7 @@ while [ $i -lt $ITERATIONS ]; do
 done
 
 cd /
-umount $SCRATCH_MNT
+_scratch_unmount
 echo 
 echo Checking filesystem
 
diff --git a/tests/generic/120 b/tests/generic/120
index fb7c8cb..4271344 100755
--- a/tests/generic/120
+++ b/tests/generic/120
@@ -92,7 +92,7 @@ echo "*** writing to file ***"
 echo "asdf" >> $SCRATCH_MNT/testfile2
 _compare_access_times $SCRATCH_MNT/testfile2 "writing file"
 
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # success, all done
 status=0
diff --git a/tests/generic/124 b/tests/generic/124
index 888bbc0..b78c189 100755
--- a/tests/generic/124
+++ b/tests/generic/124
@@ -75,6 +75,6 @@ if (test $? -eq 0 ) then
     status=0
 fi
 
-umount $SCRATCH_DEV
+_scratch_unmount
 
 exit 
diff --git a/tests/generic/128 b/tests/generic/128
index 22e4f71..39fc807 100755
--- a/tests/generic/128
+++ b/tests/generic/128
@@ -54,7 +54,7 @@ su -s/bin/bash - $qa_user -c "$SCRATCH_MNT/ls $SCRATCH_MNT/nosuid >/dev/null 2>&
 if [ $? -eq 0 ] ; then
 	echo "Error: we shouldn't be able to ls the directory"
 fi
-umount $SCRATCH_DEV
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/135 b/tests/generic/135
index 79558f5..3f83369 100755
--- a/tests/generic/135
+++ b/tests/generic/135
@@ -48,7 +48,7 @@ _umount_mount()
     CWD=`pwd`
     cd /
     # pipe error into /dev/null, in case not mounted (after _require_scratch)
-    umount $SCRATCH_MNT 2>/dev/null
+    _scratch_unmount 2>/dev/null
     _scratch_mount
     cd "$CWD"
 }
diff --git a/tests/generic/169 b/tests/generic/169
index ebeffa7..839ff9d 100755
--- a/tests/generic/169
+++ b/tests/generic/169
@@ -74,7 +74,7 @@ $XFS_IO_PROG -a -c "pwrite 0 5k" -c "fsync" \
 	| _show_wrote_and_stat_only
 
 echo "# unmounting scratch"
-umount $SCRATCH_MNT>>$seqres.full 2>&1 \
+_scratch_unmount>>$seqres.full 2>&1 \
     || _fail "unmount failed"
 
 echo "# mounting scratch"
@@ -91,7 +91,7 @@ $XFS_IO_PROG -f -c "pwrite 0 5" -c s -c "pwrite 5 5" \
 	| _show_wrote_and_stat_only
 
 echo "# unmounting scratch"
-umount $SCRATCH_MNT>>$seqres.full 2>&1 \
+_scratch_unmount>>$seqres.full 2>&1 \
     || _fail "unmount failed"
 
 echo "# mounting scratch"
diff --git a/tests/generic/192 b/tests/generic/192
index 5b6cfbc..ebabea2 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -78,7 +78,7 @@ cat $testfile
 time2=`_access_time $testfile | tee -a $seqres.full`
 
 cd /
-umount $TEST_DIR
+_test_unmount
 _test_mount
 time3=`_access_time $testfile | tee -a $seqres.full`
 
diff --git a/tests/generic/219 b/tests/generic/219
index 2b75b89..bdeb033 100755
--- a/tests/generic/219
+++ b/tests/generic/219
@@ -106,12 +106,12 @@ test_accounting()
 # real QA test starts here
 rm -f $seqres.full
 
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
 quotacheck -u -g $SCRATCH_MNT 2>/dev/null
 quotaon $SCRATCH_MNT 2>/dev/null
-umount $SCRATCH_DEV
+_scratch_unmount
 
 echo; echo "### test user accounting"
 export MOUNT_OPTIONS="-o usrquota"
@@ -120,7 +120,7 @@ quotaon $SCRATCH_MNT 2>/dev/null
 type=u
 test_files
 test_accounting
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 echo; echo "### test group accounting"
 export MOUNT_OPTIONS="-o grpquota"
@@ -129,7 +129,7 @@ quotaon $SCRATCH_MNT 2>/dev/null
 type=g
 test_files
 test_accounting
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 status=0
 exit
diff --git a/tests/generic/226 b/tests/generic/226
index 4ad56a5..b12965a 100755
--- a/tests/generic/226
+++ b/tests/generic/226
@@ -42,7 +42,7 @@ _require_odirect
 # real QA test starts here
 rm -f $seqres.full
 
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 echo "--> mkfs 256m filesystem"
 _scratch_mkfs_sized `expr 256 \* 1024 \* 1024` >> $seqres.full 2>&1
 _scratch_mount
@@ -61,7 +61,7 @@ for I in `seq 1 $loops`; do
 done
 
 echo
-umount $SCRATCH_DEV
+_scratch_unmount
 _scratch_mount
 
 echo "--> $loops direct 64m writes in a loop"
@@ -73,7 +73,7 @@ for I in `seq 1 $loops`; do
 done
 
 echo
-umount $SCRATCH_DEV
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/230 b/tests/generic/230
index b77210f..0b1b3bf 100755
--- a/tests/generic/230
+++ b/tests/generic/230
@@ -122,7 +122,7 @@ setquota -u $qa_user 1000 2000 3 5 $SCRATCH_MNT
 setquota -u -t $grace $grace $SCRATCH_MNT
 setquota -g $qa_user 1000 2000 3 5 $SCRATCH_MNT
 setquota -g -t $grace $grace $SCRATCH_MNT
-umount $SCRATCH_DEV
+_scratch_unmount
 
 echo; echo "### test user limit enforcement"
 _scratch_mount "-o usrquota"
@@ -131,7 +131,7 @@ type=u
 test_files
 test_enforcement
 cleanup_files
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 echo; echo "### test group limit enforcement"
 _scratch_mount "-o grpquota"
@@ -140,7 +140,7 @@ type=g
 test_files
 test_enforcement
 cleanup_files
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 status=0
 exit
diff --git a/tests/generic/231 b/tests/generic/231
index df7d76c..feda0c1 100755
--- a/tests/generic/231
+++ b/tests/generic/231
@@ -78,25 +78,25 @@ quotacheck -u -g $SCRATCH_MNT 2>/dev/null
 quotaon -u -g $SCRATCH_MNT 2>/dev/null
 
 if ! _fsx 1; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	status=1
 	exit
 fi
 
 if ! _check_quota_usage; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	status=1
 	exit
 fi
 
 if ! _fsx 4; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	status=1
 	exit
 fi
 
 if ! _check_quota_usage; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	status=1
 	exit
 fi
@@ -104,17 +104,17 @@ fi
 #flush cache after write
 FSX_ARGS="-f $FSX_ARGS"
 if ! _fsx 1; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	status=1
 	exit
 fi
 
 if ! _check_quota_usage; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	status=1
 	exit
 fi
 
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 status=0
 exit
diff --git a/tests/generic/232 b/tests/generic/232
index 8ada8aa..b3f6b7e 100755
--- a/tests/generic/232
+++ b/tests/generic/232
@@ -78,16 +78,16 @@ quotacheck -u -g $SCRATCH_MNT 2>/dev/null
 quotaon -u -g $SCRATCH_MNT 2>/dev/null
 
 if ! _fsstress; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	exit
 fi
 
 if ! _check_quota_usage; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	status=1
 	exit
 fi
 
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 status=0
 exit
diff --git a/tests/generic/233 b/tests/generic/233
index 58b3672..95255f8 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -87,16 +87,16 @@ quotaon -u -g $SCRATCH_MNT 2>/dev/null
 setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
 
 if ! _fsstress; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	exit
 fi
 
 if ! _check_quota_usage; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	status=1
 	exit
 fi
 
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 status=0
 exit
diff --git a/tests/generic/234 b/tests/generic/234
index eb0871f..30be0e9 100755
--- a/tests/generic/234
+++ b/tests/generic/234
@@ -101,7 +101,7 @@ _scratch_mount "-o usrquota,grpquota"
 quotacheck -u -g $SCRATCH_MNT 2>/dev/null
 quotaon -u -g $SCRATCH_MNT 2>/dev/null
 test_setting
-umount $SCRATCH_DEV
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/235 b/tests/generic/235
index bbc99e0..07f1b5e 100755
--- a/tests/generic/235
+++ b/tests/generic/235
@@ -73,7 +73,7 @@ $XFS_IO_PROG -c 'pwrite 0 8k' -c 'fsync' \
 			$SCRATCH_MNT/testfile >>$seqres.full 2>&1
 repquota -u -g $SCRATCH_MNT  | grep -v "^root" | _filter_scratch
 
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 status=0
 exit
diff --git a/tests/generic/256 b/tests/generic/256
index 086c00a..cfbf790 100755
--- a/tests/generic/256
+++ b/tests/generic/256
@@ -165,7 +165,7 @@ _test_full_fs_punch()
 }
 
 # Make a small file system to fill
-umount $SCRATCH_DEV &> /dev/null
+_scratch_unmount &> /dev/null
 _scratch_mkfs_sized $(( 1536 * 1024 * 1024 )) &> /dev/null
 _scratch_mount
 # Test must be able to write files with non-root permissions
diff --git a/tests/generic/258 b/tests/generic/258
index b9b5cf9..285a422 100755
--- a/tests/generic/258
+++ b/tests/generic/258
@@ -62,7 +62,7 @@ fi
 
 # unmount, remount, and check the timestamp
 echo "Remounting to flush cache"
-umount $TEST_DEV
+_test_unmount
 _test_mount
 
 # Should yield -315593940 (prior to epoch)
diff --git a/tests/generic/269 b/tests/generic/269
index cff5e54..ab37e84 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -70,7 +70,7 @@ _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
 
 if ! _workout; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	exit
 fi
 
diff --git a/tests/generic/274 b/tests/generic/274
index 2d8d496..61ab220 100755
--- a/tests/generic/274
+++ b/tests/generic/274
@@ -56,7 +56,7 @@ echo "------------------------------"
 
 rm -f $seqres.full
 
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
diff --git a/tests/generic/275 b/tests/generic/275
index 7382edb..b0777eb 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -53,7 +53,7 @@ echo "------------------------------"
 
 rm -f $seqres.full
 
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
diff --git a/tests/generic/280 b/tests/generic/280
index 7a2d1d0..069d46d 100755
--- a/tests/generic/280
+++ b/tests/generic/280
@@ -54,7 +54,7 @@ _supported_fs generic
 
 rm -f $seqres.full
 
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
 quotacheck -u -g $SCRATCH_MNT 2>/dev/null
@@ -65,7 +65,7 @@ pid=$!
 sleep 1
 xfs_freeze -u $SCRATCH_MNT
 wait $pid
-umount $SCRATCH_DEV
+_scratch_unmount
 
 # Failure comes in the form of a deadlock.
 
diff --git a/tests/generic/299 b/tests/generic/299
index 0459f42..4174de0 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -148,7 +148,7 @@ _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 
 if ! _workout; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	exit
 fi
 
diff --git a/tests/generic/300 b/tests/generic/300
index d7523aa..a12aba6 100755
--- a/tests/generic/300
+++ b/tests/generic/300
@@ -147,7 +147,7 @@ _scratch_mkfs_sized $FS_SIZE >> $seqres.full 2>&1
 _scratch_mount
 
 if ! _workout; then
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	exit
 fi
 
diff --git a/tests/generic/317 b/tests/generic/317
index efa37c7..68f231c 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -37,7 +37,7 @@ status=1	# failure is the default!
 _cleanup()
 {
     cd /
-    umount $SCRATCH_DEV >/dev/null 2>&1
+    _scratch_unmount >/dev/null 2>&1
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -80,7 +80,7 @@ _print_numeric_uid()
     src/nsexec -s -U -M "0 $qa_user_id 1000" -G "0 $qa_user_id 1000" src/lstat64 $file |head -3 |_filter_output
 }
 
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***" >>$seqres.full
 echo ""             >>$seqres.full
 _scratch_mkfs       >>$seqres.full 2>&1 || _fail "mkfs failed"
@@ -96,11 +96,11 @@ echo ""
 echo "*** Remounting ***"
 echo ""
 sync
-umount $SCRATCH_MNT >>$seqres.full 2>&1
+_scratch_unmount >>$seqres.full 2>&1
 _scratch_mount      >>$seqres.full 2>&1 || _fail "mount failed"
 
 _print_numeric_uid
 
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 status=0
 exit
diff --git a/tests/generic/318 b/tests/generic/318
index 8237434..c730b50 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -38,7 +38,7 @@ status=1	# failure is the default!
 _cleanup()
 {
     cd /
-    umount $SCRATCH_DEV >/dev/null 2>&1
+    _scratch_unmount >/dev/null 2>&1
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -90,7 +90,7 @@ _print_getfacls()
     $nsexec -U -M "0 $acl1 1000" -G "0 $acl1 1000" getfacl --absolute-names -n $file 2>/dev/null | _filter_scratch | _getfacl_filter_nsid
 }
 
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***" >>$seqres.full
 echo ""             >>$seqres.full
 _scratch_mkfs       >>$seqres.full 2>&1 || _fail "mkfs failed"
@@ -109,11 +109,11 @@ _print_getfacls
 echo "*** Remounting ***"
 echo ""
 sync
-umount $SCRATCH_MNT >>$seqres.full 2>&1
+_scratch_unmount >>$seqres.full 2>&1
 _scratch_mount      >>$seqres.full 2>&1 || _fail "mount failed"
 
 _print_getfacls
 
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 status=0
 exit
diff --git a/tests/shared/289 b/tests/shared/289
index c53d38c..c45c9e6 100755
--- a/tests/shared/289
+++ b/tests/shared/289
@@ -89,11 +89,11 @@ OVERHEAD=$(($TOTAL_BLOCKS-$FREE_BLOCKS-$JOURNAL_BLOCKS))
 
 _scratch_mount "-o minixdf"
 MINIX_F_BLOCKS=`stat -f $SCRATCH_MNT | awk '/^Blocks/{print $3}'`
-umount $SCRATCH_MNT
+_scratch_unmount
 
 _scratch_mount "-o bsddf"
 BSD_F_BLOCKS=`stat -f $SCRATCH_MNT | awk '/^Blocks/{print $3}'`
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # Echo data to $seqres.full for analysis
 echo "Overhead is $OVERHEAD blocks out of $TOTAL_BLOCKS ($FREE_BLOCKS free)" >> $seqres.full
diff --git a/tests/udf/098 b/tests/udf/098
index 3a5db39..09792a7 100755
--- a/tests/udf/098
+++ b/tests/udf/098
@@ -66,7 +66,7 @@ _db_filter()
 _umount_check_mount()
 {
     cd /
-    umount $SCRATCH_MNT
+    _scratch_unmount
 
     udf_db -f $SCRATCH_DEV | _db_filter
 
@@ -244,7 +244,7 @@ echo "list root EAs: none"
 ${ATTR_PROG} -R -l foo
 
 cd /
-umount $SCRATCH_MNT
+_scratch_unmount
 
 udf_db -f $SCRATCH_DEV | _db_filter
 
@@ -258,7 +258,7 @@ echo "delete the file foo - which will delete the associated streams"
 rm foo
 
 cd /
-umount $SCRATCH_MNT
+_scratch_unmount
 
 udf_db -f $SCRATCH_DEV | _db_filter
 
diff --git a/tests/udf/101 b/tests/udf/101
index 0f5fe87..9609c07 100755
--- a/tests/udf/101
+++ b/tests/udf/101
@@ -49,7 +49,7 @@ MKFS_OPTIONS="-s $FS_SIZE"
 
 _require_scratch
 _setup_udf_scratchdir
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # Inspect the space bitmap
 echo bitmap | udf_db -c - $SCRATCH_DEV
diff --git a/tests/xfs/004 b/tests/xfs/004
index 978943d..cf17286 100755
--- a/tests/xfs/004
+++ b/tests/xfs/004
@@ -32,7 +32,7 @@ status=0
 
 _cleanup()
 {
-	umount $SCRATCH_MNT
+	_scratch_unmount
 	rm -f $tmp.*
 	exit $status
 }
@@ -48,7 +48,7 @@ _populate_scratch()
 	dd if=/dev/zero of=$SCRATCH_MNT/goo count=400 bs=4096 >/dev/null 2>&1 &
 	dd if=/dev/zero of=$SCRATCH_MNT/moo count=800 bs=4096 >/dev/null 2>&1 &
 	wait
-	umount $SCRATCH_MNT			# flush everything
+	_scratch_unmount			# flush everything
 	_scratch_mount				# and then remount
 }
 
diff --git a/tests/xfs/006 b/tests/xfs/006
index fa84e40..13631be 100755
--- a/tests/xfs/006
+++ b/tests/xfs/006
@@ -54,7 +54,7 @@ _scratch_mount | _filter_scratch
 
 mkdir $SCRATCH_MNT/x
 $here/src/dirhash_collide -d -n 10000 $SCRATCH_MNT/x
-umount $SCRATCH_MNT 2>&1 | _filter_scratch
+_scratch_unmount 2>&1 | _filter_scratch
 
 _scratch_xfs_repair 2>&1 | _filter_repair
 
diff --git a/tests/xfs/007 b/tests/xfs/007
index 01cc421..8e85e5c 100755
--- a/tests/xfs/007
+++ b/tests/xfs/007
@@ -59,7 +59,7 @@ do_test()
 	off_opts=$3
 
 	echo "*** umount"
-	umount $SCRATCH_MNT
+	_scratch_unmount
 
 	QINO_1=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | \
 			grep $qino_1 | awk '{print $NF}'`
@@ -75,7 +75,7 @@ do_test()
 	xfs_quota -x -c "off -$off_opts" $SCRATCH_MNT
 	xfs_quota -x -c "remove -$off_opts" $SCRATCH_MNT
 	echo "*** umount"
-	umount $SCRATCH_MNT
+	_scratch_unmount
 
 	echo "*** Usage after quotarm ***"
 	xfs_db -c "inode $QINO_1" -c "p core.nblocks" $SCRATCH_DEV
diff --git a/tests/xfs/009 b/tests/xfs/009
index d0850c6..abef2e0 100755
--- a/tests/xfs/009
+++ b/tests/xfs/009
@@ -37,7 +37,7 @@ bsize=4096
 _cleanup()
 {
     echo "*** unmount"
-    umount $SCRATCH_MNT
+    _scratch_unmount
 }
 
 _block_filter()
diff --git a/tests/xfs/010 b/tests/xfs/010
index fd2e27c..d350d64 100755
--- a/tests/xfs/010
+++ b/tests/xfs/010
@@ -40,7 +40,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -114,7 +114,7 @@ _scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | _filter_mkfs 2>$seqres.full
 # sparsely populate the fs such that we create records with free inodes
 _scratch_mount
 _sparse_inode_populate $SCRATCH_MNT 999
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # corrupt some finobt records
 _corrupt_finobt_records $SCRATCH_DEV
diff --git a/tests/xfs/011 b/tests/xfs/011
index 197752c..e84faa5 100755
--- a/tests/xfs/011
+++ b/tests/xfs/011
@@ -40,7 +40,7 @@ _cleanup()
 	killall -9 fsstress 2>/dev/null
 	wait
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -109,7 +109,7 @@ done
 killall $FSSTRESS_PROG
 wait
 
-umount $SCRATCH_MNT
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/xfs/013 b/tests/xfs/013
index dea3d08..3a96fea 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -43,7 +43,7 @@ _cleanup()
 	killall -9 fsstress 2>/dev/null
 	wait
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -149,7 +149,7 @@ wait
 rm -rf $SCRATCH_MNT/fsstress
 rm -rf $SCRATCH_MNT/dir*
 
-umount $SCRATCH_MNT
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/xfs/014 b/tests/xfs/014
index 8866bfe..8974d1f 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -44,7 +44,7 @@ _cleanup()
 {
 	cd /
 	umount $LOOP_MNT 2>/dev/null
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -193,7 +193,7 @@ umount $LOOP_MNT
 
 echo $orig_sp_time > /proc/sys/fs/xfs/speculative_prealloc_lifetime
 
-umount $SCRATCH_MNT
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/xfs/016 b/tests/xfs/016
index e52f80c..0163716 100755
--- a/tests/xfs/016
+++ b/tests/xfs/016
@@ -50,7 +50,7 @@ _cleanup()
     cd /
     rm -f $tmp.*
     echo "*** unmount"
-    umount $SCRATCH_MNT 2>/dev/null
+    _scratch_unmount 2>/dev/null
 }
 
 _block_filter()
@@ -116,7 +116,7 @@ _log_traffic()
     done
 
     echo "   *** unmount"
-    if ! umount $SCRATCH_DEV
+    if ! _scratch_unmount
     then
         echo "failed to unmount $SCRATCH_DEV"
         exit 1
diff --git a/tests/xfs/017 b/tests/xfs/017
index 9fc16c2..b576cd1 100755
--- a/tests/xfs/017
+++ b/tests/xfs/017
@@ -34,7 +34,7 @@ trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
 _cleanup()
 {
     echo "*** unmount"
-    umount $SCRATCH_MNT 2>/dev/null
+    _scratch_unmount 2>/dev/null
 }
 
 # get standard environment, filters and checks
@@ -54,7 +54,7 @@ _require_no_large_scratch_dev
 echo "*** init FS"
 
 rm -f $seqres.full
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs_xfs                           >>$seqres.full 2>&1 \
diff --git a/tests/xfs/018 b/tests/xfs/018
index f097b28..9cde539 100755
--- a/tests/xfs/018
+++ b/tests/xfs/018
@@ -41,7 +41,7 @@ _cleanup()
     cd /
     _cleanup_logfiles
     rm -f $tmp.*
-    umount $SCRATCH_MNT 2>/dev/null
+    _scratch_unmount 2>/dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -57,7 +57,7 @@ _require_v2log
 _link_out_file $seq.op $seqfull.op
 
 echo "*** init FS"
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 
 cat >$tmp.seq.params <<EOF
 # mkfs-opt        mount-opt
diff --git a/tests/xfs/019 b/tests/xfs/019
index 09670b9..4d2fded 100755
--- a/tests/xfs/019
+++ b/tests/xfs/019
@@ -37,7 +37,7 @@ status=1	# failure is the default!
 _cleanup()
 {
     echo "*** unmount"
-    umount $SCRATCH_MNT 2>/dev/null
+    _scratch_unmount 2>/dev/null
     rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -111,7 +111,7 @@ _verify_fs()
 	VERSION="-n version=$1"
 
 	rm -f $seqfull
-	umount $SCRATCH_DEV >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
 
 	_full "mkfs"
 	_scratch_mkfs_xfs $VERSION -p $protofile >>$seqfull 2>&1 \
@@ -134,7 +134,7 @@ _verify_fs()
 
 	echo "*** unmount FS"
 	_full "umount"
-	umount $SCRATCH_DEV >>$seqfull 2>&1 \
+	_scratch_unmount >>$seqfull 2>&1 \
 		|| _fail "umount failed"
 }
 
diff --git a/tests/xfs/021 b/tests/xfs/021
index a548092..795b71c 100755
--- a/tests/xfs/021
+++ b/tests/xfs/021
@@ -37,7 +37,7 @@ status=0	# success is the default!
 _cleanup()
 {
 	echo "*** unmount"
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -80,7 +80,7 @@ _require_scratch
 _require_attrs
 
 rm -f $seqres.full
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 
 echo "*** mkfs"
 _scratch_mkfs_xfs >/dev/null \
@@ -125,7 +125,7 @@ echo ""
 inum_2=`ls -li $testfile.2 | $AWK_PROG '{ print $1 }'`
 
 echo "*** unmount FS"
-umount $SCRATCH_DEV >>$seqres.full 2>&1 \
+_scratch_unmount >>$seqres.full 2>&1 \
 	|| _fail "umount failed"
 
 echo "*** dump attributes (1)"
diff --git a/tests/xfs/030 b/tests/xfs/030
index a43455f..294f35a 100755
--- a/tests/xfs/030
+++ b/tests/xfs/030
@@ -34,7 +34,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 
@@ -87,7 +87,7 @@ else
 		_notrun "GQuota are enabled, test needs controlled sb recovery"
 	src/feature -P $SCRATCH_DEV && \
 		_notrun "PQuota are enabled, test needs controlled sb recovery"
-	umount $SCRATCH_DEV
+	_scratch_unmount
 fi
 clear=""
 eval `xfs_db -r -c "sb 1" -c stack $SCRATCH_DEV | perl -ne '
diff --git a/tests/xfs/033 b/tests/xfs/033
index 576d437..767fb7a 100755
--- a/tests/xfs/033
+++ b/tests/xfs/033
@@ -34,7 +34,7 @@ status=1	# failure is the default!
 _cleanup()
 {
     cd /
-    umount $SCRATCH_DEV 2>/dev/null
+    _scratch_unmount 2>/dev/null
     rm -f $tmp.*
 }
 
@@ -101,7 +101,7 @@ src/feature -G $SCRATCH_DEV && \
 	_notrun "GQuota are enabled, test needs controlled sb recovery"
 src/feature -P $SCRATCH_DEV && \
 	_notrun "PQuota are enabled, test needs controlled sb recovery"
-umount $SCRATCH_DEV
+_scratch_unmount
 
 # rootino, rbmino, and rsumino are now set (lets blow em away!)
 _check_root_inos 0
diff --git a/tests/xfs/034 b/tests/xfs/034
index 6beeb56..2bf319b 100755
--- a/tests/xfs/034
+++ b/tests/xfs/034
@@ -35,7 +35,7 @@ _cleanup()
     cd /
     rm -f $tmp.*
     echo "*** unmount"
-    umount $SCRATCH_MNT 2>/dev/null
+    _scratch_unmount 2>/dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -52,7 +52,7 @@ _require_scratch
 echo "*** init FS"
 
 rm -f $seqres.full
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs_xfs                           >>$seqres.full 2>&1 \
diff --git a/tests/xfs/041 b/tests/xfs/041
index 8b109fc..5038528 100755
--- a/tests/xfs/041
+++ b/tests/xfs/041
@@ -35,7 +35,7 @@ status=1	# failure is the default!
 _cleanup()
 {
     cd /
-    umount $SCRATCH_MNT
+    _scratch_unmount
     rm -f $tmp.*
 }
 trap "_cleanup ; exit \$status" 0 1 2 3 15
@@ -50,7 +50,7 @@ _supported_os IRIX Linux
 
 _require_scratch
 _require_no_large_scratch_dev
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 _fill()
 {
@@ -80,7 +80,7 @@ do
     _fill $SCRATCH_MNT/fill_$size
     _do "Grow filesystem to ${size}m" "xfs_growfs -D $grow_size $SCRATCH_MNT"
     echo -n "Flush filesystem... "
-    _do "umount $SCRATCH_MNT"
+    _do "_scratch_unmount"
     _do "_scratch_mount"
     echo "done"
     echo -n "Check files... "
diff --git a/tests/xfs/042 b/tests/xfs/042
index 77dd704..68f551c 100755
--- a/tests/xfs/042
+++ b/tests/xfs/042
@@ -35,7 +35,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    umount $SCRATCH_MNT
+    _scratch_unmount
     rm -f $tmp.*
 }
 trap "_cleanup ; exit \$status" 0 1 2 3 15
@@ -114,7 +114,7 @@ done
 _do "xfs_bmap -vp $SCRATCH_MNT/fill"
 echo "done"
 # flush the filesystem - make sure there is no space "lost" to pre-allocation
-_do "umount $SCRATCH_MNT"
+_do "_scratch_unmount"
 _do "_scratch_mount"
 echo -n "Use up any further available space using dd... "
 _do "dd if=/dev/zero of=$SCRATCH_MNT/pad bs=4096"
diff --git a/tests/xfs/044 b/tests/xfs/044
index a84af22..2ffd74f 100755
--- a/tests/xfs/044
+++ b/tests/xfs/044
@@ -68,7 +68,7 @@ _check_mount()
     fi
 
     echo "    *** umount"
-    if ! umount $SCRATCH_DEV
+    if ! _scratch_unmount
     then
         echo "        !!! umount failed (expecting success)"
         status=1
diff --git a/tests/xfs/050 b/tests/xfs/050
index 6641e7d..130df77 100755
--- a/tests/xfs/050
+++ b/tests/xfs/050
@@ -39,7 +39,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -197,7 +197,7 @@ _exercise()
 
 	echo
 	echo "*** unmount"
-	umount $SCRATCH_MNT
+	_scratch_unmount
 
 }
 
diff --git a/tests/xfs/052 b/tests/xfs/052
index c2cf596..18cf037 100755
--- a/tests/xfs/052
+++ b/tests/xfs/052
@@ -41,7 +41,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -107,7 +107,7 @@ echo ===quota output >> $seqres.full
 cat $tmp.quota >> $seqres.full
 [ ! -s $tmp.quota ] && echo "warning: quota output file is empty"
 
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # note - does (insitu) conversion from fs blocks to 1K blocks
 xfs_db -rc "dquot -$type $id" -c p $SCRATCH_DEV | tee -a $seqres.full | perl -ne '
diff --git a/tests/xfs/054 b/tests/xfs/054
index 8c18050..ea0f9f8 100755
--- a/tests/xfs/054
+++ b/tests/xfs/054
@@ -38,7 +38,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -96,7 +96,7 @@ _exercise()
 	src/lstat64 $SCRATCH_MNT/testfile | _filter_stat
 
 	echo
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 }
 
 _scratch_mkfs_xfs >> $seqres.full 2>&1 || _fail "mkfs failed!"
@@ -108,7 +108,7 @@ if src/feature -G $SCRATCH_DEV ; then
 else
 	_notrun "No quota support at mount time"
 fi
-umount $SCRATCH_MNT 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 _qmount_option "rw" # no quota options
 echo "*** Default mount options"
diff --git a/tests/xfs/065 b/tests/xfs/065
index a4faa82..6b2139f 100755
--- a/tests/xfs/065
+++ b/tests/xfs/065
@@ -64,7 +64,7 @@ _supported_os IRIX Linux
 # too much hassle to get output matching with quotas turned on
 # so don't run it
 #
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 _scratch_mount
 $here/src/feature -U $SCRATCH_DEV && \
 	_notrun "UQuota enabled, test needs controlled xfsdump output"
@@ -72,7 +72,7 @@ $here/src/feature -G $SCRATCH_DEV && \
 	_notrun "GQuota enabled, test needs controlled xfsdump output"
 $here/src/feature -P $SCRATCH_DEV && \
 	_notrun "PQuota enabled, test needs controlled xfsdump output"
-umount $SCRATCH_DEV
+_scratch_unmount
 
 #
 # adding      - touch/echo, mkdir
diff --git a/tests/xfs/071 b/tests/xfs/071
index 86c6899..1287454 100755
--- a/tests/xfs/071
+++ b/tests/xfs/071
@@ -35,7 +35,7 @@ _cleanup()
 {
     cd /
     rm -f $tmp.*
-    umount $SCRATCH_DEV 2>/dev/null
+    _scratch_unmount 2>/dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/xfs/072 b/tests/xfs/072
index 9949749..43aa421 100755
--- a/tests/xfs/072
+++ b/tests/xfs/072
@@ -30,7 +30,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 }
 
 here=`pwd`
@@ -51,7 +51,7 @@ _supported_os IRIX Linux
 _require_scratch
 
 rm -f $seqres.full
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 
 _scratch_mkfs_xfs >/dev/null	|| _fail "mkfs failed"
 _scratch_mount >/dev/null	|| _fail "mount failed"
diff --git a/tests/xfs/073 b/tests/xfs/073
index f955771..c170973 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -40,7 +40,7 @@ imgs=$TEST_DIR/$$
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	umount -d $imgs.loop 2>/dev/null
 	[ -d $imgs.loop ] && rmdir $imgs.loop
 	umount -d $imgs.source_dir 2>/dev/null
@@ -142,7 +142,7 @@ _scratch_mount 2>/dev/null || _fail "initial scratch mount failed"
 echo
 echo === populating scratch device
 _populate_scratch
-umount $SCRATCH_MNT 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 echo
 echo === copying scratch device to single target
diff --git a/tests/xfs/081 b/tests/xfs/081
index 1acb85d..6f6f825 100755
--- a/tests/xfs/081
+++ b/tests/xfs/081
@@ -46,7 +46,7 @@ _cleanup()
     _cleanup_logfiles
     rm -f $tmp.*
     echo "*** unmount"
-    umount $SCRATCH_MNT 2>/dev/null
+    _scratch_unmount 2>/dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -57,7 +57,7 @@ _require_xfs_quota
 _require_v2log
  
 echo "*** init FS"
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 
 # do a simple quota test to ensure DQUOT data is happening
 export MOUNT_OPTIONS="-o quota,gquota"
@@ -72,7 +72,7 @@ fi
 _scratch_mkfs_xfs "-l version=1" 1>/dev/null 2>&1
 _qmount
 src/feature -u $SCRATCH_DEV || _notrun "No quota support at mount time"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 _mkfs_log "-l version=1"
 _create_log
diff --git a/tests/xfs/082 b/tests/xfs/082
index fff1d6b..0c2d469 100755
--- a/tests/xfs/082
+++ b/tests/xfs/082
@@ -41,7 +41,7 @@ _cleanup()
     cd /
     _cleanup_logfiles
     rm -f $tmp.*
-    umount $SCRATCH_MNT 2>/dev/null
+    _scratch_unmount 2>/dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -58,7 +58,7 @@ _require_v2log
 _link_out_file $seq.op $seqfull.op
 
 echo "*** init FS"
-umount $SCRATCH_DEV >/dev/null 2>&1
+_scratch_unmount >/dev/null 2>&1
 
 cat >$tmp.seq.params <<EOF
 # mkfs-opt             mount-opt            start-blk
diff --git a/tests/xfs/104 b/tests/xfs/104
index 69fcc69..d71053e 100755
--- a/tests/xfs/104
+++ b/tests/xfs/104
@@ -112,7 +112,7 @@ while [ $size -le $endsize ]; do
 done
 wait	# stop for any remaining stress processes
 
-umount $SCRATCH_DEV
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/xfs/106 b/tests/xfs/106
index 7f97722..74658a6 100755
--- a/tests/xfs/106
+++ b/tests/xfs/106
@@ -233,6 +233,6 @@ type=p
 id=$prid
 test_xfs_quota | filter_xfs_quota
 
-umount $SCRATCH_DEV
+_scratch_unmount
 status=0
 exit
diff --git a/tests/xfs/108 b/tests/xfs/108
index 5030f63..addb8e7 100755
--- a/tests/xfs/108
+++ b/tests/xfs/108
@@ -82,7 +82,7 @@ _require_prjquota $SCRATCH_DEV
 
 # real QA test starts here
 rm -f $tmp.projects $seqres.full
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 _scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
 cat $tmp.mkfs >>$seqres.full
 _scratch_mount
@@ -91,7 +91,7 @@ uid=1
 gid=2
 prid=3
 export QARGS="-x -D /dev/null -P /dev/null $SCRATCH_MNT"
-umount $SCRATCH_DEV
+_scratch_unmount
 
 echo; echo "### test user accounting"
 export MOUNT_OPTIONS="-ouquota"
@@ -100,7 +100,7 @@ type=u
 id=$uid
 test_files
 test_accounting
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 echo; echo "### test group accounting"
 export MOUNT_OPTIONS="-ogquota"
@@ -109,7 +109,7 @@ type=g
 id=$gid
 test_files
 test_accounting
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 #echo; echo "### test project accounting"
 export MOUNT_OPTIONS="-opquota"
@@ -118,7 +118,7 @@ type=p
 id=$prid
 test_files
 test_accounting
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 
 status=0
 exit
diff --git a/tests/xfs/109 b/tests/xfs/109
index 5578c90..4d5450e 100755
--- a/tests/xfs/109
+++ b/tests/xfs/109
@@ -63,7 +63,7 @@ populate()
 	done
 
 	echo "flushing changes via umount/mount."
-	umount $SCRATCH_DEV
+	_scratch_unmount
 	_scratch_mount
 }
 
@@ -91,7 +91,7 @@ allocate()
 }
 
 # real QA test starts here
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 _scratch_mount
 
 # see if faststart is possible (and requested)
@@ -100,7 +100,7 @@ faststart=""
 if [ -n "$FASTSTART" -a -f $SCRATCH_MNT/f0 ]; then
 	faststart="-N"	# causes us to skip the mkfs step
 fi
-umount $SCRATCH_DEV
+_scratch_unmount
 
 _scratch_mkfs_xfs -dsize=160m,agcount=4 $faststart | _filter_mkfs 2>$tmp.mkfs
 cat $tmp.mkfs >>$seqres.full
diff --git a/tests/xfs/110 b/tests/xfs/110
index 7428faf..19eddaf 100755
--- a/tests/xfs/110
+++ b/tests/xfs/110
@@ -41,7 +41,7 @@ _supported_os Linux
 _require_scratch
 
 # real QA test starts here
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 _scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
 
 STR1=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
diff --git a/tests/xfs/111 b/tests/xfs/111
index f33f339..a12da42 100755
--- a/tests/xfs/111
+++ b/tests/xfs/111
@@ -43,7 +43,7 @@ _require_scratch
 [ "$XFS_FSR_PROG" = "" ] && _notrun "xfs_fsr not found"
 
 # real QA test starts here
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 MKFS_OPTIONS="-bsize=4096"
 MOUNT_OPTIONS="-o noatime"
 _scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
@@ -56,7 +56,7 @@ do
     $XFS_IO_PROG -f -c "pwrite 0 512" $SCRATCH_MNT/${I} > /dev/null
     let I=$I+1
 done
-umount $SCRATCH_DEV
+_scratch_unmount
 
 echo Blat inode clusters
 src/itrash $SCRATCH_DEV
diff --git a/tests/xfs/116 b/tests/xfs/116
index b692440..583439f 100755
--- a/tests/xfs/116
+++ b/tests/xfs/116
@@ -54,10 +54,10 @@ _require_xfs_quota
 
 mkfs.xfs -f $SCRATCH_DEV >/dev/null 2>&1
 mount -o uquota $SCRATCH_DEV $SCRATCH_MNT
-umount $SCRATCH_MNT
+_scratch_unmount
 xfs_db -r -c sb -c print $SCRATCH_DEV | grep qflags
 mount $SCRATCH_DEV $SCRATCH_MNT
-umount $SCRATCH_MNT
+_scratch_unmount
 xfs_db -r -c sb -c print $SCRATCH_DEV | grep qflags
 
 # success, all done
diff --git a/tests/xfs/121 b/tests/xfs/121
index 1457ed1..d301808 100755
--- a/tests/xfs/121
+++ b/tests/xfs/121
@@ -76,7 +76,7 @@ src/godown -v -f $SCRATCH_MNT >> $seqres.full
 wait 2>/dev/null
 
 echo "unmount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 echo "logprint after going down..."
 _print_logstate
@@ -89,7 +89,7 @@ echo "godown"
 src/godown -v -f $SCRATCH_MNT >> $seqres.full
 
 echo "unmount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 echo "logprint after going down..."
 _print_logstate
diff --git a/tests/xfs/134 b/tests/xfs/134
index adafa39..be18ee8 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -39,7 +39,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/xfs/136 b/tests/xfs/136
index e799430..679fa9f 100755
--- a/tests/xfs/136
+++ b/tests/xfs/136
@@ -102,7 +102,7 @@ do_extents()
 
 _print_inode()
 {
-    umount $SCRATCH_MNT
+    _scratch_unmount
     xfs_db -r -c "inode $inum" -c "print" $SCRATCH_DEV |\
     awk '
 	/nextents/ { print; next }
@@ -118,14 +118,14 @@ _print_inode()
 
 _print_inode_u()
 {
-    umount $SCRATCH_MNT
+    _scratch_unmount
     xfs_db -r -c "inode $inum" -c "print u" $SCRATCH_DEV
     _scratch_mount
 }
 
 _print_inode_a()
 {
-    umount $SCRATCH_MNT
+    _scratch_unmount
     xfs_db -r -c "inode $inum" -c "print a" $SCRATCH_DEV
     _scratch_mount
 }
diff --git a/tests/xfs/148 b/tests/xfs/148
index 5dc8df6..42c0481 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -34,7 +34,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_DEV 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 
@@ -87,7 +87,7 @@ else
 		_notrun "GQuota are enabled, test needs controlled sb recovery"
 	src/feature -P $SCRATCH_DEV && \
 		_notrun "PQuota are enabled, test needs controlled sb recovery"
-	umount $SCRATCH_DEV
+	_scratch_unmount
 fi
 clear=""
 eval `xfs_db -r -c "sb 1" -c stack $SCRATCH_DEV | $PERL_PROG -ne '
diff --git a/tests/xfs/175 b/tests/xfs/175
index 16fcfcc..ad18e42 100755
--- a/tests/xfs/175
+++ b/tests/xfs/175
@@ -54,7 +54,7 @@ _require_scratch
 
 # test that we have DMAPI support
 _dmapi_scratch_mount
-umount $SCRATCH_MNT > /dev/null 2>&1
+_scratch_unmount > /dev/null 2>&1
 
 # _test_punch args: blksize extsize_hint filesize "pp1 pp2 pp3" \
 # 					"ps1 ps2 ps3" "pt1 pt2 pt3" "wp1 wp2" "ws1 ws2" \
diff --git a/tests/xfs/176 b/tests/xfs/176
index ea07e00..035d3b4 100755
--- a/tests/xfs/176
+++ b/tests/xfs/176
@@ -51,7 +51,7 @@ _require_scratch
 
 # test that we have DMAPI support
 _dmapi_scratch_mount
-umount $SCRATCH_MNT > /dev/null 2>&1
+_scratch_unmount > /dev/null 2>&1
 
 # _test_punch args: blksize extsize_hint filesize "pp1 pp2 pp3" \
 # 					"ps1 ps2 ps3" "pt1 pt2 pt3" "wp1 wp2" "ws1 ws2" \
diff --git a/tests/xfs/177 b/tests/xfs/177
index 9a4fd38..3957b49 100755
--- a/tests/xfs/177
+++ b/tests/xfs/177
@@ -54,7 +54,7 @@ _require_scratch
 
 # test that we have DMAPI support
 _dmapi_scratch_mount
-umount $SCRATCH_MNT > /dev/null 2>&1
+_scratch_unmount > /dev/null 2>&1
 
 _scratch_mkfs_xfs >/dev/null 2>&1 \
         || _fail "mkfs failed"
@@ -72,7 +72,7 @@ $here/src/bulkstat_unlink_test 15 100 6 $SCRATCH_MNT/bulkstat
 $here/src/bulkstat_unlink_test 20 1000 3 $SCRATCH_MNT/bulkstat
 
 # Mount scratch with ikeep enabled
-umount $SCRATCH_MNT
+_scratch_unmount
 _scratch_mount "-o dmapi,mtpt=$SCRATCH_MNT" \
         || _fail "mount failed"
 
diff --git a/tests/xfs/181 b/tests/xfs/181
index 4e7ac3a..a201045 100755
--- a/tests/xfs/181
+++ b/tests/xfs/181
@@ -90,7 +90,7 @@ wait $pid 2>/dev/null
 pid=""
 
 echo "unmount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 echo "logprint after going down..."
 _print_logstate
@@ -103,7 +103,7 @@ echo "godown"
 src/godown -v -f $SCRATCH_MNT >> $seqres.full
 
 echo "unmount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 echo "logprint after going down..."
 _print_logstate
diff --git a/tests/xfs/189 b/tests/xfs/189
index a56bbde..540a0d7 100755
--- a/tests/xfs/189
+++ b/tests/xfs/189
@@ -64,7 +64,7 @@ rm -f $seqres.full
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	_putback_scratch_fstab
 	rm -f $tmp.*
 }
@@ -119,7 +119,7 @@ _test_remount_rw()
 		_check_mount rw filestreams
 	done
 
-	umount $SCRATCH_MNT
+	_scratch_unmount
 
 	# remount ignores attr2, and noattr2 mount option does does not result
 	# in any "attr2" specific option in /proc/mounts, so we can only check
@@ -138,7 +138,7 @@ _test_remount_rw()
 		_check_mount rw
 	done
 
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 #
@@ -155,7 +155,7 @@ _test_remount_write()
 	touch $SCRATCH_MNT/foobar
 	[ $? -eq 0 ] || echo "touch (1) failed unexpectedly"
 
-	umount $SCRATCH_MNT
+	_scratch_unmount
 
 	_scratch_mount -o ro
 	[ $? -eq 0 ] || echo "mount (2) failed unexpectedly"
@@ -166,7 +166,7 @@ _test_remount_write()
 	touch $SCRATCH_MNT/foobar
 	[ $? -eq 0 ] || echo "touch (2) failed unexpectedly"
 
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 #
@@ -193,7 +193,7 @@ _test_remount_barrier()
 	[ $? -eq 0 ] || _fail "remount barrier failed"
 	_check_mount rw
 
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 
 #
diff --git a/tests/xfs/196 b/tests/xfs/196
index 189f4ce..3bff8f6 100755
--- a/tests/xfs/196
+++ b/tests/xfs/196
@@ -35,7 +35,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT
+	_scratch_unmount
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/xfs/199 b/tests/xfs/199
index c1b5962..572ad37 100755
--- a/tests/xfs/199
+++ b/tests/xfs/199
@@ -35,7 +35,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -69,7 +69,7 @@ echo "Clearing features2:"
 xfs_db -x $SCRATCH_DEV -c 'sb' -c 'write features2 0'
 
 _scratch_mount
-umount $SCRATCH_MNT
+_scratch_unmount
 echo "Features 2 after mount rw:"
 xfs_db -x $SCRATCH_DEV -c 'sb' -c 'print features2'
 
@@ -84,7 +84,7 @@ xfs_db -x $SCRATCH_DEV -c 'sb' -c 'write features2 0'
 #
 _scratch_mount -o ro
 _scratch_mount -o remount,rw
-umount $SCRATCH_MNT
+_scratch_unmount
 echo "Features 2 after mount ro and remount rw:"
 xfs_db -x $SCRATCH_DEV -c 'sb' -c 'print features2'
 
diff --git a/tests/xfs/201 b/tests/xfs/201
index 88829d3..eb32627 100755
--- a/tests/xfs/201
+++ b/tests/xfs/201
@@ -43,7 +43,7 @@ do_pwrite()
 
 _cleanup()
 {
-	umount $SCRATCH_MNT
+	_scratch_unmount
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/xfs/220 b/tests/xfs/220
index 780aa44..69b539c 100755
--- a/tests/xfs/220
+++ b/tests/xfs/220
@@ -36,7 +36,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_DEV >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -64,7 +64,7 @@ _scratch_mount -o uquota
 xfs_quota -x -c off $SCRATCH_DEV
 
 # and unmount (this used to crash)
-umount $SCRATCH_DEV
+_scratch_unmount
 
 # create scratch filesystem
 _scratch_mkfs_xfs >/dev/null 2>&1
@@ -77,7 +77,7 @@ _scratch_mount -o uquota
 xfs_quota -x -c off -c remove $SCRATCH_DEV
 
 # and unmount again
-umount $SCRATCH_DEV
+_scratch_unmount
 
 status=0
 exit $status
diff --git a/tests/xfs/227 b/tests/xfs/227
index 3816e9f..64e8f14 100755
--- a/tests/xfs/227
+++ b/tests/xfs/227
@@ -161,7 +161,7 @@ _scratch_mount
 fragment_freespace
 
 # unmount and remount to reset all allocator indexes
-umount $SCRATCH_MNT
+_scratch_unmount
 _scratch_mount
 
 # create a range of source files, then fsr them to a known size
@@ -205,6 +205,6 @@ for n in `seq 4 1 12`; do
 	done
 done
 
-umount $SCRATCH_MNT
+_scratch_unmount
 echo "--- silence is golden ---"
 status=0 ; exit
diff --git a/tests/xfs/244 b/tests/xfs/244
index 6dd8224..257d121 100755
--- a/tests/xfs/244
+++ b/tests/xfs/244
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 
@@ -96,7 +96,7 @@ if $XFS_QUOTA_PROG -x -c "project -s -p $dir/over32bit 5344967296" $SCRATCH_DEV
 fi
 
 #  Do testing on filesystem with projid32bit feature enabled
-umount $SCRATCH_DEV 2>/dev/null
+_scratch_unmount 2>/dev/null
 _scratch_mkfs_xfs -i projid32bit=1 >> $seqres.full || _fail "mkfs failed"
 _qmount
 mkdir $dir
diff --git a/tests/xfs/287 b/tests/xfs/287
index b9276a7..aca410a 100755
--- a/tests/xfs/287
+++ b/tests/xfs/287
@@ -40,7 +40,7 @@ rm -f $seqres.full
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -rf $tmp.*
 }
 
@@ -84,7 +84,7 @@ echo "No 32bit project quotas:"
 $XFS_IO_PROG -r -c "lsproj" $dir/16bit
 $XFS_IO_PROG -r -c "lsproj" $dir/32bit
 
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # Now, enable projid32bit support by xfs_admin
 xfs_admin -p $SCRATCH_DEV >> $seqres.full 2>&1 || _fail "xfs_admin failed"
@@ -129,7 +129,7 @@ $XFS_IO_PROG -r -c "lsproj" $restore_dir/16bit
 $XFS_IO_PROG -r -c "lsproj" $restore_dir/32bit
 $XFS_IO_PROG -r -c "lsproj" $restore_dir/32bitv2
 
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # Now, we can examine the file systems with xfs_db
 echo "These two values of 16bit project quota ids shall be the same"
diff --git a/tests/xfs/299 b/tests/xfs/299
index d190974..1f61eea 100755
--- a/tests/xfs/299
+++ b/tests/xfs/299
@@ -40,7 +40,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
-	umount $SCRATCH_MNT 2>/dev/null
+	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -225,7 +225,7 @@ _exercise g
 _exercise u
 
 echo "*** unmount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 
 _scratch_mkfs_xfs -m crc=1 2>/dev/null | _filter_mkfs 2>$tmp.mkfs
@@ -241,7 +241,7 @@ _exercise gno
 _exercise pno
 
 echo "*** unmount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # success, all done
 status=0
diff --git a/tests/xfs/304 b/tests/xfs/304
index ef8643a..0f902fc 100755
--- a/tests/xfs/304
+++ b/tests/xfs/304
@@ -63,7 +63,7 @@ echo "*** turn off group quotas"
 xfs_quota -x -c 'off -g' $SCRATCH_MNT
 rmdir $QUOTA_DIR
 echo "*** umount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 _qmount
 mkdir -p $QUOTA_DIR
@@ -71,7 +71,7 @@ echo "*** turn off project quotas"
 xfs_quota -x -c 'off -p' $SCRATCH_MNT
 rmdir $QUOTA_DIR
 echo "*** umount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 _qmount
 mkdir -p $QUOTA_DIR
@@ -79,7 +79,7 @@ echo "*** turn off group/project quotas"
 xfs_quota -x -c 'off -gp' $SCRATCH_MNT
 rmdir $QUOTA_DIR
 echo "*** umount"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 # success, all done
 status=0

