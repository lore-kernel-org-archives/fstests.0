Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E895CD54BE
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Sep 2023 20:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjIYUTh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Sep 2023 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYUTg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Sep 2023 16:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA99B
        for <fstests@vger.kernel.org>; Mon, 25 Sep 2023 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695673125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N2yo7sm5JDcA1ekhS/+/mKj7Ld7WMG6uboU7+c0eat4=;
        b=Dj4kxNvRJtm8lFSclXshzaCHSXqvVE/qMahu2gzwHTxtXLl/lZaxhY85tw+KenZoxg+rGF
        rSZ666FiOl3Pq+jXr2+3J/54cbCECeO3ciI2RfHywFYC6/OGOQJ70J9+X1YgWnTXBC4xJd
        1eYAGQyAkCm7pM8mcTd5xJuJyiJFUQI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-spSw1iKdOUCSWCTs7ojmCw-1; Mon, 25 Sep 2023 16:18:41 -0400
X-MC-Unique: spSw1iKdOUCSWCTs7ojmCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A58B21C00BA0;
        Mon, 25 Sep 2023 20:18:40 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75755C15BB8;
        Mon, 25 Sep 2023 20:18:40 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, gfs2@lists.linux.dev, jlayton@kernel.org,
        aahringo@redhat.com
Subject: [PATCHv2] generic: add fcntl corner cases tests
Date:   Mon, 25 Sep 2023 16:18:27 -0400
Message-Id: <20230925201827.1703857-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch adds fcntl corner cases that was being used to confirm issues
on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
implementation and in those corner cases issues was being found and
fixed.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
changes since v2:
- move fcntl tests into one fcntl c file
- remove ofd and same owner tests, should be reflected by only one test
- simplify commit message (remove testname out of it)
- add error messages in fcntl.c to give more information if an error
  occur

 src/Makefile          |   3 +-
 src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/732     |  32 +++++
 tests/generic/732.out |   2 +
 4 files changed, 358 insertions(+), 1 deletion(-)
 create mode 100644 src/fcntl.c
 create mode 100755 tests/generic/732
 create mode 100644 tests/generic/732.out

diff --git a/src/Makefile b/src/Makefile
index 2815f919..67f936d3 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
-	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
+	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
+	fcntl
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/fcntl.c b/src/fcntl.c
new file mode 100644
index 00000000..8e375357
--- /dev/null
+++ b/src/fcntl.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
+ */
+
+#include <pthread.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <wait.h>
+
+static char filename[PATH_MAX + 1];
+static int fd;
+
+static void usage(char *name, const char *msg)
+{
+	printf("Fatal: %s\nUsage:\n"
+	       "%s <file for fcntl>\n", msg, name);
+	_exit(1);
+}
+
+static void *do_equal_file_lock_thread(void *arg)
+{
+       struct flock fl = {
+	       .l_type = F_WRLCK,
+	       .l_whence = SEEK_SET,
+	       .l_start = 0L,
+	       .l_len = 1L,
+       };
+       int rv;
+
+       rv = fcntl(fd, F_SETLKW, &fl);
+       if (rv == -1) {
+	       perror("fcntl");
+	       _exit(1);
+       }
+
+       return NULL;
+}
+
+static void do_test_equal_file_lock(void)
+{
+	struct flock fl;
+	pthread_t t[2];
+	int pid, rv;
+
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0L;
+	fl.l_len = 1L;
+
+	/* acquire range 0-0 */
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1) {
+	       perror("fcntl");
+		_exit(1);
+	}
+
+	pid = fork();
+	if (pid == 0) {
+		rv = pthread_create(&t[0], NULL, do_equal_file_lock_thread, NULL);
+		if (rv != 0) {
+			fprintf(stderr, "failed to create pthread\n");
+			_exit(1);
+		}
+
+		rv = pthread_create(&t[1], NULL, do_equal_file_lock_thread, NULL);
+		if (rv != 0) {
+			fprintf(stderr, "failed to create pthread\n");
+			_exit(1);
+		}
+
+		pthread_join(t[0], NULL);
+		pthread_join(t[1], NULL);
+
+		_exit(0);
+	}
+
+	/* wait until threads block on 0-0 */
+	sleep(3);
+
+	fl.l_type = F_UNLCK;
+	fl.l_start = 0;
+	fl.l_len = 1;
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1) {
+		perror("fcntl");
+		_exit(1);
+	}
+
+	sleep(3);
+
+	/* check if the ->lock() implementation got the
+	 * right locks granted because two waiter with the
+	 * same file_lock fields are waiting
+	 */
+	fl.l_type = F_WRLCK;
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1 && errno == EAGAIN) {
+		fprintf(stderr, "deadlock, pthread not cleaned up correctly\n");
+		_exit(1);
+	}
+
+	wait(NULL);
+}
+
+static void catch_alarm(int num) { }
+
+static void do_test_signal_interrupt_child(int *pfd)
+{
+	struct sigaction act;
+	unsigned char m;
+	struct flock fl;
+	int rv;
+
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 1;
+	fl.l_len = 1;
+
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1) {
+		perror("fcntl");
+		_exit(1);
+	}
+
+	memset(&act, 0, sizeof(act));
+	act.sa_handler = catch_alarm;
+	sigemptyset(&act.sa_mask);
+	sigaddset(&act.sa_mask, SIGALRM);
+	sigaction(SIGALRM, &act, NULL);
+
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0;
+	fl.l_len = 1;
+
+	/* interrupt SETLKW by signal in 3 secs */
+	alarm(3);
+	rv = fcntl(fd, F_SETLKW, &fl);
+	if (rv == 0) {
+		fprintf(stderr, "fcntl interrupt successful but should fail with EINTR\n");
+		_exit(1);
+	}
+
+	/* synchronize to move parent to test region 1-1 */
+	write(pfd[1], &m, sizeof(m));
+
+	/* keep child alive */
+	read(pfd[1], &m, sizeof(m));
+}
+
+static void do_test_signal_interrupt(void)
+{
+	struct flock fl;
+	unsigned char m;
+	int pid, rv;
+	int pfd[2];
+
+	rv = pipe(pfd);
+	if (rv == -1) {
+		perror("pipe");
+		_exit(1);
+	}
+
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0;
+	fl.l_len = 1;
+
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1) {
+		perror("fcntl");
+		_exit(1);
+	}
+
+	pid = fork();
+	if (pid == 0) {
+		do_test_signal_interrupt_child(pfd);
+		_exit(0);
+	}
+
+	/* wait until child writes */
+	read(pfd[0], &m, sizeof(m));
+
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 1;
+	fl.l_len = 1;
+	/* parent testing childs region, the child will think
+	 * it has region 1-1 locked because it was interrupted
+	 * by region 0-0. Due bugs the interruption also unlocked
+	 * region 1-1.
+	 */
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == 0) {
+		fprintf(stderr, "fcntl trylock successful but should fail because child still acquires region\n");
+		_exit(1);
+	}
+
+	write(pfd[0], &m, sizeof(m));
+
+	wait(NULL);
+
+	close(pfd[0]);
+	close(pfd[1]);
+
+	/* cleanup everything */
+	fl.l_type = F_UNLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0;
+	fl.l_len = 2;
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1) {
+		perror("fcntl");
+		_exit(1);
+	}
+}
+
+static void do_test_kill_child(void)
+{
+	struct flock fl;
+	int rv;
+
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0;
+	fl.l_len = 1;
+
+	rv = fcntl(fd, F_SETLKW, &fl);
+	if (rv == -1) {
+		perror("fcntl");
+		_exit(1);
+	}
+}
+
+static void do_test_kill(void)
+{
+	struct flock fl;
+	int pid_to_kill;
+	int rv;
+
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0;
+	fl.l_len = 1;
+
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1) {
+		perror("fcntl");
+		_exit(1);
+	}
+
+	pid_to_kill = fork();
+	if (pid_to_kill == 0) {
+		do_test_kill_child();
+		_exit(0);
+	}
+
+	/* wait until child blocks */
+	sleep(3);
+
+	kill(pid_to_kill, SIGKILL);
+
+	/* wait until Linux did plock cleanup */
+	sleep(3);
+
+	fl.l_type = F_UNLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0;
+	fl.l_len = 1;
+
+	/* cleanup parent lock */
+	rv = fcntl(fd, F_SETLK, &fl);
+	if (rv == -1) {
+		perror("fcntl");
+		_exit(1);
+	}
+
+	fl.l_type = F_WRLCK;
+	fl.l_whence = SEEK_SET;
+	fl.l_start = 0;
+	fl.l_len = 1;
+
+	/* check if the child still holds the lock
+	 * and killing the child was not cleaning
+	 * up locks.
+	 */
+	rv = fcntl(fd, F_SETLK, &fl);
+	if ((rv == -1 && errno == EAGAIN)) {
+		fprintf(stderr, "fcntl trylock failed but should be successful because killing child should cleanup acquired lock\n");
+		_exit(1);
+	}
+}
+
+int main(int argc, char * const argv[])
+{
+	if (optind != argc - 1)
+		usage(argv[0], "<file for fcntl> is mandatory to tell the file where to run fcntl() on it");
+
+	strncpy(filename, argv[1], PATH_MAX);
+
+	fd = open(filename, O_RDWR | O_CREAT, 0700);
+	if (fd == -1) {
+		perror("open");
+		_exit(1);
+	}
+
+	/* test to have to equal struct file_lock requests in ->lock() */
+	do_test_equal_file_lock();
+	/* test to interrupt F_SETLKW by a signal and cleanup only canceled the pending interrupted request */
+	do_test_signal_interrupt();
+	/* test if cleanup is correct if a child gets killed while being blocked in F_SETLKW */
+	do_test_kill();
+
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/generic/732 b/tests/generic/732
new file mode 100755
index 00000000..d77f9fc2
--- /dev/null
+++ b/tests/generic/732
@@ -0,0 +1,32 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
+#
+# FS QA Test 732
+#
+# This tests performs some fcntl() corner cases. See fcntl test
+# program for more details.
+#
+. ./common/preamble
+_begin_fstest auto
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_test
+_require_test_program fcntl
+
+echo "Silence is golden"
+
+$here/src/fcntl $TEST_DIR/testfile
+if [ $? -ne 0 ]
+then
+	exit
+fi
+
+status=0
+exit
diff --git a/tests/generic/732.out b/tests/generic/732.out
new file mode 100644
index 00000000..451f82ce
--- /dev/null
+++ b/tests/generic/732.out
@@ -0,0 +1,2 @@
+QA output created by 732
+Silence is golden
-- 
2.31.1

