Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1454AC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 15:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245713AbiETPEO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiETPEN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 11:04:13 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C337A94
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1653059048; i=@fujitsu.com;
        bh=lVifNSXMp7xmnS7rBJdJ7L4boUBi59gssJ1DuX+utzs=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=rBT5LE4gV/zmtBKXBJay2qKoXk1ze7ot7sxI1o4xwS+C0qjV0p5o83Ny/MNvrOAw2
         KpLwWc8tL0uLVWXtsbBi4Q82TqRq80KcYmiQc6JpU0Lw4LxoNru9WCmXO3HHALsT2C
         joc5oC9OHcK6F7SLGAIhjs9y3Y5Ms5ZkfTOMvHG7eqAiFhAeYg7ZymU9Rh7tyxm522
         1LKVWS0FeB37sDO2jYP9wxez7yrMLJU03fqtuGjAs7jp7kH1ayOsaiYoGCMYqlWNxC
         4Loj5HTaq4lD6dlONbpsG2OXRKcHnyFButz7/a9qH3SpRFSL63UR96Ni/PunP02Uez
         gxLbjlQxK5ftQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRWlGSWpSXmKPExsViZ8ORpPtibXu
  SQcNeTovTLXvZHRg9Pm+SC2CMYs3MS8qvSGDN6J02l7Xg9TKmim3HahoY979n7GLk4hASOM8o
  caZjGguEs5tJ4nzbPWYIZw+jxL7ZW4HKODnYBDQlnnUuYAaxRQRkJf7PWM0EYjMLqEssn/QLz
  BYWsJZYsmQXO4jNIqAqcai/D2gqBwevgIfEkWYjkLCEgILElIfvwcZwCnhK3Nh0gBXEFgIqeT
  ZzAwuIzSsgKHFy5hMWiPESEgdfvGCG6FWUuNTxjRHCrpB4ffgSVFxN4uq5TcwTGAVnIWmfhaR
  9ASPTKkarpKLM9IyS3MTMHF1DAwNdQ0NTXRNdI2NLvcQq3US91FLd8tTiEl1DvcTyYr3U4mK9
  4src5JwUvbzUkk2MwCBOKWZ5v4Oxqe+n3iFGSQ4mJVHe0hXtSUJ8SfkplRmJxRnxRaU5qcWHG
  GU4OJQkeHPWAOUEi1LTUyvSMnOAEQWTluDgURLhlQdGlRBvcUFibnFmOkTqFKMux99Pf/cyC7
  Hk5eelSonzNs8DKhIAKcoozYMbAYvuS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeVVXA03
  hycwrgdv0CugIJqAjbim3ghxRkoiQkmpgCmX9JdQ5v/RFyEzuaa33Hz6auag2Kuzkli/vJ7j2
  7C6U4iyf0TAzfNrfW6z1XiuVbD9dP7hdvch7t4mmZ9evVdeqPC2mKVuvUIn3b7/7Z+epp0JbN
  ml0dz/mzDl3T0Ay+a/J48CPbLP28pydqrFWRdzmfEHcZe2vQrvPu166PT/hm+5G+cO/bWLaHN
  SdVso/mH9GI2Dpg6VVO5XOf1neZHl3RZCWucvNSX/yHr77dijNuYa7ae753GNvXb8w1XokrGi
  3FLAqac/8792glnP+qVtQxNm8D0ery2+etytlYXeZ9s1Axq6sqm7dj4fHp7JG5L90WXhuYuM8
  3QLJwuMPnpnPmv1+NVP6o/12HzZPW6rEUpyRaKjFXFScCABAEyU5aQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-591.messagelabs.com!1653059047!162203!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32249 invoked from network); 20 May 2022 15:04:08 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-12.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 May 2022 15:04:08 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id A89B8B5A
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 16:04:07 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9CC00B53
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 16:04:07 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 20 May 2022 16:03:54 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 2/2] vfs: Add new setgid_create_acl test
Date:   Sat, 21 May 2022 00:04:24 +0800
Message-ID: <1653062664-2125-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1653062664-2125-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1653062664-2125-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
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

If the parent directory has a default acl then permissions are based off
of that and current_umask() is ignored. Specifically, if the ACL has an
ACL_MASK entry, the group permissions correspond to the permissions of
the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
group permissions correspond to the permissions of the ACL_GROUP_OBJ
entry.

Here we only use setfacl to set default acl or add ACL_MASK to check
whether inode strip  S_ISGID works correctly.

Like umask test, this patch is also designed to test kernel patchset behaviour
"move S_ISGID stripping into the vfs"
https://patchwork.kernel.org/project/linux-fsdevel/list/?series=635692

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/vfs/idmapped-mounts.c | 702 ++++++++++++++++++++++++++++++++++++++
 src/vfs/idmapped-mounts.h |   1 +
 src/vfs/vfstest.c         | 344 ++++++++++++++++++-
 tests/generic/692         |  29 ++
 tests/generic/692.out     |   2 +
 5 files changed, 1077 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/692
 create mode 100644 tests/generic/692.out

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index 72de52cc..a61a18a7 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -8083,6 +8083,698 @@ out:
 	return fret;
 }
 
+static int setgid_create_acl_idmapped(const struct vfstest_info *info)
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
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx,m:rw %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
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
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+		 * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+		 * entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx, %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
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
+		if (!is_ixgrp(open_tree_fd, FILE1, 0))
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
+		if (!is_ixgrp(open_tree_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(open_tree_fd, CHRDEV1, 0))
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
+			if (!is_ixgrp(open_tree_fd, FILE3, 0))
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
+static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
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
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx,m:rw %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
+		if (!caps_supported()) {
+			log_debug("skip: capability library not installed");
+			exit(EXIT_SUCCESS);
+		}
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
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+		 * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+		 * entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx, %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
+		if (!caps_supported()) {
+			log_debug("skip: capability library not installed");
+			exit(EXIT_SUCCESS);
+		}
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
+		if (!is_ixgrp(open_tree_fd, FILE1, 0))
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
+		if (!is_ixgrp(open_tree_fd, FILE2, 0))
+			 die("failure: is_ixgrp");
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(open_tree_fd, CHRDEV1, 0))
+			 die("failure: is_ixgrp");
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
+			if (!is_ixgrp(open_tree_fd, FILE3, 0))
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
@@ -8174,3 +8866,13 @@ const struct test_suite s_setgid_create_umask_idmapped = {
 	.tests = t_setgid_create_umask_idmapped,
 	.nr_tests = ARRAY_SIZE(t_setgid_create_umask_idmapped),
 };
+
+static const struct test_struct t_setgid_create_acl_idmapped[] = {
+	{ setgid_create_acl_idmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using acl in directories with setgid bit set on idmapped mount",                },
+	{ setgid_create_acl_idmapped_in_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using acl in directories with setgid bit set on idmapped mount inside userns",  },
+};
+
+const struct test_suite s_setgid_create_acl_idmapped = {
+	.tests = t_setgid_create_acl_idmapped,
+	.nr_tests = ARRAY_SIZE(t_setgid_create_acl_idmapped),
+};
diff --git a/src/vfs/idmapped-mounts.h b/src/vfs/idmapped-mounts.h
index a332439f..5256ed4a 100644
--- a/src/vfs/idmapped-mounts.h
+++ b/src/vfs/idmapped-mounts.h
@@ -15,5 +15,6 @@ extern const struct test_suite s_nested_userns;
 extern const struct test_suite s_setattr_fix_968219708108;
 extern const struct test_suite s_setxattr_fix_705191b03d50;
 extern const struct test_suite s_setgid_create_umask_idmapped;
+extern const struct test_suite s_setgid_create_acl_idmapped;
 
 #endif /* __IDMAPPED_MOUNTS_H */
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index 8448362e..a7f02986 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -27,6 +27,8 @@
 #include "missing.h"
 #include "utils.h"
 
+static char t_buf[PATH_MAX];
+
 static void init_vfstest_info(struct vfstest_info *info)
 {
 	info->t_overflowuid		= 65534;
@@ -1913,6 +1915,324 @@ out:
 	return fret;
 }
 
+/*
+ * If the parent directory has a default acl then permissions are based off
+ * of that and current_umask() is ignored. Specifically, if the ACL has an
+ * ACL_MASK entry, the group permissions correspond to the permissions of
+ * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+ * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+ * entry.
+ *
+ * Use setfacl to check whether inode strip S_ISGID works correctly.
+ */
+
+static int setgid_create_acl(const struct vfstest_info *info)
+{
+	int fret = -1;
+	int file1_fd = -EBADF;
+	int tmpfile_fd = -EBADF;
+	pid_t pid;
+	bool supported = false;
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
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx,m:rw %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
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
+		/* create directory */
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
+			if (!expected_uid_gid(info->t_dir1_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(info->t_dir1_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* If the parent directory has a default acl then permissions are based off
+		 * of that and current_umask() is ignored. Specifically, if the ACL has an
+		 * ACL_MASK entry, the group permissions correspond to the permissions of
+		 * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+		 * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+		 * entry.
+		 */
+		umask(S_IXGRP);
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx, %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
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
+		if (!is_ixgrp(info->t_dir1_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		/* create directory */
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
+		if (!is_ixgrp(info->t_dir1_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(info->t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (is_setgid(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(info->t_dir1_fd, CHRDEV1, 0))
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
+			if (!is_ixgrp(info->t_dir1_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (!expected_uid_gid(info->t_dir1_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
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
+
+	return fret;
+}
+
 static int setattr_truncate(const struct vfstest_info *info)
 {
 	int fret = -1;
@@ -1988,6 +2308,7 @@ static void usage(void)
 	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
 	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
 	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
+	fprintf(stderr, "--test-setgid-create-acl            Run setgid with acl tests\n");
 
 	_exit(EXIT_SUCCESS);
 }
@@ -2007,6 +2328,7 @@ static const struct option longopts[] = {
 	{"test-setattr-fix-968219708108",	no_argument,		0,	'i'},
 	{"test-setxattr-fix-705191b03d50",	no_argument,		0,	'j'},
 	{"test-setgid-create-umask",		no_argument,		0,	'u'},
+	{"test-setgid-create-acl",		no_argument,		0,	'l'},
 	{NULL,					0,			0,	  0},
 };
 
@@ -2041,6 +2363,15 @@ static const struct test_suite s_setgid_create_umask = {
 	.nr_tests = ARRAY_SIZE(t_setgid_create_umask),
 };
 
+static const struct test_struct t_setgid_create_acl[] = {
+	{ setgid_create_acl,						0,			"create operations in directories with setgid bit set under posix acl",				},
+};
+
+static const struct test_suite s_setgid_create_acl = {
+	.tests = t_setgid_create_acl,
+	.nr_tests = ARRAY_SIZE(t_setgid_create_acl),
+};
+
 static bool run_test(struct vfstest_info *info, const struct test_struct suite[], size_t suite_size)
 {
 	int i;
@@ -2139,7 +2470,7 @@ int main(int argc, char *argv[])
 	     test_core = false, test_fscaps_regression = false,
 	     test_nested_userns = false, test_setattr_fix_968219708108 = false,
 	     test_setxattr_fix_705191b03d50 = false,
-	     test_setgid_create_umask = false;
+	     test_setgid_create_umask = false, test_setgid_create_acl = false;
 
 	init_vfstest_info(&info);
 
@@ -2184,6 +2515,9 @@ int main(int argc, char *argv[])
 		case 'u':
 			test_setgid_create_umask = true;
 			break;
+		case 'l':
+			test_setgid_create_acl = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -2269,6 +2603,14 @@ int main(int argc, char *argv[])
 			goto out;
 	}
 
+	if (test_setgid_create_acl) {
+		if (!run_suite(&info, &s_setgid_create_acl))
+			goto out;
+
+		if (!run_suite(&info, &s_setgid_create_acl_idmapped))
+			goto out;
+	}
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git a/tests/generic/692 b/tests/generic/692
new file mode 100755
index 00000000..cd7439e4
--- /dev/null
+++ b/tests/generic/692
@@ -0,0 +1,29 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Fujitsu Limited. All Rights Reserved.
+#
+# FS QA Test No. 692
+#
+# Test that idmapped mounts setgid's behave correctly when using
+# acl
+#
+. ./common/preamble
+_begin_fstest auto quick cap acl idmapped mount perms rw unlink
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+_require_acls
+
+echo "Silence is golden"
+
+$here/src/vfs/vfstest --test-setgid-create-acl \
+        --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
+
+status=$?
+exit
diff --git a/tests/generic/692.out b/tests/generic/692.out
new file mode 100644
index 00000000..d7521a9f
--- /dev/null
+++ b/tests/generic/692.out
@@ -0,0 +1,2 @@
+QA output created by 692
+Silence is golden
-- 
2.27.0

