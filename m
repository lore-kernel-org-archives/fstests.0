Return-Path: <SRS0=vVM5=AU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D52C433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF1D2076A
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGIJ43 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:56:29 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45168 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726630AbgGIJ42 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Jul 2020 05:56:28 -0400
X-IronPort-AV: E=Sophos;i="5.75,331,1589212800"; 
   d="scan'208";a="95982694"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Jul 2020 17:56:26 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1E10F49B1116;
        Thu,  9 Jul 2020 17:56:22 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 9 Jul 2020 17:56:22 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 9 Jul 2020 17:56:23 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v5 7/8] generic: Verify if statx() can qurey S_DAX flag on regular file correctly
Date:   Thu, 9 Jul 2020 17:49:16 +0800
Message-ID: <20200709094917.13923-8-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
References: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1E10F49B1116.A9B44
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

With new kernel(e.g. v5.8-rc1), statx() can be used to qurey S_DAX flag
on regular file, so add a test to verify the feature.

Reference:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=712b2698e4c024b561694cbcc1abba13eb0fd9ce

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/604     | 100 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/604.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 103 insertions(+)
 create mode 100644 tests/generic/604
 create mode 100644 tests/generic/604.out

diff --git a/tests/generic/604 b/tests/generic/604
new file mode 100644
index 00000000..59963dbc
--- /dev/null
+++ b/tests/generic/604
@@ -0,0 +1,100 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
+#
+# FS QA Test 604
+#
+# By the following cases, verify if statx() can query S_DAX flag
+# on regular file correctly.
+# 1) With dax=always option, FS_XFLAG_DAX is ignored and S_DAX flag
+#    always exists on regular file.
+# 2) With dax=inode option, setting/clearing FS_XFLAG_DAX can change
+#    S_DAX flag on regular file.
+# 3) With dax=never option, FS_XFLAG_DAX is ignored and S_DAX flag
+#    never exists on regular file.
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
+_supported_fs generic
+_supported_os Linux
+_require_scratch_dax_mountopt "dax=always"
+_require_dax_iflag
+_require_xfs_io_command "statx" "-r"
+
+PARENT_DIR=$SCRATCH_MNT/testdir
+TEST_FILE=$PARENT_DIR/testfile
+
+check_s_dax()
+{
+	local exp_s_dax=$1
+
+	local attributes=$($XFS_IO_PROG -c 'statx -r' $TEST_FILE | awk '/stat.attributes / { print $3 }')
+	if [ $exp_s_dax -eq 0 ]; then
+		(( attributes & 0x2000 )) && echo "$TEST_FILE has unexpected S_DAX flag"
+	else
+		(( attributes & 0x2000 )) || echo "$TEST_FILE doen't have expected S_DAX flag"
+	fi
+}
+
+test_s_dax()
+{
+	local dax_option=$1
+	local exp_s_dax1=$2
+	local exp_s_dax2=$3
+
+	# Mount with specified dax option
+	_scratch_mount "-o $dax_option"
+
+	# Prepare directory
+	mkdir -p $PARENT_DIR
+
+	rm -f $TEST_FILE
+	$XFS_IO_PROG -c "chattr +x" $PARENT_DIR
+	touch $TEST_FILE
+	# Check if setting FS_XFLAG_DAX changes S_DAX flag
+	check_s_dax $exp_s_dax1
+
+	rm -f $TEST_FILE
+	$XFS_IO_PROG -c "chattr -x" $PARENT_DIR
+	touch $TEST_FILE
+	# Check if clearing FS_XFLAG_DAX changes S_DAX flag
+	check_s_dax $exp_s_dax2
+
+	_scratch_unmount
+}
+
+do_tests()
+{
+	test_s_dax "dax=always" 1 1
+	test_s_dax "dax=inode" 1 0
+	test_s_dax "dax=never" 0 0
+}
+
+_scratch_mkfs >> $seqres.full 2>&1
+
+do_tests
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/604.out b/tests/generic/604.out
new file mode 100644
index 00000000..c06a1c7f
--- /dev/null
+++ b/tests/generic/604.out
@@ -0,0 +1,2 @@
+QA output created by 604
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 1d0d5606..676e0d2e 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -606,3 +606,4 @@
 601 auto quick quota
 602 auto quick encrypt
 603 auto attr quick dax
+604 auto attr quick dax
-- 
2.21.0



