Return-Path: <SRS0=C+DF=BN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4281EC433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 08:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E6120678
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 08:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHCIqX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:46:23 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44092 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbgHCIqX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2020 04:46:23 -0400
X-IronPort-AV: E=Sophos;i="5.75,429,1589212800"; 
   d="scan'208";a="97500115"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Aug 2020 16:46:07 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 5F13F4CE5468;
        Mon,  3 Aug 2020 16:46:06 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 3 Aug 2020 16:46:09 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 3 Aug 2020 16:46:09 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>,
        <ira.weiny@intel.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v8 6/7] generic: Verify if statx() can qurey S_DAX flag on regular file correctly
Date:   Mon, 3 Aug 2020 16:38:37 +0800
Message-ID: <20200803083838.26222-7-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
References: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5F13F4CE5468.AAE05
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) With new kernel(e.g. v5.8-rc1), statx() can be used to qurey S_DAX flag
   on regular file, so add a test to verify the feature.
2) Factor out _check_s_dax() so that other tests can use it in future.

Reference:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=712b2698e4c024b561694cbcc1abba13eb0fd9ce

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/rc             | 13 +++++++
 tests/generic/606     | 88 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/606.out |  2 +
 tests/generic/group   |  1 +
 4 files changed, 104 insertions(+)
 create mode 100644 tests/generic/606
 create mode 100644 tests/generic/606.out

diff --git a/common/rc b/common/rc
index 75b20f96..a358702e 100644
--- a/common/rc
+++ b/common/rc
@@ -3196,6 +3196,19 @@ _require_scratch_shutdown()
 	_scratch_unmount
 }
 
+_check_s_dax()
+{
+	local target=$1
+	local exp_s_dax=$2
+
+	local attributes=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
+	if [ $exp_s_dax -eq 0 ]; then
+		(( attributes & 0x2000 )) && echo "$target has unexpected S_DAX flag"
+	else
+		(( attributes & 0x2000 )) || echo "$target doen't have expected S_DAX flag"
+	fi
+}
+
 # Only accept dax/dax=always mount option becasue dax=always, dax=inode
 # and dax=never are always introduced together.
 # Return 0 if filesystem/device supports the specified dax option.
diff --git a/tests/generic/606 b/tests/generic/606
new file mode 100644
index 00000000..6257ab6c
--- /dev/null
+++ b/tests/generic/606
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
+#
+# FS QA Test 606
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
+	_check_s_dax $TEST_FILE $exp_s_dax1
+
+	rm -f $TEST_FILE
+	$XFS_IO_PROG -c "chattr -x" $PARENT_DIR
+	touch $TEST_FILE
+	# Check if clearing FS_XFLAG_DAX changes S_DAX flag
+	_check_s_dax $TEST_FILE $exp_s_dax2
+
+	_scratch_unmount
+}
+
+do_tests()
+{
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	test_s_dax "dax=always" 1 1
+	test_s_dax "dax=inode" 1 0
+	test_s_dax "dax=never" 0 0
+}
+
+do_tests
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/606.out b/tests/generic/606.out
new file mode 100644
index 00000000..09bf888e
--- /dev/null
+++ b/tests/generic/606.out
@@ -0,0 +1,2 @@
+QA output created by 606
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index d06c1bf6..05c6b02d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -608,3 +608,4 @@
 603 auto quick quota
 604 auto quick mount
 605 auto attr quick dax
+606 auto attr quick dax
-- 
2.21.0



