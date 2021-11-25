Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA6BC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbhKYH5V (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:57:21 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17619 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348481AbhKYHzV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:55:21 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AQGKQZayKeOO8ho3ZSyF6t+crxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApG4lgzQCnGdOXjjSafeIazOhf4twaI+y/RtT6paHzNc3HQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHOekUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeaYcSnn75PCp6HBWz62qxl0N2k4JpEV4fpsKX9?=
 =?us-ascii?q?B+OZeKz0XaB2HweWsz9qGpkNE7ig4BJCzetpB5Tc7lneEZcvKiKvrG83ijeK0F?=
 =?us-ascii?q?h9t7iyWIcvjWg=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AaRBe4KoSENUrInQioHrBLu8aV5oFeYIsimQD?=
 =?us-ascii?q?101hICG9vPb5qyjk985rrCMc6QxhP03I9urwWpVoLUmzyXdV2/hoAV7AZniDhI?=
 =?us-ascii?q?LLFvAG0WPiqweQYBEWn9Q1vcxdmsNFeb7N5C9B4foSjjPYLz9b+rO6GdiT9IHj?=
 =?us-ascii?q?JitWPHtXgtpbgjuQt22gfXFLeA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890679"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id E23894D138D4
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:58 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:59 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:57 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 07/16] generic: add mmap CoW test for regular&source extents
Date:   Thu, 25 Nov 2021 15:47:43 +0800
Message-ID: <20211125074752.274176-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E23894D138D4.AF11E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode to the source file when the CoW range
covers regular unshared and regular shared blocks.
(MMAP version of generic/284,287)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/906     | 60 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/906.out | 12 +++++++++
 2 files changed, 72 insertions(+)
 create mode 100755 tests/generic/906
 create mode 100644 tests/generic/906.out

diff --git a/tests/generic/906 b/tests/generic/906
new file mode 100755
index 00000000..953348e8
--- /dev/null
+++ b/tests/generic/906
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 906
+#
+# Ensuring that copy on write in mmap mode to the source file when the
+# CoW range covers regular unshared and regular shared blocks.
+# (MMAP version of generic/284,287)
+#   - Create two files.
+#   - Reflink the odd blocks of the first file into the second file.
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
+_sweave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
diff --git a/tests/generic/906.out b/tests/generic/906.out
new file mode 100644
index 00000000..4949769b
--- /dev/null
+++ b/tests/generic/906.out
@@ -0,0 +1,12 @@
+QA output created by 906
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-906/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-906/file3
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-906/file1.chk
+mmap CoW across the transition
+Compare files
+2dc2b131303b2f70ddb480778caac8b7  SCRATCH_MNT/test-906/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-906/file3
+2dc2b131303b2f70ddb480778caac8b7  SCRATCH_MNT/test-906/file1.chk
-- 
2.34.0



