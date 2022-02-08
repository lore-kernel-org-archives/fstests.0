Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08440C41535
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Feb 2022 22:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386479AbiBHW0o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387002AbiBHVlB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Feb 2022 16:41:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E0C0612B8
        for <fstests@vger.kernel.org>; Tue,  8 Feb 2022 13:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AMAff7Ltb0TpLwc7cBBUrjBDnZpH074xhuLooaelVAk=; b=ykH0iXcppTbgM1EH5vOv7o2shm
        vMpdbi+tz3frSWsCcFA65XuwvU3e8CEIuhcdr6gEmYbUmrsyGEWON0It2jki9jPBtkTwR1YcDGH4l
        NEhNc6V/iXXCR+sR8oPjfNfFkccFiv2lKsQ7rs6MS4ew5Yre5dtxrP20MQys0Cvn9Pz5CsPZ1Z8Vc
        GUYGobZIFcpojfsojn9qbzmSxs+QMfly1S5Cq2OgXQOXtPflpO2mW4khuqi/kNjQRSFaNv97VKnSq
        KfMDzhT0qXm/pCPvOI5XmwFrLziZ/TJLn73sPzZiZIkB7+yLJ5ZqTU716Sj8gdArVz0ufAcywnvHp
        ZJkp7yoA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHYEN-00Fcyt-M4; Tue, 08 Feb 2022 21:40:59 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC] Makefile: add check target to run shellcheck
Date:   Tue,  8 Feb 2022 13:40:58 -0800
Message-Id: <20220208214058.3724721-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

shellcheck can be used to allow us to create a sanity check
on shell scripts and also build a consistent set of rules.
Although I actually find some annoying, consistancy is better
than no consitancy check at all. This is inspired by blktests'
own adoption of it and how it has found minor issues.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Makefile b/Makefile
index f6f91a4d..a83e6879 100644
--- a/Makefile
+++ b/Makefile
@@ -99,6 +99,13 @@ else
 	$(Q)$(MAKE) $(MAKEOPTS) $(SRCTAR)
 endif
 
+# We use shellcheck for sanity and consistency. Consistency is better than
+# not having any.
+check:
+	shellcheck -x -f gcc check new common/* \
+                tests/*/[0-9]*[0-9]
+.PHONY: check
+
 $(SRCTAR) : default
 	$(Q)git archive --prefix=$(PKG_NAME)-$(PKG_VERSION)/ --format=tar \
 	  v$(PKG_VERSION) > $(PKG_NAME)-$(PKG_VERSION).tar
-- 
2.34.1

