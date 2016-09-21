Received: from mx2.suse.de ([195.135.220.15]:56851 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753663AbcIUMch (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Sep 2016 08:32:37 -0400
From: jeffm@suse.com
Subject: [PATCH] tests/btrfs: test snapshot/subvol create/destroy ioctls with a regular file
Date: Wed, 21 Sep 2016 08:32:33 -0400
Message-Id: <1474461153-16373-1-git-send-email-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

There was a bug where the btrfs snapshot/subvol creation ioctls
would accept a regular file and then Oops when it tried to use
the file inode operations to do a lookup.

This also adds an ioctl-helper that can be easily extended to provide
direct ioctl access for any file system's ioctls.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 src/Makefile        |   2 +-
 src/ioctl-helper.c  | 201 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/131     |  77 ++++++++++++++++++++
 tests/btrfs/131.out |   6 ++
 tests/btrfs/group   |   1 +
 5 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 src/ioctl-helper.c
 create mode 100755 tests/btrfs/131
 create mode 100644 tests/btrfs/131.out

diff --git a/src/Makefile b/src/Makefile
index dd51216..6c6eb32 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
 	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
-	attr-list-by-handle-cursor-test listxattr
+	attr-list-by-handle-cursor-test listxattr ioctl-helper
 
 SUBDIRS =
 
diff --git a/src/ioctl-helper.c b/src/ioctl-helper.c
new file mode 100644
index 0000000..4a2acb4
--- /dev/null
+++ b/src/ioctl-helper.c
@@ -0,0 +1,201 @@
+/*
+ * Copyright (c) 2016 SUSE Linux Products GmbH.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*
+ * This program calls an ioctl with the specified arguments transformed
+ * appropriately.
+ */
+
+#include <libgen.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/fcntl.h>
+#include <sys/ioctl.h>
+
+static const char *program;
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof(x[0]))
+#define BAD_ARGS ((void *)-1UL)
+
+struct ioctl_entry {
+	const char *name;
+	unsigned int cmd;
+	int nargs;
+	void *(*get_args)(unsigned, int, char **);
+};
+
+/* start btrfs ioctls */
+#define BTRFS_IOCTL_MAGIC 0x94
+
+/* this should be 4k */
+#define BTRFS_PATH_NAME_MAX 4087
+struct btrfs_ioctl_vol_args {
+	int64_t fd;
+	char name[BTRFS_PATH_NAME_MAX + 1];
+};
+
+#define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1,		\
+                                   struct btrfs_ioctl_vol_args)
+#define BTRFS_IOC_SUBVOL_CREATE _IOW(BTRFS_IOCTL_MAGIC, 14,		\
+                                   struct btrfs_ioctl_vol_args)
+#define BTRFS_IOC_SNAP_DESTROY _IOW(BTRFS_IOCTL_MAGIC, 15,		\
+                                struct btrfs_ioctl_vol_args)
+
+static void *
+get_vol_args(unsigned cmd, int argc, char *argv[])
+{
+	static struct btrfs_ioctl_vol_args args;
+	const char *target = argv[0];
+	const char *snap_src = argv[1];
+
+	memset(&args, 0, sizeof(args));
+
+	if (cmd == BTRFS_IOC_SNAP_CREATE) {
+		args.fd = open(snap_src, O_RDONLY);
+		if (args.fd < 0) {
+			perror(snap_src);
+			return BAD_ARGS;
+		}
+	}
+
+	strcpy(args.name, target);
+	return &args;
+}
+
+#define BTRFS_SUBVOL_NAME_MAX 4039
+struct btrfs_ioctl_vol_args_v2 {
+        int64_t fd;
+        uint64_t transid;
+        uint64_t flags;
+        union {
+                struct {
+                        uint64_t size;
+                };
+                uint64_t unused[4];
+        };
+        union {
+                char name[BTRFS_SUBVOL_NAME_MAX + 1];
+                uint64_t devid;
+        };
+};
+
+#define BTRFS_IOC_SNAP_CREATE_V2 _IOW(BTRFS_IOCTL_MAGIC, 23,		\
+                                   struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_SUBVOL_CREATE_V2 _IOW(BTRFS_IOCTL_MAGIC, 24,		\
+                                   struct btrfs_ioctl_vol_args_v2)
+
+static void *
+get_vol_args_v2(unsigned cmd, int argc, char *argv[])
+{
+	static struct btrfs_ioctl_vol_args_v2 args;
+	const char *target = argv[0];
+	const char *snap_src = argv[1];
+
+	memset(&args, 0, sizeof(args));
+
+	if (cmd == BTRFS_IOC_SNAP_CREATE_V2) {
+		args.fd = open(snap_src, O_RDONLY);
+		if (args.fd < 0) {
+			perror(snap_src);
+			return BAD_ARGS;
+		}
+	}
+
+	strcpy(args.name, target);
+	return &args;
+}
+
+/* end btrfs ioctls */
+
+#define IOCTL_TBL(ioctl, _nargs, fn)					\
+	{ .name = #ioctl, .cmd = ioctl, .nargs = _nargs, .get_args = fn, }
+
+static struct ioctl_entry ioctl_table[] = {
+	IOCTL_TBL(BTRFS_IOC_SNAP_CREATE, 2, get_vol_args),
+	IOCTL_TBL(BTRFS_IOC_SNAP_CREATE_V2, 2, get_vol_args_v2),
+	IOCTL_TBL(BTRFS_IOC_SUBVOL_CREATE, 1, get_vol_args),
+	IOCTL_TBL(BTRFS_IOC_SUBVOL_CREATE_V2, 1, get_vol_args_v2),
+	IOCTL_TBL(BTRFS_IOC_SNAP_DESTROY, 1, get_vol_args),
+};
+
+static struct ioctl_entry *get_ioctl(const char *name)
+{
+	struct ioctl_entry *ioc = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ioctl_table); i++) {
+		if (!strcmp(ioctl_table[i].name, name)) {
+			ioc = &ioctl_table[i];
+			break;
+		}
+	}
+
+	return ioc;
+}
+	
+int
+main(int argc, char *argv[])
+{
+	struct ioctl_entry *ioc = NULL;
+	const char *filename;
+	void *args = NULL;
+	int ret;
+	int fd;
+
+	program = basename(argv[0]);
+
+	if (argc < 3) {
+		fprintf(stderr,
+			"usage: %s <filename> <ioctl> [args]\n", program);
+		return 1;
+	}
+
+	ioc = get_ioctl(argv[2]);
+
+	if (!ioc) {
+		fprintf(stderr, "%s: unknown ioctl `%s'\n", program, argv[2]);
+		return 1;
+	}
+
+	if (argc - 3 < ioc->nargs) {
+		fprintf(stderr, "%s: %s requires %d args\n", program,
+			ioc->name, ioc->nargs);
+		return 1;
+	}
+
+	if (ioc->get_args) {
+		args = ioc->get_args(ioc->cmd, argc - 3, argv + 3);
+		if (args == BAD_ARGS)
+			return 1;
+	}
+
+	filename = argv[1];
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		perror(filename);
+		return 1;
+	}
+
+	ret = ioctl(fd, ioc->cmd, args);
+	if (ret)
+		perror(ioc->name);
+
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/btrfs/131 b/tests/btrfs/131
new file mode 100755
index 0000000..d7541b1
--- /dev/null
+++ b/tests/btrfs/131
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FS QA Test 131
+#
+# Check if btrfs subvol/snapshot create/destroy ioctls can handle
+# being called on a regular file.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 SUSE Linux Products GmbH.  All Rights Reserved.
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_test_program ioctl-helper
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+touch $SCRATCH_MNT/testfile
+
+# The file must be writeable and executable to pass btrfs_may_create()
+chmod u+wx $SCRATCH_MNT/testfile
+
+# Create a valid subvolume for the snapshot create to use
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/test-sub
+
+# None of these should succeed.  A failure is an Oops.
+./src/ioctl-helper $SCRATCH_MNT/testfile BTRFS_IOC_SUBVOL_CREATE test1
+./src/ioctl-helper $SCRATCH_MNT/testfile BTRFS_IOC_SUBVOL_CREATE_V2 test2
+./src/ioctl-helper $SCRATCH_MNT/testfile BTRFS_IOC_SNAP_DESTROY test2
+./src/ioctl-helper $SCRATCH_MNT/testfile BTRFS_IOC_SNAP_CREATE_V2 test3 \
+		   $SCRATCH_MNT/test-sub
+./src/ioctl-helper $SCRATCH_MNT/testfile BTRFS_IOC_SNAP_CREATE_V2 test4 \
+		   $SCRATCH_MNT/test-sub
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/131.out b/tests/btrfs/131.out
new file mode 100644
index 0000000..ae184a2
--- /dev/null
+++ b/tests/btrfs/131.out
@@ -0,0 +1,6 @@
+QA output created by 131
+BTRFS_IOC_SUBVOL_CREATE: Not a directory
+BTRFS_IOC_SUBVOL_CREATE_V2: Not a directory
+BTRFS_IOC_SNAP_DESTROY: Not a directory
+BTRFS_IOC_SNAP_CREATE_V2: Not a directory
+BTRFS_IOC_SNAP_CREATE_V2: Not a directory
diff --git a/tests/btrfs/group b/tests/btrfs/group
index f3a7a4f..c090604 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -133,3 +133,4 @@
 128 auto quick send
 129 auto quick send
 130 auto clone send
+131 auto quick
-- 
1.8.5.6

