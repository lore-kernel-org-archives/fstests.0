Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267FFC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA6B61267
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhKKIyE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34979 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232022AbhKKIyD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:03 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AqjFhFKCmMPhh6RVW/zXhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fVwO80WxzhjAFmmMaUGiBaf2Da2f9fNggat/n9UxSuJKAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkERcwmj/3auK49CAljfnVLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPIcoeOfeCTXXcu7iheun2HX6/t1EEwtIZYw5Ol6Gyd?=
 =?us-ascii?q?N+OYeJTRLaQqM799aaprTpvJE35xldZe0ethE/CwI8N0QNt5+KbirfkkAzYIwM?=
 =?us-ascii?q?O8Mu/1z?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ANPWU/K8VqD+2vAlzmIpuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214014"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:12 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9F6FD4D10A18
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:11 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:12 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:10 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 05/13] generic: add mmap CoW test for delalloc&destination extents
Date:   Thu, 11 Nov 2021 16:50:58 +0800
Message-ID: <20211111085106.937684-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
References: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9F6FD4D10A18.A0F1D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents, some delalloc, some not.
(MMAP version of generic/195,194)

Also, add a check to make sure the delalloc block accutally exists.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 common/reflink        |  3 +++
 tests/generic/913     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/913.out | 12 +++++++++
 3 files changed, 76 insertions(+)
 create mode 100755 tests/generic/913
 create mode 100644 tests/generic/913.out

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
diff --git a/tests/generic/913 b/tests/generic/913
new file mode 100755
index 00000000..c02886fa
--- /dev/null
+++ b/tests/generic/913
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
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
diff --git a/tests/generic/913.out b/tests/generic/913.out
new file mode 100644
index 00000000..1f08400e
--- /dev/null
+++ b/tests/generic/913.out
@@ -0,0 +1,12 @@
+QA output created by 913
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-913/file1
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-913/file3
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-913/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-913/file1
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-913/file3
+55968a95dfc0120df4e8485576514320  SCRATCH_MNT/test-913/file3.chk
-- 
2.33.0



