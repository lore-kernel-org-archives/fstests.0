Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F5EECAAA1
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Aug 2022 10:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiH3KQS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Aug 2022 06:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiH3KPr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Aug 2022 06:15:47 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D251BD7D1C
        for <fstests@vger.kernel.org>; Tue, 30 Aug 2022 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661854362; i=@fujitsu.com;
        bh=Yl4QdjyeDLFL1IT2qNbjjgZyKKRQVZ78ZWCq6ZltBGI=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=yJP3yHZRS8/ZwBWryEj12CHa7JWObf5dK6QIMSxs6enc/3DPGd56bHXjFPDBBRb9E
         LpXUygEiXOVd8TLBIjy+ApPuVDazIzdpM+8yrsjbjDRUaZB6Ctcxllw5mcLGWti4qD
         fmJrBVE+TkTENEB0MJmAlMdQhGAyi5B3pqVKk0Sk32cZ2Jdp+L6uhdHmNQN+zCdDyl
         nedCR6/OdLAlMvczBLc8n2Kb/qY7IdvYTWBdes2fjWNwgich/fY4psA9O9xmed5vs+
         latRa/4lTDYsbn+YLLpNu89llYRora2vbXCTiOCsq6EHhJdAsYAJHL7uQL55lh1lA3
         c8yXvxBxxaFfw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRWlGSWpSXmKPExsViZ8MxSXfmI95
  kg55eXYvXhz8xWpxu2cvuwOSxaVUnm8fnTXIBTFGsmXlJ+RUJrBmbu88xFSy9wlhxae101gbG
  NWsYuxi5OIQEtjBKfL96ig3CWcEk8eXybPYuRk4gZy+jxPwd5iA2m4CmxLPOBcwgtoiArMT/G
  auZQGxmAVuJdz/+sYHYwkD2l86zrCA2i4CqxIL1fxhBbF4BD4nzTVPB6iUEFCSmPHwPNodTwF
  Li4sHnTBC7LCQan09lh6gXlDg58wkLxHwJiYMvXjBD9CpKXOr4BjSTA8iulLjxOBUirCZx9dw
  m5gmMgrOQdM9C0r2AkWkVo01SUWZ6RkluYmaOrqGBga6hoamupZmuobGRXmKVbqJeaqluXn5R
  SYauoV5iebFeanGxXnFlbnJOil5easkmRmBwpxQntOxgvL3vl94hRkkOJiVR3oZtvMlCfEn5K
  ZUZicUZ8UWlOanFhxhlODiUJHh1gfEiJFiUmp5akZaZA4w0mLQEB4+SCO/J+0Bp3uKCxNzizH
  SI1ClGXY6ps//tZxZiycvPS5US5y17CFQkAFKUUZoHNwIW9ZcYZaWEeRkZGBiEeApSi3IzS1D
  lXzGKczAqCfN+BpnCk5lXArfpFdARTEBHPFzCDXJESSJCSqqBaVsjT62uZEtfzaIZ1q8c/so0
  nLcv/Xo4L41rSdmkZs/CB+1HQ1KyS4RXe780KtFZc4mxp9Nd4sDReQeM5X/fvWvaxtgQ5ea7N
  EZy6dtpDF/6v1/QmaNQcN9PeWXMMzeZG/eOHerYzfrcea5s8tZjzvKq27MvntIXl7l9R9ZM/P
  jyOtO131n7lm0V3u13s2TqyguMq8sPTl9//HHSnJsf/u3w2FN3wjPgpbC88Gufc8bMMx7/Xbj
  zhkdzhUjFjp0FCw8kx7l4HV1SahJSLNOkdfvkv1AF/duJBzPUt/eorDxxboFx1Mar5slfXRlO
  fbjf8jnggPrt4gkuBj8u7GwTOHuG40Opx0LjkrRkjk3vG5VYijMSDbWYi4oTAZIiUU51AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-18.tower-728.messagelabs.com!1661854361!237377!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18895 invoked from network); 30 Aug 2022 10:12:41 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-18.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Aug 2022 10:12:41 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 1ED6C1000CC;
        Tue, 30 Aug 2022 11:12:41 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 11C4D100078;
        Tue, 30 Aug 2022 11:12:41 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 30 Aug 2022 11:12:37 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <brauner@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 1/2] vfs: Add new setgid_create_umask test
Date:   Tue, 30 Aug 2022 19:13:22 +0800
Message-ID: <1661858003-2181-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20220829135225.wscmhw4dqkzitcvf@wittgenste>
References: <20220829135225.wscmhw4dqkzitcvf@wittgenste>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The current_umask() is stripped from the mode directly in the vfs if the
filesystem either doesn't support acls or the filesystem has been
mounted without posic acl support.

If the filesystem does support acls then current_umask() stripping is
deferred to posix_acl_create(). So when the filesystem calls
posix_acl_create() and there are no acls set or not supported then
current_umask() will be stripped.

This patch is also designed to test kernel patch behaviour
"move S_ISGID stripping into the vfs* helper"

Here we only use umask(S_IXGRP) to check S_ISGID stripping whether works
correctly and S_IXGRP mode still exists.

Also use noacl mount option to test another kernel bug
fs: Add missing umask strip in vfs_tmpfile

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/vfs/idmapped-mounts.c | 460 ++++++++++++++++++++++++++++++++++++++
 src/vfs/idmapped-mounts.h |   1 +
 src/vfs/utils.c           |  14 ++
 src/vfs/utils.h           |   1 +
 src/vfs/vfstest.c         | 204 ++++++++++++++++-
 tests/generic/998         |  46 ++++
 tests/generic/998.out     |   2 +
 7 files changed, 727 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/998
 create mode 100644 tests/generic/998.out

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index 63297d5f..01a5fbd4 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -7664,6 +7664,456 @@ out:
 	return fret;
 }
 
+
+/* The current_umask() is stripped from the mode directly in the vfs if the
+ * filesystem either doesn't support acls or the filesystem has been
+ * mounted without posic acl support.
+ *
+ * If the filesystem does support acls then current_umask() stripping is
+ * deferred to posix_acl_create(). So when the filesystem calls
+ * posix_acl_create() and there are no acls set or not supported then
+ * current_umask() will be stripped.
+ *
+ * Use umask(S_IXGRP) to check whether inode strip S_ISGID works correctly
+ * in idmapped situation.
+ *
+ * Test for commit ac6800e279a2 ("fs: Add missing umask strip in vfs_tmpfile")
+ * and 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers").
+ */
+static int setgid_create_umask_idmapped(const struct vfstest_info *info)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
+	mode_t mode;
+
+	if (!caps_supported())
+		return 0;
+
+	if (fchmod(info->t_dir1_fd, S_IRUSR |
+			      S_IWUSR |
+			      S_IRGRP |
+			      S_IWGRP |
+			      S_IROTH |
+			      S_IWOTH |
+			      S_IXUSR |
+			      S_IXGRP |
+			      S_IXOTH |
+			      S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(info->t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	supported = openat_tmpfile_supported(open_tree_fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
+		 * whether has group execute or search permission.
+		 */
+		umask(S_IXGRP);
+		mode = umask(S_IXGRP);
+		if (!(mode & S_IXGRP))
+			die("failure: umask");
+
+		if (!switch_ids(10000, 11000))
+			die("failure: switch fsids");
+
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(open_tree_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
+			/* We're not in_group_p(). */
+			if (is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
+		if (is_ixgrp(open_tree_fd, DIR1, 0))
+			die("failure: is_ixgrp");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_ixgrp");
+
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 10000, not by gid 11000.
+		 */
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 10000, not by gid 11000.
+		 */
+		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
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
+			if (is_ixgrp(open_tree_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 10000, 10000))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+/* The current_umask() is stripped from the mode directly in the vfs if the
+ * filesystem either doesn't support acls or the filesystem has been
+ * mounted without posic acl support.
+ *
+ * If the filesystem does support acls then current_umask() stripping is
+ * deferred to posix_acl_create(). So when the filesystem calls
+ * posix_acl_create() and there are no acls set or not supported then
+ * current_umask() will be stripped.
+ *
+ * Use umask(S_IXGRP) to check whether inode strip S_ISGID works correctly
+ * in idmapped_in_userns situation.
+ *
+ * Test for commit ac6800e279a2 ("fs: Add missing umask strip in vfs_tmpfile")
+ * and 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers").
+ */
+static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *info)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
+	mode_t mode;
+
+	if (!caps_supported())
+		return 0;
+
+	if (fchmod(info->t_dir1_fd, S_IRUSR |
+			      S_IWUSR |
+			      S_IRGRP |
+			      S_IWGRP |
+			      S_IROTH |
+			      S_IWOTH |
+			      S_IXUSR |
+			      S_IXGRP |
+			      S_IXOTH |
+			      S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(info->t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	supported = openat_tmpfile_supported(open_tree_fd);
+
+	/*
+	 * Below we verify that setgid inheritance for a newly created file or
+	 * directory works correctly. As part of this we need to verify that
+	 * newly created files or directories inherit their gid from their
+	 * parent directory. So we change the parent directorie's gid to 1000
+	 * and create a file with fs{g,u}id 0 and verify that the newly created
+	 * file and directory inherit gid 1000, not 0.
+	 */
+	if (fchownat(info->t_dir1_fd, "", -1, 1000, AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!caps_supported()) {
+			log_debug("skip: capability library not installed");
+			exit(EXIT_SUCCESS);
+		}
+
+		/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
+		 * whether has group execute or search permission.
+		 */
+		umask(S_IXGRP);
+		mode = umask(S_IXGRP);
+		if (!(mode & S_IXGRP))
+			die("failure: umask");
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(open_tree_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
+			/* We're not in_group_p(). */
+			if (is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
+		if (is_ixgrp(open_tree_fd, DIR1, 0))
+			die("failure: is_ixgrp");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_ixgrp");
+
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 1000, not by gid 0.
+		 */
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 1000, not by gid 0.
+		 */
+		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
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
+			if (is_ixgrp(open_tree_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 1000))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
 static const struct test_struct t_idmapped_mounts[] = {
 	{ acls,                                                         true,   "posix acls on regular mounts",                                                                 },
 	{ create_in_userns,                                             true,   "create operations in user namespace",                                                          },
@@ -7745,3 +8195,13 @@ const struct test_suite s_setxattr_fix_705191b03d50 = {
 	.tests = t_setxattr_fix_705191b03d50,
 	.nr_tests = ARRAY_SIZE(t_setxattr_fix_705191b03d50),
 };
+
+static const struct test_struct t_setgid_create_umask_idmapped_mounts[] = {
+	{ setgid_create_umask_idmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using umask in directories with setgid bit set on idmapped mount",		},
+	{ setgid_create_umask_idmapped_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using umask in directories with setgid bit set on idmapped mount inside userns",	},
+};
+
+const struct test_suite s_setgid_create_umask_idmapped_mounts = {
+	.tests = t_setgid_create_umask_idmapped_mounts,
+	.nr_tests = ARRAY_SIZE(t_setgid_create_umask_idmapped_mounts),
+};
diff --git a/src/vfs/idmapped-mounts.h b/src/vfs/idmapped-mounts.h
index ff21ea2c..a9fb31ea 100644
--- a/src/vfs/idmapped-mounts.h
+++ b/src/vfs/idmapped-mounts.h
@@ -14,5 +14,6 @@ extern const struct test_suite s_fscaps_in_ancestor_userns;
 extern const struct test_suite s_nested_userns;
 extern const struct test_suite s_setattr_fix_968219708108;
 extern const struct test_suite s_setxattr_fix_705191b03d50;
+extern const struct test_suite s_setgid_create_umask_idmapped_mounts;
 
 #endif /* __IDMAPPED_MOUNTS_H */
diff --git a/src/vfs/utils.c b/src/vfs/utils.c
index 1388edda..6db7a11d 100644
--- a/src/vfs/utils.c
+++ b/src/vfs/utils.c
@@ -809,6 +809,20 @@ bool is_sticky(int dfd, const char *path, int flags)
 	return (st.st_mode & S_ISVTX) > 0;
 }
 
+/*is_ixgrp - check whether file or directory is S_IXGRP */
+bool is_ixgrp(int dfd, const char *path, int flags)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	errno = 0; /* Don't report misleading errno. */
+	return (st.st_mode & S_IXGRP);
+}
+
 bool switch_resids(uid_t uid, gid_t gid)
 {
 	if (setresgid(gid, gid, gid))
diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index 7fb702fd..c0dbe370 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -368,6 +368,7 @@ extern bool expected_file_size(int dfd, const char *path, int flags,
 extern bool is_setid(int dfd, const char *path, int flags);
 extern bool is_setgid(int dfd, const char *path, int flags);
 extern bool is_sticky(int dfd, const char *path, int flags);
+extern bool is_ixgrp(int dfd, const char *path, int flags);
 extern bool openat_tmpfile_supported(int dirfd);
 
 #endif /* __IDMAP_UTILS_H */
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index 29ac0bec..d430807c 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -1733,6 +1733,185 @@ out:
 	return fret;
 }
 
+/* The current_umask() is stripped from the mode directly in the vfs if the
+ * filesystem either doesn't support acls or the filesystem has been
+ * mounted without posic acl support.
+ *
+ * If the filesystem does support acls then current_umask() stripping is
+ * deferred to posix_acl_create(). So when the filesystem calls
+ * posix_acl_create() and there are no acls set or not supported then
+ * current_umask() will be stripped.
+ *
+ * Use umask(S_IXGRP) to check whether inode strip S_ISGID works correctly.
+ *
+ * test for commit ac6800e279a2 ("fs: Add missing umask strip in vfs_tmpfile")
+ * and 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers").
+ */
+static int setgid_create_umask(const struct vfstest_info *info)
+{
+	int fret = -1;
+	int file1_fd = -EBADF;
+	int tmpfile_fd = -EBADF;
+	pid_t pid;
+	bool supported = false;
+	mode_t mode;
+
+	if (!caps_supported())
+		return 0;
+
+	if (fchmod(info->t_dir1_fd, S_IRUSR |
+			      S_IWUSR |
+			      S_IRGRP |
+			      S_IWGRP |
+			      S_IROTH |
+			      S_IWOTH |
+			      S_IXUSR |
+			      S_IXGRP |
+			      S_IXOTH |
+			      S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the setgid bit got raised. */
+	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
+	supported = openat_tmpfile_supported(info->t_dir1_fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		umask(S_IXGRP);
+		mode = umask(S_IXGRP);
+		if (!(mode & S_IXGRP))
+			die("failure: umask");
+
+		if (!switch_ids(0, 10000))
+			die("failure: switch_ids");
+
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
+		/* create regular file via open() */
+		file1_fd = openat(info->t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(info->t_dir1_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(info->t_dir1_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		if (mkdirat(info->t_dir1_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
+			/* We're not in_group_p(). */
+			if (is_setgid(info->t_dir1_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(info->t_dir1_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
+		if (is_ixgrp(info->t_dir1_fd, DIR1, 0))
+			die("failure: is_ixgrp");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(info->t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(info->t_dir1_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(info->t_dir1_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(info->t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (is_setgid(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_ixgrp");
+
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 0, not by gid 10000.
+		 */
+		if (!expected_uid_gid(info->t_dir1_fd, FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 0, not by gid 10000.
+		 */
+		if (!expected_uid_gid(info->t_dir1_fd, DIR1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(info->t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(info->t_dir1_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(info->t_dir1_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(info->t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(info->t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", info->t_dir1_fd, FILE3, AT_EMPTY_PATH))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(info->t_dir1_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (is_ixgrp(info->t_dir1_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (unlinkat(info->t_dir1_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(file1_fd);
+	return fret;
+}
+
 static int setattr_truncate(const struct vfstest_info *info)
 {
 	int fret = -1;
@@ -1807,6 +1986,7 @@ static void usage(void)
 	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
 	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
 	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
+	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
 
 	_exit(EXIT_SUCCESS);
 }
@@ -1825,6 +2005,7 @@ static const struct option longopts[] = {
 	{"test-btrfs",				no_argument,		0,	'b'},
 	{"test-setattr-fix-968219708108",	no_argument,		0,	'i'},
 	{"test-setxattr-fix-705191b03d50",	no_argument,		0,	'j'},
+	{"test-setgid-create-umask",		no_argument,		0,	'u'},
 	{NULL,					0,			0,	  0},
 };
 
@@ -1850,6 +2031,15 @@ static const struct test_suite s_basic = {
 	.nr_tests = ARRAY_SIZE(t_basic),
 };
 
+static const struct test_struct t_setgid_create_umask[] = {
+	{ setgid_create_umask,						0,			"create operations in directories with setgid bit set under umask",				},
+};
+
+static const struct test_suite s_setgid_create_umask = {
+	.tests = t_setgid_create_umask,
+	.nr_tests = ARRAY_SIZE(t_setgid_create_umask),
+};
+
 static bool run_test(struct vfstest_info *info, const struct test_struct suite[], size_t suite_size)
 {
 	int i;
@@ -1947,7 +2137,8 @@ int main(int argc, char *argv[])
 	bool idmapped_mounts_supported = false, test_btrfs = false,
 	     test_core = false, test_fscaps_regression = false,
 	     test_nested_userns = false, test_setattr_fix_968219708108 = false,
-	     test_setxattr_fix_705191b03d50 = false;
+	     test_setxattr_fix_705191b03d50 = false,
+	     test_setgid_create_umask = false;
 
 	init_vfstest_info(&info);
 
@@ -1989,6 +2180,9 @@ int main(int argc, char *argv[])
 		case 'j':
 			test_setxattr_fix_705191b03d50 = true;
 			break;
+		case 'u':
+			test_setgid_create_umask = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -2066,6 +2260,14 @@ int main(int argc, char *argv[])
 	    !run_suite(&info, &s_setxattr_fix_705191b03d50))
 		goto out;
 
+	if (test_setgid_create_umask) {
+		if (!run_suite(&info, &s_setgid_create_umask))
+			goto out;
+
+		if (!run_suite(&info, &s_setgid_create_umask_idmapped_mounts))
+			goto out;
+	}
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git a/tests/generic/998 b/tests/generic/998
new file mode 100755
index 00000000..5f736b6d
--- /dev/null
+++ b/tests/generic/998
@@ -0,0 +1,46 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Fujitsu Limited. All Rights Reserved.
+#
+# FS QA Test No. 998
+#
+# Test S_ISGID stripping whether works correctly when call process
+# uses umask(S_IXGRP).
+#
+# It is also a regression test for
+# commit ac6800e279a2 ("fs: Add missing umask strip in vfs_tmpfile")
+# commit 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers")
+
+. ./common/preamble
+_begin_fstest auto quick cap idmapped mount perms rw unlink
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+_require_scratch
+_fixed_by_kernel_commit ac6800e279a2 \
+	"fs: Add missing umask strip in vfs_tmpfile" \
+1639a49ccdce "fs: move S_ISGID stripping into the vfs_*() helpers"
+
+_scratch_mkfs >$seqres.full 2>&1
+
+$here/src/vfs/vfstest --test-setgid-create-umask \
+        --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
+
+export MOUNT_OPTIONS="-o noacl"
+
+# Also test S_ISGID stripping whether works correctly on underflying filesystem
+# that supports noacl feature.
+# noacl will earse acl flag in superblock, so kernel will use current_umask in
+# vfs directly instead of calling posix_acl_create on underflying filesystem.
+_try_scratch_mount >>$seqres.full 2>&1 && \
+	$here/src/vfs/vfstest --test-setgid-create-umask \
+        --device "$SCRATCH_DEV" --mount "$SCRATCH_MNT" --fstype "$FSTYP"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/998.out b/tests/generic/998.out
new file mode 100644
index 00000000..d2679ae0
--- /dev/null
+++ b/tests/generic/998.out
@@ -0,0 +1,2 @@
+QA output created by 998
+Silence is golden
-- 
2.27.0

