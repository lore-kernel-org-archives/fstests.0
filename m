Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DFC4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbhKYH5W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:57:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49039 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348600AbhKYHzW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:55:22 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AHsyFyqkz8vygyMcAZWpfiLDo5gydJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzIAyWodCGmPbPqMMTP2L95+b42woRlVsMXWzYViGlZr+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYueJQUVUj/nSH+OlUrO?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHg4Z3LkR2cG5fr67A0ZK0sBqUW4fp6Gn1?=
 =?us-ascii?q?V3eIXJSpLbR2Zge+yhrWhRYFRam4LRCXwFNpH/Cg+kneCVrB7Ka0vip7ivbdwt?=
 =?us-ascii?q?ArcTOgXdRoGW/ckVA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AhqCXvqPsxmKeZ8BcTu+jsMiBIKoaSvp037Dk?=
 =?us-ascii?q?7SBMoVc/SL3gqynOpoV96faaskdyZJhNo7690Yi7MAvhHP1OkO0s1NWZLWzbUG?=
 =?us-ascii?q?rBFvAY0WKK+VSJcBEWndQttpuIBJITNDSfNzlHZLzBijVQa+xQpuVvrJrY/9s2?=
 =?us-ascii?q?tE0BcenWAJsO0ztE?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890682"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0E8644D138CA
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:58 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:58 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:56 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 04/16] generic: add mmap CoW test for holes&destination extents
Date:   Thu, 25 Nov 2021 15:47:40 +0800
Message-ID: <20211125074752.274176-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0E8644D138CA.A467A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents, some holes, some not.
(MMAP version of generic/191,190)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/903     | 59 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/903.out | 12 +++++++++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/generic/903
 create mode 100644 tests/generic/903.out

diff --git a/tests/generic/903 b/tests/generic/903
new file mode 100755
index 00000000..d0de3f26
--- /dev/null
+++ b/tests/generic/903
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 903
+#
+# Ensuring that copy on write in mmap mode works when the CoW
+# range originally covers multiple extents, some holes, some not.
+# (MMAP version of generic/191,190)
+#   - Create a file and truncate a second file.
+#   - Reflink the odd blocks of the first file into the second file.
+#   - mmap CoW across the halfway mark, starting with the unwritten extent.
+#   - Check that the files are now different where we say they're different.
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
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+echo "Create the original files"
+blksz=65536
+nr=64
+filesize=$((blksz * nr))
+_weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file3.chk | _filter_scratch
+
+echo "mmap CoW across the transition"
+cowoff=$((filesize / 4))
+cowsz=$((filesize / 2))
+mmapsz=$((cowoff + cowsz))
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3 >> $seqres.full
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file3.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file3.chk | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/903.out b/tests/generic/903.out
new file mode 100644
index 00000000..bf57acc7
--- /dev/null
+++ b/tests/generic/903.out
@@ -0,0 +1,12 @@
+QA output created by 903
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-903/file1
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-903/file3
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-903/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-903/file1
+09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-903/file3
+09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-903/file3.chk
-- 
2.34.0



