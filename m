Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99E9C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 08:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhLNITa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 03:19:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47274 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231801AbhLNIT3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 03:19:29 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A3FlwxKmdWCF1TIxUr48buxno5gyoJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzYHzWJLWm+OO6zYYjOkKdp/Otiw8E4PvZLVmtBhTwto+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSH+OmUbK?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHv4ZPDkxKbG5fr67A0ZK0sBqUU+PlwB25?=
 =?us-ascii?q?m9vECLj0JKBeZiIqezqmnR/Jwnew9I8TxeoASoHdtyXfeF/lOfHxpa80m/vcBh?=
 =?us-ascii?q?HFp2J8IRq2YOqIkhfNUREyoS3Vy1p0/VfrSRNuVu0Q=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7VnZx6OzDWal9sBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118878475"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 16:19:27 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id C97554D144C8;
        Tue, 14 Dec 2021 16:19:23 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:25 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 16:19:22 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 17/17] generic: add race test that mmap write to target of reflink
Date:   Tue, 14 Dec 2021 16:19:14 +0800
Message-ID: <20211214081914.2478122-18-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C97554D144C8.A00A7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test for races or FS corruption when mmap writing to a file that's also
the target of a reflink operation. (MMAP version of generic/168,170)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/generic/915     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/915.out |  4 +++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/generic/915
 create mode 100644 tests/generic/915.out

diff --git a/tests/generic/915 b/tests/generic/915
new file mode 100755
index 00000000..365f304c
--- /dev/null
+++ b/tests/generic/915
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 915
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
diff --git a/tests/generic/915.out b/tests/generic/915.out
new file mode 100644
index 00000000..4e77847b
--- /dev/null
+++ b/tests/generic/915.out
@@ -0,0 +1,4 @@
+QA output created by 915
+Format and mount
+Initialize files
+Reflink and mmap write the target
-- 
2.34.1



