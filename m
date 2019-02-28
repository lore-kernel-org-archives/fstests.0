Received: from mx1.redhat.com ([209.132.183.28]:46236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbfB1Olb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Feb 2019 09:41:31 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH 1/2] common/dmlogwrites: genericize log writes target device
Date: Thu, 28 Feb 2019 09:41:27 -0500
Message-Id: <20190228144128.55583-2-bfoster@redhat.com>
In-Reply-To: <20190228144128.55583-1-bfoster@redhat.com>
References: <20190228144128.55583-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>
List-ID: <fstests@vger.kernel.org>

The dm-log-writes infrastructure is currently implemented to use
SCRATCH_DEV as a hardcoded data device. In preparation to allow use
of specialized devices in certain circumstances, genericize the code
to allow an arbitrary data device. This requires passing the target
device as a parameter to several helper functions from various
tests. No functional changes.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 common/dmlogwrites | 24 ++++++++++++++++++------
 tests/generic/455  |  8 ++++----
 tests/generic/457  |  8 ++++----
 tests/generic/470  |  4 ++--
 tests/generic/482  |  4 ++--
 5 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/common/dmlogwrites b/common/dmlogwrites
index b9cbae7a..ae2cbc6a 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -32,7 +32,7 @@ _require_log_writes_dax()
 	_require_test_program "log-writes/replay-log"
 
 	local ret=0
-	_log_writes_init
+	_log_writes_init $SCRATCH_DEV
 	_log_writes_mkfs > /dev/null 2>&1
 	_log_writes_mount -o dax > /dev/null 2>&1
 	# Check options to be sure. XFS ignores dax option
@@ -47,10 +47,15 @@ _require_log_writes_dax()
 
 _log_writes_init()
 {
-	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
+	blkdev=$1
+
+	[ -z "$blkdev" ] && _fail \
+	"block dev must be specified for _log_writes_init"
+
+	local BLK_DEV_SIZE=`blockdev --getsz $blkdev`
 	LOGWRITES_NAME=logwrites-test
 	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
-	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $SCRATCH_DEV $LOGWRITES_DEV"
+	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $blkdev $LOGWRITES_DEV"
 	_dmsetup_create $LOGWRITES_NAME --table "$LOGWRITES_TABLE" || \
 		_fail "failed to create log-writes device"
 }
@@ -82,17 +87,21 @@ _log_writes_unmount()
 
 # _log_writes_replay_log <mark>
 #
-# This replays the log contained on $LOGWRITES_DEV onto $SCRATCH_DEV upto the
+# This replays the log contained on $LOGWRITES_DEV onto blkdev upto the
 # mark passed in.
 _log_writes_replay_log()
 {
 	_mark=$1
+	_blkdev=$2
+
+	[ -z "$_blkdev" ] && _fail \
+	"block dev must be specified for _log_writes_replay_log"
 
 	$here/src/log-writes/replay-log --log $LOGWRITES_DEV --find \
 		--end-mark $_mark >> $seqres.full 2>&1
 	[ $? -ne 0 ] && _fail "mark '$_mark' does not exist"
 
-	$here/src/log-writes/replay-log --log $LOGWRITES_DEV --replay $SCRATCH_DEV \
+	$here/src/log-writes/replay-log --log $LOGWRITES_DEV --replay $_blkdev \
 		--end-mark $_mark >> $seqres.full 2>&1
 	[ $? -ne 0 ] && _fail "replay failed"
 }
@@ -150,16 +159,19 @@ _log_writes_find_next_fua()
 _log_writes_replay_log_range()
 {
 	local end=$1
+	local blkdev=$2
 
 	[ -z "$end" ] && _fail \
 	"end entry must be specified for _log_writes_replay_log_range"
+	[ -z "$blkdev" ] && _fail \
+	"block dev must be specified for _log_writes_replay_log_range"
 
 	# To ensure we replay the last entry,
 	# we need to manually increase the end entry number to ensure
 	# it's played
 	echo "=== replay to $end ===" >> $seqres.full
 	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
-		--replay $SCRATCH_DEV --limit $(($end + 1)) \
+		--replay $blkdev --limit $(($end + 1)) \
 		>> $seqres.full 2>&1
 	[ $? -ne 0 ] && _fail "replay failed"
 }
diff --git a/tests/generic/455 b/tests/generic/455
index 6a87b99b..05621220 100755
--- a/tests/generic/455
+++ b/tests/generic/455
@@ -42,7 +42,7 @@ check_files()
 		local filename=$(basename $i)
 		local mark="${filename##*.}"
 		echo "checking $filename" >> $seqres.full
-		_log_writes_replay_log $filename
+		_log_writes_replay_log $filename $SCRATCH_DEV
 		_scratch_mount
 		local expected_md5=$(_md5_checksum $i)
 		local md5=$(_md5_checksum $SCRATCH_MNT/$name)
@@ -57,7 +57,7 @@ rm -rf $SANITY_DIR
 mkdir $SANITY_DIR
 
 # Create the log
-_log_writes_init
+_log_writes_init $SCRATCH_DEV
 
 _log_writes_mkfs >> $seqres.full 2>&1
 
@@ -92,7 +92,7 @@ _check_scratch_fs
 
 # check pre umount
 echo "checking pre umount" >> $seqres.full
-_log_writes_replay_log last
+_log_writes_replay_log last $SCRATCH_DEV
 _scratch_mount
 _scratch_unmount
 _check_scratch_fs
@@ -103,7 +103,7 @@ done
 
 # Check the end
 echo "checking post umount" >> $seqres.full
-_log_writes_replay_log end
+_log_writes_replay_log end $SCRATCH_DEV
 _scratch_mount
 for j in `seq 0 $((NUM_FILES-1))`; do
 	md5=$(_md5_checksum $SCRATCH_MNT/testfile$j)
diff --git a/tests/generic/457 b/tests/generic/457
index c4c0ca45..82367304 100755
--- a/tests/generic/457
+++ b/tests/generic/457
@@ -44,7 +44,7 @@ check_files()
 		local filename=$(basename $i)
 		local mark="${filename##*.}"
 		echo "checking $filename" >> $seqres.full
-		_log_writes_replay_log $filename
+		_log_writes_replay_log $filename $SCRATCH_DEV
 		_scratch_mount
 		local expected_md5=$(_md5_checksum $i)
 		local md5=$(_md5_checksum $SCRATCH_MNT/$name)
@@ -59,7 +59,7 @@ rm -rf $SANITY_DIR
 mkdir $SANITY_DIR
 
 # Create the log
-_log_writes_init
+_log_writes_init $SCRATCH_DEV
 
 _log_writes_mkfs >> $seqres.full 2>&1
 
@@ -96,7 +96,7 @@ _check_scratch_fs
 
 # check pre umount
 echo "checking pre umount" >> $seqres.full
-_log_writes_replay_log last
+_log_writes_replay_log last $SCRATCH_DEV
 _scratch_mount
 _scratch_unmount
 _check_scratch_fs
@@ -107,7 +107,7 @@ done
 
 # Check the end
 echo "checking post umount" >> $seqres.full
-_log_writes_replay_log end
+_log_writes_replay_log end $SCRATCH_DEV
 _scratch_mount
 for j in `seq 0 $((NUM_FILES-1))`; do
 	md5=$(_md5_checksum $SCRATCH_MNT/testfile$j)
diff --git a/tests/generic/470 b/tests/generic/470
index a970aa80..93691f4a 100755
--- a/tests/generic/470
+++ b/tests/generic/470
@@ -39,7 +39,7 @@ _require_log_writes_dax
 _require_xfs_io_command "mmap" "-S"
 _require_xfs_io_command "log_writes"
 
-_log_writes_init
+_log_writes_init $SCRATCH_DEV
 _log_writes_mkfs >> $seqres.full 2>&1
 _log_writes_mount -o dax
 
@@ -58,7 +58,7 @@ _check_scratch_fs
 _scratch_mkfs >> $seqres.full 2>&1
 
 # check pre-unmap state
-_log_writes_replay_log preunmap
+_log_writes_replay_log preunmap $SCRATCH_DEV
 _scratch_mount
 
 # We should see $SCRATCH_MNT/test as having 1 MiB in block allocations
diff --git a/tests/generic/482 b/tests/generic/482
index 7595aa59..3c2199d7 100755
--- a/tests/generic/482
+++ b/tests/generic/482
@@ -55,7 +55,7 @@ fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 512 -p $nr_cpus \
 		$FSSTRESS_AVOID)
 
 _test_unmount
-_log_writes_init
+_log_writes_init $SCRATCH_DEV
 _log_writes_mkfs >> $seqres.full 2>&1
 _log_writes_mark mkfs
 
@@ -70,7 +70,7 @@ cur=$(_log_writes_find_next_fua $prev)
 [ -z "$cur" ] && _fail "failed to locate next FUA write"
 
 while [ ! -z "$cur" ]; do
-	_log_writes_replay_log_range $cur >> $seqres.full
+	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
 
 	# Here we need extra mount to replay the log, mainly for journal based
 	# fs, as their fsck will report dirty log as error.
-- 
2.17.2
