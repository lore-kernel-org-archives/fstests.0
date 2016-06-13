Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:28905 "EHLO
	mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933130AbcFMC7d (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 12 Jun 2016 22:59:33 -0400
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
	by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 95563AC0132
	for <fstests@vger.kernel.org>; Mon, 13 Jun 2016 11:59:28 +0900 (JST)
Received: from G01JPEXCHKW18.g01.fujitsu.local (G01JPEXCHKW18.g01.fujitsu.local [10.0.194.57])
	by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id D7D8A692590
	for <fstests@vger.kernel.org>; Mon, 13 Jun 2016 11:58:01 +0900 (JST)
Message-ID: <575E2139.4020808@jp.fujitsu.com>
Date: Mon, 13 Jun 2016 11:58:01 +0900
From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] fstests: add require_command check to killall
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Some tests use killall command, but killall may not exist.
We should check whether killall exists or not.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tests/generic/051 |    5 +++--
 tests/generic/270 |    3 ++-
 tests/generic/310 |    5 +++--
 tests/xfs/011     |    5 +++--
 tests/xfs/013     |    5 +++--
 tests/xfs/051     |    5 +++--
 tests/xfs/070     |    3 ++-
 tests/xfs/079     |    3 ++-
 tests/xfs/141     |    3 ++-
 tests/xfs/167     |    2 +-
 tests/xfs/297     |    3 ++-
 tests/xfs/305     |    3 ++-
 12 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/tests/generic/051 b/tests/generic/051
index d620807..b0c3782 100755
--- a/tests/generic/051
+++ b/tests/generic/051
@@ -50,6 +50,7 @@ _supported_os Linux
 
 _require_scratch
 _require_scratch_shutdown
+_require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 
@@ -64,7 +65,7 @@ load_dir=$SCRATCH_MNT/test
 # let this run for a while
 $FSSTRESS_PROG -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
 sleep $SLEEP_TIME
-killall -q $FSSTRESS_PROG
+$KILLALL_PROG -q $FSSTRESS_PROG
 wait
 sync
 _scratch_unmount
@@ -79,7 +80,7 @@ sync
 # now shutdown and unmount
 sleep 5
 $here/src/godown $load_dir
-killall -q $FSSTRESS_PROG
+$KILLALL_PROG -q $FSSTRESS_PROG
 wait
 
 # for some reason fsstress processes manage to live on beyond the wait?
diff --git a/tests/generic/270 b/tests/generic/270
index e6874c9..f5026ba 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -69,7 +69,7 @@ _workout()
 		sleep $enospc_time
 	done
 
-	killall $tmp.fsstress.bin
+	$KILLALL_PROG $tmp.fsstress.bin
 	wait $pid
 }
 
@@ -79,6 +79,7 @@ _supported_os Linux
 _require_quota
 _require_user
 _require_scratch
+_require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
diff --git a/tests/generic/310 b/tests/generic/310
index c0a8645..895481c 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -58,6 +58,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_command "$KILLALL_PROG" killall
 
 dmesg -c > /dev/null
 
@@ -103,7 +104,7 @@ _test_read()
 {
 	src/t_readdir_1 $SEQ_DIR &
 	sleep $RUN_TIME
-	killall t_readdir_1
+	$KILLALL_PROG t_readdir_1
 	check_kernel_bug
 	if [ $? -ne 0 ]; then
 		_fatal "kernel bug detected, check dmesg for more infomation."
@@ -114,7 +115,7 @@ _test_lseek()
 {
 	src/t_readdir_2 $SEQ_DIR &
 	sleep $RUN_TIME
-	killall t_readdir_2
+	$KILLALL_PROG t_readdir_2
 	check_kernel_bug
 	if [ $? -ne 0 ]; then
 		_fatal "kernel bug detected, check dmesg for more infomation."
diff --git a/tests/xfs/011 b/tests/xfs/011
index e84faa5..dde06d7 100755
--- a/tests/xfs/011
+++ b/tests/xfs/011
@@ -37,7 +37,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-	killall -9 fsstress 2>/dev/null
+	$KILLALL_PROG -9 fsstress 2>/dev/null
 	wait
 	cd /
 	_scratch_unmount 2>/dev/null
@@ -86,6 +86,7 @@ _supported_os Linux
 _require_scratch
 _require_freeze
 _require_xfs_sysfs $(_short_dev $TEST_DEV)/log
+_require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 
@@ -106,7 +107,7 @@ while [ $iters -gt 0 ]; do
 	iters=$((iters - 1))
 done
 
-killall $FSSTRESS_PROG
+$KILLALL_PROG $FSSTRESS_PROG
 wait
 
 _scratch_unmount
diff --git a/tests/xfs/013 b/tests/xfs/013
index 3a96fea..817558f 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -40,7 +40,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-	killall -9 fsstress 2>/dev/null
+	$KILLALL_PROG -9 fsstress 2>/dev/null
 	wait
 	cd /
 	_scratch_unmount 2>/dev/null
@@ -101,6 +101,7 @@ _supported_os Linux
 _require_scratch
 _require_xfs_mkfs_finobt
 _require_xfs_finobt
+_require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 
@@ -142,7 +143,7 @@ do
 	_rand_replace $SCRATCH_MNT/dir$((i+1)) $COUNT
 done
 
-killall fsstress
+$KILLALL_PROG fsstress
 wait
 
 # clean out the competing fsstress allocations, then everything else
diff --git a/tests/xfs/051 b/tests/xfs/051
index 3f33635..f38743c 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -36,7 +36,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	killall -9 $FSSTRESS_PROG > /dev/null 2>&1
+	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
 	_scratch_unmount > /dev/null 2>&1
 }
 
@@ -51,6 +51,7 @@ _supported_os Linux
 _require_scratch
 _require_dm_target flakey
 _require_xfs_sysfs debug/log_recovery_delay
+_require_command "$KILLALL_PROG" killall
 
 echo "Silence is golden."
 
@@ -62,7 +63,7 @@ _scratch_mount
 $FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT > /dev/null 2>&1 &
 sleep 5
 src/godown -f $SCRATCH_MNT
-killall -q $FSSTRESS_PROG
+$KILLALL_PROG -q $FSSTRESS_PROG
 wait
 _scratch_unmount
 
diff --git a/tests/xfs/070 b/tests/xfs/070
index 772e2c1..e3a48b3 100755
--- a/tests/xfs/070
+++ b/tests/xfs/070
@@ -46,7 +46,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	killall -9 $XFS_REPAIR_PROG > /dev/null 2>&1
+	$KILLALL_PROG -9 $XFS_REPAIR_PROG > /dev/null 2>&1
 	wait > /dev/null 2>&1
 }
 
@@ -93,6 +93,7 @@ rm -f $seqres.full
 _supported_fs xfs
 _supported_os Linux
 _require_scratch_nocheck
+_require_command "$KILLALL_PROG" killall
 
 _scratch_mkfs | _filter_mkfs > /dev/null 2> $tmp.mkfs || _fail "mkfs failed"
 
diff --git a/tests/xfs/079 b/tests/xfs/079
index 8f06e3a..8ac9d58 100755
--- a/tests/xfs/079
+++ b/tests/xfs/079
@@ -42,7 +42,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	killall -9 fsstress > /dev/null 2>&1
+	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
 	wait > /dev/null 2>&1
 }
 
@@ -59,6 +59,7 @@ _supported_fs xfs
 _supported_os Linux
 _require_scratch
 _require_v2log
+_require_command "$KILLALL_PROG" killall
 
 echo "Silence is golden."
 
diff --git a/tests/xfs/141 b/tests/xfs/141
index a70c986..56ff14e 100755
--- a/tests/xfs/141
+++ b/tests/xfs/141
@@ -39,7 +39,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	killall -9 fsstress > /dev/null 2>&1
+	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
 	wait > /dev/null 2>&1
 }
 
@@ -55,6 +55,7 @@ _supported_fs xfs
 _supported_os Linux
 _require_xfs_sysfs $(_short_dev $TEST_DEV)/log/log_badcrc_factor
 _require_scratch
+_require_command "$KILLALL_PROG" killall
 
 echo "Silence is golden."
 
diff --git a/tests/xfs/167 b/tests/xfs/167
index e6c65d2..a9f0e61 100755
--- a/tests/xfs/167
+++ b/tests/xfs/167
@@ -56,7 +56,7 @@ workout()
 _supported_fs xfs
 _supported_os Linux
 
-[ -n "$KILLALL_PROG" ] || _notrun "killall executable not found"
+_require_command "$KILLALL_PROG" killall
 
 _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1
diff --git a/tests/xfs/297 b/tests/xfs/297
index 25b597e..fe92441 100755
--- a/tests/xfs/297
+++ b/tests/xfs/297
@@ -48,6 +48,7 @@ _supported_os IRIX Linux
 
 _require_scratch
 _require_freeze
+_require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 _scratch_mkfs_xfs -d agcount=16,su=256k,sw=12 -l su=256k,size=5120b >/dev/null 2>&1
@@ -79,7 +80,7 @@ while [ $LOOP -gt 0 ];do
 	let LOOP=$LOOP-1
 done
 echo "Test done" | tee -a $seqres.full
-killall -q $FSSTRESS_PROG
+$KILLALL_PROG -q $FSSTRESS_PROG
 wait
 
 status=0
diff --git a/tests/xfs/305 b/tests/xfs/305
index 15fb1ad..692e990 100755
--- a/tests/xfs/305
+++ b/tests/xfs/305
@@ -50,6 +50,7 @@ _require_scratch
 _require_xfs_quota
 _require_xfs_mkfs_crc
 _require_xfs_crc
+_require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 _scratch_mkfs_xfs -m crc=1 >/dev/null 2>&1
@@ -69,7 +70,7 @@ _exercise()
 	sleep 10
 	xfs_quota -x -c "off -$type" $SCRATCH_DEV
 	sleep 5
-	killall -q $FSSTRESS_PROG
+	$KILLALL_PROG -q $FSSTRESS_PROG
 	wait
 }
 
-- 
1.7.1
