Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D85C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 08:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhLNITc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 03:19:32 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23835 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231815AbhLNITc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 03:19:32 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ArRS7YagkHvtso+9Q6NImmhoEX161fBIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUPmmBOX2yDP/7YYmrzfY8gbNjk80tQuJHdx4A3HgRurXw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOOlUre?=
 =?us-ascii?q?YYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHm4ZzMnxGWKRMAxN0rVinaJ7Yw9P1rDHp?=
 =?us-ascii?q?S7tQGJz0XKBOOneS7xPS8UOYEuyiJBKEHJ6tG4jc5k26fVq1gHPj+r2zxzYcw9?=
 =?us-ascii?q?F8NagpmQJ4yv/YkVAc=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AsDKEGKtNeLmy3M/XuWRM+VJ97skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118878482"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 16:19:27 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id F03E04D144C2
        for <fstests@vger.kernel.org>; Tue, 14 Dec 2021 16:19:21 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:23 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:21 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 16:19:20 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v3 11/17] generic: add mmap CoW test for delalloc&source extents
Date:   Tue, 14 Dec 2021 16:19:08 +0800
Message-ID: <20211214081914.2478122-12-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: F03E04D144C2.A16C1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode to the source file when the CoW range
covers delalloc blocks and regular shared blocks.
(MMAP version of generic/293,295)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/909     | 65 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/909.out | 12 ++++++++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/generic/909
 create mode 100644 tests/generic/909.out

diff --git a/tests/generic/909 b/tests/generic/909
new file mode 100755
index 00000000..88e032b6
--- /dev/null
+++ b/tests/generic/909
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 909
+#
+# Ensuring that copy on write in mmap mode to the source file when the
+# CoW range covers delalloc blocks and regular shared blocks.
+# (MMAP version of generic/293,295)
+#   - Create two files.
+#   - Truncate the first file.
+#   - Write the odd blocks of the first file.
+#   - Reflink the odd blocks of the first file into the second file.
+#   - Write the even blocks of the first file.
+#   - mmap CoW the first file across the halfway mark, starting with the
+#     regular extent.
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
+_require_scratch_delalloc
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
+_sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file1.chk | _filter_scratch
+
+echo "mmap CoW across the transition"
+cowoff=$((filesize / 4))
+cowsz=$((filesize / 2))
+_sweave_reflink_holes_delalloc $blksz $nr $testdir/file1 >> $seqres.full
+mmapsz=$((cowoff + cowsz))
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1 >> $seqres.full
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file1.chk | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/909.out b/tests/generic/909.out
new file mode 100644
index 00000000..4f9a5d33
--- /dev/null
+++ b/tests/generic/909.out
@@ -0,0 +1,12 @@
+QA output created by 909
+Format and mount
+Create the original files
+Compare files
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-909/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-909/file3
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-909/file1.chk
+mmap CoW across the transition
+Compare files
+35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-909/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-909/file3
+35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-909/file1.chk
-- 
2.34.1



