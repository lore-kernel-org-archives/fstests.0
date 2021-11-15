Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379ABC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E3260555
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbhKODpP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Nov 2021 22:45:15 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54129 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236937AbhKODon (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Nov 2021 22:44:43 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AnQ9e/KmVzsOyZHGZCYUChefo5gydJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzQPmDZKXmDXOKvYNGb0ct9ya46/9RgBsMWAzN9iTgNl+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYueJQUVUj/nSH+OlUbK?=
 =?us-ascii?q?cYEideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHg7ZTKnhGcG5fr67A0ZK0sBqUW4fp6Gn1?=
 =?us-ascii?q?V3eIXJSpLbR2Zge+yhrWhRYFRam4LRCXwFNpH/Cg+kneCVrB7Ka0vip7ivbdwt?=
 =?us-ascii?q?ArcTOgVdRoGW/ckVA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Awxdje6HopvkGitqFpLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="117401942"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2021 11:41:13 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A25064D10A33
        for <fstests@vger.kernel.org>; Mon, 15 Nov 2021 11:41:11 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 15 Nov 2021 11:41:13 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 15 Nov 2021 11:41:10 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 2/3] generic: add race test that mmap write to source of reflink
Date:   Mon, 15 Nov 2021 11:41:07 +0800
Message-ID: <20211115034108.1328167-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115034108.1328167-1-ruansy.fnst@fujitsu.com>
References: <20211115034108.1328167-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A25064D10A33.AD5A2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test for races or FS corruption when mmap writing to a file that's also
the source of a reflink operation. (MMAP version of generic/167,166)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/931     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/931.out |  4 +++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/generic/931
 create mode 100644 tests/generic/931.out

diff --git a/tests/generic/931 b/tests/generic/931
new file mode 100755
index 00000000..715ac085
--- /dev/null
+++ b/tests/generic/931
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# Test for races or FS corruption when mmap writing to a file that's also
+# the source of a reflink operation. (MMAP version of generic/167,166)
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
+loops=1024
+nr_loops=$((loops - 1))
+blksz=65536
+
+echo "Initialize file"
+echo >> $seqres.full
+_pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
+_scratch_cycle_mount
+
+# Snapshot creator...
+snappy() {
+	n=0
+	while [ ! -e $finished_file ]; do
+		out="$(_cp_reflink $testdir/file1 $testdir/snap_$n 2>&1)"
+		res=$?
+		echo "$out" | grep -q "No space left" && break
+		test -n "$out" && echo "$out"
+		test $res -ne 0 && break
+		n=$((n + 1))
+	done
+}
+
+echo "Snapshot a file undergoing mmap rewrite"
+snappy &
+seq $nr_loops -1 0 | while read i; do
+	$XFS_IO_PROG -f -c "mmap -rw $((i * blksz)) $blksz" \
+		-c "mwrite -S 0x63 $((i * blksz)) $blksz" $testdir/file1 >> $seqres.full
+done
+touch $finished_file
+wait
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/931.out b/tests/generic/931.out
new file mode 100644
index 00000000..b224e6ad
--- /dev/null
+++ b/tests/generic/931.out
@@ -0,0 +1,4 @@
+QA output created by 931
+Format and mount
+Initialize file
+Snapshot a file undergoing mmap rewrite
-- 
2.33.0



