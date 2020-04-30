Return-Path: <SRS0=Qan3=6O=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A3C47247
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Apr 2020 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A46320731
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Apr 2020 17:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFUIDxQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD3Ret (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgD3Ret (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Apr 2020 13:34:49 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83591C035494
        for <fstests@vger.kernel.org>; Thu, 30 Apr 2020 10:34:47 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a2so264651oia.11
        for <fstests@vger.kernel.org>; Thu, 30 Apr 2020 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EAHVJ1EV8M1QNz3MhK2/DoClSaABjA8sdfiHKgPG6Rg=;
        b=FFUIDxQLDqF+IeaAduGbjGG6J35RunwBLVWpTPorrP+OfUug5bri3S06ojzLIHYl+k
         +sR5TMFxvkSy7j4Ja7ivSOFIL8BtOKQwdc690m6x9YKZ/m4SA4Ayyn0mdkydu1tvUxjr
         mXSAnp8v8zWTWBjfcj6urGFC9Ine2SqppQM8XeHiQbKDvzkJziXFnBhNdeiEvTKyFEcG
         6Gg+crIVEYYRlj7VJWHFiC31bCIQEJJdABD9978j6PieQv/y8F8+i60X5KL8e/QxOqzU
         6kkPh+cGdXqgi0WPx2K+CiQ+83QyNPUdBAqul1e5qKAJ78zcJC4tGhJiemsCoQ3O7Aez
         eHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EAHVJ1EV8M1QNz3MhK2/DoClSaABjA8sdfiHKgPG6Rg=;
        b=X+leDVrPx8owIfcsCswHqXIInDmANmh5RG4htZMm5ij2n08yhdBI95lmgj6HwN82eC
         nfgjDS6/Hf5Dlel79juPUaiCcfY03ya7u83Bb9aK90cMo8hKAAh4KgySHzq9zkmQk7T5
         z/SgA5lQ7R2Ctu/taV8nEjl+Ci4Lm0NVL88BK0FQR28sa9mGKX3nPKvo0uYLzmmTIMLy
         9n0XMOGNG/wLi3NSPqExaaWdeYa0RJ3rJGItSvKrrBobmTND5mCQE6uomU0bk5eorlRB
         OJ1Kf5ln2y68G9rT3+jO3DfK7TX7uy11FVlOTIS2Zm0cs3X9mB4aTVfAyNVzwDiN4FXt
         4YxA==
X-Gm-Message-State: AGi0PubSVDYd9rTcuRqpkA7SHUeTrS4gBa5avAbpZELy9OTr8OU2ZJ/1
        fm+jdzeNFLXrPL6VVsxKzUZ+gBYq0w==
X-Google-Smtp-Source: APiQypKi3bbGxC1axu7B4GGs/4jl5ZzQy72SR/QepXcSM3zq4zriulGu7GOK6Id6mPTYOixKWKwXVw==
X-Received: by 2002:aca:3b82:: with SMTP id i124mr84390oia.61.1588268086504;
        Thu, 30 Apr 2020 10:34:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id k8sm67230ood.24.2020.04.30.10.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 10:34:46 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Arvind Raghavan <raghavan.arvind@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Subject: [PATCH] fstests: Adds non-recursive and single file mode to fssum
Date:   Wed, 29 Apr 2020 23:55:44 -0400
Message-Id: <20200430035543.7178-1-raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Requires patch: Fix duplicate CLI arguments in fssum

Adds flag '-R' for non-recursive mode. Useful for checking a directory
after an fsync, as POSIX standards only guarantee that the immediate
files in the directory are synced.

Added support for files as input, instead of just directories. fssum
computes the checksum of the single file.

Added a flag for including file size in metadata. Previously it was
always included. It is useful to ignore file sizes when testing an
fsync of a directory, as the data of its children is not guaranteed to
be persisted.

Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
---
 src/fssum.c | 162 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 122 insertions(+), 40 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 3d97a70b..9b32e8cb 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -29,6 +29,7 @@
 #include <inttypes.h>
 #include <assert.h>
 #include <endian.h>
+#include <libgen.h>
 
 #define CS_SIZE 16
 #define CHUNKS	128
@@ -56,6 +57,7 @@ typedef int (*sum_file_data_t)(int fd, sum_t *dst);
 
 int gen_manifest = 0;
 int in_manifest = 0;
+int recursive = 1;
 char *checksum = NULL;
 struct excludes *excludes;
 int n_excludes = 0;
@@ -74,13 +76,14 @@ enum _flags {
 	FLAG_XATTRS,
 	FLAG_OPEN_ERROR,
 	FLAG_STRUCTURE,
+	FLAG_SIZE,
 	NUM_FLAGS
 };
 
-const char flchar[] = "ugoamcdtes";
+const char flchar[] = "ugoamcdtesz";
 char line[65536];
 
-int flags[NUM_FLAGS] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0};
+int flags[NUM_FLAGS] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1};
 
 char *
 getln(char *buf, int size, FILE *fp)
@@ -146,12 +149,14 @@ usage(void)
 	fprintf(stderr, "         t       : include xattrs\n");
 	fprintf(stderr, "         e       : include open errors (aborts otherwise)\n");
 	fprintf(stderr, "         s       : include block structure (holes)\n");
+	fprintf(stderr, "         z       : include file size\n");
 	fprintf(stderr, "    -[UGOAMCDTES]: exclude respective field from calculation\n");
 	fprintf(stderr, "    -n           : reset all flags\n");
 	fprintf(stderr, "    -N           : set all flags\n");
 	fprintf(stderr, "    -x path      : exclude path when building checksum (multiple ok)\n");
+	fprintf(stderr, "    -R           : traverse dirs non-recursively (recursive is default)\n");
 	fprintf(stderr, "    -h           : this help\n\n");
-	fprintf(stderr, "The default field mask is ugoamCdtES. If the checksum/manifest is read from a\n");
+	fprintf(stderr, "The default field mask is ugoamCdtESz. If the checksum/manifest is read from a\n");
 	fprintf(stderr, "file, the mask is taken from there and the values given on the command line\n");
 	fprintf(stderr, "are ignored.\n");
 	exit(-1);
@@ -502,6 +507,92 @@ malformed:
 		excess_file(fn);
 }
 
+void
+sum_meta(sum_t *meta, struct stat64 *st) {
+	if (!S_ISDIR(st->st_mode))
+		sum_add_u64(meta, st->st_nlink);
+	if (flags[FLAG_UID])
+		sum_add_u64(meta, st->st_uid);
+	if (flags[FLAG_GID])
+		sum_add_u64(meta, st->st_gid);
+	if (flags[FLAG_MODE])
+		sum_add_u64(meta, st->st_mode);
+	if (flags[FLAG_ATIME])
+		sum_add_time(meta, st->st_atime);
+	if (flags[FLAG_MTIME])
+		sum_add_time(meta, st->st_mtime);
+	if (flags[FLAG_CTIME])
+		sum_add_time(meta, st->st_ctime);
+}
+void
+print_manifest(char* path, sum_t *meta, sum_t *cs, struct stat64 *st) {
+	if (gen_manifest || in_manifest) {
+		char *fn;
+		char *m;
+		char *c;
+
+		if (S_ISDIR(st->st_mode))
+			strcat(path, "/");
+		fn = escape(path);
+		m = sum_to_string(meta);
+		c = sum_to_string(cs);
+
+		if (gen_manifest)
+			fprintf(out_fp, "%s %s %s\n", fn, m, c);
+		if (in_manifest)
+			check_manifest(fn, m, c, 0);
+		free(c);
+		free(m);
+		free(fn);
+	}
+}
+
+void
+sum_file(int fd, sum_t *finalcs, struct stat64 *st, char *path) {
+	int ret;
+	sum_file_data_t sum_file_data = flags[FLAG_STRUCTURE] ?
+			sum_file_data_strict : sum_file_data_permissive;
+
+	sum_t cs;
+	sum_t meta;
+
+	sum_init(&cs);
+	sum_init(&meta);
+
+	char* name = basename(path);
+	sum_add(&meta, name, strlen(name));
+	sum_meta(&meta, st);
+
+	if (flags[FLAG_XATTRS]) {
+		ret = sum_xattrs(fd, &meta);
+		if (ret < 0) {
+			fprintf(stderr, "failed to read xattrs from "
+					"%s: %s\n", path, strerror(-ret));
+			exit(-1);
+		}
+	}
+
+	if (flags[FLAG_SIZE])
+		sum_add_u64(&meta, st->st_size);
+
+	if (flags[FLAG_DATA]) {
+		ret = sum_file_data(fd, &cs);
+		if (ret < 0) {
+			fprintf(stderr, "read failed for %s: %s\n", path,
+					strerror(errno));
+			exit(-1);
+		}
+	}
+
+	sum_fini(&cs);
+	sum_fini(&meta);
+
+	print_manifest(path, &meta, &cs, st);
+
+	sum_add_sum(finalcs, &cs);
+	sum_add_sum(finalcs, &meta);
+}
+
 void
 sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 {
@@ -582,20 +673,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 
 		sum_add_u64(&meta, level);
 		sum_add(&meta, namelist[i], strlen(namelist[i]));
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
+		sum_meta(&meta, &st);
 		if (flags[FLAG_XATTRS] &&
 		    (S_ISDIR(st.st_mode) || S_ISREG(st.st_mode))) {
 			fd = openat(dirfd, namelist[i], 0);
@@ -618,7 +696,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 				}
 			}
 		}
-		if (S_ISDIR(st.st_mode)) {
+		if (S_ISDIR(st.st_mode) && recursive) {
 			fd = openat(dirfd, namelist[i], 0);
 			if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
 				sum_add_u64(&meta, errno);
@@ -631,7 +709,8 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 				close(fd);
 			}
 		} else if (S_ISREG(st.st_mode)) {
-			sum_add_u64(&meta, st.st_size);
+			if (flags[FLAG_SIZE])
+				sum_add_u64(&meta, st.st_size);
 			if (flags[FLAG_DATA]) {
 				if (verbose)
 					fprintf(stderr, "file %s\n",
@@ -672,25 +751,9 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 		}
 		sum_fini(&cs);
 		sum_fini(&meta);
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
+
+		print_manifest(path, &meta, &cs, &st);
+
 		sum_add_sum(dircs, &cs);
 		sum_add_sum(dircs, &meta);
 next:
@@ -712,7 +775,7 @@ main(int argc, char *argv[])
 	int plen;
 	int elen;
 	int n_flags = 0;
-	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNw:r:vx:";
+	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSzZnNRw:r:vx:";
 
 	out_fp = stdout;
 	while ((c = getopt(argc, argv, allopts)) != EOF) {
@@ -720,6 +783,9 @@ main(int argc, char *argv[])
 		case 'f':
 			gen_manifest = 1;
 			break;
+		case 'R':
+			recursive = 0;
+			break;
 		case 'u':
 		case 'U':
 		case 'g':
@@ -740,6 +806,8 @@ main(int argc, char *argv[])
 		case 'E':
 		case 's':
 		case 'S':
+		case 'z':
+		case 'Z':
 			++n_flags;
 			parse_flag(c);
 			break;
@@ -855,8 +923,22 @@ main(int argc, char *argv[])
 	if (gen_manifest)
 		fprintf(out_fp, "Flags: %s\n", flagstring);
 
+	struct stat64 path_st;
+	if (fstat64(fd, &path_st)) {
+		perror("fstat");
+		exit(-1);
+	}
+
 	sum_init(&cs);
-	sum(fd, 1, &cs, path, "");
+	if (S_ISDIR(path_st.st_mode)) {
+		sum(fd, 1, &cs, path, "");
+	} else if (S_ISREG(path_st.st_mode)) {
+		sum_file(fd, &cs, &path_st, path);
+	} else {
+		fprintf(stderr, "path must be file or dir: %s", path);
+		exit(-1);
+	}
+
 	sum_fini(&cs);
 
 	close(fd);
-- 
2.20.1

