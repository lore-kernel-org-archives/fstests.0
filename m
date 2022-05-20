Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FABC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 01:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbiETBfn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 21:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344536AbiETBfm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 21:35:42 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C90D9C2FA
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 18:35:41 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AUH81oahb2pjC/uDvbPcAYGdwX161fBIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUHmzMcXDvQbP7fY2aheYt0YIq0p0kGscPdzNdlSQA5qnw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHl7ZfNlhKWKBMAxN0rVinaJ7Yw9P1rDHp?=
 =?us-ascii?q?S7tQGJz0XKBOOneS7xPS8UOYEuyiJBKEHJ6tG4jc5k26fVq1gHPj+r2zxzYcw9?=
 =?us-ascii?q?F8NagpmQZ4yv/YkVAc=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AAu4ZI6roYgVFcmIGvtDTrPEaV5rNeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj9vxG+85rrCMc6QxhIE3I9urwW5VoLUmyyXcx2/h0AV7AZniBhI?=
 =?us-ascii?q?LLFvAB0WKK+VSJcEeSmtK1l50QFJSWY+eRMbEVt6jHCXGDYrMdKce8gdyVrNab?=
 =?us-ascii?q?33FwVhtrdq0lyw94DzyQGkpwSBIuP+tCKLOsotpAuyG7eWkaKuCyBnw+VeDFoN?=
 =?us-ascii?q?HR0L38ZxpuPW9b1CC+ySOv9KXhEwWVmjMXUzZ0y78k9mTf1yzVj5/TyM2G9g?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124361783"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 May 2022 09:35:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 8EBD34D17199
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 09:35:37 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 20 May 2022 09:35:37 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 20 May 2022 09:35:37 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 20 May 2022 09:35:37 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v3 3/3] xfs: add memory failure test for partly-reflinked&dax file
Date:   Fri, 20 May 2022 09:35:34 +0800
Message-ID: <20220520013534.2894233-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
References: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8EBD34D17199.AEBA4
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
index 00000000..85ae07a1
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
+blksz=$(get_page_size)
+_pwrite_byte 0x61 0 $((blksz * nr)) $testdir/testfile >> $seqres.full
+_pwrite_byte 0x62 0 $((blksz * nr)) $testdir/poisonfile >> $seqres.full
+seq 0 2 $((nr - 1)) | while read i; do
+	_reflink_range $testdir/testfile $((blksz * i)) \
+		$testdir/poisonfile $((blksz * i)) $blksz >> $seqres.full
+done
+_scratch_cycle_mount "dax"
+
+echo "Inject memory failure (1 page)"
+$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/poisonfile
+
+echo "Inject memory failure (2 pages)"
+# poison on reflinked page and not reflinked page
+$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/poisonfile
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
+Inject poison...
+Process is killed by signal: 7
+Inject memory failure (2 pages)
+Inject poison...
+Process is killed by signal: 7
-- 
2.35.1



