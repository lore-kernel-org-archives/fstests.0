Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE8DC4332F
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 03:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1909C61284
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 03:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhKIDYK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Nov 2021 22:24:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51208 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237336AbhKIDYG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Nov 2021 22:24:06 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AShzNZ6oDQ3qOZI/w/oaoNzWeNBNeBmIEZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmYeWGuEb67fYmX1c4snaYq/oBtUsMKDnIVhT1E9pX82QiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?dYnEpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXMlxyfIiO8qxlpJARsVWECwc55Gn1?=
 =?us-ascii?q?D7uADAC4CYwrFhO+sxr+/DO52iawewGPDVG8Ekig4i2iHUrB9GtaeK5gmLORwh?=
 =?us-ascii?q?F8Y7v2i196EDybBVQdSUQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A3N9QoKBOhc4tAo3lHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,219,1631548800"; 
   d="scan'208";a="117091908"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Nov 2021 11:21:17 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1B0314D10A0B
        for <fstests@vger.kernel.org>; Tue,  9 Nov 2021 11:21:16 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 9 Nov 2021 11:21:15 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 9 Nov 2021 11:21:14 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v3 5/5] generic: add mmap CoW test for 'mixed' case
Date:   Tue, 9 Nov 2021 11:21:10 +0800
Message-ID: <20211109032110.499427-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109032110.499427-1-ruansy.fnst@fujitsu.com>
References: <20211109032110.499427-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1B0314D10A0B.AD8A5
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
 tests/generic/904     | 132 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/904.out |  62 ++++++++++++++++++++
 2 files changed, 194 insertions(+)
 create mode 100755 tests/generic/904
 create mode 100644 tests/generic/904.out

diff --git a/tests/generic/904 b/tests/generic/904
new file mode 100755
index 00000000..a11b4377
--- /dev/null
+++ b/tests/generic/904
@@ -0,0 +1,132 @@
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
+
+		# make sure we actually got delalloc block
+		$FILEFRAG_PROG -v $dir/file2 2>&1 | grep -q delalloc || \
+			_notrun "test requires delayed allocation writes"
+	fi
+
+	if [ $b4 = "delalloc" ]; then
+		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2 >> $seqres.full
+		_pwrite_byte 0x61 $((blksz * 3)) $blksz $dir/file2.chk >> $seqres.full
+
+		# make sure we actually got delalloc block
+		$FILEFRAG_PROG -v $dir/file2 2>&1 | grep -q delalloc || \
+			_notrun "test requires delayed allocation writes"
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
+
+runtest hole delalloc "$testdir/h-d"
+runtest hole unwritten "$testdir/h-u"
+runtest hole regular "$testdir/h-r"
+
+runtest unwritten delalloc "$testdir/u-d"
+runtest unwritten hole "$testdir/u-h"
+runtest unwritten regular "$testdir/u-r"
+
+runtest delalloc unwritten "$testdir/d-u"
+runtest delalloc hole "$testdir/d-h"
+runtest delalloc regular "$testdir/d-r"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/904.out b/tests/generic/904.out
new file mode 100644
index 00000000..bc45481d
--- /dev/null
+++ b/tests/generic/904.out
@@ -0,0 +1,62 @@
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



