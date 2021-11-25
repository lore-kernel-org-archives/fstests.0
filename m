Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFB0C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347767AbhKYIBL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:01:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61265 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240138AbhKYH7K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:59:10 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AgPVvEqMaIzr1DQTvrR25lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQO5hjgrgzxRnGNMCGCFafzfZTD0L4siPIiw80wD6JbQm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiC0SiuFaOC79CAlj/zQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQZqO6ffynl2SCU5wicG5f2+N1gF107JpED0vh4DHs?=
 =?us-ascii?q?I9vECLj0JKBeZiIqLLBiTIgV3rp17apC1Y8VE4Tc9pQw1xM0OGfjrK5gmL/cEt?=
 =?us-ascii?q?Nvouv1zIA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4dVjmKoUX263roehSOYyAqQaV5oFeYIsimQD?=
 =?us-ascii?q?101hICG9vPb5qyjk985rrCMc6QxhP03I9urwWpVoLUmzyXdV2/hoAV7AZniDhI?=
 =?us-ascii?q?LLFvAG0WPiqweQYBEWn9Q1vcxdmsNFeb7N5C9B4foSjjPYLz9b+rO6GdiT9IHj?=
 =?us-ascii?q?JitWPHtXgtpbgjuQt22gfXFLeA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890692"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:48:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 4E6A44D138C4
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:48:00 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:48:00 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:58 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 12/16] generic: add direct-io CoW test for mixed&source extents
Date:   Thu, 25 Nov 2021 15:47:48 +0800
Message-ID: <20211125074752.274176-13-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4E6A44D138C4.AF44B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in buffered mode works when the CoW
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
index 00000000..57de8754
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
2.34.0



