Return-Path: <SRS0=M3Lt=2U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB97AC2D0C0
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Dec 2019 02:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68382075D
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Dec 2019 02:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfL3C6L (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 Dec 2019 21:58:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45453 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727048AbfL3C6L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Dec 2019 21:58:11 -0500
X-IronPort-AV: E=Sophos;i="5.69,373,1571673600"; 
   d="scan'208";a="80993381"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Dec 2019 10:58:08 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 83CC04CE14FC;
        Mon, 30 Dec 2019 10:49:16 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 30 Dec 2019 10:58:09 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 30 Dec 2019 10:58:09 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/386: fill missing brackets in awk
Date:   Mon, 30 Dec 2019 10:57:57 +0800
Message-ID: <1577674677-2545-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 83CC04CE14FC.A0D51
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since commit ea726c4a55c98 to check the correct field from df output,
it introduced a syntax error. Fix it.

Reported-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/386 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/386 b/tests/generic/386
index 1291dae0..03c010f7 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -89,7 +89,7 @@ _filter_quota_rpt() {
 			bsize = byte_size($4);
 		} else if ($NF ~ proj_dir) {
 			# this is the "df" output
-			bsize = byte_size($NF-4));
+			bsize = byte_size($(NF-4));
 		} else {
 			next;
 		}
-- 
2.18.0



