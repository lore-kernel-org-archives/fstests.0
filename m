Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFDC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Mar 2022 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiCKPTs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiCKPTr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Mar 2022 10:19:47 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13F2E1AF8E3
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 07:18:43 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AXRad16PJW7MRL8XvrR25lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQG80zl01GNUxmRJCGzXaaveNjP1fd4lb9i09h8CvsOAm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yEmjfjQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPccpeKdfiPi2SCU5wicG5f2+N1gF107JpED0vh4DHs?=
 =?us-ascii?q?I9vECLj0JKBeZiIqLLBiTIgV3rp17apC1Y8VE4Tc9pQw1xM0OGfjrK5gmL/cCt?=
 =?us-ascii?q?Nvouv1zIA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ak1z6rau+CQyuP7i9xtByYMEk7skDktV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxra6TdZMgpHnJYVcqKQgdcL+7WJVoLUmxyXcx2/h1AV7AZniAhI?=
 =?us-ascii?q?LLFvAA0WKK+VSJcEeSygce79YFT0EUMrzN5DZB4voSmDPIcerI3uP3jZyAtKPP?=
 =?us-ascii?q?yWt3VwF2Z+VF5wd9MAySFUp7X2B9dOEEPavZ9sxavCChZHhSSsy6A0MOV+/Fq8?=
 =?us-ascii?q?aOu4nhZXc9dmQawTjLnTW186T7DhTd+h8fVglEybAk/XOAsyGR3NTaj82G?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122552735"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Mar 2022 23:18:25 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id C3E304D16FD1
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 23:18:19 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 11 Mar 2022 23:18:21 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 11 Mar 2022 23:18:18 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH 2/3] xfs: add memory failure test for dax&reflink mode
Date:   Fri, 11 Mar 2022 23:18:15 +0800
Message-ID: <20220311151816.2174870-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
References: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C3E304D16FD1.A0745
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Verify that the dax-rmap feature works.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/xfs/901     | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/901.out |  9 +++++++++
 2 files changed, 58 insertions(+)
 create mode 100755 tests/xfs/901
 create mode 100644 tests/xfs/901.out

diff --git a/tests/xfs/901 b/tests/xfs/901
new file mode 100755
index 00000000..a94a0c06
--- /dev/null
+++ b/tests/xfs/901
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 901
+#
+# Test memory failure mechanism when dax and reflink working together
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
+_require_cp_reflink
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
+filesize=65536
+_pwrite_byte 0x61 0 $filesize $testdir/testfile >> $seqres.full
+_cp_reflink $testdir/testfile $testdir/posionfile >> $seqres.full
+_scratch_cycle_mount "dax"
+
+echo "Inject memory failure (1 page)"
+# create two processes:
+#  process1: mread 4k to cause page fault, and wait
+#  process2: mread 4k to cause page fault, then inject posion on this 4k page
+$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/posionfile
+
+echo "Inject memory failure (2 pages)"
+$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/posionfile
+
+_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
+_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
+
+# success, all done
+status=0
diff --git a/tests/xfs/901.out b/tests/xfs/901.out
new file mode 100644
index 00000000..92d64846
--- /dev/null
+++ b/tests/xfs/901.out
@@ -0,0 +1,9 @@
+QA output created by 901
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



