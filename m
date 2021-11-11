Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D2C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C956162E
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhKKIyX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:23 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32308 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232357AbhKKIyS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:18 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ApTWVKK0M3ohXIzpq9PbD5c9zkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJhjMghTMBnTQYUDqHOviIZmvwKYp1YI6zoUoHsJ7dz942QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM+X9BDpC79SMljPjRHuKhYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoeCdeCTn65P7I0ruNiGEL+9VJE8tIYAD5v1fH25?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qI9X4MEEat8LdZGtZd1A/Co7i2yxMBrveribK42i2DOS9?=
 =?us-ascii?q?GhYahhyIMvj?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZ4I8T6oowfuCpZ9+nmTcGe8aV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214027"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:18 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id D99F44D10A15
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:13 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:12 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:12 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 11/13] generic: add buffered-io CoW test for mixed&source extents
Date:   Thu, 11 Nov 2021 16:51:04 +0800
Message-ID: <20211111085106.937684-12-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
References: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D99F44D10A15.AEFD2
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
 common/reflink        | 54 +++++++++++++++++++++++++++++++++++
 tests/generic/919     | 66 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/919.out | 12 ++++++++
 3 files changed, 132 insertions(+)
 create mode 100755 tests/generic/919
 create mode 100644 tests/generic/919.out

diff --git a/common/reflink b/common/reflink
index e304ddc8..85b586cb 100644
--- a/common/reflink
+++ b/common/reflink
@@ -435,3 +435,57 @@ _sweave_reflink_holes_delalloc() {
 	$FILEFRAG_PROG -v $sfile 2>&1 | grep -q delalloc || \
 		_notrun "test requires delayed allocation writes"
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
+# For a file created with _weave_reflink_rainbow, fill the holes with delalloc
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
+	# make sure we actually got delalloc block
+	$FILEFRAG_PROG -v $sfile 2>&1 | grep -q delalloc || \
+		_notrun "test requires delayed allocation writes"
+}
diff --git a/tests/generic/919 b/tests/generic/919
new file mode 100755
index 00000000..932c98d7
--- /dev/null
+++ b/tests/generic/919
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
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
diff --git a/tests/generic/919.out b/tests/generic/919.out
new file mode 100644
index 00000000..a8eb7d6b
--- /dev/null
+++ b/tests/generic/919.out
@@ -0,0 +1,12 @@
+QA output created by 919
+Format and mount
+Create the original files
+Compare files
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-919/file1
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-919/file3
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-919/file1.chk
+CoW across the transition
+Compare files
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-919/file1
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-919/file3
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-919/file1.chk
-- 
2.33.0



