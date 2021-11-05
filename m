Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BDFC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 04:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEA2610A8
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 04:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhKEEzT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 00:55:19 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36507 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231391AbhKEEzS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Nov 2021 00:55:18 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AvAiMT6txCSiju3BTdJeNcdY++ufnVEpcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3yzYaD2+DM/iKa2f3cox0OYnn9hxTvp+EztRgHFFs+ylgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?cZ3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6JLClhyfLieEL/JGSRte0Zcj0uhsHWx?=
 =?us-ascii?q?V6ecwNj8AdFaAiviwzbb9TfNj7vnPhuGD0Jg34ykmlG+GS619B82rfkkD3vcAt?=
 =?us-ascii?q?B9YuyyENa+2ixIlVAdS?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Af2vj76y2i3PyW9rwrt2cKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="116919154"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2021 12:52:37 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 377FF4D10103
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 12:52:35 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 12:52:30 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 5 Nov 2021 12:52:27 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 2/5] generic/xxx: Add MMAP CoW test for 'unwritten' case
Date:   Fri, 5 Nov 2021 12:52:19 +0800
Message-ID: <20211105045222.157826-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 377FF4D10103.AE156
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
the second block is a unwritten block.  (MMAP version of generic/216,217)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/901     | 76 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/901.out |  6 ++++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/generic/901
 create mode 100644 tests/generic/901.out

diff --git a/tests/generic/901 b/tests/generic/901
new file mode 100755
index 00000000..46459815
--- /dev/null
+++ b/tests/generic/901
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
+# the second block is a unwritten block.  (MMAP version of generic/216,217)
+#
+# This test is dependent on the system page size, so we cannot use md5 in
+# the golden output; we can only compare to a check file.
+#
+. ./common/preamble
+_begin_fstest auto quick clone
+
+# Override the default cleanup function.
+_cleanup()
+{
+    cd /
+    rm -rf $tmp.* $testdir
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_require_scratch_reflink
+_require_xfs_io_command "falloc"
+
+pagesz=$(getconf PAGE_SIZE)
+blksz=$((pagesz / 4))
+
+echo "Format and mount"
+_scratch_mkfs_blocksized $blksz > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+real_blksz=$(_get_file_block_size $testdir)
+test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
+
+echo "Create the original files"
+_pwrite_byte 0x61 0 $pagesz $testdir/file1 >> $seqres.full
+
+$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2 >> $seqres.full
+$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2.chk >> $seqres.full
+
+$XFS_IO_PROG -f -c "falloc -k $blksz $blksz" $testdir/file2 >> $seqres.full
+_pwrite_byte 0x00 $blksz $blksz $testdir/file2.chk >> $seqres.full
+
+$XFS_IO_PROG -f -c "falloc -k $((blksz * 3)) $blksz" $testdir/file2 >> $seqres.full
+_pwrite_byte 0x00 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
+
+_reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
+_pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
+cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
+
+echo "CoW and unmount"
+$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
+    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
+$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
+    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+cmp -s $testdir/file1 $testdir/file2 && echo "file1 and file2 should not match."
+cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk don't match."
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/901.out b/tests/generic/901.out
new file mode 100644
index 00000000..07b9b433
--- /dev/null
+++ b/tests/generic/901.out
@@ -0,0 +1,6 @@
+QA output created by 901
+Format and mount
+Create the original files
+Compare files
+CoW and unmount
+Compare files
-- 
2.33.0



