Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE65CC43217
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 08:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhLNITb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 03:19:31 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23835 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231809AbhLNITb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 03:19:31 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AaUHv2KDB/ihnkxVW/wDhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fVAmw1G8mgTMAzWpMUWHSbK7fZjDwLttzOoqyox5U7ceAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK49CMlifnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZP0Wp++bfijXXcu7iheun2HX6/lsE0YwMqUb9/xxDGU?=
 =?us-ascii?q?I8uYXQBgDdQyOnP6t6Ky0R/Mqhck5KsTveoQFtRldIZvxZRo9acmbBfyUupkDh?=
 =?us-ascii?q?3Ft7v2i1M32P6IxAQeDpjyaC/GXBmoqNQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AdcTusqgAms4b8C7HRbCJZm/u83BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118878478"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 16:19:27 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id ABB764D144C7;
        Tue, 14 Dec 2021 16:19:23 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:23 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:23 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 16:19:21 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 16/17] generic: add race test that mmap write to source of reflink
Date:   Tue, 14 Dec 2021 16:19:13 +0800
Message-ID: <20211214081914.2478122-17-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: ABB764D144C7.A129D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test for races or FS corruption when mmap writing to a file that's also
the source of a reflink operation. (MMAP version of generic/167,166)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/generic/914     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/914.out |  4 +++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/generic/914
 create mode 100644 tests/generic/914.out

diff --git a/tests/generic/914 b/tests/generic/914
new file mode 100755
index 00000000..c51c44c7
--- /dev/null
+++ b/tests/generic/914
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 914
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
diff --git a/tests/generic/914.out b/tests/generic/914.out
new file mode 100644
index 00000000..1472055f
--- /dev/null
+++ b/tests/generic/914.out
@@ -0,0 +1,4 @@
+QA output created by 914
+Format and mount
+Initialize file
+Snapshot a file undergoing mmap rewrite
-- 
2.34.1



