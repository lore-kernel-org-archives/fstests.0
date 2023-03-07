Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB13C678D4
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 12:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCGMGX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjCGMGW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 07:06:22 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DBB3E630
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 04:06:21 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 11:45:40 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 05/11] vfs: Specify wether a test is run inside a userns or not
Date:   Tue,  7 Mar 2023 12:45:01 +0100
Message-Id: <20230307114507.332309-6-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This bool that is initialized to false will be used in future pathces,
when we will reuse some existing tests to run them inside a userns and
with some fs-specific setup.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 src/vfs/utils.h   | 2 ++
 src/vfs/vfstest.c | 1 +
 2 files changed, 3 insertions(+)

diff --git src/vfs/utils.h src/vfs/utils.h
index f1681737..4c796559 100644
--- src/vfs/utils.h
+++ src/vfs/utils.h
@@ -197,6 +197,8 @@ struct vfstest_info {
 	bool t_fs_allow_idmap;
 	/* whether user namespaces are supported */
 	bool t_has_userns;
+	/* whether this test is running inside a userns */
+	bool t_inside_userns;
 };
 
 struct test_struct {
diff --git src/vfs/vfstest.c src/vfs/vfstest.c
index 20ade869..3ec65dff 100644
--- src/vfs/vfstest.c
+++ src/vfs/vfstest.c
@@ -42,6 +42,7 @@ static void init_vfstest_info(struct vfstest_info *info)
 	info->t_mnt_scratch_fd		= -EBADF;
 	info->t_dir1_fd			= -EBADF;
 	info->t_fs_allow_idmap		= false;
+	info->t_inside_userns		= false;
 }
 
 static void stash_overflowuid(struct vfstest_info *info)
-- 
2.39.2

