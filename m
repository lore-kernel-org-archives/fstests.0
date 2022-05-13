Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A5C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 13 May 2022 03:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiEMDOY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 23:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376688AbiEMDOU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 23:14:20 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB4CF28FE87
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 20:14:17 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AzrR3Z67CtbmsALd/hp92EwxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS12AEyTBMCzrSPP2IZ2OnKNt+boTkpk5QuZTXmNcxQAE5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyTl6ZfOlB2un3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpkm8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AU+EOIqwITdi+zr57easPKrPwyr1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SK2lfqeV7Y0mPH7P+U4ssR4b6LO90cW7Lk80sKQFhbX5Xo3SOjUO2l?=
 =?us-ascii?q?HYTr2KhLGKq1aLdkHDH6xmpMBdmsNFaOEYY2IVsS+D2njcLz8/+qj6zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2f6YRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2eiIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl96ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124203538"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 May 2022 11:14:17 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id E82BC4D17199
        for <fstests@vger.kernel.org>; Fri, 13 May 2022 11:14:14 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 13 May 2022 11:14:15 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 13 May 2022 11:14:15 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 13 May 2022 11:14:12 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH 2/3] xfs: add memory failure test for dax&reflink mode
Date:   Fri, 13 May 2022 11:14:10 +0800
Message-ID: <20220513031411.2369314-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513031411.2369314-1-ruansy.fnst@fujitsu.com>
References: <20220513031411.2369314-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E82BC4D17199.ADD5F
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
index 00000000..26c1581e
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
+_cp_reflink $testdir/testfile $testdir/poisonfile >> $seqres.full
+_scratch_cycle_mount "dax"
+
+echo "Inject memory failure (1 page)"
+# create two processes:
+#  process1: mread 1 page to cause page fault, and wait
+#  process2: mread 1 page to cause page fault, then inject poison on this page
+$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/poisonfile
+
+echo "Inject memory failure (2 pages)"
+$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/poisonfile
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



