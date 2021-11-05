Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF30EC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 04:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E92610A8
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 04:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhKEEzU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 00:55:20 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1203 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232067AbhKEEzS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Nov 2021 00:55:18 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AvL/wN6x4IkleiLsus416t+crxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDoi3mYAxzQcWzrUaP+NamOhet4jPduw9hgF7ZHXzdFgHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHuekUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeaZcCHu6JHOp6HBWz62qxl0N2k4JpEV4fpsKX9?=
 =?us-ascii?q?B+OZeKz0XaB2HweWsz9qGpkNE7ig4BJCzetpB5Tc7lneEZcvKiKvrG83ijeK0F?=
 =?us-ascii?q?h9p7iyWIcvjWg=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AnTrfxK1g75LuhWV9xaI9qQqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="116919155"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2021 12:52:37 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 946974D10106
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 12:52:36 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 12:52:34 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 12:52:36 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 5 Nov 2021 12:52:33 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 3/5] generic/xxx: Add MMAP CoW test for 'hole' case
Date:   Fri, 5 Nov 2021 12:52:20 +0800
Message-ID: <20211105045222.157826-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 946974D10106.AD86E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
the second block is a hole.  (MMAP version of generic/218,220)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/902     | 70 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/902.out |  6 ++++
 2 files changed, 76 insertions(+)
 create mode 100755 tests/generic/902
 create mode 100644 tests/generic/902.out

diff --git a/tests/generic/902 b/tests/generic/902
new file mode 100755
index 00000000..a0992fc8
--- /dev/null
+++ b/tests/generic/902
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
+# the second block is a hole.  (MMAP version of generic/218,220)
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
diff --git a/tests/generic/902.out b/tests/generic/902.out
new file mode 100644
index 00000000..4fb8b6cb
--- /dev/null
+++ b/tests/generic/902.out
@@ -0,0 +1,6 @@
+QA output created by 902
+Format and mount
+Create the original files
+Compare files
+CoW and unmount
+Compare files
-- 
2.33.0



