Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45166 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbaFKESC (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Jun 2014 00:18:02 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5B4I25R010572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2014 00:18:02 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] generic: new case to test getcwd(2)
Date: Wed, 11 Jun 2014 12:17:33 +0800
Message-Id: <1402460253-11237-1-git-send-email-eguan@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, Artem Savkov <asavkov@redhat.com>, Jan Stancek <jstancek@redhat.com>
List-ID: <fstests@vger.kernel.org>

The following kernel commit introduced a race condition that causes
getcwd(2) to return "/" instead of correct path

232d2d6 dcache: Translating dentry into pathname without taking rename_lock

Jan Stancek hit it once when building ltp and Mikulas Patocka could
hit it by running lvm2 test suite. Please refer to this thread

https://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg17896.html

These commits fixed the bug
ede4ceb prepend_path() needs to reinitialize dentry/vfsmount/mnt on restarts
f650080 __dentry_path() fixes

Cc: Artem Savkov <asavkov@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---

This case was originally written by Artem Savkov and I made minor
updates and ported it to xfstests.

v2:
 - write detailed description and commit log
 - reduce run time to 5s and add quick group
 - return error when $CWD changes
 - delete the code that removes $seqres.full
 - run test in $TEST_DIR not xfstests dir

 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/t_getcwd.c        | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/028     |  58 ++++++++++++++++++++++++++++
 tests/generic/028.out |   2 +
 tests/generic/group   |   1 +
 6 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 src/t_getcwd.c
 create mode 100755 tests/generic/028
 create mode 100644 tests/generic/028.out

diff --git a/.gitignore b/.gitignore
index 66e6ee8..5353439 100644
--- a/.gitignore
+++ b/.gitignore
@@ -83,6 +83,7 @@
 /src/t_dir_offset
 /src/t_dir_offset2
 /src/t_futimens
+/src/t_getcwd
 /src/t_holes
 /src/t_immutable
 /src/t_mmap_writev
diff --git a/src/Makefile b/src/Makefile
index d754048..7a7984a 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -19,7 +19,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
 	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
-	renameat2
+	renameat2 t_getcwd
 
 SUBDIRS =
 
diff --git a/src/t_getcwd.c b/src/t_getcwd.c
new file mode 100644
index 0000000..27255bd
--- /dev/null
+++ b/src/t_getcwd.c
@@ -0,0 +1,102 @@
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#define TIMEOUT 5
+#define BUF_SIZE 256
+
+static sig_atomic_t end;
+
+int test_getcwd(char *init_cwd)
+{
+	int i = 0;
+	char cur_cwd[BUF_SIZE];
+	while (1) {
+		getcwd(cur_cwd, BUF_SIZE);
+		if (strncmp(init_cwd, cur_cwd, BUF_SIZE)) {
+			printf("[%u] %s != %s\n", i, init_cwd, cur_cwd);
+			return 1;
+		}
+		if (end)
+			break;
+		i++;
+	}
+	return 0;
+}
+
+void do_rename(char *prefix)
+{
+	int i = 0;
+	int fd;
+	char c_name[BUF_SIZE];
+	char n_name[BUF_SIZE];
+
+	strncpy(c_name, prefix, BUF_SIZE);
+
+	fd = open(c_name, O_CREAT | O_RDWR, 0644);
+	if (fd < 0) {
+		fprintf(stderr, "failed to create file %s: %s\n",
+			c_name, strerror(errno));
+		exit(1);
+	}
+	close(fd);
+
+	while (1) {
+		i++;
+		snprintf(n_name, BUF_SIZE, "%s%u", prefix, i);
+		rename(c_name, n_name);
+		strncpy(c_name, n_name, BUF_SIZE);
+	}
+}
+
+void sigproc(int sig)
+{
+	end = 1;
+}
+
+int main(int argc, char *argv[])
+{
+	char *init_cwd;
+	pid_t pid;
+	int status;
+	int ret = 1;
+
+	if (argc != 2) {
+		printf("Usage: %s <dir>\n", argv[0]);
+		exit(1);
+	}
+
+	init_cwd = argv[1];
+	ret = chdir(init_cwd);
+	if (ret < 0) {
+		perror("chdir failed");
+		exit(1);
+	}
+
+	if (signal(SIGALRM, sigproc) == SIG_ERR) {
+		perror("signal failed");
+		exit(1);
+	}
+
+	alarm(TIMEOUT);
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork failed");
+		exit(1);
+	} else if (pid == 0) {
+		do_rename("t_getcwd_testfile");
+	} else {
+		ret = test_getcwd(init_cwd);
+		kill(pid, SIGTERM);
+		waitpid(pid, &status, 0);
+	}
+
+	exit(ret);
+}
diff --git a/tests/generic/028 b/tests/generic/028
new file mode 100755
index 0000000..eb3c799
--- /dev/null
+++ b/tests/generic/028
@@ -0,0 +1,58 @@
+#! /bin/bash
+# FS QA Test No. generic/028
+#
+# The following commit introduced a race condition that causes getcwd(2)
+# to return "/" instead of correct path
+#
+# 232d2d6 dcache: Translating dentry into pathname without taking rename_lock
+#
+# These commits fixed the bug
+# ede4ceb prepend_path() needs to reinitialize dentry/vfsmount/mnt on restarts
+# f650080 __dentry_path() fixes
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Red Hat Inc.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
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
+    cd /
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+echo "Silence is golden"
+
+$here/src/t_getcwd $TEST_DIR
+status=$?
+exit
diff --git a/tests/generic/028.out b/tests/generic/028.out
new file mode 100644
index 0000000..2615f73
--- /dev/null
+++ b/tests/generic/028.out
@@ -0,0 +1,2 @@
+QA output created by 028
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index e851c62..e822dfd 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -30,6 +30,7 @@
 025 auto quick
 026 acl quick auto
 027 auto enospc
+028 auto quick
 053 acl repair auto quick
 062 attr udf auto quick
 068 other auto freeze dangerous stress
-- 
1.9.3

