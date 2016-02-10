Received: from imap.thunk.org ([74.207.234.97]:58932 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbcBJSEm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 13:04:42 -0500
Date: Wed, 10 Feb 2016 13:04:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 05/12] xfstests: do not unmount tmpfs during remount
Message-ID: <20160210180439.GH26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-6-git-send-email-tytso@mit.edu>
 <20160210060716.GV19486@dastard>
 <20160210160732.GE26922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210160732.GE26922@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

How about this?

				- Ted

>From e03fcd72962fc29e198173662635d4fa10779128 Mon Sep 17 00:00:00 2001
From: Junho Ryu <jayr@google.com>
Date: Wed, 18 Dec 2013 10:16:01 -0800
Subject: [PATCH] xfstests: do not unmount tmpfs during remount

Several tests unmount then re-mount the scratch filesystem, to check
that the content is unchanged; but unmounting a tmpfs is designed to
lose its content, which causes such tests to fail unnecessarily.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Junho Ryu <jayr@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc             | 23 +++++++++++++++++++++++
 tests/generic/003     | 12 ++++--------
 tests/generic/135     | 17 +++--------------
 tests/generic/169     | 20 ++++++--------------
 tests/generic/169.out |  6 ++----
 tests/generic/192     |  3 +--
 tests/generic/226     |  3 +--
 tests/generic/258     |  3 +--
 tests/generic/306     |  3 +--
 tests/generic/317     |  3 +--
 tests/generic/318     |  3 +--
 11 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/common/rc b/common/rc
index aca723f..69c9586 100644
--- a/common/rc
+++ b/common/rc
@@ -331,10 +331,30 @@ _scratch_unmount()
 
 _scratch_remount()
 {
+    if [ "$FSTYP" = tmpfs ]; then
+	return
+    fi
     _scratch_unmount
     _scratch_mount
 }
 
+_scratch_change_mount_opts()
+{
+    case $FSTYP in
+    tmpfs)
+        OPTS="$@"
+	if test -n "$OPTS"; then
+	   OPTS=$(echo $OPTS | sed -e 's/-o /-o remount,/')
+	   mount $OPTS $SCRATCH_MNT
+	fi
+        ;;
+    *)
+        _scratch_unmount
+        _scratch_mount "$@"
+        ;;
+    esac
+}
+
 _test_mount()
 {
     if [ "$FSTYP" == "overlay" ]; then
@@ -356,6 +376,9 @@ _test_unmount()
 
 _test_remount()
 {
+    if [ "$FSTYP" = tmpfs ]; then
+	return
+    fi
     _test_unmount
     _test_mount
 }
diff --git a/tests/generic/003 b/tests/generic/003
index 7ffd09a..e6cb3c4 100755
--- a/tests/generic/003
+++ b/tests/generic/003
@@ -108,8 +108,7 @@ _compare_stat_times NNN "$file1_stat_after_first_access" \
 	"$file1_stat_after_second_access" "after accessing file1 second time"
 
 # Remounting with nodiratime option
-_scratch_unmount
-_scratch_mount "-o nodiratime"
+_scratch_change_mount_opts "-o nodiratime"
 file1_stat_after_remount=`_stat $TPATH/dir1/file1`
 _compare_stat_times NNN "$file1_stat_after_second_access" \
 	"$file1_stat_after_remount" "for file1 after remount"
@@ -135,8 +134,7 @@ _compare_stat_times NNN "$dir2_stat_after_file_creation" \
 	"$dir2_stat_after_file_access" "for dir2 after file access"
 
 # Remounting with noatime option, creating a file and accessing it
-_scratch_unmount
-_scratch_mount "-o noatime"
+_scratch_change_mount_opts "-o noatime"
 echo "ccc" > $TPATH/dir2/file3
 file3_stat_before_first_access=`_stat $TPATH/dir2/file3`
 sleep 1
@@ -160,8 +158,7 @@ _compare_stat_times NNY "$file1_stat_after_modify" \
 
 # Remounting with strictatime option and
 # accessing a previously created file twice
-_scratch_unmount
-_scratch_mount "-o strictatime"
+_scratch_change_mount_opts "-o strictatime"
 cat $TPATH/dir2/file3 > /dev/null
 file3_stat_after_second_access=`_stat $TPATH/dir2/file3`
 _compare_stat_times YNN "$file3_stat_after_first_access" \
@@ -194,8 +191,7 @@ fi
 sleep 1
 dir2_stat_before_ro_mount=`_stat $TPATH/dir2`
 file3_stat_before_ro_mount=`_stat $TPATH/dir2/file3`
-_scratch_unmount
-_scratch_mount "-o ro,strictatime"
+_scratch_change_mount_opts "-o ro,strictatime"
 ls $TPATH/dir2 > /dev/null
 cat $TPATH/dir2/file3 > /dev/null
 dir2_stat_after_ro_mount=`_stat $TPATH/dir2`
diff --git a/tests/generic/135 b/tests/generic/135
index 4400672..9872c7b 100755
--- a/tests/generic/135
+++ b/tests/generic/135
@@ -41,19 +41,8 @@ _supported_os Linux IRIX
 
 _require_odirect
 _require_scratch
-_scratch_mkfs >/dev/null 2>&1
-
-_umount_mount()
-{
-    CWD=`pwd`
-    cd /
-    # pipe error into /dev/null, in case not mounted (after _require_scratch)
-    _scratch_unmount 2>/dev/null
-    _scratch_mount
-    cd "$CWD"
-}
-
-_umount_mount
+_scratch_mkfs >/dev/null
+_scratch_mount
 
 cd $SCRATCH_MNT
 
@@ -71,7 +60,7 @@ $XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x78 0 4k' trunc_file > /dev/null
 $XFS_IO_PROG -f -c 'truncate 2k' trunc_file > /dev/null
 $XFS_IO_PROG -c 'pwrite 1k 0 1k' trunc_file > /dev/null
 
-_umount_mount
+_scratch_remount
 
 # check file size and contents
 od -Ad -x async_file
diff --git a/tests/generic/169 b/tests/generic/169
index 839ff9d..ebfb106 100755
--- a/tests/generic/169
+++ b/tests/generic/169
@@ -73,13 +73,9 @@ $XFS_IO_PROG -a -c "pwrite 0 5k" -c "fsync" \
 	$SCRATCH_MNT/testfile \
 	| _show_wrote_and_stat_only
 
-echo "# unmounting scratch"
-_scratch_unmount>>$seqres.full 2>&1 \
-    || _fail "unmount failed"
-
-echo "# mounting scratch"
-_scratch_mount >>$seqres.full 2>&1 \
-    || _fail "mount failed: $MOUNT_OPTIONS"
+echo "# remounting scratch"
+_scratch_remount >>$seqres.full 2>&1 \
+    || _fail "remount failed: $MOUNT_OPTIONS"
 
 echo "# stating file to confirm correct size"
 $XFS_IO_PROG -r -c "stat" $SCRATCH_MNT/testfile \
@@ -90,13 +86,9 @@ $XFS_IO_PROG -f -c "pwrite 0 5" -c s -c "pwrite 5 5" \
 	-c "stat" $SCRATCH_MNT/nextfile \
 	| _show_wrote_and_stat_only
 
-echo "# unmounting scratch"
-_scratch_unmount>>$seqres.full 2>&1 \
-    || _fail "unmount failed"
-
-echo "# mounting scratch"
-_scratch_mount >>$seqres.full 2>&1 \
-    || _fail "mount failed: $MOUNT_OPTIONS"
+echo "# remounting scratch"
+_scratch_remount >>$seqres.full 2>&1 \
+    || _fail "remount failed: $MOUNT_OPTIONS"
 
 echo "# stating file to confirm correct size"
 $XFS_IO_PROG -r -c "stat" $SCRATCH_MNT/nextfile \
diff --git a/tests/generic/169.out b/tests/generic/169.out
index 22a5b77..5f7df39 100644
--- a/tests/generic/169.out
+++ b/tests/generic/169.out
@@ -5,15 +5,13 @@ wrote 5120/5120 bytes at offset 0
 wrote 5120/5120 bytes at offset 5120
 wrote 5120/5120 bytes at offset 10240
 stat.size = 15360
-# unmounting scratch
-# mounting scratch
+# remounting scratch
 # stating file to confirm correct size
 stat.size = 15360
 # appending 10 bytes to new file, sync at 5 bytes
 wrote 5/5 bytes at offset 0
 wrote 5/5 bytes at offset 5
 stat.size = 10
-# unmounting scratch
-# mounting scratch
+# remounting scratch
 # stating file to confirm correct size
 stat.size = 10
diff --git a/tests/generic/192 b/tests/generic/192
index ebabea2..c64b954 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -78,8 +78,7 @@ cat $testfile
 time2=`_access_time $testfile | tee -a $seqres.full`
 
 cd /
-_test_unmount
-_test_mount
+_test_remount
 time3=`_access_time $testfile | tee -a $seqres.full`
 
 delta1=`expr $time2 - $time1`
diff --git a/tests/generic/226 b/tests/generic/226
index b12965a..253e82c 100755
--- a/tests/generic/226
+++ b/tests/generic/226
@@ -61,8 +61,7 @@ for I in `seq 1 $loops`; do
 done
 
 echo
-_scratch_unmount
-_scratch_mount
+_scratch_remount
 
 echo "--> $loops direct 64m writes in a loop"
 for I in `seq 1 $loops`; do
diff --git a/tests/generic/258 b/tests/generic/258
index 285a422..dd5c970 100755
--- a/tests/generic/258
+++ b/tests/generic/258
@@ -62,8 +62,7 @@ fi
 
 # unmount, remount, and check the timestamp
 echo "Remounting to flush cache"
-_test_unmount
-_test_mount
+_test_remount
 
 # Should yield -315593940 (prior to epoch)
 echo "Testing for negative seconds since epoch"
diff --git a/tests/generic/306 b/tests/generic/306
index 64d8cde..725520b 100755
--- a/tests/generic/306
+++ b/tests/generic/306
@@ -67,8 +67,7 @@ touch $BINDFILE || _fail "Could not create bind mount file"
 touch $TARGET || _fail "Could not create symlink target"
 ln -s $TARGET $SYMLINK
 
-_scratch_unmount || _fail "Could not unmount scratch device"
-_scratch_mount -o ro || _fail "Could not mount scratch readonly"
+_scratch_change_mount_opts -o ro || _fail "Could not remount scratch readonly"
 
 # We should be able to read & write to/from these devices even on an RO fs
 echo "== try to create new file"
diff --git a/tests/generic/317 b/tests/generic/317
index 68f231c..0aaf10e 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -96,8 +96,7 @@ echo ""
 echo "*** Remounting ***"
 echo ""
 sync
-_scratch_unmount >>$seqres.full 2>&1
-_scratch_mount      >>$seqres.full 2>&1 || _fail "mount failed"
+_scratch_remount      >>$seqres.full 2>&1 || _fail "remount failed"
 
 _print_numeric_uid
 
diff --git a/tests/generic/318 b/tests/generic/318
index c730b50..2d39b21 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -109,8 +109,7 @@ _print_getfacls
 echo "*** Remounting ***"
 echo ""
 sync
-_scratch_unmount >>$seqres.full 2>&1
-_scratch_mount      >>$seqres.full 2>&1 || _fail "mount failed"
+_scratch_remount      >>$seqres.full 2>&1 || _fail "remount failed"
 
 _print_getfacls
 
-- 
2.5.0

