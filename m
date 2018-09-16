Received: from lilium.sigma-star.at ([109.75.188.150]:37452 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbeIQDOy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Sep 2018 23:14:54 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] generic: Test whether xattrs work on unlinked files
Date: Sun, 16 Sep 2018 23:50:11 +0200
Message-Id: <20180916215011.31029-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: koen.vandeputte@ncentric.com, Richard Weinberger <richard@nod.at>
List-ID: <fstests@vger.kernel.org>

On UBIFS we had an embarrassing bug where xattr operations
worked only for files with nlink > 0.
Make sure this will never happen again.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
Hi!

I'm not sure whether this is worth a new test, maybe we can add it
to an existing test? What about generic/020?
Since xfs_io does not support xattrs, we need a new C test helper.

Thanks,
//richard
---
 src/Makefile             |  2 +-
 src/attr_unlinked_test.c | 53 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/generic/505        | 46 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/505.out    |  2 ++
 tests/generic/group      |  1 +
 5 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 src/attr_unlinked_test.c
 create mode 100755 tests/generic/505
 create mode 100644 tests/generic/505.out

diff --git a/src/Makefile b/src/Makefile
index 41826585..433fa517 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -27,7 +27,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize pre=
allo_rw_pattern_reader \
 	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
 	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
 	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
-	attr_replace_test swapon mkswap
+	attr_replace_test swapon mkswap attr_unlinked_test
=20
 SUBDIRS =3D log-writes perf
=20
diff --git a/src/attr_unlinked_test.c b/src/attr_unlinked_test.c
new file mode 100644
index 00000000..f3ce6d84
--- /dev/null
+++ b/src/attr_unlinked_test.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test whether xattr operations work on unlinked files.
+ * based on attr_replace_test.c
+ */
+#include <stdio.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+#include <sys/stat.h>
+
+#define die() do { perror(""); \
+fprintf(stderr, "error at line %d\n", __LINE__); \
+exit(1); } while (0)
+
+#define fail(...) do { \
+fprintf(stderr, __VA_ARGS__); exit (1); \
+} while (0)
+
+int main(int argc, char *argv[])
+{
+	int ret;
+	int fd;
+	char *name =3D "user.world";
+	char value[] =3D "hello";
+
+	if (argc !=3D 2)
+		fail("Usage: %s <file>\n", argv[0]);
+
+	fd =3D open(argv[1], O_RDWR | O_DIRECTORY | O_TMPFILE, S_IRUSR | S_IWUS=
R);
+	if (fd < 0)
+		die();
+
+	ret =3D fsetxattr(fd, name, value, sizeof(value), XATTR_CREATE);
+	if (ret < 0)
+		die();
+
+	ret =3D fsetxattr(fd, name, value, sizeof(value), XATTR_REPLACE);
+	if (ret < 0)
+		die();
+
+	ret =3D fsetxattr(fd, name, NULL, 0, 0);
+	if (ret < 0)
+		die();
+
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/generic/505 b/tests/generic/505
new file mode 100755
index 00000000..6e8bb512
--- /dev/null
+++ b/tests/generic/505
@@ -0,0 +1,46 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 505
+#
+# Ensure that xattr operations work also on unlinked files.
+# UBIFS wrongly assumed that xattr operations are only valid for nlink >=
 0.
+#
+seq=3D`basename $0`
+seqres=3D$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test_program "attr_unlinked_test"
+_require_attrs
+_require_scratch
+
+rm -f $seqres.full
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount >>$seqres.full 2>&1
+
+./src/attr_unlinked_test $SCRATCH_MNT/
+
+echo "Silence is golden"
+
+status=3D0
+exit
diff --git a/tests/generic/505.out b/tests/generic/505.out
new file mode 100644
index 00000000..80e3bd1d
--- /dev/null
+++ b/tests/generic/505.out
@@ -0,0 +1,2 @@
+QA output created by 505
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 55155de8..75770f7a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -507,3 +507,4 @@
 502 auto quick log
 503 auto quick dax punch collapse zero
 504 auto quick locks
+505 auto quick attr
--=20
2.11.0
