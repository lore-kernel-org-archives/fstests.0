Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88561C43334
	for <linux-fstests@archiver.kernel.org>; Fri, 22 Jul 2022 02:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiGVCms (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiGVCms (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 22:42:48 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C311868A2
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658457765; i=@fujitsu.com;
        bh=Pyj2CY86hX6N/Mc20tqrpkQ/vuN9sYXlagCO+rAv0ag=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Sb1iXMmtjUQ1nOpi3gN1VNa+alqEnLaZCIarQmepCq+9CDTzTvWCPI8hAO7lrvUd/
         IcG23ew3w7XQUMWSZqhIsy77GjhuHP7NLUfqlsLhS00FV+feWlcD1irIDhXaiVLel8
         Omv3EBOpTr2kUBweFiPg0YfEOFQ1IxLAfadTYX6THLNy/ejXR7Tm5I3rptMDflr9CU
         sU+UZPnExE7m0XTdFKhWdWCW6MwW/UmnTtrCUzNx213d6CMGA6e39P7QaW0oEDvYWE
         RcOvZ0Nf6jusN6CepIjIcKh9hS7oB2KNow2+jRql6mR3yhcQ/FVnUel1p2B/vzbHZS
         3WprBY3yrP5vw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRWlGSWpSXmKPExsViZ8MxSXcJ360
  kg7+dGhanW/ayOzB6fN4kF8AYxZqZl5RfkcCasfH7EqaCLTwVP5o/sTQwnuDqYuTiEBK4xCjx
  6OlzdgjnKJNEy8Q2pi5GTiBnD6PEvon2IDabgKbEs84FzCC2iICsxP8Zq8FqmAXUJZZP+gVmC
  wsESfw8twKshkVAVWLziu3sIDavgIfEzSuPwWwJAQWJKQ/fg9VwCthILFwzmw1il7XErWnXmS
  HqBSVOznzCAjFfQuLgixfMEL2KEpc6vjFC2BUSrw9fgoqrSVw9t4l5AqPgLCTts5C0L2BkWsV
  olVSUmZ5RkpuYmaNraGCga2hoqmtsrGtuopdYpZuol1qqW55aXKJrpJdYXqyXWlysV1yZm5yT
  opeXWrKJERjCKcWKXjsYX634qXeIUZKDSUmUd9+km0lCfEn5KZUZicUZ8UWlOanFhxhlODiUJ
  HiNeW8lCQkWpaanVqRl5gDjCSYtwcGjJML7jAMozVtckJhbnJkOkTrFaMxxcNf+vcwcaxsO7G
  UWYsnLz0uVEuc1AJkkAFKaUZoHNwgW55cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfO6gSz
  kycwrgdv3CugUJqBTzM1vgJxSkoiQkmpgsn++/Gfzi+B0gYbj3b1Cq09JL732avryZdl8f4/9
  lin0DTgfaXlQqSA3qG56Y8zmPambxQ92XTzh7Plq1Y+v63jz5vzKPcI0i9N0s/UrZuaWv7IO0
  56L9mRp1Gw6NcfGLmDjkSKGAE/jxnT3f+cOpnbxCUfkf2I/JtnClygyb3KMmfbnN50/WubMLW
  zy1Hz5+J0+w8ubbsDY4zcIsE7t4PVfpna+lvnZi6fxNktv7f8XsGZL0tmH+e8nN07PT2pq2bv
  G0O6Rc3/ohosGCxbflzhssu/2swzD5wsLt9+/8Kp++ubjzGs7KuLWXLz1quVumXyU78s7fQ8Y
  ytdf7Z7BWeN4fq77N0WjDPG1Xo+OKbEUZyQaajEXFScCANr1kC1uAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-565.messagelabs.com!1658457764!471642!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11069 invoked from network); 22 Jul 2022 02:42:44 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-13.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Jul 2022 02:42:44 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 606D61000DC
        for <fstests@vger.kernel.org>; Fri, 22 Jul 2022 03:42:44 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 540B6100077
        for <fstests@vger.kernel.org>; Fri, 22 Jul 2022 03:42:44 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 22 Jul 2022 03:42:34 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2] xfs: test mkfs.xfs whether terminate getsubopt arrays properly
Date:   Fri, 22 Jul 2022 11:43:04 +0800
Message-ID: <1658461384-2292-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20220721164308.p6gx2kfy6fjrbppz@zlang-mailbox>
References: <20220721164308.p6gx2kfy6fjrbppz@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When I run xfs/144 manually, the step as below:
mkfs.xfs -f -d agcount=3200,size=6366g -d file,n

I accidentally pressed the Enter key, it triggers Segmentation fault.
Then I found Darrick has fixed this one week ago. So add this test.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/549     | 29 +++++++++++++++++++++++++++++
 tests/xfs/549.out |  2 ++
 2 files changed, 31 insertions(+)
 create mode 100755 tests/xfs/549
 create mode 100644 tests/xfs/549.out

diff --git a/tests/xfs/549 b/tests/xfs/549
new file mode 100755
index 00000000..7d4fc8cf
--- /dev/null
+++ b/tests/xfs/549
@@ -0,0 +1,29 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+#
+# FS QA Test 549
+#
+# Regression test for xfsprogs commit
+# 50dba8189b1f ("mkfs: terminate getsubopt arrays properly")
+#
+# This case test mkfs.xfs whether can terminate getsubopt arrays properly.
+# If not, it will trigger segmentation fault.
+#
+
+. ./common/preamble
+_begin_fstest auto quick mkfs
+
+# real QA test starts here
+_supported_fs xfs
+_fixed_by_git_commit xfsprogs 50dba8189b1f \
+	"mkfs: terminate getsubopt arrays properly"
+_require_test
+
+$MKFS_XFS_PROG -f -d agcount=4 -d garbage=0 >> $seqres.full  2>&1
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/549.out b/tests/xfs/549.out
new file mode 100644
index 00000000..4e3acd3f
--- /dev/null
+++ b/tests/xfs/549.out
@@ -0,0 +1,2 @@
+QA output created by 549
+Silence is golden
-- 
2.23.0

