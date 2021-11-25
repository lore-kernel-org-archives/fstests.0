Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14631C4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhKYH7K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:59:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49039 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345451AbhKYH5X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:57:23 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AdgcWuK534oPUMlGSP/rtWAxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENShD0OyWUXCz/TP/qMNzCnLdh+aInkoBhUupCHzNQ3G1c5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+OmVba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCfv4JTNnhCun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpwm8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Au+ApZKHr0fyXf6x3pLqExseALOsnbusQ8zAX?=
 =?us-ascii?q?Po5KKSC8Oaej5rmTdZUgpHjJYVkqKRMdcLy7VpVoYEmsjaKdgrNhWYtKPjOW3V?=
 =?us-ascii?q?dBLelZnPDfKlTbckWUygc379YCT0EIMrHN5DZB7PoSmjPTLz9Z+qjgzEn1v5al?=
 =?us-ascii?q?854Xd2xXgxwK1WhENjo=3D?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890695"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:48:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id A17F54D138C7
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:48:01 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:48:01 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:48:02 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:59 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 16/16] generic: add race test that mmap write to target of reflink
Date:   Thu, 25 Nov 2021 15:47:52 +0800
Message-ID: <20211125074752.274176-17-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A17F54D138C7.AFAB0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test for races or FS corruption when mmap writing to a file that's also
the target of a reflink operation. (MMAP version of generic/168,170)

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/915     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/915.out |  4 +++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/generic/915
 create mode 100644 tests/generic/915.out

diff --git a/tests/generic/915 b/tests/generic/915
new file mode 100755
index 00000000..365f304c
--- /dev/null
+++ b/tests/generic/915
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 915
+#
+# Test for races or FS corruption when mmap writing to a file that's also
+# the target of a reflink operation. (MMAP version of generic/168,170)
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
+echo "Initialize files"
+echo >> $seqres.full
+_pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
+_pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
+_scratch_cycle_mount
+
+# mmap overwriter...
+overwrite() {
+	while [ ! -e $finished_file ]; do
+		seq $nr_loops -1 0 | while read i; do
+			$XFS_IO_PROG -f -c "mmap -rw $((i * blksz)) $blksz" \
+				-c "mwrite -S 0x63 $((i * blksz)) $blksz" $testdir/file2 >> $seqres.full
+		done
+	done
+}
+
+echo "Reflink and mmap write the target"
+overwrite &
+seq 1 10 | while read j; do
+	seq 0 $nr_loops | while read i; do
+		_reflink_range  $testdir/file1 $((i * blksz)) \
+				$testdir/file2 $((i * blksz)) $blksz >> $seqres.full
+		[ $? -ne 0 ] && exit
+	done
+done
+touch $finished_file
+wait
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/915.out b/tests/generic/915.out
new file mode 100644
index 00000000..4e77847b
--- /dev/null
+++ b/tests/generic/915.out
@@ -0,0 +1,4 @@
+QA output created by 915
+Format and mount
+Initialize files
+Reflink and mmap write the target
-- 
2.34.0



