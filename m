Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E828EC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61F961989
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhKKIyW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31067 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232618AbhKKIyS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:18 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AAH44QKs+DKBKktUKUFIjk8QGFufnVEpcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3nzBLXG+HP/iJNmagKtgnb9iz9xgE75HdztA1GlRupXhgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?dYngsLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6JPJlhGeKCKEL/JGSRte0Zcj0uhsHWx?=
 =?us-ascii?q?V6ecwNj8AdFaAiviwzbb9TfNj7vnPhuGD0Jg34ykmlG+GS619B82rfkkD3vcAt?=
 =?us-ascii?q?B9YuyyENam2ixIlVAdS?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQtLwoKBTxF5uutjlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214031"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:18 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 290EF4D10A10
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:12 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:11 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:12 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:10 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 06/13] generic: add mmap CoW test for mixed&destination extents
Date:   Thu, 11 Nov 2021 16:50:59 +0800
Message-ID: <20211111085106.937684-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
References: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 290EF4D10A10.ADE8B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents, mixed with reflinked, unwritten, hole, regular and
delalloc blocks.
(MMAP version of generic/200,199)

Also, add a check to make sure the delalloc block accutally exists.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 common/reflink        |  3 ++
 tests/generic/914     | 68 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/914.out | 12 ++++++++
 3 files changed, 83 insertions(+)
 create mode 100755 tests/generic/914
 create mode 100644 tests/generic/914.out

diff --git a/common/reflink b/common/reflink
index 38210673..84173d59 100644
--- a/common/reflink
+++ b/common/reflink
@@ -362,6 +362,9 @@ _weave_reflink_rainbow_delalloc() {
 		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile
 		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile.chk
 	done
+	# make sure we actually got delalloc block
+	$FILEFRAG_PROG -v $dfile 2>&1 | grep -q delalloc || \
+		_notrun "test requires delayed allocation writes"
 }
 
 # Make the source file have interleaved regular blocks and reflinked blocks
diff --git a/tests/generic/914 b/tests/generic/914
new file mode 100755
index 00000000..211f6f26
--- /dev/null
+++ b/tests/generic/914
@@ -0,0 +1,68 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# Ensuring that copy on write in mmap mode works when the CoW
+# range originally covers multiple extents, mixed with reflinked, unwritten,
+# hole, regular and delalloc blocks.
+# (MMAP version of generic/200,199)
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
+_weave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file3.chk | _filter_scratch
+
+echo "mmap CoW across the transition"
+cowoff=$((filesize / 4))
+cowsz=$((filesize / 2))
+_weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
+# now cow
+mmapsz=$((cowoff + cowsz))
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3 >> $seqres.full
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file3.chk | _filter_scratch
+
+# success, all done
+status=0
diff --git a/tests/generic/914.out b/tests/generic/914.out
new file mode 100644
index 00000000..a8118a02
--- /dev/null
+++ b/tests/generic/914.out
@@ -0,0 +1,12 @@
+QA output created by 914
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-914/file1
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-914/file3
+6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-914/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-914/file1
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-914/file3
+26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-914/file3.chk
-- 
2.33.0



