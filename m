Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04421C433DB
	for <linux-fstests@archiver.kernel.org>; Sat, 27 Mar 2021 11:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1920619C7
	for <linux-fstests@archiver.kernel.org>; Sat, 27 Mar 2021 11:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhC0LTR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 27 Mar 2021 07:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhC0LTQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 27 Mar 2021 07:19:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3E3D619B8;
        Sat, 27 Mar 2021 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616843956;
        bh=EODy+jR6Op5dyLdEI6uDmAVe2BpY0QmK9Lq+F3IK4JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxsO90EhR6r6G50+7leZ6WulKAGDOExKcGz6wsbRqetZE6/YFbA0KmRG6BBRGKV7y
         9TbBV9dwhlHzi2MW53Kng3WRHihN+JAM13w9jxTlz7zaqE3VulBTgfy/J3XGM56JuT
         rAaAEchStA/urzOZo0vMkD3V2By3TuOjCf+rS0wOJVqBXbz6AOuSQoWk1SAlseJC2R
         HvQKZP/Q3WfaOl3ZDdcXdICNkg/gV+LxRuGnFdqbVyK9Wp3YxNuTR9kG2Szs8COI1P
         mcn2TRqnWDLU8UNkvposOR8FVvIWS9q6DIlIbdhQsqk3H+supcSGFC0NIsgVgO/iZY
         j5aD80kg3d5gg==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v11 1/6] generic/631: add test for detached mount propagation
Date:   Sat, 27 Mar 2021 12:18:51 +0100
Message-Id: <20210327111856.1211544-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210327111856.1211544-1-brauner@kernel.org>
References: <20210327111856.1211544-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=A6fAS7tAPRPONqYTQ9f9cKH6F5OBvRuYVz2qXgEb3AM=; m=8ZQ6bRW98ma4GpDy8UjCocC3BLQm2BLWPAkVXt35HZ0=; p=CcuTBwGrUvb0IHd+hy4yoisbQMzrkHnF1QIGY+4WNrc=; g=863cf7c9129eb2448e6b7b670c2334083ee66dc0
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYF8UlQAKCRCRxhvAZXjcooAfAQDFfuB Fe6zwqVeva62EOnytoKEAWhXxp12ARolEDAH7wgD8D+BIi9I+tT69OqZOfNNL9Q9mfTsStpAT3DQu 9WuWKgQ=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Regression test to verify that creating a series of detached mounts,
attaching them to the filesystem, and unmounting them does not trigger an
integer overflow in ns->mounts causing the kernel to block any new mounts in
count_mounts() and returning ENOSPC because it falsely assumes that the
maximum number of mounts in the mount namespace has been reached, i.e. it
thinks it can't fit the new mounts into the mount namespace anymore.

The test is written in a way that it will leave the host's mount
namespace intact so we are sure to never make the host's mount namespace
unuseable!

Link: https://git.kernel.org/torvalds/c/ee2e3f50629f17b0752b55b2566c15ce8dafb557
Cc: Eryu Guan <guan@eryu.me>
Cc: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 - v8 */
patch not present

/* v9 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Rebased on current master.

/* v10 */
- Eryu Guan <guan@eryu.me>:
  - Add missing checks whether test is supported.
  - Move status=$? assignment up.

/* v11 */
unchanged
---
 .gitignore                        |   1 +
 src/Makefile                      |   3 +-
 src/detached_mounts_propagation.c | 252 ++++++++++++++++++++++++++++++
 tests/generic/631                 |  43 +++++
 tests/generic/631.out             |   2 +
 tests/generic/group               |   1 +
 6 files changed, 301 insertions(+), 1 deletion(-)
 create mode 100644 src/detached_mounts_propagation.c
 create mode 100644 tests/generic/631
 create mode 100644 tests/generic/631.out

diff --git a/.gitignore b/.gitignore
index f3bc0a4f..72bd40a0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,6 +62,7 @@
 /src/cloner
 /src/dbtest
 /src/deduperace
+/src/detached_mounts_propagation
 /src/devzero
 /src/dio-interleaved
 /src/dio-invalidate-cache
diff --git a/src/Makefile b/src/Makefile
index 3d729a34..99019e6e 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -29,7 +29,8 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
 	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
-	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail
+	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
+	detached_mounts_propagation
 
 SUBDIRS = log-writes perf
 
diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
new file mode 100644
index 00000000..4a588e46
--- /dev/null
+++ b/src/detached_mounts_propagation.c
@@ -0,0 +1,252 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ * Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
+ * All Rights Reserved.
+ *
+ * Regression test to verify that creating a series of detached mounts,
+ * attaching them to the filesystem, and unmounting them does not trigger an
+ * integer overflow in ns->mounts causing the kernel to block any new mounts in
+ * count_mounts() and returning ENOSPC because it falsely assumes that the
+ * maximum number of mounts in the mount namespace has been reached, i.e. it
+ * thinks it can't fit the new mounts into the mount namespace anymore.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+/* open_tree() */
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE 1
+#endif
+
+#ifndef OPEN_TREE_CLOEXEC
+#define OPEN_TREE_CLOEXEC O_CLOEXEC
+#endif
+
+#ifndef __NR_open_tree
+	#if defined __alpha__
+		#define __NR_open_tree 538
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_open_tree 4428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_open_tree 6428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_open_tree 5428
+		#endif
+	#elif defined __ia64__
+		#define __NR_open_tree (428 + 1024)
+	#else
+		#define __NR_open_tree 428
+	#endif
+#endif
+
+/* move_mount() */
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
+#endif
+
+#ifndef __NR_move_mount
+	#if defined __alpha__
+		#define __NR_move_mount 539
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_move_mount 4429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_move_mount 6429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_move_mount 5429
+		#endif
+	#elif defined __ia64__
+		#define __NR_move_mount (428 + 1024)
+	#else
+		#define __NR_move_mount 429
+	#endif
+#endif
+
+static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
+{
+	return syscall(__NR_open_tree, dfd, filename, flags);
+}
+
+static inline int sys_move_mount(int from_dfd, const char *from_pathname, int to_dfd,
+				 const char *to_pathname, unsigned int flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
+}
+
+static bool is_shared_mountpoint(const char *path)
+{
+	bool shared = false;
+	FILE *f = NULL;
+	char *line = NULL;
+	int i;
+	size_t len = 0;
+
+	f = fopen("/proc/self/mountinfo", "re");
+	if (!f)
+		return 0;
+
+	while (getline(&line, &len, f) > 0) {
+		char *slider1, *slider2;
+
+		for (slider1 = line, i = 0; slider1 && i < 4; i++)
+			slider1 = strchr(slider1 + 1, ' ');
+
+		if (!slider1)
+			continue;
+
+		slider2 = strchr(slider1 + 1, ' ');
+		if (!slider2)
+			continue;
+
+		*slider2 = '\0';
+		if (strcmp(slider1 + 1, path) == 0) {
+			/* This is the path. Is it shared? */
+			slider1 = strchr(slider2 + 1, ' ');
+			if (slider1 && strstr(slider1, "shared:")) {
+				shared = true;
+				break;
+			}
+		}
+	}
+	fclose(f);
+	free(line);
+
+	return shared;
+}
+
+static void usage(void)
+{
+	const char *text = "mount-new [--recursive] <base-dir>\n";
+	fprintf(stderr, "%s", text);
+	_exit(EXIT_SUCCESS);
+}
+
+#define exit_usage(format, ...)                              \
+	({                                                   \
+		fprintf(stderr, format "\n", ##__VA_ARGS__); \
+		usage();                                     \
+	})
+
+#define exit_log(format, ...)                                \
+	({                                                   \
+		fprintf(stderr, format "\n", ##__VA_ARGS__); \
+		exit(EXIT_FAILURE);                          \
+	})
+
+static const struct option longopts[] = {
+	{"help",	no_argument,		0,	'a'},
+	{ NULL,		no_argument,		0,	 0 },
+};
+
+int main(int argc, char *argv[])
+{
+	int exit_code = EXIT_SUCCESS, index = 0;
+	int dfd, fd_tree, new_argc, ret;
+	char *base_dir;
+	char *const *new_argv;
+	char target[PATH_MAX];
+
+	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
+		switch (ret) {
+		case 'a':
+			/* fallthrough */
+		default:
+			usage();
+		}
+	}
+
+	new_argv = &argv[optind];
+	new_argc = argc - optind;
+	if (new_argc < 1)
+		exit_usage("Missing base directory\n");
+	base_dir = new_argv[0];
+
+	if (*base_dir != '/')
+		exit_log("Please specify an absolute path");
+
+	/* Ensure that target is a shared mountpoint. */
+	if (!is_shared_mountpoint(base_dir))
+		exit_log("Please ensure that \"%s\" is a shared mountpoint", base_dir);
+
+	ret = unshare(CLONE_NEWNS);
+	if (ret < 0)
+		exit_log("%m - Failed to create new mount namespace");
+
+	ret = mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
+	if (ret < 0)
+		exit_log("%m - Failed to make base_dir shared mountpoint");
+
+	dfd = open(base_dir, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	if (dfd < 0)
+		exit_log("%m - Failed to open base directory \"%s\"", base_dir);
+
+	ret = mkdirat(dfd, "detached-move-mount", 0755);
+	if (ret < 0)
+		exit_log("%m - Failed to create required temporary directories");
+
+	ret = snprintf(target, sizeof(target), "%s/detached-move-mount", base_dir);
+	if (ret < 0 || (size_t)ret >= sizeof(target))
+		exit_log("%m - Failed to assemble target path");
+
+	/*
+	 * Having a mount table with 10000 mounts is already quite excessive
+	 * and shoult account even for weird test systems.
+	 */
+	for (size_t i = 0; i < 10000; i++) {
+		fd_tree = sys_open_tree(dfd, "detached-move-mount",
+					OPEN_TREE_CLONE |
+					OPEN_TREE_CLOEXEC |
+					AT_EMPTY_PATH);
+		if (fd_tree < 0) {
+			if (errno == ENOSYS) /* New mount API not (fully) supported. */
+				break;
+
+			fprintf(stderr, "%m - Failed to open %d(detached-move-mount)", dfd);
+			exit_code = EXIT_FAILURE;
+			break;
+		}
+
+		ret = sys_move_mount(fd_tree, "", dfd, "detached-move-mount", MOVE_MOUNT_F_EMPTY_PATH);
+		if (ret < 0) {
+			if (errno == ENOSPC)
+				fprintf(stderr, "%m - Buggy mount counting");
+			else if (errno == ENOSYS) /* New mount API not (fully) supported. */
+				break;
+			else
+				fprintf(stderr, "%m - Failed to attach mount to %d(detached-move-mount)", dfd);
+			exit_code = EXIT_FAILURE;
+			break;
+		}
+		close(fd_tree);
+
+		ret = umount2(target, MNT_DETACH);
+		if (ret < 0) {
+			fprintf(stderr, "%m - Failed to unmount %s", target);
+			exit_code = EXIT_FAILURE;
+			break;
+		}
+	}
+
+	(void)unlinkat(dfd, "detached-move-mount", AT_REMOVEDIR);
+	close(dfd);
+
+	exit(exit_code);
+}
diff --git a/tests/generic/631 b/tests/generic/631
new file mode 100644
index 00000000..0b6cac42
--- /dev/null
+++ b/tests/generic/631
@@ -0,0 +1,43 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
+# All Rights Reserved.
+#
+# FS QA Test No. 631
+#
+# Regression test to verify that creating a series of detached mounts,
+# attaching them to the filesystem, and unmounting them does not trigger an
+# integer overflow in ns->mounts causing the kernel to block any new mounts in
+# count_mounts() and returning ENOSPC because it falsely assumes that the
+# maximum number of mounts in the mount namespace has been reached, i.e. it
+# thinks it can't fit the new mounts into the mount namespace anymore.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+. ./common/rc
+
+rm -f $seqres.full
+
+_supported_fs generic
+_require_test
+_require_test_program "detached_mounts_propagation"
+
+$here/src/detached_mounts_propagation $TEST_DIR >> $seqres.full
+status=$?
+
+echo silence is golden
+exit
diff --git a/tests/generic/631.out b/tests/generic/631.out
new file mode 100644
index 00000000..ce88f447
--- /dev/null
+++ b/tests/generic/631.out
@@ -0,0 +1,2 @@
+QA output created by 631
+silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 7c7531d1..151f8af2 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -633,3 +633,4 @@
 628 auto quick rw clone
 629 auto quick rw copy_range
 630 auto quick rw dedupe clone
+631 auto quick mount
-- 
2.27.0

