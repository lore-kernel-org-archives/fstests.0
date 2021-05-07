Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D7C43461
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6C613F1
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbhEGPC2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 May 2021 11:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237715AbhEGPC1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 May 2021 11:02:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D99DC61400;
        Fri,  7 May 2021 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620399686;
        bh=KyM09Gvjg+pYMSjLyU07vAFrJ5iRBa7aEYw6v2JIaEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBuj9uIq5QiRCY9P2Ug+PnvvFUSkStppFghwzqSkuzshf5X0xiBzLG4VUxac8NX7G
         yAAwBOf05U3x+vBl7EFzap93nf5jL/vx65q83l+hnLacZIY5tqEDulywDOaz1AaWwA
         eJypwG5nmFkqmbIFE23pocktmByatK27aJoEWmLn8OMRJX0mM5xnGj5lbXrunyhOew
         C3afczWQHXtp9OUFvNFb9U1DPtuTAaB6G2AiJxSKZRptop/M2gDEmS4EZhx10Mbg25
         6s00HoFHIgTW96gJXAgF3xbu3kFmZ7djGV3LWXmPkOiTjloYNMOu5zDqZI/JOBCVEa
         AE9eD+hoA0/UA==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 6/7] idmapped-mounts: add nested userns creation helpers
Date:   Fri,  7 May 2021 17:00:59 +0200
Message-Id: <20210507150100.968659-7-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210507150100.968659-1-brauner@kernel.org>
References: <20210507150100.968659-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=G9mZDhfQorbFVYlNdXFEXJkcbShmhVhIcqeSawpi2DQ=; m=N0qhIWG3u7ujYqb2FV+c/S7aogLb17WAE4v21PoRXqc=; p=bhtRa9JRCEmRnDkVtsF1D71gmig1LgVPyMzUXY/PV7s=; g=fd7a99e2c49df3e8eff8ae6c0dfd2f9c470042ec
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJVWGwAKCRCRxhvAZXjcojmQAQCkUtn w4kzaNf6WgQDFCDnQwQUcHEKhR6ttxCe033p9GQEApX7MKwAEpAADGTMaqgZVHoedwYj0flIaMBe2 BrhVOQ4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Add a helper to create a nested userns hierarchy. This will be used in
follow-up tests.

Cc: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 src/idmapped-mounts/idmapped-mounts.c |  14 ---
 src/idmapped-mounts/mount-idmapped.c  |  32 +-----
 src/idmapped-mounts/utils.c           | 160 +++++++++++++++++++++++++-
 src/idmapped-mounts/utils.h           |  25 ++++
 4 files changed, 185 insertions(+), 46 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 94b83c01..f5a48af7 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -390,20 +390,6 @@ static inline bool switch_fsids(uid_t fsuid, gid_t fsgid)
 	return true;
 }
 
-static inline bool switch_ids(uid_t uid, gid_t gid)
-{
-	if (setgroups(0, NULL))
-		return log_errno(false, "failure: setgroups");
-
-	if (setresgid(gid, gid, gid))
-		return log_errno(false, "failure: setresgid");
-
-	if (setresuid(uid, uid, uid))
-		return log_errno(false, "failure: setresuid");
-
-	return true;
-}
-
 static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
 {
 	if (setns(fd, CLONE_NEWUSER))
diff --git a/src/idmapped-mounts/mount-idmapped.c b/src/idmapped-mounts/mount-idmapped.c
index ee3b4f05..46d110fc 100644
--- a/src/idmapped-mounts/mount-idmapped.c
+++ b/src/idmapped-mounts/mount-idmapped.c
@@ -33,36 +33,6 @@
 
 static struct list active_map;
 
-static int add_map_entry(__u32 id_host,
-			 __u32 id_ns,
-			 __u32 range,
-			 idmap_type_t map_type)
-{
-	struct list *new_list = NULL;
-	struct id_map *newmap = NULL;
-
-	newmap = malloc(sizeof(*newmap));
-	if (!newmap)
-		return -ENOMEM;
-
-	new_list = malloc(sizeof(struct list));
-	if (!new_list) {
-		free(newmap);
-		return -ENOMEM;
-	}
-
-	*newmap = (struct id_map){
-		.hostid		= id_host,
-		.nsid		= id_ns,
-		.range		= range,
-		.map_type	= map_type,
-	};
-
-	new_list->elem = newmap;
-	list_add_tail(&active_map, new_list);
-	return 0;
-}
-
 static int parse_map(char *map)
 {
 	char types[2] = {'u', 'g'};
@@ -91,7 +61,7 @@ static int parse_map(char *map)
 		else
 			map_type = ID_TYPE_GID;
 
-		ret = add_map_entry(id_host, id_ns, range, map_type);
+		ret = add_map_entry(&active_map, id_host, id_ns, range, map_type);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/src/idmapped-mounts/utils.c b/src/idmapped-mounts/utils.c
index e54f481d..6ffd6a23 100644
--- a/src/idmapped-mounts/utils.c
+++ b/src/idmapped-mounts/utils.c
@@ -3,11 +3,15 @@
 #define _GNU_SOURCE
 #endif
 #include <fcntl.h>
+#include <grp.h>
 #include <linux/limits.h>
+#include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <sched.h>
+#include <sys/eventfd.h>
 #include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -137,6 +141,9 @@ static int map_ids_from_idmap(struct list *idmap, pid_t pid)
 	char mapbuf[4096] = {};
 	bool had_entry = false;
 
+	if (list_empty(idmap))
+		return 0;
+
 	for (idmap_type_t map_type = ID_TYPE_UID, u_or_g = 'u';
 	     map_type <= ID_TYPE_GID; map_type++, u_or_g = 'g') {
 		char *pos = mapbuf;
@@ -225,3 +232,154 @@ int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned long range)
 
 	return get_userns_fd_from_idmap(&head);
 }
+
+bool switch_ids(uid_t uid, gid_t gid)
+{
+	if (setgroups(0, NULL))
+		return syserror("failure: setgroups");
+
+	if (setresgid(gid, gid, gid))
+		return syserror("failure: setresgid");
+
+	if (setresuid(uid, uid, uid))
+		return syserror("failure: setresuid");
+
+	return true;
+}
+
+static int userns_fd_cb(void *data)
+{
+	struct userns_hierarchy *h = data;
+	char c;
+	int ret;
+
+	ret = read_nointr(h->fd_event, &c, 1);
+	if (ret < 0)
+		return syserror("failure: read from socketpair");
+
+	/* Only switch ids if someone actually wrote a mapping for us. */
+	if (c == '1') {
+		if (!switch_ids(0, 0))
+			return syserror("failure: switch ids to 0");
+
+		/* Ensure we can access proc files from processes we can ptrace. */
+		ret = prctl(PR_SET_DUMPABLE, 1, 0, 0, 0);
+		if (ret < 0)
+			return syserror("failure: make dumpable");
+	}
+
+	ret = write_nointr(h->fd_event, "1", 1);
+	if (ret < 0)
+		return syserror("failure: write to socketpair");
+
+	ret = create_userns_hierarchy(++h);
+	if (ret < 0)
+		return syserror("failure: userns level %d", h->level);
+
+	return 0;
+}
+
+int create_userns_hierarchy(struct userns_hierarchy *h)
+{
+	int fret = -1;
+	char c;
+	int fd_socket[2];
+	int fd_userns = -EBADF, ret = -1;
+	ssize_t bytes;
+	pid_t pid;
+	char path[256];
+
+	if (h->level == MAX_USERNS_LEVEL)
+		return 0;
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, fd_socket);
+	if (ret < 0)
+		return syserror("failure: create socketpair");
+
+	/* Note the CLONE_FILES | CLONE_VM when mucking with fds and memory. */
+	h->fd_event = fd_socket[1];
+	pid = do_clone(userns_fd_cb, h, CLONE_NEWUSER | CLONE_FILES | CLONE_VM);
+	if (pid < 0) {
+		syserror("failure: userns level %d", h->level);
+		goto out_close;
+	}
+
+	ret = map_ids_from_idmap(&h->id_map, pid);
+	if (ret < 0) {
+		kill(pid, SIGKILL);
+		syserror("failure: writing id mapping for userns level %d for %d", h->level, pid);
+		goto out_wait;
+	}
+
+	if (!list_empty(&h->id_map))
+		bytes = write_nointr(fd_socket[0], "1", 1); /* Inform the child we wrote a mapping. */
+	else
+		bytes = write_nointr(fd_socket[0], "0", 1); /* Inform the child we didn't write a mapping. */
+	if (bytes < 0) {
+		kill(pid, SIGKILL);
+		syserror("failure: write to socketpair");
+		goto out_wait;
+	}
+
+	/* Wait for child to set*id() and become dumpable. */
+	bytes = read_nointr(fd_socket[0], &c, 1);
+	if (bytes < 0) {
+		kill(pid, SIGKILL);
+		syserror("failure: read from socketpair");
+		goto out_wait;
+	}
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	fd_userns = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd_userns < 0) {
+		kill(pid, SIGKILL);
+		syserror("failure: open userns level %d for %d", h->level, pid);
+		goto out_wait;
+	}
+
+	fret = 0;
+
+out_wait:
+	if (!wait_for_pid(pid) && !fret) {
+		h->fd_userns = fd_userns;
+		fd_userns = -EBADF;
+	}
+
+out_close:
+	if (fd_userns >= 0)
+		close(fd_userns);
+	close(fd_socket[0]);
+	close(fd_socket[1]);
+	return fret;
+}
+
+int add_map_entry(struct list *head,
+		  __u32 id_host,
+		  __u32 id_ns,
+		  __u32 range,
+		  idmap_type_t map_type)
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
+	list_add_tail(head, new_list);
+	return 0;
+}
diff --git a/src/idmapped-mounts/utils.h b/src/idmapped-mounts/utils.h
index 4f976f9f..9694980e 100644
--- a/src/idmapped-mounts/utils.h
+++ b/src/idmapped-mounts/utils.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <sched.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -19,6 +20,9 @@
 
 #include "missing.h"
 
+/* Maximum number of nested user namespaces in the kernel. */
+#define MAX_USERNS_LEVEL 32
+
 /* A few helpful macros. */
 #define STRLITERALLEN(x) (sizeof(""x"") - 1)
 
@@ -63,6 +67,13 @@ struct list {
 	struct list *prev;
 };
 
+struct userns_hierarchy {
+	int fd_userns;
+	int fd_event;
+	unsigned int level;
+	struct list id_map;
+};
+
 #define list_for_each(__iterator, __list) \
 	for (__iterator = (__list)->next; __iterator != __list; __iterator = __iterator->next)
 
@@ -90,6 +101,16 @@ static inline void list_add_tail(struct list *head, struct list *list)
 	__list_add(list, head->prev, head);
 }
 
+static inline void list_del(struct list *list)
+{
+	struct list *next, *prev;
+
+	next = list->next;
+	prev = list->prev;
+	next->prev = prev;
+	prev->next = next;
+}
+
 extern pid_t do_clone(int (*fn)(void *), void *arg, int flags);
 extern int get_userns_fd(unsigned long nsid, unsigned long hostid,
 			 unsigned long range);
@@ -97,5 +118,9 @@ extern int get_userns_fd_from_idmap(struct list *idmap);
 extern ssize_t read_nointr(int fd, void *buf, size_t count);
 extern int wait_for_pid(pid_t pid);
 extern ssize_t write_nointr(int fd, const void *buf, size_t count);
+extern bool switch_ids(uid_t uid, gid_t gid);
+extern int create_userns_hierarchy(struct userns_hierarchy *h);
+extern int add_map_entry(struct list *head, __u32 id_host, __u32 id_ns,
+			 __u32 range, idmap_type_t map_type);
 
 #endif /* __IDMAP_UTILS_H */
-- 
2.27.0

