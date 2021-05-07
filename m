Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A94C433B4
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4FF6145E
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhEGPC2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 May 2021 11:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237711AbhEGPCY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 May 2021 11:02:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 130646145A;
        Fri,  7 May 2021 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620399684;
        bh=8zNN/ooM6gQDuXjjF5heDcGnawYvmgTpYyEiCKv/u2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XES754bUcXD0MQVk/LYey2KCF6Gp/n30eXaVbCPmT5CTV0xfDVRbUyjQosGrIgFSc
         tweeSFpL96Ui+qRzXIvNeeJzTqpszbsGiIPS1mHV68FKF8o08d1zoC7cZDqvfU6mfJ
         BrRS1dl1vmyJSoxa/jr5SbCfyNA9ER1R0/TpgDqNaj0Fvj0pyKMl3Iae21S405yWen
         DNGB9S9BKUYT6l05Hip1oTdYj6tZQFh89s9PkpSDJ6iVYwuwnosX/7toy3NC/vpb2E
         LR1TnS2phV2XDR8bS6FzKSWsnYGTSQrpv4GI2pv6i69WUDv8sSGvZfbl20IFYWVwGs
         t2y5qGWa2rz+A==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5/7] idmapped-mounts: refactor helpers
Date:   Fri,  7 May 2021 17:00:58 +0200
Message-Id: <20210507150100.968659-6-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210507150100.968659-1-brauner@kernel.org>
References: <20210507150100.968659-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=qx9oAe27XvP9wmdCMhY9mdk596Te0pbEEae30v7rnCc=; m=jbX11OXmTcYnZbKBU6aMvPVNTEVEawaxC8TP6Jg6XP8=; p=xGRWf+5zmzAtHVVWBIyd45Ek5Las0hhO6XL9+yPvivk=; g=af16b0b2f0ccde16689577c5f53a0c3581994552
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJVWGwAKCRCRxhvAZXjcoiWIAQDmn4g MQxRKqVuHNtfRpYfjPOo0u6Dg6UBwygCtZkdZ9gD/X6MjyF1JV3nKueQ+2BoQnps475mV52J7S8F7 wCNsIQc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Make all userns creation helpers share a commond codebase and move a
bunch of code into utils.{c,h}. This simplifies a bunch of things and
makes it easier to create nested user namespaces in follow up patches.

Cc: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 src/idmapped-mounts/mount-idmapped.c | 196 -------------------------
 src/idmapped-mounts/utils.c          | 209 +++++++++++++++++++--------
 src/idmapped-mounts/utils.h          |  73 +++++++++-
 3 files changed, 223 insertions(+), 255 deletions(-)

diff --git a/src/idmapped-mounts/mount-idmapped.c b/src/idmapped-mounts/mount-idmapped.c
index 5f5ba5d2..ee3b4f05 100644
--- a/src/idmapped-mounts/mount-idmapped.c
+++ b/src/idmapped-mounts/mount-idmapped.c
@@ -31,77 +31,6 @@
 #include "missing.h"
 #include "utils.h"
 
-/* A few helpful macros. */
-#define STRLITERALLEN(x) (sizeof(""x"") - 1)
-
-#define INTTYPE_TO_STRLEN(type)             \
-	(2 + (sizeof(type) <= 1             \
-		  ? 3                       \
-		  : sizeof(type) <= 2       \
-			? 5                 \
-			: sizeof(type) <= 4 \
-			      ? 10          \
-			      : sizeof(type) <= 8 ? 20 : sizeof(int[-2 * (sizeof(type) > 8)])))
-
-#define syserror(format, ...)                           \
-	({                                              \
-		fprintf(stderr, format, ##__VA_ARGS__); \
-		(-errno);                               \
-	})
-
-#define syserror_set(__ret__, format, ...)                    \
-	({                                                    \
-		typeof(__ret__) __internal_ret__ = (__ret__); \
-		errno = labs(__ret__);                        \
-		fprintf(stderr, format, ##__VA_ARGS__);       \
-		__internal_ret__;                             \
-	})
-
-struct list {
-	void *elem;
-	struct list *next;
-	struct list *prev;
-};
-
-#define list_for_each(__iterator, __list) \
-	for (__iterator = (__list)->next; __iterator != __list; __iterator = __iterator->next)
-
-static inline void list_init(struct list *list)
-{
-	list->elem = NULL;
-	list->next = list->prev = list;
-}
-
-static inline int list_empty(const struct list *list)
-{
-	return list == list->next;
-}
-
-static inline void __list_add(struct list *new, struct list *prev, struct list *next)
-{
-	next->prev = new;
-	new->next = next;
-	new->prev = prev;
-	prev->next = new;
-}
-
-static inline void list_add_tail(struct list *head, struct list *list)
-{
-	__list_add(list, head->prev, head);
-}
-
-typedef enum idmap_type_t {
-	ID_TYPE_UID,
-	ID_TYPE_GID
-} idmap_type_t;
-
-struct id_map {
-	idmap_type_t map_type;
-	__u32 nsid;
-	__u32 hostid;
-	__u32 range;
-};
-
 static struct list active_map;
 
 static int add_map_entry(__u32 id_host,
@@ -170,131 +99,6 @@ static int parse_map(char *map)
 	return 0;
 }
 
-static int write_id_mapping(idmap_type_t map_type, pid_t pid, const char *buf, size_t buf_size)
-{
-	int fd = -EBADF, setgroups_fd = -EBADF;
-	int fret = -1;
-	int ret;
-	char path[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
-		  STRLITERALLEN("/setgroups") + 1];
-
-	if (geteuid() != 0 && map_type == ID_TYPE_GID) {
-		ret = snprintf(path, sizeof(path), "/proc/%d/setgroups", pid);
-		if (ret < 0 || ret >= sizeof(path))
-			goto out;
-
-		setgroups_fd = open(path, O_WRONLY | O_CLOEXEC);
-		if (setgroups_fd < 0 && errno != ENOENT) {
-			syserror("Failed to open \"%s\"", path);
-			goto out;
-		}
-
-		if (setgroups_fd >= 0) {
-			ret = write_nointr(setgroups_fd, "deny\n", STRLITERALLEN("deny\n"));
-			if (ret != STRLITERALLEN("deny\n")) {
-				syserror("Failed to write \"deny\" to \"/proc/%d/setgroups\"", pid);
-				goto out;
-			}
-		}
-	}
-
-	ret = snprintf(path, sizeof(path), "/proc/%d/%cid_map", pid, map_type == ID_TYPE_UID ? 'u' : 'g');
-	if (ret < 0 || ret >= sizeof(path))
-		goto out;
-
-	fd = open(path, O_WRONLY | O_CLOEXEC);
-	if (fd < 0) {
-		syserror("Failed to open \"%s\"", path);
-		goto out;
-	}
-
-	ret = write_nointr(fd, buf, buf_size);
-	if (ret != buf_size) {
-		syserror("Failed to write %cid mapping to \"%s\"",
-			 map_type == ID_TYPE_UID ? 'u' : 'g', path);
-		goto out;
-	}
-
-	fret = 0;
-out:
-	if (fd >= 0)
-		close(fd);
-	if (setgroups_fd >= 0)
-		close(setgroups_fd);
-
-	return fret;
-}
-
-static int map_ids_from_idmap(struct list *idmap, pid_t pid)
-{
-	int fill, left;
-	char mapbuf[4096] = {};
-	bool had_entry = false;
-
-	for (idmap_type_t map_type = ID_TYPE_UID, u_or_g = 'u';
-	     map_type <= ID_TYPE_GID; map_type++, u_or_g = 'g') {
-		char *pos = mapbuf;
-		int ret;
-		struct list *iterator;
-
-
-		list_for_each(iterator, idmap) {
-			struct id_map *map = iterator->elem;
-			if (map->map_type != map_type)
-				continue;
-
-			had_entry = true;
-
-			left = 4096 - (pos - mapbuf);
-			fill = snprintf(pos, left, "%u %u %u\n", map->nsid, map->hostid, map->range);
-			/*
-			 * The kernel only takes <= 4k for writes to
-			 * /proc/<pid>/{g,u}id_map
-			 */
-			if (fill <= 0 || fill >= left)
-				return syserror_set(-E2BIG, "Too many %cid mappings defined", u_or_g);
-
-			pos += fill;
-		}
-		if (!had_entry)
-			continue;
-
-		ret = write_id_mapping(map_type, pid, mapbuf, pos - mapbuf);
-		if (ret < 0)
-			return syserror("Failed to write mapping: %s", mapbuf);
-
-		memset(mapbuf, 0, sizeof(mapbuf));
-	}
-
-	return 0;
-}
-
-static int get_userns_fd_from_idmap(struct list *idmap)
-{
-	int ret;
-	pid_t pid;
-	char path_ns[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
-		  STRLITERALLEN("/ns/user") + 1];
-
-	pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER | CLONE_NEWNS);
-	if (pid < 0)
-		return -errno;
-
-	ret = map_ids_from_idmap(idmap, pid);
-	if (ret < 0)
-		return ret;
-
-	ret = snprintf(path_ns, sizeof(path_ns), "/proc/%d/ns/user", pid);
-	if (ret < 0 || (size_t)ret >= sizeof(path_ns))
-		ret = -EIO;
-	else
-		ret = open(path_ns, O_RDONLY | O_CLOEXEC | O_NOCTTY);
-
-	(void)kill(pid, SIGKILL);
-	(void)wait_for_pid(pid);
-	return ret;
-}
-
 static inline bool strnequal(const char *str, const char *eq, size_t len)
 {
 	return strncmp(str, eq, len) == 0;
diff --git a/src/idmapped-mounts/utils.c b/src/idmapped-mounts/utils.c
index 977443f1..e54f481d 100644
--- a/src/idmapped-mounts/utils.c
+++ b/src/idmapped-mounts/utils.c
@@ -36,99 +36,192 @@ ssize_t write_nointr(int fd, const void *buf, size_t count)
 	return ret;
 }
 
-static int write_file(const char *path, const void *buf, size_t count)
+#define __STACK_SIZE (8 * 1024 * 1024)
+pid_t do_clone(int (*fn)(void *), void *arg, int flags)
 {
-	int fd;
-	ssize_t ret;
+	void *stack;
 
-	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
-	if (fd < 0)
-		return -1;
+	stack = malloc(__STACK_SIZE);
+	if (!stack)
+		return -ENOMEM;
 
-	ret = write_nointr(fd, buf, count);
-	close(fd);
-	if (ret < 0 || (size_t)ret != count)
-		return -1;
+#ifdef __ia64__
+	return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#else
+	return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#endif
+}
 
+static int get_userns_fd_cb(void *data)
+{
 	return 0;
 }
 
-static int map_ids(pid_t pid, unsigned long nsid, unsigned long hostid,
-		   unsigned long range)
+int wait_for_pid(pid_t pid)
 {
-	char map[100], procfile[256];
+	int status, ret;
 
-	snprintf(procfile, sizeof(procfile), "/proc/%d/uid_map", pid);
-	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
-	if (write_file(procfile, map, strlen(map)))
-		return -1;
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
 
+		return -1;
+	}
 
-	snprintf(procfile, sizeof(procfile), "/proc/%d/gid_map", pid);
-	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
-	if (write_file(procfile, map, strlen(map)))
+	if (!WIFEXITED(status))
 		return -1;
 
-	return 0;
+	return WEXITSTATUS(status);
 }
 
-#define __STACK_SIZE (8 * 1024 * 1024)
-pid_t do_clone(int (*fn)(void *), void *arg, int flags)
+static int write_id_mapping(idmap_type_t map_type, pid_t pid, const char *buf, size_t buf_size)
 {
-	void *stack;
+	int fd = -EBADF, setgroups_fd = -EBADF;
+	int fret = -1;
+	int ret;
+	char path[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
+		  STRLITERALLEN("/setgroups") + 1];
+
+	if (geteuid() != 0 && map_type == ID_TYPE_GID) {
+		ret = snprintf(path, sizeof(path), "/proc/%d/setgroups", pid);
+		if (ret < 0 || ret >= sizeof(path))
+			goto out;
+
+		setgroups_fd = open(path, O_WRONLY | O_CLOEXEC);
+		if (setgroups_fd < 0 && errno != ENOENT) {
+			syserror("Failed to open \"%s\"", path);
+			goto out;
+		}
+
+		if (setgroups_fd >= 0) {
+			ret = write_nointr(setgroups_fd, "deny\n", STRLITERALLEN("deny\n"));
+			if (ret != STRLITERALLEN("deny\n")) {
+				syserror("Failed to write \"deny\" to \"/proc/%d/setgroups\"", pid);
+				goto out;
+			}
+		}
+	}
 
-	stack = malloc(__STACK_SIZE);
-	if (!stack)
-		return -ENOMEM;
+	ret = snprintf(path, sizeof(path), "/proc/%d/%cid_map", pid, map_type == ID_TYPE_UID ? 'u' : 'g');
+	if (ret < 0 || ret >= sizeof(path))
+		goto out;
 
-#ifdef __ia64__
-	return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NULL);
-#else
-	return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL);
-#endif
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd < 0) {
+		syserror("Failed to open \"%s\"", path);
+		goto out;
+	}
+
+	ret = write_nointr(fd, buf, buf_size);
+	if (ret != buf_size) {
+		syserror("Failed to write %cid mapping to \"%s\"",
+			 map_type == ID_TYPE_UID ? 'u' : 'g', path);
+		goto out;
+	}
+
+	fret = 0;
+out:
+	if (fd >= 0)
+		close(fd);
+	if (setgroups_fd >= 0)
+		close(setgroups_fd);
+
+	return fret;
 }
 
-int get_userns_fd_cb(void *data)
+static int map_ids_from_idmap(struct list *idmap, pid_t pid)
 {
-	return kill(getpid(), SIGSTOP);
+	int fill, left;
+	char mapbuf[4096] = {};
+	bool had_entry = false;
+
+	for (idmap_type_t map_type = ID_TYPE_UID, u_or_g = 'u';
+	     map_type <= ID_TYPE_GID; map_type++, u_or_g = 'g') {
+		char *pos = mapbuf;
+		int ret;
+		struct list *iterator;
+
+
+		list_for_each(iterator, idmap) {
+			struct id_map *map = iterator->elem;
+			if (map->map_type != map_type)
+				continue;
+
+			had_entry = true;
+
+			left = 4096 - (pos - mapbuf);
+			fill = snprintf(pos, left, "%u %u %u\n", map->nsid, map->hostid, map->range);
+			/*
+			 * The kernel only takes <= 4k for writes to
+			 * /proc/<pid>/{g,u}id_map
+			 */
+			if (fill <= 0 || fill >= left)
+				return syserror_set(-E2BIG, "Too many %cid mappings defined", u_or_g);
+
+			pos += fill;
+		}
+		if (!had_entry)
+			continue;
+
+		ret = write_id_mapping(map_type, pid, mapbuf, pos - mapbuf);
+		if (ret < 0)
+			return syserror("Failed to write mapping: %s", mapbuf);
+
+		memset(mapbuf, 0, sizeof(mapbuf));
+	}
+
+	return 0;
 }
 
-int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned long range)
+int get_userns_fd_from_idmap(struct list *idmap)
 {
 	int ret;
 	pid_t pid;
-	char path[256];
+	char path_ns[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
+		     STRLITERALLEN("/ns/user") + 1];
 
-	pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER);
+	pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER | CLONE_NEWNS);
 	if (pid < 0)
 		return -errno;
 
-	ret = map_ids(pid, nsid, hostid, range);
+	ret = map_ids_from_idmap(idmap, pid);
 	if (ret < 0)
 		return ret;
 
-	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
-	ret = open(path, O_RDONLY | O_CLOEXEC);
-	kill(pid, SIGKILL);
-	wait_for_pid(pid);
+	ret = snprintf(path_ns, sizeof(path_ns), "/proc/%d/ns/user", pid);
+	if (ret < 0 || (size_t)ret >= sizeof(path_ns))
+		ret = -EIO;
+	else
+		ret = open(path_ns, O_RDONLY | O_CLOEXEC | O_NOCTTY);
+
+	(void)kill(pid, SIGKILL);
+	(void)wait_for_pid(pid);
 	return ret;
 }
 
-int wait_for_pid(pid_t pid)
+int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned long range)
 {
-	int status, ret;
-
-again:
-	ret = waitpid(pid, &status, 0);
-	if (ret == -1) {
-		if (errno == EINTR)
-			goto again;
-
-		return -1;
-	}
-
-	if (!WIFEXITED(status))
-		return -1;
-
-	return WEXITSTATUS(status);
+	struct list head, uid_mapl, gid_mapl;
+	struct id_map uid_map = {
+		.map_type	= ID_TYPE_UID,
+		.nsid		= nsid,
+		.hostid		= hostid,
+		.range		= range,
+	};
+	struct id_map gid_map = {
+		.map_type	= ID_TYPE_GID,
+		.nsid		= nsid,
+		.hostid		= hostid,
+		.range		= range,
+	};
+
+	list_init(&head);
+	uid_mapl.elem = &uid_map;
+	gid_mapl.elem = &gid_map;
+	list_add_tail(&head, &uid_mapl);
+	list_add_tail(&head, &gid_mapl);
+
+	return get_userns_fd_from_idmap(&head);
 }
diff --git a/src/idmapped-mounts/utils.h b/src/idmapped-mounts/utils.h
index efbf3bc3..4f976f9f 100644
--- a/src/idmapped-mounts/utils.h
+++ b/src/idmapped-mounts/utils.h
@@ -19,10 +19,81 @@
 
 #include "missing.h"
 
+/* A few helpful macros. */
+#define STRLITERALLEN(x) (sizeof(""x"") - 1)
+
+#define INTTYPE_TO_STRLEN(type)             \
+	(2 + (sizeof(type) <= 1             \
+		  ? 3                       \
+		  : sizeof(type) <= 2       \
+			? 5                 \
+			: sizeof(type) <= 4 \
+			      ? 10          \
+			      : sizeof(type) <= 8 ? 20 : sizeof(int[-2 * (sizeof(type) > 8)])))
+
+#define syserror(format, ...)                           \
+	({                                              \
+		fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__); \
+		(-errno);                               \
+	})
+
+#define syserror_set(__ret__, format, ...)                    \
+	({                                                    \
+		typeof(__ret__) __internal_ret__ = (__ret__); \
+		errno = labs(__ret__);                        \
+		fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__);       \
+		__internal_ret__;                             \
+	})
+
+typedef enum idmap_type_t {
+	ID_TYPE_UID,
+	ID_TYPE_GID
+} idmap_type_t;
+
+struct id_map {
+	idmap_type_t map_type;
+	__u32 nsid;
+	__u32 hostid;
+	__u32 range;
+};
+
+struct list {
+	void *elem;
+	struct list *next;
+	struct list *prev;
+};
+
+#define list_for_each(__iterator, __list) \
+	for (__iterator = (__list)->next; __iterator != __list; __iterator = __iterator->next)
+
+static inline void list_init(struct list *list)
+{
+	list->elem = NULL;
+	list->next = list->prev = list;
+}
+
+static inline int list_empty(const struct list *list)
+{
+	return list == list->next;
+}
+
+static inline void __list_add(struct list *new, struct list *prev, struct list *next)
+{
+	next->prev = new;
+	new->next = next;
+	new->prev = prev;
+	prev->next = new;
+}
+
+static inline void list_add_tail(struct list *head, struct list *list)
+{
+	__list_add(list, head->prev, head);
+}
+
 extern pid_t do_clone(int (*fn)(void *), void *arg, int flags);
-extern int get_userns_fd_cb(void *data);
 extern int get_userns_fd(unsigned long nsid, unsigned long hostid,
 			 unsigned long range);
+extern int get_userns_fd_from_idmap(struct list *idmap);
 extern ssize_t read_nointr(int fd, void *buf, size_t count);
 extern int wait_for_pid(pid_t pid);
 extern ssize_t write_nointr(int fd, const void *buf, size_t count);
-- 
2.27.0

