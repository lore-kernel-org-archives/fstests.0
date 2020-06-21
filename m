Return-Path: <SRS0=f9yW=AC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755B2C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C08D20DD4
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCrZbKRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgFUXPw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgFUXPv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 19:15:51 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A1DC061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:15:50 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id c4so1487743oou.6
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvDnwVJvy3GrPWKDVwi/RP41/ycwxvfdlCwwBxbF8vE=;
        b=OCrZbKRWBOK9Vn1omPCGLsE0lrfht2GtYB3qkHfttU5YeftIIgB+fNVKgymzVd11qL
         D5v9mo5pDF3OVVPiUoXmTuMIyiuy887d/4JztCrmM9+KQ7pvxptHRVp067QP+bkVTBXc
         FbsO57Qa7jzLmS9taXv6Cit3N+6Hr5DeOQY+dEHBcvMHJamp4qNsQ15KFuAax/cBHeWo
         4Ywf6kZD9BII8g8ZS6rA7TxxUMHJHyH0vAaxDMPL9dieI6mv93+TX5LVk68VxvkNAwVQ
         9yB7JIam5QPuSkEMWw/AQawRmYCxwEMwD/IiHeTpfCFTkpXJdeVHi48ylHHBsO0hoC2w
         PvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvDnwVJvy3GrPWKDVwi/RP41/ycwxvfdlCwwBxbF8vE=;
        b=UvxE0de/cs7Q01vEQze1Kln4KNMsRi5KGsAgnYS9V010NuWjHRoC7FbEsA98duA/zh
         mCrDUUbDjEq07Oc/PK188+G05Sbyfni3aaNA92R7bDWbUYmNm/rAjktJ/ZKVZvDoC/LU
         uS2lptPWtzysOKeSFl3x2uGRoJlqoBLUbWcuBKjH4AIzGzPHIfu7IpPijCoZf4Eegg2s
         lEAGADPaOAvSRyEt0NmjARkrdTiWFnFrgaGgdPFLwrv/9ufE6AnuDDS643flaaCUhqBY
         6zS9bqe1VFF4dSge6mDBzxeHNJlWHCQPePrtdrY9qPtxW2m3SMend+9/zLI0e1g4rxxT
         GRUQ==
X-Gm-Message-State: AOAM531ap1Uh1JoDKaXDcJgPeFfKG6jooXL6jaG3fzxQalxFFcxiUKkW
        yy9tKu3mFJ/4KZEAblRq0rVCtrtuFQ==
X-Google-Smtp-Source: ABdhPJwkQOGonADu29URsXEaFmINxNPleDmvUx/c9ArsGscl3L+FDgXaoH/Dn+D6MAd0X7OVd67fQQ==
X-Received: by 2002:a4a:e702:: with SMTP id y2mr1848937oou.36.1592781349625;
        Sun, 21 Jun 2020 16:15:49 -0700 (PDT)
Received: from localhost.localdomain (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id k15sm2993652oom.22.2020.06.21.16.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 16:15:49 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH v2 2/7] src/fssum: Refactoring changes for recursive traversal
Date:   Sun, 21 Jun 2020 19:15:44 -0400
Message-Id: <5241e1c1d58435f34060c45d453c73670514dbd4.1592779555.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1592779555.git.raghavan.arvind@gmail.com>
References: <cover.1592779555.git.raghavan.arvind@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Refactoring changes needed for recursive traversal and single file
input. Makes fstat and readlink use the 'at' alternatives, and creates a
helper function for opening files.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
---
 src/fssum.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 30f456c2..135dd60f 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -503,6 +503,13 @@ malformed:
 		excess_file(fn);
 }
 
+int open_one(int dirfd, const char *name)
+{
+	if (!name || !*name)
+		return dup(dirfd);
+	return openat(dirfd, name, 0);
+}
+
 void
 sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 {
@@ -563,12 +570,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 				goto next;
 		}
 
-		ret = fchdir(dirfd);
-		if (ret == -1) {
-			perror("fchdir");
-			exit(-1);
-		}
-		ret = lstat64(namelist[i], &st);
+		ret = fstatat64(dirfd, namelist[i], &st, AT_SYMLINK_NOFOLLOW);
 		if (ret) {
 			fprintf(stderr, "stat failed for %s/%s: %s\n",
 				path_prefix, path, strerror(errno));
@@ -597,7 +599,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 			sum_add_time(&meta, st.st_ctime);
 		if (flags[FLAG_XATTRS] &&
 		    (S_ISDIR(st.st_mode) || S_ISREG(st.st_mode))) {
-			fd = openat(dirfd, namelist[i], 0);
+			fd = open_one(dirfd, namelist[i]);
 			if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
 				sum_add_u64(&meta, errno);
 			} else if (fd == -1) {
@@ -618,7 +620,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 			}
 		}
 		if (S_ISDIR(st.st_mode)) {
-			fd = openat(dirfd, namelist[i], 0);
+			fd = open_one(dirfd, namelist[i]);
 			if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
 				sum_add_u64(&meta, errno);
 			} else if (fd == -1) {
@@ -635,7 +637,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 				if (verbose)
 					fprintf(stderr, "file %s\n",
 						namelist[i]);
-				fd = openat(dirfd, namelist[i], 0);
+				fd = open_one(dirfd, namelist[i]);
 				if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
 					sum_add_u64(&meta, errno);
 				} else if (fd == -1) {
@@ -659,7 +661,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 				}
 			}
 		} else if (S_ISLNK(st.st_mode)) {
-			ret = readlink(namelist[i], buf, sizeof(buf));
+			ret = readlinkat(dirfd, namelist[i], buf, sizeof(buf));
 			if (ret == -1) {
 				perror("readlink");
 				exit(-1);
-- 
2.20.1

