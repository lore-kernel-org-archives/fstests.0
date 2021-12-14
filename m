Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A029DC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 08:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhLNITb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 03:19:31 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47274 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231795AbhLNITa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 03:19:30 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AtMlKVazTUL+qHIEaWuh6t+crxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApGsh0mEFymcbUGyDaazZNzfxfIggPNy+8k5XscTUzNJiHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmjPjSH+akUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeaXcSfv7ZPCp6HBWz62qxl0N2k4JpEV4fpsKX9?=
 =?us-ascii?q?B+OZeKz0XaB2HweWsz9qGpkNE7ig4BJCzetpB5Tc7lneEZcvKiKvrG83ijeK0F?=
 =?us-ascii?q?h9q7iyWIcvjWg=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ASshaAaGyuYfcSXscpLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118878479"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 16:19:27 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 6BF6D4D144C4
        for <fstests@vger.kernel.org>; Tue, 14 Dec 2021 16:19:22 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:21 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 16:19:20 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v3 13/17] generic: add direct-io CoW test for mixed&source extents
Date:   Tue, 14 Dec 2021 16:19:10 +0800
Message-ID: <20211214081914.2478122-14-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 6BF6D4D144C4.A2B0F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in direct-io mode works when the CoW
range originally covers multiple extents, mixed with reflinked, unwritten,
hole, regular and delalloc blocks.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/911     | 66 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/911.out | 12 ++++++++
 2 files changed, 78 insertions(+)
 create mode 100755 tests/generic/911
 create mode 100644 tests/generic/911.out

diff --git a/tests/generic/911 b/tests/generic/911
new file mode 100755
index 00000000..01baa49a
--- /dev/null
+++ b/tests/generic/911
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 911
+#
+# Ensuring that copy on write in direct-io mode works when the CoW
+# range originally covers multiple extents, mixed with reflinked, unwritten,
+# hole, regular and delalloc blocks.
+#   - Create a file with the following repeating sequence of blocks:
+#     1. reflinked
+#     2. unwritten
+#     3. hole
+#     4. regular block
+#     5. delalloc
+#   - directio CoW across the halfway mark, starting with the unwritten extent.
+#   - Check that the files are now different where we say they're different.
+#
+. ./common/preamble
+_begin_fstest auto quick clone punch
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_require_scratch_reflink
+_require_scratch_delalloc
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "fpunch"
+_require_odirect
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
+_sweave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file1.chk | _filter_scratch
+
+echo "directio CoW across the transition"
+cowoff=$((filesize / 4))
+cowsz=$((filesize / 2))
+_sweave_reflink_rainbow_delalloc $blksz $nr $testdir/file1 >> $seqres.full
+# now cow
+$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
+_pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file1.chk | _filter_scratch
+
+# success, all done
+status=0
diff --git a/tests/generic/911.out b/tests/generic/911.out
new file mode 100644
index 00000000..e098fe3c
--- /dev/null
+++ b/tests/generic/911.out
@@ -0,0 +1,12 @@
+QA output created by 911
+Format and mount
+Create the original files
+Compare files
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-911/file1
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-911/file3
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-911/file1.chk
+directio CoW across the transition
+Compare files
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-911/file1
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-911/file3
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-911/file1.chk
-- 
2.34.1



