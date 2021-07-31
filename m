Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A34FC4338F
	for <linux-fstests@archiver.kernel.org>; Sat, 31 Jul 2021 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094AF61050
	for <linux-fstests@archiver.kernel.org>; Sat, 31 Jul 2021 16:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhGaQ67 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 31 Jul 2021 12:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhGaQ67 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 31 Jul 2021 12:58:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C58BB60F46;
        Sat, 31 Jul 2021 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627750733;
        bh=WBKmgpCL1OLO4t1+JIoma/oR8W4nvU4KKpHxGUpDHso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4nNGHHup5EN7Ki/a+QV4O5ipF6vE4Sa1Vh6FuCsWRMOqIRl/6bEv7poGUwrpKI5w
         jPedK8z+5O6/pm72pDAdeYdjk8cpMCA0erdVDxp9J9DVYMPuyf3+WiGSNGnl9EPTNc
         FtQ3rssBlOcAGVeaQHVIKHXGL3lf4gl1vAyxvUKjRtb0Tu4EUPUgNPTWKM25virlHH
         J7G4A5E+WUa+GnbRk01AAT7FmoP2xNcAk/aJI9JYl4fPT//DbYsPdIETZc3v2PC3Tj
         TpZScD9gJ2T94qq8OzT/5KR9e0UfL9X1YyskhrJo+nuwHC6L6lXuaqhJPUqQntCLGX
         OswNSFtlRXqXA==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 2/6] generic/640: add fscaps regression test
Date:   Sat, 31 Jul 2021 18:58:30 +0200
Message-Id: <20210731165834.479633-3-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210731165834.479633-1-brauner@kernel.org>
References: <20210731165834.479633-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9432; h=from:subject; bh=hkOZ8gVvY4huNYSzZl5myzlQ5fSeu24GJaF5uNRpED0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSyNkqYPdaV3RqZ5JTV7HFwuWe9x78tDAvmMbL+PlfuefJG 8iyGjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn8E2X4xfTN9Ohm+edqzKnXrr7pDj H93ND29oxayO/vMlI3GLVUZjD807sYGHz+tfqU6mzvPSI6kh4vJmWx358W1GS7QVww8t9uLgA=
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
Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Eryu Guan <guan@eryu.me>:
  - Don't create symlinks for each test. Instead, use the same binary
    and introduce new options to specify which tests to run.
---
 src/idmapped-mounts/idmapped-mounts.c | 159 +++++++++++++++++++++++---
 tests/generic/640                     |  28 +++++
 tests/generic/640.out                 |   2 +
 3 files changed, 174 insertions(+), 15 deletions(-)
 create mode 100755 tests/generic/640
 create mode 100644 tests/generic/640.out

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index c8635362..66411970 100644
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
-	{"device",	required_argument,	0,	1},
-	{"fstype",	required_argument,	0,	2},
-	{"mountpoint",	required_argument,	0,	3},
-	{"supported",	no_argument,		0,	4},
-	{"help",	no_argument,		0,	5},
-	{"test-core",	no_argument,		0,	6},
-	{NULL,		0,			0,	0},
+	{"device",			required_argument,	0,	1},
+	{"fstype",			required_argument,	0,	2},
+	{"mountpoint",			required_argument,	0,	3},
+	{"supported",			no_argument,		0,	4},
+	{"help",			no_argument,		0,	5},
+	{"test-core",			no_argument,		0,	6},
+	{"test-fscaps-regression",	no_argument,		0,	7},
+	{NULL,				0,			0,	0},
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
 
 	while ((ret = getopt_long(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
@@ -8848,6 +8969,9 @@ int main(int argc, char *argv[])
 		case 6:
 			test_core = true;
 			break;
+		case 7:
+			test_fscaps_regression = true;
+			break;
 		case 5:
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

