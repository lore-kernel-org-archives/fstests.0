Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46CCC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C099D60555
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhKODpM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Nov 2021 22:45:12 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52771 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236939AbhKODon (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Nov 2021 22:44:43 -0500
IronPort-Data: =?us-ascii?q?A9a23=3APfjPbKqe+ZcnL79FkKmeP1NB5bBeBmIEZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmQeXW6EPq6CMTP2fd4iO4u+pksA7cXQyNM3GgY+rnoxQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?dY3wpH2eIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXMkxWfIie3qxlpJARsVWECwc55Gn1?=
 =?us-ascii?q?D7uADAC4CYwrFhO+sxr+/DO52iawewGPDVG8Ekig4i2iHUrB9GtaeK5gmLORwh?=
 =?us-ascii?q?F8Y7v2i196FDybBVQdSUQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AOfbbU6jNuELw1boTBplNnaNVtHBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="117401943"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2021 11:41:13 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 5ACD74D10A31
        for <fstests@vger.kernel.org>; Mon, 15 Nov 2021 11:41:11 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 15 Nov 2021 11:41:10 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 15 Nov 2021 11:41:09 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 1/3] generic: add race test between reflink and mmap read
Date:   Mon, 15 Nov 2021 11:41:06 +0800
Message-ID: <20211115034108.1328167-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115034108.1328167-1-ruansy.fnst@fujitsu.com>
References: <20211115034108.1328167-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5ACD74D10A31.AFA24
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test for races or FS corruption between reflink and mmap reading the
target file. (MMAP version of generic/164,165)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 common/reflink        | 11 +++++++
 tests/generic/930     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/930.out |  5 +++
 3 files changed, 88 insertions(+)
 create mode 100755 tests/generic/930
 create mode 100644 tests/generic/930.out

diff --git a/common/reflink b/common/reflink
index 85b586cb..215a8a48 100644
--- a/common/reflink
+++ b/common/reflink
@@ -186,6 +186,17 @@ _read_range() {
 	$XFS_IO_PROG $xfs_io_args -f -c "pread -q -v $offset $len" "$file" | cut -d ' ' -f '3-18'
 }
 
+# Prints a range of a file as a hex dump
+_mread_range() {
+	file="$1"
+	offset="$2"
+	len="$3"
+	xfs_io_args="$4"
+
+	$XFS_IO_PROG $xfs_io_args -f -c "mmap -rw 0 $((offset + len))" \
+		-c "mread -v $offset $len" "$file" | cut -d ' ' -f '3-18'
+}
+
 # Compare ranges of two files
 _compare_range() {
 	file1="$1"
diff --git a/tests/generic/930 b/tests/generic/930
new file mode 100755
index 00000000..c259ae45
--- /dev/null
+++ b/tests/generic/930
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# Test for races or FS corruption between reflink and mmap reading the
+# target file. (MMAP version of generic/164,165)
+#
+. ./common/preamble
+_begin_fstest auto clone
+
+_register_cleanup "_cleanup" BUS
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_require_scratch_reflink
+_require_cp_reflink
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+finished_file=/tmp/finished
+rm -rf $finished_file
+mkdir $testdir
+
+loops=512
+nr_loops=$((loops - 1))
+blksz=65536
+
+echo "Initialize files"
+echo >> $seqres.full
+_pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
+_pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
+_cp_reflink $testdir/file1 $testdir/file3
+_scratch_cycle_mount
+
+fbytes() {
+	egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
+}
+
+reader() {
+	while [ ! -e $finished_file ]; do
+		_mread_range $testdir/file3 0 $((loops * blksz)) | fbytes
+	done
+}
+
+echo "Reflink and mmap reread the files!"
+reader &
+for i in `seq 1 2`; do
+	seq $nr_loops -1 0 | while read i; do
+		_reflink_range  $testdir/file1 $((i * blksz)) \
+				$testdir/file3 $((i * blksz)) $blksz >> $seqres.full
+		[ $? -ne 0 ] && break
+	done
+	seq $nr_loops -1 0 | while read i; do
+		_reflink_range  $testdir/file2 $((i * blksz)) \
+				$testdir/file3 $((i * blksz)) $blksz >> $seqres.full
+		[ $? -ne 0 ] && break
+	done
+done
+echo "Finished reflinking"
+touch $finished_file
+wait
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/930.out b/tests/generic/930.out
new file mode 100644
index 00000000..f8e0a1a3
--- /dev/null
+++ b/tests/generic/930.out
@@ -0,0 +1,5 @@
+QA output created by 930
+Format and mount
+Initialize files
+Reflink and mmap reread the files!
+Finished reflinking
-- 
2.33.0



