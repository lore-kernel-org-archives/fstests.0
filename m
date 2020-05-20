Return-Path: <SRS0=XlT/=7D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8A6C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132BF20759
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE9o+U6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgEUAIP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 May 2020 20:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgEUAIP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 May 2020 20:08:15 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756F9C061A0E
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:08:15 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 63so4084518oto.8
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VxNlUa4BwLtuwNDHbIL6VbwJZS8bHFNT718suB5FcBc=;
        b=LE9o+U6FGEmzVkhWVFZ6de65e/M45UTVYsUtyBu4rrQUkcYtUv5sYNIC3PpbDAaQDx
         MBlPvq03P3rr6+0l6v6nK9VI2fOuglcwoFKe6be83bK7cdaROnhC6U2N+WStmwOvZ4Js
         yHJ3KCTihJrYWqUA6WgmN3b9xp5w2toGhvvsCQUss2caUonhs8AmbSxeFu8sKhhr1EkW
         2Hf+UQrLV1kfrEZx9CLCrHx/2c8YijS0ONYGrsKW31SxHsHHEb0db6sfHBch0mlSbb/4
         hnNi0VHkO4qnw1Xn9vwLFjDyOak1ufXFXd68YPZwUhnQF6UloaULSN/Uah3TnbE3vuX2
         PTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxNlUa4BwLtuwNDHbIL6VbwJZS8bHFNT718suB5FcBc=;
        b=KUuzfQau8CpBF94k+pGhSTBZ3lbVElg+fL6eQkP9B7PFnmGwVNNtknNxbKZhi0JpJo
         u3icvfjTM1FwEeEijkhWnrtZlVvKFeBT3moV9IsYwCkBli2Q7Y3udrNXhsS98pKkBkd9
         kEmBCteZSWWVOWPEtLpB3RS+KFJ+h2Ue5i4gqGvCjV4DRxS0CT6GiZTuOx/ow0k9a/uL
         nZlGaF8Vo5ChivVkjJEUAxDl4+V949msqYMsZJ/Gq7MwG9XIyrruQZyX06aG+KjU2HsH
         SbckkrkPOUHDAZqTMoKDiF4RZHhTCe1AfDLzDl5Zp1CUueWc6h6yTdXw0PU9BK9gA7HP
         VRHA==
X-Gm-Message-State: AOAM5308VUv0W8c331UGWdj3MAPCP9J95iZelRF/gmn9uUk6yDrAW/fD
        YBtVJUgZhBkKj0WsFZwHCe0FRkjlP928
X-Google-Smtp-Source: ABdhPJyhmaPYO/fnoAQmglKycX36FYNEQQ5k4Q0Io3eBIDJeRhsenMqWy7ycuj64wTp+pA0feL0HGQ==
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr5588810ote.48.1590019693536;
        Wed, 20 May 2020 17:08:13 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id t2sm1151338otq.54.2020.05.20.17.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:08:13 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH 2/6] src/fssum: Refactor recursive traversal
Date:   Wed, 20 May 2020 17:19:11 -0400
Message-Id: <34cbcee2c5353a1b83c50d60e3d7e2588539c154.1590006879.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590006879.git.raghavan.arvind@gmail.com>
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Moves some logic from the recursive directory traversal into a helper
function to make it easier to add support for regular files. Does not
change functionality.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
---
Includes change to fstatat instead of fchdir and lstat.

 src/fssum.c | 265 ++++++++++++++++++++++++++++------------------------
 1 file changed, 141 insertions(+), 124 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 30f456c2..81e5cf5d 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -503,6 +503,10 @@ malformed:
 		excess_file(fn);
 }
 
+void
+sum_one(int dirfd, int level, sum_t *dircs, char *path_prefix,
+		char *path_in, char *name);
+
 void
 sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 {
@@ -513,8 +517,6 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 	int entries = 0;
 	int i;
 	int ret;
-	int fd;
-	int excl;
 	struct stat64 dir_st;
 
 	if (fstat64(dirfd, &dir_st)) {
@@ -549,152 +551,167 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 	qsort(namelist, entries, sizeof(*namelist), namecmp);
 	for (i = 0; i < entries; ++i) {
 		struct stat64 st;
-		sum_t cs;
-		sum_t meta;
-		char *path;
-
-		sum_init(&cs);
-		sum_init(&meta);
-		path = alloc(strlen(path_in) + strlen(namelist[i]) + 3);
-		sprintf(path, "%s/%s", path_in, namelist[i]);
-		for (excl = 0; excl < n_excludes; ++excl) {
-			if (strncmp(excludes[excl].path, path,
-			    excludes[excl].len) == 0)
-				goto next;
-		}
 
-		ret = fchdir(dirfd);
-		if (ret == -1) {
-			perror("fchdir");
-			exit(-1);
-		}
-		ret = lstat64(namelist[i], &st);
+		ret = fstatat64(dirfd, namelist[i], &st, AT_SYMLINK_NOFOLLOW);
 		if (ret) {
-			fprintf(stderr, "stat failed for %s/%s: %s\n",
-				path_prefix, path, strerror(errno));
+			fprintf(stderr, "stat failed for %s/%s/%s: %s\n",
+				path_prefix, path_in, namelist[i],
+				strerror(errno));
 			exit(-1);
 		}
 
 		/* We are crossing into a different subvol, skip this subtree. */
 		if (st.st_dev != dir_st.st_dev)
-			goto next;
-
-		sum_add_u64(&meta, level);
-		sum_add(&meta, namelist[i], strlen(namelist[i]));
-		if (!S_ISDIR(st.st_mode))
-			sum_add_u64(&meta, st.st_nlink);
-		if (flags[FLAG_UID])
-			sum_add_u64(&meta, st.st_uid);
-		if (flags[FLAG_GID])
-			sum_add_u64(&meta, st.st_gid);
-		if (flags[FLAG_MODE])
-			sum_add_u64(&meta, st.st_mode);
-		if (flags[FLAG_ATIME])
-			sum_add_time(&meta, st.st_atime);
-		if (flags[FLAG_MTIME])
-			sum_add_time(&meta, st.st_mtime);
-		if (flags[FLAG_CTIME])
-			sum_add_time(&meta, st.st_ctime);
-		if (flags[FLAG_XATTRS] &&
-		    (S_ISDIR(st.st_mode) || S_ISREG(st.st_mode))) {
-			fd = openat(dirfd, namelist[i], 0);
-			if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
-				sum_add_u64(&meta, errno);
-			} else if (fd == -1) {
-				fprintf(stderr, "open failed for %s/%s: %s\n",
-					path_prefix, path, strerror(errno));
+			continue;
+
+		sum_one(dirfd, level, dircs, path_prefix, path_in, namelist[i]);
+	}
+}
+
+void
+sum_one(int dirfd, int level, sum_t *dircs, char *path_prefix,
+		char *path_in, char *name) {
+	sum_t cs;
+	sum_t meta;
+	int fd;
+	int ret;
+	int excl;
+	char* path;
+	struct stat64 st;
+
+	sum_init(&cs);
+	sum_init(&meta);
+	path = alloc(strlen(path_in) + strlen(name) + 3);
+	sprintf(path, "%s/%s", path_in, name);
+	for (excl = 0; excl < n_excludes; ++excl) {
+		if (strncmp(excludes[excl].path, path,
+			excludes[excl].len) == 0)
+			goto out;
+	}
+
+	ret = fstatat64(dirfd, name, &st, AT_SYMLINK_NOFOLLOW);
+	if (ret) {
+		fprintf(stderr, "stat failed for %s/%s: %s\n",
+			path_prefix, path, strerror(errno));
+		exit(-1);
+	}
+
+	sum_add_u64(&meta, level);
+	sum_add(&meta, name, strlen(name));
+	if (!S_ISDIR(st.st_mode))
+		sum_add_u64(&meta, st.st_nlink);
+	if (flags[FLAG_UID])
+		sum_add_u64(&meta, st.st_uid);
+	if (flags[FLAG_GID])
+		sum_add_u64(&meta, st.st_gid);
+	if (flags[FLAG_MODE])
+		sum_add_u64(&meta, st.st_mode);
+	if (flags[FLAG_ATIME])
+		sum_add_time(&meta, st.st_atime);
+	if (flags[FLAG_MTIME])
+		sum_add_time(&meta, st.st_mtime);
+	if (flags[FLAG_CTIME])
+		sum_add_time(&meta, st.st_ctime);
+	if (flags[FLAG_XATTRS] &&
+		(S_ISDIR(st.st_mode) || S_ISREG(st.st_mode))) {
+		fd = openat(dirfd, name, 0);
+		if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
+			sum_add_u64(&meta, errno);
+		} else if (fd == -1) {
+			fprintf(stderr, "open failed for %s/%s: %s\n",
+				path_prefix, path, strerror(errno));
+			exit(-1);
+		} else {
+			ret = sum_xattrs(fd, &meta);
+			close(fd);
+			if (ret < 0) {
+				fprintf(stderr,
+					"failed to read xattrs from "
+					"%s/%s: %s\n",
+					path_prefix, path,
+					strerror(-ret));
 				exit(-1);
-			} else {
-				ret = sum_xattrs(fd, &meta);
-				close(fd);
-				if (ret < 0) {
-					fprintf(stderr,
-						"failed to read xattrs from "
-						"%s/%s: %s\n",
-						path_prefix, path,
-						strerror(-ret));
-					exit(-1);
-				}
 			}
 		}
-		if (S_ISDIR(st.st_mode)) {
-			fd = openat(dirfd, namelist[i], 0);
+	}
+	if (S_ISDIR(st.st_mode)) {
+		fd = openat(dirfd, name, 0);
+		if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
+			sum_add_u64(&meta, errno);
+		} else if (fd == -1) {
+			fprintf(stderr, "open failed for %s/%s: %s\n",
+				path_prefix, path, strerror(errno));
+			exit(-1);
+		} else {
+			sum(fd, level + 1, &cs, path_prefix, path);
+			close(fd);
+		}
+	} else if (S_ISREG(st.st_mode)) {
+		sum_add_u64(&meta, st.st_size);
+		if (flags[FLAG_DATA]) {
+			if (verbose)
+				fprintf(stderr, "file %s\n",
+					name);
+			fd = openat(dirfd, name, 0);
 			if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
 				sum_add_u64(&meta, errno);
 			} else if (fd == -1) {
-				fprintf(stderr, "open failed for %s/%s: %s\n",
-					path_prefix, path, strerror(errno));
+				fprintf(stderr,
+					"open failed for %s/%s: %s\n",
+					path_prefix, path,
+					strerror(errno));
 				exit(-1);
-			} else {
-				sum(fd, level + 1, &cs, path_prefix, path);
-				close(fd);
 			}
-		} else if (S_ISREG(st.st_mode)) {
-			sum_add_u64(&meta, st.st_size);
-			if (flags[FLAG_DATA]) {
-				if (verbose)
-					fprintf(stderr, "file %s\n",
-						namelist[i]);
-				fd = openat(dirfd, namelist[i], 0);
-				if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
-					sum_add_u64(&meta, errno);
-				} else if (fd == -1) {
+			if (fd != -1) {
+				ret = sum_file_data(fd, &cs);
+				if (ret < 0) {
 					fprintf(stderr,
-						"open failed for %s/%s: %s\n",
+						"read failed for "
+						"%s/%s: %s\n",
 						path_prefix, path,
 						strerror(errno));
 					exit(-1);
 				}
-				if (fd != -1) {
-					ret = sum_file_data(fd, &cs);
-					if (ret < 0) {
-						fprintf(stderr,
-							"read failed for "
-							"%s/%s: %s\n",
-							path_prefix, path,
-							strerror(errno));
-						exit(-1);
-					}
-					close(fd);
-				}
-			}
-		} else if (S_ISLNK(st.st_mode)) {
-			ret = readlink(namelist[i], buf, sizeof(buf));
-			if (ret == -1) {
-				perror("readlink");
-				exit(-1);
+				close(fd);
 			}
-			sum_add(&cs, buf, ret);
-		} else if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
-			sum_add_u64(&cs, major(st.st_rdev));
-			sum_add_u64(&cs, minor(st.st_rdev));
 		}
-		sum_fini(&cs);
-		sum_fini(&meta);
-		if (gen_manifest || in_manifest) {
-			char *fn;
-			char *m;
-			char *c;
-
-			if (S_ISDIR(st.st_mode))
-				strcat(path, "/");
-			fn = escape(path);
-			m = sum_to_string(&meta);
-			c = sum_to_string(&cs);
-
-			if (gen_manifest)
-				fprintf(out_fp, "%s %s %s\n", fn, m, c);
-			if (in_manifest)
-				check_manifest(fn, m, c, 0);
-			free(c);
-			free(m);
-			free(fn);
+	} else if (S_ISLNK(st.st_mode)) {
+		ret = readlink(name, buf, sizeof(buf));
+		if (ret == -1) {
+			perror("readlink");
+			exit(-1);
 		}
-		sum_add_sum(dircs, &cs);
-		sum_add_sum(dircs, &meta);
-next:
-		free(path);
+		sum_add(&cs, buf, ret);
+	} else if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
+		sum_add_u64(&cs, major(st.st_rdev));
+		sum_add_u64(&cs, minor(st.st_rdev));
 	}
+	sum_fini(&cs);
+	sum_fini(&meta);
+	if (gen_manifest || in_manifest) {
+		char *fn;
+		char *m;
+		char *c;
+
+		if (S_ISDIR(st.st_mode))
+			strcat(path, "/");
+		fn = escape(path);
+		m = sum_to_string(&meta);
+		c = sum_to_string(&cs);
+
+		if (gen_manifest)
+			fprintf(out_fp, "%s %s %s\n", fn, m, c);
+		if (in_manifest)
+			check_manifest(fn, m, c, 0);
+		free(c);
+		free(m);
+		free(fn);
+	}
+	sum_add_sum(dircs, &cs);
+	sum_add_sum(dircs, &meta);
+
+out:
+	free(path);
 }
 
 int
-- 
2.20.1

