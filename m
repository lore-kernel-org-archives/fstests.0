Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0856AC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 04:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DFC610A8
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 04:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhKEEzZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 00:55:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42990 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232067AbhKEEzY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Nov 2021 00:55:24 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AlygbaKracajO2CtVW9f0K5fIdzNeBmIEZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmRMCDjVM/fYa2Ghedx2aovg9k9U6JWGzdI3Sgdt/iEwQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?dYn0pHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXNnhSXKiWzqxlpJARsVWECwc55Gn1?=
 =?us-ascii?q?D7uADAC4CYwrFhO+sxr+/DO52iawewGPDVG8Ekig4i2iHUrB9GtaeK5gmLORwh?=
 =?us-ascii?q?F8Y7v2i196HDybBVQdSUQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3APi8jL63d7uLZDK2+ppdlWAqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="116919167"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2021 12:52:44 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id A4F1B4D10113
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 12:52:42 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 12:52:44 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 5 Nov 2021 12:52:40 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 5/5] generic/xxx: Add MMAP CoW test for 'all' case
Date:   Fri, 5 Nov 2021 12:52:22 +0800
Message-ID: <20211105045222.157826-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A4F1B4D10113.A0A88
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
the surrounding blocks vary between unwritten/regular/delalloc/hole.
(MMAP version of generic/229,238)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/904     | 135 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/904.out |  82 +++++++++++++++++++++++++
 2 files changed, 217 insertions(+)
 create mode 100755 tests/generic/904
 create mode 100644 tests/generic/904.out

diff --git a/tests/generic/904 b/tests/generic/904
new file mode 100755
index 00000000..c1cca379
--- /dev/null
+++ b/tests/generic/904
@@ -0,0 +1,135 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
+# the surrounding blocks vary between unwritten/regular/delalloc/hole.
+# (MMAP version of generic/229,238)
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
+runtest() {
+	echo "runtest $1 $2"
+	b2=$1
+	b4=$2
+	dir=$3
+
+	echo "Create the original files"
+	mkdir -p $dir
+	_pwrite_byte 0x61 0 $pagesz $dir/file1 >> $seqres.full
+
+	$XFS_IO_PROG -f -c "truncate $pagesz" $dir/file2 >> $seqres.full
+	$XFS_IO_PROG -f -c "truncate $pagesz" $dir/file2.chk >> $seqres.full
+
+	case $b2 in
+	"regular")
+		_pwrite_byte 0x61 $blksz $blksz $dir/file2 >> $seqres.full
+		_pwrite_byte 0x61 $blksz $blksz $dir/file2.chk >> $seqres.full
+		;;
+	"unwritten")
+		$XFS_IO_PROG -f -c "falloc -k $blksz $blksz" $dir/file2 >> $seqres.full
+		_pwrite_byte 0x00 $blksz $blksz $dir/file2.chk >> $seqres.full
+		;;
+	"hole")
+		;;
+	esac
+
+	case $b4 in
+	"regular")
+		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2 >> $seqres.full
+		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2.chk >> $seqres.full
+		;;
+	"unwritten")
+		$XFS_IO_PROG -f -c "falloc -k $((blksz * 3)) $blksz" $dir/file2 >> $seqres.full
+		_pwrite_byte 0x00 $((blksz * 3)) $blksz $dir/file2.chk >> $seqres.full
+		;;
+	"hole")
+		;;
+	esac
+
+	_reflink_range $dir/file1 $blksz $dir/file2 $((blksz * 2)) $blksz >> $seqres.full
+	_pwrite_byte 0x61 $((blksz * 2)) $blksz $dir/file2.chk >> $seqres.full
+	_scratch_cycle_mount
+
+	echo "Compare files"
+	cmp -s $dir/file1 $dir/file2 && echo "file1 and file2 should not match."
+	cmp -s $dir/file2 $dir/file2.chk || echo "file2 and file2.chk don't match."
+
+	echo "CoW and unmount"
+	if [ $b2 = "delalloc" ]; then
+		_pwrite_byte 0x61 $blksz $blksz $dir/file2 >> $seqres.full
+		_pwrite_byte 0x61 $blksz $blksz $dir/file2.chk >> $seqres.full
+	fi
+
+	if [ $b4 = "delalloc" ]; then
+		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2 >> $seqres.full
+		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2.chk >> $seqres.full
+	fi
+
+	$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
+        -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $dir/file2 >> $seqres.full
+	$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
+        -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $dir/file2.chk >> $seqres.full
+	_scratch_cycle_mount
+
+	echo "Compare files"
+	cmp -s $dir/file1 $dir/file2 && echo "file1 and file2 should not match."
+	cmp -s $dir/file2 $dir/file2.chk || echo "file2 and file2.chk don't match."
+}
+
+runtest regular delalloc "$testdir/r-d"
+runtest regular unwritten "$testdir/r-u"
+runtest regular hole "$testdir/r-h"
+runtest regular regular "$testdir/r-r"
+
+runtest hole delalloc "$testdir/h-d"
+runtest hole unwritten "$testdir/h-u"
+runtest hole hole "$testdir/h-h"
+runtest hole regular "$testdir/h-r"
+
+runtest unwritten delalloc "$testdir/u-d"
+runtest unwritten unwritten "$testdir/u-u"
+runtest unwritten hole "$testdir/u-h"
+runtest unwritten regular "$testdir/u-r"
+
+runtest delalloc delalloc "$testdir/d-d"
+runtest delalloc unwritten "$testdir/d-u"
+runtest delalloc hole "$testdir/d-h"
+runtest delalloc regular "$testdir/d-r"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/904.out b/tests/generic/904.out
new file mode 100644
index 00000000..f84bbe6d
--- /dev/null
+++ b/tests/generic/904.out
@@ -0,0 +1,82 @@
+QA output created by 904
+Format and mount
+runtest regular delalloc
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest regular unwritten
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest regular hole
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest regular regular
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest hole delalloc
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest hole unwritten
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest hole hole
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest hole regular
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest unwritten delalloc
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest unwritten unwritten
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest unwritten hole
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest unwritten regular
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest delalloc delalloc
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest delalloc unwritten
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest delalloc hole
+Create the original files
+Compare files
+CoW and unmount
+Compare files
+runtest delalloc regular
+Create the original files
+Compare files
+CoW and unmount
+Compare files
-- 
2.33.0



