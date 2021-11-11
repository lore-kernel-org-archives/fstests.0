Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38206C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C2761267
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhKKIyS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31067 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232530AbhKKIyI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:08 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AgbwtM6nBCpbZwXTv0HZNCoDo5gydJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2EAyzYZWWyFb/qIYWOnKoxzYITj/EkGuMTczoBgGVFt+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYueJQUVUj/nSH+OlUba?=
 =?us-ascii?q?cZ0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHg65XPlxaeG5fr67A0ZK0sBqUW4fp6Gn1?=
 =?us-ascii?q?V3eIXJSpLbR2Zge+yhrWhRYFRam4LRCXwFNpH/Cg+kneCVrB7Ka0vip7ivbdwt?=
 =?us-ascii?q?ArcTOgTdRoGW/ckVA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATIeHc6uUXQ7mz6KlUawfYdvW7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214030"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 8BCC84D10A13
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:13 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:13 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:12 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 10/13] generic: add mmap CoW test for delalloc&source extents
Date:   Thu, 11 Nov 2021 16:51:03 +0800
Message-ID: <20211111085106.937684-11-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
References: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8BCC84D10A13.AF6EA
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
 common/reflink        |  3 ++
 tests/generic/918     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/918.out | 12 ++++++++
 3 files changed, 79 insertions(+)
 create mode 100755 tests/generic/918
 create mode 100644 tests/generic/918.out

diff --git a/common/reflink b/common/reflink
index 84173d59..e304ddc8 100644
--- a/common/reflink
+++ b/common/reflink
@@ -431,4 +431,7 @@ _sweave_reflink_holes_delalloc() {
 		_pwrite_byte 0x64 $((blksz * i)) $blksz $sfile
 		_pwrite_byte 0x64 $((blksz * i)) $blksz $sfile.chk
 	done
+	# make sure we actually got delalloc block
+	$FILEFRAG_PROG -v $sfile 2>&1 | grep -q delalloc || \
+		_notrun "test requires delayed allocation writes"
 }
diff --git a/tests/generic/918 b/tests/generic/918
new file mode 100755
index 00000000..f7767a8e
--- /dev/null
+++ b/tests/generic/918
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
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
diff --git a/tests/generic/918.out b/tests/generic/918.out
new file mode 100644
index 00000000..465ade08
--- /dev/null
+++ b/tests/generic/918.out
@@ -0,0 +1,12 @@
+QA output created by 918
+Format and mount
+Create the original files
+Compare files
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-918/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-918/file3
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-918/file1.chk
+mmap CoW across the transition
+Compare files
+35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-918/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-918/file3
+35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-918/file1.chk
-- 
2.33.0



