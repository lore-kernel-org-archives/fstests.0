Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A01C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 01:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbiETBfm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 21:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiETBfl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 21:35:41 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A330C9BACD
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 18:35:40 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3An9EfE6rQTpl+fYUPJn3eTIXKK+peBmIxZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmIZCGqFa/aCNDPye9EkaI6+8UsEu5KDx9VrS1Fo/ns9QiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JbPlBOfLCu1qxlpJARsVWECwc57A35?=
 =?us-ascii?q?J8/MwKz0XaB2HweWsz9qTRPJwi98/N+H1M44F/HJt1zfUCbAhW5+rfklgzbe0x?=
 =?us-ascii?q?x9p3oYXQ6mYPJFfNFJSgN37S0UnEj8q5FgWwI9EXkXCTgA=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/hSyGa1s/WFHsRcK4uNDiwqjBFYkLtp133Aq?=
 =?us-ascii?q?2lEZdPRUGvb3qynIpoV86faUskdpZJhOo7C90cW7LU80sKQFhLX5Xo3SOzUO2l?=
 =?us-ascii?q?HYT72KhLGKq1aLdhEWtNQtsZuIGJIeNDSfNzdHZL7BkWuF+sgbsaS62ZHtleHD?=
 =?us-ascii?q?1G1sUA0vT6lh6j1yAgGdHlYefng8ObMJUIqb+tFcpyetPVAebsGADHEDWOTZ4/?=
 =?us-ascii?q?LRkpaOW299OzcXrBmJkSiz6KP3VzyR3hIlWTtJxrs4tUjp+jaJnpmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124361781"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 May 2022 09:35:38 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0A9114D17198;
        Fri, 20 May 2022 09:35:37 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 20 May 2022 09:35:37 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 20 May 2022 09:35:37 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 2/3] xfs: add memory failure test for dax&reflink mode
Date:   Fri, 20 May 2022 09:35:33 +0800
Message-ID: <20220520013534.2894233-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
References: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0A9114D17198.AF024
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Verify that the dax-rmap feature works.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org> 
---
 tests/xfs/901     | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/901.out |  9 +++++++++
 2 files changed, 58 insertions(+)
 create mode 100755 tests/xfs/901
 create mode 100644 tests/xfs/901.out

diff --git a/tests/xfs/901 b/tests/xfs/901
new file mode 100755
index 00000000..26c1581e
--- /dev/null
+++ b/tests/xfs/901
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 901
+#
+# Test memory failure mechanism when dax and reflink working together
+#
+. ./common/preamble
+_begin_fstest auto quick clone dax
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_require_check_dmesg
+_require_scratch_reflink
+_require_cp_reflink
+_require_xfs_scratch_rmapbt
+_require_scratch_dax_mountopt "dax"
+_require_test_program "t_mmap_cow_memory_failure"
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount "-o dax" >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+echo "Create the original files"
+filesize=65536
+_pwrite_byte 0x61 0 $filesize $testdir/testfile >> $seqres.full
+_cp_reflink $testdir/testfile $testdir/poisonfile >> $seqres.full
+_scratch_cycle_mount "dax"
+
+echo "Inject memory failure (1 page)"
+# create two processes:
+#  process1: mread 1 page to cause page fault, and wait
+#  process2: mread 1 page to cause page fault, then inject poison on this page
+$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/poisonfile
+
+echo "Inject memory failure (2 pages)"
+$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/poisonfile
+
+_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
+_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
+
+# success, all done
+status=0
diff --git a/tests/xfs/901.out b/tests/xfs/901.out
new file mode 100644
index 00000000..92d64846
--- /dev/null
+++ b/tests/xfs/901.out
@@ -0,0 +1,9 @@
+QA output created by 901
+Format and mount
+Create the original files
+Inject memory failure (1 page)
+Inject poison...
+Process is killed by signal: 7
+Inject memory failure (2 pages)
+Inject poison...
+Process is killed by signal: 7
-- 
2.35.1



