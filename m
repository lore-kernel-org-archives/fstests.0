Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D2DC678D5
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Mar 2023 11:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCHLOO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCHLOM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2023 06:14:12 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77F98DCE8
        for <fstests@vger.kernel.org>; Wed,  8 Mar 2023 03:14:07 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Wed, 08 Mar 2023 11:14:06 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v2 8/9] vfs: Export test_setup() and test_cleanup()
Date:   Wed,  8 Mar 2023 12:13:42 +0100
Message-Id: <20230308111343.510970-9-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Future patches will call existing test inside another test, so we need
to properly setup the test environment.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 src/vfs/vfstest.c |  4 ++--
 src/vfs/vfstest.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 src/vfs/vfstest.h

diff --git src/vfs/vfstest.c src/vfs/vfstest.c
index a840e007..325f04a1 100644
--- src/vfs/vfstest.c
+++ src/vfs/vfstest.c
@@ -80,7 +80,7 @@ static void stash_overflowgid(struct vfstest_info *info)
 	info->t_overflowgid = atoi(buf);
 }
 
-static void test_setup(struct vfstest_info *info)
+void test_setup(struct vfstest_info *info)
 {
 	if (mkdirat(info->t_mnt_fd, T_DIR1, 0777))
 		die("failure: mkdirat");
@@ -93,7 +93,7 @@ static void test_setup(struct vfstest_info *info)
 		die("failure: fchmod");
 }
 
-static void test_cleanup(struct vfstest_info *info)
+void test_cleanup(struct vfstest_info *info)
 {
 	safe_close(info->t_dir1_fd);
 	if (rm_r(info->t_mnt_fd, T_DIR1))
diff --git src/vfs/vfstest.h src/vfs/vfstest.h
new file mode 100644
index 00000000..6502d9f1
--- /dev/null
+++ src/vfs/vfstest.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __VFSTEST_H
+#define __VFSTEST_H
+
+void test_setup(struct vfstest_info *info);
+void test_cleanup(struct vfstest_info *info);
+
+
+#endif /* __VFSTEST_H */
-- 
2.39.2

