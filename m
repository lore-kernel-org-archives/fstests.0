Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BDAC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbhKYIBK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:01:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34883 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239621AbhKYH7K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:59:10 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AyMI+mq23gdtOTuw7wvbD5c9zkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJh28lg2MGzWQdUWHTb67eMTfxfNFzaISw90gAucWDxt82QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM+X9BDpC79SMljPjSG+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoeCXcCDh4JD7I0ruNiGEL+9VJE8tIYAD5v1fH25?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qI9X4MEEat8LdZGtZd1A/Co7i2yxMBrveribK42i2DOS9?=
 =?us-ascii?q?GtYahhyIMvj?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ADUmK26AyKvVLVDrlHemC55DYdb4zR+YMi2TD?=
 =?us-ascii?q?GXoQdfQfGfbo7vxG/c5rsiMc5wxhOk3I9ervBECgewKlyXcX2/h0AV7BZniChI?=
 =?us-ascii?q?OoRLsSlrcKqgeIc0bDH4VmpMRdmt9FZOEYY2IasS+B2mOF+q4bsb+6GfyT9J3j?=
 =?us-ascii?q?JgxWID2D1spbgDtENg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890694"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:48:05 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id F3F6A4D12A9D
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:59 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:48:00 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:48:00 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:58 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 10/16] generic: add mmap CoW test for delalloc&source extents
Date:   Thu, 25 Nov 2021 15:47:46 +0800
Message-ID: <20211125074752.274176-11-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: F3F6A4D12A9D.A4916
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
 tests/generic/909     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/909.out | 12 ++++++++
 3 files changed, 79 insertions(+)
 create mode 100755 tests/generic/909
 create mode 100644 tests/generic/909.out

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
diff --git a/tests/generic/909 b/tests/generic/909
new file mode 100755
index 00000000..ef1233ea
--- /dev/null
+++ b/tests/generic/909
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 909
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
diff --git a/tests/generic/909.out b/tests/generic/909.out
new file mode 100644
index 00000000..4f9a5d33
--- /dev/null
+++ b/tests/generic/909.out
@@ -0,0 +1,12 @@
+QA output created by 909
+Format and mount
+Create the original files
+Compare files
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-909/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-909/file3
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-909/file1.chk
+mmap CoW across the transition
+Compare files
+35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-909/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-909/file3
+35e2170e14665b780c6dec328d6a263b  SCRATCH_MNT/test-909/file1.chk
-- 
2.34.0



