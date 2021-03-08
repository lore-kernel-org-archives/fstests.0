Return-Path: <SRS0=IhtW=IG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DAFC433DB
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Mar 2021 01:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C98865142
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Mar 2021 01:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCHBzC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Mar 2021 20:55:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51804 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232256AbhCHByj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Mar 2021 20:54:39 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1281sa94022229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 7 Mar 2021 20:54:36 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 31F0915C3AAC; Sun,  7 Mar 2021 20:54:36 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic: clean up tests using fio
Date:   Sun,  7 Mar 2021 20:54:34 -0500
Message-Id: <20210308015434.20396-1-tytso@mit.edu>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

During the code review for a test to exercises AIO/DIO into unwritten
space, a number of changes were requested that were also applicable to
generic/299 and generic/300 (from which the aforementioned test was
patterned).  For example, the use of run_check, which is deprecated,
was dropped.  In addition, we now rely on the test runner to unmount
the scratch file system.

Also fix a nit I found in generic/095, which resulted in debugging
information in the $seqres.full to get lost when "fio ...
--output=$seqres.full" is run.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/095 |  4 ++-
 tests/generic/299 | 73 ++++++++++++++++++++++-------------------------
 tests/generic/300 | 33 +++++++++------------
 3 files changed, 51 insertions(+), 59 deletions(-)

diff --git a/tests/generic/095 b/tests/generic/095
index 30fe77a5..97757957 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -34,6 +34,7 @@ iodepth=$((16 * LOAD_FACTOR))
 iodepth_batch=$((8 * LOAD_FACTOR))
 numjobs=$((5 * LOAD_FACTOR))
 fio_config=$tmp.fio
+fio_out=$tmp.fio.out
 cat >$fio_config <<EOF
 [global]
 bs=8k
@@ -101,7 +102,8 @@ _scratch_mount
 # There's a known EIO failure to report collisions between directio and buffered
 # writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
 # at here.
-$FIO_PROG $fio_config --ignore_error=,EIO --output=$seqres.full
+$FIO_PROG $fio_config --ignore_error=,EIO --output=$fio_out
+cat $fio_out >> $seqres.full
 echo "Silence is golden"
 
 # xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
diff --git a/tests/generic/299 b/tests/generic/299
index aff6dac3..a320056d 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -15,8 +15,14 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 fio_config=$tmp.fio
+fio_out=$tmp.fio.out
 status=1	# failure is the default!
-trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    rm -f $tmp.*
+}
 
 # get standard environment, filters and checks
 . ./common/rc
@@ -27,6 +33,7 @@ _supported_fs generic
 _require_test
 _require_scratch
 _require_odirect
+_require_aio
 _require_block_device $SCRATCH_DEV
 
 NUM_JOBS=$((4*LOAD_FACTOR))
@@ -104,47 +111,35 @@ rm -f $seqres.full
 _require_fio $fio_config
 _require_xfs_io_command "falloc"
 
-_workout()
-{
-	echo ""
-	echo "Run fio with random aio-dio pattern"
-	echo ""
-	cat $fio_config >>  $seqres.full
-	run_check $FIO_PROG $fio_config &
-	pid=$!
-	echo "Start fallocate/truncate loop"
-
-	for ((i=0; ; i++))
-	do
-	    for ((k=1; k <= NUM_JOBS; k++))
-	    do
-		$XFS_IO_PROG -f -c "falloc 0 $FILE_SIZE" \
-			$SCRATCH_MNT/direct_aio.$k.0 >> $seqres.full 2>&1
-	    done
-	    for ((k=1; k <= NUM_JOBS; k++))
-	    do
-		$XFS_IO_PROG -c "truncate  0" \
-			$SCRATCH_MNT/direct_aio.$k.0 >> $seqres.full 2>&1
-	    done
-	    # Following like will check that pid is still run.
-	    # Once fio exit we can stop fallocate/truncate loop
-	    pgrep -f "$FIO_PROG" > /dev/null 2>&1 || break
-	done
-	wait $pid
-}
-
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 
-if ! _workout; then
-	_scratch_unmount 2>/dev/null
-	exit
-fi
+echo ""
+echo "Run fio with random aio-dio pattern"
+echo ""
+cat $fio_config >>  $seqres.full
+$FIO_PROG $fio_config --output=$fio_out &
+pid=$!
+echo "Start fallocate/truncate loop"
+
+for ((i=0; ; i++))
+do
+    for ((k=1; k <= NUM_JOBS; k++))
+    do
+	$XFS_IO_PROG -f -c "falloc 0 $FILE_SIZE" \
+		$SCRATCH_MNT/direct_aio.$k.0 >> $seqres.full 2>&1
+    done
+    for ((k=1; k <= NUM_JOBS; k++))
+    do
+	$XFS_IO_PROG -c "truncate  0" \
+		$SCRATCH_MNT/direct_aio.$k.0 >> $seqres.full 2>&1
+    done
+    # Following like will check that pid is still run.
+    # Once fio exit we can stop fallocate/truncate loop
+    pgrep -f "$FIO_PROG" > /dev/null 2>&1 || break
+done
+wait $pid
+cat $fio_out >> $seqres.full
 
-if ! _scratch_unmount; then
-	echo "failed to umount"
-	status=1
-	exit
-fi
 status=0
 exit
diff --git a/tests/generic/300 b/tests/generic/300
index f7a99d4a..2fe5ac6e 100755
--- a/tests/generic/300
+++ b/tests/generic/300
@@ -15,8 +15,14 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 fio_config=$tmp.fio
+fio_out=$tmp.fio.out
 status=1	# failure is the default!
-trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    rm -f $tmp.*
+}
 
 # get standard environment, filters and checks
 . ./common/rc
@@ -26,6 +32,7 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _require_scratch
 _require_odirect
+_require_aio
 _require_block_device $SCRATCH_DEV
 
 # xfs_io is not required for this test, but it's the best way to verify
@@ -115,29 +122,17 @@ rw=randwrite
 filename=aio-dio-verifier
 EOF
 
-_workout()
-{
-	echo ""
-	echo "Run fio with random aio-dio pattern"
-	echo ""
-	cat $fio_config >>  $seqres.full
-	run_check $FIO_PROG $fio_config
-}
-
 _require_fio $fio_config
 
 _scratch_mkfs_sized $FS_SIZE >> $seqres.full 2>&1
 _scratch_mount
 
-if ! _workout; then
-	_scratch_unmount 2>/dev/null
-	exit
-fi
+echo ""
+echo "Run fio with random aio-dio pattern"
+echo ""
+cat $fio_config >>  $seqres.full
+$FIO_PROG $fio_config --output=$fio_out
+cat $fio_out >> $seqres.full
 
-if ! _scratch_unmount; then
-	echo "failed to umount"
-	status=1
-	exit
-fi
 status=0
 exit
-- 
2.30.0

