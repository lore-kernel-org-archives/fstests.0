Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:34265 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752136AbcK2Vew (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Nov 2016 16:34:52 -0500
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1cBq10-0002kS-3t
        for fstests@vger.kernel.org; Wed, 30 Nov 2016 08:32:38 +1100
Received: from dave by discord.disaster.area with local (Exim 4.88)
        (envelope-from <david@fromorbit.com>)
        id 1cBq10-0002Ed-2b
        for fstests@vger.kernel.org; Wed, 30 Nov 2016 08:32:38 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/2] common: split Btrfs functions from common/rc
Date: Wed, 30 Nov 2016 08:32:33 +1100
Message-Id: <20161129213233.8462-3-david@fromorbit.com>
In-Reply-To: <20161129213233.8462-1-david@fromorbit.com>
References: <20161129213233.8462-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Similar to common/xfs, for the same reasons.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 common/btrfs | 335 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 common/rc    | 336 +----------------------------------------------------------
 2 files changed, 338 insertions(+), 333 deletions(-)
 create mode 100644 common/btrfs

diff --git a/common/btrfs b/common/btrfs
new file mode 100644
index 000000000000..7cc4f5d06977
--- /dev/null
+++ b/common/btrfs
@@ -0,0 +1,335 @@
+#
+# Common btrfs specific functions
+#
+
+_btrfs_get_subvolid()
+{
+	mnt=$1
+	name=$2
+
+	$BTRFS_UTIL_PROG sub list $mnt | grep $name | awk '{ print $2 }'
+}
+
+# We check for btrfs and (optionally) features of the btrfs command
+_require_btrfs()
+{
+	cmd=$1
+	_require_command "$BTRFS_UTIL_PROG" btrfs
+	if [ -z "$1" ]; then
+		return 1;
+	fi
+	$BTRFS_UTIL_PROG $cmd --help >/dev/null 2>&1
+	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd)"
+}
+
+_run_btrfs_util_prog()
+{
+	run_check $BTRFS_UTIL_PROG $*
+}
+
+_require_btrfs_send_stream_version()
+{
+	$BTRFS_UTIL_PROG send 2>&1 | \
+		grep '^[ \t]*\-\-stream\-version <version>' > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		_notrun "Missing btrfs-progs send --stream-version command line option, skipped this test"
+	fi
+
+	# test if btrfs kernel supports send stream version 2
+	if [ ! -f /sys/fs/btrfs/send/stream_version ]; then
+		_notrun "Missing btrfs kernel patch for send stream version 2, skipped this test"
+	fi
+}
+
+_require_btrfs_mkfs_feature()
+{
+	if [ -z $1 ]; then
+		echo "Missing feature name argument for _require_btrfs_mkfs_feature"
+		exit 1
+	fi
+	feat=$1
+	$MKFS_BTRFS_PROG -O list-all 2>&1 | \
+		grep '^[ \t]*'"$feat"'\b' > /dev/null 2>&1
+	[ $? -eq 0 ] || \
+		_notrun "Feature $feat not supported in the available version of mkfs.btrfs"
+}
+
+_require_btrfs_fs_feature()
+{
+	if [ -z $1 ]; then
+		echo "Missing feature name argument for _require_btrfs_fs_feature"
+		exit 1
+	fi
+	feat=$1
+	modprobe btrfs > /dev/null 2>&1
+	[ -e /sys/fs/btrfs/features/$feat ] || \
+		_notrun "Feature $feat not supported by the available btrfs version"
+}
+
+_check_btrfs_filesystem()
+{
+    device=$1
+
+    # If type is set, we're mounted
+    type=`_fs_type $device`
+    ok=1
+
+    if [ "$type" = "$FSTYP" ]
+    then
+        # mounted ...
+        mountpoint=`_umount_or_remount_ro $device`
+    fi
+
+    btrfsck $device >$tmp.fsck 2>&1
+    if [ $? -ne 0 ]
+    then
+        echo "_check_btrfs_filesystem: filesystem on $device is inconsistent (see $seqres.full)"
+
+        echo "_check_btrfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
+        echo "*** fsck.$FSTYP output ***"	>>$seqres.full
+        cat $tmp.fsck				>>$seqres.full
+        echo "*** end fsck.$FSTYP output"	>>$seqres.full
+
+        ok=0
+    fi
+    rm -f $tmp.fsck
+
+    if [ $ok -eq 0 ]
+    then
+        echo "*** mount output ***"		>>$seqres.full
+        _mount					>>$seqres.full
+        echo "*** end mount output"		>>$seqres.full
+    elif [ "$type" = "$FSTYP" ]
+    then
+	# was mounted ...
+	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
+	ok=$?
+    fi
+
+    if [ $ok -eq 0 ]; then
+	status=1
+	if [ "$iam" != "check" ]; then
+		exit 1
+	fi
+	return 1
+    fi
+
+    return 0
+}
+
+_require_btrfs_dev_del_by_devid()
+{
+	$BTRFS_UTIL_PROG device delete --help | egrep devid > /dev/null 2>&1
+	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old "\
+			"(must support 'btrfs device delete <devid> /<mnt>')"
+}
+
+# get btrfs profile configs being tested
+#
+# A set of pre-set profile configs are exported via _btrfs_profile_configs
+# array. Default configs can be overridden by setting BTRFS_PROFILE_CONFIGS
+# var in the format "metadata_profile:data_profile", multiple configs can be
+# seperated by space, e.g.
+# export BTRFS_PROFILE_CONFIGS="raid0:raid0 raid1:raid1 dup:single"
+_btrfs_get_profile_configs()
+{
+	if [ "$FSTYP" != "btrfs" ]; then
+		return
+	fi
+
+	if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
+		# Default configurations to test.
+		local configs=(
+			"single:single"
+			"dup:single"
+			"raid0:raid0"
+			"raid1:raid0"
+			"raid1:raid1"
+			"raid10:raid10"
+			"raid5:raid5"
+			"raid6:raid6"
+		)
+	else
+		# User-provided configurations.
+		local configs=(${BTRFS_PROFILE_CONFIGS[@]})
+	fi
+
+	_btrfs_profile_configs=()
+	for cfg in "${configs[@]}"; do
+		local supported=true
+		local profiles=(${cfg/:/ })
+		if [ "$1" == "replace" ]; then
+			# We can't do replace with these profiles because they
+			# imply only one device ($SCRATCH_DEV), and we need to
+			# keep $SCRATCH_DEV around for _scratch_mount
+			# and _check_scratch_fs.
+			local unsupported=(
+				"dup"
+			)
+		elif [ "$1" == "replace-missing" ]; then
+			# We can't replace missing devices with these profiles
+			# because there isn't enough redundancy.
+			local unsupported=(
+				"single"
+				"dup"
+				"raid0"
+			)
+		else
+			local unsupported=()
+		fi
+		for unsupp in "${unsupported[@]}"; do
+			if [ "${profiles[0]}" == "$unsupp" -o "${profiles[1]}" == "$unsupp" ]; then
+			     if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
+				     # For the default config, just omit it.
+				     supported=false
+			     else
+				     # For user-provided config, don't run the test.
+				     _notrun "Profile $unsupp not supported for $1"
+			     fi
+			fi
+		done
+		if "$supported"; then
+			_btrfs_profile_configs+=("-m ${profiles[0]} -d ${profiles[1]}")
+		fi
+	done
+	export _btrfs_profile_configs
+}
+
+# stress btrfs by running balance operation in a loop
+_btrfs_stress_balance()
+{
+	local options=$@
+	while true; do
+		$BTRFS_UTIL_PROG balance start $options
+	done
+}
+
+# stress btrfs by creating/mounting/umounting/deleting subvolume in a loop
+_btrfs_stress_subvolume()
+{
+	local btrfs_dev=$1
+	local btrfs_mnt=$2
+	local subvol_name=$3
+	local subvol_mnt=$4
+	local stop_file=$5
+
+	mkdir -p $subvol_mnt
+	while [ ! -e $stop_file ]; do
+		$BTRFS_UTIL_PROG subvolume create $btrfs_mnt/$subvol_name
+		$MOUNT_PROG -o subvol=$subvol_name $btrfs_dev $subvol_mnt
+		$UMOUNT_PROG $subvol_mnt
+		$BTRFS_UTIL_PROG subvolume delete $btrfs_mnt/$subvol_name
+	done
+}
+
+# stress btrfs by running scrub in a loop
+_btrfs_stress_scrub()
+{
+	local btrfs_mnt=$1
+	while true; do
+		$BTRFS_UTIL_PROG scrub start -B $btrfs_mnt
+	done
+}
+
+# stress btrfs by defragmenting every file/dir in a loop and compress file
+# contents while defragmenting if second argument is not "nocompress"
+_btrfs_stress_defrag()
+{
+	local btrfs_mnt=$1
+	local compress=$2
+
+	while true; do
+		if [ "$compress" == "nocompress" ]; then
+			find $btrfs_mnt \( -type f -o -type d \) -exec \
+			$BTRFS_UTIL_PROG filesystem defrag {} \;
+		else
+			find $btrfs_mnt \( -type f -o -type d \) -exec \
+			$BTRFS_UTIL_PROG filesystem defrag -clzo {} \;
+			find $btrfs_mnt \( -type f -o -type d \) -exec \
+			$BTRFS_UTIL_PROG filesystem defrag -czlib {} \;
+		fi
+	done
+}
+
+# stress btrfs by remounting it with different compression algorithms in a loop
+# run this with fsstress running at background could exercise the compression
+# code path and ensure no race when switching compression algorithm with constant
+# I/O activity.
+_btrfs_stress_remount_compress()
+{
+	local btrfs_mnt=$1
+	while true; do
+		for algo in no zlib lzo; do
+			$MOUNT_PROG -o remount,compress=$algo $btrfs_mnt
+		done
+	done
+}
+
+# stress btrfs by replacing devices in a loop
+# Note that at least 3 devices are needed in SCRATCH_DEV_POOL and the last
+# device should be free(not used by btrfs)
+_btrfs_stress_replace()
+{
+	local btrfs_mnt=$1
+
+	# The device number in SCRATCH_DEV_POOL should be at least 3,
+	# one is SCRATCH_DEV, one is to be replaced, one is free device
+	# we won't replace SCRATCH_DEV, see below for reason
+	if [ "`echo $SCRATCH_DEV_POOL | wc -w`" -lt 3 ]; then
+		echo "_btrfs_stress_replace requires at least 3 devices in SCRATCH_DEV_POOL"
+		return
+	fi
+
+	# take the last device as the first free_dev
+	local free_dev="`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $NF}'`"
+
+	# free_dev should be really free
+	if $BTRFS_UTIL_PROG filesystem show $btrfs_mnt | grep -q "$free_dev"; then
+		echo "_btrfs_stress_replace: $free_dev is used by btrfs"
+		return
+	fi
+
+	# dev_pool is device list being currently used by btrfs (excluding SCRATCH_DEV)
+	# and can be replaced. We don't replace SCRATCH_DEV because it will be used in
+	# _scratch_mount and _check_scratch_fs etc.
+	local dev_pool=`echo $SCRATCH_DEV_POOL | sed -e "s# *$SCRATCH_DEV *##" \
+			-e "s# *$free_dev *##"`
+
+	# set the first device in dev_pool as the first src_dev to be replaced
+	local src_dev=`echo $dev_pool | $AWK_PROG '{print $1}'`
+
+	echo "dev_pool=$dev_pool"
+	echo "free_dev=$free_dev, src_dev=$src_dev"
+	while true; do
+		echo "Replacing $src_dev with $free_dev"
+		$BTRFS_UTIL_PROG replace start -fB $src_dev $free_dev $btrfs_mnt
+		if [ $? -ne 0 ]; then
+			# don't update src_dev and free_dev if replace failed
+			continue
+		fi
+		dev_pool="$dev_pool $free_dev"
+		dev_pool=`echo $dev_pool | sed -e "s# *$src_dev *##"`
+		free_dev=$src_dev
+		src_dev=`echo $dev_pool | $AWK_PROG '{print $1}'`
+	done
+}
+
+# find the right option to force output in bytes, older versions of btrfs-progs
+# print that by default, newer print human readable numbers with unit suffix
+_btrfs_qgroup_units()
+{
+	$BTRFS_UTIL_PROG qgroup show --help 2>&1 | grep -q -- --raw && echo "--raw"
+}
+
+_require_btrfs_loadable()
+{
+	modprobe -r btrfs || _notrun "btrfs unloadable"
+	modprobe btrfs || _notrun "Can't load btrfs"
+}
+
+_reload_btrfs_ko()
+{
+	modprobe -r btrfs || _fail "btrfs unload failed"
+	modprobe btrfs || _fail "btrfs load failed"
+}
+
diff --git a/common/rc b/common/rc
index 00b53643f248..2719b23e3ac1 100644
--- a/common/rc
+++ b/common/rc
@@ -68,14 +68,6 @@ dd()
    fi
 }
 
-_btrfs_get_subvolid()
-{
-	mnt=$1
-	name=$2
-
-	$BTRFS_UTIL_PROG sub list $mnt | grep $name | awk '{ print $2 }'
-}
-
 # Prints the md5 checksum of a given file
 _md5_checksum()
 {
@@ -126,7 +118,7 @@ fi
 # make sure we have a standard umask
 umask 022
 
-# check for correct setup
+# check for correct setup and source the $FSTYP specific functions now
 case "$FSTYP" in
     xfs)
 	 [ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
@@ -134,7 +126,6 @@ case "$FSTYP" in
 	 [ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
 	 [ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
 
-	 #source the XFS specific functions now.
 	 . ./common/xfs
 	 ;;
     udf)
@@ -142,6 +133,8 @@ case "$FSTYP" in
 	 ;;
     btrfs)
 	 [ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
+
+	 . ./common/btrfs
 	 ;;
     ext4)
 	 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
@@ -1276,18 +1269,6 @@ _supported_os()
     _notrun "not suitable for this OS: $HOSTOS"
 }
 
-_require_btrfs_loadable()
-{
-	modprobe -r btrfs || _notrun "btrfs unloadable"
-	modprobe btrfs || _notrun "Can't load btrfs"
-}
-
-_reload_btrfs_ko()
-{
-	modprobe -r btrfs || _fail "btrfs unload failed"
-	modprobe btrfs || _fail "btrfs load failed"
-}
-
 # this test needs a scratch partition - check we're ok & unmount it
 # No post-test check of the device is required. e.g. the test intentionally
 # finishes the test with the filesystem in a corrupt state
@@ -2132,57 +2113,6 @@ _check_udf_filesystem()
     return 0
 }
 
-_check_btrfs_filesystem()
-{
-    device=$1
-
-    # If type is set, we're mounted
-    type=`_fs_type $device`
-    ok=1
-
-    if [ "$type" = "$FSTYP" ]
-    then
-        # mounted ...
-        mountpoint=`_umount_or_remount_ro $device`
-    fi
-
-    btrfsck $device >$tmp.fsck 2>&1
-    if [ $? -ne 0 ]
-    then
-        echo "_check_btrfs_filesystem: filesystem on $device is inconsistent (see $seqres.full)"
-
-        echo "_check_btrfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
-        echo "*** fsck.$FSTYP output ***"	>>$seqres.full
-        cat $tmp.fsck				>>$seqres.full
-        echo "*** end fsck.$FSTYP output"	>>$seqres.full
-
-        ok=0
-    fi
-    rm -f $tmp.fsck
-
-    if [ $ok -eq 0 ]
-    then
-        echo "*** mount output ***"		>>$seqres.full
-        _mount					>>$seqres.full
-        echo "*** end mount output"		>>$seqres.full
-    elif [ "$type" = "$FSTYP" ]
-    then
-	# was mounted ...
-	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
-	ok=$?
-    fi
-
-    if [ $ok -eq 0 ]; then
-	status=1
-	if [ "$iam" != "check" ]; then
-		exit 1
-	fi
-	return 1
-    fi
-
-    return 0
-}
-
 _check_test_fs()
 {
     case $FSTYP in
@@ -2540,18 +2470,6 @@ _require_deletable_scratch_dev_pool()
 	done
 }
 
-# We check for btrfs and (optionally) features of the btrfs command
-_require_btrfs()
-{
-	cmd=$1
-	_require_command "$BTRFS_UTIL_PROG" btrfs
-	if [ -z "$1" ]; then
-		return 1;
-	fi
-	$BTRFS_UTIL_PROG $cmd --help >/dev/null 2>&1
-	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd)"
-}
-
 # Check that fio is present, and it is able to execute given jobfile
 _require_fio()
 {
@@ -2837,50 +2755,6 @@ run_check()
 	"$@" >> $seqres.full 2>&1 || _fail "failed: '$@'"
 }
 
-_run_btrfs_util_prog()
-{
-	run_check $BTRFS_UTIL_PROG $*
-}
-
-_require_btrfs_send_stream_version()
-{
-	$BTRFS_UTIL_PROG send 2>&1 | \
-		grep '^[ \t]*\-\-stream\-version <version>' > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		_notrun "Missing btrfs-progs send --stream-version command line option, skipped this test"
-	fi
-
-	# test if btrfs kernel supports send stream version 2
-	if [ ! -f /sys/fs/btrfs/send/stream_version ]; then
-		_notrun "Missing btrfs kernel patch for send stream version 2, skipped this test"
-	fi
-}
-
-_require_btrfs_mkfs_feature()
-{
-	if [ -z $1 ]; then
-		echo "Missing feature name argument for _require_btrfs_mkfs_feature"
-		exit 1
-	fi
-	feat=$1
-	$MKFS_BTRFS_PROG -O list-all 2>&1 | \
-		grep '^[ \t]*'"$feat"'\b' > /dev/null 2>&1
-	[ $? -eq 0 ] || \
-		_notrun "Feature $feat not supported in the available version of mkfs.btrfs"
-}
-
-_require_btrfs_fs_feature()
-{
-	if [ -z $1 ]; then
-		echo "Missing feature name argument for _require_btrfs_fs_feature"
-		exit 1
-	fi
-	feat=$1
-	modprobe btrfs > /dev/null 2>&1
-	[ -e /sys/fs/btrfs/features/$feat ] || \
-		_notrun "Feature $feat not supported by the available btrfs version"
-}
-
 _require_test_symlinks()
 {
 	# IRIX UDF does not support symlinks
@@ -2904,13 +2778,6 @@ _require_test_fcntl_advisory_locks()
 		_notrun "Require fcntl advisory locks support"
 }
 
-_require_btrfs_dev_del_by_devid()
-{
-	$BTRFS_UTIL_PROG device delete --help | egrep devid > /dev/null 2>&1
-	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old "\
-			"(must support 'btrfs device delete <devid> /<mnt>')"
-}
-
 _require_test_lsattr()
 {
 	testio=$(lsattr -d $TEST_DIR 2>&1)
@@ -2994,203 +2861,6 @@ _get_available_space()
 	echo $((avail_kb * 1024))
 }
 
-# get btrfs profile configs being tested
-#
-# A set of pre-set profile configs are exported via _btrfs_profile_configs
-# array. Default configs can be overridden by setting BTRFS_PROFILE_CONFIGS
-# var in the format "metadata_profile:data_profile", multiple configs can be
-# seperated by space, e.g.
-# export BTRFS_PROFILE_CONFIGS="raid0:raid0 raid1:raid1 dup:single"
-_btrfs_get_profile_configs()
-{
-	if [ "$FSTYP" != "btrfs" ]; then
-		return
-	fi
-
-	if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
-		# Default configurations to test.
-		local configs=(
-			"single:single"
-			"dup:single"
-			"raid0:raid0"
-			"raid1:raid0"
-			"raid1:raid1"
-			"raid10:raid10"
-			"raid5:raid5"
-			"raid6:raid6"
-		)
-	else
-		# User-provided configurations.
-		local configs=(${BTRFS_PROFILE_CONFIGS[@]})
-	fi
-
-	_btrfs_profile_configs=()
-	for cfg in "${configs[@]}"; do
-		local supported=true
-		local profiles=(${cfg/:/ })
-		if [ "$1" == "replace" ]; then
-			# We can't do replace with these profiles because they
-			# imply only one device ($SCRATCH_DEV), and we need to
-			# keep $SCRATCH_DEV around for _scratch_mount
-			# and _check_scratch_fs.
-			local unsupported=(
-				"dup"
-			)
-		elif [ "$1" == "replace-missing" ]; then
-			# We can't replace missing devices with these profiles
-			# because there isn't enough redundancy.
-			local unsupported=(
-				"single"
-				"dup"
-				"raid0"
-			)
-		else
-			local unsupported=()
-		fi
-		for unsupp in "${unsupported[@]}"; do
-			if [ "${profiles[0]}" == "$unsupp" -o "${profiles[1]}" == "$unsupp" ]; then
-			     if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
-				     # For the default config, just omit it.
-				     supported=false
-			     else
-				     # For user-provided config, don't run the test.
-				     _notrun "Profile $unsupp not supported for $1"
-			     fi
-			fi
-		done
-		if "$supported"; then
-			_btrfs_profile_configs+=("-m ${profiles[0]} -d ${profiles[1]}")
-		fi
-	done
-	export _btrfs_profile_configs
-}
-
-# stress btrfs by running balance operation in a loop
-_btrfs_stress_balance()
-{
-	local options=$@
-	while true; do
-		$BTRFS_UTIL_PROG balance start $options
-	done
-}
-
-# stress btrfs by creating/mounting/umounting/deleting subvolume in a loop
-_btrfs_stress_subvolume()
-{
-	local btrfs_dev=$1
-	local btrfs_mnt=$2
-	local subvol_name=$3
-	local subvol_mnt=$4
-	local stop_file=$5
-
-	mkdir -p $subvol_mnt
-	while [ ! -e $stop_file ]; do
-		$BTRFS_UTIL_PROG subvolume create $btrfs_mnt/$subvol_name
-		$MOUNT_PROG -o subvol=$subvol_name $btrfs_dev $subvol_mnt
-		$UMOUNT_PROG $subvol_mnt
-		$BTRFS_UTIL_PROG subvolume delete $btrfs_mnt/$subvol_name
-	done
-}
-
-# stress btrfs by running scrub in a loop
-_btrfs_stress_scrub()
-{
-	local btrfs_mnt=$1
-	while true; do
-		$BTRFS_UTIL_PROG scrub start -B $btrfs_mnt
-	done
-}
-
-# stress btrfs by defragmenting every file/dir in a loop and compress file
-# contents while defragmenting if second argument is not "nocompress"
-_btrfs_stress_defrag()
-{
-	local btrfs_mnt=$1
-	local compress=$2
-
-	while true; do
-		if [ "$compress" == "nocompress" ]; then
-			find $btrfs_mnt \( -type f -o -type d \) -exec \
-			$BTRFS_UTIL_PROG filesystem defrag {} \;
-		else
-			find $btrfs_mnt \( -type f -o -type d \) -exec \
-			$BTRFS_UTIL_PROG filesystem defrag -clzo {} \;
-			find $btrfs_mnt \( -type f -o -type d \) -exec \
-			$BTRFS_UTIL_PROG filesystem defrag -czlib {} \;
-		fi
-	done
-}
-
-# stress btrfs by remounting it with different compression algorithms in a loop
-# run this with fsstress running at background could exercise the compression
-# code path and ensure no race when switching compression algorithm with constant
-# I/O activity.
-_btrfs_stress_remount_compress()
-{
-	local btrfs_mnt=$1
-	while true; do
-		for algo in no zlib lzo; do
-			$MOUNT_PROG -o remount,compress=$algo $btrfs_mnt
-		done
-	done
-}
-
-# stress btrfs by replacing devices in a loop
-# Note that at least 3 devices are needed in SCRATCH_DEV_POOL and the last
-# device should be free(not used by btrfs)
-_btrfs_stress_replace()
-{
-	local btrfs_mnt=$1
-
-	# The device number in SCRATCH_DEV_POOL should be at least 3,
-	# one is SCRATCH_DEV, one is to be replaced, one is free device
-	# we won't replace SCRATCH_DEV, see below for reason
-	if [ "`echo $SCRATCH_DEV_POOL | wc -w`" -lt 3 ]; then
-		echo "_btrfs_stress_replace requires at least 3 devices in SCRATCH_DEV_POOL"
-		return
-	fi
-
-	# take the last device as the first free_dev
-	local free_dev="`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $NF}'`"
-
-	# free_dev should be really free
-	if $BTRFS_UTIL_PROG filesystem show $btrfs_mnt | grep -q "$free_dev"; then
-		echo "_btrfs_stress_replace: $free_dev is used by btrfs"
-		return
-	fi
-
-	# dev_pool is device list being currently used by btrfs (excluding SCRATCH_DEV)
-	# and can be replaced. We don't replace SCRATCH_DEV because it will be used in
-	# _scratch_mount and _check_scratch_fs etc.
-	local dev_pool=`echo $SCRATCH_DEV_POOL | sed -e "s# *$SCRATCH_DEV *##" \
-			-e "s# *$free_dev *##"`
-
-	# set the first device in dev_pool as the first src_dev to be replaced
-	local src_dev=`echo $dev_pool | $AWK_PROG '{print $1}'`
-
-	echo "dev_pool=$dev_pool"
-	echo "free_dev=$free_dev, src_dev=$src_dev"
-	while true; do
-		echo "Replacing $src_dev with $free_dev"
-		$BTRFS_UTIL_PROG replace start -fB $src_dev $free_dev $btrfs_mnt
-		if [ $? -ne 0 ]; then
-			# don't update src_dev and free_dev if replace failed
-			continue
-		fi
-		dev_pool="$dev_pool $free_dev"
-		dev_pool=`echo $dev_pool | sed -e "s# *$src_dev *##"`
-		free_dev=$src_dev
-		src_dev=`echo $dev_pool | $AWK_PROG '{print $1}'`
-	done
-}
-
-# find the right option to force output in bytes, older versions of btrfs-progs
-# print that by default, newer print human readable numbers with unit suffix
-_btrfs_qgroup_units()
-{
-	$BTRFS_UTIL_PROG qgroup show --help 2>&1 | grep -q -- --raw && echo "--raw"
-}
-
 # return device size in kb
 _get_device_size()
 {
-- 
2.10.2

