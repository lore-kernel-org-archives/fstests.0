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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DE3C433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457DC23358
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7qW1KXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgFUXQK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgFUXQJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 19:16:09 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D90C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:16:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k15so11636486otp.8
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5lgoNAWPdhuMgBM2Z7BuqtEAax7cI1CMl4M/LZCU28=;
        b=u7qW1KXuncQFJRQ4u7MVMQYxkm6B7/mg7mHDxNH6i02okxzlOQcB8nun27OHA59dfr
         PbJmWfmyfgv7uETf2uchwvNeZXVsaRcl6VJUxacFL8qWFCM14sFGbNZPLkK2J0TEK8h7
         zyGOlf7kw8QT6hEdVgqA5YGuefhI0kZBiGgtZDz/DqtnVUDjX2fcB487gmzT+cIaWVgI
         DlSRHp+YBNb48AIiV60GuveQTW4zB9zKMrltiyl5FruYdi8iOVcKXGxy2raO3VChQoHC
         EC4BnBrvUmxhFpBof2O6zAEDVUv37XcFYcUbBxzrFRobhdsUS4BFn4wkxZF00EeFtNba
         iDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5lgoNAWPdhuMgBM2Z7BuqtEAax7cI1CMl4M/LZCU28=;
        b=sU61VdGyXl0DLsqCg/Sxu50e3jgvVE3fW+mJE239ZjOuv1vYad7Zn4+kUK5v7anGwt
         E/qxZV3PO9/wXXkylkcBr3zLwvYJdNtavDrt6YKhPRuAU1c3TxxG6fuDUoGVHB1F/kkU
         T3olEAW05Fb8nyJjonSNQUxldXwzKsmDS3P23vGvnwyH7unQhoj2nLmZ7Rm/4bdiBWQk
         6RUCZ8hOxie5KtvxLgNdnvp1Wcr/Yj14f0NkHCXDe8pHlFS6sA1mnc9J9BMkFBipuy/X
         HpYiK/yvyVVkFeJyNN0mSN+chJT8So9xWyO+87khVSvbvQrEgg02fSwgZ7d75+s2U3cX
         TTiQ==
X-Gm-Message-State: AOAM530m803TKy79nEhy+TSmHSL2Fa4K3OR4ufdy7DegIyrpiuM2M5Vp
        NzKzwwAX5qBWwC+3kDrkud2mp2LbXw==
X-Google-Smtp-Source: ABdhPJwrcUJ7rpKIPhjxwzimUXpxj0z7hcDB3KiyWN8PS0sZGho43PzjrNnaFqwAMXaxWtMSBNk5yA==
X-Received: by 2002:a9d:6ad5:: with SMTP id m21mr11739151otq.307.1592781368619;
        Sun, 21 Jun 2020 16:16:08 -0700 (PDT)
Received: from localhost.localdomain (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id 10sm2882228otq.52.2020.06.21.16.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 16:16:08 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH v2 3/7] src/fssum: Recursive traversal refactoring
Date:   Sun, 21 Jun 2020 19:16:03 -0400
Message-Id: <c9d63f068a7408080a07d4ea18999db580452df2.1592779555.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1592779555.git.raghavan.arvind@gmail.com>
References: <cover.1592779555.git.raghavan.arvind@gmail.com>
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
 src/fssum.c | 257 ++++++++++++++++++++++++++++------------------------
 1 file changed, 139 insertions(+), 118 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 135dd60f..506ca7fe 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -510,6 +510,10 @@ int open_one(int dirfd, const char *name)
 	return openat(dirfd, name, 0);
 }
 
+void
+sum_one(int dirfd, int level, sum_t *dircs, char *path_prefix,
+		char *path_in, char *name);
+
 void
 sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 {
@@ -520,8 +524,6 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 	int entries = 0;
 	int i;
 	int ret;
-	int fd;
-	int excl;
 	struct stat64 dir_st;
 
 	if (fstat64(dirfd, &dir_st)) {
@@ -556,147 +558,166 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
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
 
 		ret = fstatat64(dirfd, namelist[i], &st, AT_SYMLINK_NOFOLLOW);
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
-			fd = open_one(dirfd, namelist[i]);
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
+		fd = open_one(dirfd, name);
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
-			fd = open_one(dirfd, namelist[i]);
+	}
+	if (S_ISDIR(st.st_mode)) {
+		fd = open_one(dirfd, name);
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
+			fd = open_one(dirfd, name);
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
-				fd = open_one(dirfd, namelist[i]);
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
-			ret = readlinkat(dirfd, namelist[i], buf, sizeof(buf));
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
+		ret = readlinkat(dirfd, name, buf, sizeof(buf));
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
+out:
+	free(path);
 }
 
 int
-- 
2.20.1

