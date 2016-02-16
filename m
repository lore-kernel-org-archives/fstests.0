Received: from imap.thunk.org ([74.207.234.97]:41266 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546AbcBPGnw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 16 Feb 2016 01:43:52 -0500
Date: Tue, 16 Feb 2016 01:43:48 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH-v3a 09/16] xfstests: do not unmount tmpfs during remount
Message-ID: <20160216064348.GC3426@thunk.org>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-10-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455385269-26319-10-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

I screwed up the test generic/135 in the previous version of the
commit.  Here is a revised version, which avoids an EBUSY due to CWD
being in SCRATCH_MNT when we attempted to unmount it.

      	 	     	     	       	  	  - Ted

>From a46e47d549f0d43f6c32f54e89817cc1a602b9bf Mon Sep 17 00:00:00 2001
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
 common/rc             | 23 ++++++++++++++++++++++-
 tests/generic/003     | 20 ++++++++------------
 tests/generic/135     | 19 +++++--------------
 tests/generic/169     | 20 ++++++--------------
 tests/generic/169.out |  6 ++----
 tests/generic/192     |  3 +--
 tests/generic/226     |  3 +--
 tests/generic/258     |  3 +--
 tests/generic/306     |  3 +--
 tests/generic/317     |  3 +--
 tests/generic/318     |  3 +--
 11 files changed, 49 insertions(+), 57 deletions(-)

diff --git a/common/rc b/common/rc
index 18d1a00..42415a7 100644
--- a/common/rc
+++ b/common/rc
@@ -329,10 +329,28 @@ _scratch_unmount()
 	esac
 }
 
+_scratch_remount()
+{
+    local opts="$1"
+
+    if test -n "$opts"; then
+	mount -o "remount,$opts" $SCRATCH_MNT
+    fi
+}
+
 _scratch_cycle_mount()
 {
+    local opts="$1"
+
+    if [ "$FSTYP" = tmpfs ]; then
+	_scratch_remount "$opts"
+	return
+    fi
+    if test -n "$opts"; then
+	opts="-o $opts"
+    fi
     _scratch_unmount
-    _scratch_mount
+    _scratch_mount "$opts"
 }
 
 _test_mount()
@@ -356,6 +374,9 @@ _test_unmount()
 
 _test_cycle_mount()
 {
+    if [ "$FSTYP" = tmpfs ]; then
+	return
+    fi
     _test_unmount
     _test_mount
 }
diff --git a/tests/generic/003 b/tests/generic/003
index 7ffd09a..710ffc8 100755
--- a/tests/generic/003
+++ b/tests/generic/003
@@ -107,9 +107,8 @@ file1_stat_after_second_access=`_stat $TPATH/dir1/file1`
 _compare_stat_times NNN "$file1_stat_after_first_access" \
 	"$file1_stat_after_second_access" "after accessing file1 second time"
 
-# Remounting with nodiratime option
-_scratch_unmount
-_scratch_mount "-o nodiratime"
+# Mounting with nodiratime option
+_scratch_cycle_mount "nodiratime"
 file1_stat_after_remount=`_stat $TPATH/dir1/file1`
 _compare_stat_times NNN "$file1_stat_after_second_access" \
 	"$file1_stat_after_remount" "for file1 after remount"
@@ -134,9 +133,8 @@ dir2_stat_after_file_access=`_stat $TPATH/dir2`
 _compare_stat_times NNN "$dir2_stat_after_file_creation" \
 	"$dir2_stat_after_file_access" "for dir2 after file access"
 
-# Remounting with noatime option, creating a file and accessing it
-_scratch_unmount
-_scratch_mount "-o noatime"
+# Mounting with noatime option, creating a file and accessing it
+_scratch_cycle_mount "noatime"
 echo "ccc" > $TPATH/dir2/file3
 file3_stat_before_first_access=`_stat $TPATH/dir2/file3`
 sleep 1
@@ -158,10 +156,9 @@ file1_stat_after_change=`_stat $TPATH/dir1/file1_renamed`
 _compare_stat_times NNY "$file1_stat_after_modify" \
 	"$file1_stat_after_change" "after changing file1"
 
-# Remounting with strictatime option and
+# Mounting with strictatime option and
 # accessing a previously created file twice
-_scratch_unmount
-_scratch_mount "-o strictatime"
+_scratch_cycle_mount "strictatime"
 cat $TPATH/dir2/file3 > /dev/null
 file3_stat_after_second_access=`_stat $TPATH/dir2/file3`
 _compare_stat_times YNN "$file3_stat_after_first_access" \
@@ -189,13 +186,12 @@ if [ "$FSTYP" = "btrfs" ]; then
 		"$file3_stat_readonly_after_access" "for file in readonly subvol"
 fi
 
-# Remounting read-only. Access time should never be updated, despite the
+# Mounting read-only. Access time should never be updated, despite the
 # strictatime mount option.
 sleep 1
 dir2_stat_before_ro_mount=`_stat $TPATH/dir2`
 file3_stat_before_ro_mount=`_stat $TPATH/dir2/file3`
-_scratch_unmount
-_scratch_mount "-o ro,strictatime"
+_scratch_cycle_mount "ro,strictatime"
 ls $TPATH/dir2 > /dev/null
 cat $TPATH/dir2/file3 > /dev/null
 dir2_stat_after_ro_mount=`_stat $TPATH/dir2`
diff --git a/tests/generic/135 b/tests/generic/135
index 4400672..52418f6 100755
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
 
@@ -71,7 +60,9 @@ $XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x78 0 4k' trunc_file > /dev/null
 $XFS_IO_PROG -f -c 'truncate 2k' trunc_file > /dev/null
 $XFS_IO_PROG -c 'pwrite 1k 0 1k' trunc_file > /dev/null
 
-_umount_mount
+pushd / > /dev/null
+_scratch_cycle_mount
+popd > /dev/null
 
 # check file size and contents
 od -Ad -x async_file
diff --git a/tests/generic/169 b/tests/generic/169
index 839ff9d..f51f4d1 100755
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
+_scratch_cycle_mount >>$seqres.full 2>&1 \
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
+_scratch_cycle_mount >>$seqres.full 2>&1 \
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
index ebabea2..6bbc87c 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -78,8 +78,7 @@ cat $testfile
 time2=`_access_time $testfile | tee -a $seqres.full`
 
 cd /
-_test_unmount
-_test_mount
+_test_cycle_mount
 time3=`_access_time $testfile | tee -a $seqres.full`
 
 delta1=`expr $time2 - $time1`
diff --git a/tests/generic/226 b/tests/generic/226
index b12965a..a099ec6 100755
--- a/tests/generic/226
+++ b/tests/generic/226
@@ -61,8 +61,7 @@ for I in `seq 1 $loops`; do
 done
 
 echo
-_scratch_unmount
-_scratch_mount
+_scratch_cycle_mount
 
 echo "--> $loops direct 64m writes in a loop"
 for I in `seq 1 $loops`; do
diff --git a/tests/generic/258 b/tests/generic/258
index 285a422..d28437f 100755
--- a/tests/generic/258
+++ b/tests/generic/258
@@ -62,8 +62,7 @@ fi
 
 # unmount, remount, and check the timestamp
 echo "Remounting to flush cache"
-_test_unmount
-_test_mount
+_test_cycle_mount
 
 # Should yield -315593940 (prior to epoch)
 echo "Testing for negative seconds since epoch"
diff --git a/tests/generic/306 b/tests/generic/306
index 64d8cde..86fd829 100755
--- a/tests/generic/306
+++ b/tests/generic/306
@@ -67,8 +67,7 @@ touch $BINDFILE || _fail "Could not create bind mount file"
 touch $TARGET || _fail "Could not create symlink target"
 ln -s $TARGET $SYMLINK
 
-_scratch_unmount || _fail "Could not unmount scratch device"
-_scratch_mount -o ro || _fail "Could not mount scratch readonly"
+_scratch_remount ro || _fail "Could not remount scratch readonly"
 
 # We should be able to read & write to/from these devices even on an RO fs
 echo "== try to create new file"
diff --git a/tests/generic/317 b/tests/generic/317
index 68f231c..a5d8804 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -96,8 +96,7 @@ echo ""
 echo "*** Remounting ***"
 echo ""
 sync
-_scratch_unmount >>$seqres.full 2>&1
-_scratch_mount      >>$seqres.full 2>&1 || _fail "mount failed"
+_scratch_cycle_mount      >>$seqres.full 2>&1 || _fail "remount failed"
 
 _print_numeric_uid
 
diff --git a/tests/generic/318 b/tests/generic/318
index c730b50..f850a9b 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -109,8 +109,7 @@ _print_getfacls
 echo "*** Remounting ***"
 echo ""
 sync
-_scratch_unmount >>$seqres.full 2>&1
-_scratch_mount      >>$seqres.full 2>&1 || _fail "mount failed"
+_scratch_cycle_mount      >>$seqres.full 2>&1 || _fail "remount failed"
 
 _print_getfacls
 
-- 
2.5.0

