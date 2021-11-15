Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E50C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F3E61B42
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhKODox (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Nov 2021 22:44:53 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54129 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236898AbhKODoS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Nov 2021 22:44:18 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Ar4A92aorcB7PLikrjlkvNXX3uGVeBmIEZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmVMWzvXaKqLMzDxfo13aI/i8U4AvJOByIM1TAs//38yQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?dY3wpH2eIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXMkxWfIie1qxlpJARsVWECwc55Gn1?=
 =?us-ascii?q?D7uADAC4CYwrFhO+sxr+/DO52iawewGPDVG8Ekig4i2iHUrB9GtaeK5gmLORwh?=
 =?us-ascii?q?F8Y7v2i196HDybBVQdSUQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ASP+/ja9jjuTGx6njDb1uk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="117401941"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2021 11:41:13 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id E98EB4D10A35
        for <fstests@vger.kernel.org>; Mon, 15 Nov 2021 11:41:11 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 15 Nov 2021 11:41:13 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 15 Nov 2021 11:41:10 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 3/3] generic: add race test that mmap write to target of reflink
Date:   Mon, 15 Nov 2021 11:41:08 +0800
Message-ID: <20211115034108.1328167-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115034108.1328167-1-ruansy.fnst@fujitsu.com>
References: <20211115034108.1328167-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E98EB4D10A35.A100A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test for races or FS corruption when mmap writing to a file that's also
the target of a reflink operation. (MMAP version of generic/168,170)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/932     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/932.out |  4 +++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/generic/932
 create mode 100644 tests/generic/932.out

diff --git a/tests/generic/932 b/tests/generic/932
new file mode 100755
index 00000000..60a6deb8
--- /dev/null
+++ b/tests/generic/932
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# Test for races or FS corruption when mmap writing to a file that's also
+# the target of a reflink operation. (MMAP version of generic/168,170)
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
+loops=1024
+nr_loops=$((loops - 1))
+blksz=65536
+
+echo "Initialize files"
+echo >> $seqres.full
+_pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
+_pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
+_scratch_cycle_mount
+
+# mmap overwriter...
+overwrite() {
+	while [ ! -e $finished_file ]; do
+		seq $nr_loops -1 0 | while read i; do
+			$XFS_IO_PROG -f -c "mmap -rw $((i * blksz)) $blksz" \
+				-c "mwrite -S 0x63 $((i * blksz)) $blksz" $testdir/file2 >> $seqres.full
+		done
+	done
+}
+
+echo "Reflink and mmap write the target"
+overwrite &
+seq 1 10 | while read j; do
+	seq 0 $nr_loops | while read i; do
+		_reflink_range  $testdir/file1 $((i * blksz)) \
+				$testdir/file2 $((i * blksz)) $blksz >> $seqres.full
+		[ $? -ne 0 ] && exit
+	done
+done
+touch $finished_file
+wait
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/932.out b/tests/generic/932.out
new file mode 100644
index 00000000..95be7764
--- /dev/null
+++ b/tests/generic/932.out
@@ -0,0 +1,4 @@
+QA output created by 932
+Format and mount
+Initialize files
+Reflink and mmap write the target
-- 
2.33.0



