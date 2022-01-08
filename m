Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E1AC433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  8 Jan 2022 02:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiAHCXy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jan 2022 21:23:54 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30262 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiAHCXx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jan 2022 21:23:53 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JW3m34wy1zbjtW;
        Sat,  8 Jan 2022 10:23:15 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 8 Jan 2022 10:23:51 +0800
Received: from huawei.com (10.67.174.154) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 8 Jan
 2022 10:23:51 +0800
From:   Chen Long <chenlongcl.chen@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <richard@nod.at>, <chenlongcl.chen@huawei.com>
Subject: [PATCH] ubifs: add test for race between listxattr and setxatr
Date:   Sat, 8 Jan 2022 10:24:31 +0800
Message-ID: <20220108022431.71751-1-chenlongcl.chen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.154]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add reproducer for a bug on ubifs where listxattr() copies
the newly created xattr names regardless of the remaining
buffer size, fails the assertion of used buffer size, and
may corrupt buffer memory.

This is a regression test for three kernel commit:
1. f4e3634a3b642 (ubifs: Fix races between xattr_{set|get} and
	listxattr operations)
2. 819f9ab430a44 (ubifs: Remove ui_mutex in ubifs_xattr_get and
	change_xattr)

Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
---
 tests/ubifs/001      | 54 ++++++++++++++++++++++++++++++++++++++++++++
 tests/ubifs/001.out  |  2 ++
 tests/ubifs/Makefile | 24 ++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100755 tests/ubifs/001
 create mode 100644 tests/ubifs/001.out
 create mode 100644 tests/ubifs/Makefile

diff --git a/tests/ubifs/001 b/tests/ubifs/001
new file mode 100755
index 00000000..1e9a4de2
--- /dev/null
+++ b/tests/ubifs/001
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Huawei.  All Rights Reserved.
+#
+# FS QA Test 001
+#
+# Regression test for kernel commit:
+# 1. f4e3634a3b642 (ubifs: Fix races between xattr_{set|get} and
+#	listxattr operations)
+# 2. 819f9ab430a44 (ubifs: Remove ui_mutex in ubifs_xattr_get and
+#	change_xattr)
+#
+. ./common/preamble
+_begin_fstest auto quick attr
+
+_cleanup()
+{
+    cd /
+    rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs ubifs
+_require_test
+_require_attrs
+
+target=$TEST_DIR/$seq
+touch $target
+
+# start a background listxattr
+runfile="$tmp.listxattr"
+touch $runfile
+while [ -e $runfile ]; do
+    ${GETFATTR_PROG} $target >/dev/null 2>&1
+done &
+
+# add new xattr continuously
+largename=`for i in $(seq 0 128); do echo -n a; done`
+for i in $(seq 0 99); do
+    ${SETFATTR_PROG} -n user.${largename}.$i -v $i $target
+done
+
+rm -f $runfile
+wait > /dev/null 2>&1
+rm -f $target
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/ubifs/001.out b/tests/ubifs/001.out
new file mode 100644
index 00000000..88678b8e
--- /dev/null
+++ b/tests/ubifs/001.out
@@ -0,0 +1,2 @@
+QA output created by 001
+Silence is golden
diff --git a/tests/ubifs/Makefile b/tests/ubifs/Makefile
new file mode 100644
index 00000000..b464b22b
--- /dev/null
+++ b/tests/ubifs/Makefile
@@ -0,0 +1,24 @@
+#
+# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+include $(TOPDIR)/include/buildgrouplist
+
+GENERIC_DIR = generic
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GENERIC_DIR)
+DIRT = group.list
+
+default: $(DIRT)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group.list $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
-- 
2.17.1

