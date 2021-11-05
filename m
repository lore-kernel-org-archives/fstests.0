Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369BAC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E09E61246
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhKEDpO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Nov 2021 23:45:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:63855 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231201AbhKEDpN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Nov 2021 23:45:13 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AP2NJIaJad5qBadyuFE+RzZclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC8hzsh0WYAy2YdCDzSO6nZajOneIgjPIq1pE8Du5TSm4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+DzvuRGuK59yAljPnVHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToy+UltZq2ZNDs4esY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQfpu6efyDm4aR/yGWDKRMA2c5GAloqMJYE4c5pDmx?=
 =?us-ascii?q?Us/8VMjYAalaEne3e/V4RYoGAnex6dI+yYtxZ4SomkFnk4T8dacira833CRVwh?=
 =?us-ascii?q?V/cXvxzIMs=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/blDDqzVOA7lX50Uvx62KrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="116916018"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2021 11:42:31 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 597944D10108
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 11:42:28 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 11:42:21 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 5 Nov 2021 11:42:21 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 4/5] generic/xxx: Add MMAP CoW test for 'delalloc' case
Date:   Fri, 5 Nov 2021 11:41:59 +0800
Message-ID: <20211105034200.143626-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
References: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 597944D10108.AC4BB
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
the second block is delalloc.  (MMAP version of generic/222,227)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/903     | 76 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/903.out |  6 ++++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/generic/903
 create mode 100644 tests/generic/903.out

diff --git a/tests/generic/903 b/tests/generic/903
new file mode 100755
index 00000000..1e76fc9b
--- /dev/null
+++ b/tests/generic/903
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
+# the second block is delalloc.  (MMAP version of generic/222,227)
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
+_reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
+_pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
+_scratch_cycle_mount
+
+echo "Compare files"
+! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
+cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't match."
+
+echo "CoW and unmount"
+_pwrite_byte 0x61 $blksz $blksz $testdir/file2 >> $seqres.full
+_pwrite_byte 0x61 $blksz $blksz $testdir/file2.chk >> $seqres.full
+
+_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2 >> $seqres.full
+_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
+
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
diff --git a/tests/generic/903.out b/tests/generic/903.out
new file mode 100644
index 00000000..cfeeb11c
--- /dev/null
+++ b/tests/generic/903.out
@@ -0,0 +1,6 @@
+QA output created by 903
+Format and mount
+Create the original files
+Compare files
+CoW and unmount
+Compare files
-- 
2.33.0



