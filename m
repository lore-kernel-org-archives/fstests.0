Received: from mx1.redhat.com ([209.132.183.28]:34058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbdFAPh7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 1 Jun 2017 11:37:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF575285C1
        for <fstests@vger.kernel.org>; Thu,  1 Jun 2017 15:37:58 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH] generic: O_CLOEXEC flag sanity check
Date: Thu,  1 Jun 2017 23:37:52 +0800
Message-Id: <1496331472-13719-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Open a few files, execve a script in which counting
the fd that still open.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/t_cloexec.c       | 41 +++++++++++++++++++++++++++++++
 src/t_cloexec.sh      |  2 ++
 tests/generic/438     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/438.out | 10 ++++++++
 tests/generic/group   |  1 +
 7 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 src/t_cloexec.c
 create mode 100755 src/t_cloexec.sh
 create mode 100755 tests/generic/438
 create mode 100644 tests/generic/438.out

diff --git a/.gitignore b/.gitignore
index a6ac25e..f754256 100644
--- a/.gitignore
+++ b/.gitignore
@@ -150,6 +150,7 @@
 /src/t_mmap_dio
 /src/t_mmap_stale_pmd
 /src/t_mmap_cow_race
+/src/t_cloexec
 
 # dmapi/ binaries
 /dmapi/src/common/cmd/read_invis
diff --git a/src/Makefile b/src/Makefile
index 4ec0197..ddcd2b0 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -13,7 +13,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
 	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
 	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
-	t_mmap_cow_race
+	t_mmap_cow_race t_cloexec
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_cloexec.c b/src/t_cloexec.c
new file mode 100644
index 0000000..3b3a008
--- /dev/null
+++ b/src/t_cloexec.c
@@ -0,0 +1,41 @@
+/*
+ * open(2) flag O_CLOEXEC sanity check.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <err.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+int main(int argc, char ** argv)
+{
+	int fds[8];
+	int i;
+	char fn[50];
+	long nc = 0;
+	char *newargv[] = { "src/t_cloexec.sh", NULL };
+	char *newenv[] = { NULL };
+
+	/* argv[2] : how many files opened with O_CLOEXEC */
+	nc= strtol(argv[2], NULL, 10);
+
+	for (i = 0; i < 8; i++) {
+
+		/* argv[1] : mountpoint being tested */
+		sprintf(fn, "%s/test_file%d", argv[1], i);
+		if (i < nc)
+			fds[i] = open(fn, O_RDONLY|O_CLOEXEC);
+		else
+			fds[i] = open(fn, O_RDONLY);
+		if (fds[i] == -1)
+			err(1, "open %s", fn);
+	}
+
+	/* exec to close fds*/
+	i = execve("src/t_cloexec.sh", newargv, newenv);
+	if (i == -1)
+		perror("execve");
+	return 0;
+}
diff --git a/src/t_cloexec.sh b/src/t_cloexec.sh
new file mode 100755
index 0000000..bdcbaf8
--- /dev/null
+++ b/src/t_cloexec.sh
@@ -0,0 +1,2 @@
+#!/bin/bash
+ls -1 /proc/self/fd/ | wc -l
diff --git a/tests/generic/438 b/tests/generic/438
new file mode 100755
index 0000000..1e58901
--- /dev/null
+++ b/tests/generic/438
@@ -0,0 +1,67 @@
+#! /bin/bash
+# FS QA Test 438
+#
+# Sanity check for open(2) flag O_CLOEXEC.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
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
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+for i in `seq 0 8` ; do
+	touch $SCRATCH_MNT/test_file$i
+done
+
+for i in `seq 0 8` ; do
+	src/t_cloexec $SCRATCH_MNT $i
+done
+
+for i in `seq 0 8` ; do
+	rm -f $SCRATCH_MNT/test_file$i
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/438.out b/tests/generic/438.out
new file mode 100644
index 0000000..56f0ed2
--- /dev/null
+++ b/tests/generic/438.out
@@ -0,0 +1,10 @@
+QA output created by 438
+12
+11
+10
+9
+8
+7
+6
+5
+4
diff --git a/tests/generic/group b/tests/generic/group
index 438c299..d88f5bb 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -440,3 +440,4 @@
 435 auto encrypt
 436 auto quick rw
 437 auto quick
+438 auto quick
-- 
1.8.3.1

