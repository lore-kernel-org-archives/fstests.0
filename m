Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCADFC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbhKYH5I (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:57:08 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27293 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhKYHzH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:55:07 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J097X5Qjbzbj5p
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:51:52 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 15:51:55 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 25 Nov
 2021 15:51:54 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <sunke32@huawei.com>
Subject: [PATCH] ext4: test for illegal memory access caused by quota index information error
Date:   Thu, 25 Nov 2021 16:00:36 +0800
Message-ID: <20211125080036.2211159-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
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
 tests/ext4/054     | 36 ++++++++++++++++++++++++++++++++++++
 tests/ext4/054.out |  1 +
 2 files changed, 37 insertions(+)
 create mode 100755 tests/ext4/054
 create mode 100644 tests/ext4/054.out

diff --git a/tests/ext4/054 b/tests/ext4/054
new file mode 100755
index 00000000..286b5ecb
--- /dev/null
+++ b/tests/ext4/054
@@ -0,0 +1,36 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Huawei.  All Rights Reserved.
+#
+# FS QA Test 054
+#
+# Regression test for kernel
+# commit 9bf3d2033129 quota: check block number when reading the block in quota file
+# commit d0e36a62bd4c quota: correct error number in free_dqentry()
+#
+# The test is based on a testcase from Zhang Yi <yi.zhang@huawei.com>.
+#
+. ./common/preamble
+_begin_fstest auto
+
+# real QA test starts here
+
+# Modify as appropriate.
+_require_scratch
+_supported_fs ext4
+_require_user fsgqa
+_require_user fsgqa2
+
+_scratch_mkfs "-F -O quota -b 1024" > $seqres.full 2>&1
+debugfs -w -R "zap_block -o 0 -l 1 -p 6 -f <3> 1" $SCRATCH_DEV >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+chown fsgqa:fsgqa $SCRATCH_MNT >> $seqres.full 2>&1
+touch $SCRATCH_MNT/foo >> $seqres.full 2>&1
+rm -f $SCRATCH_MNT/foo
+chown fsgqa2:fsgqa2 $SCRATCH_MNT >> $seqres.full 2>&1
+
+umount $SCRATCH_MNT
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/054.out b/tests/ext4/054.out
new file mode 100644
index 00000000..03e258bb
--- /dev/null
+++ b/tests/ext4/054.out
@@ -0,0 +1 @@
+QA output created by 054
-- 
2.13.6

