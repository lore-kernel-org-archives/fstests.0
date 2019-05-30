Received: from mail.cn.fujitsu.com ([183.91.158.132]:9657 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726382AbfE3J1c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 May 2019 05:27:32 -0400
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] ext4: regression test for online resizing maximum blocks
Date: Thu, 30 May 2019 17:27:18 +0800
Message-ID: <1559208438-2767-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, jack@suse.cz
Cc: fstests@vger.kernel.org, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

This adds a regression test for online resizing maximum blocks
which can trigger a BUG_ON with non-zero s_first_data_block
filesystem.

The bug was fixed by patch:
"ext4: fix crash during online resizing"

The bug was introduced by patch:
"ext4: convert file system to meta_bg if needed..."

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/ext4/035     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/035.out |  4 ++++
 tests/ext4/group   |  1 +
 3 files changed, 62 insertions(+)
 create mode 100644 tests/ext4/035
 create mode 100644 tests/ext4/035.out

diff --git a/tests/ext4/035 b/tests/ext4/035
new file mode 100644
index 00000000..fc83bc24
--- /dev/null
+++ b/tests/ext4/035
@@ -0,0 +1,57 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+#
+# FSQA Test No. 309
+#
+# Regression test for commit:
+# f96c3ac8 (ext4: fix crash during online resizin)
+#
+# This case tests a loss s_first_data_block on ext4 when computing
+# maximum size with given number of group descriptor blocks.  Filesystem
+# with non-zero s_first_data_block can happen that computed maximum size
+# lower than current size and leads to a BUG_ON in in ext4_alloc_group_tables()
+# hitting on flex_gd->count == 0.
+#
+# This bug was introduced by commit:
+# 1c6bd71 (ext4: convert file system to meta_bg if needed..)
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1        # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+        rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+_require_scratch
+_require_command "$RESIZE2FS_PROG" resize2fs
+
+rm -f $seqres.full
+
+$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $SCRATCH_DEV 32768 >> $seqres.full 2>&1
+_scratch_mount
+
+echo "Resizing to 262145 blocks"
+$RESIZE2FS_PROG $SCRATCH_DEV 262145 >> $seqres.full 2>&1
+
+echo "Resizing to 300000 blocks"
+$RESIZE2FS_PROG $SCRATCH_DEV 300000 >> $seqres.full 2>&1
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/ext4/035.out b/tests/ext4/035.out
new file mode 100644
index 00000000..7e4f95af
--- /dev/null
+++ b/tests/ext4/035.out
@@ -0,0 +1,4 @@
+QA output created by 035
+Resizing to 262145 blocks
+Resizing to 300000 blocks
+Silence is golden
diff --git a/tests/ext4/group b/tests/ext4/group
index eb744a12..c8d03af7 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -37,6 +37,7 @@
 032 auto quick ioctl resize
 033 auto ioctl resize
 034 auto quick quota
+035 auto quick resize dangerous
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.18.1
