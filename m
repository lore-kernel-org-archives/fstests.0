Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB69C433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 15:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiEGPFH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 11:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiEGPFE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 11:05:04 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F51040931
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1651935673; i=@fujitsu.com;
        bh=g4KiIrqoTmoIP6H13Hnzes98yx44UkxgISdwMv4g1aY=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=n7dnw2RC06DYieQKELXEDe65TrNvB6tsgyXTBWS7vn9BIml8CbVBucnxNGUOELd1C
         /18fYSAgNosqE700jsBpGmBWwq9BPTsxdotysqOWsIhYz0Gevo0QDzXNlwLWAwg+G9
         CZlROVDMrfGb5O3HTyKXUM0cIsEbKHF/inpSzfSXYTh/WriAcdAfNWrwECTvnoD/eg
         qZv3VRZ9FYjC5TvXamIfkMk+5AMM4WRn6bu7LRSA9Nc3XBdQcdULRIWLogtEeSTus0
         6FOabEwrWVievqsmHZPGk+PI5/PxFEW8WkGtypfGluuwmWAICb9imIX3SfaRJChiEl
         7HpLJsB+LIxGA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRWlGSWpSXmKPExsViZ8ORqLujsyz
  J4PtUcYvXhz8xWpxu2cvuwOSxaVUnm8fnTXIBTFGsmXlJ+RUJrBlLGxqYC67ZV3StXcDewDjX
  pIuRi0NIYAujxLv2q2wQzgImiclrGxm7GDmBnN2MEpuXVYPYbAKaEs86FzB3MXJwiAhISOxaF
  AYSZhZwkpiz7hQTiC0sECkx9cAKdhCbRUBF4s7xc6wgNq+Ah8StF5fBbAkBBYkpD98zg9icAp
  4Ssy9NYYdY5SGx7PBfZoh6QYmTM5+wQMyXkDj44gUzRK+ixKWOb4wQdoXErFltTBC2msTVc5u
  YJzAKzkLSPgtJ+wJGplWMdklFmekZJbmJmTm6hgYGuoaGprpm5rqGZmZ6iVW6iXqppbrJqXkl
  RYlAab3E8mK91OJiveLK3OScFL281JJNjMDgTil2XraD8V3fT71DjJIcTEqivC02pUlCfEn5K
  ZUZicUZ8UWlOanFhxhlODiUJHgDOsqShASLUtNTK9Iyc4CRBpOW4OBREuG1KQVK8xYXJOYWZ6
  ZDpE4xKkqJ8ybVASUEQBIZpXlwbbDovsQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmPcIyHa
  ezLwSuOmvgBYzAS3+GFAKsrgkESEl1cCkdDZBRLcsa2O9RuVH5ZgQhl+iVzv3xFcoFZ3rKIu5
  1slrF9lo6ddYeflBj9uie/uU9A5c5113RD3BTPuBkWxWd/ED5Uey3LHMV9/PVdv6Qv1yjbpEQ
  mYt27r/Tg/a3HrXNU5v/u1y0CzxTrWr2PpdbY7vZqtW5+eGLNcOLVgvNzXpxH9zV73Df7bXbt
  tmK1Uz/WpYDPucjSYxb+udQ2+mNWhy6xxZzazd4LHxoPf1La0LRc4Fe957KZigpLY2onSKKbN
  sxY09t1snadUwiPPOluG8fNGe63P/9DccQmv8d6pXSHGd71kXZjhFPnhT6tuSQLVAzfhtnP/f
  9c/gWF/sw/H5M9vMNu1SzmhTJZbijERDLeai4kQAs74NWGkDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-528.messagelabs.com!1651935672!34406!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15877 invoked from network); 7 May 2022 15:01:12 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-3.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 May 2022 15:01:12 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C93BA10018C;
        Sat,  7 May 2022 16:01:11 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A4E05100189;
        Sat,  7 May 2022 16:01:11 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 7 May 2022 16:00:56 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <brauner@kernel.org>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v5 3/3] idmapped-mounts: Add open with O_TMPFILE operation in setgid test
Date:   Sun, 8 May 2022 00:01:27 +0800
Message-ID: <1651939287-2714-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651939287-2714-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1651939287-2714-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since we can create temp file by using O_TMPFILE flag and filesystem driver also
has this api, we should also check this operation whether strip S_ISGID.

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 145 ++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 592a15d5..f3873e52 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -51,6 +51,7 @@
 #define FILE1_RENAME "file1_rename"
 #define FILE2 "file2"
 #define FILE2_RENAME "file2_rename"
+#define FILE3 "file3"
 #define DIR1 "dir1"
 #define DIR2 "dir2"
 #define DIR3 "dir3"
@@ -340,6 +341,24 @@ out:
 	return fret;
 }
 
+static bool openat_tmpfile_supported(int dirfd)
+{
+	int fd = -1;
+
+	fd = openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+	if (fd == -1) {
+		if (errno == ENOTSUP)
+			return false;
+		else
+			return log_errno(false, "failure: create");
+	}
+
+	if (close(fd))
+		log_stderr("failure: close");
+
+	return true;
+}
+
 /* __expected_uid_gid - check whether file is owned by the provided uid and gid */
 static bool __expected_uid_gid(int dfd, const char *path, int flags,
 			       uid_t expected_uid, gid_t expected_gid, bool log)
@@ -7844,7 +7863,9 @@ static int setgid_create(void)
 {
 	int fret = -1;
 	int file1_fd = -EBADF;
+	int tmpfile_fd = -EBADF;
 	pid_t pid;
+	bool supported = false;
 
 	if (!caps_supported())
 		return 0;
@@ -7869,6 +7890,8 @@ static int setgid_create(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(t_dir1_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -7932,6 +7955,24 @@ static int setgid_create(void)
 		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", t_dir1_fd, FILE3, AT_EMPTY_PATH))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (!is_setgid(t_dir1_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(t_dir1_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(t_dir1_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8021,6 +8062,24 @@ static int setgid_create(void)
 		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", t_dir1_fd, FILE3, AT_EMPTY_PATH))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(t_dir1_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(t_dir1_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(t_dir1_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8042,6 +8101,9 @@ static int setgid_create_idmapped(void)
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
 
 	if (!caps_supported())
 		return 0;
@@ -8089,6 +8151,8 @@ static int setgid_create_idmapped(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(open_tree_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8171,6 +8235,25 @@ static int setgid_create_idmapped(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 10000, 10000))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8194,6 +8277,9 @@ static int setgid_create_idmapped_in_userns(void)
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
 
 	if (!caps_supported())
 		return 0;
@@ -8241,6 +8327,8 @@ static int setgid_create_idmapped_in_userns(void)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(open_tree_fd);
+
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8307,6 +8395,25 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (!is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8415,6 +8522,25 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 1000))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8511,6 +8637,25 @@ static int setgid_create_idmapped_in_userns(void)
 		if (unlinkat(open_tree_fd, CHRDEV1, 0))
 			die("failure: delete");
 
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
-- 
2.27.0

