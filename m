Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C6BC433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 11:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053ED6128C
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 11:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbhDLL6m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240420AbhDLL6l (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Apr 2021 07:58:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87F9C611C9;
        Mon, 12 Apr 2021 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618228704;
        bh=XqMXzqAAkwv6JqSEXbsZolUFox4Wnu3LIi45cf9gZtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnbzk4bq+dYDUcmUmHx0KycrqGRWQdSi+nkzyUwlClACoPIx03DH4xWkiYgIMo2Ux
         WeNNfV9E4M03ZTxRd8WbyDrhOc6Esyn80fdRDlbeLZBanEhRjWRdJ420GVfIniHab+
         E12kyszF/geJ/VLt+ub7K01CdtYU8F7aZrwhyDPysgDEy+JGiSXawt+9WHer71M03W
         /wh99HZKKjT6hK5pH/EOSDnz5SYcgeUBFV06rlVWWz2XWk4RPO0TFO+OqgI8IQ4oQ+
         EdOC4NVckIj8mBbGRTe0CECFd9ylped2tE7JAKwjqSAooiRwCTCYg0eRGqa5ryBDRZ
         ct2mBQ9WPge+w==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v13 3/6] common/rc: add _scratch_{u}mount_idmapped() helpers
Date:   Mon, 12 Apr 2021 13:57:05 +0200
Message-Id: <20210412115708.1628386-4-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210412115708.1628386-1-brauner@kernel.org>
References: <20210412115708.1628386-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=0tBoWLwhZNa+tipA2iRvU4W45a+5ynswiuHs0HRDIhQ=; m=6Vb20E8gcJEA5o4NwNERTGWL1KgKXo25uFGgA6DLiA4=; p=US6dNeQYrf5FnzdSPtpDPa3YQxiUIOcLwdH35i+Jt80=; g=9c892fd1eb0dd15af2123a1c358e9d021f1dddd6
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHQ1ggAKCRCRxhvAZXjcogQRAP4oukN hntvFMb/P72K9i/urJb6SdCDQRfycrHome7o1pAEAlPhvGGtAeaEh48/lCQ+kjvfycM/9m3mmeC6T I83zPQE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

They will be used in follow-up patches for xfs quota tests but might be
useful for other tests in the future.

Cc: Eryu Guan <guan@eryu.me>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 - v9 */
patch not present

/* v10 */
patch introduced

/* v11 */
- Amir Goldstein <amir73il@gmail.com>:
  - Minor Makefile style nit.
  - Add missing "/" when calculating maxium path length.
  - Handle the case where user gives us a path to userns.

/* v12 */
- Eryu Guan <guan@eryu.me>:
  - Fix helper installation.

/* v13 */
unchanged
---
 .gitignore                           |   1 +
 common/rc                            |  35 +++
 src/idmapped-mounts/Makefile         |  13 +-
 src/idmapped-mounts/mount-idmapped.c | 431 +++++++++++++++++++++++++++
 src/idmapped-mounts/utils.c          |   2 +-
 src/idmapped-mounts/utils.h          |   1 +
 6 files changed, 478 insertions(+), 5 deletions(-)
 create mode 100644 src/idmapped-mounts/mount-idmapped.c

diff --git a/.gitignore b/.gitignore
index 3229bb26..4cc9c807 100644
--- a/.gitignore
+++ b/.gitignore
@@ -179,6 +179,7 @@
 /src/aio-dio-regress/aiocp
 /src/aio-dio-regress/aiodio_sparse2
 /src/idmapped-mounts/idmapped-mounts
+/src/idmapped-mounts/mount-idmapped
 /src/log-writes/replay-log
 /src/perf/*.pyc
 
diff --git a/common/rc b/common/rc
index 1bba0e93..f77430e2 100644
--- a/common/rc
+++ b/common/rc
@@ -342,6 +342,36 @@ _scratch_mount()
 	_try_scratch_mount $* || _fail "mount failed"
 }
 
+_scratch_mount_idmapped()
+{
+	local type="$1"
+	local id="$2"
+
+	if [ "$type" = "u" ]; then
+		# This means root will be able to create files as uid %id in
+		# the underlying filesystem by going through the idmapped mount.
+		$here/src/idmapped-mounts/mount-idmapped --map-mount u:0:$id:1 \
+							 --map-mount u:$id:0:1 \
+							 --map-mount g:0:0:1 \
+							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+	elif [ "$type" = "g" ]; then
+		# This means root will be able to create files as gid %id in
+		# the underlying filesystem by going through the idmapped mount.
+		$here/src/idmapped-mounts/mount-idmapped --map-mount g:0:$id:1 \
+							 --map-mount g:$id:0:1 \
+							 --map-mount u:0:0:1 \
+							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+	elif [ "$type" = "b" ]; then
+		# This means root will be able to create files as uid and gid
+		# %id in the underlying filesystem by going through the idmapped mount.
+		$here/src/idmapped-mounts/mount-idmapped --map-mount b:0:$id:1 \
+							 --map-mount b:$id:0:1 \
+							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+	else
+		_fail "usage: either \"u\" (uid), \"g\" (gid), or \"b\" (uid and gid) must be specified "
+	fi
+}
+
 _scratch_unmount()
 {
 	case "$FSTYP" in
@@ -357,6 +387,11 @@ _scratch_unmount()
 	esac
 }
 
+_scratch_umount_idmapped()
+{
+	$UMOUNT_PROG $SCRATCH_MNT
+}
+
 _scratch_remount()
 {
     local opts="$1"
diff --git a/src/idmapped-mounts/Makefile b/src/idmapped-mounts/Makefile
index 6a934146..ad4ddc99 100644
--- a/src/idmapped-mounts/Makefile
+++ b/src/idmapped-mounts/Makefile
@@ -3,9 +3,10 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-TARGETS = idmapped-mounts
+TARGETS = idmapped-mounts mount-idmapped
+CFILES_IDMAPPED_MOUNTS = idmapped-mounts.c utils.c
+CFILES_MOUNT_IDMAPPED = mount-idmapped.c utils.c
 
-CFILES = idmapped-mounts.c utils.c
 HFILES = missing.h utils.h
 LLDLIBS += -pthread
 LDIRT = $(TARGETS)
@@ -24,9 +25,13 @@ depend: .dep
 
 include $(BUILDRULES)
 
-$(TARGETS): $(CFILES)
+idmapped-mounts: $(CFILES_IDMAPPED_MOUNTS)
 	@echo "    [CC]    $@"
-	$(Q)$(LTLINK) $(CFILES) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
+	$(Q)$(LTLINK) $(CFILES_IDMAPPED_MOUNTS) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
+
+mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
+	@echo "    [CC]    $@"
+	$(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
 
 install:
 	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src/idmapped-mounts
diff --git a/src/idmapped-mounts/mount-idmapped.c b/src/idmapped-mounts/mount-idmapped.c
new file mode 100644
index 00000000..5f5ba5d2
--- /dev/null
+++ b/src/idmapped-mounts/mount-idmapped.c
@@ -0,0 +1,431 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include "../global.h"
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <libgen.h>
+#include <limits.h>
+#include <linux/bpf.h>
+#include <linux/sched.h>
+#include <linux/seccomp.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "missing.h"
+#include "utils.h"
+
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
+		fprintf(stderr, format, ##__VA_ARGS__); \
+		(-errno);                               \
+	})
+
+#define syserror_set(__ret__, format, ...)                    \
+	({                                                    \
+		typeof(__ret__) __internal_ret__ = (__ret__); \
+		errno = labs(__ret__);                        \
+		fprintf(stderr, format, ##__VA_ARGS__);       \
+		__internal_ret__;                             \
+	})
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
+static struct list active_map;
+
+static int add_map_entry(__u32 id_host,
+			 __u32 id_ns,
+			 __u32 range,
+			 idmap_type_t map_type)
+{
+	struct list *new_list = NULL;
+	struct id_map *newmap = NULL;
+
+	newmap = malloc(sizeof(*newmap));
+	if (!newmap)
+		return -ENOMEM;
+
+	new_list = malloc(sizeof(struct list));
+	if (!new_list) {
+		free(newmap);
+		return -ENOMEM;
+	}
+
+	*newmap = (struct id_map){
+		.hostid		= id_host,
+		.nsid		= id_ns,
+		.range		= range,
+		.map_type	= map_type,
+	};
+
+	new_list->elem = newmap;
+	list_add_tail(&active_map, new_list);
+	return 0;
+}
+
+static int parse_map(char *map)
+{
+	char types[2] = {'u', 'g'};
+	int ret;
+	__u32 id_host, id_ns, range;
+	char which;
+
+	if (!map)
+		return -1;
+
+	ret = sscanf(map, "%c:%u:%u:%u", &which, &id_ns, &id_host, &range);
+	if (ret != 4)
+		return -1;
+
+	if (which != 'b' && which != 'u' && which != 'g')
+		return -1;
+
+	for (int i = 0; i < 2; i++) {
+		idmap_type_t map_type;
+
+		if (which != types[i] && which != 'b')
+			continue;
+
+		if (types[i] == 'u')
+			map_type = ID_TYPE_UID;
+		else
+			map_type = ID_TYPE_GID;
+
+		ret = add_map_entry(id_host, id_ns, range, map_type);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int write_id_mapping(idmap_type_t map_type, pid_t pid, const char *buf, size_t buf_size)
+{
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
+
+	ret = snprintf(path, sizeof(path), "/proc/%d/%cid_map", pid, map_type == ID_TYPE_UID ? 'u' : 'g');
+	if (ret < 0 || ret >= sizeof(path))
+		goto out;
+
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
+}
+
+static int map_ids_from_idmap(struct list *idmap, pid_t pid)
+{
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
+}
+
+static int get_userns_fd_from_idmap(struct list *idmap)
+{
+	int ret;
+	pid_t pid;
+	char path_ns[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
+		  STRLITERALLEN("/ns/user") + 1];
+
+	pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER | CLONE_NEWNS);
+	if (pid < 0)
+		return -errno;
+
+	ret = map_ids_from_idmap(idmap, pid);
+	if (ret < 0)
+		return ret;
+
+	ret = snprintf(path_ns, sizeof(path_ns), "/proc/%d/ns/user", pid);
+	if (ret < 0 || (size_t)ret >= sizeof(path_ns))
+		ret = -EIO;
+	else
+		ret = open(path_ns, O_RDONLY | O_CLOEXEC | O_NOCTTY);
+
+	(void)kill(pid, SIGKILL);
+	(void)wait_for_pid(pid);
+	return ret;
+}
+
+static inline bool strnequal(const char *str, const char *eq, size_t len)
+{
+	return strncmp(str, eq, len) == 0;
+}
+
+static void usage(void)
+{
+	const char *text = "\
+mount-idmapped --map-mount=<idmap> <source> <target>\n\
+\n\
+Create an idmapped mount of <source> at <target>\n\
+Options:\n\
+  --map-mount=<idmap>\n\
+	Specify an idmap for the <target> mount in the format\n\
+	<idmap-type>:<id-from>:<id-to>:<id-range>\n\
+	The <idmap-type> can be:\n\
+	\"b\" or \"both\"	-> map both uids and gids\n\
+	\"u\" or \"uid\"	-> map uids\n\
+	\"g\" or \"gid\"	-> map gids\n\
+	For example, specifying:\n\
+	both:1000:1001:1	-> map uid and gid 1000 to uid and gid 1001 in <target> and no other ids\n\
+	uid:20000:100000:1000	-> map uid 20000 to uid 100000, uid 20001 to uid 100001 [...] in <target>\n\
+	Currently up to 340 separate idmappings may be specified.\n\n\
+  --map-mount=/proc/<pid>/ns/user\n\
+	Specify a path to a user namespace whose idmap is to be used.\n\n\
+  --recursive\n\
+	Copy the whole mount tree from <source> and apply the idmap to everyone at <target>.\n\n\
+Examples:\n\
+  - Create an idmapped mount of /source on /target with both ('b') uids and gids mapped:\n\
+	mount-idmapped --map-mount b:0:10000:10000 /source /target\n\n\
+  - Create an idmapped mount of /source on /target with uids ('u') and gids ('g') mapped separately:\n\
+	mount-idmapped --map-mount u:0:10000:10000 g:0:20000:20000 /source /target\n\n\
+";
+	fprintf(stderr, "%s", text);
+	_exit(EXIT_SUCCESS);
+}
+
+#define exit_usage(format, ...)                         \
+	({                                              \
+		fprintf(stderr, format, ##__VA_ARGS__); \
+		usage();                                \
+	})
+
+#define exit_log(format, ...)                           \
+	({                                              \
+		fprintf(stderr, format, ##__VA_ARGS__); \
+		exit(EXIT_FAILURE);                     \
+	})
+
+static const struct option longopts[] = {
+	{"map-mount",	required_argument,	0,	'a'},
+	{"help",	no_argument,		0,	'c'},
+	{"recursive",	no_argument,		0,	'd'},
+	{ NULL,		0,			0,	0  },
+};
+
+int main(int argc, char *argv[])
+{
+	int fd_userns = -EBADF;
+	int index = 0;
+	const char *source = NULL, *target = NULL;
+	bool recursive = false;
+	int fd_tree, new_argc, ret;
+	char *const *new_argv;
+
+	list_init(&active_map);
+	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
+		switch (ret) {
+		case 'a':
+			if (strnequal(optarg, "/proc/", STRLITERALLEN("/proc/"))) {
+				fd_userns = open(optarg, O_RDONLY | O_CLOEXEC);
+				if (fd_userns < 0)
+					exit_log("%m - Failed top open user namespace path %s\n", optarg);
+				break;
+			}
+
+			ret = parse_map(optarg);
+			if (ret < 0)
+				exit_log("Failed to parse idmaps for mount\n");
+			break;
+		case 'd':
+			recursive = true;
+			break;
+		case 'c':
+			/* fallthrough */
+		default:
+			usage();
+		}
+	}
+
+	new_argv = &argv[optind];
+	new_argc = argc - optind;
+	if (new_argc < 2)
+		exit_usage("Missing source or target mountpoint\n\n");
+	source = new_argv[0];
+	target = new_argv[1];
+
+	fd_tree = sys_open_tree(-EBADF, source,
+			        OPEN_TREE_CLONE |
+			        OPEN_TREE_CLOEXEC |
+			        AT_EMPTY_PATH |
+			        (recursive ? AT_RECURSIVE : 0));
+	if (fd_tree < 0) {
+		exit_log("%m - Failed to open %s\n", source);
+		exit(EXIT_FAILURE);
+	}
+
+	if (!list_empty(&active_map) || fd_userns >= 0) {
+		struct mount_attr attr = {
+			.attr_set = MOUNT_ATTR_IDMAP,
+		};
+
+		if (fd_userns >= 0)
+			attr.userns_fd = fd_userns;
+		else
+			attr.userns_fd = get_userns_fd_from_idmap(&active_map);
+		if (attr.userns_fd < 0)
+			exit_log("%m - Failed to create user namespace\n");
+
+		ret = sys_mount_setattr(fd_tree, "", AT_EMPTY_PATH | AT_RECURSIVE,
+					&attr, sizeof(attr));
+		if (ret < 0)
+			exit_log("%m - Failed to change mount attributes\n");
+		close(attr.userns_fd);
+	}
+
+	ret = sys_move_mount(fd_tree, "", -EBADF, target,
+			     MOVE_MOUNT_F_EMPTY_PATH);
+	if (ret < 0)
+		exit_log("%m - Failed to attach mount to %s\n", target);
+	close(fd_tree);
+
+	exit(EXIT_SUCCESS);
+}
diff --git a/src/idmapped-mounts/utils.c b/src/idmapped-mounts/utils.c
index b27ba445..977443f1 100644
--- a/src/idmapped-mounts/utils.c
+++ b/src/idmapped-mounts/utils.c
@@ -88,7 +88,7 @@ pid_t do_clone(int (*fn)(void *), void *arg, int flags)
 #endif
 }
 
-static int get_userns_fd_cb(void *data)
+int get_userns_fd_cb(void *data)
 {
 	return kill(getpid(), SIGSTOP);
 }
diff --git a/src/idmapped-mounts/utils.h b/src/idmapped-mounts/utils.h
index 93425731..efbf3bc3 100644
--- a/src/idmapped-mounts/utils.h
+++ b/src/idmapped-mounts/utils.h
@@ -20,6 +20,7 @@
 #include "missing.h"
 
 extern pid_t do_clone(int (*fn)(void *), void *arg, int flags);
+extern int get_userns_fd_cb(void *data);
 extern int get_userns_fd(unsigned long nsid, unsigned long hostid,
 			 unsigned long range);
 extern ssize_t read_nointr(int fd, void *buf, size_t count);
-- 
2.27.0

