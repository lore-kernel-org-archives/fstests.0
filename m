Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CFDC433ED
	for <linux-fstests@archiver.kernel.org>; Sat,  1 May 2021 12:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C9F61423
	for <linux-fstests@archiver.kernel.org>; Sat,  1 May 2021 12:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhEAM0q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 1 May 2021 08:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231960AbhEAM0q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 1 May 2021 08:26:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36CB761406;
        Sat,  1 May 2021 12:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619871956;
        bh=Xj2RjhlOpeS9x3IVdiwabaHefFE9w2awWv4KGNbbDwk=;
        h=From:To:Cc:Subject:Date:From;
        b=W/OvcBGyVhZ1S4eL5MlWDCkbRjswW8Pr5gxDwe95WBY5SCA59Jp2SYWuJ0YUHI+dY
         LfaQsRqWnP/QZ7iM3omXK0YXa6qDD1a3plwhuq3e80FAA9QV6xzWjog6PxyHRXLFC+
         FBeDRr6pFlec7pciy1Ngkb3W7xEGON+/EwIvpUxU3cHrLQRYOVWciV04T7kogXMFiD
         j3c7OAShAscO2fAbzEsSB1FceVqt2tERf434Tydk9akG5UtgDS5hBcTs0VKUh/CWvu
         nV1dfcOA7tKfB3iEEb+rhRnEo5HdxRFzbSbx/2zFbPfCVSDyJDtlhg0v8fUguR7rOW
         492Qh7KYSid+g==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2] generic/633: extend fscaps test
Date:   Sat,  1 May 2021 14:25:39 +0200
Message-Id: <20210501122539.2844335-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=G7+GAmtHT1fOvWjrHGSYUBzRApj8cxdMrLcBmh7+zR4=; m=EtZEQotKpb6JN8l4G45xBer7S6tIn3vMaU+740ytsuI=; p=Vi/v28YemCmKi3cS9Y6CVdDzlKL1LypX5Ptiei2bCMg=; g=79dd8984001b519e1da5901520f83de1cf52e0a7
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYI1IqQAKCRCRxhvAZXjcon6LAQCVaig J99Fa+VgPIJx4oo83yzgJ2vIX9oyyo60vpPAfHQD/Wc0fnJ0iDdwG6Dsi97FMWrVVmjrl7hu3dJdO y3QI0wE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Add a test to verify that setting a v3 fscap from an idmapped mount
works as expected. This and other related use-cases were regressed by
commit [1] which was reverted in [2] and the proper fix merged right
before v5.12 was released in [3].

[1]: commit 3b0c2d3eaa83 ("Revert 95ebabde382c ("capabilities: Don't allow writing ambiguous v3 file capabilities")")
[2]: commit 95ebabde382c ("capabilities: Don't allow writing ambiguous v3 file capabilities")
[3]: commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Cc: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 118 +++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 870a8fe7..6582f3a2 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -3204,6 +3204,121 @@ out:
 	return fret;
 }
 
+static int fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns(void)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, file1_fd2 = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+
+	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
+	if (file1_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/* Skip if vfs caps are unsupported. */
+	if (set_dummy_vfs_caps(file1_fd, 0, 1000))
+		return 0;
+
+	if (fremovexattr(file1_fd, "security.capability")) {
+		log_stderr("failure: fremovexattr");
+		goto out;
+	}
+	if (expected_dummy_vfs_caps_uid(file1_fd, -1)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+	if (errno != ENODATA) {
+		log_stderr("failure: errno");
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
+	open_tree_fd = sys_open_tree(t_dir1_fd, "",
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
+	file1_fd2 = openat(open_tree_fd, FILE1, O_RDWR | O_CLOEXEC, 0);
+	if (file1_fd2 < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	/*
+	 * Verify we can set an v3 fscap for real root this was regressed at
+	 * some point. Make sure this doesn't happen again!
+	 */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (expected_dummy_vfs_caps_uid(file1_fd2, -1))
+			die("failure: expected_dummy_vfs_caps_uid");
+		if (errno != ENODATA)
+			die("failure: errno");
+
+		if (set_dummy_vfs_caps(file1_fd2, 0, 0))
+			die("failure: set_dummy_vfs_caps");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd2, 0))
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		if (!expected_dummy_vfs_caps_uid(file1_fd, 0) && errno != EOVERFLOW)
+			die("failure: expected_dummy_vfs_caps_uid");
+
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		goto out;
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd2, 10000)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	if (!expected_dummy_vfs_caps_uid(file1_fd, 0)) {
+		log_stderr("failure: expected_dummy_vfs_caps_uid");
+		goto out;
+	}
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(file1_fd2);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
 static int fscaps_idmapped_mounts_in_userns_separate_userns(void)
 {
 	int fret = -1;
@@ -8748,7 +8863,8 @@ struct t_idmapped_mounts {
 	{ fscaps,							"fscaps on regular mounts",									},
 	{ fscaps_idmapped_mounts,					"fscaps on idmapped mounts",									},
 	{ fscaps_idmapped_mounts_in_userns,				"fscaps on idmapped mounts in user namespace",							},
-	{ fscaps_idmapped_mounts_in_userns_separate_userns,		"fscaps on idmapped mounts in user namespace with different id mappings ",			},
+	{ fscaps_idmapped_mounts_in_userns_separate_userns,		"fscaps on idmapped mounts in user namespace with different id mappings",			},
+	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
 	{ fsids_mapped,							"mapped fsids",											},
 	{ fsids_unmapped,						"unmapped fsids",										},
 	{ hardlink_crossing_mounts,					"cross mount hardlink",										},

base-commit: 15510d3a208187e234333f7974580786d54d52dc
-- 
2.27.0

