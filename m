Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CCCC43334
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jun 2022 02:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbiFJCgE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiFJCf7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Jun 2022 22:35:59 -0400
Received: from out20-159.mail.aliyun.com (out20-159.mail.aliyun.com [115.124.20.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88580B5247
        for <fstests@vger.kernel.org>; Thu,  9 Jun 2022 19:35:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.343362|-1;BR=01201311R101S71rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.110168-0.0153295-0.874502;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.O1M3roV_1654828553;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O1M3roV_1654828553)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 10:35:54 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fstests@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] generic/297: fix the delta time based on stat
Date:   Fri, 10 Jun 2022 10:35:53 +0800
Message-Id: <20220610023553.24418-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

stat -c '%Y' report seconds as int, so the delta 2.01s may result as 3s.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 tests/generic/297 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/297 b/tests/generic/297
index 6bdc3e1c..e3082202 100755
--- a/tests/generic/297
+++ b/tests/generic/297
@@ -51,7 +51,7 @@ for i in $(seq 0 $fnr); do
 	touch $TEST_DIR/after
 	before=$(stat -c '%Y' $TEST_DIR/before)
 	after=$(stat -c '%Y' $TEST_DIR/after)
-	delta=$((after - before))
+	delta=$((after - before -1)) # 2.01s may result as 3s; so -1
 	test $delta -gt $timeout && break
 done
 
@@ -64,7 +64,7 @@ $TIMEOUT_PROG -s INT ${kill_after}s $XFS_IO_PROG -f -c "reflink $testdir/file1 0
 touch $TEST_DIR/after
 before=$(stat -c '%Y' $TEST_DIR/before)
 after=$(stat -c '%Y' $TEST_DIR/after)
-delta=$((after - before))
+delta=$((after - before - 1)) # 2.01s may result as 3s; so -1
 echo "reflink of $n bytes took $delta seconds" >> $seqres.full
 test $delta -gt $timeout && _fail "reflink didn't stop in time, n=$n t=$delta"
 
-- 
2.36.1

