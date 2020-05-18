Return-Path: <SRS0=Vcut=7A=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A895CC433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 18 May 2020 22:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D7B20835
	for <linux-fstests@archiver.kernel.org>; Mon, 18 May 2020 22:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYVzhNCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgERWag (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 May 2020 18:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgERWaf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 May 2020 18:30:35 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB97FC061A0C
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 15:30:35 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g25so3844443otp.13
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 15:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2utvjv9yZ9ilbDezgYpSIEUwedTrSb+C4kp870mhxM=;
        b=UYVzhNCNoZGu9RfrZQWcpAD1IXlSbAkbMiZE5q/o2+KcDiSOTe6jzBxbYBeflgzMJX
         zBX8b26kZ1B4gSKiMqfNubgOR1KaIZVKfAKlD8KAWaewZxCjFWp3gYkUqEX8WTVm2Z0l
         4EjBMy8WU0kjX6OPrIvVpS1EyVGj6CykdV6JpDmfbhI6ieJMO1TUqv0V558X6zPzw5Zs
         aKxHxIYa/n/B78+LuZ4SPfYHNiih4pM7cSJEwu5BmCorD7Vuy0mEAw5RKMdpb0jnTeCe
         TpeZ9svS4yoDyWYEk0HCePVdm0Re40ovoXdZAJdzGjTSzDs7jUlp7E8wPUkbyL40rb5U
         imsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2utvjv9yZ9ilbDezgYpSIEUwedTrSb+C4kp870mhxM=;
        b=hToOrHenfj/FDdMIBqpJ2c1rXU774cPRAV5+ktvtR2a+ZupCViaejrLEZ8zGC4INcn
         cGUKkpCvXZ9gOEB69DfOfTC9cflw4sqO+w3wGCAlSAqNISqPbNhgKf3ro72bmpF8nPQY
         oa+l1pdB7GaxwgqtQhtU8rNkzx4gyZ1baw8rM8VLUK5ISOTgM+UWGofc2FvySxzjWFHk
         qk7c49nQKtbRZm0M95TFtgZYJqMJlCnOY1t2Y8vP139Bs+Y9QT/n1boHXbpuk4+DMZyZ
         DOoCG5ivlzriFolVb8eVF9bll8WIVegnkg5sLhVPxqpuXRFo4QABFgxq91tr1dYYSi72
         SbXQ==
X-Gm-Message-State: AOAM532Cu47oII1TpQnayCNnAGM4IVOnonORAT1tm2rHGN3YV907q1qi
        MMKuq5uDRf2yJ6Xs6BBdnQQ0aiUEOroO
X-Google-Smtp-Source: ABdhPJyaoxCFgt7PTyCl9DdF/etyFki97TzY1gbkd9OQ8cSOpxmtNlOxMMTY2rV6Aav2tS8Hsyi/Qg==
X-Received: by 2002:a9d:19af:: with SMTP id k44mr13441181otk.80.1589841034694;
        Mon, 18 May 2020 15:30:34 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id x17sm3421113ool.38.2020.05.18.15.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:30:34 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Arvind Raghavan <raghavan.arvind@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Subject: [PATCH] src/fssum: Refactor recursive traversal
Date:   Mon, 18 May 2020 16:15:51 -0400
Message-Id: <20200518201551.2553-1-raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
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
 src/fssum.c | 298 ++++++++++++++++++++++++++++------------------------
 1 file changed, 162 insertions(+), 136 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 3d97a70b..f2325ae0 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -502,6 +502,162 @@ malformed:
 		excess_file(fn);
 }
 
+void
+sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in);
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
+	sum_file_data_t sum_file_data = flags[FLAG_STRUCTURE] ?
+			sum_file_data_strict : sum_file_data_permissive;
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
+	ret = fchdir(dirfd);
+	if (ret == -1) {
+		perror("fchdir");
+		exit(-1);
+	}
+	ret = lstat64(name, &st);
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
+				exit(-1);
+			}
+		}
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
+			if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
+				sum_add_u64(&meta, errno);
+			} else if (fd == -1) {
+				fprintf(stderr,
+					"open failed for %s/%s: %s\n",
+					path_prefix, path,
+					strerror(errno));
+				exit(-1);
+			}
+			if (fd != -1) {
+				ret = sum_file_data(fd, &cs);
+				if (ret < 0) {
+					fprintf(stderr,
+						"read failed for "
+						"%s/%s: %s\n",
+						path_prefix, path,
+						strerror(errno));
+					exit(-1);
+				}
+				close(fd);
+			}
+		}
+	} else if (S_ISLNK(st.st_mode)) {
+		ret = readlink(name, buf, sizeof(buf));
+		if (ret == -1) {
+			perror("readlink");
+			exit(-1);
+		}
+		sum_add(&cs, buf, ret);
+	} else if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
+		sum_add_u64(&cs, major(st.st_rdev));
+		sum_add_u64(&cs, minor(st.st_rdev));
+	}
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
+}
+
 void
 sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 {
@@ -512,10 +668,6 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 	int entries = 0;
 	int i;
 	int ret;
-	int fd;
-	int excl;
-	sum_file_data_t sum_file_data = flags[FLAG_STRUCTURE] ?
-			sum_file_data_strict : sum_file_data_permissive;
 	struct stat64 dir_st;
 
 	if (fstat64(dirfd, &dir_st)) {
@@ -550,19 +702,6 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
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
 
 		ret = fchdir(dirfd);
 		if (ret == -1) {
@@ -571,130 +710,17 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 		}
 		ret = lstat64(namelist[i], &st);
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
-				exit(-1);
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
-			}
-		}
-		if (S_ISDIR(st.st_mode)) {
-			fd = openat(dirfd, namelist[i], 0);
-			if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
-				sum_add_u64(&meta, errno);
-			} else if (fd == -1) {
-				fprintf(stderr, "open failed for %s/%s: %s\n",
-					path_prefix, path, strerror(errno));
-				exit(-1);
-			} else {
-				sum(fd, level + 1, &cs, path_prefix, path);
-				close(fd);
-			}
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
-					fprintf(stderr,
-						"open failed for %s/%s: %s\n",
-						path_prefix, path,
-						strerror(errno));
-					exit(-1);
-				}
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
-			}
-			sum_add(&cs, buf, ret);
-		} else if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
-			sum_add_u64(&cs, major(st.st_rdev));
-			sum_add_u64(&cs, minor(st.st_rdev));
-		}
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
-		}
-		sum_add_sum(dircs, &cs);
-		sum_add_sum(dircs, &meta);
-next:
-		free(path);
+			continue;
+
+		sum_one(dirfd, level, dircs, path_prefix, path_in, namelist[i]);
 	}
 }
 
-- 
2.20.1

