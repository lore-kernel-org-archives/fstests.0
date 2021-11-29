Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FFFC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Nov 2021 06:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbhK2GZ0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Nov 2021 01:25:26 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28116 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhK2GX0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Nov 2021 01:23:26 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J2Zrl5KDzz1DJhk;
        Mon, 29 Nov 2021 14:17:27 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:20:06 +0800
Received: from huawei.com (10.67.174.154) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 29 Nov
 2021 14:20:06 +0800
From:   "chenlongcl.chen@huawei.com" <chenlongcl.chen@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <tytso@mit.edu>, <chenlongcl.chen@huawei.com>
Subject: [PATCH v2] ext4: verify ext4 when the starting block of index and leaf are inconsistent
Date:   Mon, 29 Nov 2021 14:21:23 +0800
Message-ID: <20211129062123.68070-1-chenlongcl.chen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.154]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
the index block and leaf block are inconsistent, triggering bugon.

This is a regression test for three kernel commit:
1. 0f2f87d51aebc (ext4: prevent partial update of the extent blocks)
2. 9c6e071913792 (ext4: check for inconsistent extents between index
   and leaf block)
3. 8dd27fecede55 (ext4: check for out-of-order index extents in
   ext4_valid_extent_entries())

Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
---
 tests/ext4/054     | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/054.out |  2 +
 2 files changed, 94 insertions(+)
 create mode 100755 tests/ext4/054
 create mode 100644 tests/ext4/054.out

diff --git a/tests/ext4/054 b/tests/ext4/054
new file mode 100755
index 00000000..1b0dcdc5
--- /dev/null
+++ b/tests/ext4/054
@@ -0,0 +1,92 @@
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
+}
+
+# Import common functions
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4
+_require_test
+_require_scratch_nocheck
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "pwrite"
+_require_xfs_io_command "fsync"
+_require_xfs_io_command "fpunch"
+_require_command "$DEBUGFS_PROG" debugfs
+
+# In order to accurately construct the damaged extent in the following
+# test steps, the blocksize is set to 1024 here
+_scratch_mkfs "-b 1024" > $seqres.full 2>&1
+_scratch_mount
+
+TEST_FILE="${SCRATCH_MNT}/testfile"
+touch $TEST_FILE
+
+# The following steps create an abnormal file system image and
+# create a file(testfile). The starting logic block of its second leaf
+# extent block is inconsistent with the starting logic block of the
+# second idx extent entry in the inode.
+# Level Entries       Logical      Physical Length Flags
+# 0/ 1   2/  2  5632 -  6527  2020            896
+#               ^^^^ point to leaf block
+# 1/ 1   1/ 15  5376 -  5439  7041 -  7104     64 Uninit
+# 1/ 1   2/ 15  5632 -  5695  7297 -  7360     64 Uninit
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
+$XFS_IO_PROG -c "fsync" $TEST_FILE >> $seqres.full
+
+_scratch_unmount >> $seqres.full 2>&1
+
+$DEBUGFS_PROG -w -R "set_inode_field testfile block[6] 0x1600" $SCRATCH_DEV \
+        2>> $seqres.full >> $seqres.full
+
+# Mount the file system and create a block at a location in the middle
+# of 5440-5632
+
+# When the delalloc option is enabled when mounting, the block allocation
+# will not be triggered when writing (the maximum waiting time is about 30s).
+# If nodellalloc is used, the block will be allocated when writing. The
+# expected BUG_ON in this use case can be triggered immediately, and the test
+# results can be quickly obtained.
+_scratch_mount "-o nodelalloc"
+$XFS_IO_PROG -c "pwrite $((1024 * 5568)) $((1024 * 64))" $TEST_FILE \
+        2>> $seqres.full >> $seqres.full
+
+# If this BUG is not fixed, when the testcase is executed to this position,
+# the kernel will be BUG_ON immediately.
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

