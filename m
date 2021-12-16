Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53917C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 09:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhLPJUj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 04:20:39 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29133 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbhLPJUj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 04:20:39 -0500
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JF62m4NLxz1DK6m;
        Thu, 16 Dec 2021 17:17:36 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 17:20:37 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 16 Dec
 2021 17:20:36 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>
CC:     <sunke32@huawei.com>
Subject: [PATCH v2] ext4: illegal memory access caused by quota index information error
Date:   Thu, 16 Dec 2021 17:32:19 +0800
Message-ID: <20211216093219.302359-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The quota index information in the image is tampered, causing illegal
memory access.
It is a regression test for Kernel commit 9bf3d2033129 quota: check block
number when reading the block in quota file and commit d0e36a62bd4c
quota: correct error number in free_dqentry().

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/ext4/055     | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/055.out |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100755 tests/ext4/055
 create mode 100644 tests/ext4/055.out

diff --git a/tests/ext4/055 b/tests/ext4/055
new file mode 100755
index 00000000..2e344106
--- /dev/null
+++ b/tests/ext4/055
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Huawei.  All Rights Reserved.
+#
+# FS QA Test 055
+#
+# The preceding illegal memory access problem occurs due to tampering with the
+# quota index information in the image.
+#
+# Regression test for kernel
+# commit 9bf3d2033129 quota: check block number when reading the block in quota file
+# commit d0e36a62bd4c quota: correct error number in free_dqentry()
+#
+# The test is based on a testcase from Zhang Yi <yi.zhang@huawei.com>.
+#
+. ./common/preamble
+_begin_fstest auto quota
+
+# real QA test starts here
+
+# Modify as appropriate.
+_require_scratch_nocheck
+_supported_fs ext4
+_require_user fsgqa
+_require_user fsgqa2
+_require_command "$DEBUGFS_PROG" debugfs
+
+echo "Silence is golden"
+
+# The 1K blocksize is designed for debugfs.
+_scratch_mkfs "-F -O quota -b 1024" > $seqres.full 2>&1
+# Start from 0, fill block 1 with 6，replace the original 2.
+# The purpose is change the normal index order from 1->2->3->4->5 to 1->6->0.
+$DEBUGFS_PROG -w -R "zap_block -o 0 -l 1 -p 6 -f <3> 1" $SCRATCH_DEV >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+# Quota with user id 0 switch to quota with user id fsgqa, quota with user id 0 should
+# be release, but it can not be released because of block 6 is used by other quota.
+chown fsgqa:fsgqa $SCRATCH_MNT >> $seqres.full 2>&1
+touch $SCRATCH_MNT/foo >> $seqres.full 2>&1
+# In the process of deleting foo, will get the next block is 0 from block 6.
+# Block 0 is illegitimate, because it is the superblock of quota file.
+# It will take magic number from  block 0 as block number, and assign block number to
+# info->dqi_free_blk
+rm -f $SCRATCH_MNT/foo
+# Switch the quota, the wrong block number will be larger then INX_MAX, and it will be
+# return as a error code. Since the error code is not available, dqget() will change it
+# to a invalid address, use this address will trigger problem.
+chown fsgqa2:fsgqa2 $SCRATCH_MNT >> $seqres.full 2>&1
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/055.out b/tests/ext4/055.out
new file mode 100644
index 00000000..e806fb56
--- /dev/null
+++ b/tests/ext4/055.out
@@ -0,0 +1,2 @@
+QA output created by 055
+Silence is golden
-- 
2.13.6

