Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC1BC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AD361101
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhKEDpA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Nov 2021 23:45:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35807 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230395AbhKEDo7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Nov 2021 23:44:59 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AX53fb6rQeDtdgaHGEoAbmxdibf9eBmIEZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjBNWGjVPv+DazfzLdF1ao6y9E1U7Z+HzddmTgQ/pHs2QiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?dYn0pHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXNnhSYKyOyqxlpJARsVWECwc55Gn1?=
 =?us-ascii?q?D7uADAC4CYwrFhO+sxr+/DO52iawewGPDVG8Ekig4i2iHUrB9GtaeK5gmLORwh?=
 =?us-ascii?q?F8Y7v2i196FDybBVQdSUQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3An9iwZqPX5HHzk8BcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="116916006"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2021 11:42:19 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 44D674D10102
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 11:42:16 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 11:42:11 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 11:42:10 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 5 Nov 2021 11:42:08 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 1/5] generic/xxx: Add MMAP CoW test for 'regular' case
Date:   Fri, 5 Nov 2021 11:41:56 +0800
Message-ID: <20211105034200.143626-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
References: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 44D674D10102.ACA67
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
the second block is a regular block.  (MMAP version of generic/205,206)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/900     | 75 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/900.out |  6 ++++
 2 files changed, 81 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..b608e314
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,75 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# See what happens if we MMAP CoW blocks 2-4 of a page's worth of blocks when
+# the second block is a regular block.  (MMAP version of generic/205,206)
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
+_pwrite_byte 0x61 $blksz $blksz $testdir/file2 >> $seqres.full
+_pwrite_byte 0x61 $blksz $blksz $testdir/file2.chk >> $seqres.full
+
+_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2 >> $seqres.full
+_pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
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
diff --git a/tests/generic/900.out b/tests/generic/900.out
new file mode 100644
index 00000000..2abfd789
--- /dev/null
+++ b/tests/generic/900.out
@@ -0,0 +1,6 @@
+QA output created by 900
+Format and mount
+Create the original files
+Compare files
+CoW and unmount
+Compare files
-- 
2.33.0



