Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ADDC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhKYHxW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:53:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17619 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234555AbhKYHvR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:51:17 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Abc+7R6uWDcYAyQG/oNeDBy/i7OfnVEpcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3mmZJUWGCO/qOa2fwc4h1O47k/EgC75HVydNnTAJsri5gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?eZ3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6JPDnhWYLCCEL/JGSRte0Zcj0uhsHWx?=
 =?us-ascii?q?V6ecwNj8AdFaAiviwzbb9TfNj7vnPhuGD0Jg34ykmlG+GS619B82rfkkD3vcAt?=
 =?us-ascii?q?B9YuyyENaq2ixIlVAdS?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALtkaN69uYvXtXhm7cVxuk+D2I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZhyY0TiTS/Pre5cjztCWE7wr5N0tQ++xoVJPvfZr8z+8M3WBzB8bHYOCFgh?=
 =?us-ascii?q?rMEGlihbGSuAEIcheWnoVgPMxbAstD4arLYWSS4/ya3ODDKbwdKaG8gcaVbLvl?=
 =?us-ascii?q?vg1QpHpRBp2JUmxCZTqmLg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890673"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 548204D138C6
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:57 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:56 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:57 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:55 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 01/16] generic: add mmap CoW test for ranges of two shared files
Date:   Thu, 25 Nov 2021 15:47:37 +0800
Message-ID: <20211125074752.274176-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 548204D138C6.ADBB5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents. (MMAP version of generic/185,183)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/900     | 69 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/900.out | 14 +++++++++
 2 files changed, 83 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..de76cd00
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,69 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 900
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
diff --git a/tests/generic/900.out b/tests/generic/900.out
new file mode 100644
index 00000000..b2569ab0
--- /dev/null
+++ b/tests/generic/900.out
@@ -0,0 +1,14 @@
+QA output created by 900
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-900/file1
+b83f9394092e15bdcda585cd8e776dc6  SCRATCH_MNT/test-900/file2
+d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-900/file3
+d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-900/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-900/file1
+b83f9394092e15bdcda585cd8e776dc6  SCRATCH_MNT/test-900/file2
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-900/file3
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-900/file3.chk
-- 
2.34.0



