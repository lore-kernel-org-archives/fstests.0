Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2D7C2D0A3
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Nov 2020 02:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7A8205ED
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Nov 2020 02:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgKJCfB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:35:01 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:5946 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727311AbgKJCfA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Nov 2020 21:35:00 -0500
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; 
   d="scan'208";a="101125476"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Nov 2020 10:34:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 2475B48990FC
        for <fstests@vger.kernel.org>; Tue, 10 Nov 2020 10:34:55 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 10 Nov 2020 10:34:53 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 10 Nov 2020 10:34:52 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/426: Remove unused opt variable in create_test_files()
Date:   Tue, 10 Nov 2020 10:25:26 +0800
Message-ID: <20201110022526.7149-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 2475B48990FC.A99A0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/426 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/426 b/tests/generic/426
index e34d0aca..0bb75f81 100755
--- a/tests/generic/426
+++ b/tests/generic/426
@@ -43,7 +43,6 @@ mkdir -p $testdir
 create_test_files()
 {
 	local dir=$1
-	local opt=$2
 
 	mkdir -p $dir
 	rm -f $dir/*
-- 
2.21.0



