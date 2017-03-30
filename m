Received: from mx2.suse.de ([195.135.220.15]:57053 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933048AbdC3PVQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 30 Mar 2017 11:21:16 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F8A8AB45
        for <fstests@vger.kernel.org>; Thu, 30 Mar 2017 15:21:14 +0000 (UTC)
From: David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: reorder arguments so that options come first
Date: Thu, 30 Mar 2017 17:20:18 +0200
Message-Id: <20170330152018.16575-1-dsterba@suse.com>
In-Reply-To: <20170330145551.14159-1-dsterba@suse.com>
References: <20170330145551.14159-1-dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
List-ID: <fstests@vger.kernel.org>

The option parser in the btrfs utility is going to be updated and will
accept arguments in a stricter form, namely that options must come
before their non-option argument. Otherwise eg. the -f option in send
would be understood as another path and not an option leading to many
test failures.

The canonical form should be:

  btrfs command subcommand [-options] [arguments]

Signed-off-by: David Sterba <dsterba@suse.com>
---

- one case missed

 tests/btrfs/008 |  4 ++--
 tests/btrfs/016 |  7 ++++---
 tests/btrfs/019 |  2 +-
 tests/btrfs/025 | 10 +++++-----
 tests/btrfs/030 | 10 +++++-----
 tests/btrfs/034 | 10 +++++-----
 tests/btrfs/036 |  2 +-
 tests/btrfs/038 | 12 ++++++------
 tests/btrfs/039 | 10 +++++-----
 tests/btrfs/040 | 10 +++++-----
 tests/btrfs/043 | 10 +++++-----
 tests/btrfs/044 | 10 +++++-----
 tests/btrfs/045 | 10 +++++-----
 tests/btrfs/046 | 10 +++++-----
 tests/btrfs/048 | 10 +++++-----
 tests/btrfs/050 |  4 ++--
 tests/btrfs/051 |  4 ++--
 tests/btrfs/053 | 10 +++++-----
 tests/btrfs/054 | 10 +++++-----
 tests/btrfs/058 |  2 +-
 tests/btrfs/077 | 10 +++++-----
 tests/btrfs/083 | 10 +++++-----
 tests/btrfs/084 | 10 +++++-----
 tests/btrfs/087 | 10 +++++-----
 tests/btrfs/092 | 10 +++++-----
 tests/btrfs/094 | 10 +++++-----
 tests/btrfs/097 | 10 +++++-----
 tests/btrfs/105 | 10 +++++-----
 tests/btrfs/108 |  4 ++--
 tests/btrfs/109 |  4 ++--
 tests/btrfs/110 | 12 ++++++------
 tests/btrfs/111 | 20 ++++++++++----------
 tests/btrfs/117 | 12 ++++++------
 tests/btrfs/127 | 10 +++++-----
 tests/btrfs/128 | 10 +++++-----
 tests/btrfs/129 | 10 +++++-----
 tests/btrfs/133 | 18 +++++++++---------
 tests/btrfs/134 | 12 ++++++------
 tests/btrfs/135 | 18 +++++++++---------
 tests/btrfs/137 | 10 +++++-----
 40 files changed, 189 insertions(+), 188 deletions(-)

diff --git a/tests/btrfs/008 b/tests/btrfs/008
index d08003ab8efc..d60f2555b1e1 100755
--- a/tests/btrfs/008
+++ b/tests/btrfs/008
@@ -77,9 +77,9 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $work_dir $work_dir/snapshots/backup2 \
 	>> $seqres.full 2>&1 || _fail "failed backup2"
 $BTRFS_UTIL_PROG subvolume snapshot -r $work_dir $work_dir/snapshots/backup3 \
 	>> $seqres.full 2>&1 || _fail "failed backup3"
-$BTRFS_UTIL_PROG send $work_dir/snapshots/backup3/ -f $TEST_DIR/$tmp_dir/blah \
+$BTRFS_UTIL_PROG send -f $TEST_DIR/$tmp_dir/blah $work_dir/snapshots/backup3 \
 	>> $seqres.full 2>&1 || _fail "send failed"
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -vvvv -f $TEST_DIR/$tmp_dir/blah \
+$BTRFS_UTIL_PROG receive -vvvv -f $TEST_DIR/$tmp_dir/blah $SCRATCH_MNT \
 	>> $seqres.full 2>&1 || _fail "receive failed"
 
 echo "Silence is golden"
diff --git a/tests/btrfs/016 b/tests/btrfs/016
index 833246d304f6..de4f1a840195 100755
--- a/tests/btrfs/016
+++ b/tests/btrfs/016
@@ -79,10 +79,11 @@ $FSSUM_PROG -A -f -w $tmp/fssum.snap $TEST_DIR/$tmp_dir/snap >> $seqres.full \
 $FSSUM_PROG -A -f -w $tmp/fssum.snap1 $TEST_DIR/$tmp_dir/snap1 >> $seqres.full \
 	2>&1 || _fail "fssum gen failed"
 
-$BTRFS_UTIL_PROG send $TEST_DIR/$tmp_dir/snap -f $tmp/send.snap >> \
+$BTRFS_UTIL_PROG send -f $tmp/send.snap $TEST_DIR/$tmp_dir/snap >> \
 	$seqres.full 2>&1 || _fail "failed send"
-$BTRFS_UTIL_PROG send $TEST_DIR/$tmp_dir/snap1 -p $TEST_DIR/$tmp_dir/snap \
-	-f $tmp/send.snap1 >> $seqres.full 2>&1 || _fail "failed send"
+$BTRFS_UTIL_PROG send -p $TEST_DIR/$tmp_dir/snap \
+	-f $tmp/send.snap1 $TEST_DIR/$tmp_dir/snap1 \
+	>> $seqres.full 2>&1 || _fail "failed send"
 
 $BTRFS_UTIL_PROG receive -f $tmp/send.snap $SCRATCH_MNT >> $seqres.full 2>&1 \
 	|| _fail "failed recv"
diff --git a/tests/btrfs/019 b/tests/btrfs/019
index 452d24b809d7..212c0586be68 100755
--- a/tests/btrfs/019
+++ b/tests/btrfs/019
@@ -96,7 +96,7 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
 	$TEST_DIR/$tmp_dir/snap2 >> $seqres.full 2>&1 || _fail "failed snap2"
 
 $BTRFS_UTIL_PROG send -f $TEST_DIR/$tmp_dir/send2.dump \
-	$TEST_DIR/$tmp_dir/snap2 -p $TEST_DIR/$tmp_dir/snap1 \
+	-p $TEST_DIR/$tmp_dir/snap1 $TEST_DIR/$tmp_dir/snap2 \
 	>> $seqres.full 2>&1 || _fail "failed second send"
 
 $BTRFS_UTIL_PROG receive -f $TEST_DIR/$tmp_dir/send2.dump $SCRATCH_MNT \
diff --git a/tests/btrfs/025 b/tests/btrfs/025
index 81ae94371d3c..43d7e6cb33f0 100755
--- a/tests/btrfs/025
+++ b/tests/btrfs/025
@@ -71,9 +71,9 @@ _run_btrfs_util_prog filesystem sync $SCRATCH_MNT
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT \
     $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $tmp/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-    -f $tmp/2.snap 2>&1
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+    $SCRATCH_MNT/mysnap2 2>&1
 
 md5sum $SCRATCH_MNT/foo | _filter_scratch
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
@@ -84,10 +84,10 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 md5sum $SCRATCH_MNT/mysnap2/foo | _filter_scratch
 
 _scratch_unmount
diff --git a/tests/btrfs/030 b/tests/btrfs/030
index a8e08f6ed742..6b67de08713f 100755
--- a/tests/btrfs/030
+++ b/tests/btrfs/030
@@ -165,19 +165,19 @@ run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
     $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $tmp/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-    -f $tmp/2.snap
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -f $tmp/2.snap -p $SCRATCH_MNT/mysnap1 \
+    $SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
 
 _scratch_unmount
diff --git a/tests/btrfs/034 b/tests/btrfs/034
index 179c827c1a16..f27ab34cbde5 100755
--- a/tests/btrfs/034
+++ b/tests/btrfs/034
@@ -72,9 +72,9 @@ $XFS_IO_PROG -c "truncate 3882008" $SCRATCH_MNT/foo
 
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $tmp/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-    -f $tmp/2.snap
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -f $tmp/2.snap -p $SCRATCH_MNT/mysnap1 \
+	$SCRATCH_MNT/mysnap2
 
 md5sum $SCRATCH_MNT/foo | _filter_scratch
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
@@ -85,10 +85,10 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 md5sum $SCRATCH_MNT/mysnap2/foo | _filter_scratch
 
 _scratch_unmount
diff --git a/tests/btrfs/036 b/tests/btrfs/036
index 57ad73717f68..7e5f281e164e 100755
--- a/tests/btrfs/036
+++ b/tests/btrfs/036
@@ -80,6 +80,6 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 do_snapshots &
 snapshots_pid=$!
 
-$BTRFS_UTIL_PROG send $SCRATCH_MNT/snap_1 -f /dev/null 2>&1 | _filter_scratch
+$BTRFS_UTIL_PROG send -f /dev/null $SCRATCH_MNT/snap_1 2>&1 | _filter_scratch
 
 status=0 ; exit
diff --git a/tests/btrfs/038 b/tests/btrfs/038
index d75ed4819a04..e46b7eb13a5c 100755
--- a/tests/btrfs/038
+++ b/tests/btrfs/038
@@ -88,10 +88,10 @@ run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 run_check $FSSUM_PROG -A -f -w $tmp/clones.fssum $SCRATCH_MNT/clones_snap \
 	-x $SCRATCH_MNT/clones_snap/mysnap1 -x $SCRATCH_MNT/clones_snap/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $tmp/1.snap
-_run_btrfs_util_prog send $SCRATCH_MNT/clones_snap -f $tmp/clones.snap
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -f $tmp/clones.snap $SCRATCH_MNT/clones_snap
 _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 \
-	-c $SCRATCH_MNT/clones_snap $SCRATCH_MNT/mysnap2 -f $tmp/2.snap
+	-c $SCRATCH_MNT/clones_snap -f $tmp/2.snap $SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_btrfs_filesystem $SCRATCH_DEV
@@ -99,13 +99,13 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/clones.snap
+_run_btrfs_util_prog receive -f $tmp/clones.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/clones.fssum $SCRATCH_MNT/clones_snap 2>> $seqres.full
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
 
 _scratch_unmount
diff --git a/tests/btrfs/039 b/tests/btrfs/039
index ac7144ff8a5f..25380dc178ba 100755
--- a/tests/btrfs/039
+++ b/tests/btrfs/039
@@ -104,9 +104,9 @@ run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $tmp/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $tmp/2.snap
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_btrfs_filesystem $SCRATCH_DEV
@@ -114,10 +114,10 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
 
 _scratch_unmount
diff --git a/tests/btrfs/040 b/tests/btrfs/040
index c97ed508e723..13584b1e514c 100755
--- a/tests/btrfs/040
+++ b/tests/btrfs/040
@@ -97,9 +97,9 @@ run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $tmp/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $tmp/2.snap
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_btrfs_filesystem $SCRATCH_DEV
@@ -107,10 +107,10 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
 
 _scratch_unmount
diff --git a/tests/btrfs/043 b/tests/btrfs/043
index 1ba5acd1038d..7bf83036931d 100755
--- a/tests/btrfs/043
+++ b/tests/btrfs/043
@@ -126,9 +126,9 @@ run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $tmp/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $tmp/2.snap
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
 
@@ -136,10 +136,10 @@ _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/044 b/tests/btrfs/044
index 9d6d212db2a9..8668d767ad05 100755
--- a/tests/btrfs/044
+++ b/tests/btrfs/044
@@ -106,9 +106,9 @@ run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $tmp/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $tmp/2.snap
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
 
@@ -116,10 +116,10 @@ _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/045 b/tests/btrfs/045
index bdafbab571c6..9fad27d50526 100755
--- a/tests/btrfs/045
+++ b/tests/btrfs/045
@@ -352,10 +352,10 @@ run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $tmp/1.snap
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $tmp/2.snap
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
 
@@ -363,10 +363,10 @@ _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/046 b/tests/btrfs/046
index 6bf50005b507..284fa955567b 100755
--- a/tests/btrfs/046
+++ b/tests/btrfs/046
@@ -282,17 +282,17 @@ md5sum $SCRATCH_MNT/mysnap0/foo | _filter_scratch
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
 md5sum $SCRATCH_MNT/mysnap2/foo | _filter_scratch
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
 _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File digests in the replica filesystem:"
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index e03b3c57ad19..01613367db0a 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -172,17 +172,17 @@ _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 touch $SCRATCH_MNT/testdir/subdir1/foobar2
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_scratch_fs
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/mysnap2/testdir/subdir1 compression
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/mysnap2/testdir/subdir1/foobar \
 	compression
diff --git a/tests/btrfs/050 b/tests/btrfs/050
index 9a1f5e486f21..62e2cfc4c881 100755
--- a/tests/btrfs/050
+++ b/tests/btrfs/050
@@ -92,7 +92,7 @@ done
 
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
 
 _scratch_unmount
 _check_scratch_fs
@@ -100,7 +100,7 @@ _check_scratch_fs
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
 status=0
diff --git a/tests/btrfs/051 b/tests/btrfs/051
index 9ffbde371392..0a8741203914 100755
--- a/tests/btrfs/051
+++ b/tests/btrfs/051
@@ -68,7 +68,7 @@ echo "hello world" > $TEST_PATH/amaiAdvancedStreamingPlugin.txt
 
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
 
 _scratch_unmount
 _check_scratch_fs
@@ -76,7 +76,7 @@ _check_scratch_fs
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
 status=0
diff --git a/tests/btrfs/053 b/tests/btrfs/053
index 06dcaff0ca3d..1f9bffd26549 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -87,9 +87,9 @@ _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_scratch_fs
@@ -97,10 +97,10 @@ _check_scratch_fs
 _scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/054 b/tests/btrfs/054
index 606fb40e1d92..9e0dd463a47f 100755
--- a/tests/btrfs/054
+++ b/tests/btrfs/054
@@ -85,9 +85,9 @@ mkdir $SCRATCH_MNT/first_subvol
 
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap2 -p $SCRATCH_MNT/mysnap1 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_scratch_fs
@@ -95,11 +95,11 @@ _check_scratch_fs
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 [ -e $SCRATCH_MNT/first_subvol ] && \
 	echo "Subvolume first_subvol was not supposed to be replicated by full send!"
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 [ -e $SCRATCH_MNT/testdir ] && \
 	echo "Directory testdir was supposed to be deleted after incremental send!"
 
diff --git a/tests/btrfs/058 b/tests/btrfs/058
index ecfe85719287..ed39f9433271 100755
--- a/tests/btrfs/058
+++ b/tests/btrfs/058
@@ -77,7 +77,7 @@ sleep 3
 # The send operation used to fail with -ESTALE due to the presence of the
 # orphan inode.
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap -f /dev/null
+_run_btrfs_util_prog send -f /dev/null $SCRATCH_MNT/mysnap
 
 status=0
 exit
diff --git a/tests/btrfs/077 b/tests/btrfs/077
index e56fe5bc3965..8d6541aaab4a 100755
--- a/tests/btrfs/077
+++ b/tests/btrfs/077
@@ -125,9 +125,9 @@ run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
 
@@ -135,10 +135,10 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/083 b/tests/btrfs/083
index 47fc3e72309c..80c8cc39b245 100755
--- a/tests/btrfs/083
+++ b/tests/btrfs/083
@@ -136,9 +136,9 @@ run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -146,10 +146,10 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/084 b/tests/btrfs/084
index 55e989ac8db0..0dc940684e1f 100755
--- a/tests/btrfs/084
+++ b/tests/btrfs/084
@@ -111,9 +111,9 @@ run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -121,9 +121,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/087 b/tests/btrfs/087
index b4a62e5787a3..15b050dbd124 100755
--- a/tests/btrfs/087
+++ b/tests/btrfs/087
@@ -178,9 +178,9 @@ run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -188,9 +188,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/092 b/tests/btrfs/092
index 71fceec507ba..5f9c5d609ea5 100755
--- a/tests/btrfs/092
+++ b/tests/btrfs/092
@@ -165,9 +165,9 @@ run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -175,9 +175,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/094 b/tests/btrfs/094
index 452c00840668..aa1e9ab9a9fc 100755
--- a/tests/btrfs/094
+++ b/tests/btrfs/094
@@ -105,9 +105,9 @@ $CLONER_PROG -s $((44 * $BLOCK_SIZE)) -d $((44 * $BLOCK_SIZE)) -l $BLOCK_SIZE \
 
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 echo "File contents in the original filesystem:"
 echo "mysnap1/foo"
@@ -123,8 +123,8 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File contents in the new filesystem:"
 echo "mysnap1/foo"
diff --git a/tests/btrfs/097 b/tests/btrfs/097
index d83cc4628829..6c6988fbc8f7 100755
--- a/tests/btrfs/097
+++ b/tests/btrfs/097
@@ -96,9 +96,9 @@ $CLONER_PROG -s $(((32 + 12) * $BLOCK_SIZE)) -d $((4 * $BLOCK_SIZE)) \
 
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 echo "File contents in the original filesystem:"
 od -t x1 $SCRATCH_MNT/mysnap2/foo | _filter_od
@@ -109,8 +109,8 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File contents in the new filesystem:"
 od -t x1 $SCRATCH_MNT/mysnap2/foo | _filter_od
diff --git a/tests/btrfs/105 b/tests/btrfs/105
index cdbdb8ffa62f..c6c12a9bceeb 100755
--- a/tests/btrfs/105
+++ b/tests/btrfs/105
@@ -87,9 +87,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0xbb 0 96K" \
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/mysnap2 \
 	$SCRATCH_MNT/mysnap2_ro
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2_ro \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2_ro
 
 echo "File digest in the original filesystem after being replaced:"
 md5sum $SCRATCH_MNT/mysnap2_ro/foo/bar | _filter_scratch
@@ -100,8 +100,8 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File digest in the new filesystem:"
 # Must match the digest from the new file.
diff --git a/tests/btrfs/108 b/tests/btrfs/108
index 9c6d35db1d79..23d2fa6dbc42 100755
--- a/tests/btrfs/108
+++ b/tests/btrfs/108
@@ -77,7 +77,7 @@ echo "File digests in the original filesystem:"
 md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
 md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
 
-_run_btrfs_util_prog send $SCRATCH_MNT/snap -f $send_files_dir/1.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap
 
 # Now recreate the filesystem by receiving the send stream and verify we get
 # the same file contents that the original filesystem had.
@@ -85,7 +85,7 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 
 # We expect the destination filesystem to have exactly the same file data as
 # the original filesystem.
diff --git a/tests/btrfs/109 b/tests/btrfs/109
index 8ee1aa190a1b..c5ab00337e32 100755
--- a/tests/btrfs/109
+++ b/tests/btrfs/109
@@ -87,7 +87,7 @@ echo "File digests in the original filesystem:"
 md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
 md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
 
-_run_btrfs_util_prog send $SCRATCH_MNT/snap -f $send_files_dir/1.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap
 
 # Now recreate the filesystem by receiving the send stream and verify we get
 # the same file contents that the original filesystem had.
@@ -100,7 +100,7 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount "-o compress"
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 
 echo "File digests in the new filesystem:"
 # Must match the digests we got in the original filesystem.
diff --git a/tests/btrfs/110 b/tests/btrfs/110
index 7548af4c4e95..3404887999eb 100755
--- a/tests/btrfs/110
+++ b/tests/btrfs/110
@@ -66,14 +66,14 @@ echo "File digest in the first filesystem, first snapshot:"
 md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
 
 # Save send stream for this snapshot.
-_run_btrfs_util_prog send $SCRATCH_MNT/snap1 -f $send_files_dir/1.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
 
 # Create a new filesystem and receive the snapshot.
 _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 
 echo "File digest in the second filesystem, first snapshot:"
 # Must match the digest we got in the first filesystem.
@@ -92,8 +92,8 @@ _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/snap2_rw \
 echo "File digest in the second filesystem, second snapshot:"
 md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
 
-_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/snap2
 
 # Create a new filesystem and receive both the first snapshot, through the first
 # send stream we created, and the second snapshot through the incremental send
@@ -103,12 +103,12 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 # Receiving the second snapshot used to fail because the send stream used an
 # incorrect value for the clone sources uuid field - it used the uuid of
 # snapshot 1, which is different on each filesystem, instead of the received
 # uuid value, which is preserved across different filesystems.
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File digests in the third filesystem:"
 # Must match the digests we got in the previous filesystems.
diff --git a/tests/btrfs/111 b/tests/btrfs/111
index 56085dc1b9dc..fd13469ecd6e 100755
--- a/tests/btrfs/111
+++ b/tests/btrfs/111
@@ -74,17 +74,17 @@ md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
 
 # Save send streams for the snapshots. For the first one we use a full send
 # operation and the for the second snapshot we use an incremental send.
-_run_btrfs_util_prog send $SCRATCH_MNT/snap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/snap2
 
 # Create a new filesystem and receive the snapshots.
 _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -vv -f $send_files_dir/1.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -vv -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -vv -f $send_files_dir/1.snap $SCRATCH_MNT
+_run_btrfs_util_prog receive -vv -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File digests in the second filesystem:"
 # Must match the digests we got in the first filesystem.
@@ -106,9 +106,9 @@ sync
 # Now create send streams for the snapshots from this new filesystem. For the
 # first snapshot we do a full send while for the second snapshot we do an
 # incremental send.
-_run_btrfs_util_prog send $SCRATCH_MNT/snap1 -f $send_files_dir/1_2.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 \
-	-f $send_files_dir/2_2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1_2.snap $SCRATCH_MNT/snap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2_2.snap \
+	$SCRATCH_MNT/snap2
 
 # Create a new filesystem and receive the send streams we just created from the
 # second filesystem. This worked until the linux kernel 4.2, where a regression
@@ -120,8 +120,8 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -vv -f $send_files_dir/1_2.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -vv -f $send_files_dir/2_2.snap
+_run_btrfs_util_prog receive -vv -f $send_files_dir/1_2.snap $SCRATCH_MNT
+_run_btrfs_util_prog receive -vv -f $send_files_dir/2_2.snap $SCRATCH_MNT
 
 echo "File digests in the third filesystem:"
 # Must match the digests we got in the first and second filesystems.
diff --git a/tests/btrfs/117 b/tests/btrfs/117
index a028da56acff..2e5ecf7ded1b 100755
--- a/tests/btrfs/117
+++ b/tests/btrfs/117
@@ -80,10 +80,10 @@ _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/clones_snap
 
 _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/snap1 -f $tmp/1.snap
-_run_btrfs_util_prog send $SCRATCH_MNT/clones_snap -f $tmp/clones.snap
+_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/snap1
+_run_btrfs_util_prog send -f $tmp/clones.snap $SCRATCH_MNT/clones_snap
 _run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 \
-	-c $SCRATCH_MNT/clones_snap $SCRATCH_MNT/snap2 -f $tmp/2.snap
+	-c $SCRATCH_MNT/clones_snap -f $tmp/2.snap $SCRATCH_MNT/snap2
 
 echo "File digests in the original filesystem:"
 md5sum $SCRATCH_MNT/snap1/a/b/c/x | _filter_scratch
@@ -94,9 +94,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/clones.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_run_btrfs_util_prog receive -f $tmp/clones.snap $SCRATCH_MNT
+_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
 
 echo "File digests in the new filesystem:"
 # Should match the digests we had in the original filesystem.
diff --git a/tests/btrfs/127 b/tests/btrfs/127
index c44e74d61e39..d1e873ac00be 100755
--- a/tests/btrfs/127
+++ b/tests/btrfs/127
@@ -243,9 +243,9 @@ run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -253,9 +253,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/128 b/tests/btrfs/128
index 089205f06e33..b5563a7af8b0 100755
--- a/tests/btrfs/128
+++ b/tests/btrfs/128
@@ -109,9 +109,9 @@ run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -119,9 +119,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/129 b/tests/btrfs/129
index 089d95583c3c..e1fb7b50643f 100755
--- a/tests/btrfs/129
+++ b/tests/btrfs/129
@@ -105,9 +105,9 @@ run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f $send_files_dir/1.snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -115,9 +115,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/133 b/tests/btrfs/133
index 5839f1779426..34b6c13163d6 100755
--- a/tests/btrfs/133
+++ b/tests/btrfs/133
@@ -71,8 +71,8 @@ mkdir $SCRATCH_MNT/a2
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
     $SCRATCH_MNT/mysnap1 > /dev/null
 
-$BTRFS_UTIL_PROG send $SCRATCH_MNT/mysnap1 -f \
-    $send_files_dir/1.snap 2>&1 1>/dev/null | _filter_scratch
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
 
 _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
@@ -98,16 +98,16 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 # which causes a transaction commit and therefore bumps the filesystem's current
 # generation to the value 9. All the inodes created end up getting a generation
 # value of 9 and the snapshot's root inode (256) gets a generation value of 8.
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
 rm $send_files_dir/1.snap
 
 $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 $FSSUM_PROG -A -f -w $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
-$BTRFS_UTIL_PROG send $SCRATCH_MNT/mysnap1 -f \
-    $send_files_dir/1.snap 2>&1 1>/dev/null | _filter_scratch
-$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap 2>&1 1>/dev/null | _filter_scratch
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2 2>&1 1>/dev/null | _filter_scratch
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -118,9 +118,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
 $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/2.snap > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
 $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/134 b/tests/btrfs/134
index 8224e477509b..f65200888c84 100755
--- a/tests/btrfs/134
+++ b/tests/btrfs/134
@@ -105,10 +105,10 @@ $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
         -x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-$BTRFS_UTIL_PROG send $SCRATCH_MNT/mysnap1 -f \
-	$send_files_dir/1.snap 2>&1 1>/dev/null | _filter_scratch
-$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap 2>&1 1>/dev/null | _filter_scratch
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2 2>&1 1>/dev/null | _filter_scratch
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -116,9 +116,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
 $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/2.snap > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
 $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/135 b/tests/btrfs/135
index bdc70b3da7cc..2199d6aefc0c 100755
--- a/tests/btrfs/135
+++ b/tests/btrfs/135
@@ -76,8 +76,8 @@ mv $SCRATCH_MNT/d1 $SCRATCH_MNT/d259_old/d1
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 	$SCRATCH_MNT/mysnap1 > /dev/null
 
-$BTRFS_UTIL_PROG send $SCRATCH_MNT/mysnap1 -f \
-	$send_files_dir/1.snap 2>&1 1>/dev/null | _filter_scratch
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
 
 _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
@@ -109,16 +109,16 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 # which causes a transaction commit and therefore bumps the filesystem's current
 # generation to the value 9. All the inodes created end up getting a generation
 # value of 9 and the snapshot's root inode (256) gets a generation value of 8.
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
 rm $send_files_dir/1.snap
 
 $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 $FSSUM_PROG -A -f -w $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
-$BTRFS_UTIL_PROG send $SCRATCH_MNT/mysnap1 -f \
-	$send_files_dir/1.snap 2>&1 1>/dev/null | _filter_scratch
-$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
-	-f $send_files_dir/2.snap 2>&1 1>/dev/null | _filter_scratch
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2 2>&1 1>/dev/null | _filter_scratch
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same content that the original filesystem had.
@@ -126,7 +126,7 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
 $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 # The receive of the incremental send stream used to fail because it contained
 # a rmdir operation with an invalid path. The output of the receive command,
@@ -152,7 +152,7 @@ $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 # was incorrect because the inodes with number 259 in both snapshots are not the
 # same, they have different generations.
 #
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/2.snap > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
 $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/137 b/tests/btrfs/137
index 3ff2c6b4a04e..eaac5d4960f1 100755
--- a/tests/btrfs/137
+++ b/tests/btrfs/137
@@ -103,10 +103,10 @@ $XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/bar | _filter_fiemap
 echo
 
 # Create the send streams to apply later on a new filesystem.
-$BTRFS_UTIL_PROG send $SCRATCH_MNT/snap1 -f $send_files_dir/1.snap 2>&1 \
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
 	| _filter_scratch
-$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 \
-	-f $send_files_dir/2.snap 2>&1 | _filter_scratch
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/snap2 2>&1 | _filter_scratch
 
 # Create a new filesystem, receive the send streams and verify that the file
 # contents are the same as in the original filesystem and that the file holes
@@ -114,8 +114,8 @@ $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 \
 _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap >/dev/null
-$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/2.snap >/dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT >/dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT >/dev/null
 
 echo
 echo "File digests in the new filesystem:"
-- 
2.12.0

