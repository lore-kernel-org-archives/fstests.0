From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 2/3] common/rc: add generic file type support check
Date: Tue, 20 Dec 2016 15:17:34 +0200
Message-Id: <1482239855-791-3-git-send-email-amir73il@gmail.com>
In-Reply-To: <1482239855-791-1-git-send-email-amir73il@gmail.com>
References: <1482239855-791-1-git-send-email-amir73il@gmail.com>
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

_supports_filetype() helper checks if the filetype feature
is enabled for xfs and ext* file sytems.

Add a check for the generic case where we don't know
how to test file system filetype feature.

Introduce a helper utility t_dir_type that lists directory
entries filtered by file type.

Check for filetype feature by expecting to find no directory
entries listed as DT_UNKNOWN inside a test directory.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .gitignore       |   1 +
 common/rc        |   9 +++++
 src/Makefile     |   2 +-
 src/t_dir_type.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 src/t_dir_type.c

diff --git a/.gitignore b/.gitignore
index b8d13a0..7dcea14 100644
--- a/.gitignore
+++ b/.gitignore
@@ -94,6 +94,7 @@
 /src/t_access_root
 /src/t_dir_offset
 /src/t_dir_offset2
+/src/t_dir_type
 /src/t_futimens
 /src/t_getcwd
 /src/t_holes
diff --git a/common/rc b/common/rc
index 288517f..a779c50 100644
--- a/common/rc
+++ b/common/rc
@@ -278,6 +278,15 @@ _supports_filetype()
 		tune2fs -l $(df --output=source $dir | tail -1) | \
 		   grep -q filetype
 		;;
+	*)
+		testfile=$dir/$$.ftype
+		touch $testfile
+		# look for DT_UNKNOWN files
+		unknowns=$(src/t_dir_type $dir u | wc -l)
+		rm $testfile
+		# 0 unknowns is success
+		return $unknowns
+		;;
 	esac
 }
 
diff --git a/src/Makefile b/src/Makefile
index 4056496..94d74aa 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
 	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
-	attr-list-by-handle-cursor-test listxattr dio-interleaved
+	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type
 
 SUBDIRS =
 
diff --git a/src/t_dir_type.c b/src/t_dir_type.c
new file mode 100644
index 0000000..344bef8
--- /dev/null
+++ b/src/t_dir_type.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2016 CTERA Networks. All Rights Reserved.
+ * Author: Amir Goldstein <amir73il@gmail.com>
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
+ * t_dir_type
+ *
+ * print directory entries, optionally filtered by d_type
+ *
+ * ./t_dir_type <path> [u|f|d|c|b|l|p|s|w]
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <dirent.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+
+struct linux_dirent64 {
+	uint64_t	d_ino;
+	int64_t		d_off;
+	unsigned short	d_reclen;
+	unsigned char	d_type;
+	char		d_name[0];
+};
+
+#define DT_MASK 15
+#define DT_MAX 15
+unsigned char type_to_char[DT_MAX] = {
+	[DT_UNKNOWN] = 'u',
+	[DT_DIR] = 'd',
+	[DT_REG] = 'f',
+	[DT_LNK] = 'l',
+	[DT_CHR] = 'c',
+	[DT_BLK] = 'b',
+	[DT_FIFO] = 'p',
+	[DT_SOCK] = 's',
+	[DT_WHT] = 'w',
+};
+
+#define DT_CHAR(t) type_to_char[(t)&DT_MASK]
+
+#define BUF_SIZE 4096
+
+int
+main(int argc, char *argv[])
+{
+	int fd, nread;
+	char buf[BUF_SIZE];
+	struct linux_dirent64 *d;
+	int bpos;
+	int type = -1; /* -1 means all types */
+	int ret = 1;
+
+	fd = open(argv[1], O_RDONLY | O_DIRECTORY);
+	if (fd < 0) {
+		perror("open");
+		exit(EXIT_FAILURE);
+	}
+
+	if (argc > 2 && argv[2][0]) {
+		char t = argv[2][0];
+
+		for (type = DT_MAX-1; type >= 0; type--)
+			if (DT_CHAR(type) == t)
+				break;
+		/* no match ends up with type = -1 */
+	}
+
+	for ( ; ; ) {
+		nread = syscall(SYS_getdents64, fd, buf, BUF_SIZE);
+		if (nread == -1) {
+			perror("getdents");
+			exit(EXIT_FAILURE);
+		}
+
+		if (nread == 0)
+			break;
+
+		for (bpos = 0; bpos < nread;) {
+			d = (struct linux_dirent64 *) (buf + bpos);
+			if (type < 0 || type == (int)d->d_type) {
+				ret = 0;
+				printf("%s %c\n", d->d_name, DT_CHAR(d->d_type));
+			}
+			bpos += d->d_reclen;
+		}
+	}
+
+	return ret;
+}
-- 
2.7.4
