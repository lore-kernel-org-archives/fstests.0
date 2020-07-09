Return-Path: <SRS0=vVM5=AU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E4CC433E1
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3292076A
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGIJ43 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:56:29 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45172 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726766AbgGIJ43 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Jul 2020 05:56:29 -0400
X-IronPort-AV: E=Sophos;i="5.75,331,1589212800"; 
   d="scan'208";a="95982693"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Jul 2020 17:56:26 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 010C64CE5057;
        Thu,  9 Jul 2020 17:56:23 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 9 Jul 2020 17:56:24 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 9 Jul 2020 17:56:24 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v5 8/8] generic: Verify the inheritance behavior of FS_XFLAG_DAX flag in various combinations
Date:   Thu, 9 Jul 2020 17:49:17 +0800
Message-ID: <20200709094917.13923-9-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
References: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 010C64CE5057.AECF0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---

V1->V5:
Run test with more mount options(i.e. without dax option and with old
dax option).

 tests/generic/605     | 199 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/605.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 202 insertions(+)
 create mode 100644 tests/generic/605
 create mode 100644 tests/generic/605.out

diff --git a/tests/generic/605 b/tests/generic/605
new file mode 100644
index 00000000..6924223a
--- /dev/null
+++ b/tests/generic/605
@@ -0,0 +1,199 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
+#
+# FS QA Test 605
+#
+# Verify the inheritance behavior of FS_XFLAG_DAX flag in various combinations.
+# 1) New files and directories automatically inherit FS_XFLAG_DAX from their parent directory.
+# 2) cp operation make files and directories inherit the FS_XFLAG_DAX from new parent directory.
+# 3) mv operation make files and directories preserve the FS_XFLAG_DAX from old parent directory.
+# In addition, setting/clearing FS_XFLAG_DAX flag is not impacted by dax mount options.
+
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
+_require_scratch
+_require_dax_iflag
+_require_xfs_io_command "lsattr" "-v"
+
+check_xflag()
+{
+	local target=$1
+	local exp_xflag=$2
+
+	if [ $exp_xflag -eq 0 ]; then
+		_test_inode_flag dax $target && echo "$target has unexpected FS_XFLAG_DAX flag"
+	else
+		_test_inode_flag dax $target || echo "$target doen't have expected FS_XFLAG_DAX flag"
+	fi
+}
+
+test_xflag_inheritance1()
+{
+	mkdir -p a
+	$XFS_IO_PROG -c "chattr +x" a
+	mkdir -p a/b/c
+	touch a/b/c/d
+
+	check_xflag a 1
+	check_xflag a/b 1
+	check_xflag a/b/c 1
+	check_xflag a/b/c/d 1
+
+	rm -rf a
+}
+
+test_xflag_inheritance2()
+{
+	mkdir -p a/b
+	$XFS_IO_PROG -c "chattr +x" a
+	mkdir -p a/b/c a/d
+	touch a/b/c/e a/d/f
+
+	check_xflag a 1
+	check_xflag a/b 0
+	check_xflag a/b/c 0
+	check_xflag a/b/c/e 0
+	check_xflag a/d 1
+	check_xflag a/d/f 1
+
+	rm -rf a
+}
+
+test_xflag_inheritance3()
+{
+	mkdir -p a/b
+	$XFS_IO_PROG -c "chattr +x" a/b
+	mkdir -p a/b/c a/d
+	touch a/b/c/e a/d/f
+
+	check_xflag a 0
+	check_xflag a/b 1
+	check_xflag a/b/c 1
+	check_xflag a/b/c/e 1
+	check_xflag a/d 0
+	check_xflag a/d/f 0
+
+	rm -rf a
+}
+
+test_xflag_inheritance4()
+{
+	mkdir -p a
+	$XFS_IO_PROG -c "chattr +x" a
+	mkdir -p a/b/c
+	$XFS_IO_PROG -c "chattr -x" a/b
+	mkdir -p a/b/c/d a/b/e
+	touch a/b/c/d/f a/b/e/g
+
+	check_xflag a 1
+	check_xflag a/b 0
+	check_xflag a/b/c 1
+	check_xflag a/b/c/d 1
+	check_xflag a/b/c/d/f 1
+	check_xflag a/b/e 0
+	check_xflag a/b/e/g 0
+
+	rm -rf a
+}
+
+test_xflag_inheritance5()
+{
+	mkdir -p a b
+	$XFS_IO_PROG -c "chattr +x" a
+	mkdir -p a/c a/d b/e b/f
+	touch a/g b/h
+
+	cp -r a/c b/
+	cp -r b/e a/
+	cp -r a/g b/
+	mv a/d b/
+	mv b/f a/
+	mv b/h a/
+
+	check_xflag b/c 0
+	check_xflag b/d 1
+	check_xflag a/e 1
+	check_xflag a/f 0
+	check_xflag b/g 0
+	check_xflag a/h 0
+
+	rm -rf a b
+}
+
+do_xflag_tests()
+{
+	local option=$1
+
+	_scratch_mount "$option"
+	cd $SCRATCH_MNT
+
+	for i in $(seq 1 5); do
+		test_xflag_inheritance${i}
+	done
+
+	cd - > /dev/null
+	_scratch_unmount
+}
+
+check_dax_mountopt()
+{
+	local option=$1
+	local ret=0
+
+	_try_scratch_mount "-o $option" >> $seqres.full 2>&1 || return 1
+
+	# Match option name exactly
+	_fs_options $SCRATCH_DEV | egrep -q "$option(,|$)" || ret=1
+
+	_scratch_unmount
+
+	return $ret
+}
+
+do_tests()
+{
+	# Mount without dax option
+	do_xflag_tests
+
+	# Mount with old dax option if fs only supports it.
+	check_dax_mountopt "dax" && do_xflag_tests "-o dax"
+
+	# Mount with new dax options if fs supports them.
+	if check_dax_mountopt "dax=always"; then
+		for dax_option in "dax=always" "dax=inode" "dax=never"; do
+			do_xflag_tests "-o $dax_option"
+		done
+	fi
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
diff --git a/tests/generic/605.out b/tests/generic/605.out
new file mode 100644
index 00000000..1ae20049
--- /dev/null
+++ b/tests/generic/605.out
@@ -0,0 +1,2 @@
+QA output created by 605
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 676e0d2e..a8451862 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -607,3 +607,4 @@
 602 auto quick encrypt
 603 auto attr quick dax
 604 auto attr quick dax
+605 auto attr quick dax
-- 
2.21.0



