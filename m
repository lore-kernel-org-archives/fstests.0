Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588DBC74A4B
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 19:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCMTDw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCMTDv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 15:03:51 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3427019F1C
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 12:03:49 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Mon, 13 Mar 2023 19:03:47 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v3 3/9] vfs: Use tabs to indent, not spaces
Date:   Mon, 13 Mar 2023 20:03:24 +0100
Message-Id: <20230313190330.94229-4-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
References: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 src/vfs/vfstest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git src/vfs/vfstest.c src/vfs/vfstest.c
index 20ade869..a840e007 100644
--- src/vfs/vfstest.c
+++ src/vfs/vfstest.c
@@ -105,7 +105,7 @@ static int hardlink_crossing_mounts(const struct vfstest_info *info)
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
 
-        if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
+	if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
 		log_stderr("failure: chown_r");
 		goto out;
 	}
-- 
2.39.2

