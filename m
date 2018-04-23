Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753889AbeDWCmw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 22 Apr 2018 22:42:52 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v2] generic: test record locks across execve
Date: Mon, 23 Apr 2018 10:42:48 +0800
Message-Id: <20180423024248.28132-1-xzhou@redhat.com>
In-Reply-To: <20180422104212.GA3333@desktop>
References: <20180422104212.GA3333@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: berrange@redhat.com, guaneryu@gmail.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

According to fcntl(2) man page, record locks are preserved across
an execve(2). This is a regression case for this.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
v2:
  Do not fork when checking lock after execve;
  More comments and some minor fixes.

Thanks Eryu for the review!
Jeff Layton's patch for this issue has not landed Linus tree.

 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/t_locks_execve.c  | 73 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/484     | 73 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/484.out |  2 ++
 tests/generic/group   |  1 +
 6 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 src/t_locks_execve.c
 create mode 100755 tests/generic/484
 create mode 100644 tests/generic/484.out

diff --git a/.gitignore b/.gitignore
index 368d11c8..192ca35e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -121,6 +121,7 @@
 /src/t_getcwd
 /src/t_holes
 /src/t_immutable
+/src/t_locks_execve
 /src/t_mmap_cow_race
 /src/t_mmap_dio
 /src/t_mmap_fallocate
diff --git a/src/Makefile b/src/Makefile
index 0d3feae1..6ca56366 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -15,7 +15,7 @@ TARGETS =3D dirstress fill fill2 getpagesize holes lsta=
t64 \
 	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
-	t_ofd_locks
+	t_ofd_locks t_locks_execve
=20
 LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_r=
eader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_locks_execve.c b/src/t_locks_execve.c
new file mode 100644
index 00000000..dae4506d
--- /dev/null
+++ b/src/t_locks_execve.c
@@ -0,0 +1,73 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <stdio.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+static void err_exit(char *op, int errn)
+{
+	fprintf(stderr, "%s: %s\n", op, strerror(errn));
+	exit(errn);
+}
+
+void *thread_fn(void *arg)
+{
+	/* execve will release threads */
+	while(1) sleep(1);
+	return NULL;
+}
+
+struct flock fl =3D {
+	.l_type =3D F_WRLCK,
+	.l_whence =3D SEEK_SET,
+	.l_start =3D 0,
+	.l_len =3D 1,
+};
+
+static void checklock(int fd)
+{
+	if (fcntl(fd, F_GETLK, &fl) < 0)
+		err_exit("getlk", errno);
+	if (fl.l_type =3D=3D F_UNLCK) {
+		printf("The write lock got released during execve\n");
+		exit(1);
+	}
+	exit(0);
+}
+
+int main(int argc, char **argv)
+{
+	int fd, flags;
+	char fdstr[10];
+	char *newargv[] =3D { argv[0], argv[1], fdstr, NULL };
+	/* passing fd in argv[2] in execve */
+	if (argc =3D=3D 3) {
+		fd =3D atoi(argv[2]);
+		checklock(fd);
+		exit(0);
+	}
+	fd =3D open(argv[1], O_WRONLY|O_CREAT, 0755);
+	if (fd < 0)
+		err_exit("open", errno);
+	if (fcntl(fd, F_SETLK, &fl) < 0)
+		err_exit("setlk", errno);
+
+	/* spawning thread is necessary to reproduce the issue */
+	pthread_t th;
+	pthread_create(&th, NULL, thread_fn, &fd);
+
+	if ((flags =3D fcntl(fd, F_GETFD)) < 0)
+		err_exit("getfd", errno);
+	flags &=3D ~FD_CLOEXEC;
+	if (fcntl(fd, F_SETFD, flags) < 0)
+		err_exit("setfd", errno);
+	snprintf(fdstr, sizeof(fdstr), "%d", fd);
+	execve(argv[0], newargv, NULL);
+	return 0;
+}
diff --git a/tests/generic/484 b/tests/generic/484
new file mode 100755
index 00000000..76ebf1fd
--- /dev/null
+++ b/tests/generic/484
@@ -0,0 +1,73 @@
+#! /bin/bash
+# FS QA Test 484
+#
+# This is testing
+#
+#  "Record locks are not inherited by a child created via fork(2),
+#   but are preserved across an execve(2)."
+#
+# from fcntl(2) man page.
+#
+# Fixed by patch from Jeff Layton:
+# locks: change POSIX lock ownership on execve when files_struct is disp=
laced
+#
+# Author: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
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
+seq=3D`basename $0`
+seqres=3D$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=3D`pwd`
+tmp=3D/tmp/$$
+status=3D1	# failure is the default!
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
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+# prepare a 4k testfile in TEST_DIR
+$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
+	$TEST_DIR/t_lock_execve_file >> $seqres.full 2>&1
+
+# run test programe
+$here/src/t_locks_execve $TEST_DIR/t_lock_execve_file
+
+# success, all done
+echo "Silence is golden"
+status=3D0
+exit
diff --git a/tests/generic/484.out b/tests/generic/484.out
new file mode 100644
index 00000000..94f2f0bd
--- /dev/null
+++ b/tests/generic/484.out
@@ -0,0 +1,2 @@
+QA output created by 484
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index ea8e51b3..798321f9 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -486,3 +486,4 @@
 481 auto quick log metadata
 482 auto metadata replay
 483 auto quick log metadata
+484 auto lock quick
--=20
2.17.0.252.gfe0a9ea

