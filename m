Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B959BC33C99
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 06:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87673207E0
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 06:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgAGGbj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:31:39 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1323 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725267AbgAGGbj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 01:31:39 -0500
X-IronPort-AV: E=Sophos;i="5.69,404,1571673600"; 
   d="scan'208";a="81423182"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2020 14:31:36 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 06855406AB15;
        Tue,  7 Jan 2020 14:22:32 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 7 Jan 2020 14:31:29 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 7 Jan 2020 14:31:29 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <yangx.jy@cn.fujitsu.com>, <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] fsstress.c: Add header file stdbool.h
Date:   Tue, 7 Jan 2020 14:31:26 +0800
Message-ID: <1578378686-22832-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 06855406AB15.AB3F5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Compilation failed on Fedora 20 because stdbool.h is not included
in xfs/platform_defs-x86_64.h or xfs/linux.h on Fedora 20.

Also, yang xiao fixed similar problem(commit 234f51ebbd) for fsx.c in
2016.2, but after that, fsstress.c started to use bool variable without
including stdbool.h file. It may fail on old linux distributions, so
fix it.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 ltp/fsstress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index c5a59d51..709fdeec 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -8,6 +8,7 @@
 #include <setjmp.h>
 #include <sys/uio.h>
 #include <stddef.h>
+#include <stdbool.h>
 #include "global.h"
 
 #ifdef HAVE_BTRFSUTIL_H
-- 
2.18.0



