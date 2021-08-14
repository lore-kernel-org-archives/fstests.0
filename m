Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D8C4338F
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28A360F48
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbhHNKtj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 14 Aug 2021 06:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237870AbhHNKti (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 14 Aug 2021 06:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 168EA60FC1;
        Sat, 14 Aug 2021 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628938150;
        bh=uvKXHarXecbs4SUhHADE/w7gEIo/2hERGnNFRNn7qIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oj04i7bLKqD1ydWGrn21BIoFsRKpOCiOK1qqaFmolKYXXdoYxWmWODrBKkP58JR3D
         LiqV7wHX/f/eG5154ARxY0AVgvCSR1QoBZPmVIG4iLTcAgT/YNs9qkMOXz8RQY4f9+
         9Ui8ppJ3e7SR0zz2gHHOzuH+Ss8h6hSY4KlxsBUFTvYrQAJYsqzWZ7g1sJQz6OOk2L
         8cT5QO58xh9G04ckl9eRqdW0iVpzoH9D+NFI6lr3IzWZ71yFxHEvn5yRGd+9v6ax+q
         +03zzH7EkyDzgBOhEeD36qSWJ8USILeDZGlQw/vE5WSYsUUOmm/Edj0yn6P2hDc7f1
         lF7KvghkFaN2Q==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 4/8] generic/640: add fscaps regression test
Date:   Sat, 14 Aug 2021 12:48:01 +0200
Message-Id: <20210814104805.1124023-5-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814104805.1124023-1-brauner@kernel.org>
References: <20210814104805.1124023-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9528; h=from:subject; bh=80/uhKCT8XgTsWhP3LGiVulUcZAEmlNYhR01palJdfc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSKzw83nDZBYZeHueAecTaGV+XLPspxGnhpZe1PLrPqOBbq +2drRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWHWNkWPrk2Z6ll7e7f450d9HVni Pc+kFqt7ZGwAYz7dfdgvvrbzIyrDW4sX3VsrKZ/o5mSaxnEn+orW7s4Ja7mZ87Z9/34JDFLAA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Eryu Guan <guan@eryu.me>:
  - Don't create symlinks for each test. Instead, use the same binary
    and introduce new options to specify which tests to run.

/* v3 */
unchanged

/* v4 */
unchanged
---
 src/idmapped-mounts/idmapped-mounts.c | 159 +++++++++++++++++++++++---
 tests/generic/640                     |  28 +++++
 tests/generic/640.out                 |   2 +
 3 files changed, 174 insertions(+), 15 deletions(-)
 create mode 100755 tests/generic/640
 create mode 100644 tests/generic/640.out

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index e45248e1..dca03d08 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -3199,6 +3199,121 @@ out:
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
@@ -8717,24 +8832,26 @@ static void usage(void)
 	fprintf(stderr, "    Run idmapped mount tests\n\n");
 
 	fprintf(stderr, "Arguments:\n");
-	fprintf(stderr, "--device        Device used in the tests\n");
-	fprintf(stderr, "--fstype        Filesystem type used in the tests\n");
-	fprintf(stderr, "--help          Print help\n");
-	fprintf(stderr, "--mountpoint    Mountpoint of device\n");
-	fprintf(stderr, "--supported     Test whether idmapped mounts are supported on this filesystem\n");
-	fprintf(stderr, "--test-core     Run core idmapped mount testsuite\n");
+	fprintf(stderr, "--device                     Device used in the tests\n");
+	fprintf(stderr, "--fstype                     Filesystem type used in the tests\n");
+	fprintf(stderr, "--help                       Print help\n");
+	fprintf(stderr, "--mountpoint                 Mountpoint of device\n");
+	fprintf(stderr, "--supported                  Test whether idmapped mounts are supported on this filesystem\n");
+	fprintf(stderr, "--test-core                  Run core idmapped mount testsuite\n");
+	fprintf(stderr, "--test-fscaps-regression     Run fscap regression tests\n");
 
 	_exit(EXIT_SUCCESS);
 }
 
 static const struct option longopts[] = {
-	{"device",	required_argument,	0,	'd'},
-	{"fstype",	required_argument,	0,	'f'},
-	{"mountpoint",	required_argument,	0,	'm'},
-	{"supported",	no_argument,		0,	's'},
-	{"help",	no_argument,		0,	'h'},
-	{"test-core",	no_argument,		0,	'c'},
-	{NULL,		0,			0,	0},
+	{"device",			required_argument,	0,	'd'},
+	{"fstype",			required_argument,	0,	'f'},
+	{"mountpoint",			required_argument,	0,	'm'},
+	{"supported",			no_argument,		0,	's'},
+	{"help",			no_argument,		0,	'h'},
+	{"test-core",			no_argument,		0,	'c'},
+	{"test-fscaps-regression",	no_argument,		0,	'g'},
+	{NULL,				0,			0,	  0},
 };
 
 struct t_idmapped_mounts {
@@ -8748,7 +8865,7 @@ struct t_idmapped_mounts {
 	{ fscaps,							"fscaps on regular mounts",									},
 	{ fscaps_idmapped_mounts,					"fscaps on idmapped mounts",									},
 	{ fscaps_idmapped_mounts_in_userns,				"fscaps on idmapped mounts in user namespace",							},
-	{ fscaps_idmapped_mounts_in_userns_separate_userns,		"fscaps on idmapped mounts in user namespace with different id mappings ",			},
+	{ fscaps_idmapped_mounts_in_userns_separate_userns,		"fscaps on idmapped mounts in user namespace with different id mappings",			},
 	{ fsids_mapped,							"mapped fsids",											},
 	{ fsids_unmapped,						"unmapped fsids",										},
 	{ hardlink_crossing_mounts,					"cross mount hardlink",										},
@@ -8792,6 +8909,10 @@ struct t_idmapped_mounts {
 	{ threaded_idmapped_mount_interactions,				"threaded operations on idmapped mounts",							},
 };
 
+struct t_idmapped_mounts fscaps_in_ancestor_userns[] = {
+	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
+};
+
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 {
 	int i;
@@ -8829,7 +8950,7 @@ int main(int argc, char *argv[])
 {
 	int fret, ret;
 	int index = 0;
-	bool supported = false, test_core = false;
+	bool supported = false, test_core = false, test_fscaps_regression = false;
 
 	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
@@ -8848,6 +8969,9 @@ int main(int argc, char *argv[])
 		case 'c':
 			test_core = true;
 			break;
+		case 'g':
+			test_fscaps_regression = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -8920,6 +9044,11 @@ int main(int argc, char *argv[])
 	if (test_core && !run_test(basic_suite, ARRAY_SIZE(basic_suite)))
 		goto out;
 
+	if (test_fscaps_regression &&
+	    !run_test(fscaps_in_ancestor_userns,
+		      ARRAY_SIZE(fscaps_in_ancestor_userns)))
+		goto out;
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git a/tests/generic/640 b/tests/generic/640
new file mode 100755
index 00000000..a3795b2d
--- /dev/null
+++ b/tests/generic/640
@@ -0,0 +1,28 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Christian Brauner.  All Rights Reserved.
+#
+# FS QA Test 640
+#
+# Test that fscaps on idmapped mounts behave correctly.
+#
+. ./common/preamble
+_begin_fstest auto quick cap idmapped mount
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs generic
+_require_idmapped_mounts
+_require_test
+
+echo "Silence is golden"
+
+$here/src/idmapped-mounts/idmapped-mounts --test-fscaps-regression \
+	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
+
+status=$?
+exit
diff --git a/tests/generic/640.out b/tests/generic/640.out
new file mode 100644
index 00000000..a336a0f5
--- /dev/null
+++ b/tests/generic/640.out
@@ -0,0 +1,2 @@
+QA output created by 640
+Silence is golden
-- 
2.30.2

