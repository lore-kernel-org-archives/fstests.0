Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD97C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbhKYH7J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:59:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34883 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240032AbhKYH5S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:57:18 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A0mF6aK6yZcVLh+i8C5CznAxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1DUEnDcYWWuPa/bbZWTyc49wPonj9E1SsZfcy4VjTVE5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+OmVba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCfv4JTNnxGun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpsm8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AbNE46Kg7uhv0jW1BFRrAYSZmonBQXvQji2hC?=
 =?us-ascii?q?6mlwRA09TyVXraCTdL9x726MtN9xYgBGpTnuAtjjfZqxz/BICKgqTM+ftWrdyQ?=
 =?us-ascii?q?+VxeNZnO7fKzyJIVyEygc1784JGJSWY+eAbmSS+vyX3ODXKbcdKaO8mpxA/d2u?=
 =?us-ascii?q?qUuFETsaEZ2IlD0VNu4neXcYeDV7?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890684"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 84F8A4D138C7
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:59 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:48:00 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:57 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 09/16] generic: add mmap CoW test for holes&source extents
Date:   Thu, 25 Nov 2021 15:47:45 +0800
Message-ID: <20211125074752.274176-10-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 84F8A4D138C7.A06C1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode to the source file when the CoW range
covers holes and regular shared blocks.
(MMAP version of generic/291,292)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/908     | 62 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/908.out | 12 +++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/generic/908
 create mode 100644 tests/generic/908.out

diff --git a/tests/generic/908 b/tests/generic/908
new file mode 100755
index 00000000..ad8de699
--- /dev/null
+++ b/tests/generic/908
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 908
+#
+# Ensuring that copy on write in mmap mode to the source file when the
+# CoW range covers holes and regular shared blocks.
+# (MMAP version of generic/291,292)
+#   - Create two files.
+#   - Truncate the first file.
+#   - Write the odd blocks of the first file.
+#   - Reflink the odd blocks of the first file into the second file.
+#   - mmap CoW the first file across the halfway mark, starting with the
+#     regular extent.
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
+_sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file1.chk | _filter_scratch
+
+echo "mmap CoW across the transition"
+cowoff=$((filesize / 4))
+cowsz=$((filesize / 2))
+mmapsz=$((cowoff + cowsz))
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1 >> $seqres.full
+_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+md5sum $testdir/file1 | _filter_scratch
+md5sum $testdir/file3 | _filter_scratch
+md5sum $testdir/file1.chk | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/908.out b/tests/generic/908.out
new file mode 100644
index 00000000..c8c670ac
--- /dev/null
+++ b/tests/generic/908.out
@@ -0,0 +1,12 @@
+QA output created by 908
+Format and mount
+Create the original files
+Compare files
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-908/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-908/file3
+b8a8a88d4c143f79900c4b4e79aa3e37  SCRATCH_MNT/test-908/file1.chk
+mmap CoW across the transition
+Compare files
+e8cf59797f0b3758c8878c368bb4cf7e  SCRATCH_MNT/test-908/file1
+ce2023f765eba19677517c511886d5c9  SCRATCH_MNT/test-908/file3
+e8cf59797f0b3758c8878c368bb4cf7e  SCRATCH_MNT/test-908/file1.chk
-- 
2.34.0



