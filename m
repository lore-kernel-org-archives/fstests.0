Received: from mail.kernel.org ([198.145.29.99]:48070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeJORHT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 15 Oct 2018 13:07:19 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs: fix test btrfs/007 to not leave temporary files in /tmp
Date: Mon, 15 Oct 2018 10:22:46 +0100
Message-Id: <20181015092246.10424-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

This test was using the "mktemp -d" command to create a temporary
directory for storing send streams and computations from fssum, without
ever deleting them when it finishes. Therefore after running it for many
times it filled up all space from /tmp.

Fix this by using a temporary directory in TEST_DEV instead, as all the
more recent send/receive tests do, to store these files, and making sure
they get deleted when the test finishes. On average the sum of the size
of those files is between 5.5Mb to 6Mb, but changing the number of
operations for fsstress makes it even bigger.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/007     | 33 +++++++++++++++++++--------------
 tests/btrfs/007.out |  1 -
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/tests/btrfs/007 b/tests/btrfs/007
index 09f2f011..438f2f27 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -16,14 +16,14 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
-tmp=`mktemp -d`
+tmp=/tmp/$$
 status=1
 
 _cleanup()
 {
-	echo "*** unmount"
-	_scratch_unmount 2>/dev/null
+	cd /
 	rm -f $tmp.*
+	rm -fr $send_files_dir
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -38,7 +38,11 @@ _require_scratch
 _require_fssum
 _require_seek_data_hole
 
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
 rm -f $seqres.full
+rm -fr $send_files_dir
+mkdir $send_files_dir
 
 workout()
 {
@@ -57,19 +61,20 @@ workout()
 
 	_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
 
-	echo "# $BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp/base.snap" \
+	echo "# $BTRFS_UTIL_PROG send $SCRATCH_MNT/base > ${send_files_dir}/base.snap" \
 		>> $seqres.full
-	$BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp/base.snap 2>> $seqres.full \
+	$BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $send_files_dir/base.snap 2>> $seqres.full \
 		|| _fail "failed: '$@'"
 	echo "# $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base\
-		$SCRATCH_MNT/incr > $tmp/incr.snap" >> $seqres.full
+		$SCRATCH_MNT/incr > ${send_files_dir}/incr.snap" >> $seqres.full
 	$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base \
-		$SCRATCH_MNT/incr > $tmp/incr.snap 2>> $seqres.full \
+		$SCRATCH_MNT/incr > $send_files_dir/incr.snap 2>> $seqres.full \
 		|| _fail "failed: '$@'"
 
-	run_check $FSSUM_PROG -A -f -w $tmp/base.fssum $SCRATCH_MNT/base
-	run_check $FSSUM_PROG -A -f -w $tmp/incr.fssum -x $SCRATCH_MNT/incr/base \
-		$SCRATCH_MNT/incr
+	run_check $FSSUM_PROG -A -f -w $send_files_dir/base.fssum \
+		$SCRATCH_MNT/base
+	run_check $FSSUM_PROG -A -f -w $send_files_dir/incr.fssum \
+		-x $SCRATCH_MNT/incr/base $SCRATCH_MNT/incr
 
 	_scratch_unmount >/dev/null 2>&1
 	echo "*** mkfs -dsize=$fsz"    >>$seqres.full
@@ -78,11 +83,11 @@ workout()
 		|| _fail "size=$fsz mkfs failed"
 	_scratch_mount "-o noatime"
 
-	_run_btrfs_util_prog receive $SCRATCH_MNT < $tmp/base.snap
-	run_check $FSSUM_PROG -r $tmp/base.fssum $SCRATCH_MNT/base
+	_run_btrfs_util_prog receive $SCRATCH_MNT < $send_files_dir/base.snap
+	run_check $FSSUM_PROG -r $send_files_dir/base.fssum $SCRATCH_MNT/base
 
-	_run_btrfs_util_prog receive $SCRATCH_MNT < $tmp/incr.snap
-	run_check $FSSUM_PROG -r $tmp/incr.fssum $SCRATCH_MNT/incr
+	_run_btrfs_util_prog receive $SCRATCH_MNT < $send_files_dir/incr.snap
+	run_check $FSSUM_PROG -r $send_files_dir/incr.fssum $SCRATCH_MNT/incr
 }
 
 echo "*** test send / receive"
diff --git a/tests/btrfs/007.out b/tests/btrfs/007.out
index 8f8cec7d..5d029ceb 100644
--- a/tests/btrfs/007.out
+++ b/tests/btrfs/007.out
@@ -1,4 +1,3 @@
 QA output created by 007
 *** test send / receive
 *** done
-*** unmount
-- 
2.11.0
