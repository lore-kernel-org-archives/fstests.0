Return-Path: <SRS0=ffIA=DQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7200C433E7
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Oct 2020 04:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4B32223C
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Oct 2020 04:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJIEvs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Oct 2020 00:51:48 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19421 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725917AbgJIEvs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Oct 2020 00:51:48 -0400
X-IronPort-AV: E=Sophos;i="5.77,353,1596470400"; 
   d="scan'208";a="99998241"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Oct 2020 12:51:44 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 9C2CA4CE38B0;
        Fri,  9 Oct 2020 12:51:44 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 9 Oct 2020 12:51:44 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 9 Oct 2020 12:51:43 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <guaneryu@gmail.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] ext4/046: Add a test for inline_data vs. DAX inode flag
Date:   Fri, 9 Oct 2020 12:32:47 +0800
Message-ID: <20201009043248.23876-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9C2CA4CE38B0.A9FE5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Inline_data is mutually exclusive to DAX inode flag so enabling both
of them is not expected and triggers some errors.  It's a regression
test for kernel patch:
  ext4: disallow modifying DAX inode flag if inline_data has been set

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/ext4/046     | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/046.out |  2 ++
 tests/ext4/group   |  1 +
 3 files changed, 59 insertions(+)
 create mode 100755 tests/ext4/046
 create mode 100644 tests/ext4/046.out

diff --git a/tests/ext4/046 b/tests/ext4/046
new file mode 100755
index 00000000..f72b1cdb
--- /dev/null
+++ b/tests/ext4/046
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
+#
+# FS QA Test 046
+#
+# This is a regression test for kernel patch:
+#   ext4: disallow modifying DAX inode flag if inline_data has been set
+
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
+_require_scratch_dax_mountopt "dax=always"
+_require_dax_iflag
+_require_scratch_ext4_feature "inline_data"
+
+TESTFILE=$SCRATCH_MNT/testfile
+
+_scratch_mkfs_ext4 -O inline_data > $seqres.full 2>&1
+
+_scratch_mount "-o dax=inode" >> $seqres.full 2>&1
+
+echo "Need to make some inline data..." > $TESTFILE
+
+# It's fine to disallow modifying DAX inode flag on the file which
+# has inline_data flag.
+if $XFS_IO_PROG -c "chattr +x" $TESTFILE >> $seqres.full 2>&1; then
+	_scratch_cycle_mount "dax=inode"
+	echo 'Append data' >> $TESTFILE
+fi
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/ext4/046.out b/tests/ext4/046.out
new file mode 100644
index 00000000..52c445eb
--- /dev/null
+++ b/tests/ext4/046.out
@@ -0,0 +1,2 @@
+QA output created by 046
+Silence is golden
diff --git a/tests/ext4/group b/tests/ext4/group
index 40351fd9..9a51b246 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -48,6 +48,7 @@
 043 auto quick
 044 auto quick
 045 auto dir
+046 auto quick dax
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.25.1



