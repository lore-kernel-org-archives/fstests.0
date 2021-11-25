Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63BAC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbhKYH7K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:59:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17619 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243442AbhKYH5W (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:57:22 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A9ilqJ661n3ll57OGi4nuhAxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0DAAzWtKXj+BPP2OZmqmLtFyb4W+8UoEvZ/dzNRkSFY5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+OmVba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCfv4JTNnxaun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpsm8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AohvOB65q9ofXVn3mmQPXwObXdLJyesId70hD?=
 =?us-ascii?q?6qm+c3xomofyrbHWoB17726StN9/YgBDpTntAse9qFLnhOZICOoqTNOftWvdyQ?=
 =?us-ascii?q?6VxIAL1/qY/9SIIUSXndK1vp0QEJSWf+edMbEVt6fHCXODeerIuOP3lpxA2d2u?=
 =?us-ascii?q?tUuFNjsGV0nchD0XNjqm?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890683"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id BA42E4D138C8
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:57 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:56 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:56 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 03/16] generic: add mmap CoW test for unwritten&destination extents
Date:   Thu, 25 Nov 2021 15:47:39 +0800
Message-ID: <20211125074752.274176-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: BA42E4D138C8.A058B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents, some unwritten, some not.
(MMAP version of generic/189,188)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/902     | 59 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/902.out | 12 +++++++++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/generic/902
 create mode 100644 tests/generic/902.out

diff --git a/tests/generic/902 b/tests/generic/902
new file mode 100755
index 00000000..457b039a
--- /dev/null
+++ b/tests/generic/902
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 902
+#
+# Ensuring that copy on write in mmap mode works when the CoW
+# range originally covers multiple extents, some unwritten, some not.
+# (MMAP version of generic/189,188)
+#   - Create a file and fallocate a second file.
+#   - Reflink the odd blocks of the first file into the second file.
+#   - mmap CoW across the halfway mark, starting with the unwritten extent.
+#   - Check that the files are now different where we say they're different.
+#
+. ./common/preamble
+_begin_fstest auto quick clone
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_require_scratch_reflink
+_require_xfs_io_command "falloc"
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+echo "Create the original files"
+blksz=65536
+nr=64
+filesize=$((blksz * nr))
+_weave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file3.chk | _filter_scratch
+
+echo "mmap CoW across the transition"
+cowoff=$((filesize / 4))
+cowsz=$((filesize / 2))
+mmapsz=$((cowoff + cowsz))
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3 >> $seqres.full
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file3.chk | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/902.out b/tests/generic/902.out
new file mode 100644
index 00000000..bc951255
--- /dev/null
+++ b/tests/generic/902.out
@@ -0,0 +1,12 @@
+QA output created by 902
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-902/file1
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-902/file3
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-902/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-902/file1
+09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-902/file3
+09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-902/file3.chk
-- 
2.34.0



