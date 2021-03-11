Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C553C433E9
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Mar 2021 17:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1862B64FE2
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Mar 2021 17:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCKR4D (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:56:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39377 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhCKRz4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Mar 2021 12:55:56 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lKPXO-0008Tn-0g; Thu, 11 Mar 2021 17:55:54 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/4] xfs/528: quotas and idmapped mounts
Date:   Thu, 11 Mar 2021 18:55:35 +0100
Message-Id: <20210311175536.1971732-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210311175536.1971732-1-christian.brauner@ubuntu.com>
References: <20210311175536.1971732-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test that xfs quota behave correctly on idmapped mounts.
Mount a scratch device with user and group quota support enabled. Create
directories "unmapped" and "idmapped". Create files in the unampped
mount and verify quota behavior. Create files through the idmapped mount
and verify identical behavior.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .gitignore                           |   1 +
 src/idmapped-mounts/Makefile         |  14 +-
 src/idmapped-mounts/mount-idmapped.c | 428 +++++++++++++++++
 src/idmapped-mounts/utils.c          |   2 +-
 src/idmapped-mounts/utils.h          |   1 +
 tests/xfs/528                        | 373 +++++++++++++++
 tests/xfs/528.out                    | 657 +++++++++++++++++++++++++++
 tests/xfs/group                      |   1 +
 8 files changed, 1472 insertions(+), 5 deletions(-)
 create mode 100644 src/idmapped-mounts/mount-idmapped.c
 create mode 100755 tests/xfs/528
 create mode 100644 tests/xfs/528.out

diff --git a/.gitignore b/.gitignore
index c9436197..d5d6be32 100644
--- a/.gitignore
+++ b/.gitignore
@@ -177,6 +177,7 @@
 /src/aio-dio-regress/aiocp
 /src/aio-dio-regress/aiodio_sparse2
 /src/idmapped-mounts/idmapped-mounts
+/src/idmapped-mounts/mount-idmapped
 /src/log-writes/replay-log
 /src/perf/*.pyc
 
diff --git a/src/idmapped-mounts/Makefile b/src/idmapped-mounts/Makefile
index 6a934146..40bf9164 100644
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
@@ -24,12 +25,17 @@ depend: .dep
 
 include $(BUILDRULES)
 
-$(TARGETS): $(CFILES)
+idmapped-mounts:
 	@echo "    [CC]    $@"
-	$(Q)$(LTLINK) $(CFILES) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
+	$(Q)$(LTLINK) $(CFILES_IDMAPPED_MOUNTS) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
+
+mount-idmapped:
+	@echo "    [CC]    $@"
+	$(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
 
 install:
 	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src/idmapped-mounts
 	$(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/idmapped-mounts
+	$(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/mount-idmapped
 
 -include .dep
diff --git a/src/idmapped-mounts/mount-idmapped.c b/src/idmapped-mounts/mount-idmapped.c
new file mode 100644
index 00000000..f127cdc7
--- /dev/null
+++ b/src/idmapped-mounts/mount-idmapped.c
@@ -0,0 +1,428 @@
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
+	char path[STRLITERALLEN("/proc") + INTTYPE_TO_STRLEN(pid_t) +
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
+	char path_ns[STRLITERALLEN("/proc") + INTTYPE_TO_STRLEN(pid_t) +
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
+			if (strnequal(optarg, "/proc", STRLITERALLEN("/proc/"))) {
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
+	if (!list_empty(&active_map)) {
+		struct mount_attr attr = {
+			.attr_set = MOUNT_ATTR_IDMAP,
+		};
+
+		attr.userns_fd = get_userns_fd_from_idmap(&active_map);
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
diff --git a/tests/xfs/528 b/tests/xfs/528
new file mode 100755
index 00000000..c3962f38
--- /dev/null
+++ b/tests/xfs/528
@@ -0,0 +1,373 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
+# All Rights Reserved.
+#
+# FS QA Test No. 528
+#
+# Exercise basic xfs_quota functionality (user/group/project quota)
+# Use of "sync" mount option here is an attempt to get deterministic
+# allocator behaviour.
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
+. ./common/quota
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs xfs
+_require_idmapped_mounts
+_require_scratch
+_require_xfs_quota
+_require_user fsgqa
+_require_user fsgqa2
+_require_group fsgqa
+_require_group fsgqa2
+
+_scratch_mkfs_xfs >>$seqres.full 2>&1
+
+uqid=`id -u fsgqa`
+gqid=`id -g fsgqa`
+
+uqid2=`id -u fsgqa2`
+gqid2=`id -g fsgqa2`
+
+pqid=10
+cat >$tmp.projects <<EOF
+$pqid:$SCRATCH_MNT
+EOF
+
+cat >$tmp.projid <<EOF
+root:0
+fsgqa:$pqid
+EOF
+
+create_files_unmapped()
+{
+	local bs=$1
+	local inum=$2
+
+	echo "Using type=$type id=$id" >> $seqres.full
+
+	for ((i=0; i<$((inum-1)); i++)); do
+		_file_as_id $SCRATCH_MNT/unmapped/inode$i $id $type 1024 0
+	done
+
+	_file_as_id $SCRATCH_MNT/unmapped/block $id $type $bs 1
+}
+
+create_files_idmapped()
+{
+	local bs=$1
+	local inum=$2
+
+	echo "Using type=$type id=$id2" >> $seqres.full
+
+	for ((i=0; i<$((inum-1)); i++)); do
+		_file_as_id $SCRATCH_MNT/idmapped/inode$i $id2 $type 1024 0
+	done
+
+	_file_as_id $SCRATCH_MNT/idmapped/block $id2 $type $bs 1
+}
+
+clean_files()
+{
+	rm -rf $SCRATCH_MNT/unmapped 2>/dev/null
+	rm -rf $SCRATCH_MNT/idmapped 2>/dev/null
+	rm -rf $tmp.quot 2>/dev/null
+	rm -rf $tmp.quota 2>/dev/null
+}
+
+filter_quot()
+{
+	_filter_quota | grep -v "root \|\#0 " \
+		| sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
+}
+
+filter_report()
+{
+	_filter_quota | grep -v "^root \|^\#0 " \
+		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
+}
+
+filter_quota()
+{
+	_filter_quota | sed -e "/Disk quotas for/s/([0-9]*)/(ID)/g" \
+			    -e "/Disk quotas for/s/#[0-9]*/#ID/g"
+}
+
+filter_state()
+{
+	_filter_quota | sed -e "s/Inode: #[0-9]* (0 blocks, 0 extents)/Inode: #[INO] (0 blocks, 0 extents)/g" \
+			    -e "s/Inode: #[0-9]* ([0-9]* blocks, [0-9]* extents)/Inode: #[INO] (X blocks, Y extents)/g" \
+			    -e "/[0-9][0-9]:[0-9][0-9]:[0-9][0-9]/s/ [0-9][0-9]:[0-9][0-9]:[0-9][0-9]//g" \
+			    -e '/max warnings:/d'
+}
+
+test_quot()
+{
+	local opt="$*"
+
+	echo "checking quot command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "quot -$type $opt -bi" $SCRATCH_MNT | filter_quot
+}
+
+test_report()
+{
+	local opt="$*"
+
+	echo "checking report command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "report -$type $opt -bi" \
+			$SCRATCH_MNT | filter_report
+}
+
+test_quota()
+{
+	local opt="$*"
+
+	echo "checking quota command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "quota -$type $opt -bi $id" \
+			$SCRATCH_MNT | filter_quota
+}
+
+test_limit()
+{
+	local bs=$1
+	local bh=$2
+	local is=$3
+	local ih=$4
+
+	echo "checking limit command (type=$type, bsoft=$bs, bhard=$bh, isoft=$is, ihard=$ih)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "limit -$type bsoft=$bs bhard=$bh fsgqa" \
+			-c "limit -$type isoft=$is ihard=$ih fsgqa" \
+			$SCRATCH_MNT
+
+	# let the timer day transition happen
+	sleep 2
+}
+
+test_timer()
+{
+	echo "checking timer command (type=$type)"
+	# set 3days+1h for time won't become 2days soon
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "timer -$type -bi 73h" \
+			$SCRATCH_MNT | _filter_scratch
+}
+
+test_disable()
+{
+	echo "checking disable command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "disable -$type -v" \
+			$SCRATCH_MNT | filter_state
+}
+
+test_enable()
+{
+	echo "checking enable command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "enable -$type -v" $SCRATCH_MNT | filter_state
+}
+
+test_off()
+{
+	echo "checking off command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "off -$type -v" $SCRATCH_MNT | _filter_scratch
+}
+
+test_remove()
+{
+	echo "checking remove command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "remove -$type -v" \
+			$SCRATCH_MNT | _filter_scratch
+}
+
+test_state()
+{
+	echo "checking state command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "state -$type" $SCRATCH_MNT | filter_state
+}
+
+test_dump()
+{
+	echo "checking dump command (type=$type)"
+	rm -f $tmp.backup 2>>/dev/null
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "dump -$type -f $tmp.backup" \
+			$SCRATCH_MNT | _filter_scratch
+}
+
+test_restore()
+{
+	echo "checking restore command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "restore -$type -f $tmp.backup" \
+			$SCRATCH_MNT | _filter_scratch
+}
+
+_wipe_mounts()
+{
+	umount -l -q "${SCRATCH_MNT}/idmapped" >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
+}
+
+_wipe_scratch()
+{
+	_wipe_mounts
+	_scratch_mkfs_xfs >>$seqres.full 2>&1
+}
+
+_qmount_idmapped()
+{
+	_wipe_mounts
+	_try_scratch_mount || _fail "qmount failed"
+
+	mkdir -p "${SCRATCH_MNT}/unmapped"
+	mkdir -p "${SCRATCH_MNT}/idmapped"
+
+	$here/src/idmapped-mounts/mount-idmapped --map-mount b:$id:$id2:1 --map-mount b:0:0:1 "$SCRATCH_MNT/unmapped" "$SCRATCH_MNT/idmapped" || _fail "mount-idmapped failed"
+
+	chmod ugo+rwx $SCRATCH_MNT
+	chmod ugo+rwx $SCRATCH_MNT/unmapped
+	chmod ugo+rwx $SCRATCH_MNT/idmapped
+}
+
+test_xfs_quota()
+{
+	# init quota
+	echo "init quota limit and timer, and dump it"
+	if [ "$idmapped" -eq 1 ]; then
+		echo "create_files_idmapped 1024k 15"; create_files_idmapped 1024k 15
+	else
+		echo "create_files_unmapped 1024k 15"; create_files_unmapped 1024k 15
+	fi
+	echo "quota remount"; _qmount_idmapped
+	echo ; test_quot
+	echo ; test_timer
+	echo ; test_limit 512k 2048k 10 20
+	echo ; test_dump
+
+	# report options test
+	echo "report options test"
+	echo ; test_report
+	echo "-N option"; test_report -N
+	echo "-L -U options"; test_report -L $id -U $id
+	echo "-t option"; test_report -t
+	echo "-n option"; test_report -n
+	echo "-h option"; test_report -h
+
+	# quot options test
+	echo "quot options test"
+	echo ; test_quot
+	echo "-f option"; test_quot -f $tmp.quot
+	cat $tmp.quot | filter_quot
+	echo "-n option"; test_quot -n
+
+	# quota options test
+	echo ; test_quota
+	echo "-f option"; test_quota -f $tmp.quota
+	cat $tmp.quota | filter_quota
+	echo "-N option"; test_quota -N
+	echo "-n option"; test_quota -n
+	echo "-h option"; test_quota -h
+
+	# disable/enable test
+	echo "disable quota"
+	echo ; test_disable
+	echo ; test_report -N
+	echo "expect a remove error at here"; test_remove
+	echo ; test_enable
+	echo ; test_report -N
+
+	# off and remove test
+	echo "off and remove test"
+	echo ; test_limit 100m 100m 100 100
+	echo ; test_quota -N
+	echo ; test_off
+	echo ; test_state
+	echo ; test_remove
+	echo ; test_report -N
+	echo "quota remount"; _qmount_idmapped
+	echo ; test_report -N
+
+	# restore test
+	echo "restore quota"
+	echo ; test_restore
+	echo ; test_report -N
+	echo ; test_state
+	echo "cleanup files"; clean_files
+}
+
+echo "----------------------- uquota,sync,unmapped ---------------------------"
+_wipe_scratch
+_qmount_option "uquota,sync"
+type=u
+id=$uqid
+id2=$uqid2
+idmapped=0
+_qmount_idmapped
+test_xfs_quota
+
+echo "----------------------- uquota,sync,idmapped ---------------------------"
+_wipe_scratch
+_qmount_option "uquota,sync"
+type=u
+id=$uqid
+id2=$uqid2
+idmapped=1
+_qmount_idmapped
+test_xfs_quota
+
+echo "----------------------- gquota,sync,unmapped ---------------------------"
+_wipe_scratch
+_qmount_option "gquota,sync"
+type=g
+id=$gqid
+id2=$gqid2
+idmapped=0
+_qmount_idmapped
+test_xfs_quota
+
+echo "----------------------- gquota,sync,idmapped ---------------------------"
+_wipe_scratch
+_qmount_option "gquota,sync"
+type=g
+id=$gqid
+id2=$gqid2
+idmapped=1
+_qmount_idmapped
+test_xfs_quota
+
+umount -l -q "${SCRATCH_MNT}/idmapped" >/dev/null 2>&1
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/528.out b/tests/xfs/528.out
new file mode 100644
index 00000000..cc33efcc
--- /dev/null
+++ b/tests/xfs/528.out
@@ -0,0 +1,657 @@
+QA output created by 528
+----------------------- uquota,sync,unmapped ---------------------------
+init quota limit and timer, and dump it
+create_files_unmapped 1024k 15
+quota remount
+
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+
+checking timer command (type=u)
+
+checking limit command (type=u, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+
+checking dump command (type=u)
+report options test
+
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-N option
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L -U options
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-t option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-n option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-h option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/Grace 
+---------- --------------------------------- --------------------------------- 
+fsgqa 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days]
+
+quot options test
+
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+-f option
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+-n option
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 #ID 
+
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-f option
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-N option
+checking quota command (type=u)
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-n option
+checking quota command (type=u)
+Disk quotas for User #ID (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-h option
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+disable quota
+
+checking disable command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: OFF
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [--------] 15 10 20 00 [--------]
+
+expect a remove error at here
+checking remove command (type=u)
+XFS_QUOTARM: Invalid argument
+
+checking enable command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+off and remove test
+
+checking limit command (type=u, bsoft=100m, bhard=100m, isoft=100, ihard=100)
+
+checking quota command (type=u)
+SCRATCH_DEV 1024 102400 102400 00 [--------] 15 100 100 00 [--------] SCRATCH_MNT
+
+checking off command (type=u)
+User quota are not enabled on SCRATCH_DEV
+
+checking state command (type=u)
+
+checking remove command (type=u)
+User quota are not enabled on SCRATCH_DEV
+
+checking report command (type=u)
+
+quota remount
+
+checking report command (type=u)
+fsgqa 1024 0 0 00 [--------] 15 0 0 00 [--------]
+
+restore quota
+
+checking restore command (type=u)
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+
+
+checking state command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [7 days]
+Inodes grace time: [7 days]
+Realtime Blocks grace time: [7 days]
+cleanup files
+----------------------- uquota,sync,idmapped ---------------------------
+init quota limit and timer, and dump it
+create_files_idmapped 1024k 15
+quota remount
+
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+
+checking timer command (type=u)
+
+checking limit command (type=u, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+
+checking dump command (type=u)
+report options test
+
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-N option
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L -U options
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-t option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-n option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-h option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/Grace 
+---------- --------------------------------- --------------------------------- 
+fsgqa 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days]
+
+quot options test
+
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+-f option
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+-n option
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 #ID 
+
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-f option
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-N option
+checking quota command (type=u)
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-n option
+checking quota command (type=u)
+Disk quotas for User #ID (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-h option
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+disable quota
+
+checking disable command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: OFF
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [--------] 15 10 20 00 [--------]
+
+expect a remove error at here
+checking remove command (type=u)
+XFS_QUOTARM: Invalid argument
+
+checking enable command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+off and remove test
+
+checking limit command (type=u, bsoft=100m, bhard=100m, isoft=100, ihard=100)
+
+checking quota command (type=u)
+SCRATCH_DEV 1024 102400 102400 00 [--------] 15 100 100 00 [--------] SCRATCH_MNT
+
+checking off command (type=u)
+User quota are not enabled on SCRATCH_DEV
+
+checking state command (type=u)
+
+checking remove command (type=u)
+User quota are not enabled on SCRATCH_DEV
+
+checking report command (type=u)
+
+quota remount
+
+checking report command (type=u)
+fsgqa 1024 0 0 00 [--------] 15 0 0 00 [--------]
+
+restore quota
+
+checking restore command (type=u)
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+
+
+checking state command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [7 days]
+Inodes grace time: [7 days]
+Realtime Blocks grace time: [7 days]
+cleanup files
+----------------------- gquota,sync,unmapped ---------------------------
+init quota limit and timer, and dump it
+create_files_unmapped 1024k 15
+quota remount
+
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+
+checking timer command (type=g)
+
+checking limit command (type=g, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+
+checking dump command (type=g)
+report options test
+
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-N option
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L -U options
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-t option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-n option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-h option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/Grace 
+---------- --------------------------------- --------------------------------- 
+fsgqa 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days]
+
+quot options test
+
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+-f option
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+-n option
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 #ID 
+
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-f option
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-N option
+checking quota command (type=g)
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-n option
+checking quota command (type=g)
+Disk quotas for Group #ID (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-h option
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+disable quota
+
+checking disable command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: OFF
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [--------] 15 10 20 00 [--------]
+
+expect a remove error at here
+checking remove command (type=g)
+XFS_QUOTARM: Invalid argument
+
+checking enable command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+off and remove test
+
+checking limit command (type=g, bsoft=100m, bhard=100m, isoft=100, ihard=100)
+
+checking quota command (type=g)
+SCRATCH_DEV 1024 102400 102400 00 [--------] 15 100 100 00 [--------] SCRATCH_MNT
+
+checking off command (type=g)
+Group quota are not enabled on SCRATCH_DEV
+
+checking state command (type=g)
+
+checking remove command (type=g)
+Group quota are not enabled on SCRATCH_DEV
+
+checking report command (type=g)
+
+quota remount
+
+checking report command (type=g)
+fsgqa 1024 0 0 00 [--------] 15 0 0 00 [--------]
+
+restore quota
+
+checking restore command (type=g)
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+
+
+checking state command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [7 days]
+Inodes grace time: [7 days]
+Realtime Blocks grace time: [7 days]
+cleanup files
+----------------------- gquota,sync,idmapped ---------------------------
+init quota limit and timer, and dump it
+create_files_idmapped 1024k 15
+quota remount
+
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+
+checking timer command (type=g)
+
+checking limit command (type=g, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+
+checking dump command (type=g)
+report options test
+
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-N option
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L -U options
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-t option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-n option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-h option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/Grace 
+---------- --------------------------------- --------------------------------- 
+fsgqa 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days]
+
+quot options test
+
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+-f option
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+-n option
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 #ID 
+
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-f option
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-N option
+checking quota command (type=g)
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-n option
+checking quota command (type=g)
+Disk quotas for Group #ID (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-h option
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+disable quota
+
+checking disable command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: OFF
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [--------] 15 10 20 00 [--------]
+
+expect a remove error at here
+checking remove command (type=g)
+XFS_QUOTARM: Invalid argument
+
+checking enable command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+off and remove test
+
+checking limit command (type=g, bsoft=100m, bhard=100m, isoft=100, ihard=100)
+
+checking quota command (type=g)
+SCRATCH_DEV 1024 102400 102400 00 [--------] 15 100 100 00 [--------] SCRATCH_MNT
+
+checking off command (type=g)
+Group quota are not enabled on SCRATCH_DEV
+
+checking state command (type=g)
+
+checking remove command (type=g)
+Group quota are not enabled on SCRATCH_DEV
+
+checking report command (type=g)
+
+quota remount
+
+checking report command (type=g)
+fsgqa 1024 0 0 00 [--------] 15 0 0 00 [--------]
+
+restore quota
+
+checking restore command (type=g)
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+
+
+checking state command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [7 days]
+Inodes grace time: [7 days]
+Realtime Blocks grace time: [7 days]
+cleanup files
diff --git a/tests/xfs/group b/tests/xfs/group
index e861cec9..2356c4a9 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -525,3 +525,4 @@
 525 auto quick mkfs
 526 auto quick mkfs
 527 auto quick quota
+528 auto quick quota
-- 
2.27.0

