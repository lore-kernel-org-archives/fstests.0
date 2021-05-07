Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A6FC43460
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BEA6145E
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbhEGPC3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 May 2021 11:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237738AbhEGPC2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 May 2021 11:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B36EA61456;
        Fri,  7 May 2021 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620399688;
        bh=W4khVUG85d2sD293ua0w1eeDpKGeo23VSPEkBx6kb40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNdOXNwMY8NbqC+rn5pcR3rXz71/RhsMrrhUegPXX+3NMluxis0j8qP7Qcaq72SSO
         9UI9gRpvAA09JNmzkCKObF1Xyeri8xGlRHA0Zxh3nOXveOKmBLDNp2zivy0t9ZVnHb
         UdXSmzs+1xLW5uR/b2fLWPUElLzJymi8hkJmo1XKbW6Obuqoa6EobNKIbBTPeBOh4I
         tHJK3LRrDu7TlCUPbXOs6tMcJ+VuHHLyL70KW4WVZWIFyLX/M5RlUFQzwMUlNuhKea
         POUIWn4wCeuSrbmLs9tzlkWSXT5mUXwroZ/X7i9kZgM6VdL/IR4J2PuIxVnBGaytJD
         PrR8mmWDhW1YA==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 7/7] generic/638: add nested user namespace tests
Date:   Fri,  7 May 2021 17:01:00 +0200
Message-Id: <20210507150100.968659-8-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210507150100.968659-1-brauner@kernel.org>
References: <20210507150100.968659-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=GT+xC3cjW7m9spm1WVAylfXL4euZnI473h/hwwMkbbg=; m=KE5UNaVLEjY70jsc2vomYECSKyXztqtToX0Kcei4m3Y=; p=eE8hLodqnRaJ2fY3Vpxkd822eVIPh1EjFvRWWL9xzTI=; g=bdbe3e78aca52e8eed634a9072a82176db45cb1c
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJVWGwAKCRCRxhvAZXjcojjtAQCKwcR 9XF0rXC/yGqqw5OT3mGOEA9nyOqMYW9QqML71zAD+IXONe+UBmISOmItF7NrEyFWut8/WXzWq1NfE Yb3ggwc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Test ownership and ownership changes in a complex user namespace
hierarchy.

Cc: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .gitignore                            |   1 +
 src/idmapped-mounts/Makefile          |   8 +-
 src/idmapped-mounts/idmapped-mounts.c | 715 ++++++++++++++++++++++++++
 src/idmapped-mounts/utils.h           |   4 +
 tests/generic/638                     |  42 ++
 tests/generic/638.out                 |   2 +
 tests/generic/group                   |   1 +
 7 files changed, 771 insertions(+), 2 deletions(-)
 create mode 100755 tests/generic/638
 create mode 100644 tests/generic/638.out

diff --git a/.gitignore b/.gitignore
index da48e6f8..713e4886 100644
--- a/.gitignore
+++ b/.gitignore
@@ -181,6 +181,7 @@
 /src/idmapped-mounts/idmapped-mounts
 /src/idmapped-mounts/mount-idmapped
 /src/idmapped-mounts/fscaps-in-ancestor-userns
+/src/idmapped-mounts/nested-userns
 /src/log-writes/replay-log
 /src/perf/*.pyc
 
diff --git a/src/idmapped-mounts/Makefile b/src/idmapped-mounts/Makefile
index 1bab6471..a205c830 100644
--- a/src/idmapped-mounts/Makefile
+++ b/src/idmapped-mounts/Makefile
@@ -4,7 +4,7 @@ TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
 BINS = idmapped-mounts mount-idmapped
-LINKS = fscaps-in-ancestor-userns
+LINKS = fscaps-in-ancestor-userns nested-userns
 TARGETS = $(BINS) $(LINKS)
 CFILES_IDMAPPED_MOUNTS = idmapped-mounts.c utils.c
 CFILES_MOUNT_IDMAPPED = mount-idmapped.c utils.c
@@ -34,6 +34,9 @@ idmapped-mounts: $(CFILES_IDMAPPED_MOUNTS)
 fscaps-in-ancestor-userns:
 	ln -sf idmapped-mounts fscaps-in-ancestor-userns
 
+nested-userns:
+	ln -sf idmapped-mounts nested-userns
+
 mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
 	@echo "    [CC]    $@"
 	$(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
@@ -43,6 +46,7 @@ install:
 	$(INSTALL) -m 755 $(BINS) $(PKG_LIB_DIR)/src/idmapped-mounts
 	cd $(PKG_LIB_DIR)/src/idmapped-mounts && \
 		rm -f $(LINKS) && \
-		$(LN_S) idmapped-mounts fscaps-in-ancestor-userns
+		$(LN_S) idmapped-mounts fscaps-in-ancestor-userns && \
+		$(LN_S) idmapped-mounts nested-userns
 
 -include .dep
diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index f5a48af7..2e456018 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8814,6 +8814,714 @@ out:
 	return fret;
 }
 
+static int nested_userns(void)
+{
+	int fret = -1;
+	int ret;
+	pid_t pid;
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
+	if (mkdirat(t_dir1_fd, DIR1, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out;
+	}
+
+	fd_dir1 = openat(t_dir1_fd, DIR1, O_DIRECTORY | O_CLOEXEC);
+	if (fd_dir1 < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	for (unsigned int id = 0; id <= id_file_range; id++) {
+		char file[256];
+
+		snprintf(file, sizeof(file), DIR1 "/" FILE1 "_%u", id);
+
+		if (mknodat(t_dir1_fd, file, S_IFREG | 0644, 0)) {
+			log_stderr("failure: create %s", file);
+			goto out;
+		}
+
+		if (fchownat(t_dir1_fd, file, id, id, AT_SYMLINK_NOFOLLOW)) {
+			log_stderr("failure: fchownat %s", file);
+			goto out;
+		}
+
+		if (!expected_uid_gid(t_dir1_fd, file, 0, id, id)) {
+			log_stderr("failure: check ownership %s", file);
+			goto out;
+		}
+	}
+
+	/* Create detached mounts for all the user namespaces. */
+	fd_open_tree_level1 = sys_open_tree(t_dir1_fd, DIR1,
+					    AT_NO_AUTOMOUNT |
+					    AT_SYMLINK_NOFOLLOW |
+					    OPEN_TREE_CLOEXEC |
+					    OPEN_TREE_CLONE);
+	if (fd_open_tree_level1 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	fd_open_tree_level2 = sys_open_tree(t_dir1_fd, DIR1,
+					    AT_NO_AUTOMOUNT |
+					    AT_SYMLINK_NOFOLLOW |
+					    OPEN_TREE_CLOEXEC |
+					    OPEN_TREE_CLONE);
+	if (fd_open_tree_level2 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	fd_open_tree_level3 = sys_open_tree(t_dir1_fd, DIR1,
+					    AT_NO_AUTOMOUNT |
+					    AT_SYMLINK_NOFOLLOW |
+					    OPEN_TREE_CLOEXEC |
+					    OPEN_TREE_CLONE);
+	if (fd_open_tree_level3 < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	fd_open_tree_level4 = sys_open_tree(t_dir1_fd, DIR1,
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
+	for (unsigned int id = 0; id <= id_file_range; id++) {
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
+			bret = expected_uid_gid(fd_open_tree_level3, file, 0, t_overflowuid, t_overflowgid);
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
+		if (!expected_uid_gid(fd_open_tree_level4, file, 0, t_overflowuid, t_overflowgid)) {
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
+		for (unsigned int id = 0; id <= id_file_range; id++) {
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
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, t_overflowuid, t_overflowgid);
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
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, t_overflowuid, t_overflowgid))
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
+		for (unsigned int id = 0; id <= id_file_range; id++) {
+			bool bret;
+			unsigned int id_level2, id_level3;
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, t_overflowuid, t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			id_level2 = id;
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
+				die("failure: check ownership %s", file);
+
+			if (id == 999) {
+				/* This id is unmapped. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, t_overflowuid, t_overflowgid);
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
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, t_overflowuid, t_overflowgid))
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
+		for (unsigned int id = 0; id <= id_file_range; id++) {
+			bool bret;
+			unsigned int id_level2, id_level3;
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, t_overflowuid, t_overflowgid))
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
+				bret = expected_uid_gid(fd_open_tree_level2, file, 0, t_overflowuid, t_overflowgid);
+			}
+			if (!bret)
+				die("failure: check ownership %s", file);
+
+
+			if (id == 999) {
+				/* This id is unmapped. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, t_overflowuid, t_overflowgid);
+			} else {
+				id_level3 = id; /* Rest is business as usual. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, id_level3, id_level3);
+			}
+			if (!bret)
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, t_overflowuid, t_overflowgid))
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
+		for (unsigned int id = 0; id <= id_file_range; id++) {
+			char file[256];
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, t_overflowuid, t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, t_overflowuid, t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level3, file, 0, t_overflowuid, t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, t_overflowuid, t_overflowgid))
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
+		for (unsigned int id = 0; id <= id_file_range; id++) {
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
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, t_overflowuid, t_overflowgid);
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
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, t_overflowuid, t_overflowgid))
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
+		for (unsigned int id = 0; id <= id_file_range; id++) {
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
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, t_overflowuid, t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			id_level2 = id_new;
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, id_level2, id_level2))
+				die("failure: check ownership %s", file);
+
+			if (id_new == 999) {
+				/* This id is unmapped. */
+				bret = expected_uid_gid(fd_open_tree_level3, file, 0, t_overflowuid, t_overflowgid);
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
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, t_overflowuid, t_overflowgid))
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
+		for (unsigned int id = 0; id <= id_file_range; id++) {
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
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, t_overflowuid, t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			/* There's no id 1000 anymore as we changed ownership for id 1000 to 1001 above. */
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, t_overflowuid, t_overflowgid))
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
+				if (!expected_uid_gid(fd_open_tree_level3, file, 0, t_overflowuid, t_overflowgid))
+					die("failure: check ownership %s", file);
+			} else {
+				if (!expected_uid_gid(fd_open_tree_level3, file, 0, id_new, id_new))
+					die("failure: check ownership %s", file);
+			}
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, t_overflowuid, t_overflowgid))
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
+		for (unsigned int id = 0; id <= id_file_range; id++) {
+			char file[256];
+			unsigned long id_new;
+
+			snprintf(file, sizeof(file), FILE1 "_%u", id);
+
+			id_new = id + 1;
+			if (!fchownat(fd_open_tree_level4, file, id_new, id_new, AT_SYMLINK_NOFOLLOW))
+				die("failure: fchownat %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level1, file, 0, t_overflowuid, t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level2, file, 0, t_overflowuid, t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level3, file, 0, t_overflowuid, t_overflowgid))
+				die("failure: check ownership %s", file);
+
+			if (!expected_uid_gid(fd_open_tree_level4, file, 0, t_overflowuid, t_overflowgid))
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
 static void usage(void)
 {
 	fprintf(stderr, "Description:\n");
@@ -8894,6 +9602,10 @@ struct t_idmapped_mounts fscaps_in_ancestor_userns[] = {
 	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
 };
 
+struct t_idmapped_mounts t_nested_userns[] = {
+	{ nested_userns,						"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
+};
+
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 {
 	int i;
@@ -9027,6 +9739,9 @@ int main(int argc, char *argv[])
 		if (!run_test(fscaps_in_ancestor_userns,
 			      ARRAY_SIZE(fscaps_in_ancestor_userns)))
 			goto out;
+	} else if (strcmp(invocation_name, "nested-userns") == 0) {
+		if (!run_test(t_nested_userns, ARRAY_SIZE(t_nested_userns)))
+			goto out;
 	} else {
 		die("idmapped mount test suite \"%s\" unknown", invocation_name);
 	}
diff --git a/src/idmapped-mounts/utils.h b/src/idmapped-mounts/utils.h
index 9694980e..afb3c228 100644
--- a/src/idmapped-mounts/utils.h
+++ b/src/idmapped-mounts/utils.h
@@ -77,6 +77,10 @@ struct userns_hierarchy {
 #define list_for_each(__iterator, __list) \
 	for (__iterator = (__list)->next; __iterator != __list; __iterator = __iterator->next)
 
+#define list_for_each_safe(__iterator, __list, __next)               \
+	for (__iterator = (__list)->next, __next = __iterator->next; \
+	     __iterator != __list; __iterator = __next, __next = __next->next)
+
 static inline void list_init(struct list *list)
 {
 	list->elem = NULL;
diff --git a/tests/generic/638 b/tests/generic/638
new file mode 100755
index 00000000..7653c7bd
--- /dev/null
+++ b/tests/generic/638
@@ -0,0 +1,42 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Christian Brauner.  All Rights Reserved.
+#
+# FS QA Test 638
+#
+# Test that idmapped mounts behave correctly with complex user namespaces.
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
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs generic
+_require_idmapped_mounts
+_require_test
+
+echo "Silence is golden"
+
+$here/src/idmapped-mounts/nested-userns --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
+
+status=$?
+exit
diff --git a/tests/generic/638.out b/tests/generic/638.out
new file mode 100644
index 00000000..3113b1e3
--- /dev/null
+++ b/tests/generic/638.out
@@ -0,0 +1,2 @@
+QA output created by 638
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 9dfefdf4..63bae9cc 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -640,3 +640,4 @@
 635 auto quick atime bigtime shutdown
 636 auto quick swap
 637 auto quick idmapped
+638 auto quick idmapped
-- 
2.27.0

