Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CE3C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 04:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiGTEpR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 00:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiGTEpR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 00:45:17 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A92C0F
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 21:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658292313; i=@fujitsu.com;
        bh=2Q/da6yYy6ZTDqxekZr5kpgHWbvOSEPd9M6BCI9UrV4=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=RPy7GWxotHHJCdbO7UPNZWqlGon2mpiF4bcDR2lT732v9L/fpoN72cTC1To30vewb
         r6bcnvjRHRZhoGHPnr6k+9Qr6UEX5138vnZsaYPZK3aaXA1ychwCars8nFFCLZb3k6
         1qt8U5V4YMqx5CpV7UJzu10lCSk0mNmm3LJdy6tznecaZD6lxR4whGos5ktgi7E1lx
         W2wodz6Gap5PmrzFvf3Eeu1ohYXI4EJ7fzFSr12q1uNbXVzbOP2H40R3SrakXem9WZ
         TIA50ZIXDNB8UuySpPSfiEUkto7rbENQiWsbihaqRQtJr7GbV/3rEtgNafcwwhAk6Y
         NJJSNr06SgW9w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsViZ8ORpBvRcT3
  JYF4vp8XlJ3wWp1v2sjsweWxa1cnm8XmTXABTFGtmXlJ+RQJrxqH+aywFp3gqdi/ewNzAeIer
  i5GLQ0hgI6PEuQn72SCcJUwSt1ovMEE4exglphy/xdrFyMnBJqAp8axzATOILSIgK/F/xmomE
  JtZwEbi0NwpbCC2sECwxNwTn4BqODhYBFQlbj03AwnzCnhIfL2+lhHElhBQkJjy8D0zRFxQ4u
  TMJywQYyQkDr54wQxRoyhxqeMbVH2FxOvDl6DiahJXz21insDIPwtJ+ywk7QsYmVYx2iYVZaZ
  nlOQmZuboGhoY6BoamgJpY11DEyO9xCrdRL3UUt28/KKSDF1DvcTyYr3U4mK94src5JwUvbzU
  kk2MwFBNKU7v28G4cd8vvUOMkhxMSqK86f+vJQnxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4F3cf
  j1JSLAoNT21Ii0zBxg3MGkJDh4lEV6+FqA0b3FBYm5xZjpE6hSjMcfBXfv3MnOsbTiwl1mIJS
  8/L1VKnHciyCQBkNKM0jy4QbB4vsQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmNcOZApPZl4
  J3L5XQKcwAZ0yyekKyCkliQgpqQYm309qmnPFgl53XZo+eW7QpwXtLM2fo4WzSj9dbC27xv3V
  486dX9//Hji49qPtvdDOnU5TNU7KOStWlO/ZXDmpPEFjwolZDA0lInx8TnILPmpb73kw69Tug
  k/bpEz15x4RvB78Y4HOxwMbqz7t0LHlffG65WS59r6i2L0aN+xmHpgyY569+h9mye8R/28fsj
  upP39bSs59xlfbnZxX7zzkMcN1J6tOrOpBv+o7Ubtf/9tzVfb1XYbQmFdRR2a2bL+02M8v91n
  mjquO72I0myda1Jcf8WksSX0y/WnwTpHTLJbns3T+KaeuZP+uG33ScsO5bYeXnDprYsjGefX1
  5znHfKZutDv0S7EyzuhTrNr0Yx5KLMUZiYZazEXFiQBqK3fZYgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-728.messagelabs.com!1658292311!27398!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14723 invoked from network); 20 Jul 2022 04:45:12 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-3.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Jul 2022 04:45:12 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 8F1D61AF;
        Wed, 20 Jul 2022 05:45:11 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 83E7C1AE;
        Wed, 20 Jul 2022 05:45:11 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 20 Jul 2022 05:45:09 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <djwong@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] xfs/549: test mkfs.xfs whether terminate getsubopt arrays properly
Date:   Wed, 20 Jul 2022 13:45:37 +0800
Message-ID: <1658295937-2169-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
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
Then I found Darrick has fixed this one weeks ago. So add this test.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/549     | 33 +++++++++++++++++++++++++++++++++
 tests/xfs/549.out |  2 ++
 2 files changed, 35 insertions(+)
 create mode 100755 tests/xfs/549
 create mode 100644 tests/xfs/549.out

diff --git a/tests/xfs/549 b/tests/xfs/549
new file mode 100755
index 00000000..31ead3c7
--- /dev/null
+++ b/tests/xfs/549
@@ -0,0 +1,33 @@
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
+testfile=$TEST_DIR/a
+rm -rf $testfile
+
+$MKFS_XFS_PROG -f -d agcount=4 -d file,name=$testfile,nrext64=0 \
+	>> $seqres.full  2>&1
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

