Return-Path: <SRS0=y1X6=7S=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8C2C433DF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 23:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2BB206DB
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 23:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWDG5rxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgFEXbS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgFEXbS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Jun 2020 19:31:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421F4C08C5C2
        for <fstests@vger.kernel.org>; Fri,  5 Jun 2020 16:31:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so4281590plb.11
        for <fstests@vger.kernel.org>; Fri, 05 Jun 2020 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RC1PMbjKQLQzpXcUfGMx7BY/P+H6SHJliNjbzDvnHI=;
        b=pWDG5rxr4m7SHqCTknBxv35mCDzRLBwB0TQDz5l6wByKeS7AzHd9GQMPY+0QLoIo4j
         7kxdsPZx0qjM9aeFCqjvg/WMcvKZod9OaHkk2uHSsh5mcB4WbRJfx9WThKbO/kM/7oqQ
         vbVlPd3yJxqjC9XqkYTWtv2x44OTvrx0QOWVIOr1Hq0yvtMzST1EMh3+hvOP6RxeUj75
         pk1aG5biYlPlWaIxm1q8DP/jIJqhzFIVadETD5un/joMDntx/AwacOd10/zEDUjeRUBb
         iY9mqms52X1tRcquTkS+6yAAfdrxHngrqoTZmM7b8wfbUbQQJB2aYI+by3yRxoVbTuSk
         HOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RC1PMbjKQLQzpXcUfGMx7BY/P+H6SHJliNjbzDvnHI=;
        b=Fkwk2R548SNoEGbwxa9TQrf6R0Z0ILRWE+BKJXSGHBZk9I0SxDLBnTKBGT6UScNyHE
         GmPL2WDAgPF/BgmWvic4CrHycqHulQK0+sHE+jzT85IkPeYLQGsE70UgNU9zUFT8Pegh
         swCZFcxZiE0td/IJliPxmQ65aLCQYKyx6O80pJy6fPxJaO42fYab3o729in3VrGAdieC
         erI9Vdxd47ldTUEmIBw0vtGjIQ2Gr6l08OHSBKBdMwvkCoUZhwT3VWkn5kaGjV4dc0Oh
         24Fp2eldh+lX56MS8vl8SSu+TTwcYl4REZhxQ1rezKJlySTJzS+jcyRLFnQhJrMuCf/3
         BWpw==
X-Gm-Message-State: AOAM531ni+uI2uHxok7cTYOpyTqvtxOvKmEzzITwP/dUsMx8Md16XFU/
        y9zhsnXAtEe0wBRGZnNPfyUCm8oj
X-Google-Smtp-Source: ABdhPJzrPSSYq2RywSK3t9toK5gNy04zpFKkANYJ/57VHNomlpjLuBTMpO5nOOoggKH+10tT0eVOhw==
X-Received: by 2002:a17:90a:4495:: with SMTP id t21mr5511820pjg.185.1591399877446;
        Fri, 05 Jun 2020 16:31:17 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id nl11sm5257384pjb.0.2020.06.05.16.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:31:16 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshads@google.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: add empty lines to mkfs_filter
Date:   Fri,  5 Jun 2020 16:31:03 -0700
Message-Id: <20200605233103.57234-1-harshads@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Mkfs program can dump empty lines if encounters warnings and results
in test to fail. One of the case when this happens is when we are
trying to create a big file system (> 4T) and if "big" is not present
in /etc/mke2fs.conf. Ignore those empty lines too.

Before the fix, test generic/472 failed with following diff

diff /root/xfstests/tests/generic/472.out /root/xfstests/results//generic/472.out.bad
@@ -1,6 +1,6 @@
 QA output created by 472
 +
 +
  regular swap
  too long swap
  tiny swap
After the fix, test generic/472 passed
Ran generic/472
Passed all 1 tests

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 66c7fd4d..24f7fed3 100644
--- a/common/rc
+++ b/common/rc
@@ -560,7 +560,7 @@ _setup_large_ext4_fs()
 _scratch_mkfs_ext4()
 {
 	local mkfs_cmd="$MKFS_EXT4_PROG -F"
-	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
+	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \" | grep -v \"^$\""
 	local tmp=`mktemp -u`
 	local mkfs_status
 
-- 
2.27.0.278.ge193c7cf3a9-goog

