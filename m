Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA2C76196
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Mar 2023 11:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCNLqS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCNLqP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2023 07:46:15 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91EE89F26
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 04:45:39 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 14 Mar 2023 11:45:36 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v4 2/9] vfs: Fix documentation typo
Date:   Tue, 14 Mar 2023 12:45:04 +0100
Message-Id: <20230314114511.128207-3-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314114511.128207-1-rodrigo@sdfg.com.ar>
References: <20230314114511.128207-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 src/vfs/utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git src/vfs/utils.h src/vfs/utils.h
index c0dbe370..f1681737 100644
--- src/vfs/utils.h
+++ src/vfs/utils.h
@@ -177,7 +177,7 @@ struct vfs_ns_cap_data {
 struct vfstest_info {
 	uid_t t_overflowuid;
 	gid_t t_overflowgid;
-	/* path of the test device */
+	/* Filesystem type of the mountpoint */
 	const char *t_fstype;
 	/* path of the test device */
 	const char *t_device;
-- 
2.39.2

