Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE8C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 08:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhLNITb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 03:19:31 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11436 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231812AbhLNITb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 03:19:31 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AuGQirKoKBG1NmVU9M5Kktcc2G/JeBmIxZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjAaXT+GOP7ZZWKjf9EgO4639k0OsJ7WzdAxHldlq3syQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUbe?=
 =?us-ascii?q?eY3wpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXDnxKWLyu0qxlpJARsVWECwc57A35?=
 =?us-ascii?q?J8/MwKz0XaB2HweWsz9qTRPJwi98/N+H1M44F/HJt1zfUCbAhW5+rfklgzbe0x?=
 =?us-ascii?q?x9p3oYXQ6mYPJFfNFJSgN37S0UnEj8q5FgWwY9EXkXCTgA=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyKBZhag6YLzP9Ik4doTdPDJfK3BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118878480"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 16:19:27 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 70FE14D144A0;
        Tue, 14 Dec 2021 16:19:21 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:21 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 16:19:19 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 10/17] generic: add mmap CoW test for holes&source extents
Date:   Tue, 14 Dec 2021 16:19:07 +0800
Message-ID: <20211214081914.2478122-11-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 70FE14D144A0.AFE81
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode to the source file when the CoW range
covers holes and regular shared blocks.
(MMAP version of generic/291,292)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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
2.34.1



