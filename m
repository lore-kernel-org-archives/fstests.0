Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D2C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhKYHzW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:55:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49039 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234489AbhKYHxU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:53:20 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AcmGNzKkXlxl8k2USS7zol0no5gydJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzFUxmIbXmHTPP2CajD3L911a4uz/RkPuJeGnN4yGlRp+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYueJQUVUj/nSH+OlUrO?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHg4Z3LkR2eG5fr67A0ZK0sBqUW4fp6Gn1?=
 =?us-ascii?q?V3eIXJSpLbR2Zge+yhrWhRYFRam4LRCXwFNpH/Cg+kneCVrB7Ka0vip7ivbdwt?=
 =?us-ascii?q?ArcTOgTdRoGW/ckVA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AYzLPC6rbeJFn4jXiF8c2vA8aV5oFeYIsimQD?=
 =?us-ascii?q?101hICG9vPb5qyjk985rrCMc6QxhP03I9urwWpVoLUmzyXdV2/hoAV7AZniDhI?=
 =?us-ascii?q?LLFvAG0WPiqweQYBEWn9Q1vcxdmsNFeb7N5C9B4foSjjPYLz9b+rO6GdiT9IHj?=
 =?us-ascii?q?JitWPHtXgtpbgjuQt22gfXFLeA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890680"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 631D34D138CE
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:58 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:58 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:56 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 05/16] generic: add mmap CoW test for delalloc&destination extents
Date:   Thu, 25 Nov 2021 15:47:41 +0800
Message-ID: <20211125074752.274176-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 631D34D138CE.A03C8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents, some delalloc, some not.
(MMAP version of generic/195,194)

Also, add a check to make sure the delalloc block is accutally exist.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 common/reflink        |  3 +++
 tests/generic/904     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/904.out | 12 +++++++++
 3 files changed, 76 insertions(+)
 create mode 100755 tests/generic/904
 create mode 100644 tests/generic/904.out

diff --git a/common/reflink b/common/reflink
index ee60398e..38210673 100644
--- a/common/reflink
+++ b/common/reflink
@@ -296,6 +296,9 @@ _weave_reflink_holes_delalloc() {
 		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile
 		_pwrite_byte 0x62 $((blksz * i)) $blksz $dfile.chk
 	done
+	# make sure we actually got delalloc block
+	$FILEFRAG_PROG -v $dfile 2>&1 | grep -q delalloc || \
+		_notrun "test requires delayed allocation writes"
 }
 
 # Create a file of interleaved regular blocks and reflinked blocks
diff --git a/tests/generic/904 b/tests/generic/904
new file mode 100755
index 00000000..69703d70
--- /dev/null
+++ b/tests/generic/904
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 904
+#
+# Ensuring that copy on write in mmap mode works when the CoW
+# range originally covers multiple extents, some delalloc, some not.
+# (MMAP version of generic/195,194)
+#   - Create a file.
+#   - Reflink the odd blocks of the first file into the second file.
+#   - Buffered write the even blocks of the second file.
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
+_weave_reflink_holes_delalloc $blksz $nr $testdir/file3 >> $seqres.full
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
diff --git a/tests/generic/904.out b/tests/generic/904.out
new file mode 100644
index 00000000..cc993394
--- /dev/null
+++ b/tests/generic/904.out
@@ -0,0 +1,12 @@
+QA output created by 904
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-904/file1
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-904/file3
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-904/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-904/file1
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-904/file3
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-904/file3.chk
-- 
2.34.0



