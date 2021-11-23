Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA91BC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Nov 2021 01:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhKWBjp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:39:45 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28167 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBjp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Nov 2021 20:39:45 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HymsL3764z8vYM;
        Tue, 23 Nov 2021 09:34:46 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 09:36:36 +0800
Received: from huawei.com (10.67.174.154) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 23 Nov
 2021 09:36:35 +0800
From:   "chenlongcl.chen@huawei.com" <chenlongcl.chen@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <tytso@mit.edu>, <chenlongcl.chen@huawei.com>
Subject: [PATCH] ext4: verify ext4 when the starting block of index and leaf are inconsistent
Date:   Tue, 23 Nov 2021 09:37:59 +0800
Message-ID: <20211123013759.170012-1-chenlongcl.chen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.154]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: chenlong <chenlongcl.chen@huawei.com>

Insert the extent entry in ext4_ext_insert_extent() (to be inserted at
the beginning of the block). In the stage of updating the starting block
number of the parent index block, an error happened
in ext4_ext_correct_indexes()->ext4_ext_get_access(), which caused the
index update of the parent index node to fail. The ext4_ext_insert_extent()
function exits directly and does not roll back the extent entry of
the leaf block. Eventually, the extent starting block numbers in
the index block and leaf block are inconsistent, triggering bugon

This is a regression test for three kernel commit:
1. 0f2f87d51aebc (ext4: prevent partial update of the extent blocks)
2. 9c6e071913792 (ext4: check for inconsistent extents between index
   and leaf block)
3. 8dd27fecede55 (ext4: check for out-of-order index extents in
   ext4_valid_extent_entries())
---
 tests/ext4/054     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/054.out |  2 +
 2 files changed, 99 insertions(+)
 create mode 100755 tests/ext4/054
 create mode 100644 tests/ext4/054.out

diff --git a/tests/ext4/054 b/tests/ext4/054
new file mode 100755
index 00000000..3d63f12f
--- /dev/null
+++ b/tests/ext4/054
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Huawei.  All Rights Reserved.
+#
+# FS QA Test 054
+#
+# Regression test for kernel commit:
+# 1. 0f2f87d51aebc (ext4: prevent partial update of the extent blocks)
+# 2. 9c6e071913792 (ext4: check for inconsistent extents between index \
+#    and leaf block)
+# 3. 8dd27fecede55 (ext4: check for out-of-order index extents in \
+#    ext4_valid_extent_entries())
+
+. ./common/preamble
+_begin_fstest auto quick
+
+_cleanup()
+{
+    cd /
+    rm -f $tmp.*
+    $UMOUNT_PROG ${IMG_MNT} > /dev/null 2>&1
+    rm -f ${IMG_FILE} > /dev/null 2>&1
+}
+
+# Import common functions
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4
+_require_test
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "pwrite"
+_require_xfs_io_command "fsync"
+_require_xfs_io_command "fpunch"
+_require_command "$DEBUGFS_PROG" debugfs
+
+IMG_FILE=${SCRATCH_MNT}/$seq.fs
+IMG_MNT=${SCRATCH_MNT}/$seq.mnt
+TEST_FILE="${IMG_MNT}/testfile"
+
+fallocate -l 10M $IMG_FILE
+mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
+
+$MKFS_EXT4_PROG -F $IMG_FILE >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+$MOUNT_PROG -t ${FSTYP} ${IMG_FILE} ${IMG_MNT} >/dev/null 2>&1 || \
+    _fail "mount failed"
+touch $TEST_FILE
+
+#
+# The following steps create an abnormal file system image and
+# create a file(testfile). The starting logic block of his second leaf
+# extent block is inconsistent with the starting logic block of the
+# second idx extent entry in the inode.
+# Level Entries       Logical      Physical Length Flags
+# 0/ 1   2/  2  5632 -  6527  2020            896
+#               ^^^^ 指向了leaf block
+# 1/ 1   1/ 15  5376 -  5439  7041 -  7104     64 Uninit
+# 1/ 1   2/ 15  5632 -  5695  7297 -  7360     64 Uninit
+#
+for i in {0..50}
+do
+    offset=$((1024 * 128 * i))
+    $XFS_IO_PROG -c "falloc $offset $((1024 * 64))" $TEST_FILE >> $seqres.full
+    offset=$((offset + 1024 * 64))
+    $XFS_IO_PROG -c "pwrite $offset $((1024 * 64))" $TEST_FILE >> $seqres.full
+    $XFS_IO_PROG -c "fsync" $TEST_FILE >> $seqres.full
+done
+
+$XFS_IO_PROG -c "fpunch $((1024 * 5376)) $((1024 * 256))" $TEST_FILE \
+        >> $seqres.full
+$XFS_IO_PROG -c "fsync" $TEST_FILE >> $seqres.full
+$XFS_IO_PROG -c "falloc $((1024 * 5376)) $((1024 * 64))" $TEST_FILE \
+        >> $seqres.full
+$XFS_IO_PROG -c "fsync" $TEST_FILE
+
+$UMOUNT_PROG ${IMG_MNT} || _fail "umount failed"
+
+$DEBUGFS_PROG -w -R "set_inode_field testfile block[6] 0x1600" $IMG_FILE \
+        2>>$seqres.full >> $seqres.full
+
+# Mount the file system and create a block at a location in the middle
+# of 5440-5632
+
+$MOUNT_PROG -t ${FSTYP} -o nodelalloc ${IMG_FILE} ${IMG_MNT} \
+        >/dev/null 2>&1 || _fail "mount failed"
+$XFS_IO_PROG -c "pwrite $((1024 * 5568)) $((1024 * 64))" $TEST_FILE \
+        2>>$seqres.full >> $seqres.full
+
+# If this BUG is not fixed, when the testcase is executed to this position,
+# the kernel will be BUG_ON immediately.
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/054.out b/tests/ext4/054.out
new file mode 100644
index 00000000..108fe4c9
--- /dev/null
+++ b/tests/ext4/054.out
@@ -0,0 +1,2 @@
+QA output created by 054
+Silence is golden
-- 
2.17.1

