Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6939EC433B4
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Apr 2021 10:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451A4610CF
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Apr 2021 10:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIKdB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Apr 2021 06:33:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16432 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhDIKc4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Apr 2021 06:32:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGvXZ4GB8zvS3Q
        for <fstests@vger.kernel.org>; Fri,  9 Apr 2021 18:30:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 18:32:25 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <sunke32@huawei.com>
Subject: [PATCH] generic/591: tmpfs do not test with O_DIRECT flag
Date:   Fri, 9 Apr 2021 06:38:00 -0400
Message-ID: <20210409103800.2077384-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

tmpfs does not support the O_DIRECT flag, so when FSTYP is tmpfs,
do not test with O_DIRECT flag.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/generic/591 | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/generic/591 b/tests/generic/591
index d4020463..4b97a2fc 100755
--- a/tests/generic/591
+++ b/tests/generic/591
@@ -31,10 +31,18 @@ _require_test_program "splice-test"
 
 rm -f $seqres.full
 
-$here/src/splice-test -r $TEST_DIR/a
-$here/src/splice-test -rd $TEST_DIR/a
-$here/src/splice-test $TEST_DIR/a
-$here/src/splice-test -d $TEST_DIR/a
+if [ $FSTYP == "tmpfs" ]; then
+	echo "concurrent reader with O_DIRECT"
+	echo "concurrent reader with O_DIRECT"
+	$here/src/splice-test -rd $TEST_DIR/a
+	echo "sequential reader with O_DIRECT"
+	$here/src/splice-test -d $TEST_DIR/a
+else
+	$here/src/splice-test -r $TEST_DIR/a
+	$here/src/splice-test -rd $TEST_DIR/a
+	$here/src/splice-test $TEST_DIR/a
+	$here/src/splice-test -d $TEST_DIR/a
+fi
 
 # success, all done
 status=0
-- 
2.13.6

