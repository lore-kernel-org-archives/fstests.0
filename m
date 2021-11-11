Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4FDC433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B3361989
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhKKIyY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31067 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232513AbhKKIyV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:21 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ALHGxKqJkJY+zuy2EFE+RzZclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC90D921jMDzDMfW2qFP/uKYDf2f9ggPI+38x4OvsDcmoNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+DzvuRGuK59yAljPjQHueU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToy+UltZq2ZNDs4esY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQfp+WefSDk7aR/yGWDKRMA2c5GAloqMJYE4c5pDmx?=
 =?us-ascii?q?Us/8VMjYAalaEne3e/V4RYoGAnex6dI+yYtxZ4SomkFnk4T8dacira833CRVwj?=
 =?us-ascii?q?V/cXvxzIMs=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AMofVJa9dKZvi8K21cdduk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214034"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:18 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8A9D84D10A19
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:14 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:15 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:13 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 13/13] generic: add mmap CoW test for mixed&source extents
Date:   Thu, 11 Nov 2021 16:51:06 +0800
Message-ID: <20211111085106.937684-14-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
References: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8A9D84D10A19.AF3C2
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
 tests/generic/921     | 67 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/921.out | 12 ++++++++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/generic/921
 create mode 100644 tests/generic/921.out

diff --git a/tests/generic/921 b/tests/generic/921
new file mode 100755
index 00000000..7c463143
--- /dev/null
+++ b/tests/generic/921
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# Ensuring that copy on write in mmap mode works when the CoW
+# range originally covers multiple extents, mixed with reflinked, unwritten,
+# hole, regular and delalloc blocks.
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
+_sweave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
+_sweave_reflink_rainbow_delalloc $blksz $nr $testdir/file1 >> $seqres.full
+# now cow
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
diff --git a/tests/generic/921.out b/tests/generic/921.out
new file mode 100644
index 00000000..3405a4df
--- /dev/null
+++ b/tests/generic/921.out
@@ -0,0 +1,12 @@
+QA output created by 921
+Format and mount
+Create the original files
+Compare files
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-921/file1
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-921/file3
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-921/file1.chk
+mmap CoW across the transition
+Compare files
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-921/file1
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-921/file3
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-921/file1.chk
-- 
2.33.0



