Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD04AC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Apr 2022 15:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbiD1PU2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349021AbiD1PUU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2022 11:20:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78FB3DF1
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 08:16:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA9E7B82D65
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 15:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE05C385B1;
        Thu, 28 Apr 2022 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651159014;
        bh=qDYOQNXH2eDUFA6HK2CmMTwprii3ixkmCuLdnYQ7C5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVb4rujTZv42LsrpczeGyPh5prTuBt54WQQ3MQYSHfTKtfA/Yl3togE1HirWHmZ9J
         G//DlqJP4eN1wilcvVNeLAVUj3pKr2/XII1LF2j6I/lXS9R6Np9liwhfOSfOGl13v4
         wNnOupvMVDNt0kqB+YaJYr5qkzgklXTP1mFfuxzTpkPF/Wof68k4xjPgunwQk9BLRy
         dHn2t8t1lN4d2WGcqXKxgJdVLmG59db2Y94HRHFRZPaC15fCjnysDuaIqCkZWcV2+e
         SnNY6hDGSxICnGuCzbKk5nuItiobrU0HWAQzNwHHT0y0zV+tX344292FOaSXtXv06y
         t6z5qwI1/dOZw==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 11/11] vfstest: split out remaining idmapped mount tests
Date:   Thu, 28 Apr 2022 17:15:59 +0200
Message-Id: <20220428151559.947144-12-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220428151559.947144-1-brauner@kernel.org>
References: <20220428151559.947144-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=80986; h=from:subject; bh=qDYOQNXH2eDUFA6HK2CmMTwprii3ixkmCuLdnYQ7C5U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRlrV+qW3BH/f0BtSWMJlYiV4PtTmU+V/QojbscfPLT+x/e J/7e7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIujjDP7vQGyp6f7s/nX4obOXk7H z4wOGAB2/5LnpWdV3g5tyTu4uR4f7i8JPq/vfMt1xpvhcZVqYaP7Gz9bofvzjTQfOXSq66nAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Split out all the remaining idmapped mount tests into the idmapped
mounts source file.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/idmapped-mounts.c | 1123 +++++++++++++++++++++++++++++++++
 src/vfs/idmapped-mounts.h |    2 +
 src/vfs/utils.c           |  130 ++++
 src/vfs/utils.h           |    5 +
 src/vfs/vfstest.c         | 1260 +------------------------------------
 5 files changed, 1261 insertions(+), 1259 deletions(-)

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index d935e4c8..8c9b03da 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -6470,6 +6470,1110 @@ out:
 	return fret;
 }
 
+static int nested_userns(const struct vfstest_info *info)
+{
+	int fret = -1;
+	int ret;
+	pid_t pid;
+	unsigned int id;
+	struct list *it, *next;
+	struct userns_hierarchy hierarchy[] = {
+		{ .level = 1, .fd_userns = -EBADF, },
+		{ .level = 2, .fd_userns = -EBADF, },
+		{ .level = 3, .fd_userns = -EBADF, },
+		{ .level = 4, .fd_userns = -EBADF, },
+		/* Dummy entry that marks the end. */
+		{ .level = MAX_USERNS_LEVEL, .fd_userns = -EBADF, },
+	};
+	struct mount_attr attr_level1 = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= -EBADF,
+	};
+	struct mount_attr attr_level2 = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= -EBADF,
+	};
+	struct mount_attr attr_level3 = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= -EBADF,
+	};
+	struct mount_attr attr_level4 = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= -EBADF,
+	};
+	int fd_dir1 = -EBADF,
+	    fd_open_tree_level1 = -EBADF,
+	    fd_open_tree_level2 = -EBADF,
+	    fd_open_tree_level3 = -EBADF,
+	    fd_open_tree_level4 = -EBADF;
+	const unsigned int id_file_range = 10000;
+
+	list_init(&hierarchy[0].id_map);
+	list_init(&hierarchy[1].id_map);
+	list_init(&hierarchy[2].id_map);
+	list_init(&hierarchy[3].id_map);
+
+	/*
+	 * Give a large map to the outermost user namespace so we can create
+	 * comfortable nested maps.
+	 */
+	ret = add_map_entry(&hierarchy[0].id_map, 1000000, 0, 1000000000, ID_TYPE_UID);
+	if (ret) {
+		log_stderr("failure: adding uidmap for userns at level 1");
+		goto out;
+	}
+
+	ret = add_map_entry(&hierarchy[0].id_map, 1000000, 0, 1000000000, ID_TYPE_GID);
+	if (ret) {
+		log_stderr("failure: adding gidmap for userns at level 1");
+		goto out;
+	}
+
+	/* This is uid:0->2000000:100000000 in init userns. */
+	ret = add_map_entry(&hierarchy[1].id_map, 1000000, 0, 100000000, ID_TYPE_UID);
+	if (ret) {
+		log_stderr("failure: adding uidmap for userns at level 2");
+		goto out;
+	}
+
+	/* This is gid:0->2000000:100000000 in init userns. */
+	ret = add_map_entry(&hierarchy[1].id_map, 1000000, 0, 100000000, ID_TYPE_GID);
+	if (ret) {
+		log_stderr("failure: adding gidmap for userns at level 2");
+		goto out;
+	}
+
+	/* This is uid:0->3000000:999 in init userns. */
+	ret = add_map_entry(&hierarchy[2].id_map, 1000000, 0, 999, ID_TYPE_UID);
+	if (ret) {
+		log_stderr("failure: adding uidmap for userns at level 3");
+		goto out;
+	}
+
+	/* This is gid:0->3000000:999 in the init userns. */
+	ret = add_map_entry(&hierarchy[2].id_map, 1000000, 0, 999, ID_TYPE_GID);
+	if (ret) {
+		log_stderr("failure: adding gidmap for userns at level 3");
+		goto out;
+	}
+
+	/* id 999 will remain unmapped. */
+
+	/* This is uid:1000->2001000:1 in init userns. */
+	ret = add_map_entry(&hierarchy[2].id_map, 1000, 1000, 1, ID_TYPE_UID);
+	if (ret) {
+		log_stderr("failure: adding uidmap for userns at level 3");
+		goto out;
+	}
+
+	/* This is gid:1000->2001000:1 in init userns. */
+	ret = add_map_entry(&hierarchy[2].id_map, 1000, 1000, 1, ID_TYPE_GID);
+	if (ret) {
+		log_stderr("failure: adding gidmap for userns at level 3");
+		goto out;
+	}
+
+	/* This is uid:1001->3001001:10000 in init userns. */
+	ret = add_map_entry(&hierarchy[2].id_map, 1001001, 1001, 10000000, ID_TYPE_UID);
+	if (ret) {
+		log_stderr("failure: adding uidmap for userns at level 3");
+		goto out;
+	}
+
+	/* This is gid:1001->3001001:10000 in init userns. */
+	ret = add_map_entry(&hierarchy[2].id_map, 1001001, 1001, 10000000, ID_TYPE_GID);
+	if (ret) {
+		log_stderr("failure: adding gidmap for userns at level 3");
+		goto out;
+	}
+
+	/* Don't write a mapping in the 4th userns. */
+	list_empty(&hierarchy[4].id_map);
+
+	/* Create the actual userns hierarchy. */
+	ret = create_userns_hierarchy(hierarchy);
+	if (ret) {
+		log_stderr("failure: create userns hierarchy");
+		goto out;
+	}
+
+	attr_level1.userns_fd = hierarchy[0].fd_userns;
+	attr_level2.userns_fd = hierarchy[1].fd_userns;
+	attr_level3.userns_fd = hierarchy[2].fd_userns;
+	attr_level4.userns_fd = hierarchy[3].fd_userns;
+
+	/*
+	 * Create one directory where we create files for each uid/gid within
+	 * the first userns.
+	 */
+	if (mkdirat(info->t_dir1_fd, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	fd_dir1 = openat(info->t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (fd_dir1 < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	for (id = 0; id <= id_file_range; id++) {
+		char file[256];
+
+		snprintf(file, sizeof(file), DIR1 "/" FILE1 "_%u", id);
+
+		if (mknodat(info->t_dir1_fd, file, S_IFREG | 0644, 0)) {
+			log_stderr("failure: create %s", file);
+			goto out;
+		}
+
+		if (fchownat(info->t_dir1_fd, file, id, id, AT_SYMLINK_NOFOLLOW)) {
+			log_stderr("failure: fchownat %s", file);
+			goto out;
+		}
+
+		if (!expected_uid_gid(info->t_dir1_fd, file, 0, id, id)) {
+			log_stderr("failure: check ownership %s", file);
+			goto out;
+		}
+	}
+
+	/* Create detached mounts for all the user namespaces. */
+	fd_open_tree_level1 = sys_open_tree(info->t_dir1_fd, DIR1,
+					    AT_NO_AUTOMOUNT |
+					    AT_SYMLINK_NOFOLLOW |
+					    OPEN_TREE_CLOEXEC |
+					    OPEN_TREE_CLONE);
+	if (fd_open_tree_level1 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	fd_open_tree_level2 = sys_open_tree(info->t_dir1_fd, DIR1,
+					    AT_NO_AUTOMOUNT |
+					    AT_SYMLINK_NOFOLLOW |
+					    OPEN_TREE_CLOEXEC |
+					    OPEN_TREE_CLONE);
+	if (fd_open_tree_level2 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	fd_open_tree_level3 = sys_open_tree(info->t_dir1_fd, DIR1,
+					    AT_NO_AUTOMOUNT |
+					    AT_SYMLINK_NOFOLLOW |
+					    OPEN_TREE_CLOEXEC |
+					    OPEN_TREE_CLONE);
+	if (fd_open_tree_level3 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	fd_open_tree_level4 = sys_open_tree(info->t_dir1_fd, DIR1,
+					    AT_NO_AUTOMOUNT |
+					    AT_SYMLINK_NOFOLLOW |
+					    OPEN_TREE_CLOEXEC |
+					    OPEN_TREE_CLONE);
+	if (fd_open_tree_level4 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	/* Turn detached mounts into detached idmapped mounts. */
+	if (sys_mount_setattr(fd_open_tree_level1, "", AT_EMPTY_PATH,
+			      &attr_level1, sizeof(attr_level1))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	if (sys_mount_setattr(fd_open_tree_level2, "", AT_EMPTY_PATH,
+			      &attr_level2, sizeof(attr_level2))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	if (sys_mount_setattr(fd_open_tree_level3, "", AT_EMPTY_PATH,
+			      &attr_level3, sizeof(attr_level3))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	if (sys_mount_setattr(fd_open_tree_level4, "", AT_EMPTY_PATH,
+			      &attr_level4, sizeof(attr_level4))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	/* Verify that ownership looks correct for callers in the init userns. */
+	for (id = 0; id <= id_file_range; id++) {
+		bool bret;
+		unsigned int id_level1, id_level2, id_level3;
+		char file[256];
+
+		snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+		id_level1 = id + 1000000;
+		if (!expected_uid_gid(fd_open_tree_level1, file, 0, id_level1, id_level1)) {
+			log_stderr("failure: check ownership %s", file);
+			goto out;
+		}
+
+		id_level2 = id + 2000000;
+		if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2)) {
+			log_stderr("failure: check ownership %s", file);
+			goto out;
+		}
+
+		if (id == 999) {
+			/* This id is unmapped. */
+			bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
+		} else if (id == 1000) {
+			id_level3 = id + 2000000; /* We punched a hole in the map at 1000. */
+			bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+		} else {
+			id_level3 = id + 3000000; /* Rest is business as usual. */
+			bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+		}
+		if (!bret) {
+			log_stderr("failure: check ownership %s", file);
+			goto out;
+		}
+
+		if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid)) {
+			log_stderr("failure: check ownership %s", file);
+			goto out;
+		}
+	}
+
+	/* Verify that ownership looks correct for callers in the first userns. */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr_level1.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		for (id = 0; id <= id_file_range; id++) {
+			bool bret;
+			unsigned int id_level1, id_level2, id_level3;
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			id_level1 = id;
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, id_level1, id_level1))
+				die("failure: check ownership %s", file);
+
+			id_level2 = id + 1000000;
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
+				die("failure: check ownership %s", file);
+
+			if (id == 999) {
+				/* This id is unmapped. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
+			} else if (id == 1000) {
+				id_level3 = id + 1000000; /* We punched a hole in the map at 1000. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			} else {
+				id_level3 = id + 2000000; /* Rest is business as usual. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			}
+			if (!bret)
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* Verify that ownership looks correct for callers in the second userns. */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr_level2.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		for (id = 0; id <= id_file_range; id++) {
+			bool bret;
+			unsigned int id_level2, id_level3;
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			id_level2 = id;
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
+				die("failure: check ownership %s", file);
+
+			if (id == 999) {
+				/* This id is unmapped. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
+			} else if (id == 1000) {
+				id_level3 = id; /* We punched a hole in the map at 1000. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			} else {
+				id_level3 = id + 1000000; /* Rest is business as usual. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			}
+			if (!bret)
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* Verify that ownership looks correct for callers in the third userns. */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr_level3.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		for (id = 0; id <= id_file_range; id++) {
+			bool bret;
+			unsigned int id_level2, id_level3;
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (id == 1000) {
+				/*
+				 * The idmapping of the third userns has a hole
+				 * at uid/gid 1000. That means:
+				 * - 1000->userns_0(2000000) // init userns
+				 * - 1000->userns_1(2000000) // level 1
+				 * - 1000->userns_2(1000000) // level 2
+				 * - 1000->userns_3(1000)    // level 3 (because level 3 has a hole)
+				 */
+				id_level2 = id;
+				bret = expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2);
+			} else {
+				bret = expected_uid_gid(fd_open_tree_level2, file, 0, info->t_overflowuid, info->t_overflowgid);
+			}
+			if (!bret)
+				die("failure: check ownership %s", file);
+
+
+			if (id == 999) {
+				/* This id is unmapped. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
+			} else {
+				id_level3 = id; /* Rest is business as usual. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			}
+			if (!bret)
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* Verify that ownership looks correct for callers in the fourth userns. */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (setns(attr_level4.userns_fd, CLONE_NEWUSER))
+			die("failure: switch_userns");
+
+		for (id = 0; id <= id_file_range; id++) {
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* Verify that chown works correctly for callers in the first userns. */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr_level1.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		for (id = 0; id <= id_file_range; id++) {
+			bool bret;
+			unsigned int id_level1, id_level2, id_level3, id_new;
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			id_new = id + 1;
+			if (fchownat(fd_open_tree_level1, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
+				die("failure: fchownat %s", file);
+
+			id_level1 = id_new;
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, id_level1, id_level1))
+				die("failure: check ownership %s", file);
+
+			id_level2 = id_new + 1000000;
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
+				die("failure: check ownership %s", file);
+
+			if (id_new == 999) {
+				/* This id is unmapped. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
+			} else if (id_new == 1000) {
+				id_level3 = id_new + 1000000; /* We punched a hole in the map at 1000. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			} else {
+				id_level3 = id_new + 2000000; /* Rest is business as usual. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			}
+			if (!bret)
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			/* Revert ownership. */
+			if (fchownat(fd_open_tree_level1, file, id, id, AT_SYMLINK_NOFOLLOW))
+				die("failure: fchownat %s", file);
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* Verify that chown works correctly for callers in the second userns. */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr_level2.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		for (id = 0; id <= id_file_range; id++) {
+			bool bret;
+			unsigned int id_level2, id_level3, id_new;
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			id_new = id + 1;
+			if (fchownat(fd_open_tree_level2, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
+				die("failure: fchownat %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			id_level2 = id_new;
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
+				die("failure: check ownership %s", file);
+
+			if (id_new == 999) {
+				/* This id is unmapped. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
+			} else if (id_new == 1000) {
+				id_level3 = id_new; /* We punched a hole in the map at 1000. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			} else {
+				id_level3 = id_new + 1000000; /* Rest is business as usual. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			}
+			if (!bret)
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			/* Revert ownership. */
+			if (fchownat(fd_open_tree_level2, file, id, id, AT_SYMLINK_NOFOLLOW))
+				die("failure: fchownat %s", file);
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* Verify that chown works correctly for callers in the third userns. */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (!switch_userns(attr_level3.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		for (id = 0; id <= id_file_range; id++) {
+			unsigned int id_new;
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			id_new = id + 1;
+			if (id_new == 999 || id_new == 1000) {
+				/*
+				 * We can't change ownership as we can't
+				 * chown from or to an unmapped id.
+				 */
+				if (!fchownat(fd_open_tree_level3, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
+					die("failure: fchownat %s", file);
+			} else {
+				if (fchownat(fd_open_tree_level3, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
+					die("failure: fchownat %s", file);
+			}
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			/* There's no id 1000 anymore as we changed ownership for id 1000 to 1001 above. */
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (id_new == 999) {
+				/*
+				 * We did not change ownership as we can't
+				 * chown to an unmapped id.
+				 */
+				if (!expected_uid_gid(fd_open_tree_level3, file, 0, id, id))
+					die("failure: check ownership %s", file);
+			} else if (id_new == 1000) {
+				/*
+				 * We did not change ownership as we can't
+				 * chown from an unmapped id.
+				 */
+				if (!expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid))
+					die("failure: check ownership %s", file);
+			} else {
+				if (!expected_uid_gid(fd_open_tree_level3, file, 0, id_new, id_new))
+					die("failure: check ownership %s", file);
+			}
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			/* Revert ownership. */
+			if (id_new != 999 && id_new != 1000) {
+				if (fchownat(fd_open_tree_level3, file, id, id, AT_SYMLINK_NOFOLLOW))
+					die("failure: fchownat %s", file);
+			}
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	/* Verify that chown works correctly for callers in the fourth userns. */
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		if (setns(attr_level4.userns_fd, CLONE_NEWUSER))
+			die("failure: switch_userns");
+
+		for (id = 0; id <= id_file_range; id++) {
+			char file[256];
+			unsigned long id_new;
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			id_new = id + 1;
+			if (!fchownat(fd_open_tree_level4, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
+				die("failure: fchownat %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
+				die("failure: check ownership %s", file);
+
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+
+out:
+	list_for_each_safe(it, &hierarchy[0].id_map, next) {
+		list_del(it);
+		free(it->elem);
+		free(it);
+	}
+
+	list_for_each_safe(it, &hierarchy[1].id_map, next) {
+		list_del(it);
+		free(it->elem);
+		free(it);
+	}
+
+	list_for_each_safe(it, &hierarchy[2].id_map, next) {
+		list_del(it);
+		free(it->elem);
+		free(it);
+	}
+
+	safe_close(hierarchy[0].fd_userns);
+	safe_close(hierarchy[1].fd_userns);
+	safe_close(hierarchy[2].fd_userns);
+	safe_close(fd_dir1);
+	safe_close(fd_open_tree_level1);
+	safe_close(fd_open_tree_level2);
+	safe_close(fd_open_tree_level3);
+	safe_close(fd_open_tree_level4);
+	return fret;
+}
+
+#define USER1 "fsgqa"
+#define USER2 "fsgqa2"
+
+/**
+ * lookup_ids - lookup uid and gid for a username
+ * @name: [in]  name of the user
+ * @uid:  [out] pointer to the user-ID
+ * @gid:  [out] pointer to the group-ID
+ *
+ * Lookup the uid and gid of a user.
+ *
+ * Return: On success, true is returned.
+ *         On error, false is returned.
+ */
+static bool lookup_ids(const char *name, uid_t *uid, gid_t *gid)
+{
+	bool bret = false;
+	struct passwd *pwentp = NULL;
+	struct passwd pwent;
+	char *buf;
+	ssize_t bufsize;
+	int ret;
+
+	bufsize = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (bufsize < 0)
+		bufsize = 1024;
+
+	buf = malloc(bufsize);
+	if (!buf)
+		return bret;
+
+	ret = getpwnam_r(name, &pwent, buf, bufsize, &pwentp);
+	if (!ret && pwentp) {
+		*uid = pwent.pw_uid;
+		*gid = pwent.pw_gid;
+		bret = true;
+	}
+
+	free(buf);
+	return bret;
+}
+
+/**
+ * setattr_fix_968219708108 - test for commit 968219708108 ("fs: handle circular mappings correctly")
+ *
+ * Test that ->setattr() works correctly for idmapped mounts with circular
+ * idmappings such as:
+ *
+ * b:1000:1001:1
+ * b:1001:1000:1
+ *
+ * Assume a directory /source with two files:
+ *
+ * /source/file1 | 1000:1000
+ * /source/file2 | 1001:1001
+ *
+ * and we create an idmapped mount of /source at /target with an idmapped of:
+ *
+ * mnt_userns:        1000:1001:1
+ *                    1001:1000:1
+ *
+ * In the idmapped mount file1 will be owned by uid 1001 and file2 by uid 1000:
+ *
+ * /target/file1 | 1001:1001
+ * /target/file2 | 1000:1000
+ *
+ * Because in essence the idmapped mount switches ownership for {g,u}id 1000
+ * and {g,u}id 1001.
+ *
+ * 1. A user with fs{g,u}id 1000 must be allowed to setattr /target/file2 from
+ *    {g,u}id 1000 in the idmapped mount to {g,u}id 1000.
+ * 2. A user with fs{g,u}id 1001 must be allowed to setattr /target/file1 from
+ *    {g,u}id 1001 in the idmapped mount to {g,u}id 1001.
+ * 3. A user with fs{g,u}id 1000 must fail to setattr /target/file1 from
+ *    {g,u}id 1001 in the idmapped mount to {g,u}id 1000.
+ *    This must fail with EPERM. The caller's fs{g,u}id doesn't match the
+ *    {g,u}id of the file.
+ * 4. A user with fs{g,u}id 1001 must fail to setattr /target/file2 from
+ *    {g,u}id 1000 in the idmapped mount to {g,u}id 1000.
+ *    This must fail with EPERM. The caller's fs{g,u}id doesn't match the
+ *    {g,u}id of the file.
+ * 5. Both, a user with fs{g,u}id 1000 and a user with fs{g,u}id 1001, must
+ *    fail to setattr /target/file1 owned by {g,u}id 1001 in the idmapped mount
+ *    and /target/file2 owned by {g,u}id 1000 in the idmapped mount to any
+ *    {g,u}id apart from {g,u}id 1000 or 1001 with EINVAL.
+ *    Only {g,u}id 1000 and 1001 have a mapping in the idmapped mount. Other
+ *    {g,u}id are unmapped.
+ */
+static int setattr_fix_968219708108(const struct vfstest_info *info)
+{
+	int fret = -1;
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= -EBADF,
+	};
+	int ret;
+	uid_t user1_uid, user2_uid;
+	gid_t user1_gid, user2_gid;
+	pid_t pid;
+	struct list idmap;
+	struct list *it_cur, *it_next;
+
+	if (!caps_supported())
+		return 0;
+
+	list_init(&idmap);
+
+	if (!lookup_ids(USER1, &user1_uid, &user1_gid)) {
+		log_stderr("failure: lookup_user");
+		goto out;
+	}
+
+	if (!lookup_ids(USER2, &user2_uid, &user2_gid)) {
+		log_stderr("failure: lookup_user");
+		goto out;
+	}
+
+	log_debug("Found " USER1 " with uid(%d) and gid(%d) and " USER2 " with uid(%d) and gid(%d)",
+		  user1_uid, user1_gid, user2_uid, user2_gid);
+
+	if (mkdirat(info->t_dir1_fd, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	if (mknodat(info->t_dir1_fd, DIR1 "/" FILE1, S_IFREG | 0644, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+
+	if (chown_r(info->t_mnt_fd, T_DIR1, user1_uid, user1_gid)) {
+		log_stderr("failure: chown_r");
+		goto out;
+	}
+
+	if (mknodat(info->t_dir1_fd, DIR1 "/" FILE2, S_IFREG | 0644, 0)) {
+		log_stderr("failure: mknodat");
+		goto out;
+	}
+
+	if (fchownat(info->t_dir1_fd, DIR1 "/" FILE2, user2_uid, user2_gid, AT_SYMLINK_NOFOLLOW)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	print_r(info->t_mnt_fd, T_DIR1);
+
+	/* u:1000:1001:1 */
+	ret = add_map_entry(&idmap, user1_uid, user2_uid, 1, ID_TYPE_UID);
+	if (ret) {
+		log_stderr("failure: add_map_entry");
+		goto out;
+	}
+
+	/* u:1001:1000:1 */
+	ret = add_map_entry(&idmap, user2_uid, user1_uid, 1, ID_TYPE_UID);
+	if (ret) {
+		log_stderr("failure: add_map_entry");
+		goto out;
+	}
+
+	/* g:1000:1001:1 */
+	ret = add_map_entry(&idmap, user1_gid, user2_gid, 1, ID_TYPE_GID);
+	if (ret) {
+		log_stderr("failure: add_map_entry");
+		goto out;
+	}
+
+	/* g:1001:1000:1 */
+	ret = add_map_entry(&idmap, user2_gid, user1_gid, 1, ID_TYPE_GID);
+	if (ret) {
+		log_stderr("failure: add_map_entry");
+		goto out;
+	}
+
+	attr.userns_fd = get_userns_fd_from_idmap(&idmap);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(info->t_dir1_fd, DIR1,
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE |
+				     AT_RECURSIVE);
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
+	print_r(open_tree_fd, "");
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		/* switch to {g,u}id 1001 */
+		if (!switch_resids(user2_uid, user2_gid))
+			die("failure: switch_resids");
+
+		/* drop all capabilities */
+		if (!caps_down())
+			die("failure: caps_down");
+
+		/*
+		 * The {g,u}id 0 is not mapped in this idmapped mount so this
+		 * needs to fail with EINVAL.
+		 */
+		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+		if (errno != EINVAL)
+			die("failure: errno");
+
+		/*
+		 * A user with fs{g,u}id 1001 must be allowed to change
+		 * ownership of /target/file1 owned by {g,u}id 1001 in this
+		 * idmapped mount to {g,u}id 1001.
+		 */
+		if (fchownat(open_tree_fd, FILE1, user2_uid, user2_gid,
+			     AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+
+		/* Verify that the ownership is still {g,u}id 1001. */
+		if (!expected_uid_gid(open_tree_fd, FILE1, AT_SYMLINK_NOFOLLOW,
+				      user2_uid, user2_gid))
+			die("failure: check ownership");
+
+		/*
+		 * A user with fs{g,u}id 1001 must not be allowed to change
+		 * ownership of /target/file1 owned by {g,u}id 1001 in this
+		 * idmapped mount to {g,u}id 1000.
+		 */
+		if (!fchownat(open_tree_fd, FILE1, user1_uid, user1_gid,
+			      AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* Verify that the ownership is still {g,u}id 1001. */
+		if (!expected_uid_gid(open_tree_fd, FILE1, AT_SYMLINK_NOFOLLOW,
+				      user2_uid, user2_gid))
+			die("failure: check ownership");
+
+		/*
+		 * A user with fs{g,u}id 1001 must not be allowed to change
+		 * ownership of /target/file2 owned by {g,u}id 1000 in this
+		 * idmapped mount to {g,u}id 1000.
+		 */
+		if (!fchownat(open_tree_fd, FILE2, user1_uid, user1_gid,
+			      AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* Verify that the ownership is still {g,u}id 1000. */
+		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW,
+				      user1_uid, user1_gid))
+			die("failure: check ownership");
+
+		/*
+		 * A user with fs{g,u}id 1001 must not be allowed to change
+		 * ownership of /target/file2 owned by {g,u}id 1000 in this
+		 * idmapped mount to {g,u}id 1001.
+		 */
+		if (!fchownat(open_tree_fd, FILE2, user2_uid, user2_gid,
+			      AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* Verify that the ownership is still {g,u}id 1000. */
+		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW,
+				      user1_uid, user1_gid))
+			die("failure: check ownership");
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
+		/* switch to {g,u}id 1000 */
+		if (!switch_resids(user1_uid, user1_gid))
+			die("failure: switch_resids");
+
+		/* drop all capabilities */
+		if (!caps_down())
+			die("failure: caps_down");
+
+		/*
+		 * The {g,u}id 0 is not mapped in this idmapped mount so this
+		 * needs to fail with EINVAL.
+		 */
+		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+		if (errno != EINVAL)
+			die("failure: errno");
+
+		/*
+		 * A user with fs{g,u}id 1000 must be allowed to change
+		 * ownership of /target/file2 owned by {g,u}id 1000 in this
+		 * idmapped mount to {g,u}id 1000.
+		 */
+		if (fchownat(open_tree_fd, FILE2, user1_uid, user1_gid,
+			     AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+
+		/* Verify that the ownership is still {g,u}id 1000. */
+		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW,
+				      user1_uid, user1_gid))
+			die("failure: check ownership");
+
+		/*
+		 * A user with fs{g,u}id 1000 must not be allowed to change
+		 * ownership of /target/file2 owned by {g,u}id 1000 in this
+		 * idmapped mount to {g,u}id 1001.
+		 */
+		if (!fchownat(open_tree_fd, FILE2, user2_uid, user2_gid,
+			      AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* Verify that the ownership is still {g,u}id 1000. */
+		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW,
+				      user1_uid, user1_gid))
+			die("failure: check ownership");
+
+		/*
+		 * A user with fs{g,u}id 1000 must not be allowed to change
+		 * ownership of /target/file1 owned by {g,u}id 1001 in this
+		 * idmapped mount to {g,u}id 1000.
+		 */
+		if (!fchownat(open_tree_fd, FILE1, user1_uid, user1_gid,
+			     AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* Verify that the ownership is still {g,u}id 1001. */
+		if (!expected_uid_gid(open_tree_fd, FILE1, AT_SYMLINK_NOFOLLOW,
+				      user2_uid, user2_gid))
+			die("failure: check ownership");
+
+		/*
+		 * A user with fs{g,u}id 1000 must not be allowed to change
+		 * ownership of /target/file1 owned by {g,u}id 1001 in this
+		 * idmapped mount to {g,u}id 1001.
+		 */
+		if (!fchownat(open_tree_fd, FILE1, user2_uid, user2_gid,
+			      AT_SYMLINK_NOFOLLOW))
+			die("failure: change ownership");
+		if (errno != EPERM)
+			die("failure: errno");
+
+		/* Verify that the ownership is still {g,u}id 1001. */
+		if (!expected_uid_gid(open_tree_fd, FILE1, AT_SYMLINK_NOFOLLOW,
+				      user2_uid, user2_gid))
+			die("failure: check ownership");
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
+	safe_close(open_tree_fd);
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
 static const struct test_struct t_idmapped_mounts[] = {
 	{ acls,                                                         true,   "posix acls on regular mounts",                                                                 },
 	{ create_in_userns,                                             true,   "create operations in user namespace",                                                          },
@@ -6523,3 +7627,22 @@ const struct test_suite s_fscaps_in_ancestor_userns = {
 	.tests		= t_fscaps_in_ancestor_userns,
 	.nr_tests	= ARRAY_SIZE(t_fscaps_in_ancestor_userns),
 };
+
+static const struct test_struct t_nested_userns[] = {
+	{ nested_userns,						true,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
+};
+
+const struct test_suite s_nested_userns = {
+	.tests = t_nested_userns,
+	.nr_tests = ARRAY_SIZE(t_nested_userns),
+};
+
+/* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
+static const struct test_struct t_setattr_fix_968219708108[] = {
+	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
+};
+
+const struct test_suite s_setattr_fix_968219708108 = {
+	.tests = t_setattr_fix_968219708108,
+	.nr_tests = ARRAY_SIZE(t_setattr_fix_968219708108),
+};
diff --git a/src/vfs/idmapped-mounts.h b/src/vfs/idmapped-mounts.h
index 37c8886d..9febecd3 100644
--- a/src/vfs/idmapped-mounts.h
+++ b/src/vfs/idmapped-mounts.h
@@ -11,5 +11,7 @@
 
 extern const struct test_suite s_idmapped_mounts;
 extern const struct test_suite s_fscaps_in_ancestor_userns;
+extern const struct test_suite s_nested_userns;
+extern const struct test_suite s_setattr_fix_968219708108;
 
 #endif /* __IDMAPPED_MOUNTS_H */
diff --git a/src/vfs/utils.c b/src/vfs/utils.c
index 28944b70..089ac34e 100644
--- a/src/vfs/utils.c
+++ b/src/vfs/utils.c
@@ -871,3 +871,133 @@ int fd_to_fd(int from, int to)
 
 	return 0;
 }
+
+/*
+ * There'll be scenarios where you'll want to see the attributes associated with
+ * a directory tree during debugging or just to make sure things look correct.
+ * Simply uncomment and place the print_r() helper where you need it.
+ */
+#ifdef DEBUG_TRACE
+static int fd_cloexec(int fd, bool cloexec)
+{
+	int oflags, nflags;
+
+	oflags = fcntl(fd, F_GETFD, 0);
+	if (oflags < 0)
+		return -errno;
+
+	if (cloexec)
+		nflags = oflags | FD_CLOEXEC;
+	else
+		nflags = oflags & ~FD_CLOEXEC;
+
+	if (nflags == oflags)
+		return 0;
+
+	if (fcntl(fd, F_SETFD, nflags) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static inline int dup_cloexec(int fd)
+{
+	int fd_dup;
+
+	fd_dup = dup(fd);
+	if (fd_dup < 0)
+		return -errno;
+
+	if (fd_cloexec(fd_dup, true)) {
+		close(fd_dup);
+		return -errno;
+	}
+
+	return fd_dup;
+}
+
+int print_r(int fd, const char *path)
+{
+	int ret = 0;
+	int dfd, dfd_dup;
+	DIR *dir;
+	struct dirent *direntp;
+	struct stat st;
+
+	if (!path || *path == '\0') {
+		char buf[sizeof("/proc/self/fd/") + 30];
+
+		ret = snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
+		if (ret < 0 || (size_t)ret >= sizeof(buf))
+			return -1;
+
+		/*
+		 * O_PATH file descriptors can't be used so we need to re-open
+		 * just in case.
+		 */
+		dfd = openat(-EBADF, buf, O_CLOEXEC | O_DIRECTORY, 0);
+	} else {
+		dfd = openat(fd, path, O_CLOEXEC | O_DIRECTORY, 0);
+	}
+	if (dfd < 0)
+		return -1;
+
+	/*
+	 * When fdopendir() below succeeds it assumes ownership of the fd so we
+	 * to make sure we always have an fd that fdopendir() can own which is
+	 * why we dup() in the case where the caller wants us to operate on the
+	 * fd directly.
+	 */
+	dfd_dup = dup_cloexec(dfd);
+	if (dfd_dup < 0) {
+		close(dfd);
+		return -1;
+	}
+
+	dir = fdopendir(dfd);
+	if (!dir) {
+		close(dfd);
+		close(dfd_dup);
+		return -1;
+	}
+	/* Transfer ownership to fdopendir(). */
+	dfd = -EBADF;
+
+	while ((direntp = readdir(dir))) {
+		if (!strcmp(direntp->d_name, ".") ||
+		    !strcmp(direntp->d_name, ".."))
+			continue;
+
+		ret = fstatat(dfd_dup, direntp->d_name, &st, AT_SYMLINK_NOFOLLOW);
+		if (ret < 0 && errno != ENOENT)
+			break;
+
+		ret = 0;
+		if (S_ISDIR(st.st_mode))
+			ret = print_r(dfd_dup, direntp->d_name);
+		else
+			fprintf(stderr, "mode(%o):uid(%d):gid(%d) -> %d/%s\n",
+				(st.st_mode & ~S_IFMT), st.st_uid, st.st_gid,
+				dfd_dup, direntp->d_name);
+		if (ret < 0 && errno != ENOENT)
+			break;
+	}
+
+	if (!path || *path == '\0')
+		ret = fstatat(fd, "", &st,
+			      AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+			      AT_EMPTY_PATH);
+	else
+		ret = fstatat(fd, path, &st,
+			      AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW);
+	if (!ret)
+		fprintf(stderr, "mode(%o):uid(%d):gid(%d) -> %s\n",
+			(st.st_mode & ~S_IFMT), st.st_uid, st.st_gid,
+			(path && *path) ? path : "(null)");
+
+	close(dfd_dup);
+	closedir(dir);
+
+	return ret;
+}
+#endif
diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index a13efabb..07aae675 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -347,6 +347,11 @@ extern int io_uring_openat_with_creds(struct io_uring *ring, int dfd,
 
 extern int chown_r(int fd, const char *path, uid_t uid, gid_t gid);
 extern int rm_r(int fd, const char *path);
+#ifdef DEBUG_TRACE
+extern int print_r(int fd, const char *path);
+#else
+static inline int print_r(int fd, const char *path) { return 0; }
+#endif
 extern int fd_to_fd(int from, int to);
 extern bool protected_symlinks_enabled(void);
 extern bool xfs_irix_sgid_inherit_enabled(const char *fstype);
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index dadf1a0b..4567e95f 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -79,141 +79,6 @@ static void stash_overflowgid(struct vfstest_info *info)
 	info->t_overflowgid = atoi(buf);
 }
 
-/*
- * There'll be scenarios where you'll want to see the attributes associated with
- * a directory tree during debugging or just to make sure things look correct.
- * Simply uncomment and place the print_r() helper where you need it.
- */
-#ifdef DEBUG_TRACE
-static int fd_cloexec(int fd, bool cloexec)
-{
-	int oflags, nflags;
-
-	oflags = fcntl(fd, F_GETFD, 0);
-	if (oflags < 0)
-		return -errno;
-
-	if (cloexec)
-		nflags = oflags | FD_CLOEXEC;
-	else
-		nflags = oflags & ~FD_CLOEXEC;
-
-	if (nflags == oflags)
-		return 0;
-
-	if (fcntl(fd, F_SETFD, nflags) < 0)
-		return -errno;
-
-	return 0;
-}
-
-static inline int dup_cloexec(int fd)
-{
-	int fd_dup;
-
-	fd_dup = dup(fd);
-	if (fd_dup < 0)
-		return -errno;
-
-	if (fd_cloexec(fd_dup, true)) {
-		close(fd_dup);
-		return -errno;
-	}
-
-	return fd_dup;
-}
-
-__attribute__((unused)) static int print_r(int fd, const char *path)
-{
-	int ret = 0;
-	int dfd, dfd_dup;
-	DIR *dir;
-	struct dirent *direntp;
-	struct stat st;
-
-	if (!path || *path == '\0') {
-		char buf[sizeof("/proc/self/fd/") + 30];
-
-		ret = snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
-		if (ret < 0 || (size_t)ret >= sizeof(buf))
-			return -1;
-
-		/*
-		 * O_PATH file descriptors can't be used so we need to re-open
-		 * just in case.
-		 */
-		dfd = openat(-EBADF, buf, O_CLOEXEC | O_DIRECTORY, 0);
-	} else {
-		dfd = openat(fd, path, O_CLOEXEC | O_DIRECTORY, 0);
-	}
-	if (dfd < 0)
-		return -1;
-
-	/*
-	 * When fdopendir() below succeeds it assumes ownership of the fd so we
-	 * to make sure we always have an fd that fdopendir() can own which is
-	 * why we dup() in the case where the caller wants us to operate on the
-	 * fd directly.
-	 */
-	dfd_dup = dup_cloexec(dfd);
-	if (dfd_dup < 0) {
-		close(dfd);
-		return -1;
-	}
-
-	dir = fdopendir(dfd);
-	if (!dir) {
-		close(dfd);
-		close(dfd_dup);
-		return -1;
-	}
-	/* Transfer ownership to fdopendir(). */
-	dfd = -EBADF;
-
-	while ((direntp = readdir(dir))) {
-		if (!strcmp(direntp->d_name, ".") ||
-		    !strcmp(direntp->d_name, ".."))
-			continue;
-
-		ret = fstatat(dfd_dup, direntp->d_name, &st, AT_SYMLINK_NOFOLLOW);
-		if (ret < 0 && errno != ENOENT)
-			break;
-
-		ret = 0;
-		if (S_ISDIR(st.st_mode))
-			ret = print_r(dfd_dup, direntp->d_name);
-		else
-			fprintf(stderr, "mode(%o):uid(%d):gid(%d) -> %d/%s\n",
-				(st.st_mode & ~S_IFMT), st.st_uid, st.st_gid,
-				dfd_dup, direntp->d_name);
-		if (ret < 0 && errno != ENOENT)
-			break;
-	}
-
-	if (!path || *path == '\0')
-		ret = fstatat(fd, "", &st,
-			      AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
-			      AT_EMPTY_PATH);
-	else
-		ret = fstatat(fd, path, &st,
-			      AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW);
-	if (!ret)
-		fprintf(stderr, "mode(%o):uid(%d):gid(%d) -> %s\n",
-			(st.st_mode & ~S_IFMT), st.st_uid, st.st_gid,
-			(path && *path) ? path : "(null)");
-
-	close(dfd_dup);
-	closedir(dir);
-
-	return ret;
-}
-#else
-__attribute__((unused)) static int print_r(int fd, const char *path)
-{
-	return 0;
-}
-#endif
-
 static void test_setup(struct vfstest_info *info)
 {
 	if (mkdirat(info->t_mnt_fd, T_DIR1, 0777))
@@ -1827,1110 +1692,6 @@ out:
 	return fret;
 }
 
-static int nested_userns(const struct vfstest_info *info)
-{
-	int fret = -1;
-	int ret;
-	pid_t pid;
-	unsigned int id;
-	struct list *it, *next;
-	struct userns_hierarchy hierarchy[] = {
-		{ .level = 1, .fd_userns = -EBADF, },
-		{ .level = 2, .fd_userns = -EBADF, },
-		{ .level = 3, .fd_userns = -EBADF, },
-		{ .level = 4, .fd_userns = -EBADF, },
-		/* Dummy entry that marks the end. */
-		{ .level = MAX_USERNS_LEVEL, .fd_userns = -EBADF, },
-	};
-	struct mount_attr attr_level1 = {
-		.attr_set	= MOUNT_ATTR_IDMAP,
-		.userns_fd	= -EBADF,
-	};
-	struct mount_attr attr_level2 = {
-		.attr_set	= MOUNT_ATTR_IDMAP,
-		.userns_fd	= -EBADF,
-	};
-	struct mount_attr attr_level3 = {
-		.attr_set	= MOUNT_ATTR_IDMAP,
-		.userns_fd	= -EBADF,
-	};
-	struct mount_attr attr_level4 = {
-		.attr_set	= MOUNT_ATTR_IDMAP,
-		.userns_fd	= -EBADF,
-	};
-	int fd_dir1 = -EBADF,
-	    fd_open_tree_level1 = -EBADF,
-	    fd_open_tree_level2 = -EBADF,
-	    fd_open_tree_level3 = -EBADF,
-	    fd_open_tree_level4 = -EBADF;
-	const unsigned int id_file_range = 10000;
-
-	list_init(&hierarchy[0].id_map);
-	list_init(&hierarchy[1].id_map);
-	list_init(&hierarchy[2].id_map);
-	list_init(&hierarchy[3].id_map);
-
-	/*
-	 * Give a large map to the outermost user namespace so we can create
-	 * comfortable nested maps.
-	 */
-	ret = add_map_entry(&hierarchy[0].id_map, 1000000, 0, 1000000000, ID_TYPE_UID);
-	if (ret) {
-		log_stderr("failure: adding uidmap for userns at level 1");
-		goto out;
-	}
-
-	ret = add_map_entry(&hierarchy[0].id_map, 1000000, 0, 1000000000, ID_TYPE_GID);
-	if (ret) {
-		log_stderr("failure: adding gidmap for userns at level 1");
-		goto out;
-	}
-
-	/* This is uid:0->2000000:100000000 in init userns. */
-	ret = add_map_entry(&hierarchy[1].id_map, 1000000, 0, 100000000, ID_TYPE_UID);
-	if (ret) {
-		log_stderr("failure: adding uidmap for userns at level 2");
-		goto out;
-	}
-
-	/* This is gid:0->2000000:100000000 in init userns. */
-	ret = add_map_entry(&hierarchy[1].id_map, 1000000, 0, 100000000, ID_TYPE_GID);
-	if (ret) {
-		log_stderr("failure: adding gidmap for userns at level 2");
-		goto out;
-	}
-
-	/* This is uid:0->3000000:999 in init userns. */
-	ret = add_map_entry(&hierarchy[2].id_map, 1000000, 0, 999, ID_TYPE_UID);
-	if (ret) {
-		log_stderr("failure: adding uidmap for userns at level 3");
-		goto out;
-	}
-
-	/* This is gid:0->3000000:999 in the init userns. */
-	ret = add_map_entry(&hierarchy[2].id_map, 1000000, 0, 999, ID_TYPE_GID);
-	if (ret) {
-		log_stderr("failure: adding gidmap for userns at level 3");
-		goto out;
-	}
-
-	/* id 999 will remain unmapped. */
-
-	/* This is uid:1000->2001000:1 in init userns. */
-	ret = add_map_entry(&hierarchy[2].id_map, 1000, 1000, 1, ID_TYPE_UID);
-	if (ret) {
-		log_stderr("failure: adding uidmap for userns at level 3");
-		goto out;
-	}
-
-	/* This is gid:1000->2001000:1 in init userns. */
-	ret = add_map_entry(&hierarchy[2].id_map, 1000, 1000, 1, ID_TYPE_GID);
-	if (ret) {
-		log_stderr("failure: adding gidmap for userns at level 3");
-		goto out;
-	}
-
-	/* This is uid:1001->3001001:10000 in init userns. */
-	ret = add_map_entry(&hierarchy[2].id_map, 1001001, 1001, 10000000, ID_TYPE_UID);
-	if (ret) {
-		log_stderr("failure: adding uidmap for userns at level 3");
-		goto out;
-	}
-
-	/* This is gid:1001->3001001:10000 in init userns. */
-	ret = add_map_entry(&hierarchy[2].id_map, 1001001, 1001, 10000000, ID_TYPE_GID);
-	if (ret) {
-		log_stderr("failure: adding gidmap for userns at level 3");
-		goto out;
-	}
-
-	/* Don't write a mapping in the 4th userns. */
-	list_empty(&hierarchy[4].id_map);
-
-	/* Create the actual userns hierarchy. */
-	ret = create_userns_hierarchy(hierarchy);
-	if (ret) {
-		log_stderr("failure: create userns hierarchy");
-		goto out;
-	}
-
-	attr_level1.userns_fd = hierarchy[0].fd_userns;
-	attr_level2.userns_fd = hierarchy[1].fd_userns;
-	attr_level3.userns_fd = hierarchy[2].fd_userns;
-	attr_level4.userns_fd = hierarchy[3].fd_userns;
-
-	/*
-	 * Create one directory where we create files for each uid/gid within
-	 * the first userns.
-	 */
-	if (mkdirat(info->t_dir1_fd, DIR1, 0777)) {
-		log_stderr("failure: mkdirat");
-		goto out;
-	}
-
-	fd_dir1 = openat(info->t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
-	if (fd_dir1 < 0) {
-		log_stderr("failure: openat");
-		goto out;
-	}
-
-	for (id = 0; id <= id_file_range; id++) {
-		char file[256];
-
-		snprintf(file, sizeof(file), DIR1 "/" FILE1 "_%u", id);
-
-		if (mknodat(info->t_dir1_fd, file, S_IFREG | 0644, 0)) {
-			log_stderr("failure: create %s", file);
-			goto out;
-		}
-
-		if (fchownat(info->t_dir1_fd, file, id, id, AT_SYMLINK_NOFOLLOW)) {
-			log_stderr("failure: fchownat %s", file);
-			goto out;
-		}
-
-		if (!expected_uid_gid(info->t_dir1_fd, file, 0, id, id)) {
-			log_stderr("failure: check ownership %s", file);
-			goto out;
-		}
-	}
-
-	/* Create detached mounts for all the user namespaces. */
-	fd_open_tree_level1 = sys_open_tree(info->t_dir1_fd, DIR1,
-					    AT_NO_AUTOMOUNT |
-					    AT_SYMLINK_NOFOLLOW |
-					    OPEN_TREE_CLOEXEC |
-					    OPEN_TREE_CLONE);
-	if (fd_open_tree_level1 < 0) {
-		log_stderr("failure: sys_open_tree");
-		goto out;
-	}
-
-	fd_open_tree_level2 = sys_open_tree(info->t_dir1_fd, DIR1,
-					    AT_NO_AUTOMOUNT |
-					    AT_SYMLINK_NOFOLLOW |
-					    OPEN_TREE_CLOEXEC |
-					    OPEN_TREE_CLONE);
-	if (fd_open_tree_level2 < 0) {
-		log_stderr("failure: sys_open_tree");
-		goto out;
-	}
-
-	fd_open_tree_level3 = sys_open_tree(info->t_dir1_fd, DIR1,
-					    AT_NO_AUTOMOUNT |
-					    AT_SYMLINK_NOFOLLOW |
-					    OPEN_TREE_CLOEXEC |
-					    OPEN_TREE_CLONE);
-	if (fd_open_tree_level3 < 0) {
-		log_stderr("failure: sys_open_tree");
-		goto out;
-	}
-
-	fd_open_tree_level4 = sys_open_tree(info->t_dir1_fd, DIR1,
-					    AT_NO_AUTOMOUNT |
-					    AT_SYMLINK_NOFOLLOW |
-					    OPEN_TREE_CLOEXEC |
-					    OPEN_TREE_CLONE);
-	if (fd_open_tree_level4 < 0) {
-		log_stderr("failure: sys_open_tree");
-		goto out;
-	}
-
-	/* Turn detached mounts into detached idmapped mounts. */
-	if (sys_mount_setattr(fd_open_tree_level1, "", AT_EMPTY_PATH,
-			      &attr_level1, sizeof(attr_level1))) {
-		log_stderr("failure: sys_mount_setattr");
-		goto out;
-	}
-
-	if (sys_mount_setattr(fd_open_tree_level2, "", AT_EMPTY_PATH,
-			      &attr_level2, sizeof(attr_level2))) {
-		log_stderr("failure: sys_mount_setattr");
-		goto out;
-	}
-
-	if (sys_mount_setattr(fd_open_tree_level3, "", AT_EMPTY_PATH,
-			      &attr_level3, sizeof(attr_level3))) {
-		log_stderr("failure: sys_mount_setattr");
-		goto out;
-	}
-
-	if (sys_mount_setattr(fd_open_tree_level4, "", AT_EMPTY_PATH,
-			      &attr_level4, sizeof(attr_level4))) {
-		log_stderr("failure: sys_mount_setattr");
-		goto out;
-	}
-
-	/* Verify that ownership looks correct for callers in the init userns. */
-	for (id = 0; id <= id_file_range; id++) {
-		bool bret;
-		unsigned int id_level1, id_level2, id_level3;
-		char file[256];
-
-		snprintf(file, sizeof(file), FILE1 "_%u", id);
-
-		id_level1 = id + 1000000;
-		if (!expected_uid_gid(fd_open_tree_level1, file, 0, id_level1, id_level1)) {
-			log_stderr("failure: check ownership %s", file);
-			goto out;
-		}
-
-		id_level2 = id + 2000000;
-		if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2)) {
-			log_stderr("failure: check ownership %s", file);
-			goto out;
-		}
-
-		if (id == 999) {
-			/* This id is unmapped. */
-			bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
-		} else if (id == 1000) {
-			id_level3 = id + 2000000; /* We punched a hole in the map at 1000. */
-			bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-		} else {
-			id_level3 = id + 3000000; /* Rest is business as usual. */
-			bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-		}
-		if (!bret) {
-			log_stderr("failure: check ownership %s", file);
-			goto out;
-		}
-
-		if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid)) {
-			log_stderr("failure: check ownership %s", file);
-			goto out;
-		}
-	}
-
-	/* Verify that ownership looks correct for callers in the first userns. */
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		if (!switch_userns(attr_level1.userns_fd, 0, 0, false))
-			die("failure: switch_userns");
-
-		for (id = 0; id <= id_file_range; id++) {
-			bool bret;
-			unsigned int id_level1, id_level2, id_level3;
-			char file[256];
-
-			snprintf(file, sizeof(file), FILE1 "_%u", id);
-
-			id_level1 = id;
-			if (!expected_uid_gid(fd_open_tree_level1, file, 0, id_level1, id_level1))
-				die("failure: check ownership %s", file);
-
-			id_level2 = id + 1000000;
-			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
-				die("failure: check ownership %s", file);
-
-			if (id == 999) {
-				/* This id is unmapped. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
-			} else if (id == 1000) {
-				id_level3 = id + 1000000; /* We punched a hole in the map at 1000. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-			} else {
-				id_level3 = id + 2000000; /* Rest is business as usual. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-			}
-			if (!bret)
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-		}
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	/* Verify that ownership looks correct for callers in the second userns. */
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		if (!switch_userns(attr_level2.userns_fd, 0, 0, false))
-			die("failure: switch_userns");
-
-		for (id = 0; id <= id_file_range; id++) {
-			bool bret;
-			unsigned int id_level2, id_level3;
-			char file[256];
-
-			snprintf(file, sizeof(file), FILE1 "_%u", id);
-
-			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			id_level2 = id;
-			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
-				die("failure: check ownership %s", file);
-
-			if (id == 999) {
-				/* This id is unmapped. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
-			} else if (id == 1000) {
-				id_level3 = id; /* We punched a hole in the map at 1000. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-			} else {
-				id_level3 = id + 1000000; /* Rest is business as usual. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-			}
-			if (!bret)
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-		}
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	/* Verify that ownership looks correct for callers in the third userns. */
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		if (!switch_userns(attr_level3.userns_fd, 0, 0, false))
-			die("failure: switch_userns");
-
-		for (id = 0; id <= id_file_range; id++) {
-			bool bret;
-			unsigned int id_level2, id_level3;
-			char file[256];
-
-			snprintf(file, sizeof(file), FILE1 "_%u", id);
-
-			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			if (id == 1000) {
-				/*
-				 * The idmapping of the third userns has a hole
-				 * at uid/gid 1000. That means:
-				 * - 1000->userns_0(2000000) // init userns
-				 * - 1000->userns_1(2000000) // level 1
-				 * - 1000->userns_2(1000000) // level 2
-				 * - 1000->userns_3(1000)    // level 3 (because level 3 has a hole)
-				 */
-				id_level2 = id;
-				bret = expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2);
-			} else {
-				bret = expected_uid_gid(fd_open_tree_level2, file, 0, info->t_overflowuid, info->t_overflowgid);
-			}
-			if (!bret)
-				die("failure: check ownership %s", file);
-
-
-			if (id == 999) {
-				/* This id is unmapped. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
-			} else {
-				id_level3 = id; /* Rest is business as usual. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-			}
-			if (!bret)
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-		}
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	/* Verify that ownership looks correct for callers in the fourth userns. */
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		if (setns(attr_level4.userns_fd, CLONE_NEWUSER))
-			die("failure: switch_userns");
-
-		for (id = 0; id <= id_file_range; id++) {
-			char file[256];
-
-			snprintf(file, sizeof(file), FILE1 "_%u", id);
-
-			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level2, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-		}
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	/* Verify that chown works correctly for callers in the first userns. */
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		if (!switch_userns(attr_level1.userns_fd, 0, 0, false))
-			die("failure: switch_userns");
-
-		for (id = 0; id <= id_file_range; id++) {
-			bool bret;
-			unsigned int id_level1, id_level2, id_level3, id_new;
-			char file[256];
-
-			snprintf(file, sizeof(file), FILE1 "_%u", id);
-
-			id_new = id + 1;
-			if (fchownat(fd_open_tree_level1, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
-				die("failure: fchownat %s", file);
-
-			id_level1 = id_new;
-			if (!expected_uid_gid(fd_open_tree_level1, file, 0, id_level1, id_level1))
-				die("failure: check ownership %s", file);
-
-			id_level2 = id_new + 1000000;
-			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
-				die("failure: check ownership %s", file);
-
-			if (id_new == 999) {
-				/* This id is unmapped. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
-			} else if (id_new == 1000) {
-				id_level3 = id_new + 1000000; /* We punched a hole in the map at 1000. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-			} else {
-				id_level3 = id_new + 2000000; /* Rest is business as usual. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-			}
-			if (!bret)
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			/* Revert ownership. */
-			if (fchownat(fd_open_tree_level1, file, id, id, AT_SYMLINK_NOFOLLOW))
-				die("failure: fchownat %s", file);
-		}
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	/* Verify that chown works correctly for callers in the second userns. */
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		if (!switch_userns(attr_level2.userns_fd, 0, 0, false))
-			die("failure: switch_userns");
-
-		for (id = 0; id <= id_file_range; id++) {
-			bool bret;
-			unsigned int id_level2, id_level3, id_new;
-			char file[256];
-
-			snprintf(file, sizeof(file), FILE1 "_%u", id);
-
-			id_new = id + 1;
-			if (fchownat(fd_open_tree_level2, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
-				die("failure: fchownat %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			id_level2 = id_new;
-			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
-				die("failure: check ownership %s", file);
-
-			if (id_new == 999) {
-				/* This id is unmapped. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid);
-			} else if (id_new == 1000) {
-				id_level3 = id_new; /* We punched a hole in the map at 1000. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-			} else {
-				id_level3 = id_new + 1000000; /* Rest is business as usual. */
-				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
-			}
-			if (!bret)
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			/* Revert ownership. */
-			if (fchownat(fd_open_tree_level2, file, id, id, AT_SYMLINK_NOFOLLOW))
-				die("failure: fchownat %s", file);
-		}
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	/* Verify that chown works correctly for callers in the third userns. */
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		if (!switch_userns(attr_level3.userns_fd, 0, 0, false))
-			die("failure: switch_userns");
-
-		for (id = 0; id <= id_file_range; id++) {
-			unsigned int id_new;
-			char file[256];
-
-			snprintf(file, sizeof(file), FILE1 "_%u", id);
-
-			id_new = id + 1;
-			if (id_new == 999 || id_new == 1000) {
-				/*
-				 * We can't change ownership as we can't
-				 * chown from or to an unmapped id.
-				 */
-				if (!fchownat(fd_open_tree_level3, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
-					die("failure: fchownat %s", file);
-			} else {
-				if (fchownat(fd_open_tree_level3, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
-					die("failure: fchownat %s", file);
-			}
-
-			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			/* There's no id 1000 anymore as we changed ownership for id 1000 to 1001 above. */
-			if (!expected_uid_gid(fd_open_tree_level2, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			if (id_new == 999) {
-				/*
-				 * We did not change ownership as we can't
-				 * chown to an unmapped id.
-				 */
-				if (!expected_uid_gid(fd_open_tree_level3, file, 0, id, id))
-					die("failure: check ownership %s", file);
-			} else if (id_new == 1000) {
-				/*
-				 * We did not change ownership as we can't
-				 * chown from an unmapped id.
-				 */
-				if (!expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid))
-					die("failure: check ownership %s", file);
-			} else {
-				if (!expected_uid_gid(fd_open_tree_level3, file, 0, id_new, id_new))
-					die("failure: check ownership %s", file);
-			}
-
-			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			/* Revert ownership. */
-			if (id_new != 999 && id_new != 1000) {
-				if (fchownat(fd_open_tree_level3, file, id, id, AT_SYMLINK_NOFOLLOW))
-					die("failure: fchownat %s", file);
-			}
-		}
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	/* Verify that chown works correctly for callers in the fourth userns. */
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		if (setns(attr_level4.userns_fd, CLONE_NEWUSER))
-			die("failure: switch_userns");
-
-		for (id = 0; id <= id_file_range; id++) {
-			char file[256];
-			unsigned long id_new;
-
-			snprintf(file, sizeof(file), FILE1 "_%u", id);
-
-			id_new = id + 1;
-			if (!fchownat(fd_open_tree_level4, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
-				die("failure: fchownat %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level1, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level2, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level3, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-			if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid))
-				die("failure: check ownership %s", file);
-
-		}
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	fret = 0;
-	log_debug("Ran test");
-
-out:
-	list_for_each_safe(it, &hierarchy[0].id_map, next) {
-		list_del(it);
-		free(it->elem);
-		free(it);
-	}
-
-	list_for_each_safe(it, &hierarchy[1].id_map, next) {
-		list_del(it);
-		free(it->elem);
-		free(it);
-	}
-
-	list_for_each_safe(it, &hierarchy[2].id_map, next) {
-		list_del(it);
-		free(it->elem);
-		free(it);
-	}
-
-	safe_close(hierarchy[0].fd_userns);
-	safe_close(hierarchy[1].fd_userns);
-	safe_close(hierarchy[2].fd_userns);
-	safe_close(fd_dir1);
-	safe_close(fd_open_tree_level1);
-	safe_close(fd_open_tree_level2);
-	safe_close(fd_open_tree_level3);
-	safe_close(fd_open_tree_level4);
-	return fret;
-}
-
-#define USER1 "fsgqa"
-#define USER2 "fsgqa2"
-
-/**
- * lookup_ids - lookup uid and gid for a username
- * @name: [in]  name of the user
- * @uid:  [out] pointer to the user-ID
- * @gid:  [out] pointer to the group-ID
- *
- * Lookup the uid and gid of a user.
- *
- * Return: On success, true is returned.
- *         On error, false is returned.
- */
-static bool lookup_ids(const char *name, uid_t *uid, gid_t *gid)
-{
-	bool bret = false;
-	struct passwd *pwentp = NULL;
-	struct passwd pwent;
-	char *buf;
-	ssize_t bufsize;
-	int ret;
-
-	bufsize = sysconf(_SC_GETPW_R_SIZE_MAX);
-	if (bufsize < 0)
-		bufsize = 1024;
-
-	buf = malloc(bufsize);
-	if (!buf)
-		return bret;
-
-	ret = getpwnam_r(name, &pwent, buf, bufsize, &pwentp);
-	if (!ret && pwentp) {
-		*uid = pwent.pw_uid;
-		*gid = pwent.pw_gid;
-		bret = true;
-	}
-
-	free(buf);
-	return bret;
-}
-
-/**
- * setattr_fix_968219708108 - test for commit 968219708108 ("fs: handle circular mappings correctly")
- *
- * Test that ->setattr() works correctly for idmapped mounts with circular
- * idmappings such as:
- *
- * b:1000:1001:1
- * b:1001:1000:1
- *
- * Assume a directory /source with two files:
- *
- * /source/file1 | 1000:1000
- * /source/file2 | 1001:1001
- *
- * and we create an idmapped mount of /source at /target with an idmapped of:
- *
- * mnt_userns:        1000:1001:1
- *                    1001:1000:1
- *
- * In the idmapped mount file1 will be owned by uid 1001 and file2 by uid 1000:
- *
- * /target/file1 | 1001:1001
- * /target/file2 | 1000:1000
- *
- * Because in essence the idmapped mount switches ownership for {g,u}id 1000
- * and {g,u}id 1001.
- *
- * 1. A user with fs{g,u}id 1000 must be allowed to setattr /target/file2 from
- *    {g,u}id 1000 in the idmapped mount to {g,u}id 1000.
- * 2. A user with fs{g,u}id 1001 must be allowed to setattr /target/file1 from
- *    {g,u}id 1001 in the idmapped mount to {g,u}id 1001.
- * 3. A user with fs{g,u}id 1000 must fail to setattr /target/file1 from
- *    {g,u}id 1001 in the idmapped mount to {g,u}id 1000.
- *    This must fail with EPERM. The caller's fs{g,u}id doesn't match the
- *    {g,u}id of the file.
- * 4. A user with fs{g,u}id 1001 must fail to setattr /target/file2 from
- *    {g,u}id 1000 in the idmapped mount to {g,u}id 1000.
- *    This must fail with EPERM. The caller's fs{g,u}id doesn't match the
- *    {g,u}id of the file.
- * 5. Both, a user with fs{g,u}id 1000 and a user with fs{g,u}id 1001, must
- *    fail to setattr /target/file1 owned by {g,u}id 1001 in the idmapped mount
- *    and /target/file2 owned by {g,u}id 1000 in the idmapped mount to any
- *    {g,u}id apart from {g,u}id 1000 or 1001 with EINVAL.
- *    Only {g,u}id 1000 and 1001 have a mapping in the idmapped mount. Other
- *    {g,u}id are unmapped.
- */
-static int setattr_fix_968219708108(const struct vfstest_info *info)
-{
-	int fret = -1;
-	int open_tree_fd = -EBADF;
-	struct mount_attr attr = {
-		.attr_set	= MOUNT_ATTR_IDMAP,
-		.userns_fd	= -EBADF,
-	};
-	int ret;
-	uid_t user1_uid, user2_uid;
-	gid_t user1_gid, user2_gid;
-	pid_t pid;
-	struct list idmap;
-	struct list *it_cur, *it_next;
-
-	if (!caps_supported())
-		return 0;
-
-	list_init(&idmap);
-
-	if (!lookup_ids(USER1, &user1_uid, &user1_gid)) {
-		log_stderr("failure: lookup_user");
-		goto out;
-	}
-
-	if (!lookup_ids(USER2, &user2_uid, &user2_gid)) {
-		log_stderr("failure: lookup_user");
-		goto out;
-	}
-
-	log_debug("Found " USER1 " with uid(%d) and gid(%d) and " USER2 " with uid(%d) and gid(%d)",
-		  user1_uid, user1_gid, user2_uid, user2_gid);
-
-	if (mkdirat(info->t_dir1_fd, DIR1, 0777)) {
-		log_stderr("failure: mkdirat");
-		goto out;
-	}
-
-	if (mknodat(info->t_dir1_fd, DIR1 "/" FILE1, S_IFREG | 0644, 0)) {
-		log_stderr("failure: mknodat");
-		goto out;
-	}
-
-	if (chown_r(info->t_mnt_fd, T_DIR1, user1_uid, user1_gid)) {
-		log_stderr("failure: chown_r");
-		goto out;
-	}
-
-	if (mknodat(info->t_dir1_fd, DIR1 "/" FILE2, S_IFREG | 0644, 0)) {
-		log_stderr("failure: mknodat");
-		goto out;
-	}
-
-	if (fchownat(info->t_dir1_fd, DIR1 "/" FILE2, user2_uid, user2_gid, AT_SYMLINK_NOFOLLOW)) {
-		log_stderr("failure: fchownat");
-		goto out;
-	}
-
-	print_r(info->t_mnt_fd, T_DIR1);
-
-	/* u:1000:1001:1 */
-	ret = add_map_entry(&idmap, user1_uid, user2_uid, 1, ID_TYPE_UID);
-	if (ret) {
-		log_stderr("failure: add_map_entry");
-		goto out;
-	}
-
-	/* u:1001:1000:1 */
-	ret = add_map_entry(&idmap, user2_uid, user1_uid, 1, ID_TYPE_UID);
-	if (ret) {
-		log_stderr("failure: add_map_entry");
-		goto out;
-	}
-
-	/* g:1000:1001:1 */
-	ret = add_map_entry(&idmap, user1_gid, user2_gid, 1, ID_TYPE_GID);
-	if (ret) {
-		log_stderr("failure: add_map_entry");
-		goto out;
-	}
-
-	/* g:1001:1000:1 */
-	ret = add_map_entry(&idmap, user2_gid, user1_gid, 1, ID_TYPE_GID);
-	if (ret) {
-		log_stderr("failure: add_map_entry");
-		goto out;
-	}
-
-	attr.userns_fd = get_userns_fd_from_idmap(&idmap);
-	if (attr.userns_fd < 0) {
-		log_stderr("failure: get_userns_fd");
-		goto out;
-	}
-
-	open_tree_fd = sys_open_tree(info->t_dir1_fd, DIR1,
-				     AT_NO_AUTOMOUNT |
-				     AT_SYMLINK_NOFOLLOW |
-				     OPEN_TREE_CLOEXEC |
-				     OPEN_TREE_CLONE |
-				     AT_RECURSIVE);
-	if (open_tree_fd < 0) {
-		log_stderr("failure: sys_open_tree");
-		goto out;
-	}
-
-	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
-		log_stderr("failure: sys_mount_setattr");
-		goto out;
-	}
-
-	print_r(open_tree_fd, "");
-
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		/* switch to {g,u}id 1001 */
-		if (!switch_resids(user2_uid, user2_gid))
-			die("failure: switch_resids");
-
-		/* drop all capabilities */
-		if (!caps_down())
-			die("failure: caps_down");
-
-		/*
-		 * The {g,u}id 0 is not mapped in this idmapped mount so this
-		 * needs to fail with EINVAL.
-		 */
-		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-		if (errno != EINVAL)
-			die("failure: errno");
-
-		/*
-		 * A user with fs{g,u}id 1001 must be allowed to change
-		 * ownership of /target/file1 owned by {g,u}id 1001 in this
-		 * idmapped mount to {g,u}id 1001.
-		 */
-		if (fchownat(open_tree_fd, FILE1, user2_uid, user2_gid,
-			     AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-
-		/* Verify that the ownership is still {g,u}id 1001. */
-		if (!expected_uid_gid(open_tree_fd, FILE1, AT_SYMLINK_NOFOLLOW,
-				      user2_uid, user2_gid))
-			die("failure: check ownership");
-
-		/*
-		 * A user with fs{g,u}id 1001 must not be allowed to change
-		 * ownership of /target/file1 owned by {g,u}id 1001 in this
-		 * idmapped mount to {g,u}id 1000.
-		 */
-		if (!fchownat(open_tree_fd, FILE1, user1_uid, user1_gid,
-			      AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-		if (errno != EPERM)
-			die("failure: errno");
-
-		/* Verify that the ownership is still {g,u}id 1001. */
-		if (!expected_uid_gid(open_tree_fd, FILE1, AT_SYMLINK_NOFOLLOW,
-				      user2_uid, user2_gid))
-			die("failure: check ownership");
-
-		/*
-		 * A user with fs{g,u}id 1001 must not be allowed to change
-		 * ownership of /target/file2 owned by {g,u}id 1000 in this
-		 * idmapped mount to {g,u}id 1000.
-		 */
-		if (!fchownat(open_tree_fd, FILE2, user1_uid, user1_gid,
-			      AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-		if (errno != EPERM)
-			die("failure: errno");
-
-		/* Verify that the ownership is still {g,u}id 1000. */
-		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW,
-				      user1_uid, user1_gid))
-			die("failure: check ownership");
-
-		/*
-		 * A user with fs{g,u}id 1001 must not be allowed to change
-		 * ownership of /target/file2 owned by {g,u}id 1000 in this
-		 * idmapped mount to {g,u}id 1001.
-		 */
-		if (!fchownat(open_tree_fd, FILE2, user2_uid, user2_gid,
-			      AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-		if (errno != EPERM)
-			die("failure: errno");
-
-		/* Verify that the ownership is still {g,u}id 1000. */
-		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW,
-				      user1_uid, user1_gid))
-			die("failure: check ownership");
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	pid = fork();
-	if (pid < 0) {
-		log_stderr("failure: fork");
-		goto out;
-	}
-	if (pid == 0) {
-		/* switch to {g,u}id 1000 */
-		if (!switch_resids(user1_uid, user1_gid))
-			die("failure: switch_resids");
-
-		/* drop all capabilities */
-		if (!caps_down())
-			die("failure: caps_down");
-
-		/*
-		 * The {g,u}id 0 is not mapped in this idmapped mount so this
-		 * needs to fail with EINVAL.
-		 */
-		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-		if (errno != EINVAL)
-			die("failure: errno");
-
-		/*
-		 * A user with fs{g,u}id 1000 must be allowed to change
-		 * ownership of /target/file2 owned by {g,u}id 1000 in this
-		 * idmapped mount to {g,u}id 1000.
-		 */
-		if (fchownat(open_tree_fd, FILE2, user1_uid, user1_gid,
-			     AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-
-		/* Verify that the ownership is still {g,u}id 1000. */
-		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW,
-				      user1_uid, user1_gid))
-			die("failure: check ownership");
-
-		/*
-		 * A user with fs{g,u}id 1000 must not be allowed to change
-		 * ownership of /target/file2 owned by {g,u}id 1000 in this
-		 * idmapped mount to {g,u}id 1001.
-		 */
-		if (!fchownat(open_tree_fd, FILE2, user2_uid, user2_gid,
-			      AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-		if (errno != EPERM)
-			die("failure: errno");
-
-		/* Verify that the ownership is still {g,u}id 1000. */
-		if (!expected_uid_gid(open_tree_fd, FILE2, AT_SYMLINK_NOFOLLOW,
-				      user1_uid, user1_gid))
-			die("failure: check ownership");
-
-		/*
-		 * A user with fs{g,u}id 1000 must not be allowed to change
-		 * ownership of /target/file1 owned by {g,u}id 1001 in this
-		 * idmapped mount to {g,u}id 1000.
-		 */
-		if (!fchownat(open_tree_fd, FILE1, user1_uid, user1_gid,
-			     AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-		if (errno != EPERM)
-			die("failure: errno");
-
-		/* Verify that the ownership is still {g,u}id 1001. */
-		if (!expected_uid_gid(open_tree_fd, FILE1, AT_SYMLINK_NOFOLLOW,
-				      user2_uid, user2_gid))
-			die("failure: check ownership");
-
-		/*
-		 * A user with fs{g,u}id 1000 must not be allowed to change
-		 * ownership of /target/file1 owned by {g,u}id 1001 in this
-		 * idmapped mount to {g,u}id 1001.
-		 */
-		if (!fchownat(open_tree_fd, FILE1, user2_uid, user2_gid,
-			      AT_SYMLINK_NOFOLLOW))
-			die("failure: change ownership");
-		if (errno != EPERM)
-			die("failure: errno");
-
-		/* Verify that the ownership is still {g,u}id 1001. */
-		if (!expected_uid_gid(open_tree_fd, FILE1, AT_SYMLINK_NOFOLLOW,
-				      user2_uid, user2_gid))
-			die("failure: check ownership");
-
-		exit(EXIT_SUCCESS);
-	}
-	if (wait_for_pid(pid))
-		goto out;
-
-	fret = 0;
-	log_debug("Ran test");
-out:
-	safe_close(attr.userns_fd);
-	safe_close(open_tree_fd);
-
-	list_for_each_safe(it_cur, &idmap, it_next) {
-		list_del(it_cur);
-		free(it_cur->elem);
-		free(it_cur);
-	}
-
-	return fret;
-}
-
 static void usage(void)
 {
 	fprintf(stderr, "Description:\n");
@@ -2941,7 +1702,7 @@ static void usage(void)
 	fprintf(stderr, "--fstype                            Filesystem type used in the tests\n");
 	fprintf(stderr, "--help                              Print help\n");
 	fprintf(stderr, "--mountpoint                        Mountpoint of device\n");
-	fprintf(stderr, "--idmapped-mounts-supported	     Test whether idmapped mounts are supported on this filesystem\n");
+	fprintf(stderr, "--idmapped-mounts-supported         Test whether idmapped mounts are supported on this filesystem\n");
 	fprintf(stderr, "--scratch-mountpoint                Mountpoint of scratch device used in the tests\n");
 	fprintf(stderr, "--scratch-device                    Scratch device used in the tests\n");
 	fprintf(stderr, "--test-core                         Run core idmapped mount testsuite\n");
@@ -2991,25 +1752,6 @@ static const struct test_suite s_basic = {
 	.nr_tests = ARRAY_SIZE(t_basic),
 };
 
-static const struct test_struct t_nested_userns[] = {
-	{ nested_userns,						true,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
-};
-
-static const struct test_suite s_nested_userns = {
-	.tests = t_nested_userns,
-	.nr_tests = ARRAY_SIZE(t_nested_userns),
-};
-
-/* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
-static const struct test_struct t_setattr_fix_968219708108[] = {
-	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
-};
-
-static const struct test_suite s_setattr_fix_968219708108 = {
-	.tests = t_setattr_fix_968219708108,
-	.nr_tests = ARRAY_SIZE(t_setattr_fix_968219708108),
-};
-
 static bool run_test(struct vfstest_info *info, const struct test_struct suite[], size_t suite_size)
 {
 	int i;
-- 
2.32.0

