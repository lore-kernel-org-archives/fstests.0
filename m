Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697B0C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353318AbiELQx2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356712AbiELQx1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C5268669
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3772B82732
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E01DC36AE3;
        Thu, 12 May 2022 16:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374404;
        bh=kzikaS3je4lqymUo0J3W/MBly8Iag4RLfex8L5r65rU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQ1O6lwmimO/CZG1jTCWw5XNNz93cnyMnNg3KYI8BXaKiAVkoRqShdCPjcU+qBGW4
         yEG7QKwUBfJE+vVl7nAAVgRkK52WqtxJt946RKPUNYL7G2eMArJfsAQGcFgEBYn6vb
         tjL+l1INCMJYz0M5ZSpMqGvM78zrzXt4f5i8vTTnp9ZLVh1VJjVEsweHJiAwichqO9
         cQ2OMhIQdvYWSvAgZCZV/wsw7aLy49mj3zwsyZv+3ycK68ybMW/6hxWb467qb2Bv9+
         FDiI1nUhdrXw9OuIx6RLnJP6/V4AaL4deMcqN+zP89mc+pzByOU7eph7gdiaJx1Sz2
         xp+WJvQ/fEbXQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 08/13] missing: move sys_execveat() to missing.h
Date:   Thu, 12 May 2022 18:52:45 +0200
Message-Id: <20220512165250.450989-9-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; h=from:subject; bh=kzikaS3je4lqymUo0J3W/MBly8Iag4RLfex8L5r65rU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWnt6v/ENWcKqLlPxY7njs/gZ+/6Y+oSeMnnZUv9tgo61 NLt/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESESxn+O2+7LSKeyFslXaiknK15kK u9I++dgs5K7pWuZRfd7s/1Zfhfm+PnV51U8POHwdsrxnVL2z40/F7/1ub3zqh7er8ed69iAQA=
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
Acked-by: Christoph Hellwig <hch@lst.de>
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
index 8a68565c..1d71b25b 100644
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
2.34.1

