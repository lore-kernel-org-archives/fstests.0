Return-Path: <SRS0=iucR=7Q=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74B0C433E0
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Jun 2020 14:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA96220679
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Jun 2020 14:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCOHt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:07:49 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41828 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725833AbgFCOHt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Jun 2020 10:07:49 -0400
X-IronPort-AV: E=Sophos;i="5.73,467,1583164800"; 
   d="scan'208";a="93765252"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2020 22:07:43 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 31A0A50A999D;
        Wed,  3 Jun 2020 22:07:42 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 3 Jun 2020 22:07:42 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 3 Jun 2020 22:07:42 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 4/4] xfs/260: Move xfs/260 to generic
Date:   Wed, 3 Jun 2020 22:01:15 +0800
Message-ID: <20200603140115.30392-4-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200603140115.30392-1-yangx.jy@cn.fujitsu.com>
References: <20200603140115.30392-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 31A0A50A999D.A9B27
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Both ext4 and xfs support per-inode DAX flag now so move it to generic.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/{xfs/260 => generic/602} | 12 ++++++++----
 tests/generic/602.out          |  2 ++
 tests/generic/group            |  1 +
 tests/xfs/260.out              |  2 --
 tests/xfs/group                |  1 -
 5 files changed, 11 insertions(+), 7 deletions(-)
 rename tests/{xfs/260 => generic/602} (91%)
 create mode 100644 tests/generic/602.out
 delete mode 100644 tests/xfs/260.out

diff --git a/tests/xfs/260 b/tests/generic/602
similarity index 91%
rename from tests/xfs/260
rename to tests/generic/602
index fbdc4cd8..0cd20f31 100755
--- a/tests/xfs/260
+++ b/tests/generic/602
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
 #
-# FS QA Test 260
+# FS QA Test 602
 #
 # Test per-inode DAX flag by mmap direct/buffered IO.
 #
@@ -28,7 +28,7 @@ _cleanup()
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux
 _require_scratch_dax_mountopt "dax"
 _require_test_program "feature"
@@ -121,8 +121,12 @@ do_tests()
 	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
 }
 
-# make xfs 2Mb aligned for PMD fault testing
-_scratch_mkfs "-d su=2m,sw=1" > /dev/null 2>&1
+# make 2Mb aligned for PMD fault testing
+mkfs_opts=""
+[ "$FSTYP" = "ext4" ] && mkfs_opts="-E stride=512,stripe_width=1"
+[ "$FSTYP" = "xfs" ] && mkfs_opts="-d su=2m,sw=1"
+
+_scratch_mkfs "$mkfs_opts" > /dev/null 2>&1
 
 # mount with dax option
 _scratch_mount "-o dax"
diff --git a/tests/generic/602.out b/tests/generic/602.out
new file mode 100644
index 00000000..61976e5e
--- /dev/null
+++ b/tests/generic/602.out
@@ -0,0 +1,2 @@
+QA output created by 602
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index c6ce029c..4bda3772 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -604,3 +604,4 @@
 599 auto quick remount shutdown
 600 auto quick quota
 601 auto quick quota
+602 auto attr quick dax
diff --git a/tests/xfs/260.out b/tests/xfs/260.out
deleted file mode 100644
index 18ca517c..00000000
--- a/tests/xfs/260.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 260
-Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index daf54add..71c30898 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -257,7 +257,6 @@
 257 auto quick clone
 258 auto quick clone
 259 auto quick
-260 auto attr quick dax
 261 auto quick quota
 262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 263 auto quick quota
-- 
2.21.0



