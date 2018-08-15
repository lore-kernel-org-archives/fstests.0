Received: from mail.cn.fujitsu.com ([183.91.158.132]:16965 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727952AbeHPDCI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Aug 2018 23:02:08 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] src/aiocp.c: Fix buffer alignment
Date: Wed, 15 Aug 2018 13:41:45 +0800
Message-ID: <1534311705-14286-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20180812150836.GE2791@desktop>
References: <20180812150836.GE2791@desktop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

In generic/252, aiocp with DIRECT will fail and return EINVAL on
4096 sector size block device, because the default 512 alignment
defined in aiocp is not aligned with 4096.

Please see the following error:
----------------------------------------------------------
read missing bytes expect 8388608 got -22
----------------------------------------------------------

We use '-a' option to specify a proper alignment size in all tests
that call aiocp with DIRECT.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/252 | 3 ++-
 tests/generic/329 | 3 ++-
 tests/generic/330 | 3 ++-
 tests/xfs/237     | 3 ++-
 tests/xfs/239     | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/generic/252 b/tests/generic/252
index 9e7f442..991bbe3 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -59,6 +59,7 @@ nr=640
 bufnr=128
 filesize=$((blksz * nr))
 bufsize=$((blksz * bufnr))
+alignment=`_min_dio_alignment $TEST_DEV`
 
 _require_fs_space $SCRATCH_MNT $((filesize / 1024 * 5 / 4))
 
@@ -75,7 +76,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 sync
 _dmerror_load_error_table
-$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
+$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
diff --git a/tests/generic/329 b/tests/generic/329
index c68d94a..c618c2a 100755
--- a/tests/generic/329
+++ b/tests/generic/329
@@ -51,6 +51,7 @@ nr=640
 bufnr=128
 filesize=$((blksz * nr))
 bufsize=$((blksz * bufnr))
+alignment=`_min_dio_alignment $TEST_DEV`
 
 _require_fs_space $SCRATCH_MNT $((filesize / 1024 * 3 * 5 / 4))
 
@@ -69,7 +70,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 sync
 _dmerror_load_error_table
-$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
+$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
diff --git a/tests/generic/330 b/tests/generic/330
index 334ac3c..7183d4c 100755
--- a/tests/generic/330
+++ b/tests/generic/330
@@ -47,6 +47,7 @@ nr=640
 bufnr=128
 filesize=$((blksz * nr))
 bufsize=$((blksz * bufnr))
+alignment=`_min_dio_alignment $TEST_DEV`
 
 _require_fs_space $SCRATCH_MNT $((filesize / 1024 * 3 * 5 / 4))
 
@@ -63,7 +64,7 @@ echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 sync
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
-$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
+$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _scratch_cycle_mount
 
 echo "Compare files"
diff --git a/tests/xfs/237 b/tests/xfs/237
index 286fd68..94855f5 100755
--- a/tests/xfs/237
+++ b/tests/xfs/237
@@ -53,6 +53,7 @@ nr=640
 bufnr=128
 filesize=$((blksz * nr))
 bufsize=$((blksz * bufnr))
+alignment=`_min_dio_alignment $TEST_DEV`
 
 _require_fs_space $SCRATCH_MNT $((filesize / 1024 * 3 * 5 / 4))
 
@@ -72,7 +73,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 sync
 _dmerror_load_error_table
-$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
+$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
diff --git a/tests/xfs/239 b/tests/xfs/239
index 6a13319..afe0d56 100755
--- a/tests/xfs/239
+++ b/tests/xfs/239
@@ -51,6 +51,7 @@ filesize=$((blksz * nr))
 bufsize=$((blksz * bufnr))
 filesize=$filesize
 bufsize=$bufsize
+alignment=`_min_dio_alignment $TEST_DEV`
 
 _require_fs_space $SCRATCH_MNT $((filesize / 1024 * 3 * 5 / 4))
 
@@ -68,7 +69,7 @@ echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 sync
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
-$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
+$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
 _scratch_cycle_mount
 
 echo "Compare files"
-- 
1.8.3.1
