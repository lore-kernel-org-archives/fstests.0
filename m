Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31857C001B0
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Aug 2023 21:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjHIVDW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHIVDV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Aug 2023 17:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F14D1724
        for <fstests@vger.kernel.org>; Wed,  9 Aug 2023 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691614955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2DlF26TGGikWAJjzVdPWWtLvI1HE6xOKhSiw8HRoLVc=;
        b=KXFPoHupZ3kyE7Pu5uZ/MRW6NeLS6eBwsJ8HQfXlBemKjkq97ED/kuoW4lmCjIUypTOXzk
        V4WV75TcsRBAta9tKwO2OI3rKGieQwWBDBVbeJQXI/gta/MFg/Ob3aMUQUDUgNqqWsNgQA
        eRq5NQ04o4eRCTZM7v1Y9zpBelnOQPo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-q-JA83ElMNyRaXG2FPdFdw-1; Wed, 09 Aug 2023 17:02:33 -0400
X-MC-Unique: q-JA83ElMNyRaXG2FPdFdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F33A85CCE2;
        Wed,  9 Aug 2023 21:02:33 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CE0140C2077;
        Wed,  9 Aug 2023 21:02:33 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     fstests@vger.kernel.org
Cc:     cluster-devel@redhat.com, jlayton@kernel.org, aahringo@redhat.com
Subject: [RFC xfstests] generic: add fcntl corner cases tests
Date:   Wed,  9 Aug 2023 17:02:28 -0400
Message-Id: <20230809210228.2068122-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch adds generic 730 testcase. It will test on various fcntl()
corner cases that was making problems on a GFS2 filesystem. GFS2 has
it's own lock() implementation that has it's own posix lock
implementation behind it. There are testcases to find issues with struct
file_lock matches. Currently the Linux kernel does not have a unique
identifier per lock request to e.g. find the original lock request when
a complete handler of an async lock request comes back. The current way
is to use struct file_lock fields to fine the original lock request.
However there was issues being found that in some cases it wasn't an
unique match because multiple pending struct file_lock could have the
same state. To find issues the testcases fcntl_lock_equal_file_lock and
fcntl_lock_same_owner are introduced and their OFD variants.

Other test like fcntl_lock_kill_child tests cleanup routines when a
process blocking in F_SETLKW to wait the lock request getting granted
and the process gets killed.

A similar test is fcntl_lock_signal_interrupt which checks for
side-effects e.g. unlock all previous acquired locks when a blocking
F_SETLKW gets interrupted by a signal.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 src/Makefile                         |   5 +-
 src/fcntl_lock_equal_file_lock.c     | 140 +++++++++++++++++++++++
 src/fcntl_lock_equal_file_lock_ofd.c | 144 ++++++++++++++++++++++++
 src/fcntl_lock_kill_child.c          | 148 +++++++++++++++++++++++++
 src/fcntl_lock_same_owner.c          | 146 ++++++++++++++++++++++++
 src/fcntl_lock_same_owner_ofd.c      | 144 ++++++++++++++++++++++++
 src/fcntl_lock_signal_interrupt.c    | 159 +++++++++++++++++++++++++++
 tests/generic/730                    |  70 ++++++++++++
 tests/generic/730.out                |   2 +
 9 files changed, 957 insertions(+), 1 deletion(-)
 create mode 100644 src/fcntl_lock_equal_file_lock.c
 create mode 100644 src/fcntl_lock_equal_file_lock_ofd.c
 create mode 100644 src/fcntl_lock_kill_child.c
 create mode 100644 src/fcntl_lock_same_owner.c
 create mode 100644 src/fcntl_lock_same_owner_ofd.c
 create mode 100644 src/fcntl_lock_signal_interrupt.c
 create mode 100755 tests/generic/730
 create mode 100644 tests/generic/730.out

diff --git a/src/Makefile b/src/Makefile
index 24cd4747..e633f748 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -19,7 +19,10 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
-	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault
+	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault \
+	fcntl_lock_equal_file_lock fcntl_lock_equal_file_lock_ofd \
+	fcntl_lock_kill_child fcntl_lock_same_owner fcntl_lock_same_owner_ofd \
+	fcntl_lock_signal_interrupt
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/fcntl_lock_equal_file_lock.c b/src/fcntl_lock_equal_file_lock.c
new file mode 100644
index 00000000..38b111c5
--- /dev/null
+++ b/src/fcntl_lock_equal_file_lock.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This program tests fcntl() operations that have two
+ * of struct file_lock in the kernel in waiting state. Those
+ * two struct file_lock have exact the identitcal fields. Currently
+ * the Linux kernel matches lock requests by file_lock fields and not
+ * by an unique identifiers. There is a verifier to check if the
+ * posix locks got unlocked.
+ */
+
+#include <sys/wait.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+
+static const char *filename;
+static int fd;
+
+static void *do_equal_file_lock_thread0(void *arg)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd, F_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	return NULL;
+}
+
+static void *do_equal_file_lock_thread1(void *arg)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd, F_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	return NULL;
+}
+
+static void do_setup()
+{
+	fd = open(filename, O_RDWR | O_CREAT, 0700);
+	if (fd == -1)
+		_exit(1);
+}
+
+static void do_teardown()
+{
+	close(fd);
+}
+
+static void do_equal_file_lock()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	pthread_t t[2];
+	int pid, rv;
+
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	pid = fork();
+	if (pid == 0) {
+		rv = pthread_create(&t[0], NULL, do_equal_file_lock_thread0, NULL);
+		if (rv != 0)
+			_exit(1);
+
+		rv = pthread_create(&t[1], NULL, do_equal_file_lock_thread1, NULL);
+		if (rv != 0)
+			_exit(1);
+
+		pthread_join(t[0], NULL);
+		pthread_join(t[1], NULL);
+
+		_exit(0);
+	}
+
+	/* wait threads should block */
+	sleep(3);
+
+	fl.l_type = F_UNLCK;
+	fl.l_start = 0;
+	fl.l_len = 1;
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	sleep(3);
+
+	/* check if the lock() implementation got the
+	 * right locks because two waiter with the
+	 * same file_lock fields are waiting.
+	 */
+	fl.l_type = F_WRLCK;
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1 && errno == EAGAIN)
+		_exit(1);
+
+	wait(NULL);
+}
+
+static void usage(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s {filename}\n", argv0);
+	_exit(1);
+}
+
+int main(int argc, const char *argv[])
+{
+	if (argc != 2)
+		usage(argv[0]);
+
+	filename = argv[1];
+
+	do_setup();
+	do_equal_file_lock();
+	do_teardown();
+
+	return 0;
+}
diff --git a/src/fcntl_lock_equal_file_lock_ofd.c b/src/fcntl_lock_equal_file_lock_ofd.c
new file mode 100644
index 00000000..a9f6b06b
--- /dev/null
+++ b/src/fcntl_lock_equal_file_lock_ofd.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This program tests fcntl() operations that have two
+ * of struct file_lock in the kernel in waiting state. Those
+ * two struct file_lock have exact the identitcal fields. Currently
+ * the Linux kernel matches lock requests by file_lock fields and not
+ * by an unique identifiers. This does the same test as
+ * fcntl_lock_equal_file_lock does just with OFD posix locks.
+ * There is a verifier to check if the right posix locks got unlocked.
+ */
+
+#include <sys/wait.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+
+static const char *filename;
+static int fd[2];
+
+static void do_setup()
+{
+	fd[0] = open(filename, O_RDWR | O_CREAT, 0700);
+	if (fd[0] == -1)
+		goto error;
+
+	fd[1] = open(filename, O_RDWR, 0700);
+	if (fd[1] == -1)
+		goto fd0;
+
+	return;
+
+fd0:
+	close(fd[0]);
+error:
+	_exit(1);
+}
+
+static void do_teardown()
+{
+	close(fd[0]);
+	close(fd[1]);
+}
+
+static void do_equal_file_lock_ofd_child0()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd[1], F_OFD_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+}
+
+static void do_equal_file_lock_ofd_child1()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd[1], F_OFD_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+}
+
+static void do_equal_file_lock_ofd()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	int pid, rv;
+
+	rv = fcntl(fd[0], F_OFD_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	pid = fork();
+	if (pid == 0) {
+		do_equal_file_lock_ofd_child0();
+		_exit(0);
+	}
+
+	pid = fork();
+	if (pid == 0) {
+		do_equal_file_lock_ofd_child1();
+		_exit(0);
+	}
+
+	/* wait childs should block */
+	sleep(3);
+
+	fl.l_type = F_UNLCK;
+	fl.l_start = 0;
+	fl.l_len = 1;
+	rv = fcntl(fd[0], F_OFD_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	sleep(3);
+
+	/* check if the lock() implementation got the
+	 * right locks because two waiter with the
+	 * same file_lock fields were waiting.
+	 */
+	fl.l_type = F_WRLCK;
+	rv = fcntl(fd[0], F_OFD_SETLK, &fl);
+	if (!(rv == -1 && errno == EAGAIN))
+		_exit(1);
+
+	wait(NULL);
+}
+
+static void usage(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s {filename}\n", argv0);
+	_exit(1);
+}
+
+int main(int argc, const char *argv[])
+{
+	if (argc != 2)
+		usage(argv[0]);
+
+	filename = argv[1];
+
+	do_setup();
+	do_equal_file_lock_ofd();
+	do_teardown();
+
+	return 0;
+}
diff --git a/src/fcntl_lock_kill_child.c b/src/fcntl_lock_kill_child.c
new file mode 100644
index 00000000..60a992bb
--- /dev/null
+++ b/src/fcntl_lock_kill_child.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This program tests fcntl() operations that have two
+ * fcntl() calls in waiting state in two different childs but the
+ * fl_owner value is the same because using OFD locks. One of the
+ * blocked childs get killed. There is a verifier at the end if
+ * the right posix lock got unlocked when killing the child.
+ *
+ */
+
+#include <sys/wait.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+
+static const char *filename;
+static int fd[2];
+
+static void do_setup()
+{
+	fd[0] = open(filename, O_RDWR | O_CREAT, 0700);
+	if (fd[0] == -1)
+		goto error;
+
+	fd[1] = open(filename, O_RDWR, 0700);
+	if (fd[1] == -1)
+		goto fd0;
+
+	return;
+
+fd0:
+	close(fd[0]);
+error:
+	_exit(1);
+}
+
+static void do_teardown()
+{
+	close(fd[0]);
+	close(fd[1]);
+}
+
+static void do_to_be_killed_child()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd[1], F_OFD_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+}
+
+static void do_blocking_child()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 1L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd[1], F_OFD_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+}
+
+static void do_kill_child_setlkw()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 2L,
+	};
+	int pid_to_kill, pid, rv;
+
+	rv = fcntl(fd[0], F_OFD_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	pid_to_kill = fork();
+	if (pid_to_kill == 0) {
+		do_to_be_killed_child();
+		_exit(0);
+	}
+
+	pid = fork();
+	if (pid == 0) {
+		do_blocking_child();
+		_exit(0);
+	}
+
+	/* wait childs should block */
+	sleep(3);
+
+	kill(pid_to_kill, SIGKILL);
+
+	/* wait until Linux did plock cleanup */
+
+	sleep(3);
+
+	/* check if the lock() implementation got the
+	 * right lock because two waiter with the
+	 * same fl_owner were waiting.
+	 */
+	fl.l_type = F_WRLCK;
+	rv = fcntl(fd[0], F_OFD_SETLK, &fl);
+	if ((rv == -1 && errno == EAGAIN))
+		_exit(1);
+
+	fl.l_type = F_UNLCK;
+	fl.l_start = 1;
+	fl.l_len = 1;
+	rv = fcntl(fd[0], F_OFD_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	wait(NULL);
+}
+
+static void usage(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s {filename}\n", argv0);
+	_exit(1);
+}
+
+int main(int argc, const char *argv[])
+{
+	if (argc != 2)
+		usage(argv[0]);
+
+	filename = argv[1];
+
+	do_setup();
+	do_kill_child_setlkw();
+	do_teardown();
+
+	return 0;
+}
diff --git a/src/fcntl_lock_same_owner.c b/src/fcntl_lock_same_owner.c
new file mode 100644
index 00000000..071a3b49
--- /dev/null
+++ b/src/fcntl_lock_same_owner.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This program tests fcntl() operations that have two
+ * fcntl() calls in waiting state in two different threads.
+ * Those fcntl() ends in a struct file_lock have the same fl_owner
+ * field. One fcntl() call gets granted, there will be a verifier
+ * going on if the right lock was granted.
+ */
+
+#include <sys/wait.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+
+static const char *filename;
+static int fd;
+
+static void *do_same_owner_thread0(void *arg)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd, F_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	return NULL;
+}
+
+static void *do_same_owner_thread1(void *arg)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 1L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd, F_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	return NULL;
+}
+
+static void do_setup()
+{
+	fd = open(filename, O_RDWR | O_CREAT, 0700);
+	if (fd == -1)
+		_exit(1);
+}
+
+static void do_teardown()
+{
+	close(fd);
+}
+
+static void do_same_owner()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 2L,
+	};
+	pthread_t t[2];
+	int pid, rv;
+
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	pid = fork();
+	if (pid == 0) {
+		rv = pthread_create(&t[0], NULL, do_same_owner_thread0, NULL);
+		if (rv != 0)
+			_exit(1);
+
+		rv = pthread_create(&t[1], NULL, do_same_owner_thread1, NULL);
+		if (rv != 0)
+			_exit(1);
+
+		pthread_join(t[0], NULL);
+		pthread_join(t[1], NULL);
+
+		_exit(0);
+	}
+
+	/* wait threads should block */
+	sleep(3);
+
+	fl.l_type = F_UNLCK;
+	fl.l_start = 1;
+	fl.l_len = 1;
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	sleep(3);
+
+	/* check if the lock() implementation got the
+	 * right lock because two waiter with the
+	 * same fl_owner were waiting.
+	 */
+	fl.l_type = F_WRLCK;
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (!(rv == -1 && errno == EAGAIN))
+		_exit(1);
+
+	fl.l_type = F_UNLCK;
+	fl.l_start = 1;
+	fl.l_len = 1;
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	wait(NULL);
+}
+
+static void usage(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s {filename}\n", argv0);
+	_exit(1);
+}
+
+int main(int argc, const char *argv[])
+{
+	if (argc != 2)
+		usage(argv[0]);
+
+	filename = argv[1];
+
+	do_setup();
+	do_same_owner();
+	do_teardown();
+
+	return 0;
+}
diff --git a/src/fcntl_lock_same_owner_ofd.c b/src/fcntl_lock_same_owner_ofd.c
new file mode 100644
index 00000000..d5addfb5
--- /dev/null
+++ b/src/fcntl_lock_same_owner_ofd.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This program tests fcntl() operations that have two
+ * fcntl() calls in waiting state in two different threads.
+ * Those fcntl() ends in a struct file_lock have the same fl_owner
+ * field. One fcntl() call gets granted, there will be a verifier
+ * going on if the right lock was granted.
+ *
+ * This test is the same like fcntl_lock_same_owner but using OFD
+ * locks.
+ */
+
+#include <sys/wait.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+
+static const char *filename;
+static int fd[2];
+
+static void do_setup()
+{
+	fd[0] = open(filename, O_RDWR | O_CREAT, 0700);
+	if (fd[0] == -1)
+		goto error;
+
+	fd[1] = open(filename, O_RDWR, 0700);
+	if (fd[1] == -1)
+		goto fd0;
+
+	return;
+
+fd0:
+	close(fd[0]);
+error:
+	_exit(1);
+}
+
+static void do_teardown()
+{
+	close(fd[0]);
+	close(fd[1]);
+}
+
+static void do_same_owner_ofd_child0()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd[1], F_OFD_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+}
+
+static void do_same_owner_ofd_child1()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 1L,
+		.l_len = 1L,
+	};
+	int rv;
+
+	rv = fcntl(fd[1], F_OFD_SETLKW, &fl);
+	if (rv == -1)
+		_exit(1);
+}
+
+static void do_same_owner_ofd()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 2L,
+	};
+	int pid, rv;
+
+	rv = fcntl(fd[0], F_OFD_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	pid = fork();
+	if (pid == 0) {
+		do_same_owner_ofd_child0();
+		_exit(0);
+	}
+
+	pid = fork();
+	if (pid == 0) {
+		do_same_owner_ofd_child1();
+		_exit(0);
+	}
+
+	/* wait childs should block */
+	sleep(3);
+
+	fl.l_type = F_UNLCK;
+	fl.l_start = 1;
+	fl.l_len = 1;
+	rv = fcntl(fd[0], F_OFD_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	sleep(3);
+
+	/* check if the lock() implementation granted
+	 * the locks.
+	 */
+	fl.l_type = F_WRLCK;
+	rv = fcntl(fd[0], F_OFD_SETLK, &fl);
+	if (rv == -1 && errno == EAGAIN)
+		_exit(1);
+
+	wait(NULL);
+}
+
+static void usage(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s {filename}\n", argv0);
+	_exit(1);
+}
+
+int main(int argc, const char *argv[])
+{
+	if (argc != 2)
+		usage(argv[0]);
+
+	filename = argv[1];
+
+	do_setup();
+	do_same_owner_ofd();
+	do_teardown();
+
+	return 0;
+}
diff --git a/src/fcntl_lock_signal_interrupt.c b/src/fcntl_lock_signal_interrupt.c
new file mode 100644
index 00000000..af3008f1
--- /dev/null
+++ b/src/fcntl_lock_signal_interrupt.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This program tests fcntl() operations in the child process
+ * that have one lock acquired and sitting in a blocked fcntl()
+ * F_SETLKW call to get granted. The blocked fcntl() call will be
+ * interrupted by a signal that will cancel the blocked fcntl() call.
+ * Afterwards there is a verifier that the previous lock which wasn't
+ * cancelled is still acquired by the child.
+ */
+
+#include <sys/wait.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+
+struct pipe_msg {
+	int rv;
+};
+
+static const char *filename;
+static int pfd[2];
+static int fd;
+
+static void do_setup()
+{
+	int rv;
+
+	rv = pipe(pfd);
+	if (rv == -1)
+		goto error;
+
+	fd = open(filename, O_RDWR | O_CREAT, 0700);
+	if (fd == -1)
+		goto pipe;
+
+	return;
+
+pipe:
+	close(pfd[0]);
+	close(pfd[1]);
+
+error:
+	_exit(1);
+}
+
+static void do_teardown()
+{
+	close(fd);
+
+	close(pfd[0]);
+	close(pfd[1]);
+}
+
+static void catch_alarm(int num) { }
+
+static void do_signal_interrupt_setlkw_child(void)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 1L,
+		.l_len = 1L,
+	};
+	struct sigaction act;
+	struct pipe_msg msg;
+	int rv;
+
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	memset(&act, 0, sizeof(act));
+	act.sa_handler = catch_alarm;
+	sigemptyset(&act.sa_mask);
+	sigaddset(&act.sa_mask, SIGALRM);
+	sigaction(SIGALRM, &act, NULL);
+
+	fl.l_start = 0;
+
+	/* interrupt SETLKW by signal in 3 secs */
+	alarm(3);
+	rv = fcntl(fd, F_SETLKW, &fl);
+	if (rv == -1 && errno == EINTR)
+		msg.rv = 0;
+	else
+		msg.rv = 1;
+
+	write(pfd[1], &msg, sizeof(msg));
+
+	/* keep child alive */
+	read(pfd[1], &msg, sizeof(msg));
+}
+
+static void do_signal_interrupt_setlkw()
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start = 0L,
+		.l_len = 1L,
+	};
+	struct pipe_msg msg;
+	int pid, rv;
+
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1)
+		_exit(1);
+
+	pid = fork();
+	if (pid == 0) {
+		do_signal_interrupt_setlkw_child();
+		_exit(0);
+	}
+
+	/* wait until child writes */
+	read(pfd[0], &msg, sizeof(msg));
+
+	fl.l_type = F_WRLCK;
+	fl.l_start = 1;
+	fl.l_len = 1;
+	rv = fcntl(fd, F_SETLK, &fl);
+	/* parent testing childs region, the child will think
+	 * it has region 1-1 locked because it was interrupted
+	 * by region 0-0. Due bugs the interruption also unlocked
+	 * region 1-1.
+	 */
+	if (rv == -1 && errno == EAGAIN)
+		rv = 0;
+	else
+		rv = 1;
+
+	write(pfd[0], &msg, sizeof(msg));
+
+	wait(NULL);
+	_exit(rv);
+}
+
+static void usage(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s {filename}\n", argv0);
+	_exit(1);
+}
+
+int main(int argc, const char *argv[])
+{
+	if (argc != 2)
+		usage(argv[0]);
+
+	filename = argv[1];
+
+	do_setup();
+	do_signal_interrupt_setlkw();
+	do_teardown();
+
+	return 0;
+}
diff --git a/tests/generic/730 b/tests/generic/730
new file mode 100755
index 00000000..4a1e7f20
--- /dev/null
+++ b/tests/generic/730
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
+#
+# FS QA Test 730
+#
+# This tests performs some fcntl() corner cases when
+# two waiter have the same or some (fl_owner) fields. In Linux
+# there exists no unique lock request identifier, some lock()
+# filesystem implementation does that over struct file_lock fields.
+# Other tests check for bad side-effects if a blocking F_SETLKW lock
+# request got interrupted or the process got killed.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+_require_test_program fcntl_lock_equal_file_lock
+_require_test_program fcntl_lock_equal_file_lock_ofd
+_require_test_program fcntl_lock_kill_child
+_require_test_program fcntl_lock_same_owner
+_require_test_program fcntl_lock_same_owner_ofd
+_require_test_program fcntl_lock_signal_interrupt
+
+echo "Silence is golden"
+
+$here/src/fcntl_lock_equal_file_lock $TEST_DIR/testfile
+if [ $? -ne 0 ]
+then
+	exit
+fi
+
+$here/src/fcntl_lock_equal_file_lock_ofd $TEST_DIR/testfile
+if [ $? -ne 0 ]
+then
+	exit
+fi
+
+$here/src/fcntl_lock_kill_child $TEST_DIR/testfile
+if [ $? -ne 0 ]
+then
+	exit
+fi
+
+$here/src/fcntl_lock_same_owner $TEST_DIR/testfile
+if [ $? -ne 0 ]
+then
+	exit
+fi
+
+$here/src/fcntl_lock_same_owner_ofd $TEST_DIR/testfile
+if [ $? -ne 0 ]
+then
+	exit
+fi
+
+$here/src/fcntl_lock_signal_interrupt $TEST_DIR/testfile
+if [ $? -ne 0 ]
+then
+	exit
+fi
+
+status=0
+exit
diff --git a/tests/generic/730.out b/tests/generic/730.out
new file mode 100644
index 00000000..50c3c832
--- /dev/null
+++ b/tests/generic/730.out
@@ -0,0 +1,2 @@
+QA output created by 730
+Silence is golden
-- 
2.31.1

