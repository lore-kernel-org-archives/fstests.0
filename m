Return-Path: <SRS0=fS5H=D2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A924C433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 03:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F366222283
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 03:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgJSDCA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Oct 2020 23:02:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59196 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728538AbgJSDCA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Oct 2020 23:02:00 -0400
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; 
   d="scan'208";a="100279417"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Oct 2020 11:01:57 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 31A32486A854;
        Mon, 19 Oct 2020 11:01:56 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 19 Oct 2020 11:01:57 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v2] generic/402: Drop useless fail message
Date:   Mon, 19 Oct 2020 11:01:59 +0800
Message-ID: <1603076519-14005-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20201018101058.GY3853@desktop>
References: <20201018101058.GY3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 31A32486A854.A9FB0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Here won't be "scratch mount failed" messages when mounting SCRATCH_DEV
failed, because _scratch_mount exits early by invoking the following_fail.

_scratch_mount
{
        _try_scratch_mount $* || _fail "mount failed"
}

The message is useless and redundant. So drop it.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/402 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/402 b/tests/generic/402
index 7fc81864..ddaadf6d 100755
--- a/tests/generic/402
+++ b/tests/generic/402
@@ -102,7 +102,7 @@ run_test()
 }
 
 _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
-_scratch_mount || _fail "scratch mount failed"
+_scratch_mount
 
 _require_timestamp_range $SCRATCH_DEV
 
-- 
2.23.0



