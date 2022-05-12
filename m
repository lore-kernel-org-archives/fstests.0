Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E6C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356713AbiELQx1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356717AbiELQx1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CC72689C2
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 161E6B82A02
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37C0C385B8;
        Thu, 12 May 2022 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374401;
        bh=m/v2wnlq6tC3G1d/H92XvIF1+USXvaIfRZdZXXr/aNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6lDhdF3ixaYnr5Fs3IOJzRkMmmf27I2Wo0nbJrKhvueQzXxSndswigHj42jEluIZ
         ldpnFiMZmS0YaS3w5WKYO1qan6wnZtKT7ahKIw6BJ4fXifNvMGvQ5R0YTOW9KSJHF7
         kavRntVDabnMtGtqKEtLDCqPG95g21HZXPTjT3H+S/vU97XtAgYDx4ckWnW/jYFLBT
         mQ2zh/MTqtsOWFOM28OOPoOic6KROpuCqUWWN5NQWFOh2IdSSejKGpYZcjdb8G98kj
         zcRuEqf3hEsee+sdxxPUKfcjkv0q4b38F3IkL9AFB/RQR/yziRvfeov2IT9pIKU+d1
         PMFLlzVbkTZCQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 07/13] utils: move helpers into utils
Date:   Thu, 12 May 2022 18:52:44 +0200
Message-Id: <20220512165250.450989-8-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=36984; h=from:subject; bh=m/v2wnlq6tC3G1d/H92XvIF1+USXvaIfRZdZXXr/aNY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWnvYK90+fnHv1s0zW6Jl9/VECUy8lTY/fAOXlvZGqenG kqu5O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiJcXIsCpvVdYl4ZJll99bae44f6 avrm/2pfbP6okHWz6cdxV4fZ7hD4dW0otowy8HwxTOJ+lz9sno18zKKdYPvlvgFB76q/oQJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In order to split the test suite into multiple source files we need to
be able to access generic helpers in all source files not just one. So
move all generic helpers into utils.{c,h}.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/utils.c   | 495 ++++++++++++++++++++++++++++++++++
 src/vfs/utils.h   | 196 ++++++++++++++
 src/vfs/vfstest.c | 659 ----------------------------------------------
 3 files changed, 691 insertions(+), 659 deletions(-)

diff --git a/src/vfs/utils.c b/src/vfs/utils.c
index faf06fcd..1634e5c8 100644
--- a/src/vfs/utils.c
+++ b/src/vfs/utils.c
@@ -9,12 +9,14 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/eventfd.h>
+#include <sys/fsuid.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/xattr.h>
 
 #include "utils.h"
 
@@ -423,3 +425,496 @@ int add_map_entry(struct list *head,
 	list_add_tail(head, new_list);
 	return 0;
 }
+
+/* __expected_uid_gid - check whether file is owned by the provided uid and gid */
+bool __expected_uid_gid(int dfd, const char *path, int flags,
+			uid_t expected_uid, gid_t expected_gid, bool log)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return log_errno(false, "failure: fstatat");
+
+	if (log && st.st_uid != expected_uid)
+		log_stderr("failure: uid(%d) != expected_uid(%d)", st.st_uid, expected_uid);
+
+	if (log && st.st_gid != expected_gid)
+		log_stderr("failure: gid(%d) != expected_gid(%d)", st.st_gid, expected_gid);
+
+	errno = 0; /* Don't report misleading errno. */
+	return st.st_uid == expected_uid && st.st_gid == expected_gid;
+}
+
+/* caps_down - lower all effective caps */
+int caps_down(void)
+{
+	bool fret = false;
+#ifdef HAVE_SYS_CAPABILITY_H
+	cap_t caps = NULL;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	ret = cap_clear_flag(caps, CAP_EFFECTIVE);
+	if (ret)
+		goto out;
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+
+out:
+	cap_free(caps);
+#endif
+	return fret;
+}
+
+/* caps_down_fsetid - lower CAP_FSETID effective cap */
+int caps_down_fsetid(void)
+{
+	bool fret = false;
+#ifdef HAVE_SYS_CAPABILITY_H
+	cap_t caps = NULL;
+	cap_value_t cap = CAP_FSETID;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, 0);
+	if (ret)
+		goto out;
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+
+out:
+	cap_free(caps);
+#endif
+	return fret;
+}
+
+#ifdef HAVE_LIBURING_H
+int io_uring_openat_with_creds(struct io_uring *ring, int dfd, const char *path,
+			       int cred_id, bool with_link, int *ret_cqe)
+{
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe;
+	int ret, i, to_submit = 1;
+
+	if (with_link) {
+		sqe = io_uring_get_sqe(ring);
+		if (!sqe)
+			return log_error_errno(-EINVAL, EINVAL, "failure: io_uring_sqe");
+		io_uring_prep_nop(sqe);
+		sqe->flags |= IOSQE_IO_LINK;
+		sqe->user_data = 1;
+		to_submit++;
+	}
+
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe)
+		return log_error_errno(-EINVAL, EINVAL, "failure: io_uring_sqe");
+	io_uring_prep_openat(sqe, dfd, path, O_RDONLY | O_CLOEXEC, 0);
+	sqe->user_data = 2;
+
+	if (cred_id != -1)
+		sqe->personality = cred_id;
+
+	ret = io_uring_submit(ring);
+	if (ret != to_submit) {
+		log_stderr("failure: io_uring_submit");
+		goto out;
+	}
+
+	for (i = 0; i < to_submit; i++) {
+		ret = io_uring_wait_cqe(ring, &cqe);
+		if (ret < 0) {
+			log_stderr("failure: io_uring_wait_cqe");
+			goto out;
+		}
+
+		ret = cqe->res;
+		/*
+		 * Make sure caller can identify that this is a proper io_uring
+		 * failure and not some earlier error.
+		 */
+		if (ret_cqe)
+			*ret_cqe = ret;
+		io_uring_cqe_seen(ring, cqe);
+	}
+	log_debug("Ran test");
+out:
+	return ret;
+}
+#endif /* HAVE_LIBURING_H */
+
+/* caps_up - raise all permitted caps */
+int caps_up(void)
+{
+	bool fret = false;
+#ifdef HAVE_SYS_CAPABILITY_H
+	cap_t caps = NULL;
+	cap_value_t cap;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	for (cap = 0; cap <= CAP_LAST_CAP; cap++) {
+		cap_flag_value_t flag;
+
+		ret = cap_get_flag(caps, cap, CAP_PERMITTED, &flag);
+		if (ret) {
+			if (errno == EINVAL)
+				break;
+			else
+				goto out;
+		}
+
+		ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, flag);
+		if (ret)
+			goto out;
+	}
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+out:
+	cap_free(caps);
+#endif
+	return fret;
+}
+
+/* chown_r - recursively change ownership of all files */
+int chown_r(int fd, const char *path, uid_t uid, gid_t gid)
+{
+	int dfd, ret;
+	DIR *dir;
+	struct dirent *direntp;
+
+	dfd = openat(fd, path, O_CLOEXEC | O_DIRECTORY);
+	if (dfd < 0)
+		return -1;
+
+	dir = fdopendir(dfd);
+	if (!dir) {
+		close(dfd);
+		return -1;
+	}
+
+	while ((direntp = readdir(dir))) {
+		struct stat st;
+
+		if (!strcmp(direntp->d_name, ".") ||
+		    !strcmp(direntp->d_name, ".."))
+			continue;
+
+		ret = fstatat(dfd, direntp->d_name, &st, AT_SYMLINK_NOFOLLOW);
+		if (ret < 0 && errno != ENOENT)
+			break;
+
+		if (S_ISDIR(st.st_mode))
+			ret = chown_r(dfd, direntp->d_name, uid, gid);
+		else
+			ret = fchownat(dfd, direntp->d_name, uid, gid, AT_SYMLINK_NOFOLLOW);
+		if (ret < 0 && errno != ENOENT)
+			break;
+	}
+
+	ret = fchownat(fd, path, uid, gid, AT_SYMLINK_NOFOLLOW);
+	closedir(dir);
+	return ret;
+}
+
+/* expected_dummy_vfs_caps_uid - check vfs caps are stored with the provided uid */
+bool expected_dummy_vfs_caps_uid(int fd, uid_t expected_uid)
+{
+#define __cap_raised_permitted(x, ns_cap_data)                                 \
+	((ns_cap_data.data[(x) >> 5].permitted) & (1 << ((x)&31)))
+	struct vfs_ns_cap_data ns_xattr = {};
+	ssize_t ret;
+
+	ret = fgetxattr(fd, "security.capability", &ns_xattr, sizeof(ns_xattr));
+	if (ret < 0 || ret == 0)
+		return false;
+
+	if (ns_xattr.magic_etc & VFS_CAP_REVISION_3) {
+
+		if (le32_to_cpu(ns_xattr.rootid) != expected_uid) {
+			errno = EINVAL;
+			log_stderr("failure: rootid(%d) != expected_rootid(%d)", le32_to_cpu(ns_xattr.rootid), expected_uid);
+		}
+
+		return (le32_to_cpu(ns_xattr.rootid) == expected_uid) &&
+		       (__cap_raised_permitted(CAP_NET_RAW, ns_xattr) > 0);
+	} else {
+		log_stderr("failure: fscaps version");
+	}
+
+	return false;
+}
+
+/* set_dummy_vfs_caps - set dummy vfs caps for the provided uid */
+int set_dummy_vfs_caps(int fd, int flags, int rootuid)
+{
+#define __raise_cap_permitted(x, ns_cap_data)                                  \
+	ns_cap_data.data[(x) >> 5].permitted |= (1 << ((x)&31))
+
+	struct vfs_ns_cap_data ns_xattr;
+
+	memset(&ns_xattr, 0, sizeof(ns_xattr));
+	__raise_cap_permitted(CAP_NET_RAW, ns_xattr);
+	ns_xattr.magic_etc |= VFS_CAP_REVISION_3 | VFS_CAP_FLAGS_EFFECTIVE;
+	ns_xattr.rootid = cpu_to_le32(rootuid);
+
+	return fsetxattr(fd, "security.capability",
+			 &ns_xattr, sizeof(ns_xattr), flags);
+}
+
+bool protected_symlinks_enabled(void)
+{
+	static int enabled = -1;
+
+	if (enabled == -1) {
+		int fd;
+		ssize_t ret;
+		char buf[256];
+
+		enabled = 0;
+
+		fd = open("/proc/sys/fs/protected_symlinks", O_RDONLY | O_CLOEXEC);
+		if (fd < 0)
+			return false;
+
+		ret = read(fd, buf, sizeof(buf));
+		close(fd);
+		if (ret < 0)
+			return false;
+
+		if (atoi(buf) >= 1)
+			enabled = 1;
+        }
+
+	return enabled == 1;
+}
+
+static bool is_xfs(const char *fstype)
+{
+	static int enabled = -1;
+
+	if (enabled == -1)
+		enabled = !strcmp(fstype, "xfs");
+
+	return enabled;
+}
+
+bool xfs_irix_sgid_inherit_enabled(const char *fstype)
+{
+	static int enabled = -1;
+
+	if (enabled == -1) {
+		int fd;
+		ssize_t ret;
+		char buf[256];
+
+		enabled = 0;
+
+		if (is_xfs(fstype)) {
+			fd = open("/proc/sys/fs/xfs/irix_sgid_inherit", O_RDONLY | O_CLOEXEC);
+			if (fd < 0)
+				return false;
+
+			ret = read(fd, buf, sizeof(buf));
+			close(fd);
+			if (ret < 0)
+				return false;
+
+			if (atoi(buf) >= 1)
+				enabled = 1;
+		}
+        }
+
+	return enabled == 1;
+}
+
+bool expected_file_size(int dfd, const char *path, int flags, off_t expected_size)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return log_errno(false, "failure: fstatat");
+
+	if (st.st_size != expected_size)
+		return log_errno(false, "failure: st_size(%zu) != expected_size(%zu)",
+				 (size_t)st.st_size, (size_t)expected_size);
+
+	return true;
+}
+
+/* is_setid - check whether file is S_ISUID and S_ISGID */
+bool is_setid(int dfd, const char *path, int flags)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	errno = 0; /* Don't report misleading errno. */
+	return (st.st_mode & S_ISUID) || (st.st_mode & S_ISGID);
+}
+
+/* is_setgid - check whether file or directory is S_ISGID */
+bool is_setgid(int dfd, const char *path, int flags)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	errno = 0; /* Don't report misleading errno. */
+	return (st.st_mode & S_ISGID);
+}
+
+/* is_sticky - check whether file is S_ISVTX */
+bool is_sticky(int dfd, const char *path, int flags)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	errno = 0; /* Don't report misleading errno. */
+	return (st.st_mode & S_ISVTX) > 0;
+}
+
+bool switch_resids(uid_t uid, gid_t gid)
+{
+	if (setresgid(gid, gid, gid))
+		return log_errno(false, "failure: setregid");
+
+	if (setresuid(uid, uid, uid))
+		return log_errno(false, "failure: setresuid");
+
+	if (setfsgid(-1) != gid)
+		return log_errno(false, "failure: setfsgid(-1)");
+
+	if (setfsuid(-1) != uid)
+		return log_errno(false, "failure: setfsuid(-1)");
+
+	return true;
+}
+
+/* rm_r - recursively remove all files */
+int rm_r(int fd, const char *path)
+{
+	int dfd, ret;
+	DIR *dir;
+	struct dirent *direntp;
+
+	if (!path || strcmp(path, "") == 0)
+		return -1;
+
+	dfd = openat(fd, path, O_CLOEXEC | O_DIRECTORY);
+	if (dfd < 0)
+		return -1;
+
+	dir = fdopendir(dfd);
+	if (!dir) {
+		close(dfd);
+		return -1;
+	}
+
+	while ((direntp = readdir(dir))) {
+		struct stat st;
+
+		if (!strcmp(direntp->d_name, ".") ||
+		    !strcmp(direntp->d_name, ".."))
+			continue;
+
+		ret = fstatat(dfd, direntp->d_name, &st, AT_SYMLINK_NOFOLLOW);
+		if (ret < 0 && errno != ENOENT)
+			break;
+
+		if (S_ISDIR(st.st_mode))
+			ret = rm_r(dfd, direntp->d_name);
+		else
+			ret = unlinkat(dfd, direntp->d_name, 0);
+		if (ret < 0 && errno != ENOENT)
+			break;
+	}
+
+	ret = unlinkat(fd, path, AT_REMOVEDIR);
+	closedir(dir);
+	return ret;
+}
+
+/* fd_to_fd - transfer data from one fd to another */
+int fd_to_fd(int from, int to)
+{
+	for (;;) {
+		uint8_t buf[PATH_MAX];
+		uint8_t *p = buf;
+		ssize_t bytes_to_write;
+		ssize_t bytes_read;
+
+		bytes_read = read_nointr(from, buf, sizeof buf);
+		if (bytes_read < 0)
+			return -1;
+		if (bytes_read == 0)
+			break;
+
+		bytes_to_write = (size_t)bytes_read;
+		do {
+			ssize_t bytes_written;
+
+			bytes_written = write_nointr(to, p, bytes_to_write);
+			if (bytes_written < 0)
+				return -1;
+
+			bytes_to_write -= bytes_written;
+			p += bytes_written;
+		} while (bytes_to_write > 0);
+	}
+
+	return 0;
+}
+
+bool openat_tmpfile_supported(int dirfd)
+{
+	int fd = -1;
+
+	fd = openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+	if (fd == -1) {
+		if (errno == ENOTSUP)
+			return false;
+		else
+			return log_errno(false, "failure: create");
+	}
+
+	if (close(fd))
+		log_stderr("failure: close");
+
+	return true;
+}
diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index 54947ec7..d8ec3c5e 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -17,15 +17,41 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
+#include <sys/fsuid.h>
 #include <sys/types.h>
 #include <unistd.h>
 
+#ifdef HAVE_SYS_CAPABILITY_H
+#include <sys/capability.h>
+#endif
+
+#ifdef HAVE_LIBURING_H
+#include <liburing.h>
+#endif
+
 #include "missing.h"
 
 /* Flags for which functionality is required by the test */
 #define T_REQUIRE_IDMAPPED_MOUNTS (1U << 0)
 #define T_REQUIRE_USERNS (1U << 1)
 
+#define T_DIR1 "idmapped_mounts_1"
+#define FILE1 "file1"
+#define FILE1_RENAME "file1_rename"
+#define FILE2 "file2"
+#define FILE3 "file3"
+#define FILE2_RENAME "file2_rename"
+#define DIR1 "dir1"
+#define DIR2 "dir2"
+#define DIR3 "dir3"
+#define DIR1_RENAME "dir1_rename"
+#define HARDLINK1 "hardlink1"
+#define SYMLINK1 "symlink1"
+#define SYMLINK_USER1 "symlink_user1"
+#define SYMLINK_USER2 "symlink_user2"
+#define SYMLINK_USER3 "symlink_user3"
+#define CHRDEV1 "chrdev1"
+
 /* Maximum number of nested user namespaces in the kernel. */
 #define MAX_USERNS_LEVEL 32
 
@@ -41,6 +67,37 @@
 			      ? 10          \
 			      : sizeof(type) <= 8 ? 20 : sizeof(int[-2 * (sizeof(type) > 8)])))
 
+#define log_stderr(format, ...)                                                         \
+	fprintf(stderr, "%s: %d: %s - %m - " format "\n", __FILE__, __LINE__, __func__, \
+		##__VA_ARGS__)
+
+#ifdef DEBUG_TRACE
+#define log_debug(format, ...)                                           \
+	fprintf(stderr, "%s: %d: %s - " format "\n", __FILE__, __LINE__, \
+		__func__, ##__VA_ARGS__)
+#else
+#define log_debug(format, ...)
+#endif
+
+#define log_error_errno(__ret__, __errno__, format, ...)      \
+	({                                                    \
+		typeof(__ret__) __internal_ret__ = (__ret__); \
+		errno = (__errno__);                          \
+		log_stderr(format, ##__VA_ARGS__);            \
+		__internal_ret__;                             \
+	})
+
+#define log_errno(__ret__, format, ...) log_error_errno(__ret__, errno, format, ##__VA_ARGS__)
+
+#define die_errno(__errno__, format, ...)          \
+	({                                         \
+		errno = (__errno__);               \
+		log_stderr(format, ##__VA_ARGS__); \
+		exit(EXIT_FAILURE);                \
+	})
+
+#define die(format, ...) die_errno(errno, format, ##__VA_ARGS__)
+
 #define syserror(format, ...)                           \
 	({                                              \
 		fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__); \
@@ -55,6 +112,68 @@
 		__internal_ret__;                             \
 	})
 
+#define safe_close(fd)      \
+	if (fd >= 0) {           \
+		int _e_ = errno; \
+		close(fd);       \
+		errno = _e_;     \
+		fd = -EBADF;     \
+	}
+
+#define ARRAY_SIZE(A) (sizeof(A) / sizeof((A)[0]))
+
+#ifndef CAP_NET_RAW
+#define CAP_NET_RAW 13
+#endif
+
+#ifndef VFS_CAP_FLAGS_EFFECTIVE
+#define VFS_CAP_FLAGS_EFFECTIVE 0x000001
+#endif
+
+#ifndef VFS_CAP_U32_3
+#define VFS_CAP_U32_3 2
+#endif
+
+#ifndef VFS_CAP_U32
+#define VFS_CAP_U32 VFS_CAP_U32_3
+#endif
+
+#ifndef VFS_CAP_REVISION_1
+#define VFS_CAP_REVISION_1 0x01000000
+#endif
+
+#ifndef VFS_CAP_REVISION_2
+#define VFS_CAP_REVISION_2 0x02000000
+#endif
+
+#ifndef VFS_CAP_REVISION_3
+#define VFS_CAP_REVISION_3 0x03000000
+struct vfs_ns_cap_data {
+	__le32 magic_etc;
+	struct {
+		__le32 permitted;
+		__le32 inheritable;
+	} data[VFS_CAP_U32];
+	__le32 rootid;
+};
+#endif
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+#define cpu_to_le16(w16) le16_to_cpu(w16)
+#define le16_to_cpu(w16) ((u_int16_t)((u_int16_t)(w16) >> 8) | (u_int16_t)((u_int16_t)(w16) << 8))
+#define cpu_to_le32(w32) le32_to_cpu(w32)
+#define le32_to_cpu(w32)                                                                       \
+	((u_int32_t)((u_int32_t)(w32) >> 24) | (u_int32_t)(((u_int32_t)(w32) >> 8) & 0xFF00) | \
+	 (u_int32_t)(((u_int32_t)(w32) << 8) & 0xFF0000) | (u_int32_t)((u_int32_t)(w32) << 24))
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+#define cpu_to_le16(w16) ((u_int16_t)(w16))
+#define le16_to_cpu(w16) ((u_int16_t)(w16))
+#define cpu_to_le32(w32) ((u_int32_t)(w32))
+#define le32_to_cpu(w32) ((u_int32_t)(w32))
+#else
+#error Expected endianess macro to be set
+#endif
+
 struct vfstest_info {
 	uid_t t_overflowuid;
 	gid_t t_overflowgid;
@@ -159,9 +278,86 @@ extern int get_userns_fd_from_idmap(struct list *idmap);
 extern ssize_t read_nointr(int fd, void *buf, size_t count);
 extern int wait_for_pid(pid_t pid);
 extern ssize_t write_nointr(int fd, const void *buf, size_t count);
+
+extern int caps_down(void);
+extern int caps_down_fsetid(void);
+extern int caps_up(void);
+static inline bool caps_supported(void)
+{
+	bool ret = false;
+
+#ifdef HAVE_SYS_CAPABILITY_H
+	ret = true;
+#endif
+
+	return ret;
+}
+extern bool expected_dummy_vfs_caps_uid(int fd, uid_t expected_uid);
+extern int set_dummy_vfs_caps(int fd, int flags, int rootuid);
+
 extern bool switch_ids(uid_t uid, gid_t gid);
+
 extern int create_userns_hierarchy(struct userns_hierarchy *h);
 extern int add_map_entry(struct list *head, __u32 id_host, __u32 id_ns,
 			 __u32 range, idmap_type_t map_type);
 
+extern bool __expected_uid_gid(int dfd, const char *path, int flags,
+			       uid_t expected_uid, gid_t expected_gid, bool log);
+static inline bool expected_uid_gid(int dfd, const char *path, int flags,
+				    uid_t expected_uid, gid_t expected_gid)
+{
+	return __expected_uid_gid(dfd, path, flags, expected_uid, expected_gid, true);
+}
+
+static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
+{
+	if (setns(fd, CLONE_NEWUSER))
+		return log_errno(false, "failure: setns");
+
+	if (!switch_ids(uid, gid))
+		return log_errno(false, "failure: switch_ids");
+
+	if (drop_caps && !caps_down())
+		return log_errno(false, "failure: caps_down");
+
+	return true;
+}
+
+extern bool switch_resids(uid_t uid, gid_t gid);
+
+static inline bool switch_fsids(uid_t fsuid, gid_t fsgid)
+{
+	if (setfsgid(fsgid))
+		return log_errno(false, "failure: setfsgid");
+
+	if (setfsgid(-1) != fsgid)
+		return log_errno(false, "failure: setfsgid(-1)");
+
+	if (setfsuid(fsuid))
+		return log_errno(false, "failure: setfsuid");
+
+	if (setfsuid(-1) != fsuid)
+		return log_errno(false, "failure: setfsuid(-1)");
+
+	return true;
+}
+
+#ifdef HAVE_LIBURING_H
+extern int io_uring_openat_with_creds(struct io_uring *ring, int dfd,
+				      const char *path, int cred_id,
+				      bool with_link, int *ret_cqe);
+#endif /* HAVE_LIBURING_H */
+
+extern int chown_r(int fd, const char *path, uid_t uid, gid_t gid);
+extern int rm_r(int fd, const char *path);
+extern int fd_to_fd(int from, int to);
+extern bool protected_symlinks_enabled(void);
+extern bool xfs_irix_sgid_inherit_enabled(const char *fstype);
+extern bool expected_file_size(int dfd, const char *path, int flags,
+			       off_t expected_size);
+extern bool is_setid(int dfd, const char *path, int flags);
+extern bool is_setgid(int dfd, const char *path, int flags);
+extern bool is_sticky(int dfd, const char *path, int flags);
+extern bool openat_tmpfile_supported(int dirfd);
+
 #endif /* __IDMAP_UTILS_H */
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index 86b79499..8a68565c 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -35,67 +35,9 @@
 #include <linux/btrfs_tree.h>
 #endif
 
-#ifdef HAVE_SYS_CAPABILITY_H
-#include <sys/capability.h>
-#endif
-
-#ifdef HAVE_LIBURING_H
-#include <liburing.h>
-#endif
-
 #include "missing.h"
 #include "utils.h"
 
-#define T_DIR1 "idmapped_mounts_1"
-#define FILE1 "file1"
-#define FILE1_RENAME "file1_rename"
-#define FILE2 "file2"
-#define FILE2_RENAME "file2_rename"
-#define FILE3 "file3"
-#define DIR1 "dir1"
-#define DIR2 "dir2"
-#define DIR3 "dir3"
-#define DIR1_RENAME "dir1_rename"
-#define HARDLINK1 "hardlink1"
-#define SYMLINK1 "symlink1"
-#define SYMLINK_USER1 "symlink_user1"
-#define SYMLINK_USER2 "symlink_user2"
-#define SYMLINK_USER3 "symlink_user3"
-#define CHRDEV1 "chrdev1"
-
-#define log_stderr(format, ...)                                                         \
-	fprintf(stderr, "%s: %d: %s - %m - " format "\n", __FILE__, __LINE__, __func__, \
-		##__VA_ARGS__)
-
-#ifdef DEBUG_TRACE
-#define log_debug(format, ...)                                           \
-	fprintf(stderr, "%s: %d: %s - " format "\n", __FILE__, __LINE__, \
-		__func__, ##__VA_ARGS__)
-#else
-#define log_debug(format, ...)
-#endif
-
-#define log_error_errno(__ret__, __errno__, format, ...)      \
-	({                                                    \
-		typeof(__ret__) __internal_ret__ = (__ret__); \
-		errno = (__errno__);                          \
-		log_stderr(format, ##__VA_ARGS__);            \
-		__internal_ret__;                             \
-	})
-
-#define log_errno(__ret__, format, ...) log_error_errno(__ret__, errno, format, ##__VA_ARGS__)
-
-#define die_errno(__errno__, format, ...)          \
-	({                                         \
-		errno = (__errno__);               \
-		log_stderr(format, ##__VA_ARGS__); \
-		exit(EXIT_FAILURE);                \
-	})
-
-#define die(format, ...) die_errno(errno, format, ##__VA_ARGS__)
-
-#define ARRAY_SIZE(A) (sizeof(A) / sizeof((A)[0]))
-
 static char t_buf[PATH_MAX];
 
 static void init_vfstest_info(struct vfstest_info *info)
@@ -149,418 +91,6 @@ static void stash_overflowgid(struct vfstest_info *info)
 	info->t_overflowgid = atoi(buf);
 }
 
-static bool is_xfs(const char *fstype)
-{
-	static int enabled = -1;
-
-	if (enabled == -1)
-		enabled = !strcmp(fstype, "xfs");
-
-	return enabled;
-}
-
-static bool protected_symlinks_enabled(void)
-{
-	static int enabled = -1;
-
-	if (enabled == -1) {
-		int fd;
-		ssize_t ret;
-		char buf[256];
-
-		enabled = 0;
-
-		fd = open("/proc/sys/fs/protected_symlinks", O_RDONLY | O_CLOEXEC);
-		if (fd < 0)
-			return false;
-
-		ret = read(fd, buf, sizeof(buf));
-		close(fd);
-		if (ret < 0)
-			return false;
-
-		if (atoi(buf) >= 1)
-			enabled = 1;
-        }
-
-	return enabled == 1;
-}
-
-static bool xfs_irix_sgid_inherit_enabled(const char *fstype)
-{
-	static int enabled = -1;
-
-	if (enabled == -1) {
-		int fd;
-		ssize_t ret;
-		char buf[256];
-
-		enabled = 0;
-
-		if (is_xfs(fstype)) {
-			fd = open("/proc/sys/fs/xfs/irix_sgid_inherit", O_RDONLY | O_CLOEXEC);
-			if (fd < 0)
-				return false;
-
-			ret = read(fd, buf, sizeof(buf));
-			close(fd);
-			if (ret < 0)
-				return false;
-
-			if (atoi(buf) >= 1)
-				enabled = 1;
-		}
-        }
-
-	return enabled == 1;
-}
-
-static inline bool caps_supported(void)
-{
-	bool ret = false;
-
-#ifdef HAVE_SYS_CAPABILITY_H
-	ret = true;
-#endif
-
-	return ret;
-}
-
-/* caps_down_fsetid - lower CAP_FSETID effective cap */
-static int caps_down_fsetid(void)
-{
-	bool fret = false;
-#ifdef HAVE_SYS_CAPABILITY_H
-	cap_t caps = NULL;
-	cap_value_t cap = CAP_FSETID;
-	int ret = -1;
-
-	caps = cap_get_proc();
-	if (!caps)
-		goto out;
-
-	ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, 0);
-	if (ret)
-		goto out;
-
-	ret = cap_set_proc(caps);
-	if (ret)
-		goto out;
-
-	fret = true;
-
-out:
-	cap_free(caps);
-#endif
-	return fret;
-}
-
-/* caps_down - lower all effective caps */
-static int caps_down(void)
-{
-	bool fret = false;
-#ifdef HAVE_SYS_CAPABILITY_H
-	cap_t caps = NULL;
-	int ret = -1;
-
-	caps = cap_get_proc();
-	if (!caps)
-		goto out;
-
-	ret = cap_clear_flag(caps, CAP_EFFECTIVE);
-	if (ret)
-		goto out;
-
-	ret = cap_set_proc(caps);
-	if (ret)
-		goto out;
-
-	fret = true;
-
-out:
-	cap_free(caps);
-#endif
-	return fret;
-}
-
-/* caps_up - raise all permitted caps */
-static int caps_up(void)
-{
-	bool fret = false;
-#ifdef HAVE_SYS_CAPABILITY_H
-	cap_t caps = NULL;
-	cap_value_t cap;
-	int ret = -1;
-
-	caps = cap_get_proc();
-	if (!caps)
-		goto out;
-
-	for (cap = 0; cap <= CAP_LAST_CAP; cap++) {
-		cap_flag_value_t flag;
-
-		ret = cap_get_flag(caps, cap, CAP_PERMITTED, &flag);
-		if (ret) {
-			if (errno == EINVAL)
-				break;
-			else
-				goto out;
-		}
-
-		ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, flag);
-		if (ret)
-			goto out;
-	}
-
-	ret = cap_set_proc(caps);
-	if (ret)
-		goto out;
-
-	fret = true;
-out:
-	cap_free(caps);
-#endif
-	return fret;
-}
-
-static bool openat_tmpfile_supported(int dirfd)
-{
-	int fd = -1;
-
-	fd = openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
-	if (fd == -1) {
-		if (errno == ENOTSUP)
-			return false;
-		else
-			return log_errno(false, "failure: create");
-	}
-
-	if (close(fd))
-		log_stderr("failure: close");
-
-	return true;
-}
-
-/* __expected_uid_gid - check whether file is owned by the provided uid and gid */
-static bool __expected_uid_gid(int dfd, const char *path, int flags,
-			       uid_t expected_uid, gid_t expected_gid, bool log)
-{
-	int ret;
-	struct stat st;
-
-	ret = fstatat(dfd, path, &st, flags);
-	if (ret < 0)
-		return log_errno(false, "failure: fstatat");
-
-	if (log && st.st_uid != expected_uid)
-		log_stderr("failure: uid(%d) != expected_uid(%d)", st.st_uid, expected_uid);
-
-	if (log && st.st_gid != expected_gid)
-		log_stderr("failure: gid(%d) != expected_gid(%d)", st.st_gid, expected_gid);
-
-	errno = 0; /* Don't report misleading errno. */
-	return st.st_uid == expected_uid && st.st_gid == expected_gid;
-}
-
-static bool expected_uid_gid(int dfd, const char *path, int flags,
-			     uid_t expected_uid, gid_t expected_gid)
-{
-	return __expected_uid_gid(dfd, path, flags,
-				  expected_uid, expected_gid, true);
-}
-
-static bool expected_file_size(int dfd, const char *path,
-			       int flags, off_t expected_size)
-{
-	int ret;
-	struct stat st;
-
-	ret = fstatat(dfd, path, &st, flags);
-	if (ret < 0)
-		return log_errno(false, "failure: fstatat");
-
-	if (st.st_size != expected_size)
-		return log_errno(false, "failure: st_size(%zu) != expected_size(%zu)",
-				 (size_t)st.st_size, (size_t)expected_size);
-
-	return true;
-}
-
-/* is_setid - check whether file is S_ISUID and S_ISGID */
-static bool is_setid(int dfd, const char *path, int flags)
-{
-	int ret;
-	struct stat st;
-
-	ret = fstatat(dfd, path, &st, flags);
-	if (ret < 0)
-		return false;
-
-	errno = 0; /* Don't report misleading errno. */
-	return (st.st_mode & S_ISUID) || (st.st_mode & S_ISGID);
-}
-
-/* is_setgid - check whether file or directory is S_ISGID */
-static bool is_setgid(int dfd, const char *path, int flags)
-{
-	int ret;
-	struct stat st;
-
-	ret = fstatat(dfd, path, &st, flags);
-	if (ret < 0)
-		return false;
-
-	errno = 0; /* Don't report misleading errno. */
-	return (st.st_mode & S_ISGID);
-}
-
-/* is_sticky - check whether file is S_ISVTX */
-static bool is_sticky(int dfd, const char *path, int flags)
-{
-	int ret;
-	struct stat st;
-
-	ret = fstatat(dfd, path, &st, flags);
-	if (ret < 0)
-		return false;
-
-	errno = 0; /* Don't report misleading errno. */
-	return (st.st_mode & S_ISVTX) > 0;
-}
-
-static inline bool switch_fsids(uid_t fsuid, gid_t fsgid)
-{
-	if (setfsgid(fsgid))
-		return log_errno(false, "failure: setfsgid");
-
-	if (setfsgid(-1) != fsgid)
-		return log_errno(false, "failure: setfsgid(-1)");
-
-	if (setfsuid(fsuid))
-		return log_errno(false, "failure: setfsuid");
-
-	if (setfsuid(-1) != fsuid)
-		return log_errno(false, "failure: setfsuid(-1)");
-
-	return true;
-}
-
-static inline bool switch_resids(uid_t uid, gid_t gid)
-{
-	if (setresgid(gid, gid, gid))
-		return log_errno(false, "failure: setregid");
-
-	if (setresuid(uid, uid, uid))
-		return log_errno(false, "failure: setresuid");
-
-	if (setfsgid(-1) != gid)
-		return log_errno(false, "failure: setfsgid(-1)");
-
-	if (setfsuid(-1) != uid)
-		return log_errno(false, "failure: setfsuid(-1)");
-
-	return true;
-}
-
-static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
-{
-	if (setns(fd, CLONE_NEWUSER))
-		return log_errno(false, "failure: setns");
-
-	if (!switch_ids(uid, gid))
-		return log_errno(false, "failure: switch_ids");
-
-	if (drop_caps && !caps_down())
-		return log_errno(false, "failure: caps_down");
-
-	return true;
-}
-
-/* rm_r - recursively remove all files */
-static int rm_r(int fd, const char *path)
-{
-	int dfd, ret;
-	DIR *dir;
-	struct dirent *direntp;
-
-	if (!path || strcmp(path, "") == 0)
-		return -1;
-
-	dfd = openat(fd, path, O_CLOEXEC | O_DIRECTORY);
-	if (dfd < 0)
-		return -1;
-
-	dir = fdopendir(dfd);
-	if (!dir) {
-		close(dfd);
-		return -1;
-	}
-
-	while ((direntp = readdir(dir))) {
-		struct stat st;
-
-		if (!strcmp(direntp->d_name, ".") ||
-		    !strcmp(direntp->d_name, ".."))
-			continue;
-
-		ret = fstatat(dfd, direntp->d_name, &st, AT_SYMLINK_NOFOLLOW);
-		if (ret < 0 && errno != ENOENT)
-			break;
-
-		if (S_ISDIR(st.st_mode))
-			ret = rm_r(dfd, direntp->d_name);
-		else
-			ret = unlinkat(dfd, direntp->d_name, 0);
-		if (ret < 0 && errno != ENOENT)
-			break;
-	}
-
-	ret = unlinkat(fd, path, AT_REMOVEDIR);
-	closedir(dir);
-	return ret;
-}
-
-/* chown_r - recursively change ownership of all files */
-static int chown_r(int fd, const char *path, uid_t uid, gid_t gid)
-{
-	int dfd, ret;
-	DIR *dir;
-	struct dirent *direntp;
-
-	dfd = openat(fd, path, O_CLOEXEC | O_DIRECTORY);
-	if (dfd < 0)
-		return -1;
-
-	dir = fdopendir(dfd);
-	if (!dir) {
-		close(dfd);
-		return -1;
-	}
-
-	while ((direntp = readdir(dir))) {
-		struct stat st;
-
-		if (!strcmp(direntp->d_name, ".") ||
-		    !strcmp(direntp->d_name, ".."))
-			continue;
-
-		ret = fstatat(dfd, direntp->d_name, &st, AT_SYMLINK_NOFOLLOW);
-		if (ret < 0 && errno != ENOENT)
-			break;
-
-		if (S_ISDIR(st.st_mode))
-			ret = chown_r(dfd, direntp->d_name, uid, gid);
-		else
-			ret = fchownat(dfd, direntp->d_name, uid, gid, AT_SYMLINK_NOFOLLOW);
-		if (ret < 0 && errno != ENOENT)
-			break;
-	}
-
-	ret = fchownat(fd, path, uid, gid, AT_SYMLINK_NOFOLLOW);
-	closedir(dir);
-	return ret;
-}
-
 /*
  * There'll be scenarios where you'll want to see the attributes associated with
  * a directory tree during debugging or just to make sure things look correct.
@@ -696,37 +226,6 @@ __attribute__((unused)) static int print_r(int fd, const char *path)
 }
 #endif
 
-/* fd_to_fd - transfer data from one fd to another */
-static int fd_to_fd(int from, int to)
-{
-	for (;;) {
-		uint8_t buf[PATH_MAX];
-		uint8_t *p = buf;
-		ssize_t bytes_to_write;
-		ssize_t bytes_read;
-
-		bytes_read = read_nointr(from, buf, sizeof buf);
-		if (bytes_read < 0)
-			return -1;
-		if (bytes_read == 0)
-			break;
-
-		bytes_to_write = (size_t)bytes_read;
-		do {
-			ssize_t bytes_written;
-
-			bytes_written = write_nointr(to, p, bytes_to_write);
-			if (bytes_written < 0)
-				return -1;
-
-			bytes_to_write -= bytes_written;
-			p += bytes_written;
-		} while (bytes_to_write > 0);
-	}
-
-	return 0;
-}
-
 static int sys_execveat(int fd, const char *path, char **argv, char **envp,
 			int flags)
 {
@@ -738,111 +237,6 @@ static int sys_execveat(int fd, const char *path, char **argv, char **envp,
 #endif
 }
 
-#ifndef CAP_NET_RAW
-#define CAP_NET_RAW 13
-#endif
-
-#ifndef VFS_CAP_FLAGS_EFFECTIVE
-#define VFS_CAP_FLAGS_EFFECTIVE 0x000001
-#endif
-
-#ifndef VFS_CAP_U32_3
-#define VFS_CAP_U32_3 2
-#endif
-
-#ifndef VFS_CAP_U32
-#define VFS_CAP_U32 VFS_CAP_U32_3
-#endif
-
-#ifndef VFS_CAP_REVISION_1
-#define VFS_CAP_REVISION_1 0x01000000
-#endif
-
-#ifndef VFS_CAP_REVISION_2
-#define VFS_CAP_REVISION_2 0x02000000
-#endif
-
-#ifndef VFS_CAP_REVISION_3
-#define VFS_CAP_REVISION_3 0x03000000
-struct vfs_ns_cap_data {
-	__le32 magic_etc;
-	struct {
-		__le32 permitted;
-		__le32 inheritable;
-	} data[VFS_CAP_U32];
-	__le32 rootid;
-};
-#endif
-
-#if __BYTE_ORDER == __BIG_ENDIAN
-#define cpu_to_le16(w16) le16_to_cpu(w16)
-#define le16_to_cpu(w16) ((u_int16_t)((u_int16_t)(w16) >> 8) | (u_int16_t)((u_int16_t)(w16) << 8))
-#define cpu_to_le32(w32) le32_to_cpu(w32)
-#define le32_to_cpu(w32)                                                                       \
-	((u_int32_t)((u_int32_t)(w32) >> 24) | (u_int32_t)(((u_int32_t)(w32) >> 8) & 0xFF00) | \
-	 (u_int32_t)(((u_int32_t)(w32) << 8) & 0xFF0000) | (u_int32_t)((u_int32_t)(w32) << 24))
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
-#define cpu_to_le16(w16) ((u_int16_t)(w16))
-#define le16_to_cpu(w16) ((u_int16_t)(w16))
-#define cpu_to_le32(w32) ((u_int32_t)(w32))
-#define le32_to_cpu(w32) ((u_int32_t)(w32))
-#else
-#error Expected endianess macro to be set
-#endif
-
-/* expected_dummy_vfs_caps_uid - check vfs caps are stored with the provided uid */
-static bool expected_dummy_vfs_caps_uid(int fd, uid_t expected_uid)
-{
-#define __cap_raised_permitted(x, ns_cap_data)                                 \
-	((ns_cap_data.data[(x) >> 5].permitted) & (1 << ((x)&31)))
-	struct vfs_ns_cap_data ns_xattr = {};
-	ssize_t ret;
-
-	ret = fgetxattr(fd, "security.capability", &ns_xattr, sizeof(ns_xattr));
-	if (ret < 0 || ret == 0)
-		return false;
-
-	if (ns_xattr.magic_etc & VFS_CAP_REVISION_3) {
-
-		if (le32_to_cpu(ns_xattr.rootid) != expected_uid) {
-			errno = EINVAL;
-			log_stderr("failure: rootid(%d) != expected_rootid(%d)", le32_to_cpu(ns_xattr.rootid), expected_uid);
-		}
-
-		return (le32_to_cpu(ns_xattr.rootid) == expected_uid) &&
-		       (__cap_raised_permitted(CAP_NET_RAW, ns_xattr) > 0);
-	} else {
-		log_stderr("failure: fscaps version");
-	}
-
-	return false;
-}
-
-/* set_dummy_vfs_caps - set dummy vfs caps for the provided uid */
-static int set_dummy_vfs_caps(int fd, int flags, int rootuid)
-{
-#define __raise_cap_permitted(x, ns_cap_data)                                  \
-	ns_cap_data.data[(x) >> 5].permitted |= (1 << ((x)&31))
-
-	struct vfs_ns_cap_data ns_xattr;
-
-	memset(&ns_xattr, 0, sizeof(ns_xattr));
-	__raise_cap_permitted(CAP_NET_RAW, ns_xattr);
-	ns_xattr.magic_etc |= VFS_CAP_REVISION_3 | VFS_CAP_FLAGS_EFFECTIVE;
-	ns_xattr.rootid = cpu_to_le32(rootuid);
-
-	return fsetxattr(fd, "security.capability",
-			 &ns_xattr, sizeof(ns_xattr), flags);
-}
-
-#define safe_close(fd)      \
-	if (fd >= 0) {           \
-		int _e_ = errno; \
-		close(fd);       \
-		errno = _e_;     \
-		fd = -EBADF;     \
-	}
-
 static void test_setup(struct vfstest_info *info)
 {
 	if (mkdirat(info->t_mnt_fd, T_DIR1, 0777))
@@ -6972,59 +6366,6 @@ out:
 }
 
 #ifdef HAVE_LIBURING_H
-static int io_uring_openat_with_creds(struct io_uring *ring, int dfd, const char *path, int cred_id,
-				      bool with_link, int *ret_cqe)
-{
-	struct io_uring_cqe *cqe;
-	struct io_uring_sqe *sqe;
-	int ret, i, to_submit = 1;
-
-	if (with_link) {
-		sqe = io_uring_get_sqe(ring);
-		if (!sqe)
-			return log_error_errno(-EINVAL, EINVAL, "failure: io_uring_sqe");
-		io_uring_prep_nop(sqe);
-		sqe->flags |= IOSQE_IO_LINK;
-		sqe->user_data = 1;
-		to_submit++;
-	}
-
-	sqe = io_uring_get_sqe(ring);
-	if (!sqe)
-		return log_error_errno(-EINVAL, EINVAL, "failure: io_uring_sqe");
-	io_uring_prep_openat(sqe, dfd, path, O_RDONLY | O_CLOEXEC, 0);
-	sqe->user_data = 2;
-
-	if (cred_id != -1)
-		sqe->personality = cred_id;
-
-	ret = io_uring_submit(ring);
-	if (ret != to_submit) {
-		log_stderr("failure: io_uring_submit");
-		goto out;
-	}
-
-	for (i = 0; i < to_submit; i++) {
-		ret = io_uring_wait_cqe(ring, &cqe);
-		if (ret < 0) {
-			log_stderr("failure: io_uring_wait_cqe");
-			goto out;
-		}
-
-		ret = cqe->res;
-		/*
-		 * Make sure caller can identify that this is a proper io_uring
-		 * failure and not some earlier error.
-		 */
-		if (ret_cqe)
-			*ret_cqe = ret;
-		io_uring_cqe_seen(ring, cqe);
-	}
-	log_debug("Ran test");
-out:
-	return ret;
-}
-
 static int io_uring(const struct vfstest_info *info)
 {
 	int fret = -1;
-- 
2.34.1

