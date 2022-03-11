Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131DBC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Mar 2022 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiCKPTu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiCKPTu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Mar 2022 10:19:50 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 669AA1B01A0
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 07:18:45 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3Atz2/KK7cQpHe7OKkPrtXTAxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0zRWmjEYWW7Taf+DMzagfdBwbIy+o0MO7cLTy9c3SVA5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyLi7JbMlBOun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpwm8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AJi83Xqqc4nT4Owz0FSF5kPQaV5rPeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj+fxG+85rsyMc6QxhIU3I9urhBEDtex/hHNtOkOws1NSZLW7bUQ?=
 =?us-ascii?q?mTXeJfBOLZqlWKcUDDH6xmpMNdmsNFaeEYY2IUsS+D2njbLz8/+qj7zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2fqYRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2fSIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl92ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122552736"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Mar 2022 23:18:25 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1B72C4D16FD3
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 23:18:20 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 11 Mar 2022 23:18:19 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 11 Mar 2022 23:18:19 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH 3/3] xfs: add memory failure test for partly-reflinked&dax file
Date:   Fri, 11 Mar 2022 23:18:16 +0800
Message-ID: <20220311151816.2174870-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
References: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1B72C4D16FD3.AD7CA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Verify that dax-rmap works for both normal extent and shared extent.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/xfs/902     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/902.out |  9 ++++++++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/xfs/902
 create mode 100644 tests/xfs/902.out

diff --git a/tests/xfs/902 b/tests/xfs/902
new file mode 100755
index 00000000..291d34fd
--- /dev/null
+++ b/tests/xfs/902
@@ -0,0 +1,52 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 902
+#
+# Test memory failure mechanism when dax and reflink working together
+#   test for partly reflinked file
+#
+. ./common/preamble
+_begin_fstest auto quick clone dax
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_require_check_dmesg
+_require_scratch_reflink
+_require_xfs_scratch_rmapbt
+_require_scratch_dax_mountopt "dax"
+_require_test_program "t_mmap_cow_memory_failure"
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount "-o dax" >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+echo "Create the original files"
+nr=16
+blksz=4096
+_pwrite_byte 0x61 0 $((blksz * nr)) $testdir/testfile >> $seqres.full
+_pwrite_byte 0x62 0 $((blksz * nr)) $testdir/posionfile >> $seqres.full
+seq 0 2 $((nr - 1)) | while read i; do
+	_reflink_range $testdir/testfile $((blksz * i)) \
+		$testdir/posionfile $((blksz * i)) $blksz >> $seqres.full
+done
+_scratch_cycle_mount "dax"
+
+echo "Inject memory failure (1 page)"
+$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/posionfile
+
+echo "Inject memory failure (2 pages)"
+# posion on reflinked page and not reflinked page
+$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/posionfile
+
+_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
+_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
+
+# success, all done
+status=0
diff --git a/tests/xfs/902.out b/tests/xfs/902.out
new file mode 100644
index 00000000..3c055d54
--- /dev/null
+++ b/tests/xfs/902.out
@@ -0,0 +1,9 @@
+QA output created by 902
+Format and mount
+Create the original files
+Inject memory failure (1 page)
+Inject posion...
+Process is killed by signal: 7
+Inject memory failure (2 pages)
+Inject posion...
+Process is killed by signal: 7
-- 
2.35.1



