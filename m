Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F10C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Apr 2022 17:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiDTRzs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiDTRzs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Apr 2022 13:55:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E863968A
        for <fstests@vger.kernel.org>; Wed, 20 Apr 2022 10:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11825B81EB7
        for <fstests@vger.kernel.org>; Wed, 20 Apr 2022 17:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B74C385A1;
        Wed, 20 Apr 2022 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650477178;
        bh=nM7i64I7iaXau9h9H8t4XLkJwuZpH0tWRosOusAdLZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQ5CgNfDoXQUEHOZ4AImmIWFGmPb5zHUd1eMHjZcVq4P7xCousBCGzK9yueWSy93d
         oodLYzrE54CpqNqMMSGY79vaHg0pUeddB9/90hRzSVl65B4TYJPRc9vZmFTlrSpOH6
         TnXGWS4x2g459K/UyehqAnmhuVjNRbHXVLKoSuKhwtFEthaTKW3QtcVItFr8YmwV3v
         zYuG5JFJ6Y51SXjBMfJwbgUVLtROpp7XayRPxlUmSNIwfTLkOkpc3aEuo3tngVKFJo
         hUPC69Tt9a/JKA3bUizU0T9luW02FYEWqJEb23pVscyQndTognnzvtq8yi8gvtZDMo
         7AXzzF5XFPmLg==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org
Subject: [PATCH] generic: add test for tmpfs POSIX ACLs
Date:   Wed, 20 Apr 2022 19:52:22 +0200
Message-Id: <20220420175221.2502964-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419131423.2367795-1-brauner@kernel.org>
References: 
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7974; h=from:subject; bh=nM7i64I7iaXau9h9H8t4XLkJwuZpH0tWRosOusAdLZU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQleMjF7HnKt4u1VkZPYvLeOQI8Hh3FNxtUFx78crg0cPVd Dt/pHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJCWX4H9e7Ql4yYwu7+p/9DLlxk7 K7brGdPLTYuGn/rrZZDZeObGVkeJPPz/357OQy+SMLhZYZ5F87KNQsqrjaiX/xNePpim22/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a regression test for commit 705191b03d50 ("fs: fix acl translation").
This tests whether setting POSIX ACLs on a tmpfs mounted in a
non-initial user and mount namespace works as expected.

Note, once again the idmapped mount testsuite is grossly misnamed at
this point. It has morphed into a full-blown generic vfs feature
testsuite.

Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Hey,

As promised yesterday in
https://lore.kernel.org/linux-fsdevel/20220419131423.2367795-1-brauner@kernel.org
this adds a regression test to xfstests.

Thanks!
Christian
---
 src/idmapped-mounts/idmapped-mounts.c | 140 +++++++++++++++++++++++++-
 tests/generic/683                     |  32 ++++++
 tests/generic/683.out                 |   2 +
 3 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/683
 create mode 100644 tests/generic/683.out

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 4cf6c3bb..7a0aeb3d 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -13791,6 +13791,128 @@ out:
 	return fret;
 }
 
+/**
+ * setxattr_fix_705191b03d50 - test for commit 705191b03d50 ("fs: fix acl translation").
+ */
+static int setxattr_fix_705191b03d50(void)
+{
+	int fret = -1;
+	int fd_userns = -EBADF;
+	int ret;
+	uid_t user1_uid;
+	gid_t user1_gid;
+	pid_t pid;
+	struct list idmap;
+	struct list *it_cur, *it_next;
+
+	list_init(&idmap);
+
+	if (!lookup_ids(USER1, &user1_uid, &user1_gid)) {
+		log_stderr("failure: lookup_user");
+		goto out;
+	}
+
+	log_debug("Found " USER1 " with uid(%d) and gid(%d)", user1_uid, user1_gid);
+
+	if (mkdirat(t_dir1_fd, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	if (chown_r(t_mnt_fd, T_DIR1, user1_uid, user1_gid)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	print_r(t_mnt_fd, T_DIR1);
+
+	/* u:0:user1_uid:1 */
+	ret = add_map_entry(&idmap, user1_uid, 0, 1, ID_TYPE_UID);
+	if (ret) {
+		log_stderr("failure: add_map_entry");
+		goto out;
+	}
+
+	/* g:0:user1_gid:1 */
+	ret = add_map_entry(&idmap, user1_gid, 0, 1, ID_TYPE_GID);
+	if (ret) {
+		log_stderr("failure: add_map_entry");
+		goto out;
+	}
+
+	/* u:100:10000:100 */
+	ret = add_map_entry(&idmap, 10000, 100, 100, ID_TYPE_UID);
+	if (ret) {
+		log_stderr("failure: add_map_entry");
+		goto out;
+	}
+
+	/* g:100:10000:100 */
+	ret = add_map_entry(&idmap, 10000, 100, 100, ID_TYPE_GID);
+	if (ret) {
+		log_stderr("failure: add_map_entry");
+		goto out;
+	}
+
+	fd_userns = get_userns_fd_from_idmap(&idmap);
+	if (fd_userns < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(fd_userns, 0, 0, false))
+			die("failure: switch_userns");
+
+		/* create separate mount namespace */
+		if (unshare(CLONE_NEWNS))
+			die("failure: create new mount namespace");
+
+		/* turn off mount propagation */
+		if (sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0))
+			die("failure: turn mount propagation off");
+
+		snprintf(t_buf, sizeof(t_buf), "%s/%s/%s", t_mountpoint, T_DIR1, DIR1);
+
+		if (sys_mount("none", t_buf, "tmpfs", 0, "mode=0755"))
+			die("failure: mount");
+
+		snprintf(t_buf, sizeof(t_buf), "%s/%s/%s/%s", t_mountpoint, T_DIR1, DIR1, DIR3);
+		if (mkdir(t_buf, 0700))
+			die("failure: mkdir");
+
+		snprintf(t_buf, sizeof(t_buf), "setfacl -m u:100:rwx %s/%s/%s/%s", t_mountpoint, T_DIR1, DIR1, DIR3);
+		if (system(t_buf))
+			die("failure: system");
+
+		snprintf(t_buf, sizeof(t_buf), "getfacl -n -p %s/%s/%s/%s | grep -q user:100:rwx", t_mountpoint, T_DIR1, DIR1, DIR3);
+		if (system(t_buf))
+			die("failure: system");
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(fd_userns);
+
+	list_for_each_safe(it_cur, &idmap, it_next) {
+		list_del(it_cur);
+		free(it_cur->elem);
+		free(it_cur);
+	}
+
+	return fret;
+}
+
 static void usage(void)
 {
 	fprintf(stderr, "Description:\n");
@@ -13809,6 +13931,7 @@ static void usage(void)
 	fprintf(stderr, "--test-nested-userns                Run nested userns idmapped mount testsuite\n");
 	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
 	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
+	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
 
 	_exit(EXIT_SUCCESS);
 }
@@ -13826,6 +13949,7 @@ static const struct option longopts[] = {
 	{"test-nested-userns",			no_argument,		0,	'n'},
 	{"test-btrfs",				no_argument,		0,	'b'},
 	{"test-setattr-fix-968219708108",	no_argument,		0,	'i'},
+	{"test-setxattr-fix-705191b03d50",	no_argument,		0,	'j'},
 	{NULL,					0,			0,	  0},
 };
 
@@ -13923,6 +14047,11 @@ struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
 	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
 };
 
+/* Test for commit 705191b03d50 ("fs: fix acl translation"). */
+struct t_idmapped_mounts t_setxattr_fix_705191b03d50[] = {
+	{ setxattr_fix_705191b03d50,					false,	"test that setxattr works correctly for userns mountable filesystems",				},
+};
+
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 {
 	int i;
@@ -14000,7 +14129,8 @@ int main(int argc, char *argv[])
 	int index = 0;
 	bool supported = false, test_btrfs = false, test_core = false,
 	     test_fscaps_regression = false, test_nested_userns = false,
-	     test_setattr_fix_968219708108 = false;
+	     test_setattr_fix_968219708108 = false,
+	     test_setxattr_fix_705191b03d50 = false;
 
 	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
@@ -14037,6 +14167,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			test_setattr_fix_968219708108 = true;
 			break;
+		case 'j':
+			test_setxattr_fix_705191b03d50 = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -14106,6 +14239,11 @@ int main(int argc, char *argv[])
 		      ARRAY_SIZE(t_setattr_fix_968219708108)))
 		goto out;
 
+	if (test_setxattr_fix_705191b03d50 &&
+	    !run_test(t_setxattr_fix_705191b03d50,
+		      ARRAY_SIZE(t_setxattr_fix_705191b03d50)))
+		goto out;
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git a/tests/generic/683 b/tests/generic/683
new file mode 100755
index 00000000..397548ed
--- /dev/null
+++ b/tests/generic/683
@@ -0,0 +1,32 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
+#
+# FS QA Test No. 683
+#
+# Test that setting POSIX ACLs in userns-mountable filesystems works.
+#
+# Regression test for commit:
+#
+# 705191b03d50 ("fs: fix acl translation")
+#
+. ./common/preamble
+_begin_fstest auto quick perms
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+_require_user fsgqa
+_require_group fsgqa
+
+echo "Silence is golden"
+
+$here/src/idmapped-mounts/idmapped-mounts --test-setxattr-fix-705191b03d50 \
+	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
+
+status=$?
+exit
diff --git a/tests/generic/683.out b/tests/generic/683.out
new file mode 100644
index 00000000..7f2a2ace
--- /dev/null
+++ b/tests/generic/683.out
@@ -0,0 +1,2 @@
+QA output created by 683
+Silence is golden

base-commit: fbc6486be09c93a68d3863ebf7e3ed851fc4721c
-- 
2.32.0

