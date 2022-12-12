Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32E4C00145
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 23:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiLLXHu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Dec 2022 18:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiLLXHp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Dec 2022 18:07:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C895E1B
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 15:07:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g10so13672311plo.11
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 15:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HShScqi7kTR3PgX58TU3BpyMdgC0rv+6kWGSBz6ZE6M=;
        b=ZHDFrwhyqrOwUVm+icc9VrGuYB5BkS//XQ6Szdzub4SY3UQCJGojAmcVrqXGUXaAfJ
         IJrwE/F8p02+jBa7DBahM+eFEbLSbi7P3TEW0y/TveGEDrQkKjtZOq3BBGUqOQsl+3B3
         xbhljWYCil0BKKXoJbbtSxBduwByHOtF73mBaa8yxtE377+dmrx3NWMlJNix8hI43fkR
         Rpw8iseJm8yqtvdBlLCzpqrr3Ppd6S+tIoFGuoo1LRaDeYd2LhTvfgpKI5+0eDiymyoU
         7QQ85IoR/C3kQa+dYguHgw/oWxSwwZVrfofQnJNXb2NLjWM9mreD22mR2SoPZBE8oJ/H
         DbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HShScqi7kTR3PgX58TU3BpyMdgC0rv+6kWGSBz6ZE6M=;
        b=1Zcj9RQutWyZnuGVZv+RJel2XvFBB+dNo+XRwa4BW6m8U2mNVCO+O3mn97O71I0vGm
         mIIwzCuuYi9oqaJHQcRpHbmrJLHLh0yaufjDgRQklQM98k/W55Y/pg+xCAkXyiPchmkU
         1hZ4fUSA89sC+UQjGjm4KNmQRrGo+kjUex4J7Qzu6gj62glNo9CD+05oW4J1auTzShYr
         rUYd0J1fWbbTNw2dyg0DoiEh/qgJyGinXtMtzB6bYcA2t2rR5HSn/VwPrJjIZSqI9sm2
         ZwWsvgQt6OtlbChZBl/VTBWm/oL7NWmZjwcg6jdYn/XmreL8UQivcaQfGRlibKsUcS5b
         +Pbw==
X-Gm-Message-State: ANoB5pnz4tucRluqX2M/W59tteoHJTyc4JpN23tjmOyvOET11Rbowtjb
        1p4SH7e1D7wvIKB3tNcd/qIzTY6kjfs=
X-Google-Smtp-Source: AA0mqf7LwSX5O8rYprU0YGXO0q3c1tShTKT8TsJuxhwJQNGNL03Ljpz2TDu9J4tH3IaIAdujkjiNGQ==
X-Received: by 2002:a05:6a21:c00b:b0:a7:9fa4:d767 with SMTP id bm11-20020a056a21c00b00b000a79fa4d767mr21634039pzc.9.1670886460155;
        Mon, 12 Dec 2022 15:07:40 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2d4:203:d2a6:902a:fcf:d19a])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b00187022627d7sm6938140plw.36.2022.12.12.15.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:07:39 -0800 (PST)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH] check: use /var/tmp instead of /tmp
Date:   Mon, 12 Dec 2022 15:06:46 -0800
Message-Id: <20221212230646.4022294-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

With the results recorded in /tmp, a crashing test results in a loss
of all prior test runs. Instead, record results in /var/tmp so that
it is possible to recover results from completed tests.

Also, make sure tmp.arglist is wiped before each run to avoid
accidentally rerunning tests.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 check | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/check b/check
index d2e51296..21c00524 100755
--- a/check
+++ b/check
@@ -4,7 +4,7 @@
 #
 # Control script for QA
 #
-tmp=/tmp/$$
+tmp=/var/tmp/$$
 status=0
 needwrap=true
 needsum=true
@@ -46,7 +46,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
 
-rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
+rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
 
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
-- 
2.39.0.rc1.256.g54fd8350bd-goog

