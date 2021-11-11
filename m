Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE8C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B886162E
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhKKIyE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31067 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232357AbhKKIyE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:04 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AcRcmK6P8i+cJ6jHvrR25lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQK5hz1xgmQOyTQaXDqBPq6PZ2qhfNsnYN+0pk5V7JTUm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiC0SiuFaOC79CAljPnQG9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQZouabeSHl2SCU5wicG5f2+N1gF107JpED0vh4DHs?=
 =?us-ascii?q?I9vECLj0JKBeZiIqLLBiTIgV3rp17apC1Y8VE4Tc9pQw1xM0OGfjrK5gmL/cFt?=
 =?us-ascii?q?Nvouv1zIA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/8vxPKgmoTybonpKZOs6JbSgFHBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214012"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:12 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9000A4D10A12
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:10 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:11 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:10 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:08 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 01/13] generic: add mmap CoW test for ranges of two shared files
Date:   Thu, 11 Nov 2021 16:50:54 +0800
Message-ID: <20211111085106.937684-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
References: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9000A4D10A12.AB2F4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents. (MMAP version of generic/185,183)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/909     | 69 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/909.out | 14 +++++++++
 2 files changed, 83 insertions(+)
 create mode 100755 tests/generic/909
 create mode 100644 tests/generic/909.out

diff --git a/tests/generic/909 b/tests/generic/909
new file mode 100755
index 00000000..dc011eba
--- /dev/null
+++ b/tests/generic/909
@@ -0,0 +1,69 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# Ensuring that copy on write in mmap mode works when the CoW
+# range originally covers multiple extents. (MMAP version of generic/185,183)
+#   - Create two files
+#   - Reflink the odd blocks of the first file into a third file.
+#   - Reflink the even blocks of the second file into the third file.
+#   - mmap CoW across the halfway mark.
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
+_pwrite_byte 0x61 0 $filesize $testdir/file1 >> $seqres.full
+_pwrite_byte 0x62 0 $filesize $testdir/file2 >> $seqres.full
+seq 0 2 $((nr-1)) | while read f; do
+	_reflink_range $testdir/file1 $((blksz * f)) $testdir/file3 $((blksz * f)) $blksz >> $seqres.full
+	_pwrite_byte 0x61 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
+done
+seq 1 2 $((nr-1)) | while read f; do
+	_reflink_range $testdir/file2 $((blksz * f)) $testdir/file3 $((blksz * f)) $blksz >> $seqres.full
+	_pwrite_byte 0x62 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
+done
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file2 | _filter_scratch
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
+md5sum $testdir/file2 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file3.chk | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/909.out b/tests/generic/909.out
new file mode 100644
index 00000000..8da48a79
--- /dev/null
+++ b/tests/generic/909.out
@@ -0,0 +1,14 @@
+QA output created by 909
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-909/file1
+b83f9394092e15bdcda585cd8e776dc6  SCRATCH_MNT/test-909/file2
+d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-909/file3
+d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-909/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-909/file1
+b83f9394092e15bdcda585cd8e776dc6  SCRATCH_MNT/test-909/file2
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-909/file3
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-909/file3.chk
-- 
2.33.0



