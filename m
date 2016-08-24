Received: from mx1.redhat.com ([209.132.183.28]:39654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932790AbcHXLz5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Aug 2016 07:55:57 -0400
From: Artem Savkov <asavkov@redhat.com>
Subject: [PATCH] generic/337: add checks for listxattr call fails.
Date: Wed, 24 Aug 2016 13:55:53 +0200
Message-Id: <1472039753-29982-1-git-send-email-asavkov@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>, Dave Chinner <david@fromorbit.com>, Artem Savkov <asavkov@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add simple checks for failed calls to listxattr syscall. So far ERANGE, ENOENT
and EFAULT are checked.

Test is based on llistxattr02 test from LTP.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/listxattr_fails.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/337     |  4 ++++
 tests/generic/337.out |  3 +++
 5 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 src/listxattr_fails.c

diff --git a/.gitignore b/.gitignore
index d84f385..613d245 100644
--- a/.gitignore
+++ b/.gitignore
@@ -66,6 +66,7 @@
 /src/holes
 /src/holetest
 /src/itrash
+/src/listxattr_fails
 /src/locktest
 /src/loggen
 /src/looptest
diff --git a/src/Makefile b/src/Makefile
index 57b0df1..0fee55f 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
 	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
-	attr-list-by-handle-cursor-test
+	attr-list-by-handle-cursor-test listxattr_fails
 
 SUBDIRS =
 
diff --git a/src/listxattr_fails.c b/src/listxattr_fails.c
new file mode 100644
index 0000000..ddc4f7e
--- /dev/null
+++ b/src/listxattr_fails.c
@@ -0,0 +1,51 @@
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+
+int main(int argc, char **argv)
+{
+  int ret;
+  char buf;
+
+  if (argc < 2) {
+    fprintf(stderr, "usage: %s <testfile>\n", argv[0]);
+    return 1;
+  };
+
+  ret = listxattr(argv[1], &buf, 1);
+  if (ret == -1) {
+    if (errno == ERANGE) {
+      printf("expected error: ERANGE\n");
+    } else {
+      perror("unexpected error");
+    }
+  } else {
+    fprintf(stderr, "unexpected success\n");
+  }
+
+  ret = listxattr("", &buf, 1);
+  if (ret == -1) {
+    if (errno == ENOENT) {
+      printf("expected error: ENOENT\n");
+    } else {
+      perror("unexpected error");
+    }
+  } else {
+    fprintf(stderr, "unexpected success\n");
+  }
+
+  ret = listxattr((char *)-1, &buf, 1);
+  if (ret == -1) {
+    if (errno == EFAULT) {
+      printf("expected error: EFAULT\n");
+    } else {
+      perror("unexpected error");
+    }
+  } else {
+    fprintf(stderr, "unexpected success\n");
+  }
+
+  return 0;
+}
diff --git a/tests/generic/337 b/tests/generic/337
index 1758871..88b1e33 100755
--- a/tests/generic/337
+++ b/tests/generic/337
@@ -68,5 +68,9 @@ $SETFATTR_PROG -n user.ping -v pong $SCRATCH_MNT/testfile
 # It should list all the xattrs we have set before.
 $GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/testfile | _filter_scratch
 
+# Call listattr_fails to check if we get expected errors on errorneus listxattr
+# calls.
+$here/src/listxattr_fails $SCRATCH_MNT/testfile
+
 status=0
 exit
diff --git a/tests/generic/337.out b/tests/generic/337.out
index 1cd92ff..8ff8374 100644
--- a/tests/generic/337.out
+++ b/tests/generic/337.out
@@ -6,3 +6,6 @@ user.foobar="123"
 user.ping="pong"
 user.something="pizza"
 
+expected error: ERANGE
+expected error: ENOENT
+expected error: EFAULT
-- 
1.8.3.1

