Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64830C433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48ADF61101
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhKEDo7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Nov 2021 23:44:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47127 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229587AbhKEDo6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Nov 2021 23:44:58 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AM5bRGq6HWLbfLW461WTxkwxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1mMHmGEWXz+Pb/2MZzP3LtlzPI7j8h8D7MPdyNVrHAY5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+OkVba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCbu6JLLlxCun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpkm8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgthSUaN/BlwKJ8BcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="116916005"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2021 11:42:19 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 5E35C4D10107
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 11:42:16 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 11:42:12 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 5 Nov 2021 11:42:09 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 2/5] generic/xxx: Add MMAP CoW test for 'unwritten' case
Date:   Fri, 5 Nov 2021 11:41:57 +0800
Message-ID: <20211105034200.143626-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
References: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5E35C4D10107.AF0CF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
the second block is a unwritten block.  (MMAP version of generic/216,217)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/901     | 76 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/901.out |  6 ++++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/generic/901
 create mode 100644 tests/generic/901.out

diff --git a/tests/generic/901 b/tests/generic/901
new file mode 100755
index 00000000..2aae5f6d
--- /dev/null
+++ b/tests/generic/901
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
+# the second block is a unwritten block.  (MMAP version of generic/216,217)
+#
+# This test is dependent on the system page size, so we cannot use md5 in
+# the golden output; we can only compare to a check file.
+#
+. ./common/preamble
+_begin_fstest auto quick clone
+
+# Override the default cleanup function.
+_cleanup()
+{
+    cd /
+    rm -rf $tmp.* $testdir
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_require_scratch_reflink
+_require_xfs_io_command "falloc"
+
+pagesz=$(getconf PAGE_SIZE)
+blksz=$((pagesz / 4))
+
+echo "Format and mount"
+_scratch_mkfs_blocksized $blksz > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+real_blksz=$(_get_file_block_size $testdir)
+test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
+
+echo "Create the original files"
+_pwrite_byte 0x61 0 $pagesz $testdir/file1 >> $seqres.full
+
+$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2 >> $seqres.full
+$XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2.chk >> $seqres.full
+
+$XFS_IO_PROG -f -c "falloc -k $blksz $blksz" $testdir/file2 >> $seqres.full
+_pwrite_byte 0x00 $blksz $blksz $testdir/file2.chk >> $seqres.full
+
+$XFS_IO_PROG -f -c "falloc -k $((blksz * 3)) $blksz" $testdir/file2 >> $seqres.full
+_pwrite_byte 0x00 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
+
+_reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
+_pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
+cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't match."
+
+echo "CoW and unmount"
+$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
+    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
+$XFS_IO_PROG -f -c "mmap 0 $pagesz" \
+    -c "mwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
+cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't match."
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/901.out b/tests/generic/901.out
new file mode 100644
index 00000000..07b9b433
--- /dev/null
+++ b/tests/generic/901.out
@@ -0,0 +1,6 @@
+QA output created by 901
+Format and mount
+Create the original files
+Compare files
+CoW and unmount
+Compare files
-- 
2.33.0



