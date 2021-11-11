Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF40C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60266162E
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhKKIyK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32308 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232022AbhKKIyF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:05 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AuUMKQ6sdCKe3YfVbIpWDdi8HAefnVEpcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3zGtJXG/UaKmNZGXxLd9yad6z8R5X7J6Ex9VlSVBk/n9gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?dYngsLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6JPJlhGeKiuEL/JGSRte0Zcj0uhsHWx?=
 =?us-ascii?q?V6ecwNj8AdFaAiviwzbb9TfNj7vnPhuGD0Jg34ykmlG+GS619B82rfkkD3vcAt?=
 =?us-ascii?q?B9YuyyENam2ixIlVAdS?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AmNT4kaArvW8Z0ErlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214018"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:12 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 045464D10A15
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:11 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:09 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:09 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 03/13] generic: add mmap CoW test for unwritten&destination extents
Date:   Thu, 11 Nov 2021 16:50:56 +0800
Message-ID: <20211111085106.937684-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
References: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 045464D10A15.AE912
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ensuring that copy on write in mmap mode works when the CoW range originally
covers multiple extents, some unwritten, some not.
(MMAP version of generic/189,188)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/911     | 59 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/911.out | 12 +++++++++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/generic/911
 create mode 100644 tests/generic/911.out

diff --git a/tests/generic/911 b/tests/generic/911
new file mode 100755
index 00000000..962a7dac
--- /dev/null
+++ b/tests/generic/911
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. xxx
+#
+# Ensuring that copy on write in mmap mode works when the CoW
+# range originally covers multiple extents, some unwritten, some not.
+# (MMAP version of generic/189,188)
+#   - Create a file and fallocate a second file.
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
+_weave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
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
diff --git a/tests/generic/911.out b/tests/generic/911.out
new file mode 100644
index 00000000..8e41bdf6
--- /dev/null
+++ b/tests/generic/911.out
@@ -0,0 +1,12 @@
+QA output created by 911
+Format and mount
+Create the original files
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-911/file1
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-911/file3
+fa50dba51826899c372464a153cb2117  SCRATCH_MNT/test-911/file3.chk
+mmap CoW across the transition
+Compare files
+bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-911/file1
+09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-911/file3
+09101629908f9bdd5d178e7ce20bb1bb  SCRATCH_MNT/test-911/file3.chk
-- 
2.33.0



