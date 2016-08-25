Received: from mx1.redhat.com ([209.132.183.28]:38086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758044AbcHYLBo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 Aug 2016 07:01:44 -0400
From: Artem Savkov <asavkov@redhat.com>
Subject: [PATCH v2] Add a test for listxattr syscall with different buffer sizes.
Date: Thu, 25 Aug 2016 13:01:33 +0200
Message-Id: <1472122893-22158-1-git-send-email-asavkov@redhat.com>
In-Reply-To: <20160825055713.GN22388@dastard>
References: <20160825055713.GN22388@dastard>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>, Eryu Guan <eguan@redhat.com>, Filipe Manana <fdmanana@suse.com>, Artem Savkov <asavkov@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add generic/375 test that calls listxattr syscall with different buffer size
arguments checking if it fails properly.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/listxattr.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/375     | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/375.out | 10 +++++++++
 tests/generic/group   |  1 +
 6 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 src/listxattr.c
 create mode 100755 tests/generic/375
 create mode 100644 tests/generic/375.out

diff --git a/.gitignore b/.gitignore
index d84f385..915d2d8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -66,6 +66,7 @@
 /src/holes
 /src/holetest
 /src/itrash
+/src/listxattr
 /src/locktest
 /src/loggen
 /src/looptest
diff --git a/src/Makefile b/src/Makefile
index 57b0df1..dd51216 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
 	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
-	attr-list-by-handle-cursor-test
+	attr-list-by-handle-cursor-test listxattr
 
 SUBDIRS =
 
diff --git a/src/listxattr.c b/src/listxattr.c
new file mode 100644
index 0000000..7fdccb5
--- /dev/null
+++ b/src/listxattr.c
@@ -0,0 +1,55 @@
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+
+int main(int argc, char **argv)
+{
+  int ret;
+  size_t bufsize = 0;
+  char *buf = NULL;
+
+  if (argc < 2) {
+    fprintf(stderr, "usage: %s <testfile> [bufsize]\n", argv[0]);
+    return 1;
+  };
+
+  if (argc == 3) {
+    bufsize = strtoul(argv[2], NULL, 10);
+    if (bufsize == -1) {
+      perror("buffsize");
+      return 1;
+    }
+  }
+
+  if (bufsize == 0) {
+    bufsize = listxattr(argv[1], buf, 0);
+    if (bufsize == -1) {
+      fprintf(stderr, "listxattr failed with %d\n", -errno);
+      return 1;
+    }
+  }
+
+  buf = malloc(bufsize + 1);
+  if (buf == NULL) {
+    perror("buf alloc");
+    return 1;
+  }
+
+  ret = listxattr(argv[1], buf, bufsize);
+  if (ret < 0) {
+    fprintf(stderr, "listxattr failed with %d\n", -errno);
+  } else {
+    char *l;
+    for (l = buf; l != (buf + bufsize) && *l != '\0'; l = strchr(l, '\0') + 1) {
+      printf("xattr: %s\n", l);
+    }
+  }
+
+  free(buf);
+
+  return 0;
+}
diff --git a/tests/generic/375 b/tests/generic/375
new file mode 100755
index 0000000..ad7b168
--- /dev/null
+++ b/tests/generic/375
@@ -0,0 +1,62 @@
+#! /bin/bash
+# FSQA Test No. 375
+#
+# Test listxattr syscall behaviour with different buffer sizes.
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
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
+. ./common/attr
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_attrs
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Create a testfile with multiple xattrs.
+TESTFILE=${SCRATCH_MNT}/testfile
+touch $TESTFILE
+$SETFATTR_PROG -n user.foo -v bar $TESTFILE
+$SETFATTR_PROG -n user.ping -v pong $TESTFILE
+$SETFATTR_PROG -n user.xxxx -v yyyy $TESTFILE
+
+# Call listxattr without buffer length argument. This should succeed.
+$here/src/listxattr $TESTFILE
+
+# Calling listxattr on nonexistant file should fail with -ENOENT.
+$here/src/listxattr ""
+
+# Calling listxattr with buffersize not suffecient for even one xattr should
+# fail with -ERANGE.
+$here/src/listxattr $TESTFILE 1
+
+# Calling listxattr with buffersize suffecient for one xattr, but not
+# sufficient for the whole list should still fail with -ERANGE.
+$here/src/listxattr $TESTFILE 9
+
+# Calling listxattr with buffersize not suffecient for even one xattr should
+# fail with -ERANGE.
+$here/src/listxattr $TESTFILE 500
+
+status=0
+exit
diff --git a/tests/generic/375.out b/tests/generic/375.out
new file mode 100644
index 0000000..0c02a83
--- /dev/null
+++ b/tests/generic/375.out
@@ -0,0 +1,10 @@
+QA output created by 375
+xattr: user.foo
+xattr: user.ping
+xattr: user.xxxx
+listxattr failed with -2
+listxattr failed with -34
+listxattr failed with -34
+xattr: user.foo
+xattr: user.ping
+xattr: user.xxxx
diff --git a/tests/generic/group b/tests/generic/group
index ef38c35..3068510 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -377,3 +377,4 @@
 372 auto quick clone
 373 auto quick clone
 374 auto quick clone dedupe
+375 auto quick metadata
-- 
1.8.3.1

