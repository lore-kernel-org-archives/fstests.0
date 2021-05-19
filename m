Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF75C433ED
	for <linux-fstests@archiver.kernel.org>; Wed, 19 May 2021 03:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A45F61209
	for <linux-fstests@archiver.kernel.org>; Wed, 19 May 2021 03:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhESDLF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 May 2021 23:11:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3026 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbhESDLF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 May 2021 23:11:05 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FlHq42RwlzmWZV;
        Wed, 19 May 2021 11:07:28 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 11:09:44 +0800
Received: from huawei.com (10.67.174.154) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 11:09:43 +0800
From:   chenlong <chenlongcl.chen@huawei.com>
To:     <fstests@vger.kernel.org>, <guaneryu@gmail.com>, <tytso@mit.edu>
CC:     <chenlongcl.chen@huawei.com>
Subject: [PATCH] ext4/048: Add new regression test
Date:   Wed, 19 May 2021 11:10:15 +0800
Message-ID: <20210519031015.14005-1-chenlongcl.chen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.154]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check the block group zero and prevent initializing reserved inodes.
But in some special cases, the reserved inode may not all belong to
the group zero, it may exist into the second group if we format 
filesystem below.
mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
So, it will end up triggering a false positive report of a corrupted
file system

It's a regression test for commit a149d2a5cabb.

Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
---
 tests/ext4/048     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/048.out |  5 +++++
 tests/ext4/group   |  1 +
 3 files changed, 56 insertions(+)
 create mode 100755 tests/ext4/048
 create mode 100644 tests/ext4/048.out

diff --git a/tests/ext4/048 b/tests/ext4/048
new file mode 100755
index 00000000..56801579
--- /dev/null
+++ b/tests/ext4/048
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Huawei.  All Rights Reserved.
+#
+# FS QA Test 048
+#
+# Regression test for commit:
+# a149d2a5cabb(ext4: fix check to prevent false positive report of incorrect
+# used inodes)
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_require_scratch
+
+echo "+ create scratch fs"
+_scratch_mkfs_ext4 -b 4096 -g 8192 -N 1024 -I 4096 >> $seqres.full 2>&1
+
+echo "+ mount fs"
+_scratch_mount -o errors=remount-ro
+sleep 5
+
+echo "+ check mountpoint status"
+cat /proc/self/mounts | grep ${SCRATCH_MNT} | \
+    $AWK_PROG '{print $4}' | grep -oE '^rw,' | tee -a $seqres.full
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/048.out b/tests/ext4/048.out
new file mode 100644
index 00000000..16e50e86
--- /dev/null
+++ b/tests/ext4/048.out
@@ -0,0 +1,5 @@
+QA output created by 048
++ create scratch fs
++ mount fs
++ check mountpoint status
+rw,
diff --git a/tests/ext4/group b/tests/ext4/group
index ceda2ba6..82b77efb 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -50,6 +50,7 @@
 045 auto dir
 046 auto prealloc quick
 047 auto quick dax
+048 auto quick
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.18.0.huawei.25

