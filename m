Return-Path: <SRS0=fsOW=DS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA57DC433E7
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 02:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9272072D
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 02:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgJKCOM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 10 Oct 2020 22:14:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18694 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726473AbgJKCOL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 10 Oct 2020 22:14:11 -0400
X-IronPort-AV: E=Sophos;i="5.77,361,1596470400"; 
   d="scan'208";a="100043863"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Oct 2020 10:14:09 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 4323E48990D7;
        Sun, 11 Oct 2020 10:14:07 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sun, 11 Oct 2020 10:14:08 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/611: Filter getfattr output
Date:   Sun, 11 Oct 2020 10:14:24 +0800
Message-ID: <1602382464-1230-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 4323E48990D7.A9E04
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When using old version(such as getfattr 2.4.46) getfattr command, it
has the following output,

touch file
setfattr -n user.a file
getfattr --absolute-names -n user.a file
user.a

on new getfattr, it reports the following output,
getfattr --absolute-names -n user.a file
user.a=""

Filter doubt quotes and equals, so this case can pass.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/611     | 2 +-
 tests/generic/611.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/611 b/tests/generic/611
index f4158bb3..c697b39a 100755
--- a/tests/generic/611
+++ b/tests/generic/611
@@ -51,7 +51,7 @@ touch "${localfile}"
 _scratch_cycle_mount
 
 # If the target bug isn't fixed, getfattr fails
-${GETFATTR_PROG} --absolute-names -n user.a $localfile | grep 'user.a'
+${GETFATTR_PROG} --absolute-names -n user.a $localfile | grep 'user.a' | sed 's/=""//g'
 
 status=0
 exit
diff --git a/tests/generic/611.out b/tests/generic/611.out
index 1ab12434..8ccf52f0 100644
--- a/tests/generic/611.out
+++ b/tests/generic/611.out
@@ -1,2 +1,2 @@
 QA output created by 611
-user.a=""
+user.a
-- 
2.23.0



