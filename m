Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A0C6FD1F
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Mar 2023 11:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCHLOP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjCHLOM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2023 06:14:12 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51C559EC
        for <fstests@vger.kernel.org>; Wed,  8 Mar 2023 03:14:07 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Wed, 08 Mar 2023 11:14:01 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v2 1/9] vfs: Don't open-code safe_close()
Date:   Wed,  8 Mar 2023 12:13:35 +0100
Message-Id: <20230308111343.510970-2-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 src/vfs/utils.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git src/vfs/utils.c src/vfs/utils.c
index 8b000506..ea7536c1 100644
--- src/vfs/utils.c
+++ src/vfs/utils.c
@@ -129,10 +129,8 @@ static int write_id_mapping(idmap_type_t map_type, pid_t pid, const char *buf, s
 
 	fret = 0;
 out:
-	if (fd >= 0)
-		close(fd);
-	if (setgroups_fd >= 0)
-		close(setgroups_fd);
+	safe_close(fd);
+	safe_close(setgroups_fd);
 
 	return fret;
 }
-- 
2.39.2

