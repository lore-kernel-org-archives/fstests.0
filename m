Return-Path: <SRS0=EeAr=YO=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF6CA9EAF
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Oct 2019 13:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7195214B2
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Oct 2019 13:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfJUN3R (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:29:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbfJUN3R (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Oct 2019 09:29:17 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6AE2E7CC86C884A7CD92;
        Mon, 21 Oct 2019 21:29:07 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 21:28:58 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <guaneryu@gmail.com>, <darrick.wong@oracle.com>,
        <ebiggers@google.com>, <yi.zhang@huawei.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH xfstests v3] fstests: Add path $here before src/<file>
Date:   Mon, 21 Oct 2019 21:35:46 +0800
Message-ID: <1571664946-105756-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Calling src/<file> without path '$here' may cause the problem that the
file cannot be found.
For example, Running generic/192 with overlayfs(Let ubifs as base fs)
yields the following output:

  generic/192 - output mismatch
     QA output created by 192
     sleep for 5 seconds
     test
    +./common/rc: line 316: src/t_dir_type: No such file or directory
     delta1 is in range
     delta2 is in range
    ...

When the use case fails, the call stack in generic/192 is:

  local unknowns=$(src/t_dir_type $dir u | wc -l)	common/rc
  _supports_filetype					common/rc
  _overlay_mount					common/overlay
  _overlay_test_mount					common/overlay
  _test_mount						common/rc
  _test_cycle_mount					generic/192

Before _test_cycle_mount() being invoked, generic/192 executed 'cd /'
to change work dir from 'xfstests-dev' to '/', so src/t_dir_type was not
found.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 common/encrypt    |  2 +-
 common/locktest   |  4 ++--
 common/populate   |  2 +-
 common/quota      |  4 ++--
 common/rc         | 28 ++++++++++++++--------------
 common/renameat2  |  6 +++---
 common/repair     |  2 +-
 tests/generic/002 |  8 ++++----
 tests/generic/014 |  2 +-
 tests/generic/035 |  4 ++--
 tests/generic/042 |  2 +-
 tests/generic/068 |  2 +-
 tests/generic/084 |  2 +-
 tests/generic/088 |  2 +-
 tests/generic/093 |  2 +-
 tests/generic/120 | 12 ++++++------
 tests/generic/124 |  4 ++--
 tests/generic/125 |  4 ++--
 tests/generic/129 |  8 ++++----
 tests/generic/223 |  8 ++++----
 tests/generic/252 |  2 +-
 tests/generic/257 |  2 +-
 tests/generic/310 |  5 +++--
 tests/generic/317 |  6 +++---
 tests/generic/331 |  2 +-
 tests/generic/332 |  2 +-
 tests/generic/340 |  6 +++---
 tests/generic/344 | 10 ++++++----
 tests/generic/345 | 10 ++++++----
 tests/generic/346 |  8 +++++---
 tests/generic/354 |  8 ++++----
 tests/generic/379 | 12 ++++++------
 tests/generic/385 |  2 +-
 tests/generic/398 | 26 +++++++++++++-------------
 tests/generic/401 |  2 +-
 tests/generic/413 | 18 +++++++++---------
 tests/generic/417 |  2 +-
 tests/generic/418 |  2 +-
 tests/generic/419 |  2 +-
 tests/generic/426 |  4 ++--
 tests/generic/428 |  2 +-
 tests/generic/437 |  2 +-
 tests/generic/438 |  2 +-
 tests/generic/462 |  2 +-
 tests/generic/486 |  3 ++-
 tests/generic/524 |  2 +-
 tests/shared/032  |  2 +-
 tests/xfs/009     | 22 +++++++++++-----------
 tests/xfs/024     |  4 ++--
 tests/xfs/030     |  8 ++++----
 tests/xfs/032     |  2 +-
 tests/xfs/033     |  6 +++---
 tests/xfs/034     |  2 +-
 tests/xfs/041     |  4 ++--
 tests/xfs/042     |  2 +-
 tests/xfs/048     |  2 +-
 tests/xfs/052     |  6 +++---
 tests/xfs/061     |  2 +-
 tests/xfs/062     |  2 +-
 tests/xfs/066     |  2 +-
 tests/xfs/071     |  2 +-
 tests/xfs/081     |  2 +-
 tests/xfs/111     |  4 ++--
 tests/xfs/114     |  2 +-
 tests/xfs/121     |  2 +-
 tests/xfs/136     |  2 +-
 tests/xfs/181     |  2 +-
 tests/xfs/197     |  4 ++--
 tests/xfs/206     |  2 +-
 tests/xfs/238     |  2 +-
 tests/xfs/240     |  2 +-
 tests/xfs/241     |  2 +-
 tests/xfs/260     | 18 +++++++++---------
 tests/xfs/269     |  2 +-
 tests/xfs/272     |  2 +-
 tests/xfs/274     |  2 +-
 tests/xfs/276     |  2 +-
 tests/xfs/282     |  4 ++--
 tests/xfs/283     |  4 ++--
 tests/xfs/285     |  2 +-
 tests/xfs/286     |  2 +-
 tests/xfs/294     |  2 +-
 tests/xfs/331     |  4 ++--
 tests/xfs/335     |  4 ++--
 tests/xfs/336     |  4 ++--
 tests/xfs/337     |  4 ++--
 tests/xfs/341     |  4 ++--
 tests/xfs/342     |  4 ++--
 tests/xfs/422     |  2 +-
 tests/xfs/423     |  2 +-
 tests/xfs/443     |  4 ++--
 tests/xfs/444     |  2 +-
 tests/xfs/509     |  2 +-
 tests/xfs/510     |  2 +-
 94 files changed, 216 insertions(+), 208 deletions(-)

diff --git a/common/encrypt b/common/encrypt
index 06a56ed..535b035 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -467,7 +467,7 @@ _do_verify_ciphertext_for_encryption_policy()
 	local set_encpolicy_args=$4
 	local keydesc=$5
 	local raw_key_hex=$6
-	local crypt_cmd="src/fscrypt-crypt-util $7"
+	local crypt_cmd="$here/src/fscrypt-crypt-util $7"
 
 	local blocksize=$(_get_block_size $SCRATCH_MNT)
 	local test_contents_files=()
diff --git a/common/locktest b/common/locktest
index 1da5fbb..61e7dd4 100644
--- a/common/locktest
+++ b/common/locktest
@@ -45,7 +45,7 @@ _run_generic() {
 	touch $TESTFILE
 
 	# Start the server
-	src/locktest $mode $TESTFILE 2> $SERVER_LOG 1> $SERVER_PORT &
+	$here/src/locktest $mode $TESTFILE 2> $SERVER_LOG 1> $SERVER_PORT &
 	server_pid=$!
 
 	timeout=30
@@ -71,7 +71,7 @@ _run_generic() {
 
 	# Start the client
 
-	src/locktest $mode -p $PORT -h localhost $TESTFILE 2> $CLIENT_LOG
+	$here/src/locktest $mode -p $PORT -h localhost $TESTFILE 2> $CLIENT_LOG
 	client_result=$?
 	client_pid=$!
 	if [ $client_result -ne 0 ]; then
diff --git a/common/populate b/common/populate
index f2953a6..eeac66d 100644
--- a/common/populate
+++ b/common/populate
@@ -39,7 +39,7 @@ __populate_create_file() {
 __populate_fragment_file() {
 	local fname="$1"
 
-	test -f "${fname}" && ./src/punch-alternating "${fname}"
+	test -f "${fname}" && $here/src/punch-alternating "${fname}"
 }
 
 # Create a large directory
diff --git a/common/quota b/common/quota
index 5e154fa..6d1948b 100644
--- a/common/quota
+++ b/common/quota
@@ -42,7 +42,7 @@ _require_quota()
 #
 _require_xfs_quota()
 {
-    src/feature -q $TEST_DEV
+    $here/src/feature -q $TEST_DEV
     [ $? -ne 0 ] && _notrun "Installed kernel does not support XFS quota"
     if [ "$USE_EXTERNAL" = yes -a ! -z "$TEST_RTDEV" ]; then
 	_notrun "Quotas not supported on realtime test device"
@@ -87,7 +87,7 @@ _require_prjquota()
 	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
 	return
     fi
-    src/feature -P $_dev
+    $here/src/feature -P $_dev
     [ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
     if [ "$USE_EXTERNAL" = yes ]; then
 	if [ -n "$TEST_RTDEV" -o -n "$SCRATCH_RTDEV" ]; then
diff --git a/common/rc b/common/rc
index a29bd78..bbebadd 100644
--- a/common/rc
+++ b/common/rc
@@ -313,7 +313,7 @@ _supports_filetype()
 		local testfile=$dir/$$.ftype
 		touch $testfile
 		# look for DT_UNKNOWN files
-		local unknowns=$(src/t_dir_type $dir u | wc -l)
+		local unknowns=$($here/src/t_dir_type $dir u | wc -l)
 		rm $testfile
 		# 0 unknowns is success
 		return $unknowns
@@ -386,10 +386,10 @@ _scratch_shutdown()
 		if [ -z $OVL_BASE_SCRATCH_DEV ]; then
 			_fail "_scratch_shutdown: call _require_scratch_shutdown first in test"
 		else
-			src/godown $* $OVL_BASE_SCRATCH_MNT
+			$here/src/godown $* $OVL_BASE_SCRATCH_MNT
 		fi
 	else
-		src/godown $* $SCRATCH_MNT
+		$here/src/godown $* $SCRATCH_MNT
 	fi
 }
 
@@ -1295,7 +1295,7 @@ _is_block_dev()
     fi
 
     if [ -b "$dev" ]; then
-        src/lstat64 "$dev" | $AWK_PROG '/Device type:/ { print $9 }'
+        $here/src/lstat64 "$dev" | $AWK_PROG '/Device type:/ { print $9 }'
     fi
 }
 
@@ -1314,7 +1314,7 @@ _is_char_dev()
 	fi
 
 	if [ -c "$dev" ]; then
-		src/lstat64 "$dev" | $AWK_PROG '/Device type:/ { print $9 }'
+		$here/src/lstat64 "$dev" | $AWK_PROG '/Device type:/ { print $9 }'
 	fi
 }
 
@@ -1919,10 +1919,10 @@ _require_aiodio()
 {
     if [ -z "$1" ]
     then
-        AIO_TEST=src/aio-dio-regress/aiodio_sparse2
+        AIO_TEST=$here/src/aio-dio-regress/aiodio_sparse2
         [ -x $AIO_TEST ] || _notrun "aio-dio utilities required"
     else
-        AIO_TEST=src/aio-dio-regress/$1
+        AIO_TEST=$here/src/aio-dio-regress/$1
         [ -x $AIO_TEST ] || _notrun "$AIO_TEST not built"
     fi
     _require_aio
@@ -1934,7 +1934,7 @@ _require_aiodio()
 #
 _require_test_program()
 {
-    local prog=src/$1
+    local prog=$here/src/$1
     [ -x $prog ] || _notrun "$prog not built"
 }
 
@@ -3095,7 +3095,7 @@ _require_exportfs()
 # Does shutdown work on this fs?
 _require_scratch_shutdown()
 {
-	[ -x src/godown ] || _notrun "src/godown executable not found"
+	[ -x $here/src/godown ] || _notrun "src/godown executable not found"
 
 	_scratch_mkfs > /dev/null 2>&1 || _notrun "_scratch_mkfs failed on $SCRATCH_DEV"
 	_scratch_mount
@@ -3108,11 +3108,11 @@ _require_scratch_shutdown()
 			# running shutdown to avoid shutting down base fs accidently.
 			_notrun "This test requires a valid $OVL_BASE_SCRATCH_DEV as ovl base fs"
 		else
-			src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
+			$here/src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
 			|| _notrun "Underlying filesystem does not support shutdown"
 		fi
 	else
-		src/godown -f $SCRATCH_MNT 2>&1 \
+		$here/src/godown -f $SCRATCH_MNT 2>&1 \
 			|| _notrun "$FSTYP does not support shutdown"
 	fi
 
@@ -3347,8 +3347,8 @@ _require_relatime()
 
 _require_userns()
 {
-	[ -x src/nsexec ] || _notrun "src/nsexec executable not found"
-	src/nsexec -U true 2>/dev/null || _notrun "userns not supported by this kernel"
+	[ -x $here/src/nsexec ] || _notrun "src/nsexec executable not found"
+	$here/src/nsexec -U true 2>/dev/null || _notrun "userns not supported by this kernel"
 }
 
 _create_loop_device()
@@ -3426,7 +3426,7 @@ _require_ofd_locks()
 	# EINVAL will be returned.
 	_require_test_program "t_ofd_locks"
 	touch $TEST_DIR/ofd_testfile
-	src/t_ofd_locks -t $TEST_DIR/ofd_testfile > /dev/null 2>&1
+	$here/src/t_ofd_locks -t $TEST_DIR/ofd_testfile > /dev/null 2>&1
 	[ $? -eq 22 ] && _notrun "Require OFD locks support"
 }
 
diff --git a/common/renameat2 b/common/renameat2
index 2538141..4b64eea 100644
--- a/common/renameat2
+++ b/common/renameat2
@@ -67,7 +67,7 @@ _rename_tests_source_dest()
 			echo -n "$options $stype/$dtype -> "
 			_setup_one $source $stype
 			_setup_one $dest $dtype
-			src/renameat2 $source $dest $flags
+			$here/src/renameat2 $source $dest $flags
 			if test $? == 0; then
 				_showtype_one $source
 				echo -n "/"
@@ -107,7 +107,7 @@ _require_renameat2()
 	local rename_dir=$TEST_DIR/$$
 	local cmd=""
 
-	if test ! -x src/renameat2; then
+	if test ! -x $here/src/renameat2; then
 		_notrun "renameat2 binary not found"
 	fi
 
@@ -133,7 +133,7 @@ _require_renameat2()
 		_fail "_require_renameat2: only support noreplace,exchange,whiteout rename flags"
 		;;
 	esac
-	if ! src/renameat2 -t $cmd; then
+	if ! $here/src/renameat2 -t $cmd; then
 		rm -rf $rename_dir
 		_notrun "kernel doesn't support renameat2 syscall"
 	fi
diff --git a/common/repair b/common/repair
index c94939c..5a9097f 100644
--- a/common/repair
+++ b/common/repair
@@ -19,7 +19,7 @@ _zero_position()
 		exit
 	fi
 	length=`expr $length / 512`
-	src/devzero -v $value -b 1 -n $length -o $offset $SCRATCH_DEV \
+	$here/src/devzero -v $value -b 1 -n $length -o $offset $SCRATCH_DEV \
 		| perl -npe 's/\d\.\d\dKb/X.XXKb/g'
 }
 
diff --git a/tests/generic/002 b/tests/generic/002
index 8242ea9..575ac42 100755
--- a/tests/generic/002
+++ b/tests/generic/002
@@ -40,22 +40,22 @@ touch $TEST_DIR/$tmp.1
 for l in 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
 do
     ln $TEST_DIR/$tmp.1 $TEST_DIR/$tmp.$l
-    x=`src/lstat64 $TEST_DIR/$tmp.1 | sed -n -e '/ Links: /s/.*Links: *//p'`
+    x=`$here/src/lstat64 $TEST_DIR/$tmp.1 | sed -n -e '/ Links: /s/.*Links: *//p'`
     if [ "$l" -ne $x ]
     then
 	echo "Arrgh, created link #$l and lstat64 looks like ..."
-	src/lstat64 $TEST_DIR/$tmp.1
+	$here/src/lstat64 $TEST_DIR/$tmp.1
 	status=1
     fi
 done
 
 for l in 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
 do
-    x=`src/lstat64 $TEST_DIR/$tmp.1 | sed -n -e '/ Links: /s/.*Links: *//p'`
+    x=`$here/src/lstat64 $TEST_DIR/$tmp.1 | sed -n -e '/ Links: /s/.*Links: *//p'`
     if [ "$l" -ne $x ]
     then
 	echo "Arrgh, about to remove link #$l and lstat64 looks like ..."
-	src/lstat64 $TEST_DIR/$tmp.1
+	$here/src/lstat64 $TEST_DIR/$tmp.1
 	status=1
     fi
     rm -f $TEST_DIR/$tmp.$l
diff --git a/tests/generic/014 b/tests/generic/014
index 59a6618..2106df1 100755
--- a/tests/generic/014
+++ b/tests/generic/014
@@ -45,7 +45,7 @@ echo "brevity is wit..."
 echo "------"
 echo "test 1"
 echo "------"
-src/truncfile -c 10000 $TEST_DIR/truncfile.$$.0 >$tmp.out 2>&1
+$here/src/truncfile -c 10000 $TEST_DIR/truncfile.$$.0 >$tmp.out 2>&1
 ret=$?
 if [ "$ret" -ne 0 ]; then
 	out=`cat $tmp.out`
diff --git a/tests/generic/035 b/tests/generic/035
index 8da3bc9..07a6664 100755
--- a/tests/generic/035
+++ b/tests/generic/035
@@ -43,7 +43,7 @@ file1=$rename_dir/file1
 file2=$rename_dir/file2
 touch $file1
 touch $file2
-src/t_rename_overwrite $file1 $file2
+$here/src/t_rename_overwrite $file1 $file2
 rm $file2
 
 echo "overwriting directory:"
@@ -51,7 +51,7 @@ dir1=$rename_dir/dir1
 dir2=$rename_dir/dir2
 mkdir $dir1
 mkdir $dir2
-src/t_rename_overwrite $dir1 $dir2
+$here/src/t_rename_overwrite $dir1 $dir2
 rmdir $dir2
 
 rmdir $rename_dir
diff --git a/tests/generic/042 b/tests/generic/042
index 6c62eb6..ff7e874 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -56,7 +56,7 @@ _crashtest()
 	# write, run the test command and shutdown the fs
 	$XFS_IO_PROG -f -c "pwrite -S 1 0 64k" -c "$cmd 60k 4k" $file | \
 		_filter_xfs_io
-	./src/godown -f $mnt
+	$here/src/godown -f $mnt
 
 	$UMOUNT_PROG $mnt
 	_mount $img $mnt
diff --git a/tests/generic/068 b/tests/generic/068
index 17ef9ca..17e6446 100755
--- a/tests/generic/068
+++ b/tests/generic/068
@@ -77,7 +77,7 @@ touch $tmp.running
     procs=2
     while [ -f "$tmp.running" ]
       do
-      src/fstest -m -p $FSTEST_DIR  -n $procs -f 4 > /dev/null 2>&1
+      $here/src/fstest -m -p $FSTEST_DIR  -n $procs -f 4 > /dev/null 2>&1
     done
 
     rm -rf $FSTEST_DIR/*
diff --git a/tests/generic/084 b/tests/generic/084
index 402d8b2..77eaeab 100755
--- a/tests/generic/084
+++ b/tests/generic/084
@@ -54,7 +54,7 @@ _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
 # create, open & unlinked files so unlinked inode list is not empty
-src/multi_open_unlink -f $SCRATCH_MNT/$seq.unlinked -n $nr_cpu &
+$here/src/multi_open_unlink -f $SCRATCH_MNT/$seq.unlinked -n $nr_cpu &
 open_pid=$!
 
 # start link/unlink storm
diff --git a/tests/generic/088 b/tests/generic/088
index 4b4e0c9..73a328c 100755
--- a/tests/generic/088
+++ b/tests/generic/088
@@ -32,7 +32,7 @@ _supported_os Linux
 _require_test
 
 path=$TEST_DIR/t_access
-src/t_access_root $path | tee $seqres.full | _filter
+$here/src/t_access_root $path | tee $seqres.full | _filter
 
 # success, all done
 status=0
diff --git a/tests/generic/093 b/tests/generic/093
index a2467a5..08cf6f7 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -70,7 +70,7 @@ rm -f $file
 touch $file
 chown $qa_user $file
 chmod ugo+w $TEST_DIR
-su $qa_user -c "src/writemod $file" | filefilter
+su $qa_user -c "$here/src/writemod $file" | filefilter
 cat $file
 
 # success, all done
diff --git a/tests/generic/120 b/tests/generic/120
index cef3684..48ca950 100755
--- a/tests/generic/120
+++ b/tests/generic/120
@@ -31,14 +31,14 @@ _scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
 _compare_access_times()
 {
 	original_access_time="`cat $tmp.out | sed -n '5p'|awk '{ print substr($0,0,32)}'`"
-	accessed_time="`src/lstat64 $1 | sed -n '5p'| awk '{ print substr($0,0,32)}'`"
+	accessed_time="`$here/src/lstat64 $1 | sed -n '5p'| awk '{ print substr($0,0,32)}'`"
 	echo "*** compare access times ***"
 	if [ "$original_access_time" != "$accessed_time" ]
 		then
 		echo "*** file access time updated on $2 (unexpected) ***"
 		cat $tmp.out
 		echo "---------------------------------------------------"
-		src/lstat64 $1
+		$here/src/lstat64 $1
 		mount | grep $SCRATCH_MNT
 	fi
 
@@ -53,8 +53,8 @@ fi
 
 #executable file
 echo "*** copying file ***"
-cp src/lstat64 $SCRATCH_MNT
-src/lstat64 $SCRATCH_MNT/lstat64 >$tmp.out
+cp $here/src/lstat64 $SCRATCH_MNT
+$here/src/lstat64 $SCRATCH_MNT/lstat64 >$tmp.out
 sleep 5
 echo "*** executing file ***"
 $SCRATCH_MNT/lstat64 $SCRATCH_MNT/lstat64 >/dev/null
@@ -63,7 +63,7 @@ _compare_access_times $SCRATCH_MNT/lstat64 "executing file"
 #reading file
 echo "*** creating file ***"
 touch $SCRATCH_MNT/testfile
-src/lstat64 $SCRATCH_MNT/testfile >$tmp.out
+$here/src/lstat64 $SCRATCH_MNT/testfile >$tmp.out
 sleep 5
 echo "*** reading file ***"
 cat $SCRATCH_MNT/testfile >/dev/null
@@ -72,7 +72,7 @@ _compare_access_times $SCRATCH_MNT/testfile "reading file"
 #writing file
 echo "*** creating file ***"
 touch $SCRATCH_MNT/testfile2
-src/lstat64 $SCRATCH_MNT/testfile2 >$tmp.out
+$here/src/lstat64 $SCRATCH_MNT/testfile2 >$tmp.out
 sleep 5
 echo "*** writing to file ***"
 echo "asdf" >> $SCRATCH_MNT/testfile2
diff --git a/tests/generic/124 b/tests/generic/124
index 9009703..0af2363 100755
--- a/tests/generic/124
+++ b/tests/generic/124
@@ -43,8 +43,8 @@ for TESTFILE in $TEST_DIR/rw_pattern.tmp $SCRATCH_MNT/rw_pattern.tmp
   count=1
   while (( count < 101 ))
     do
-    src/preallo_rw_pattern_writer $TESTFILE
-    src/preallo_rw_pattern_reader $TESTFILE
+    $here/src/preallo_rw_pattern_writer $TESTFILE
+    $here/src/preallo_rw_pattern_reader $TESTFILE
     if (test $? -ne 0) then
 	echo Read/Write Pattern Test FAILED.
 	_cleanup
diff --git a/tests/generic/125 b/tests/generic/125
index 48811db..9d5693e 100755
--- a/tests/generic/125
+++ b/tests/generic/125
@@ -39,13 +39,13 @@ touch $TESTFILE
 chmod a+rw $TESTDIR
 chmod a+rw $TESTFILE
 
-su $qa_user -c "./src/ftrunc -f $TESTFILE"
+su $qa_user -c "$here/src/ftrunc -f $TESTFILE"
 
 if [ "$?" != "0" ];  then
     echo src/ftrunc returned non 0 status!
 fi
 
-src/trunc -f $TESTFILE
+$here/src/trunc -f $TESTFILE
 if (test $? -eq 0 ) then
     status=0
 fi
diff --git a/tests/generic/129 b/tests/generic/129
index d9b638b..e872c0a 100755
--- a/tests/generic/129
+++ b/tests/generic/129
@@ -37,10 +37,10 @@ _scratch_mount "-o nosuid"
 
 mkdir $SCRATCH_MNT/looptest
 
-src/looptest -i 100000 -r -w -b 8192 -s $SCRATCH_MNT/looptest/looptest1.tst
-src/looptest -i 10000 -t -r -w -s -b 102400 $SCRATCH_MNT/looptest/looptest2.tst
-src/looptest -i 50000 -r -w -b 256 -s $SCRATCH_MNT/looptest/looptest3.tst
-src/looptest -i 2000 -o -r -w -b 8192 -s $SCRATCH_MNT/looptest/looptest4.tst
+$here/src/looptest -i 100000 -r -w -b 8192 -s $SCRATCH_MNT/looptest/looptest1.tst
+$here/src/looptest -i 10000 -t -r -w -s -b 102400 $SCRATCH_MNT/looptest/looptest2.tst
+$here/src/looptest -i 50000 -r -w -b 256 -s $SCRATCH_MNT/looptest/looptest3.tst
+$here/src/looptest -i 2000 -o -r -w -b 8192 -s $SCRATCH_MNT/looptest/looptest4.tst
 
 status=0
 exit
diff --git a/tests/generic/223 b/tests/generic/223
index dfd8c41..6cfd00d 100755
--- a/tests/generic/223
+++ b/tests/generic/223
@@ -56,9 +56,9 @@ for SUNIT_K in 8 16 32 64 128; do
 			$XFS_IO_PROG -f -c "pwrite -b $SIZE 0 $SIZE" \
 				$SCRATCH_MNT/file-$FILE-$SIZE-write \
 					>> $seqres.full 2>&1
-			src/t_stripealign $SCRATCH_MNT/file-$FILE-$SIZE-falloc \
+			$here/src/t_stripealign $SCRATCH_MNT/file-$FILE-$SIZE-falloc \
 				$SUNIT_BLOCKS | _filter_scratch
-			src/t_stripealign $SCRATCH_MNT/file-$FILE-$SIZE-write \
+			$here/src/t_stripealign $SCRATCH_MNT/file-$FILE-$SIZE-write \
 				$SUNIT_BLOCKS | _filter_scratch
 		done
 	done
@@ -66,7 +66,7 @@ for SUNIT_K in 8 16 32 64 128; do
 	echo "=== Testing size 1g falloc on ${SUNIT_K}k stripe ==="
 	$XFS_IO_PROG -f -c "falloc 0 1g" \
 	    $SCRATCH_MNT/file-1g-falloc >> $seqres.full 2>&1
-	src/t_stripealign $SCRATCH_MNT/file-1g-falloc $SUNIT_BLOCKS \
+	$here/src/t_stripealign $SCRATCH_MNT/file-1g-falloc $SUNIT_BLOCKS \
 	    | _filter_scratch
 
 	rm -f $SCRATCH_MNT/file-1g-falloc | _filter_scratch
@@ -74,7 +74,7 @@ for SUNIT_K in 8 16 32 64 128; do
 	echo "=== Testing size 1073745920 falloc on ${SUNIT_K}k stripe ==="
 	$XFS_IO_PROG -f -c "falloc 0 1073745920" \
 		$SCRATCH_MNT/file-1073745920-falloc >> $seqres.full 2>&1
-	src/t_stripealign $SCRATCH_MNT/file-1073745920-falloc \
+	$here/src/t_stripealign $SCRATCH_MNT/file-1073745920-falloc \
 		$SUNIT_BLOCKS | _filter_scratch
 
 	_scratch_unmount
diff --git a/tests/generic/252 b/tests/generic/252
index 2e86c81..a6d8069 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -37,7 +37,7 @@ _require_xfs_io_command "falloc"
 # realtime subvolume, thus the test will fail with rtinherit=1
 _require_no_rtinherit
 _require_aiodio "aiocp"
-AIO_TEST="src/aio-dio-regress/aiocp"
+AIO_TEST="$here/src/aio-dio-regress/aiocp"
 
 rm -f $seqres.full
 
diff --git a/tests/generic/257 b/tests/generic/257
index f0d4291..764d9d6 100755
--- a/tests/generic/257
+++ b/tests/generic/257
@@ -33,7 +33,7 @@ mkdir $TEST_DIR/ttt
 for n in {1..168}; do
     touch $TEST_DIR/ttt/$n;
 done
-src/t_dir_offset2 $TEST_DIR/ttt
+$here/src/t_dir_offset2 $TEST_DIR/ttt
 
 # success, all done
 echo "*** done"
diff --git a/tests/generic/310 b/tests/generic/310
index 2bcf720..1fcd517 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -27,6 +27,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
+here=`pwd`
 status=1	# failure is the default!
 
 _cleanup()
@@ -87,7 +88,7 @@ done
 
 _test_read()
 {
-	src/t_readdir_1 $SEQ_DIR &
+	$here/src/t_readdir_1 $SEQ_DIR &
 	sleep $RUN_TIME
 	$KILLALL_PROG t_readdir_1
 	check_kernel_bug
@@ -98,7 +99,7 @@ _test_read()
 
 _test_lseek()
 {
-	src/t_readdir_2 $SEQ_DIR &
+	$here/src/t_readdir_2 $SEQ_DIR &
 	sleep $RUN_TIME
 	$KILLALL_PROG t_readdir_2
 	check_kernel_bug
diff --git a/tests/generic/317 b/tests/generic/317
index 1aded76..509887d 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -58,10 +58,10 @@ _filter_output()
 _print_numeric_uid()
 {
     echo "From init_user_ns"
-    src/lstat64 $file |head -3 |_filter_output
+    $here/src/lstat64 $file |head -3 |_filter_output
 
     echo "From user_ns"
-    src/nsexec -s -U -M "0 $qa_user_id 1000" -G "0 $qa_user_id 1000" src/lstat64 $file |head -3 |_filter_output
+    $here/src/nsexec -s -U -M "0 $qa_user_id 1000" -G "0 $qa_user_id 1000" $here/src/lstat64 $file |head -3 |_filter_output
 }
 
 _scratch_unmount >/dev/null 2>&1
@@ -72,7 +72,7 @@ _scratch_mount
 chmod 777 $SCRATCH_MNT
 
 # create $file as "root" in userns, which is $qa_user in parent namespace
-src/nsexec -s -U -M "0 $qa_user_id 1000" -G "0 $qa_user_id 1000" touch $file
+$here/src/nsexec -s -U -M "0 $qa_user_id 1000" -G "0 $qa_user_id 1000" touch $file
 
 _print_numeric_uid
 
diff --git a/tests/generic/331 b/tests/generic/331
index 8f5629c..59198c1 100755
--- a/tests/generic/331
+++ b/tests/generic/331
@@ -34,7 +34,7 @@ _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
 _require_aiodio "aiocp"
-AIO_TEST="src/aio-dio-regress/aiocp"
+AIO_TEST="$here/src/aio-dio-regress/aiocp"
 
 rm -f $seqres.full
 
diff --git a/tests/generic/332 b/tests/generic/332
index a01da99..7561c79 100755
--- a/tests/generic/332
+++ b/tests/generic/332
@@ -31,7 +31,7 @@ _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
 _require_aiodio "aiocp"
-AIO_TEST="src/aio-dio-regress/aiocp"
+AIO_TEST="$here/src/aio-dio-regress/aiocp"
 
 rm -f $seqres.full
 
diff --git a/tests/generic/340 b/tests/generic/340
index 628664a..73d8c90 100755
--- a/tests/generic/340
+++ b/tests/generic/340
@@ -33,9 +33,9 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-src/holetest -f $SCRATCH_MNT/testfile 1
-src/holetest -f $SCRATCH_MNT/testfile 16
-src/holetest -f $SCRATCH_MNT/testfile 256
+$here/src/holetest -f $SCRATCH_MNT/testfile 1
+$here/src/holetest -f $SCRATCH_MNT/testfile 16
+$here/src/holetest -f $SCRATCH_MNT/testfile 256
 
 status=0
 exit
diff --git a/tests/generic/344 b/tests/generic/344
index 242996c..937b5d9 100755
--- a/tests/generic/344
+++ b/tests/generic/344
@@ -10,6 +10,8 @@
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
+
+here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -34,10 +36,10 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-src/holetest -f -r $SCRATCH_MNT/testfile 16
-src/holetest -f -r $SCRATCH_MNT/testfile 256
-src/holetest -f -r -w $SCRATCH_MNT/testfile 16
-src/holetest -f -r -w $SCRATCH_MNT/testfile 256
+$here/src/holetest -f -r $SCRATCH_MNT/testfile 16
+$here/src/holetest -f -r $SCRATCH_MNT/testfile 256
+$here/src/holetest -f -r -w $SCRATCH_MNT/testfile 16
+$here/src/holetest -f -r -w $SCRATCH_MNT/testfile 256
 
 status=0
 exit
diff --git a/tests/generic/345 b/tests/generic/345
index 4b1e456..7664033 100755
--- a/tests/generic/345
+++ b/tests/generic/345
@@ -9,6 +9,8 @@
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
+
+here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -33,10 +35,10 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-src/holetest -f -F $SCRATCH_MNT/testfile 16
-src/holetest -f -F $SCRATCH_MNT/testfile 256
-src/holetest -f -F -r $SCRATCH_MNT/testfile 16
-src/holetest -f -F -r $SCRATCH_MNT/testfile 256
+$here/src/holetest -f -F $SCRATCH_MNT/testfile 16
+$here/src/holetest -f -F $SCRATCH_MNT/testfile 256
+$here/src/holetest -f -F -r $SCRATCH_MNT/testfile 16
+$here/src/holetest -f -F -r $SCRATCH_MNT/testfile 256
 
 status=0
 exit
diff --git a/tests/generic/346 b/tests/generic/346
index 83ac7d8..5aeeed2 100755
--- a/tests/generic/346
+++ b/tests/generic/346
@@ -9,6 +9,8 @@
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
+
+here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -33,9 +35,9 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-src/holetest -f -w $SCRATCH_MNT/testfile 1
-src/holetest -f -w $SCRATCH_MNT/testfile 16
-src/holetest -f -w $SCRATCH_MNT/testfile 256
+$here/src/holetest -f -w $SCRATCH_MNT/testfile 1
+$here/src/holetest -f -w $SCRATCH_MNT/testfile 16
+$here/src/holetest -f -w $SCRATCH_MNT/testfile 256
 
 status=0
 exit
diff --git a/tests/generic/354 b/tests/generic/354
index b38845c..8159547 100755
--- a/tests/generic/354
+++ b/tests/generic/354
@@ -34,10 +34,10 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-src/holetest -f -p $SCRATCH_MNT/testfile 16
-src/holetest -f -p $SCRATCH_MNT/testfile 256
-src/holetest -f -p -F $SCRATCH_MNT/testfile 16
-src/holetest -f -p -F $SCRATCH_MNT/testfile 256
+$here/src/holetest -f -p $SCRATCH_MNT/testfile 16
+$here/src/holetest -f -p $SCRATCH_MNT/testfile 256
+$here/src/holetest -f -p -F $SCRATCH_MNT/testfile 16
+$here/src/holetest -f -p -F $SCRATCH_MNT/testfile 256
 
 status=0
 exit
diff --git a/tests/generic/379 b/tests/generic/379
index acba9ed..d47aae9 100755
--- a/tests/generic/379
+++ b/tests/generic/379
@@ -57,7 +57,7 @@ _exercise()
 
 	umask 022
 	touch $SCRATCH_MNT/testfile
-	if src/feature -c $SCRATCH_MNT/testfile; then
+	if $here/src/feature -c $SCRATCH_MNT/testfile; then
 		:
 	else
 		_notrun "Installed fileutils doesn't support 32 bit uids/gids"
@@ -65,20 +65,20 @@ _exercise()
 
 	chown 12345 $SCRATCH_MNT/testfile
 	chgrp 54321 $SCRATCH_MNT/testfile
-	src/lstat64 $SCRATCH_MNT/testfile | _filter_stat
+	$here/src/lstat64 $SCRATCH_MNT/testfile | _filter_stat
 
 	chown 34567 $SCRATCH_MNT/testfile
 	chgrp 76543 $SCRATCH_MNT/testfile
-	src/lstat64 $SCRATCH_MNT/testfile | _filter_stat
+	$here/src/lstat64 $SCRATCH_MNT/testfile | _filter_stat
 
 	chown 56789 $SCRATCH_MNT/testfile
 	chgrp 98765 $SCRATCH_MNT/testfile
-	src/lstat64 $SCRATCH_MNT/testfile | _filter_stat
+	$here/src/lstat64 $SCRATCH_MNT/testfile | _filter_stat
 
 	# finally give back to original owners
 	chown 12345 $SCRATCH_MNT/testfile
 	chgrp 54321 $SCRATCH_MNT/testfile
-	src/lstat64 $SCRATCH_MNT/testfile | _filter_stat
+	$here/src/lstat64 $SCRATCH_MNT/testfile | _filter_stat
 
 	echo
 	_scratch_unmount 2>/dev/null
@@ -88,7 +88,7 @@ _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed!"
 
 _qmount_option "usrquota,grpquota"
 _qmount
-if src/feature -G $SCRATCH_DEV ; then
+if $here/src/feature -G $SCRATCH_DEV ; then
 	:
 else
 	_notrun "No quota support at mount time"
diff --git a/tests/generic/385 b/tests/generic/385
index 937131a..9b56897 100755
--- a/tests/generic/385
+++ b/tests/generic/385
@@ -77,7 +77,7 @@ touch $SCRATCH_MNT/test
 # always trigger the wrong unlock flags bug we had in older kernels.
 #
 for i in `seq 1 2000`; do
-    src/rename test t/test
+    $here/src/rename test t/test
 done
 
 # success, all done
diff --git a/tests/generic/398 b/tests/generic/398
index d224e02..4ebdab2 100755
--- a/tests/generic/398
+++ b/tests/generic/398
@@ -84,7 +84,7 @@ echo -e "\n*** Link encrypted <= encrypted ***"
 ln $edir1/efile1 $edir2/efile1 |& _filter_scratch | filter_eperm_to_exdev
 
 echo -e "\n*** Rename encrypted => encrypted ***"
-src/renameat2 $edir1/efile1 $edir2/efile1 |& filter_eperm_to_exdev
+$here/src/renameat2 $edir1/efile1 $edir2/efile1 |& filter_eperm_to_exdev
 
 
 # Test linking and renaming an unencrypted file into an encrypted directory.
@@ -94,7 +94,7 @@ echo -e "\n\n*** Link unencrypted <= encrypted ***"
 ln $udir/ufile $edir1/ufile |& _filter_scratch | filter_eperm_to_exdev
 
 echo -e "\n*** Rename unencrypted => encrypted ***"
-src/renameat2 $udir/ufile $edir1/ufile |& filter_eperm_to_exdev
+$here/src/renameat2 $udir/ufile $edir1/ufile |& filter_eperm_to_exdev
 
 
 # Test linking and renaming an encrypted file into an unencrypted directory.
@@ -105,8 +105,8 @@ ln -v $edir1/efile1 $udir/efile1 |& _filter_scratch
 rm $udir/efile1 # undo
 
 echo -e "\n*** Rename encrypted => unencrypted ***"
-src/renameat2 $edir1/efile1 $udir/efile1
-src/renameat2 $udir/efile1 $edir1/efile1 # undo
+$here/src/renameat2 $edir1/efile1 $udir/efile1
+$here/src/renameat2 $udir/efile1 $edir1/efile1 # undo
 
 
 # Test renaming a forbidden (unencrypted, or encrypted with a different
@@ -114,13 +114,13 @@ src/renameat2 $udir/efile1 $edir1/efile1 # undo
 # rename) operation.  Should fail with EXDEV.
 
 echo -e "\n\n*** Exchange encrypted <=> encrypted ***"
-src/renameat2 -x $edir1/efile1 $edir2/efile2 |& filter_eperm_to_exdev
+$here/src/renameat2 -x $edir1/efile1 $edir2/efile2 |& filter_eperm_to_exdev
 
 echo -e "\n*** Exchange unencrypted <=> encrypted ***"
-src/renameat2 -x $udir/ufile $edir1/efile1 |& filter_eperm_to_exdev
+$here/src/renameat2 -x $udir/ufile $edir1/efile1 |& filter_eperm_to_exdev
 
 echo -e "\n*** Exchange encrypted <=> unencrypted ***"
-src/renameat2 -x $edir1/efile1 $udir/ufile |& filter_eperm_to_exdev
+$here/src/renameat2 -x $edir1/efile1 $udir/ufile |& filter_eperm_to_exdev
 
 
 # Test a file with a special type, i.e. not regular, directory, or symlink.
@@ -129,11 +129,11 @@ src/renameat2 -x $edir1/efile1 $udir/ufile |& filter_eperm_to_exdev
 
 echo -e "\n\n*** Special file tests ***"
 mkfifo $edir1/fifo
-src/renameat2 $edir1/fifo $edir2/fifo
-src/renameat2 $edir2/fifo $udir/fifo
-src/renameat2 $udir/fifo $edir1/fifo
+$here/src/renameat2 $edir1/fifo $edir2/fifo
+$here/src/renameat2 $edir2/fifo $udir/fifo
+$here/src/renameat2 $udir/fifo $edir1/fifo
 mkfifo $udir/fifo
-src/renameat2 -x $udir/fifo $edir1/fifo
+$here/src/renameat2 -x $udir/fifo $edir1/fifo
 ln -v $edir1/fifo $edir2/fifo | _filter_scratch
 rm $edir1/fifo $edir2/fifo $udir/fifo
 
@@ -148,9 +148,9 @@ efile1=$(find $edir1 -type f)
 efile2=$(find $edir2 -type f)
 
 echo -e "\n\n*** Exchange encrypted <=> encrypted without key ***"
-src/renameat2 -x $efile1 $efile2 |& filter_eperm_to_enokey
+$here/src/renameat2 -x $efile1 $efile2 |& filter_eperm_to_enokey
 echo -e "\n*** Exchange encrypted <=> unencrypted without key ***"
-src/renameat2 -x $efile1 $udir/ufile |& filter_eperm_to_enokey
+$here/src/renameat2 -x $efile1 $udir/ufile |& filter_eperm_to_enokey
 
 # success, all done
 status=0
diff --git a/tests/generic/401 b/tests/generic/401
index 1eb3d4a..9d45fbc 100755
--- a/tests/generic/401
+++ b/tests/generic/401
@@ -60,7 +60,7 @@ mknod $testdir/p p
 # or DT_UNKNOWN on fs without filetype support
 ftype=
 _supports_filetype $SCRATCH_MNT && ftype=1
-src/t_dir_type $testdir | \
+$here/src/t_dir_type $testdir | \
 while read name type; do
 	if [ "$ftype" != 1 -a "$type" = u ]; then
 		if [ "$name" = "." -o "$name" = ".." ]; then
diff --git a/tests/generic/413 b/tests/generic/413
index 1f0dbba..1ce89af 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -51,43 +51,43 @@ t_both_dax()
 {
 	prep_files
 	# with O_DIRECT first
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
+	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
 
 	prep_files
 	# again with buffered IO
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
 		$1 "buffered both dax"
 }
 
 t_nondax_to_dax()
 {
 	prep_files
-	src/t_mmap_dio $TEST_DIR/tf_s \
+	$here/src/t_mmap_dio $TEST_DIR/tf_s \
 		$SCRATCH_MNT/tf_d $1 "dio nondax to dax"
 
 	prep_files
-	src/t_mmap_dio -b $TEST_DIR/tf_s \
+	$here/src/t_mmap_dio -b $TEST_DIR/tf_s \
 		$SCRATCH_MNT/tf_d $1 "buffered nondax to dax"
 }
 
 t_dax_to_nondax()
 {
 	prep_files
-	src/t_mmap_dio $SCRATCH_MNT/tf_s \
+	$here/src/t_mmap_dio $SCRATCH_MNT/tf_s \
 		$TEST_DIR/tf_d $1 "dio dax to nondax"
 
 	prep_files
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_s \
+	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_s \
 		$TEST_DIR/tf_d $1 "buffered dax to nondax"
 }
 
 t_both_nondax()
 {
 	prep_files
-	src/t_mmap_dio $TEST_DIR/tf_{s,d} $1 "dio both nondax"
+	$here/src/t_mmap_dio $TEST_DIR/tf_{s,d} $1 "dio both nondax"
 
 	prep_files
-	src/t_mmap_dio -b $TEST_DIR/tf_{s,d} \
+	$here/src/t_mmap_dio -b $TEST_DIR/tf_{s,d} \
 		$1 "buffered both nondax"
 }
 
@@ -105,7 +105,7 @@ do_tests()
 	# less than page size
 	t_mmap_dio_dax 1024
 	# page size
-	t_mmap_dio_dax `src/feature -s`
+	t_mmap_dio_dax `$here/src/feature -s`
 	# bigger sizes, for PMD faults
 	t_mmap_dio_dax $((16 * 1024 * 1024))
 	t_mmap_dio_dax $((64 * 1024 * 1024))
diff --git a/tests/generic/417 b/tests/generic/417
index b07c861..2421005 100755
--- a/tests/generic/417
+++ b/tests/generic/417
@@ -52,7 +52,7 @@ function create_dirty_orphans() {
 	delay=100
 
 	echo "open and unlink $num_files files with EAs"
-	src/multi_open_unlink -f $SCRATCH_MNT/test_file \
+	$here/src/multi_open_unlink -f $SCRATCH_MNT/test_file \
 		-n $num_files -s $delay -e $num_eas -v $ea_val_size &
 	pid=$!
 
diff --git a/tests/generic/418 b/tests/generic/418
index 6fdae08..3aa765f 100755
--- a/tests/generic/418
+++ b/tests/generic/418
@@ -48,7 +48,7 @@ _require_test_program "feature"
 diotest=$here/src/dio-invalidate-cache
 testfile=$TEST_DIR/$seq-diotest
 sectorsize=`blockdev --getss $TEST_DEV`
-pagesize=`src/feature -s`
+pagesize=`$here/src/feature -s`
 
 # test case array, test different write/read combinations
 # -r: use direct read
diff --git a/tests/generic/419 b/tests/generic/419
index 0abbac9..dffeab3 100755
--- a/tests/generic/419
+++ b/tests/generic/419
@@ -59,7 +59,7 @@ _scratch_cycle_mount
 efile1=$(find $SCRATCH_MNT/edir -maxdepth 1 -type f | head -1)
 efile2=$(find $SCRATCH_MNT/edir -maxdepth 1 -type f | tail -1)
 mv $efile1 $efile2 |& _filter_scratch | sed 's|edir/[a-zA-Z0-9+,_]\+|edir/FILENAME|g'
-src/renameat2 -x $efile1 $efile2
+$here/src/renameat2 -x $efile1 $efile2
 
 # success, all done
 status=0
diff --git a/tests/generic/426 b/tests/generic/426
index 7d47b29..c2ec1e4 100755
--- a/tests/generic/426
+++ b/tests/generic/426
@@ -48,7 +48,7 @@ create_test_files()
 
 	mkdir -p $dir
 	rm -f $dir/*
-	src/open_by_handle -c $dir $NUMFILES
+	$here/src/open_by_handle -c $dir $NUMFILES
 }
 
 # Test encode/decode file handles
@@ -58,7 +58,7 @@ test_file_handles()
 	local opt=$2
 
 	echo test_file_handles $* | _filter_test_dir
-	src/open_by_handle $opt $dir $NUMFILES
+	$here/src/open_by_handle $opt $dir $NUMFILES
 }
 
 # Check stale handles to deleted files
diff --git a/tests/generic/428 b/tests/generic/428
index 06c996a..ff5ca51 100755
--- a/tests/generic/428
+++ b/tests/generic/428
@@ -37,7 +37,7 @@ _require_test
 _require_test_program "t_mmap_stale_pmd"
 
 # real QA test starts here
-src/t_mmap_stale_pmd $TEST_DIR/testfile
+$here/src/t_mmap_stale_pmd $TEST_DIR/testfile
 
 # success, all done
 echo "Silence is golden"
diff --git a/tests/generic/437 b/tests/generic/437
index 0df382b..0ac9335 100755
--- a/tests/generic/437
+++ b/tests/generic/437
@@ -38,7 +38,7 @@ _require_test
 _require_test_program "t_mmap_cow_race"
 
 # real QA test starts here
-src/t_mmap_cow_race $TEST_DIR/testfile
+$here/src/t_mmap_cow_race $TEST_DIR/testfile
 
 # success, all done
 echo "Silence is golden"
diff --git a/tests/generic/438 b/tests/generic/438
index d183210..6ef6f63 100755
--- a/tests/generic/438
+++ b/tests/generic/438
@@ -57,7 +57,7 @@ echo >$FILE
 SYNCPID=$!
 
 # Run the test
-src/t_mmap_fallocate $FILE 256 && echo "Silence is golden"
+$here/src/t_mmap_fallocate $FILE 256 && echo "Silence is golden"
 
 kill -TERM $SYNCPID
 wait $SYNCPID
diff --git a/tests/generic/462 b/tests/generic/462
index c117f1b..da39f15 100755
--- a/tests/generic/462
+++ b/tests/generic/462
@@ -67,7 +67,7 @@ chown $qa_user $TEST_DIR/${seq}.file
 
 # run test programme, read another file writing into
 # the read-only file with mmap, which should fail.
-_user_do "src/t_mmap_write_ro $TEST_DIR/${seq}.file \
+_user_do "$here/src/t_mmap_write_ro $TEST_DIR/${seq}.file \
 	$SCRATCH_MNT/readonlyfile"
 
 # read-only file should not get updated, md5sum again.
diff --git a/tests/generic/486 b/tests/generic/486
index ea571ef..74fab76 100755
--- a/tests/generic/486
+++ b/tests/generic/486
@@ -17,6 +17,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
+here=`pwd`
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -50,7 +51,7 @@ filter_attr_output() {
 		sed -e 's/has a [0-9]* byte value/has a NNNN byte value/g'
 }
 
-./src/attr_replace_test $SCRATCH_MNT/hello
+$here/src/attr_replace_test $SCRATCH_MNT/hello
 $ATTR_PROG -l $SCRATCH_MNT/hello >>$seqres.full 2>&1
 $ATTR_PROG -l $SCRATCH_MNT/hello | filter_attr_output
 
diff --git a/tests/generic/524 b/tests/generic/524
index bd86ec0..2cd11b3 100755
--- a/tests/generic/524
+++ b/tests/generic/524
@@ -48,7 +48,7 @@ _scratch_mount
 
 file=$SCRATCH_MNT/file
 filesize=$((1024 * 1024 * 32))
-pagesize=`src/feature -s`
+pagesize=`$here/src/feature -s`
 truncsize=$((filesize - pagesize))
 
 for i in $(seq 0 15); do
diff --git a/tests/shared/032 b/tests/shared/032
index 3b0263b..493845f 100755
--- a/tests/shared/032
+++ b/tests/shared/032
@@ -57,7 +57,7 @@ do
 	[ $fs = ext4dev ] && preargs="-F"
 
 	# overwite the first few Kb - should blow away superblocks
-	src/devzero -n 20 $SCRATCH_DEV >/dev/null
+	$here/src/devzero -n 20 $SCRATCH_DEV >/dev/null
 
 	# create a filesystem of this type
 	echo "=== Creating $fs filesystem..." >>$seqres.full
diff --git a/tests/xfs/009 b/tests/xfs/009
index 9385d3b..6a31514 100755
--- a/tests/xfs/009
+++ b/tests/xfs/009
@@ -140,20 +140,20 @@ bsize=$(_get_file_block_size $SCRATCH_MNT)
 
 echo "*** test 1 - reservations cleared on O_TRUNC"
 rm -f $out
-cat <<EOF | src/alloc -n -b $bsize -f $out | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out | _block_filter
 r 0 1000b
 m
 EOF
 _filesize $out
 
-cat <<EOF | src/alloc -n -b $bsize -f $out -t | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out -t | _block_filter
 m
 EOF
 _filesize $out
 
 echo "*** test 2 - reserve & filesize"
 rm -f $out
-cat <<EOF | src/alloc -n -b $bsize -f $out | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out | _block_filter
 r 0 1000b
 EOF
 
@@ -161,7 +161,7 @@ _filesize $out
 
 echo "*** test 3 - alloc & filesize"
 rm -f $out
-cat <<EOF | src/alloc -n -b $bsize -f $out | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out | _block_filter
 a 1000b
 EOF
 
@@ -169,19 +169,19 @@ _filesize $out
 
 echo "*** test 4 - allocations cleared on O_TRUNC"
 rm -f $out
-cat <<EOF | src/alloc -n -b $bsize -f $out | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out | _block_filter
 a 1000b
 EOF
 _filesize $out
 
-cat <<EOF | src/alloc -n -b $bsize -f $out -t | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out -t | _block_filter
 m
 EOF
 _filesize $out
 
 echo "*** test 5 - reserve / unreserve"
 rm -f $out
-cat <<EOF | src/alloc -n -b $bsize -f $out | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out | _block_filter
 r 0 100b
 u 100b 500b
 m
@@ -191,7 +191,7 @@ EOF
 
 echo "*** test 6 - reserve adjacent"
 rm -f $out
-cat <<EOF | src/alloc -t -n -b $bsize -f $out | _block_filter
+cat <<EOF | $here/src/alloc -t -n -b $bsize -f $out | _block_filter
 r 0 100b
 r 100b 100b
 m
@@ -199,7 +199,7 @@ EOF
 
 echo "*** test 7 - alloc"
 rm -f $out
-cat <<EOF | src/alloc -n -b $bsize -f $out | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out | _block_filter
 a 1000b
 m
 a 2000b
@@ -210,7 +210,7 @@ _filesize $out
 
 echo "*** test 8 - alloc & truncate"
 rm -f $out
-cat <<EOF | src/alloc -n -b $bsize -f $out | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out | _block_filter
 a 1000b
 m
 t 500b
@@ -221,7 +221,7 @@ _filesize $out
 
 echo "*** test 9 - reserve & truncate"
 rm -f $out
-cat <<EOF | src/alloc -n -b $bsize -f $out | _block_filter
+cat <<EOF | $here/src/alloc -n -b $bsize -f $out | _block_filter
 r 0 1000b
 m
 t 500b
diff --git a/tests/xfs/024 b/tests/xfs/024
index b4ecd79..d114214 100755
--- a/tests/xfs/024
+++ b/tests/xfs/024
@@ -34,11 +34,11 @@ _require_tape $TAPE_DEV
 _create_dumpdir_fill
 # ensure file/dir timestamps precede dump timestamp
 sleep 2
-src/bstat $SCRATCH_MNT >>$seqres.full
+$here/src/bstat $SCRATCH_MNT >>$seqres.full
 _erase_hard
 _do_dump
 _append_dumpdir_fill
-src/bstat $SCRATCH_MNT >>$seqres.full
+$here/src/bstat $SCRATCH_MNT >>$seqres.full
 _erase_hard
 _do_dump -l 1
 _do_restore
diff --git a/tests/xfs/030 b/tests/xfs/030
index 10854c8..efdb6a1 100755
--- a/tests/xfs/030
+++ b/tests/xfs/030
@@ -68,11 +68,11 @@ then
 else
 	_qmount_option noquota
 	_scratch_mount
-	src/feature -U $SCRATCH_DEV && \
+	$here/src/feature -U $SCRATCH_DEV && \
 		_notrun "UQuota are enabled, test needs controlled sb recovery"
-	src/feature -G $SCRATCH_DEV && \
+	$here/src/feature -G $SCRATCH_DEV && \
 		_notrun "GQuota are enabled, test needs controlled sb recovery"
-	src/feature -P $SCRATCH_DEV && \
+	$here/src/feature -P $SCRATCH_DEV && \
 		_notrun "PQuota are enabled, test needs controlled sb recovery"
 	_scratch_unmount
 fi
@@ -82,7 +82,7 @@ eval `xfs_db -r -c "sb 1" -c stack $SCRATCH_DEV | perl -ne '
 		print "clear=", $1 / 512, "\n"; exit
 	}'`
 [ -z "$clear" ] && echo "Cannot calculate length to clear"
-src/devzero -v -1 -n "$clear" $SCRATCH_DEV >/dev/null
+$here/src/devzero -v -1 -n "$clear" $SCRATCH_DEV >/dev/null
 
 # now kick off the real repair test...
 #
diff --git a/tests/xfs/032 b/tests/xfs/032
index 597fd0e..af18f75 100755
--- a/tests/xfs/032
+++ b/tests/xfs/032
@@ -32,7 +32,7 @@ _require_test_program "feature"
 rm -f $seqres.full
 
 SECTORSIZE=`blockdev --getss $SCRATCH_DEV`
-PAGESIZE=`src/feature -s`
+PAGESIZE=`$here/src/feature -s`
 IMGFILE=$TEST_DIR/${seq}_copy.img
 
 echo "Silence is golden."
diff --git a/tests/xfs/033 b/tests/xfs/033
index 0ce67a9..9842814 100755
--- a/tests/xfs/033
+++ b/tests/xfs/033
@@ -83,11 +83,11 @@ _link_out_file_named $seqfull.out "$FEATURES"
 # check we won't get any quota inodes setup on mount
 _qmount_option noquota
 _scratch_mount
-src/feature -U $SCRATCH_DEV && \
+$here/src/feature -U $SCRATCH_DEV && \
 	_notrun "UQuota are enabled, test needs controlled sb recovery"
-src/feature -G $SCRATCH_DEV && \
+$here/src/feature -G $SCRATCH_DEV && \
 	_notrun "GQuota are enabled, test needs controlled sb recovery"
-src/feature -P $SCRATCH_DEV && \
+$here/src/feature -P $SCRATCH_DEV && \
 	_notrun "PQuota are enabled, test needs controlled sb recovery"
 _scratch_unmount
 
diff --git a/tests/xfs/034 b/tests/xfs/034
index a831a96..92208b9 100755
--- a/tests/xfs/034
+++ b/tests/xfs/034
@@ -53,7 +53,7 @@ then
     exit
 fi
 
-if ! src/xfsctl $SCRATCH_MNT $SCRATCH_MNT/fish >>$seqres.full 2>&1
+if ! $here/src/xfsctl $SCRATCH_MNT $SCRATCH_MNT/fish >>$seqres.full 2>&1
 then
     echo "!!! failed to run xfsctl test program"
     exit
diff --git a/tests/xfs/041 b/tests/xfs/041
index 1c45b8c..b2ef47c 100755
--- a/tests/xfs/041
+++ b/tests/xfs/041
@@ -41,7 +41,7 @@ _fill()
 {
     if [ $# -ne 1 ]; then echo "Usage: _fill \"path\"" 1>&2 ; exit 1; fi
     _do "Fill filesystem" \
-	"src/fill2fs --verbose --dir=$1 --seed=0 --filesize=65536 --stddev=32768 --list=- >>$tmp.manifest"
+	"$here/src/fill2fs --verbose --dir=$1 --seed=0 --filesize=65536 --stddev=32768 --list=- >>$tmp.manifest"
 }
 
 _do_die_on_error=message_only
@@ -69,7 +69,7 @@ do
     _do "_try_scratch_mount"
     echo "done"
     echo -n "Check files... "
-    if ! _do "src/fill2fs_check $tmp.manifest"; then
+    if ! _do "$here/src/fill2fs_check $tmp.manifest"; then
       echo "fail (see $seqres.full)"
       _do "cat $tmp.manifest"
       _do "ls -altrR $SCRATCH_MNT"
diff --git a/tests/xfs/042 b/tests/xfs/042
index 43276f7..f3248e2 100755
--- a/tests/xfs/042
+++ b/tests/xfs/042
@@ -101,7 +101,7 @@ _do "sum $SCRATCH_MNT/fill >$tmp.fillsum1"
 echo "done"
 
 echo -n "Create one very large file... "
-_do "src/fill2 -d nbytes=16000000,file=$SCRATCH_MNT/fragmented"
+_do "$here/src/fill2 -d nbytes=16000000,file=$SCRATCH_MNT/fragmented"
 echo "done"
 _do "xfs_bmap -v $SCRATCH_MNT/fragmented"
 _do "sum $SCRATCH_MNT/fragmented >$tmp.sum1"
diff --git a/tests/xfs/048 b/tests/xfs/048
index 424e15c..22cfc84 100755
--- a/tests/xfs/048
+++ b/tests/xfs/048
@@ -30,7 +30,7 @@ _supported_fs xfs
 _supported_os Linux
 _require_test
 
-src/fault $TEST_DIR || exit
+$here/src/fault $TEST_DIR || exit
 
 # success, all done
 status=0
diff --git a/tests/xfs/052 b/tests/xfs/052
index fed5723..6aec223 100755
--- a/tests/xfs/052
+++ b/tests/xfs/052
@@ -53,11 +53,11 @@ chmod a+w $seqres.full     # arbitrary users will write here
 _qmount
 
 # setup user/group to test
-if src/feature -U $SCRATCH_DEV ; then
+if $here/src/feature -U $SCRATCH_DEV ; then
 	type=u; eval `_choose_uid`
-elif src/feature -G $SCRATCH_DEV ; then
+elif $here/src/feature -G $SCRATCH_DEV ; then
 	type=g; eval `_choose_gid`
-elif src/feature -P $SCRATCH_DEV ; then
+elif $here/src/feature -P $SCRATCH_DEV ; then
 	type=p; eval `_choose_prid`
 else
 	_notrun "No quota support at mount time"
diff --git a/tests/xfs/061 b/tests/xfs/061
index f8a639f..c457806 100755
--- a/tests/xfs/061
+++ b/tests/xfs/061
@@ -37,7 +37,7 @@ _create_dumpdir_fill_perm
 # override dump_file to checked-in dumpfile
 # we have no quotas to restore
 # if we happen to run this on crackle then put the hostname back
-_do_restore_file --no-check-quota -f src/dumpfile -L stress_056 |
+_do_restore_file --no-check-quota -f $here/src/dumpfile -L stress_056 |
 sed -e 's/HOSTNAME/crackle/g' -e 's#SCRATCH_DEV#/dev/dsk/dks0d2s1#'
 _diff_compare_sub
 _ls_nodate_compare_sub
diff --git a/tests/xfs/062 b/tests/xfs/062
index 755c524..cbce661 100755
--- a/tests/xfs/062
+++ b/tests/xfs/062
@@ -27,7 +27,7 @@ _cleanup()
 _bstat_count()
 {
 	batchsize=$1
-	./src/bstat $SCRATCH_MNT $batchsize | grep ino | wc -l
+	$here/src/bstat $SCRATCH_MNT $batchsize | grep ino | wc -l
 }
 
 # print bulkstat counts using varied batch sizes
diff --git a/tests/xfs/066 b/tests/xfs/066
index 90e1251..c86fc23 100755
--- a/tests/xfs/066
+++ b/tests/xfs/066
@@ -38,7 +38,7 @@ _my_stat_filter()
 }
 
 rm -f $TEST_DIR/testfile
-if src/feature -t $TEST_DIR/testfile; then
+if $here/src/feature -t $TEST_DIR/testfile; then
 	:
 else
 	_notrun "Installed libc doesn't correctly handle setrlimit/ftruncate64"
diff --git a/tests/xfs/071 b/tests/xfs/071
index d0e598c..f962f6b 100755
--- a/tests/xfs/071
+++ b/tests/xfs/071
@@ -27,7 +27,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common/rc
 . ./common/filter
 
-bitsperlong=`src/feature -w`
+bitsperlong=`$here/src/feature -w`
 # link correct .out file
 rm -f $seqfull.out
 if [ "$bitsperlong" -eq 32 ]; then
diff --git a/tests/xfs/081 b/tests/xfs/081
index 39f4c3c..b377da7 100755
--- a/tests/xfs/081
+++ b/tests/xfs/081
@@ -49,7 +49,7 @@ export MOUNT_OPTIONS="-o quota,gquota"
 # mount with quotas?
 _scratch_mkfs_xfs "-l version=1" 1>/dev/null 2>&1
 _qmount
-src/feature -u $SCRATCH_DEV || _notrun "No quota support at mount time"
+$here/src/feature -u $SCRATCH_DEV || _notrun "No quota support at mount time"
 _scratch_unmount
 
 _mkfs_log "-l version=1"
diff --git a/tests/xfs/111 b/tests/xfs/111
index 965eb62..0db33cb 100755
--- a/tests/xfs/111
+++ b/tests/xfs/111
@@ -52,12 +52,12 @@ BYTE=`_scratch_xfs_db -c "convert inode $INO byte" \
 	| awk '{print $2}' | sed s/[\(\)]//g`
 
 echo Blat inode clusters
-src/itrash $SCRATCH_DEV $BYTE
+$here/src/itrash $SCRATCH_DEV $BYTE
 
 _try_scratch_mount || _fail "Couldn't mount after itrash"
 
 echo Attempting bulkstat
-#src/bstat -q $SCRATCH_MNT
+#$here/src/bstat -q $SCRATCH_MNT
 $XFS_FSR_PROG -g $SCRATCH_MNT | _filter_scratch
 
 # Fix up intentional corruption so test can pass
diff --git a/tests/xfs/114 b/tests/xfs/114
index 613699e..e994f57 100755
--- a/tests/xfs/114
+++ b/tests/xfs/114
@@ -58,7 +58,7 @@ $XFS_IO_PROG -f \
 	-c "pwrite -S 0x68 -b 1048576 0 $len2" \
 	$SCRATCH_MNT/f2 >> $seqres.full
 
-./src/punch-alternating -o $((16 * blksz / file_blksz)) \
+$here/src/punch-alternating -o $((16 * blksz / file_blksz)) \
 	-s $((blksz / file_blksz)) \
 	-i $((blksz * 2 / file_blksz)) \
 	$SCRATCH_MNT/f1 >> "$seqres.full"
diff --git a/tests/xfs/121 b/tests/xfs/121
index 2e3914b..b907db4 100755
--- a/tests/xfs/121
+++ b/tests/xfs/121
@@ -46,7 +46,7 @@ _scratch_mount
 num_files=200
 delay=5
 echo "open and unlink $num_files files"
-src/multi_open_unlink -f $SCRATCH_MNT/test_file -n $num_files -s $delay &
+$here/src/multi_open_unlink -f $SCRATCH_MNT/test_file -n $num_files -s $delay &
 
 # time to create and unlink all the files
 sleep 3
diff --git a/tests/xfs/136 b/tests/xfs/136
index b2e70dd..c29a1ba 100755
--- a/tests/xfs/136
+++ b/tests/xfs/136
@@ -81,7 +81,7 @@ do_extents()
 {
     num=$1
     echo ""; echo "** $num extents **"
-    src/makeextents -v -p -w -n $num $file
+    $here/src/makeextents -v -p -w -n $num $file
 }
 
 _print_inode()
diff --git a/tests/xfs/181 b/tests/xfs/181
index dba69a7..cdd6ca1 100755
--- a/tests/xfs/181
+++ b/tests/xfs/181
@@ -58,7 +58,7 @@ ea_val_size=`expr 32 \* 1024`
 delay=100
 
 echo "open and unlink $num_files files with EAs"
-src/multi_open_unlink -f $SCRATCH_MNT/test_file -n $num_files -s $delay -e $num_eas -v $ea_val_size &
+$here/src/multi_open_unlink -f $SCRATCH_MNT/test_file -n $num_files -s $delay -e $num_eas -v $ea_val_size &
 pid=$!
 
 # time to create and unlink all the files
diff --git a/tests/xfs/197 b/tests/xfs/197
index 76f6f0d..55a321a 100755
--- a/tests/xfs/197
+++ b/tests/xfs/197
@@ -35,7 +35,7 @@ _supported_fs xfs
 _supported_os Linux
 _require_test
 
-bitsperlong=`src/feature -w`
+bitsperlong=`$here/src/feature -w`
 if [ "$bitsperlong" -ne 32 ]; then
 	_notrun "This test is only valid on 32 bit machines"
 fi
@@ -44,7 +44,7 @@ mkdir $TEST_DIR/ttt
 for n in {1..168}; do
     touch $TEST_DIR/ttt/$n;
 done
-src/t_dir_offset $TEST_DIR/ttt
+$here/src/t_dir_offset $TEST_DIR/ttt
 
 # success, all done
 echo "*** done"
diff --git a/tests/xfs/206 b/tests/xfs/206
index 7f4e725..159e68d 100755
--- a/tests/xfs/206
+++ b/tests/xfs/206
@@ -41,7 +41,7 @@ _supported_os Linux
 _require_test
 _require_loop
 
-bitsperlong=`src/feature -w`
+bitsperlong=`$here/src/feature -w`
 if [ "$bitsperlong" -ne 64 ]; then
 	_notrun "This test is only valid on 64 bit machines"
 fi
diff --git a/tests/xfs/238 b/tests/xfs/238
index c606518..edd1a5e 100755
--- a/tests/xfs/238
+++ b/tests/xfs/238
@@ -36,6 +36,6 @@ echo "Silence is golden"
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount > /dev/null 2>&1
-src/stale_handle $SCRATCH_MNT
+$here/src/stale_handle $SCRATCH_MNT
 status=$?
 exit
diff --git a/tests/xfs/240 b/tests/xfs/240
index 0560651..eee76ec 100755
--- a/tests/xfs/240
+++ b/tests/xfs/240
@@ -36,7 +36,7 @@ _require_cp_reflink
 _require_dm_target error
 _require_xfs_io_command "cowextsize"
 _require_aiodio "aiocp"
-AIO_TEST="src/aio-dio-regress/aiocp"
+AIO_TEST="$here/src/aio-dio-regress/aiocp"
 
 rm -f $seqres.full
 
diff --git a/tests/xfs/241 b/tests/xfs/241
index 6b642a8..c18937b 100755
--- a/tests/xfs/241
+++ b/tests/xfs/241
@@ -33,7 +33,7 @@ _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "cowextsize"
 _require_aiodio "aiocp"
-AIO_TEST="src/aio-dio-regress/aiocp"
+AIO_TEST="$here/src/aio-dio-regress/aiocp"
 
 rm -f $seqres.full
 
diff --git a/tests/xfs/260 b/tests/xfs/260
index 4956752..3464ffe 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -49,12 +49,12 @@ t_both_dax()
 	prep_files
 	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
 	# with O_DIRECT first
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
+	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
 
 	prep_files
 	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
 	# again with buffered IO
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
 		$1 "buffered both dax"
 }
 
@@ -63,13 +63,13 @@ t_nondax_to_dax()
 	prep_files
 	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
 	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
 		$1 "dio nondax to dax"
 
 	prep_files
 	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
 	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
 		$1 "buffered nondax to dax"
 }
 
@@ -78,13 +78,13 @@ t_dax_to_nondax()
 	prep_files
 	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
 	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
 		$1 "dio dax to nondax"
 
 	prep_files
 	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
 	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
 		$1 "buffered dax to nondax"
 }
 
@@ -92,12 +92,12 @@ t_both_nondax()
 {
 	prep_files
 	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
 		$1 "dio both nondax"
 
 	prep_files
 	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
 		$1 "buffered both nondax"
 }
 
@@ -115,7 +115,7 @@ do_tests()
 	# less than page size
 	t_dax_flag_mmap_dio 1024
 	# page size
-	t_dax_flag_mmap_dio `src/feature -s`
+	t_dax_flag_mmap_dio `$here/src/feature -s`
 	# bigger sizes, for PMD faults
 	t_dax_flag_mmap_dio $((16 * 1024 * 1024))
 	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
diff --git a/tests/xfs/269 b/tests/xfs/269
index 25ae50d..007bcfa 100755
--- a/tests/xfs/269
+++ b/tests/xfs/269
@@ -44,7 +44,7 @@ mkdir $SCRATCH_MNT/foo
 __populate_create_attr $SCRATCH_MNT/foo 100
 
 echo "Run test program"
-./src/attr-list-by-handle-cursor-test $SCRATCH_MNT/foo
+$here/src/attr-list-by-handle-cursor-test $SCRATCH_MNT/foo
 
 # success, all done
 status=0
diff --git a/tests/xfs/272 b/tests/xfs/272
index 1f878de..9e3e171 100755
--- a/tests/xfs/272
+++ b/tests/xfs/272
@@ -40,7 +40,7 @@ _scratch_mount
 
 _pwrite_byte 0x80 0 737373 $SCRATCH_MNT/urk >> $seqres.full
 sync
-./src/punch-alternating $SCRATCH_MNT/urk >> $seqres.full
+$here/src/punch-alternating $SCRATCH_MNT/urk >> $seqres.full
 ino=$(stat -c '%i' $SCRATCH_MNT/urk)
 
 echo "Get fsmap" | tee -a $seqres.full
diff --git a/tests/xfs/274 b/tests/xfs/274
index 592c903..b42bd5d 100755
--- a/tests/xfs/274
+++ b/tests/xfs/274
@@ -42,7 +42,7 @@ _scratch_mount
 
 _pwrite_byte 0x80 0 737373 $SCRATCH_MNT/f1 >> $seqres.full
 sync
-./src/punch-alternating $SCRATCH_MNT/f1 >> $seqres.full
+$here/src/punch-alternating $SCRATCH_MNT/f1 >> $seqres.full
 _cp_reflink $SCRATCH_MNT/f1 $SCRATCH_MNT/f2
 ino=$(stat -c '%i' $SCRATCH_MNT/f1)
 
diff --git a/tests/xfs/276 b/tests/xfs/276
index ed29844..01f1c27 100755
--- a/tests/xfs/276
+++ b/tests/xfs/276
@@ -41,7 +41,7 @@ _scratch_mount
 
 $XFS_IO_PROG -f -R -c 'pwrite -S 0x80 0 737373' $SCRATCH_MNT/urk >> $seqres.full
 sync
-./src/punch-alternating $SCRATCH_MNT/urk >> $seqres.full
+$here/src/punch-alternating $SCRATCH_MNT/urk >> $seqres.full
 ino=$(stat -c '%i' $SCRATCH_MNT/urk)
 
 echo "Get fsmap" | tee -a $seqres.full
diff --git a/tests/xfs/282 b/tests/xfs/282
index 3f0d8e5..b4d3f81 100755
--- a/tests/xfs/282
+++ b/tests/xfs/282
@@ -37,13 +37,13 @@ _require_legacy_v2_format
 _create_dumpdir_fill
 # ensure file/dir timestamps precede dump timestamp
 sleep 2
-src/bstat $SCRATCH_MNT >>$seqres.full
+$here/src/bstat $SCRATCH_MNT >>$seqres.full
 
 echo "*** Level 0 dump, format 2"
 _do_dump_file -f $tmp.l0 -K
 
 _append_dumpdir_fill
-src/bstat $SCRATCH_MNT >>$seqres.full
+$here/src/bstat $SCRATCH_MNT >>$seqres.full
 
 echo "*** Level 1 dump, current format"
 _do_dump_file -l 1 -f $tmp.l1
diff --git a/tests/xfs/283 b/tests/xfs/283
index eab9f96..ec0f2df 100755
--- a/tests/xfs/283
+++ b/tests/xfs/283
@@ -37,13 +37,13 @@ _require_legacy_v2_format
 _create_dumpdir_fill
 # ensure file/dir timestamps precede dump timestamp
 sleep 2
-src/bstat $SCRATCH_MNT >>$seqres.full
+$here/src/bstat $SCRATCH_MNT >>$seqres.full
 
 echo "*** Level 0 dump, current format"
 _do_dump_file -f $tmp.l0
 
 _append_dumpdir_fill
-src/bstat $SCRATCH_MNT >>$seqres.full
+$here/src/bstat $SCRATCH_MNT >>$seqres.full
 
 echo "*** Level 1 dump, format 2"
 _do_dump_file -l 1 -f $tmp.l1 -K
diff --git a/tests/xfs/285 b/tests/xfs/285
index ad8b1ba..5c341ad 100755
--- a/tests/xfs/285
+++ b/tests/xfs/285
@@ -43,7 +43,7 @@ _scratch_mount
 STRESS_DIR="$SCRATCH_MNT/testdir"
 mkdir -p $STRESS_DIR
 
-cpus=$(( $(src/feature -o) * 4 * LOAD_FACTOR))
+cpus=$(( $($here/src/feature -o) * 4 * LOAD_FACTOR))
 $FSSTRESS_PROG -d $STRESS_DIR -p $cpus -n $((cpus * 100000)) $FSSTRESS_AVOID >/dev/null 2>&1 &
 $XFS_SCRUB_PROG -d -T -v -n $SCRATCH_MNT >> $seqres.full
 
diff --git a/tests/xfs/286 b/tests/xfs/286
index 8bc1e59..9ad979e 100755
--- a/tests/xfs/286
+++ b/tests/xfs/286
@@ -45,7 +45,7 @@ _scratch_mount
 STRESS_DIR="$SCRATCH_MNT/testdir"
 mkdir -p $STRESS_DIR
 
-cpus=$(( $(src/feature -o) * 4 * LOAD_FACTOR))
+cpus=$(( $($here/src/feature -o) * 4 * LOAD_FACTOR))
 $FSSTRESS_PROG -d $STRESS_DIR -p $cpus -n $((cpus * 100000)) $FSSTRESS_AVOID >/dev/null 2>&1 &
 $XFS_SCRUB_PROG -d -T -v -n $SCRATCH_MNT >> $seqres.full
 
diff --git a/tests/xfs/294 b/tests/xfs/294
index af0fc12..67c5fbf 100755
--- a/tests/xfs/294
+++ b/tests/xfs/294
@@ -85,7 +85,7 @@ df -h $SCRATCH_MNT >> $seqres.full 2>&1
 # Fill remaining space; let this run to failure
 dd if=/dev/zero of=$SCRATCH_MNT/spacefile1 oflag=direct >> $seqres.full 2>&1
 # Fragment our all-consuming file
-./src/punch-alternating $SCRATCH_MNT/fragfile >> $seqres.full 2>&1
+$here/src/punch-alternating $SCRATCH_MNT/fragfile >> $seqres.full 2>&1
 
 # Punching might have freed up large-ish swaths of metadata
 # Consume hopefully any remaining contiguous freespace
diff --git a/tests/xfs/331 b/tests/xfs/331
index 8053c95..b26ea15 100755
--- a/tests/xfs/331
+++ b/tests/xfs/331
@@ -56,8 +56,8 @@ len=$((blocks * blksz))
 echo "+ make some files"
 $XFS_IO_PROG -f -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f1 >> $seqres.full
 $XFS_IO_PROG -f -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f2 >> $seqres.full
-./src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
-./src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
 
 # success, all done
 status=0
diff --git a/tests/xfs/335 b/tests/xfs/335
index 98255c6..9135aac 100755
--- a/tests/xfs/335
+++ b/tests/xfs/335
@@ -59,8 +59,8 @@ $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCR
 $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f2 >> $seqres.full
 
 echo "Explode the rtrmapbt"
-./src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
-./src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
 _scratch_cycle_mount
 
 echo "Remove half the records"
diff --git a/tests/xfs/336 b/tests/xfs/336
index 1cb53b9..33b2721 100755
--- a/tests/xfs/336
+++ b/tests/xfs/336
@@ -61,8 +61,8 @@ $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCR
 $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f2 >> $seqres.full
 
 echo "Explode the rtrmapbt"
-./src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
-./src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
 _scratch_cycle_mount
 
 echo "Create metadump file"
diff --git a/tests/xfs/337 b/tests/xfs/337
index db1b4a2..7b03d86 100755
--- a/tests/xfs/337
+++ b/tests/xfs/337
@@ -58,8 +58,8 @@ len=$((blocks * blksz))
 echo "+ make some files"
 $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f1 >> $seqres.full
 $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f2 >> $seqres.full
-./src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
-./src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
 _scratch_unmount
 
 echo "+ check fs"
diff --git a/tests/xfs/341 b/tests/xfs/341
index 5b811f9..45b7620 100755
--- a/tests/xfs/341
+++ b/tests/xfs/341
@@ -53,8 +53,8 @@ len=$((blocks * rtextsz))
 echo "Create some files"
 $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f1 >> $seqres.full
 $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f2 >> $seqres.full
-./src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
-./src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
 echo garbage > $SCRATCH_MNT/f3
 ino=$(stat -c '%i' $SCRATCH_MNT/f3)
 _scratch_unmount
diff --git a/tests/xfs/342 b/tests/xfs/342
index 58b7625..186adaa 100755
--- a/tests/xfs/342
+++ b/tests/xfs/342
@@ -52,8 +52,8 @@ len=$((blocks * rtextsz))
 echo "Create some files"
 $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f1 >> $seqres.full
 $XFS_IO_PROG -f -R -c "falloc 0 $len" -c "pwrite -S 0x68 -b 1048576 0 $len" $SCRATCH_MNT/f2 >> $seqres.full
-./src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
-./src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f1 >> "$seqres.full"
+$here/src/punch-alternating $SCRATCH_MNT/f2 >> "$seqres.full"
 echo garbage > $SCRATCH_MNT/f3
 ino=$(stat -c '%i' $SCRATCH_MNT/f3)
 _scratch_unmount
diff --git a/tests/xfs/422 b/tests/xfs/422
index 8430b1f..fdf69ba 100755
--- a/tests/xfs/422
+++ b/tests/xfs/422
@@ -55,7 +55,7 @@ for i in $(seq 0 9); do
 	done
 done
 
-cpus=$(( $(src/feature -o) * 4 * LOAD_FACTOR))
+cpus=$(( $($here/src/feature -o) * 4 * LOAD_FACTOR))
 
 echo "Concurrent repair"
 filter_output() {
diff --git a/tests/xfs/423 b/tests/xfs/423
index 85f8a0e..a63f402 100755
--- a/tests/xfs/423
+++ b/tests/xfs/423
@@ -44,7 +44,7 @@ _scratch_mount
 
 $XFS_IO_PROG -f -c 'falloc 0 10m' $SCRATCH_MNT/a >> $seqres.full
 $XFS_IO_PROG -f -c 'falloc 0 10m' $SCRATCH_MNT/b >> $seqres.full
-./src/punch-alternating $SCRATCH_MNT/b
+$here/src/punch-alternating $SCRATCH_MNT/b
 sync
 
 echo "Set up delalloc extents"
diff --git a/tests/xfs/443 b/tests/xfs/443
index 319e088..54d603c 100755
--- a/tests/xfs/443
+++ b/tests/xfs/443
@@ -62,9 +62,9 @@ file2=$SCRATCH_MNT/file2
 # files with large enough extent counts (200 or so should be plenty) to ensure
 # btree format on the largest possible inode size filesystems.
 $XFS_IO_PROG -fc "falloc 0 $((400 * dbsize))" $file1
-./src/punch-alternating $file1
+$here/src/punch-alternating $file1
 $XFS_IO_PROG -fc "falloc 0 $((400 * dbsize))" $file2
-./src/punch-alternating $file2
+$here/src/punch-alternating $file2
 
 # Now run an extent swap at every possible extent count down to 0. Depending on
 # inode size, one of these swaps will cover the boundary case between extent and
diff --git a/tests/xfs/444 b/tests/xfs/444
index 7a33b9e..6ed8871 100755
--- a/tests/xfs/444
+++ b/tests/xfs/444
@@ -57,7 +57,7 @@ mount_loop() {
 	filesz=$((bno_maxrecs * 3 * blksz))
 	rm -rf $SCRATCH_MNT/a
 	$XFS_IO_PROG -f -c "falloc 0 $filesz" $SCRATCH_MNT/a >> $seqres.full 2>&1
-	test -e $SCRATCH_MNT/a && ./src/punch-alternating $SCRATCH_MNT/a
+	test -e $SCRATCH_MNT/a && $here/src/punch-alternating $SCRATCH_MNT/a
 	rm -rf $SCRATCH_MNT/a
 
 	_scratch_unmount 2>&1 | _filter_scratch
diff --git a/tests/xfs/509 b/tests/xfs/509
index ceba9ff..4778ce0 100755
--- a/tests/xfs/509
+++ b/tests/xfs/509
@@ -120,7 +120,7 @@ inumbers_count()
 bstat_compare()
 {
 	bstat_versions | while read v_tag v_flag; do
-		diff -u <(./src/bstat $SCRATCH_MNT | grep ino | awk '{print $2}') \
+		diff -u <($here/src/bstat $SCRATCH_MNT | grep ino | awk '{print $2}') \
 			<($XFS_IO_PROG -c "bulkstat $v_flag" $SCRATCH_MNT | grep ino | awk '{print $3}')
 	done
 }
diff --git a/tests/xfs/510 b/tests/xfs/510
index c12b409..4a7684e 100755
--- a/tests/xfs/510
+++ b/tests/xfs/510
@@ -40,7 +40,7 @@ _supported_os Linux
 rm -f $seqres.full
 
 echo "Silence is golden."
-src/bulkstat_null_ocount $TEST_DIR
+$here/src/bulkstat_null_ocount $TEST_DIR
 
 # success, all done
 status=0
-- 
2.7.4

