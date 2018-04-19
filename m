Received: from userp2130.oracle.com ([156.151.31.86]:35122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753402AbeDSQBe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Apr 2018 12:01:34 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] fstests: btrfs/011 cleanup the functions
Date: Fri, 20 Apr 2018 00:03:37 +0800
Message-Id: <20180419160337.6040-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Use common helper functions where needed. By doing this it improves
code readability and debugging of it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/011 | 197 ++++++++++++++++++--------------------------------------
 1 file changed, 63 insertions(+), 134 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 4aae22dc6292..95bc182a0edf 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -65,149 +65,85 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch_nocheck
-_require_scratch_dev_pool 4
-_require_btrfs_dump_super
+_require_scratch_dev_pool 5
+_require_scratch_dev_pool_equal_size
+_require_command "$WIPEFS_PROG" wipefs
 
 rm -f $seqres.full
 rm -f $tmp.tmp
 
 echo "*** test btrfs replace"
 
+fill_scratch()
+{
+	local fssize=$1
+
+	# Fill inline extents.
+	for i in `seq 1 500`; do
+		_ddt of=$SCRATCH_MNT/s$i bs=3800 count=1
+	done > /dev/null 2>&1
+
+	# Fill data extents.
+	for i in `seq 1 500`; do
+		_ddt of=$SCRATCH_MNT/l$i bs=16385 count=1
+	done > /dev/null 2>&1
+	_ddt of=$SCRATCH_MNT/t0 bs=1M count=1 > /dev/null 2>&1
+	for i in `seq $fssize`; do
+		cp $SCRATCH_MNT/t0 $SCRATCH_MNT/t$i || _fail "cp failed"
+	done > /dev/null 2>> $seqres.full
+	sync; sync
+}
+
 workout()
 {
 	local mkfs_options="$1"
 	local num_devs4raid="$2"
 	local with_cancel="$3"
-	local quick="$4"
+	local fssize="$4"
 	local source_dev="`echo ${SCRATCH_DEV_POOL} | awk '{print $1}'`"
-	local target_dev="`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`"
-	local fssize
+	local quick="quick"
 
-	echo >> $seqres.full
-	echo "---------workout \"$1\" $2 $3 $4-----------" >> $seqres.full
+	[[ $fssize != 64 ]] && quick="thorough"
 
-	if [ "`echo $SCRATCH_DEV_POOL | wc -w`" -lt `expr $num_devs4raid + 1` ]; then
-		echo "Skip workout $1 $2 $3 $4" >> $seqres.full
-		echo "Too few devices in SCRATCH_DEV_POOL $SCRATCH_DEV_POOL, required: " `expr $num_devs4raid + 1` >> $seqres.full
-		return 0
-	fi
+	echo -e "\\n---------workout \"$1\" $2 $3 $4-----------" >> $seqres.full
 
-	# use min number of disks in order to fill up the disk to replace
-	# as much as possible
-	local used_devs_without_1st="`echo $SCRATCH_DEV_POOL | \
-		awk '{ORS=\" \"; for (i = 2; i <= (NF - 1 < '$num_devs4raid' ? NF - 1 : '$num_devs4raid'); i++) print $i}'`"
-
-	# _scratch_mkfs adds the 1st device again (which is $SCRATCH_DEV)
-	_scratch_mkfs $mkfs_options $used_devs_without_1st >> $seqres.full 2>&1 || _fail "mkfs failed"
-
-	# create a filesystem on the target device just for the sake of
-	# being able to query its size with btrfs-show-super
-	$MKFS_BTRFS_PROG $MKFS_OPTIONS $target_dev >> $seqres.full 2>&1 || _fail "mkfs target_dev failed"
-
-	# The source and target devices for the replace operation are
-	# arbitrarily chosen out of the pool. Since the target device mustn't
-	# be smaller than the source device, the requirement for this test is
-	# that all devices have _exactly_ the same size. If this is not the
-	# case, this test is not run.
-	local num_lines=`$BTRFS_SHOW_SUPER_PROG $SCRATCH_DEV $used_devs_without_1st $target_dev | grep dev_item.total_bytes | uniq | wc -l`
-	if [ $num_lines -gt 1 ]; then
-		_notrun "Different device sizes detected"
-	fi
+	$WIPEFS_PROG -a $SCRATCH_DEV_POOL > /dev/null 2>&1
+	_scratch_dev_pool_get $num_devs4raid
+	_spare_dev_get
 
-	if [ `$BTRFS_SHOW_SUPER_PROG $SCRATCH_DEV | grep dev_item.total_bytes | awk '{print $2}'` -lt 2500000000 ]; then
-		_notrun "device size too small"
-	fi
+	_scratch_pool_mkfs $mkfs_options >> $seqres.full 2>&1 ||\
+		_fail "mkfs failed"
 
 	_scratch_mount
+	_require_fs_space $SCRATCH_MNT $((2 * 512 * 1024)) #2.5G
 
-	echo "$BTRFS_UTIL_PROG filesystem show" >> $seqres.full
-	$BTRFS_UTIL_PROG filesystem show >> $seqres.full
+	fill_scratch $fssize
+	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 
-	# Generate metadata and some minimal user data, generate 500 times
-	# 20K extents in the data chunk and fill up metadata with inline
-	# extents.
-	for i in `seq 1 500`; do
-		_ddt of=$SCRATCH_MNT/l$i bs=16385 count=1
-		_ddt of=$SCRATCH_MNT/s$i bs=3800 count=1
-	done > /dev/null 2>&1
-
-	# Generate a template once and quickly copy it multiple times.
-	_ddt of=$SCRATCH_MNT/t0 bs=1M count=1 > /dev/null 2>&1
+	echo -e "Replace from $source_dev to $SPARE_DEV\\n" >> $seqres.full
+	btrfs_replace_test $source_dev $SPARE_DEV "" $with_cancel $quick
 
-	if [ "${quick}Q" = "thoroughQ" ]; then
-		# The intention of this "thorough" test is to increase
-		# the probability of random errors, in particular in
-		# conjunction with the background noise generator and
-		# a sync call while the replace operation is ongoing.
-		fssize=2048
-	elif [ "${with_cancel}Q" = "cancelQ" ]; then
-		# The goal is to produce enough data to prevent that the
-		# replace operation finishes before the cancel request
-		# is started.
-		fssize=1024
-	else
-		fssize=64
-	fi
-
-	# since the available size was tested before, do not tolerate
-	# any failures
-	for i in `seq $fssize`; do
-		cp $SCRATCH_MNT/t0 $SCRATCH_MNT/t$i || _fail "cp failed"
-	done > /dev/null 2>> $seqres.full
-	sync; sync
-
-	btrfs_replace_test $source_dev $target_dev "" $with_cancel $quick
-	_scratch_unmount > /dev/null 2>&1
+	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 
+	# Skip -r test for configs without mirror OR replace cancel
 	if echo $mkfs_options | egrep -qv "raid1|raid5|raid6|raid10" || \
 	   [ "${with_cancel}Q" = "cancelQ" ]; then
-		# the -r option has no effect without mirrors, skip -r test
-		# in this case, and if only the canceling should be tested
-		# as well
+		_scratch_unmount > /dev/null 2>&1
+		_scratch_dev_pool_put
+		_spare_dev_put
 		return 0
 	fi
 
-	# One more time with the '-r' option this time. Instead of wasting
-	# time to populate the filesystem with data again, use the
-	# existing filesystem in the state as it is after the previous
-	# replace operation.
-	# If possible, use a strategy to select the source and target
-	# device so that we really change bits on the target disk, see
-	# below.
-
-	# The default: For the 2nd run, the new target drive is the old
-	# source drive, and the new source drive is the old target drive.
-	# Since except for the noise data, the copied data is already on
-	# the new target disk (which is the old source disk), this is not
-	# optimal to check whether data is copied correctly.
-	local tmp_dev="$source_dev"
-	source_dev="$target_dev"
-	target_dev="$tmp_dev"
-
-	# If we have at least one more device in the SCRATCH_DEV_POOL than
-	# used so far, use one of those for the new target devive.
-	if [ "`echo $SCRATCH_DEV_POOL | wc -w`" -gt `expr $num_devs4raid + 1` ]; then
-		target_dev="`echo ${SCRATCH_DEV_POOL} | awk '{print $(NF-1)}'`"
-	fi
-
-	# If the filesystem is built out of more than one devices, use a
-	# different source device for this round.
-	if [ $num_devs4raid -gt 1 ]; then
-		source_dev="`echo ${SCRATCH_DEV_POOL} | awk '{print $2}'`"
-	fi
+	# Due to above replace, now SPARE_DEV is part of the FS, check that.
+	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT |\
+		grep -qs $SPARE_DEV$ ||\
+		_fail "$SPARE_DEV is not part of SCRATCH_FS"
 
-	# Mount similar to _scratch_mount, but since the SCRATCH_DEV (the
-	# 1st device in SCRATCH_DEV_POOL) was replaced by the previous
-	# btrfs replace operation, substitute SCRATCH_DEV with a device
-	# that is known to be part of the SCRATCH_MNT filesystem.
-	_mount -t $FSTYP `_scratch_mount_options | sed "s&${SCRATCH_DEV}&${source_dev}&"`
-	if [ $? -ne 0 ]; then
-		echo "mount failed"
-		return 1
-	fi
+	btrfs_replace_test $SPARE_DEV $source_dev "-r" $with_cancel $quick
 
-	btrfs_replace_test $source_dev $target_dev "-r" $with_cancel $quick
 	_scratch_unmount > /dev/null 2>&1
+	_scratch_dev_pool_put
+	_spare_dev_put
 }
 
 btrfs_replace_test()
@@ -226,11 +162,9 @@ btrfs_replace_test()
 
 	if [ "${with_cancel}Q" = "cancelQ" ]; then
 		# background the replace operation (no '-B' option given)
-		echo "$BTRFS_UTIL_PROG replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT" >> $seqres.full
-		$BTRFS_UTIL_PROG replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "btrfs replace start failed"
+		_run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
 		sleep 1
-		echo "$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT" >> $seqres.full
-		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "btrfs replace cancel failed"
+		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
 
 		# 'replace status' waits for the replace operation to finish
 		# before the status is printed
@@ -244,8 +178,7 @@ btrfs_replace_test()
 			# a sync in the middle of the replace operation.
 			(sleep 1; sync) > /dev/null 2>&1 &
 		fi
-		echo "$BTRFS_UTIL_PROG replace start -Bf $replace_options $source_dev $target_dev $SCRATCH_MNT" >> $seqres.full
-		$BTRFS_UTIL_PROG replace start -Bf $replace_options $source_dev $target_dev $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "btrfs replace start failed"
+		_run_btrfs_util_prog replace start -Bf $replace_options $source_dev $target_dev $SCRATCH_MNT
 
 		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
 		cat $tmp.tmp >> $seqres.full
@@ -263,7 +196,7 @@ btrfs_replace_test()
 	# exit values != 0, including detected correctable and uncorrectable
 	# errors on the device.
 	sync; sync
-	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "btrfs scrub failed"
+	_run_btrfs_util_prog scrub start -B $SCRATCH_MNT
 
 	# Two tests are performed, the 1st is to btrfsck the filesystem,
 	# and the 2nd test is to mount the filesystem.
@@ -276,10 +209,6 @@ btrfs_replace_test()
 	_scratch_unmount > /dev/null 2>&1
 	if [ "${with_cancel}Q" != "cancelQ" ]; then
 		# after the replace operation, use the target_dev for everything
-		echo "$BTRFS_UTIL_PROG filesystem show -d" >> $seqres.full
-		$BTRFS_UTIL_PROG filesystem show -d >> $seqres.full
-		echo "$BTRFS_UTIL_PROG filesystem show" >> $seqres.full
-		$BTRFS_UTIL_PROG filesystem show >> $seqres.full
 		echo "_check_btrfs_filesystem $target_dev" >> $seqres.full
 		_check_btrfs_filesystem $target_dev
 		_mount -t $FSTYP `_scratch_mount_options | sed "s&${SCRATCH_DEV}&${target_dev}&"`
@@ -289,16 +218,16 @@ btrfs_replace_test()
 	fi
 }
 
-workout "-m single -d single" 1 no quick
-workout "-m single -d single -M" 1 no quick
-workout "-m dup -d single" 1 no quick
-workout "-m dup -d single" 1 cancel quick
-workout "-m dup -d dup -M" 1 no quick
-workout "-m raid0 -d raid0" 2 no quick
-workout "-m raid1 -d raid1" 2 no thorough
-workout "-m raid5 -d raid5" 2 no quick
-workout "-m raid6 -d raid6" 3 no quick
-workout "-m raid10 -d raid10" 4 no quick
+workout "-m single -d single" 1 no 64
+workout "-m single -d single -M" 1 no 64
+workout "-m dup -d single" 1 no 64
+workout "-m dup -d single" 1 cancel 1024
+workout "-m dup -d dup -M" 1 no 64
+workout "-m raid0 -d raid0" 2 no 64
+workout "-m raid1 -d raid1" 2 no 2048
+workout "-m raid5 -d raid5" 2 no 64
+workout "-m raid6 -d raid6" 3 no 64
+workout "-m raid10 -d raid10" 4 no 64
 
 echo "*** done"
 status=0
-- 
2.15.0

