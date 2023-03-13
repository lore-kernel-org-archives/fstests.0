Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A542C74A4B
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 19:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjCMTEC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCMTEB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 15:04:01 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2369212BE
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 12:03:59 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Mon, 13 Mar 2023 19:03:58 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v3 6/9] vfs: Prepare tests in &s_idmapped_mounts to be reused inside a userns
Date:   Mon, 13 Mar 2023 20:03:27 +0100
Message-Id: <20230313190330.94229-7-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
References: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Future patches will call these tests within a userns. So, let's change
the makedev major/minor to something that works inside a userns.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 src/vfs/idmapped-mounts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git src/vfs/idmapped-mounts.c src/vfs/idmapped-mounts.c
index ed7948b6..eb0df938 100644
--- src/vfs/idmapped-mounts.c
+++ src/vfs/idmapped-mounts.c
@@ -535,7 +535,7 @@ static int fsids_mapped(const struct vfstest_info *info)
 			die("failure: create");
 
 		/* create character device */
-		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1)))
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(0, 0)))
 			die("failure: create");
 
 		/* create symlink */
@@ -764,7 +764,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 	}
 
 	/* create character device */
-	if (mknodat(info->t_dir1_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1))) {
+	if (mknodat(info->t_dir1_fd, CHRDEV1, S_IFCHR | 0644, makedev(0, 0))) {
 		log_stderr("failure: mknodat");
 		goto out;
 	}
-- 
2.39.2

