Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:9706 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753259AbeF0IVN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:21:13 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-00083G-1n
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-0002iw-0j
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/8] shared: use new test setup preamble
Date: Wed, 27 Jun 2018 18:20:58 +1000
Message-Id: <20180627082103.9662-4-david@fromorbit.com>
In-Reply-To: <20180627082103.9662-1-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/shared/001 | 33 ++++++++++-----------------------
 tests/shared/002 | 40 ++++++++++++++--------------------------
 tests/shared/003 | 35 ++++++++++-------------------------
 tests/shared/004 | 27 +++++++--------------------
 tests/shared/005 | 30 ++++++++----------------------
 tests/shared/006 | 35 +++++++++++------------------------
 tests/shared/007 | 30 +++++++++---------------------
 tests/shared/032 | 26 +++++++++-----------------
 tests/shared/272 | 34 ++++++++++++++--------------------
 tests/shared/289 | 31 +++++++------------------------
 tests/shared/298 | 48 ++++++++++++++++++++++--------------------------
 11 files changed, 121 insertions(+), 248 deletions(-)

diff --git a/tests/shared/001 b/tests/shared/001
index bde6e1987d90..80caa30e7f71 100755
--- a/tests/shared/001
+++ b/tests/shared/001
@@ -9,31 +9,19 @@
 #
 # 721e3eb ext4: lock i_mutex when truncating orphan inodes
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() { :; }
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
 _supported_fs ext2 ext3 ext4
 _supported_os Linux
 _require_scratch
 
-rm -f $seqres.full
 echo "Silence is golden"
 
 _scratch_mkfs_sized $((16*1024*1024)) >>$seqres.full 2>&1
@@ -52,5 +40,4 @@ debugfs -w -R "set_super_value last_orphan $inode" $SCRATCH_DEV \
 # mount again to truncate orphan inode, _check_dmesg will catch the WARNING
 _scratch_mount
 
-status=0
-exit
+_success
diff --git a/tests/shared/002 b/tests/shared/002
index 30ece3370601..ac7352bffc44 100755
--- a/tests/shared/002
+++ b/tests/shared/002
@@ -10,43 +10,32 @@
 # fsync log/journal is replayed, the xattrs still exist and with the correct
 # values.
 #
+# We create a lot of xattrs for a single file. Only btrfs and xfs are currently
+# able to store such a large mount of xattrs per file, other filesystems such
+# as ext3/4 and f2fs for example, fail with ENOSPC even if we attempt to add
+# less than 1000 xattrs with very small values.
+#
 # This test is motivated by a bug found in btrfs.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-
-_cleanup()
-{
+# test exit cleanup goes here
+cleanup() {
 	_cleanup_flakey
-	rm -f $tmp.*
 }
-trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
 . ./common/dmflakey
 . ./common/attr
-
-# real QA test starts here
-
-# We create a lot of xattrs for a single file. Only btrfs and xfs are currently
-# able to store such a large mount of xattrs per file, other filesystems such
-# as ext3/4 and f2fs for example, fail with ENOSPC even if we attempt to add
-# less than 1000 xattrs with very small values.
-_supported_fs btrfs xfs
 _supported_os Linux
+_supported_fs btrfs xfs
 _require_scratch
 _require_dm_target flakey
 _require_attrs
 
-rm -f $seqres.full
-
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
@@ -94,5 +83,4 @@ for ((i = 1; i <= $num_xattrs; i++)); do
 	echo
 done
 
-status=0
-exit
+_success
diff --git a/tests/shared/003 b/tests/shared/003
index 761b9691d4cc..23501b274101 100755
--- a/tests/shared/003
+++ b/tests/shared/003
@@ -11,34 +11,21 @@
 #
 # Also test on ext2/3.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() { :; }
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
 _supported_fs ext2 ext3 ext4
 _supported_os Linux
 
 # nofsck as we modify sb via debugfs
 _require_scratch_nocheck
 
-# remove previous $seqres.full before test
-rm -f $seqres.full
 echo "Silence is golden"
 
 _scratch_mkfs >>$seqres.full 2>&1
@@ -50,6 +37,4 @@ debugfs -w -R "feature +needs_recovery" $SCRATCH_DEV \
 # mount with noload option
 _try_scratch_mount "-o noload" >>$seqres.full 2>&1
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/shared/004 b/tests/shared/004
index 3021c85d51eb..d5fe835ea8a3 100755
--- a/tests/shared/004
+++ b/tests/shared/004
@@ -7,31 +7,20 @@
 # Regression test for commit:
 # c9eb13a ext4: fix hang when processing corrupted orphaned inode list
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs ext2 ext3 ext4
 _supported_os Linux
 _require_scratch
 _require_command "$DEBUGFS_PROG" debugfs
 
-# remove previous $seqres.full before test
-rm -f $seqres.full
 echo "Silence is golden"
 
 # Although the bug only happens when last_orphan is set to 5
@@ -44,6 +33,4 @@ for i in {1..10}; do
 	_scratch_unmount
 done
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/shared/005 b/tests/shared/005
index 67940dd0d0fc..e9df81a67ce8 100755
--- a/tests/shared/005
+++ b/tests/shared/005
@@ -13,33 +13,21 @@
 # So, create this malformed inode and try a buffered append to make
 # sure we catch this situation.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-PIDS=""
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
-_supported_os Linux
+# include test specific environments here
 _supported_fs ext2 ext3 ext4
+_supported_os Linux
 _require_scratch_nocheck
 _disable_dmesg_check
 _require_command "$DEBUGFS_PROG"
 
-rm -f $seqres.full
-
 echo "Format and mount"
 _scratch_mkfs  >> $seqres.full 2>&1
 _scratch_mount
@@ -60,6 +48,4 @@ _scratch_mount
 dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
 sync
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/shared/006 b/tests/shared/006
index aa65e9a29e7b..d7a8cd9c6b6b 100755
--- a/tests/shared/006
+++ b/tests/shared/006
@@ -9,20 +9,18 @@
 # Also a regression test for xfsprogs commit
 # d586858 xfs_repair: fix sibling pointer tests in verify_dir2_path()
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-}
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs ext4 ext3 ext2 xfs
+_supported_os Linux
+_require_scratch
 
 create_file()
 {
@@ -37,17 +35,7 @@ create_file()
 	done
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
 
-# real QA test starts here
-_supported_fs ext4 ext3 ext2 xfs
-_supported_os Linux
-
-_require_scratch
-
-rm -f $seqres.full
 echo "Silence is golden"
 
 _scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1
@@ -77,5 +65,4 @@ rm -rf $SCRATCH_MNT/testdir
 echo "Inode status after deleting all test files" >>$seqres.full
 $DF_PROG -i $SCRATCH_MNT >>$seqres.full
 
-status=0
-exit
+_success
diff --git a/tests/shared/007 b/tests/shared/007
index 65cb5273b6a0..a552c1aba3aa 100755
--- a/tests/shared/007
+++ b/tests/shared/007
@@ -13,32 +13,22 @@
 # So, create this malformed inode and try a dio append to make sure we
 # catch this situation.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-PIDS=""
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	rm -f $tmp.*
-}
+# test exit cleanup goes here
+cleanup() { :; }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
-_supported_os Linux
+# include test specific environments here
 _supported_fs ext2 ext3 ext4
+_supported_os Linux
 _require_scratch_nocheck
 _disable_dmesg_check
 _require_command "$DEBUGFS_PROG"
 
-rm -f $seqres.full
+PIDS=""
 
 echo "Format and mount"
 _scratch_mkfs  >> $seqres.full 2>&1
@@ -62,6 +52,4 @@ _scratch_mount
 dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=direct,append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
 sync
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/shared/032 b/tests/shared/032
index 3b0263b2ce78..ef0dc936b31e 100755
--- a/tests/shared/032
+++ b/tests/shared/032
@@ -6,34 +6,28 @@
 #
 # cross check mkfs detection of foreign filesystems
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
-rm -f $seqres.full
+# test exit cleanup goes here
+cleanup() { :; }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs xfs btrfs
 _supported_os Linux
-
 _require_scratch_nocheck
 _require_no_large_scratch_dev
 
+echo "Silence is golden."
+
 # mkfs.btrfs did not have overwrite detection at first
 if [ "$FSTYP" == "btrfs" ]; then
 	grep -q 'force overwrite' `echo $MKFS_BTRFS_PROG | awk '{print $1}'` || \
 		_notrun "Installed mkfs.btrfs does not support -f option"
 fi
 
-echo "Silence is golden."
 for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
 do
 	preop=""	# for special input needs
@@ -75,6 +69,4 @@ do
 	fi
 done
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/shared/272 b/tests/shared/272
index b94dfc3c3d87..5c694308ae6b 100755
--- a/tests/shared/272
+++ b/tests/shared/272
@@ -6,21 +6,23 @@
 #
 # Test data journaling flag switch for a single file  
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs ext3 ext4
+_supported_os Linux
+_require_scratch
+_exclude_scratch_mount_option dax
 
 # ext3 and ext4 don't support direct IO in journalling mode
 write_opt_list="iflag=noatime conv=notrunc conv=fsync"
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
 _workout()
 {
 	echo "Switch data journalling mode. Silence is golden."
@@ -32,7 +34,6 @@ _workout()
 		idx=$((idx + 1))
 		for chattr_opt in $chattr_opt_list
 		do
-		    
 			echo "OP write_opt: $write_opt 4M, \
 chattr_opt: $chattr_opt" >>$seqres.full
 			dd if=/dev/zero of=$SCRATCH_MNT/file.$idx \
@@ -63,13 +64,6 @@ chattr_opt: $chattr_opt" >>$seqres.full
 	done
 }
 
-# real QA test starts here
-_supported_fs ext3 ext4
-_supported_os Linux
-_require_scratch
-_exclude_scratch_mount_option dax
-
-rm -f $seqres.full
 _scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
 
@@ -86,5 +80,5 @@ if ! _scratch_unmount; then
 	exit
 fi
 echo "Check filesystem"
-status=0
-exit
+
+_success
diff --git a/tests/shared/289 b/tests/shared/289
index 94b644302b2d..7466fc2726f2 100755
--- a/tests/shared/289
+++ b/tests/shared/289
@@ -6,34 +6,19 @@
 #
 # Test overhead & df output for extN filesystems
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# Modify as appropriate.
+# include test specific environments here
 _supported_fs ext2 ext3 ext4
 _supported_os Linux
 _require_scratch
 
-rm -f $seqres.full
-
 _scratch_mkfs >> $seqres.full 2>&1
 
 # Get the honest truth about block counts straight from metadata on disk
@@ -79,6 +64,4 @@ _within_tolerance "minix f_blocks" $MINIX_F_BLOCKS $TOTAL_BLOCKS 0 -v
 # bsd should be within ... we'll say 1% for some slop
 _within_tolerance "bsd f_blocks" $BSD_F_BLOCKS $(($TOTAL_BLOCKS-$OVERHEAD)) 1% -v
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/shared/298 b/tests/shared/298
index e7b7b233de45..fc2d090a2f66 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -6,15 +6,22 @@
 #
 # Test that filesystem sends discard requests only on free blocks
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() {
+	$UMOUNT_PROG $loop_dev &> /dev/null
+	_destroy_loop_device $loop_dev
+	if [ $status -eq 0 ]; then
+		rm $img_file
+		rm -rf $workdir
+	fi
+}
 
-. ./common/rc
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
+# include test specific environments here
 _supported_fs ext4 xfs
 _supported_os Linux
 _require_test
@@ -24,15 +31,8 @@ _require_xfs_io_command "fiemap"
 _require_fs_space $TEST_DIR 307200
 [ "$FSTYP" = "ext4" ] && _require_dumpe2fs
 
-_cleanup()
-{
-	$UMOUNT_PROG $loop_dev &> /dev/null
-	_destroy_loop_device $loop_dev
-	if [ $status -eq 0 ]; then
-		rm -rf $tmp
-		rm $img_file
-	fi
-}
+workdir=$TEST_DIR/$$
+mkdir -p $workdir
 
 get_holes()
 {
@@ -70,7 +70,7 @@ merge_ranges()
 	file1=$1
 	file2=$2
 
-	tmp_file=$tmp/sectors.tmp
+	tmp_file=$workdir/sectors.tmp
 
 	cat $file1 $file2 | sort -n > $tmp_file
 
@@ -101,19 +101,16 @@ merge_ranges()
 	rm $tmp_file
 }
 
-here=`pwd`
-tmp=`mktemp -d`
-
 img_file=$TEST_DIR/$$.fs
 dd if=/dev/zero of=$img_file bs=1M count=300 &> /dev/null
 
 loop_dev=$(_create_loop_device $img_file)
-loop_mnt=$tmp/loop_mnt
+loop_mnt=$workdir/loop_mnt
 
-fiemap_ref="$tmp/reference"
-fiemap_after="$tmp/after"
-free_sectors="$tmp/free_sectors"
-merged_sectors="$tmp/merged_free_sectors"
+fiemap_ref="$workdir/reference"
+fiemap_after="$workdir/after"
+free_sectors="$workdir/free_sectors"
+merged_sectors="$workdir/merged_free_sectors"
 
 mkdir $loop_mnt
 
@@ -173,5 +170,4 @@ while read line; do
 done < $fiemap_after
 echo "done."
 
-status=0
-exit
+_success
-- 
2.17.0

