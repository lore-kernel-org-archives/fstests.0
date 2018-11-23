Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729305AbeKWQmV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Nov 2018 11:42:21 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAN5sOX9145539
        for <fstests@vger.kernel.org>; Fri, 23 Nov 2018 00:59:36 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nx73v1f08-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Fri, 23 Nov 2018 00:59:36 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Fri, 23 Nov 2018 05:59:35 -0000
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 1/2] ext4/002: Work with 64k block size
Date: Fri, 23 Nov 2018 11:29:29 +0530
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20181123055930.21423-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

This commit changes the script to operate on FS blocks by obtaining the
block size from the underlying filesystem and using it to perform I/O in
units of block sizes.

This commit also uses $SCRATCH_MNT rather than $TEST_DIR for holding the
test files since the FS on $TEST_DIR might be created with a different
block size than the one specified in $MKFS_OPTIONS.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/ext4/002     | 68 ++++++++++++++++++++++++----------------------
 tests/ext4/002.out | 18 ++++--------
 2 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/tests/ext4/002 b/tests/ext4/002
index c4fb3bde..b911b1a4 100755
--- a/tests/ext4/002
+++ b/tests/ext4/002
@@ -105,61 +105,63 @@ _check_ext4_eof_flag()
 _supported_fs ext4
 _supported_os Linux
 _require_xfs_io_command "falloc"
-_require_test
+_require_scratch
 
 # Real QA test starts here.
 rm -f $seqres.full
 
-# Remove any leftover files from last run.
-rm -f ${TEST_DIR}/test_?
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
 
 # Begin test cases.
-echo "Test 1: Fallocate 40960 bytes and write 4096 bytes (buffered io)." \
+echo "Test 1: Fallocate 10 blocks and write 1 block (buffered io)." \
     >> $seqres.full
-${XFS_IO_PROG} -f                       \
-    -c 'falloc -k 0 40960'              \
-    -c 'pwrite 0 4096'                  \
-    ${TEST_DIR}/test_1 | _filter_xfs_io_unique
+${XFS_IO_PROG} -f				\
+    -c "falloc -k 0 $((10 * $BLOCK_SIZE))"	\
+    -c "pwrite 0 $BLOCK_SIZE"			\
+    ${SCRATCH_MNT}/test_1 | _filter_xfs_io_blocks_modified
 _check_ext4_eof_flag test_1 ${BIT_SET}
 
-echo "Test 2: Fallocate 40960 bytes and write 4096 bytes (direct io)." \
+echo "Test 2: Fallocate 10 blocks and write 1 block (direct io)." \
     >> $seqres.full
-${XFS_IO_PROG} -f -d                    \
-    -c 'falloc -k 0 40960'              \
-    -c 'pwrite 0 4096'                  \
-    ${TEST_DIR}/test_2 | _filter_xfs_io_unique
+${XFS_IO_PROG} -f -d				\
+    -c "falloc -k 0 $((10 * $BLOCK_SIZE))"	\
+    -c "pwrite 0 $BLOCK_SIZE"			\
+    ${SCRATCH_MNT}/test_2 | _filter_xfs_io_blocks_modified
 _check_ext4_eof_flag test_2 ${BIT_SET}
 
-echo "Test 3: Fallocate 40960 bytes and write 40960 bytes (buffered io)." \
+echo "Test 3: Fallocate 10 blocks and write 10 blocks (buffered io)." \
     >> $seqres.full
-${XFS_IO_PROG} -f                       \
-    -c 'falloc -k 0 40960'              \
-    -c 'pwrite 0 40960'                 \
-    ${TEST_DIR}/test_3 | _filter_xfs_io_unique
+${XFS_IO_PROG} -f				\
+    -c "falloc -k 0 $((10 * $BLOCK_SIZE))"	\
+    -c "pwrite 0 $((10 * $BLOCK_SIZE))"		\
+    ${SCRATCH_MNT}/test_3 | _filter_xfs_io_blocks_modified
 _check_ext4_eof_flag test_3 ${BIT_NOT_SET}
 
-echo "Test 4: Fallocate 40960 bytes and write 40960 bytes (direct io)." \
+echo "Test 4: Fallocate 10 blocks and write 10 blocks (direct io)." \
     >> $seqres.full
-${XFS_IO_PROG} -f -d                    \
-    -c 'falloc -k 0 40960'              \
-    -c 'pwrite 0 40960'                 \
-    ${TEST_DIR}/test_4 | _filter_xfs_io_unique
+${XFS_IO_PROG} -f -d				\
+    -c "falloc -k 0 $((10 * $BLOCK_SIZE))"	\
+    -c "pwrite 0 $((10 * $BLOCK_SIZE))"		\
+    ${SCRATCH_MNT}/test_4 | _filter_xfs_io_blocks_modified
 _check_ext4_eof_flag test_4 ${BIT_NOT_SET}
 
-echo "Test 5: Fallocate 128k, seek 256k and write 4k block (buffered io)." \
+echo "Test 5: Fallocate 32 blocks, seek 64 blocks and write 1 block (buffered io)." \
     >> $seqres.full
-${XFS_IO_PROG} -f                       \
-    -c 'falloc -k 0 128k'               \
-    -c 'pwrite 256k 4k'                 \
-    ${TEST_DIR}/test_5 | _filter_xfs_io_unique
+${XFS_IO_PROG} -f					\
+    -c "falloc -k 0 $((32 * $BLOCK_SIZE))"		\
+    -c "pwrite $((64 * $BLOCK_SIZE)) $BLOCK_SIZE"	\
+    ${SCRATCH_MNT}/test_5 | _filter_xfs_io_blocks_modified
 _check_ext4_eof_flag test_5 ${BIT_NOT_SET}
 
-echo "Test 6: Fallocate 128k, seek to 256k and write a 4k block (direct io)." \
+echo "Test 6: Fallocate 32 blocks, seek to 64 blocks and write 1 block (direct io)." \
     >> $seqres.full
-${XFS_IO_PROG} -f -d                    \
-    -c 'falloc -k 0 128k'               \
-    -c 'pwrite 256k 4k'                 \
-    ${TEST_DIR}/test_6 | _filter_xfs_io_unique
+${XFS_IO_PROG} -f -d					\
+    -c "falloc -k 0 $((32 * $BLOCK_SIZE))"		\
+    -c "pwrite $((64 * $BLOCK_SIZE)) $BLOCK_SIZE"	\
+    ${SCRATCH_MNT}/test_6 | _filter_xfs_io_blocks_modified
 _check_ext4_eof_flag test_6 ${BIT_NOT_SET}
 
 status=0
diff --git a/tests/ext4/002.out b/tests/ext4/002.out
index 3dcca877..1605a115 100644
--- a/tests/ext4/002.out
+++ b/tests/ext4/002.out
@@ -1,13 +1,7 @@
 QA output created by 002
-wrote 4096/4096 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 40960/40960 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 40960/40960 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 262144
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 262144
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Blocks modified: [0 - 0]
+Blocks modified: [0 - 0]
+Blocks modified: [0 - 9]
+Blocks modified: [0 - 9]
+Blocks modified: [64 - 64]
+Blocks modified: [64 - 64]
-- 
2.19.1
