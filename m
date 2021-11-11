Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B979C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393E8619E1
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhKKIyZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:25 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34979 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232587AbhKKIyV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:21 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AQhHqCqq0rj+9wTXfIhqq+rrUXwheBmIEZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjAeDGHSO/bZNjP3c9x0b9vg9kIF7MWDytc1SwI5qH9mQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?dY3gpGGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXMlRSaKyCxqxlpJARsVWECwc55Gn1?=
 =?us-ascii?q?D7uADAC4CYwrFhO+sxr+/DO52iawewGPDVG8Ekig4i2iHUrB9GtaeK5gmLORwh?=
 =?us-ascii?q?F8Y7v2i196PDybBVQdSUQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ai9DAla0o3SfpL8bdW+XySgqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214035"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 4636C4D0DC96
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:12 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:12 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:10 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 07/13] generic: add mmap CoW test for regular&source extents
Date:   Thu, 11 Nov 2021 16:51:00 +0800
Message-ID: <20211111085106.937684-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
References: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4636C4D0DC96.ADC12
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
 tests/generic/915     | 60 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/915.out | 12 +++++++++
 2 files changed, 72 insertions(+)
 create mode 100755 tests/generic/915
 create mode 100644 tests/generic/915.out

diff --git a/tests/generic/915 b/tests/generic/915
new file mode 100755
index 00000000..2829a190
--- /dev/null
+++ b/tests/generic/915
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
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
diff --git a/tests/generic/915.out b/tests/generic/915.out
new file mode 100644
index 00000000..178fc665
--- /dev/null
+++ b/tests/generic/915.out
@@ -0,0 +1,12 @@
+QA output created by 915
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-915/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-915/file3
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-915/file1.chk
+mmap CoW across the transition
+Compare files
+2dc2b131303b2f70ddb480778caac8b7  SCRATCH_MNT/test-915/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-915/file3
+2dc2b131303b2f70ddb480778caac8b7  SCRATCH_MNT/test-915/file1.chk
-- 
2.33.0



