Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED41C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbhKYH5W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:57:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61265 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348426AbhKYHzV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:55:21 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AJ7pd+6yos3RtixNay5V6t+crxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApGgg0WYFzWMaWG+OP/mMYGqnL9B+bYW290oPuZaGndIwHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHOekUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeaYcSnn75PMp6HBWz62qxl0N2k4JpEV4fpsKX9?=
 =?us-ascii?q?B+OZeKz0XaB2HweWsz9qGpkNE7ig4BJCzetpB5Tc7lneEZcvKiKvrG83ijeK0F?=
 =?us-ascii?q?h9q7iyWIcvjWg=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AL/zcI6AinysoHwPlHemC55DYdb4zR+YMi2TD?=
 =?us-ascii?q?GXoQdfQfGfbo7vxG/c5rsiMc5wxhOk3I9ervBECgewKlyXcX2/h0AV7BZniChI?=
 =?us-ascii?q?OoRLsSlrcKqgeIc0bDH4VmpMRdmt9FZOEYY2IasS+B2mOF+q4bsb+6GfyT9J3j?=
 =?us-ascii?q?JgxWID2D1spbgDtENg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890677"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id C83844D138D3
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:58 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:59 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:57 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 06/16] generic: add mmap CoW test for mixed&destination extents
Date:   Thu, 25 Nov 2021 15:47:42 +0800
Message-ID: <20211125074752.274176-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C83844D138D3.A06B0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents, mixed with reflinked, unwritten, hole, regular and
delalloc blocks.
(MMAP version of generic/200,199)

Also, add a check to make sure the delalloc block is accutally exist.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 common/reflink        |  3 ++
 tests/generic/905     | 68 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/905.out | 12 ++++++++
 3 files changed, 83 insertions(+)
 create mode 100755 tests/generic/905
 create mode 100644 tests/generic/905.out

diff --git a/common/reflink b/common/reflink
index 38210673..84173d59 100644
--- a/common/reflink
+++ b/common/reflink
@@ -362,6 +362,9 @@ _weave_reflink_rainbow_delalloc() {
 		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile
 		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile.chk
 	done
+	# make sure we actually got delalloc block
+	$FILEFRAG_PROG -v $dfile 2>&1 | grep -q delalloc || \
+		_notrun "test requires delayed allocation writes"
 }
 
 # Make the source file have interleaved regular blocks and reflinked blocks
diff --git a/tests/generic/905 b/tests/generic/905
new file mode 100755
index 00000000..56cdcd27
--- /dev/null
+++ b/tests/generic/905
@@ -0,0 +1,68 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 905
+#
+# Ensuring that copy on write in mmap mode works when the CoW
+# range originally covers multiple extents, mixed with reflinked, unwritten,
+# hole, regular and delalloc blocks.
+# (MMAP version of generic/200,199)
+#   - Create a file with the following repeating sequence of blocks:
+#     1. reflinked
+#     2. unwritten
+#     3. hole
+#     4. regular block
+#     5. delalloc
+#   - mmap CoW across the halfway mark, starting with the unwritten extent.
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
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "fpunch"
+_require_cp_reflink
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
+_weave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
+_weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
+# now cow
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
diff --git a/tests/generic/905.out b/tests/generic/905.out
new file mode 100644
index 00000000..6fb0be5f
--- /dev/null
+++ b/tests/generic/905.out
@@ -0,0 +1,12 @@
+QA output created by 905
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-905/file1
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-905/file3
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-905/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-905/file1
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-905/file3
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-905/file3.chk
-- 
2.34.0



