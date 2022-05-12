Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EB3C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356478AbiELQxn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356712AbiELQxl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CDD26866F
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5D6DB82948
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F40AC34116;
        Thu, 12 May 2022 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374417;
        bh=Mze69ipYEOQWtnBlQV6oHtcWeLJR2o36iHokMZ8AsFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usmQcmG6Xm+9WUgVhuQI30p0EVE8cA5vhe7+i+tbbZybt6EN9fOdNIH7jqV1FVCIi
         9r3FvDcgK5+JjGPQznpajo9OZaFzDjcUl+IDRWlEHsC9xPMgvNjJQjEWvQPZM7cgHc
         Zvsr0/q2vx3z4rhI2iJLzQEgyLIOfq/A4/THI458MEEiWYIDOWbN6lNOL4irpnZarI
         eNX189Yyl7THkAGm/8Kiixrr2ycTKgO0ayGlCTWVUhsFqtc51bDzyjxH9WFu+Lv7XG
         ZYkL6OJxfDuNDf04+rKK2Q8gr7DwSQ0vL4FRDTRKyPJ6nw4rCVSDrBU5+oek6Rqe28
         nA3pTh8GF7MaQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 13/13] vfs/idmapped-mounts: remove invalid test
Date:   Thu, 12 May 2022 18:52:50 +0200
Message-Id: <20220512165250.450989-14-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8727; h=from:subject; bh=Mze69ipYEOQWtnBlQV6oHtcWeLJR2o36iHokMZ8AsFw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWnvbNWVfvvs+vkXpZL3OqxDv/ltiq8qnrrkbdFBcsuT+ 1YSFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABe5yfC/LO3obt578ocqsw4edw6I5z od9WSRN2+U/Pqiub+fneE4wsiwdVMkI3NNttP0/qBp61fZNF/cvl55q5e7puKmEM2z17P4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The threaded mount interaction test validates that the idmapping of a
mount behaves correctly when changed while another process already has a
writable file descriptor to that mount. In newer kernels it isn't
possible to change a mount's idmapped if someone has a writable file
descriptor to that mount.

Link: e1bbcd277a53 ("fs: hold writers when changing mount's idmapping")
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/idmapped-mounts.c | 241 --------------------------------------
 src/vfs/vfstest.c         |   1 -
 2 files changed, 242 deletions(-)

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index d3763c2d..63297d5f 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -6438,246 +6438,6 @@ out:
 	return fret;
 }
 
-#define PTR_TO_INT(p) ((int)((intptr_t)(p)))
-#define INT_TO_PTR(u) ((void *)((intptr_t)(u)))
-
-struct threaded_args {
-	const struct vfstest_info *info;
-	int open_tree_fd;
-};
-
-static void *idmapped_mount_create_cb(void *data)
-{
-	int fret = EXIT_FAILURE;
-	struct mount_attr attr = {
-		.attr_set = MOUNT_ATTR_IDMAP,
-	};
-	struct threaded_args *args = data;
-
-	/* Changing mount properties on a detached mount. */
-	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
-	if (attr.userns_fd < 0) {
-		log_stderr("failure: get_userns_fd");
-		goto out;
-	}
-
-	if (sys_mount_setattr(args->open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
-		log_stderr("failure: sys_mount_setattr");
-		goto out;
-	}
-
-	fret = EXIT_SUCCESS;
-
-out:
-	safe_close(attr.userns_fd);
-	pthread_exit(INT_TO_PTR(fret));
-}
-
-/* This tries to verify that we never see an inconistent ownership on-disk and
- * can't write invalid ids to disk. To do this we create a race between
- * idmapping a mount and creating files on it.
- * Note, while it is perfectly fine to see overflowuid and overflowgid as owner
- * if we create files through the open_tree_fd before the mount is idmapped but
- * look at the files after the mount has been idmapped in this test it can never
- * be the case that we see overflowuid and overflowgid when we access the file
- * through a non-idmapped mount (in the initial user namespace).
- */
-static void *idmapped_mount_operations_cb(void *data)
-{
-	int file1_fd = -EBADF, file2_fd = -EBADF, dir1_fd = -EBADF,
-	    dir1_fd2 = -EBADF, fret = EXIT_FAILURE;
-	struct threaded_args *args = data;
-	const struct vfstest_info *info = args->info;
-
-	if (!switch_fsids(10000, 10000)) {
-		log_stderr("failure: switch fsids");
-		goto out;
-	}
-
-	file1_fd = openat(args->open_tree_fd, FILE1,
-			  O_CREAT | O_EXCL | O_CLOEXEC, 0644);
-	if (file1_fd < 0) {
-		log_stderr("failure: openat");
-		goto out;
-	}
-
-	file2_fd = openat(args->open_tree_fd, FILE2,
-			  O_CREAT | O_EXCL | O_CLOEXEC, 0644);
-	if (file2_fd < 0) {
-		log_stderr("failure: openat");
-		goto out;
-	}
-
-	if (mkdirat(args->open_tree_fd, DIR1, 0777)) {
-		log_stderr("failure: mkdirat");
-		goto out;
-	}
-
-	dir1_fd = openat(args->open_tree_fd, DIR1,
-			 O_RDONLY | O_DIRECTORY | O_CLOEXEC);
-	if (dir1_fd < 0) {
-		log_stderr("failure: openat");
-		goto out;
-	}
-
-	if (!__expected_uid_gid(args->open_tree_fd, FILE1, 0, 0, 0, false) &&
-	    !__expected_uid_gid(args->open_tree_fd, FILE1, 0, 10000, 10000, false) &&
-	    !__expected_uid_gid(args->open_tree_fd, FILE1, 0, info->t_overflowuid, info->t_overflowgid, false)) {
-		log_stderr("failure: expected_uid_gid");
-		goto out;
-	}
-
-	if (!__expected_uid_gid(args->open_tree_fd, FILE2, 0, 0, 0, false) &&
-	    !__expected_uid_gid(args->open_tree_fd, FILE2, 0, 10000, 10000, false) &&
-	    !__expected_uid_gid(args->open_tree_fd, FILE2, 0, info->t_overflowuid, info->t_overflowgid, false)) {
-		log_stderr("failure: expected_uid_gid");
-		goto out;
-	}
-
-	if (!__expected_uid_gid(args->open_tree_fd, DIR1, 0, 0, 0, false) &&
-	    !__expected_uid_gid(args->open_tree_fd, DIR1, 0, 10000, 10000, false) &&
-	    !__expected_uid_gid(args->open_tree_fd, DIR1, 0, info->t_overflowuid, info->t_overflowgid, false)) {
-		log_stderr("failure: expected_uid_gid");
-		goto out;
-	}
-
-	if (!__expected_uid_gid(dir1_fd, "", AT_EMPTY_PATH, 0, 0, false) &&
-	    !__expected_uid_gid(dir1_fd, "", AT_EMPTY_PATH, 10000, 10000, false) &&
-	    !__expected_uid_gid(dir1_fd, "", AT_EMPTY_PATH, info->t_overflowuid, info->t_overflowgid, false)) {
-		log_stderr("failure: expected_uid_gid");
-		goto out;
-	}
-
-	dir1_fd2 = openat(info->t_dir1_fd, DIR1,
-			 O_RDONLY | O_DIRECTORY | O_CLOEXEC);
-	if (dir1_fd2 < 0) {
-		log_stderr("failure: openat");
-		goto out;
-	}
-
-        if (!__expected_uid_gid(info->t_dir1_fd, FILE1, 0, 0, 0, false) &&
-	    !__expected_uid_gid(info->t_dir1_fd, FILE1, 0, 10000, 10000, false)) {
-		log_stderr("failure: expected_uid_gid");
-		goto out;
-	}
-
-	if (!__expected_uid_gid(info->t_dir1_fd, FILE2, 0, 0, 0, false) &&
-	    !__expected_uid_gid(info->t_dir1_fd, FILE2, 0, 10000, 10000, false)) {
-		log_stderr("failure: expected_uid_gid");
-		goto out;
-	}
-
-	if (!__expected_uid_gid(info->t_dir1_fd, DIR1, 0, 0, 0, false) &&
-	    !__expected_uid_gid(info->t_dir1_fd, DIR1, 0, 10000, 10000, false)) {
-		log_stderr("failure: expected_uid_gid");
-		goto out;
-	}
-
-	if (!__expected_uid_gid(info->t_dir1_fd, DIR1, 0, 0, 0, false) &&
-	    !__expected_uid_gid(info->t_dir1_fd, DIR1, 0, 10000, 10000, false)) {
-		log_stderr("failure: expected_uid_gid");
-		goto out;
-	}
-
-	if (!__expected_uid_gid(dir1_fd2, "", AT_EMPTY_PATH, 0, 0, false) &&
-	    !__expected_uid_gid(dir1_fd2, "", AT_EMPTY_PATH, 10000, 10000, false)) {
-		log_stderr("failure: expected_uid_gid");
-		goto out;
-	}
-
-	fret = EXIT_SUCCESS;
-
-out:
-	safe_close(file1_fd);
-	safe_close(file2_fd);
-	safe_close(dir1_fd);
-	safe_close(dir1_fd2);
-
-	pthread_exit(INT_TO_PTR(fret));
-}
-
-static int threaded_idmapped_mount_interactions(const struct vfstest_info *info)
-{
-	int i;
-	int fret = -1;
-	pid_t pid;
-	pthread_attr_t thread_attr;
-	pthread_t threads[2];
-
-	pthread_attr_init(&thread_attr);
-
-	for (i = 0; i < 1000; i++) {
-		int ret1 = 0, ret2 = 0, tret1 = 0, tret2 = 0;
-
-		pid = fork();
-		if (pid < 0) {
-			log_stderr("failure: fork");
-			goto out;
-		}
-		if (pid == 0) {
-			int open_tree_fd = -EBADF;
-			struct threaded_args args = {
-				.info = info,
-				.open_tree_fd = -EBADF,
-			};
-
-			open_tree_fd = sys_open_tree(info->t_dir1_fd, "",
-						     AT_EMPTY_PATH |
-						     AT_NO_AUTOMOUNT |
-						     AT_SYMLINK_NOFOLLOW |
-						     OPEN_TREE_CLOEXEC |
-						     OPEN_TREE_CLONE);
-			if (open_tree_fd < 0)
-				die("failure: sys_open_tree");
-
-			args.open_tree_fd = open_tree_fd;
-
-			if (pthread_create(&threads[0], &thread_attr,
-					   idmapped_mount_create_cb,
-					   &args))
-				die("failure: pthread_create");
-
-			if (pthread_create(&threads[1], &thread_attr,
-					   idmapped_mount_operations_cb,
-					   &args))
-				die("failure: pthread_create");
-
-			ret1 = pthread_join(threads[0], INT_TO_PTR(tret1));
-			ret2 = pthread_join(threads[1], INT_TO_PTR(tret2));
-
-			if (ret1) {
-				errno = ret1;
-				die("failure: pthread_join");
-			}
-
-			if (ret2) {
-				errno = ret2;
-				die("failure: pthread_join");
-			}
-
-			if (tret1 || tret2)
-				exit(EXIT_FAILURE);
-
-			exit(EXIT_SUCCESS);
-
-		}
-
-		if (wait_for_pid(pid)) {
-			log_stderr("failure: iteration %d", i);
-			goto out;
-		}
-
-		rm_r(info->t_dir1_fd, ".");
-
-	}
-
-	fret = 0;
-	log_debug("Ran test");
-
-out:
-	return fret;
-}
-
 static int nested_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
@@ -7941,7 +7701,6 @@ static const struct test_struct t_idmapped_mounts[] = {
 	{ sticky_bit_rename_idmapped_mounts_in_userns,			true,	"sticky bit rename operations on idmapped mounts in user namespace",				},
 	{ symlink_idmapped_mounts,					true,	"symlink from idmapped mounts",									},
 	{ symlink_idmapped_mounts_in_userns,				true,	"symlink from idmapped mounts in user namespace",						},
-	{ threaded_idmapped_mount_interactions,				true,	"threaded operations on idmapped mounts",							},
 };
 
 const struct test_suite s_idmapped_mounts = {
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index 67aa3bda..29ac0bec 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -13,7 +13,6 @@
 #include <limits.h>
 #include <linux/limits.h>
 #include <linux/types.h>
-#include <pthread.h>
 #include <pwd.h>
 #include <sched.h>
 #include <stdbool.h>
-- 
2.34.1

