Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78AAC43219
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 08:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhLNITc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 03:19:32 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47274 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231801AbhLNITb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 03:19:31 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AKSzmD6unGSKYot2uwYChootQ8OfnVEpcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3x2YcUWiAa/aNYzajLdwiPd6zpx4PvMDVy9FmSQFtriBgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuClUbS?=
 =?us-ascii?q?dZngoLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6JzDkB2aIyKEL/JGSRte0Zcj0uhsHWx?=
 =?us-ascii?q?V6ecwNj8AdFaAiviwzbb9TfNj7vnPhuGD0Jg34ykmlG+GS619B82rfkkD3vcAt?=
 =?us-ascii?q?B9YuyyENau2ixIlVAdS?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A3MR9uawD6XO1QvwGTt9SKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118878481"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 16:19:27 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 1F4E64D144C3
        for <fstests@vger.kernel.org>; Tue, 14 Dec 2021 16:19:22 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:23 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 16:19:20 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v3 12/17] generic: add buffered-io CoW test for mixed&source extents
Date:   Tue, 14 Dec 2021 16:19:09 +0800
Message-ID: <20211214081914.2478122-13-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1F4E64D144C3.A0338
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
 common/reflink        | 51 +++++++++++++++++++++++++++++++++
 tests/generic/910     | 65 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/910.out | 12 ++++++++
 3 files changed, 128 insertions(+)
 create mode 100755 tests/generic/910
 create mode 100644 tests/generic/910.out

diff --git a/common/reflink b/common/reflink
index ee60398e..68dbdedd 100644
--- a/common/reflink
+++ b/common/reflink
@@ -426,3 +426,54 @@ _sweave_reflink_holes_delalloc() {
 		_pwrite_byte 0x64 $((blksz * i)) $blksz $sfile.chk
 	done
 }
+
+# Create a file of interleaved holes, unwritten blocks, regular blocks, and
+# reflinked blocks
+_sweave_reflink_rainbow() {
+	blksz=$1
+	nr=$2
+	sfile=$3
+	dfile=$4
+
+	$XFS_IO_PROG -f -c "truncate $((blksz * nr))" $sfile
+	_pwrite_byte 0x00 0 $((blksz * nr)) $sfile.chk
+	_pwrite_byte 0x61 0 $((blksz * nr)) $dfile
+	seq 0 5 $((nr - 1)) | while read i; do
+		_pwrite_byte 0x61 $((blksz * i)) $blksz $sfile
+		_pwrite_byte 0x61 $((blksz * i)) $blksz $sfile.chk
+	done
+	# 0 blocks are reflinked
+	seq 0 5 $((nr - 1)) | while read i; do
+		_reflink_range $sfile $((blksz * i)) $dfile $((blksz * i)) $blksz
+		_pwrite_byte 0x61 $((blksz * i)) $blksz $sfile.chk
+	done
+	# 1 blocks are unwritten
+	seq 1 5 $((nr - 1)) | while read i; do
+		$XFS_IO_PROG -f -c "falloc $((blksz * i)) $blksz" $sfile
+		_pwrite_byte 0x00 $((blksz * i)) $blksz $sfile.chk
+	done
+	# 2 blocks are holes
+	seq 2 5 $((nr - 1)) | while read i; do
+		_pwrite_byte 0x00 $((blksz * i)) $blksz $sfile.chk
+	done
+	# 3 blocks are regular
+	seq 3 5 $((nr - 1)) | while read i; do
+		_pwrite_byte 0x71 $((blksz * i)) $blksz $sfile
+		_pwrite_byte 0x71 $((blksz * i)) $blksz $sfile.chk
+	done
+	# 4 blocks will be delalloc later
+}
+
+# For a file created with _sweave_reflink_rainbow, fill the holes with delalloc
+# extents
+_sweave_reflink_rainbow_delalloc() {
+	blksz=$1
+	nr=$2
+	dfile=$3
+
+	# 4 blocks are delalloc (do later)
+	seq 4 5 $((nr - 1)) | while read i; do
+		_pwrite_byte 0x62 $((blksz * i)) $blksz $sfile
+		_pwrite_byte 0x62 $((blksz * i)) $blksz $sfile.chk
+	done
+}
diff --git a/tests/generic/910 b/tests/generic/910
new file mode 100755
index 00000000..32628060
--- /dev/null
+++ b/tests/generic/910
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 910
+#
+# Ensuring that copy on write in buffered mode works when the CoW
+# range originally covers multiple extents, mixed with reflinked, unwritten,
+# hole, regular and delalloc blocks.
+#   - Create a file with the following repeating sequence of blocks:
+#     1. reflinked
+#     2. unwritten
+#     3. hole
+#     4. regular block
+#     5. delalloc
+#   - CoW across the halfway mark, starting with the unwritten extent.
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
+echo "CoW across the transition"
+cowoff=$((filesize / 4))
+cowsz=$((filesize / 2))
+_sweave_reflink_rainbow_delalloc $blksz $nr $testdir/file1 >> $seqres.full
+# now cow
+$XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
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
diff --git a/tests/generic/910.out b/tests/generic/910.out
new file mode 100644
index 00000000..12956584
--- /dev/null
+++ b/tests/generic/910.out
@@ -0,0 +1,12 @@
+QA output created by 910
+Format and mount
+Create the original files
+Compare files
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-910/file1
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-910/file3
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-910/file1.chk
+CoW across the transition
+Compare files
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-910/file1
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-910/file3
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-910/file1.chk
-- 
2.34.1



