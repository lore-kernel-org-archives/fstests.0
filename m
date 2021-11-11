Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B8C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E829361267
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhKKIyC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:02 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34979 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229543AbhKKIyC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:02 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AAdOukq4FDnnuUwmWL1luIwxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0WEEnGYdXzzXaPeLMzTxKNh0bN/n8hgHvcODytBjQAM5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+OlULa?=
 =?us-ascii?q?ZUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCfl6JDLlhaun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpom8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyDeAlqyppkXre0/OvHqpKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214013"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:12 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id AFA004D10A13
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:10 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:10 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:09 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 02/13] generic: add mmap CoW test for regular&destination extents
Date:   Thu, 11 Nov 2021 16:50:55 +0800
Message-ID: <20211111085106.937684-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
References: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: AFA004D10A13.AE10E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents, some regular, some not.
(MMAP version of generic/197,196)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/910     | 59 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/910.out | 12 +++++++++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/generic/910
 create mode 100644 tests/generic/910.out

diff --git a/tests/generic/910 b/tests/generic/910
new file mode 100755
index 00000000..4fef8e18
--- /dev/null
+++ b/tests/generic/910
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# Ensuring that copy on write in mmap mode works when the CoW
+# range originally covers multiple extents, some regular, some not.
+# (MMAP version of generic/197,196)
+#   - Create two files.
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
+_weave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
diff --git a/tests/generic/910.out b/tests/generic/910.out
new file mode 100644
index 00000000..e3933a4b
--- /dev/null
+++ b/tests/generic/910.out
@@ -0,0 +1,12 @@
+QA output created by 910
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-910/file1
+d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-910/file3
+d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-910/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-910/file1
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-910/file3
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-910/file3.chk
-- 
2.33.0



