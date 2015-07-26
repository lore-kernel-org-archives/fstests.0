Received: from imap.thunk.org ([74.207.234.97]:37880 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbbGZMVH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 26 Jul 2015 08:21:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/6] xfsprogs: define and use BUILD_CC in configure.ac for cross compilation
Date: Sun, 26 Jul 2015 08:20:52 -0400
Message-Id: <1437913255-7524-4-git-send-email-tytso@mit.edu>
In-Reply-To: <1437913255-7524-1-git-send-email-tytso@mit.edu>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: xfs@oss.sgi.com
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

In order to support cross-compilation, we need to build gen_crc32table
using the C compiler targetted for the build platform, since it is run
as part of the build process.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 configure.ac         | 8 ++++++++
 include/builddefs.in | 1 +
 libxfs/Makefile      | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index ae17c68..4cfbd4e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -8,6 +8,14 @@ AC_PREFIX_DEFAULT(/usr)
 
 AC_PROG_LIBTOOL
 
+AC_PROG_CC
+if test $cross_compiling = no; then
+  BUILD_CC="$CC"
+  AC_SUBST(BUILD_CC)
+else
+  AC_CHECK_PROGS(BUILD_CC, gcc cc)
+fi
+
 AC_ARG_ENABLE(shared,
 [ --enable-shared=[yes/no] Enable use of shared libraries [default=yes]],,
 	enable_shared=yes)
diff --git a/include/builddefs.in b/include/builddefs.in
index 7e9f53d..1d2d22e 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -64,6 +64,7 @@ PKG_DOC_DIR	= @datadir@/doc/@pkg_name@
 PKG_LOCALE_DIR	= @datadir@/locale
 
 CC		= @cc@
+BUILD_CC	= @BUILD_CC@
 AWK		= @awk@
 SED		= @sed@
 TAR		= @tar@
diff --git a/libxfs/Makefile b/libxfs/Makefile
index ae15a5d..6323b81 100644
--- a/libxfs/Makefile
+++ b/libxfs/Makefile
@@ -67,7 +67,7 @@ default: crc32selftest ltdepend $(LTLIBRARY)
 
 crc32table.h: gen_crc32table.c
 	@echo "    [CC]     gen_crc32table"
-	$(Q) $(CC) $(CFLAGS) -o gen_crc32table $<
+	$(Q) $(BUILD_CC) $(CFLAGS) -o gen_crc32table $<
 	@echo "    [GENERATE] $@"
 	$(Q) ./gen_crc32table > crc32table.h
 
@@ -78,7 +78,7 @@ crc32table.h: gen_crc32table.c
 # disk.
 crc32selftest: gen_crc32table.c crc32table.h crc32.c
 	@echo "    [TEST]    CRC32"
-	$(Q) $(CC) $(CFLAGS) -D CRC32_SELFTEST=1 crc32.c -o $@
+	$(Q) $(BUILD_CC) $(CFLAGS) -D CRC32_SELFTEST=1 crc32.c -o $@
 	$(Q) ./$@
 
 include $(BUILDRULES)
-- 
2.3.0

