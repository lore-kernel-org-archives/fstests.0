Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9CAC43217
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Apr 2022 15:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348986AbiD1PUB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348963AbiD1PUA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2022 11:20:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FB5AFB1C
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 08:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 121D9B82E14
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 15:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB08C385AF;
        Thu, 28 Apr 2022 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651159001;
        bh=u4eSjnlK6GHegIrrd4UU7RVKVlXZSGEAdyh+KGVN+iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAuM7bIg942XMwV/HVb9QQxjo+Szh/IMLWjsd5W/j+NF9/f9aLwk0ZU3QV5uixXk8
         LR3yx3pqTdQWsK38VdpGA0gBk7qZV+Op+4v0eVuOgCertHyL0Wvn7bRpuV2LuK4CVa
         7OMVeNHEHkIm8UexMovy1cWwEsg2ukf65m27qG7fyiV4Piuo7UR6McJEdF4cyzLlHX
         E8QmTVWx3Erqld7juxZAXAxFdo8H6kH8JEat21PMxQREdhB94V519x4cDesF+G2ZCP
         zQi5rD8Npz1IiX1863k0nGSIZCBZJUNpyxdpeOE97v2fmwMCX0UotIy3ozJWR6QXWZ
         mNEClt5fL4zgg==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 07/11] missing: move sys_execveat() to missing.h
Date:   Thu, 28 Apr 2022 17:15:55 +0200
Message-Id: <20220428151559.947144-8-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220428151559.947144-1-brauner@kernel.org>
References: <20220428151559.947144-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; h=from:subject; bh=u4eSjnlK6GHegIrrd4UU7RVKVlXZSGEAdyh+KGVN+iA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRlrV8c2/Pr1+rZm1MW7/wTnOBVc4vp4bGNs5N33/WLl94j 77+nuaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAik6IZ/gqmMryy56735D9he9rgds zMeK65xe/upet36BdV7Z1tc4Hhf5Ju4/a9TQd+H3m9SlSyvzio8fxl67f3HOvP3D+XwRG8khcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The missing.h header provides syscalls potentially missing from the used
libc. Move the sys_execveat() definition into it. It doesn't belong into
vfstest.c.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/missing.h | 11 +++++++++++
 src/vfs/vfstest.c | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/vfs/missing.h b/src/vfs/missing.h
index c4f4cc32..059e742d 100644
--- a/src/vfs/missing.h
+++ b/src/vfs/missing.h
@@ -148,4 +148,15 @@ static inline int sys_umount2(const char *path, int flags)
 	return syscall(__NR_umount2, path, flags);
 }
 
+static inline int sys_execveat(int fd, const char *path, char **argv,
+			       char **envp, int flags)
+{
+#ifdef __NR_execveat
+	return syscall(__NR_execveat, fd, path, argv, envp, flags);
+#else
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
 #endif /* __IDMAP_MISSING_H */
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index c3eb5ae4..f6c8c194 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -226,17 +226,6 @@ __attribute__((unused)) static int print_r(int fd, const char *path)
 }
 #endif
 
-static int sys_execveat(int fd, const char *path, char **argv, char **envp,
-			int flags)
-{
-#ifdef __NR_execveat
-	return syscall(__NR_execveat, fd, path, argv, envp, flags);
-#else
-	errno = ENOSYS;
-	return -1;
-#endif
-}
-
 static void test_setup(struct vfstest_info *info)
 {
 	if (mkdirat(info->t_mnt_fd, T_DIR1, 0777))
-- 
2.32.0

