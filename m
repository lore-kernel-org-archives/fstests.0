Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A8C433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 22:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D7B61A0A
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhCXWtD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 18:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCXWsb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 18:48:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBDAC06174A
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 15:48:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 5EBCD1F45F00
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     fstests@vger.kernel.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        "Lakshmipathi . G" <lakshmipathi.ganapathi@collabora.com>,
        Eryu Guan <guaneryu@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/2] common: Escape SCRATCH_DEV variable
Date:   Wed, 24 Mar 2021 19:48:16 -0300
Message-Id: <20210324224817.103503-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Escape SCRATCH_DEV variable so it prints its name, instead of printing
the value. If the value is "", the error message will not be very
informative.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 6d1757da..fc1a7751 100644
--- a/common/rc
+++ b/common/rc
@@ -1537,7 +1537,7 @@ _require_scratch_nocheck()
 	tmpfs)
 		if [ -z "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
 		then
-		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
+		    _notrun "this test requires a valid \$SCRATCH_MNT and unique \$SCRATCH_DEV"
 		fi
 		;;
 	ubifs)
-- 
2.31.0

