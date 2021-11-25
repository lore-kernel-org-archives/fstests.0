Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A317C4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbhKYIBL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:01:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49039 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240174AbhKYH7K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:59:10 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AeYVhH62M27iCL7QhRvbD5c9zkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ3Wt2hGRWn2RLDziGbqvfZjP8eYtzO4+2/U8P7MPczNQ2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM+X9BDpC79SMljPjSG+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoeCXcCDh4JP7I0ruNiGEL+9VJE8tIYAD5v1fH25?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qI9X4MEEat8LdZGtZd1A/Co7i2yxMBrveribK42i2DOS9?=
 =?us-ascii?q?GlYahhyIMvj?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AMZ0u06F8ywT0ASQvpLqExseALOsnbusQ8zAX?=
 =?us-ascii?q?Po5KKSC8Oaej5rmTdZUgpHjJYVkqKRMdcLy7VpVoYEmsjaKdgrNhWYtKPjOW3V?=
 =?us-ascii?q?dBLelZnPDfKlTbckWUygc379YCT0EIMrHN5DZB7PoSmjPTLz9Z+qjgzEn1v5al?=
 =?us-ascii?q?854Xd2xXgxwK1WhENjo=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890697"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:48:05 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 2D4D54D138C6
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:48:01 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:48:01 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:59 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 15/16] generic: add race test that mmap write to source of reflink
Date:   Thu, 25 Nov 2021 15:47:51 +0800
Message-ID: <20211125074752.274176-16-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 2D4D54D138C6.AEDED
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test for races or FS corruption when mmap writing to a file that's also
the source of a reflink operation. (MMAP version of generic/167,166)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
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
2.34.0



