Return-Path: <SRS0=NoLx=A4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2920C433E5
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB9C20768
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 08:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgGQIh6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:37:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbgGQIh5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 Jul 2020 04:37:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B34C59D85D3CF0D2021;
        Fri, 17 Jul 2020 16:37:56 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 16:37:46 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <guaneryu@gmail.com>, Richard Weinberger <richard@nod.at>
CC:     <fstests@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH 1/2] generic: add test for race between listxattr and setxatr
Date:   Fri, 17 Jul 2020 16:44:46 +0800
Message-ID: <20200717084447.66402-2-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
In-Reply-To: <20200717084447.66402-1-houtao1@huawei.com>
References: <20200717084447.66402-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add reproducer for a bug on ubifs where listxattr() copies
the newly created xattr names regardless of the remaining
buffer size, fails the assertion of used buffer size,
and may corrupt buffer memory.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tests/generic/998     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/998.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 67 insertions(+)
 create mode 100644 tests/generic/998
 create mode 100644 tests/generic/998.out

diff --git a/tests/generic/998 b/tests/generic/998
new file mode 100644
index 00000000..b108a969
--- /dev/null
+++ b/tests/generic/998
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Huawei. All Rights Reserved.
+#
+# FS QA Test 998
+#
+# Test race between listxattr() and setxattr(). It reproduces a bug
+# on UBIFS where listxattr() copies the newly created xattr names
+# regardless of the remaining buffer size, fails the assertion of
+# used buffer size, and may corrupt buffer memory.
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
+	cd /
+	rm -f $tmp.*
+	rm -f $TEST_DIR/$seq
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/attr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_attrs
+
+target=$TEST_DIR/$seq
+touch $target
+
+# start a background listxattr
+runfile="$tmp.listxattr"
+touch $runfile
+while [ -e $runfile ]; do
+	${GETFATTR_PROG} $target >/dev/null 2>&1
+done &
+
+# add new xattr continuously
+largename=`for i in $(seq 0 128); do echo -n a; done`
+for i in $(seq 0 99); do
+	${SETFATTR_PROG} -n user.${largename}.$i -v $i $target
+done
+
+rm -f $runfile
+wait > /dev/null 2>&1
+rm -f $target
+
+echo Silence is golden
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/998.out b/tests/generic/998.out
new file mode 100644
index 00000000..d2679ae0
--- /dev/null
+++ b/tests/generic/998.out
@@ -0,0 +1,2 @@
+QA output created by 998
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index d9ab9a31..62697ac5 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -605,3 +605,4 @@
 600 auto quick quota
 601 auto quick quota
 602 auto quick encrypt
+998 auto quick attr
-- 
2.25.0.4.g0ad7144999

