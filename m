Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA23DC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348514AbhKYHzU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:55:20 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61265 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234384AbhKYHxU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:53:20 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ASAwUe6oadlD6ZoW2V0+Zv5jSEsBeBmIEZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjBLWWqEaK2MajamftogYN6/9kgGu5/VytFkTAE/rH0wQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?dYH0pHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXMnxyeLSSyqxlpJARsVWECwc55Gn1?=
 =?us-ascii?q?D7uADAC4CYwrFhO+sxr+/DO52iawewGPDVG8Ekig4i2iHUrB9GtaeK5gmLORwh?=
 =?us-ascii?q?F8Y7v2i196FDybBVQdSUQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ArjkJb6ndWVWuUDvrw8dba3ysVe3pDfIC3DAb?=
 =?us-ascii?q?v31ZSRFFG/FwWfrPoBxRviWE8Qr5OUtQ/uxoV5PwI080maQa3WAxB8bbYOCEgh?=
 =?us-ascii?q?rNEGgB1/qG/9XgcxeOjdK1vJ0IG8ND4bbLfDtHZLHBjDVQfexA/DD8ysqVbJ/l?=
 =?us-ascii?q?vhFQpF1RGttdBnxCZzpyryZNKzV7OQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890676"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 3CF574D138E2
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:59 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:57 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:57 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 08/16] generic: add mmap CoW test for unwritten&source extents
Date:   Thu, 25 Nov 2021 15:47:44 +0800
Message-ID: <20211125074752.274176-9-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3CF574D138E2.A0BB9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode to the source file when the CoW range
covers unwritten and regular shared blocks.
(MMAP version of generic/289,290)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/907     | 62 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/907.out | 12 +++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/generic/907
 create mode 100644 tests/generic/907.out

diff --git a/tests/generic/907 b/tests/generic/907
new file mode 100755
index 00000000..61c9293a
--- /dev/null
+++ b/tests/generic/907
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 907
+#
+# Ensuring that copy on write in mmap mode to the source file when the
+# CoW range covers unwritten and regular shared blocks.
+# (MMAP version of generic/289,290)
+#   - Create two files.
+#   - fallocate the first file.
+#   - Write the odd blocks of the first file.
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
+_sweave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
diff --git a/tests/generic/907.out b/tests/generic/907.out
new file mode 100644
index 00000000..c18b849c
--- /dev/null
+++ b/tests/generic/907.out
@@ -0,0 +1,12 @@
+QA output created by 907
+Format and mount
+Create the original files
+Compare files
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-907/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-907/file3
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-907/file1.chk
+mmap CoW across the transition
+Compare files
+e8cf59797f0b3758c8878c368bb4cf7e  SCRATCH_MNT/test-907/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-907/file3
+e8cf59797f0b3758c8878c368bb4cf7e  SCRATCH_MNT/test-907/file1.chk
-- 
2.34.0



