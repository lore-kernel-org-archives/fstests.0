Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC7C433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F7A61246
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhKEDpR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Nov 2021 23:45:17 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:63855 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231201AbhKEDpR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Nov 2021 23:45:17 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AJyErhqN6HmII2onvrR25lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQjs0Tsg3mAEyTEcUWCDP/6ONGT1fd0jPNiz/R9VupWAm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiC0SiuFaOC79CAljfzQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQYqeaZeSLl2SCU5wicG5f2+N1gF107JpED0vh4DHs?=
 =?us-ascii?q?I9vECLj0JKBeZiIqLLBiTIgV3rp17apC1Y8VE4Tc9pQw1xM0OGfjrK5gmL/cBt?=
 =?us-ascii?q?Nvouv1zIA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ADtOBFa1ScaIH/yAv7zD2dQqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="116916022"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2021 11:42:37 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id EBF5C4D10106
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 11:42:34 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 11:42:28 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 11:42:29 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 5 Nov 2021 11:42:27 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 5/5] generic/xxx: Add MMAP CoW test for 'all' case
Date:   Fri, 5 Nov 2021 11:42:00 +0800
Message-ID: <20211105034200.143626-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
References: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: EBF5C4D10106.A1BCF
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
index 00000000..dee6df4e
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
+	! cmp -s $dir/file1 $dir/file2 || _fail "file1 and file2 don't match."
+	cmp -s $dir/file2 $dir/file2.chk || _fail "file2 and file2.chk don't match."
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
+	! cmp -s $dir/file1 $dir/file2 || _fail "file1 and file2 don't match."
+	cmp -s $dir/file2 $dir/file2.chk || _fail "file2 and file2.chk don't match."
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



