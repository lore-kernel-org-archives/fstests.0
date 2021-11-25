Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909DC433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhKYH7K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:59:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61265 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244238AbhKYH5W (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:57:22 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AypiJ16hJdmjxuTvHIekIa4D/X161fBIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUEymAaUWrSPvzYYGf0ctsgbdm+8UsC6pDQm4dkSVQ++Hw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOi+xZVA/fvQHOOlUbS?=
 =?us-ascii?q?ZYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHm7pzClxOXKhMAxN0rVinaJ7Yw9P1rDHp?=
 =?us-ascii?q?S7tQGJz0XKBOOneS7xPS8UOYEuyiJBKEHJ6tG4jc5k26fVq1gHPj+r2zxzYcw9?=
 =?us-ascii?q?F8NagpmRJ4yv/YkVAc=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AL1L6nKpWcV4UHijv3wNS2VAaV5oFeYIsimQD?=
 =?us-ascii?q?101hICG9vPb5qyjk985rrCMc6QxhP03I9urwWpVoLUmzyXdV2/hoAV7AZniDhI?=
 =?us-ascii?q?LLFvAG0WPiqweQYBEWn9Q1vcxdmsNFeb7N5C9B4foSjjPYLz9b+rO6GdiT9IHj?=
 =?us-ascii?q?JitWPHtXgtpbgjuQt22gfXFLeA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890691"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:48:05 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id DF0F04D138C5
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:48:00 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:48:01 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:59 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 14/16] generic: add race test between reflink and mmap read
Date:   Thu, 25 Nov 2021 15:47:50 +0800
Message-ID: <20211125074752.274176-15-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: DF0F04D138C5.AF7F3
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
 tests/generic/913     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/913.out |  5 +++
 3 files changed, 88 insertions(+)
 create mode 100755 tests/generic/913
 create mode 100644 tests/generic/913.out

diff --git a/common/reflink b/common/reflink
index cca43393..7b94864e 100644
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
diff --git a/tests/generic/913 b/tests/generic/913
new file mode 100755
index 00000000..f709c36c
--- /dev/null
+++ b/tests/generic/913
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 913
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
diff --git a/tests/generic/913.out b/tests/generic/913.out
new file mode 100644
index 00000000..a34df6ce
--- /dev/null
+++ b/tests/generic/913.out
@@ -0,0 +1,5 @@
+QA output created by 913
+Format and mount
+Initialize files
+Reflink and mmap reread the files!
+Finished reflinking
-- 
2.34.0



