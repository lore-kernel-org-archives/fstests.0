Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34600 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932153AbbDJXlY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 10 Apr 2015 19:41:24 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3ANfNW0008084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2015 19:41:23 -0400
Received: from lenny.home.zabbo.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3ANfNA1017505
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2015 19:41:23 -0400
From: Zach Brown <zab@redhat.com>
Subject: [PATCH] xfs_io: add copy_file_range command
Date: Fri, 10 Apr 2015 16:41:21 -0700
Message-Id: <1428709281-28098-1-git-send-email-zab@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Add support for the copy_file_range() syscall that is being developed.
The xfs_io interface for the syscall is based on sendfile -- it writes
to the current file from a referenced path or other open file number.

This patch short circuits autoconf detection of the libc wrapper and
manually calls the raw syscall.  This would all be removed once the
syscall is fully merged and supported.

Signed-off-by: Zach Brown <zab@redhat.com>
---
 configure.ac          |   1 +
 include/builddefs.in  |   1 +
 io/Makefile           |   8 ++
 io/copy_file_range.c  | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++
 io/init.c             |   1 +
 io/io.h               |   6 ++
 m4/package_libcdev.m4 |  11 +++
 7 files changed, 270 insertions(+)
 create mode 100644 io/copy_file_range.c

diff --git a/configure.ac b/configure.ac
index ae17c68..a2c3597 100644
--- a/configure.ac
+++ b/configure.ac
@@ -113,6 +113,7 @@ AC_HAVE_PREADV
 AC_HAVE_SYNC_FILE_RANGE
 AC_HAVE_BLKID_TOPO($enable_blkid)
 AC_HAVE_READDIR
+AC_HAVE_COPY_FILE_RANGE
 
 AC_CHECK_SIZEOF([long])
 AC_CHECK_SIZEOF([char *])
diff --git a/include/builddefs.in b/include/builddefs.in
index 944bcf6..e118f54 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -104,6 +104,7 @@ HAVE_FIEMAP = @have_fiemap@
 HAVE_PREADV = @have_preadv@
 HAVE_SYNC_FILE_RANGE = @have_sync_file_range@
 HAVE_READDIR = @have_readdir@
+HAVE_COPY_FILE_RANGE = @have_copy_file_range@
 
 GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall 
 #	   -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-decl
diff --git a/io/Makefile b/io/Makefile
index a08a782..a2c5f2c 100644
--- a/io/Makefile
+++ b/io/Makefile
@@ -45,6 +45,14 @@ else
 LSRCFILES += sendfile.c
 endif
 
+# XXX devel hack, flip back to ifeq once libc has wrappers
+ifneq ($(HAVE_COPY_FILE_RANGE),yes)
+CFILES += copy_file_range.c
+LCFLAGS += -DHAVE_COPY_FILE_RANGE
+else
+LSRCFILES += copy_file_range.c
+endif
+
 ifeq ($(HAVE_FIEMAP),yes)
 CFILES += fiemap.c
 LCFLAGS += -DHAVE_FIEMAP
diff --git a/io/copy_file_range.c b/io/copy_file_range.c
new file mode 100644
index 0000000..ece8367
--- /dev/null
+++ b/io/copy_file_range.c
@@ -0,0 +1,242 @@
+/*
+ * Copyright (c) 2015 Red Hat, Inc.
+ * All Rights Reserved.
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
+#include <xfs/xfs.h>
+#include <xfs/command.h>
+#include <xfs/input.h>
+#include "init.h"
+#include "io.h"
+
+static cmdinfo_t copy_file_range_cmd;
+
+static void
+copy_file_range_help(void)
+{
+	printf(_(
+"\n"
+" copy a range of bytes between files\n"
+"\n"
+" Example:\n"
+" 'copy_file_range -f 2 512' - copies 512 bytes between the open files\n"
+"\n"
+" Copies data between one file descriptor and another.  The copy can be\n"
+" accelerated if the file descriptors support it.  The kernel may not see\n"
+" any data transfer at all.  For example, with NFS, the server may copy\n"
+" between files without the client seeing any data.\n"
+" The offsets in the files are optional.  If an offset isn't provided then\n"
+" the current position in the file descriptor is used and updated.\n"
+" -f -- specifies an open input file number from which to source data to write\n"
+" -i -- specifies an input file name from which to source data to write.\n"
+" -s -- specifies the byte offset to copy from in the source file.\n"
+" -t -- specifies the byte offset to copy to in the target file.\n"
+" -F -- specifies the raw flags argument for the copy system call.\n" 
+" The final argument specifies length in bytes to copy between the files.\n"
+"\n"));
+}
+
+/* XXX devel hack, remove once libc has copy_file_range wrappers */
+#if 1
+
+#ifdef __x86_64__
+#define __NR_copy_file_range 323
+#elif __i386__
+#define __NR_copy_file_range 359
+#else
+#error "sorry, don't know __NR_copy_file_range for arch"
+#endif
+
+static inline int copy_file_range(int fd_in, loff_t *pos_in, int fd_out,
+				  loff_t *pos_out, size_t len, int flags)
+{
+	return syscall(__NR_copy_file_range, fd_in, pos_in, fd_out, pos_out,
+		       len, flags);
+}
+#endif
+
+static int
+copy_range(
+	int		fd_in,
+	off64_t		*off_in,
+	int		fd_out,
+	off64_t		*off_out,
+	size_t		len,
+	int		flags,
+	long long	*total)
+{
+	ssize_t		bytes;
+	int		ops = 0;
+
+	*total = 0;
+	while (len > 0) {
+		bytes = copy_file_range(fd_in, off_in, fd_out, off_out, len,
+					flags);
+		if (bytes == 0)
+			break;
+		if (bytes < 0) {
+			perror("copy_file_range");
+			return -1;
+		}
+		ops++;
+		*total += bytes;
+
+		if (off_in)
+			*off_in += bytes;
+		if (off_out)
+			*off_out += bytes;
+
+		if (bytes >= len)
+			break;
+		len -= bytes;
+	}
+	return ops;
+}
+
+static int
+copy_file_range_f(
+	int		argc,
+	char		**argv)
+{
+	off64_t		in_offset;
+	off64_t		out_offset;
+	off64_t		*off_in = NULL;
+	off64_t		*off_out = NULL;
+	long long	count, total;
+	size_t		blocksize, sectsize;
+	struct timeval	t1, t2;
+	char		s1[64], s2[64], ts[64];
+	char		*infile = NULL;
+	int		Cflag, qflag;
+	int		c, fd = -1;
+	int		flags = 0;
+
+	Cflag = qflag = 0;
+	init_cvtnum(&blocksize, &sectsize);
+	while ((c = getopt(argc, argv, "Cf:F:i:s:t:q")) != EOF) {
+		switch (c) {
+		case 'C':
+			Cflag = 1;
+			break;
+		case 'q':
+			qflag = 1;
+			break;
+		case 'f':
+			fd = atoi(argv[1]);
+			if (fd < 0 || fd >= filecount) {
+				printf(_("value %d is out of range (0-%d)\n"),
+					fd, filecount-1);
+				return 0;
+			}
+			break;
+		case 'F':
+			flags = strtoul(optarg, NULL, 0);
+			if (errno) {
+				printf(_("invalid flags argument -- %s\n"),
+					 argv[1]);
+				return 0;
+			}
+			break;
+		case 'i':
+			infile = optarg;
+			break;
+		case 's':
+			in_offset = cvtnum(blocksize, sectsize, optarg);
+			if (in_offset < 0) {
+				printf(_("non-numeric offset argument -- %s\n"),
+					optarg);
+				goto done;
+			}
+			off_in = &in_offset;
+			break;
+		case 't':
+			out_offset = cvtnum(blocksize, sectsize, optarg);
+			if (out_offset < 0) {
+				printf(_("non-numeric offset argument -- %s\n"),
+					optarg);
+				goto done;
+			}
+			off_out = &out_offset;
+			break;
+		default:
+			return command_usage(&copy_file_range_cmd);
+		}
+	}
+	if (infile && fd != -1)
+		return command_usage(&copy_file_range_cmd);
+
+	if (!infile)
+		fd = filetable[fd].fd;
+	else if ((fd = openfile(infile, NULL, IO_READONLY, 0)) < 0)
+		return 0;
+
+	/* must specify length */
+	if (optind != argc - 1)
+		return command_usage(&copy_file_range_cmd);
+
+	count = cvtnum(blocksize, sectsize, argv[optind]);
+	if (count < 0) {
+		printf(_("non-numeric length argument -- %s\n"),
+			argv[optind]);
+		goto done;
+	}
+
+	gettimeofday(&t1, NULL);
+	c = copy_range(fd, off_in, file->fd, off_out, count, flags, &total);
+	if (c < 0)
+		goto done;
+	if (qflag)
+		goto done;
+	gettimeofday(&t2, NULL);
+	t2 = tsub(t2, t1);
+
+	/* Finally, report back -- -C gives a parsable format */
+	timestr(&t2, ts, sizeof(ts), Cflag ? VERBOSE_FIXED_TIME : 0);
+	if (!Cflag) {
+		cvtstr((double)total, s1, sizeof(s1));
+		cvtstr(tdiv((double)total, t2), s2, sizeof(s2));
+		printf(_("copied %lld/%lld bytes\n"),
+			total, count);
+		printf(_("%s, %d ops; %s (%s/sec and %.4f ops/sec)\n"),
+			s1, c, ts, s2, tdiv((double)c, t2));
+	} else {/* bytes,ops,time,bytes/sec,ops/sec */
+		printf("%lld,%d,%s,%.3f,%.3f\n",
+			total, c, ts,
+			tdiv((double)total, t2), tdiv((double)c, t2));
+	}
+done:
+	if (infile)
+		close(fd);
+	return 0;
+}
+
+void
+copy_file_range_init(void)
+{
+	copy_file_range_cmd.name = "copy_file_range";
+	copy_file_range_cmd.altname = "copy_file_range";
+	copy_file_range_cmd.cfunc = copy_file_range_f;
+	copy_file_range_cmd.argmin = 3;
+	copy_file_range_cmd.argmax = 9;
+	copy_file_range_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
+	copy_file_range_cmd.args =
+		_("-i infile | -f N [-s src_off] [-t targ_off] [-F flags] len");
+	copy_file_range_cmd.oneline =
+		_("Copy data directly between file descriptors");
+	copy_file_range_cmd.help = copy_file_range_help;
+
+	add_command(&copy_file_range_cmd);
+}
diff --git a/io/init.c b/io/init.c
index 1b07518..e716bc4 100644
--- a/io/init.c
+++ b/io/init.c
@@ -83,6 +83,7 @@ init_commands(void)
 	sync_init();
 	sync_range_init();
 	truncate_init();
+	copy_file_range_init();
 }
 
 static int
diff --git a/io/io.h b/io/io.h
index db8b513..3411be1 100644
--- a/io/io.h
+++ b/io/io.h
@@ -159,3 +159,9 @@ extern void		readdir_init(void);
 #else
 #define readdir_init()		do { } while (0)
 #endif
+
+#ifdef HAVE_COPY_FILE_RANGE
+extern void		copy_file_range_init(void);
+#else
+#define copy_file_range_init()		do { } while (0)
+#endif
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index 919ae0a..794fa57 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -202,3 +202,14 @@ AC_DEFUN([AC_HAVE_READDIR],
     AC_SUBST(have_readdir)
   ])
 
+AC_DEFUN([AC_HAVE_COPY_FILE_RANGE],
+  [ AC_MSG_CHECKING([for copy_file_range])
+    AC_TRY_LINK([
+#include <unistd.h>
+    ], [
+         copy_file_range(0, 0, 0, 0, 0, 0);
+    ],	have_copy_file_range=yes
+	AC_MSG_RESULT(yes),
+	AC_MSG_RESULT(no))
+    AC_SUBST(have_copy_file_range)
+  ])
-- 
2.1.0

