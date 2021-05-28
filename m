Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D7C47087
	for <linux-fstests@archiver.kernel.org>; Fri, 28 May 2021 09:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEE860E0B
	for <linux-fstests@archiver.kernel.org>; Fri, 28 May 2021 09:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhE1JgO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 May 2021 05:36:14 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2391 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbhE1JgM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 May 2021 05:36:12 -0400
Received: from dggeml762-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FrzvP3rbgz65bP;
        Fri, 28 May 2021 17:30:57 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggeml762-chm.china.huawei.com (10.1.199.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:34:36 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 17:34:35 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>, <djwong@kernel.org>
CC:     <sunke32@huawei.com>
Subject: [PATCH] xfs: fix check of whether the mkfs fail
Date:   Fri, 28 May 2021 05:40:46 -0400
Message-ID: <20210528094046.1920724-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The return value ("$?") is always the status of the last command in the pipe.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/xfs/070 | 3 ++-
 tests/xfs/448 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/070 b/tests/xfs/070
index 8249c5c01cfd..9ef1e786a0a5 100755
--- a/tests/xfs/070
+++ b/tests/xfs/070
@@ -84,7 +84,8 @@ _supported_fs xfs
 _require_scratch_nocheck
 _require_command "$KILLALL_PROG" killall
 
-_scratch_mkfs | _filter_mkfs > /dev/null 2> $tmp.mkfs || _fail "mkfs failed"
+_scratch_mkfs | _filter_mkfs > /dev/null 2> $tmp.mkfs
+test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed"
 
 . $tmp.mkfs # import agcount
 
diff --git a/tests/xfs/448 b/tests/xfs/448
index 493d303e62cf..a11698fa2d8c 100755
--- a/tests/xfs/448
+++ b/tests/xfs/448
@@ -47,7 +47,8 @@ _require_no_xfs_bug_on_assert
 rm -f "$seqres.full"
 
 # Format and mount
-_scratch_mkfs | _filter_mkfs > $seqres.full 2> $tmp.mkfs || _fail "mkfs failed"
+_scratch_mkfs | _filter_mkfs > $seqres.full 2> $tmp.mkfs
+test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed"
 _scratch_mount
 
 # Get directory block size
-- 
2.25.4

