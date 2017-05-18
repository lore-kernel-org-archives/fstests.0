Received: from mail-pf0-f196.google.com ([209.85.192.196]:36756 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbdERWuU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 May 2017 18:50:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so7217156pfb.3
        for <fstests@vger.kernel.org>; Thu, 18 May 2017 15:50:19 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests: skip AIO-related tests when CONFIG_AIO=n
Date: Thu, 18 May 2017 15:49:10 -0700
Message-Id: <20170518224910.131061-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

When running xfstests on a kernel configured with CONFIG_AIO=n, all
AIO-related tests fail, often due to an error similar to the following:

    error Function not implemented during io_setup

This affected at least the following tests: generic/036, generic/112,
generic/113, generic/198, generic/207, generic/208, generic/210,
generic/211, generic/239, generic/323, generic/427, xfs/240, xfs/241.

Fix this by enhancing the 'feature' program to allow testing for
asynchronous I/O support, then skipping all AIO-related tests when AIO
is unsupported.

This change is useful because CONFIG_AIO is sometimes disabled to reduce
the kernel's attack surface (e.g. see
https://android-review.googlesource.com/#/c/292158/).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/rc         | 18 ++++++++++++++++++
 src/Makefile      |  1 +
 src/feature.c     | 42 +++++++++++++++++++++++++++++++++++++++---
 tests/generic/112 |  1 +
 tests/generic/113 |  1 +
 tests/xfs/240     |  3 +--
 tests/xfs/241     |  3 +--
 7 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index ee4902b6..a6ce6ca0 100644
--- a/common/rc
+++ b/common/rc
@@ -1886,7 +1886,24 @@ _require_nonexternal()
 	_notrun "External device testing in progress, skipped this test"
 }
 
+# this test requires that the kernel supports asynchronous I/O
+_require_aio()
+{
+	$here/src/feature -A
+	case $? in
+	0)
+		;;
+	1)
+		_notrun "kernel does not support asynchronous I/O"
+		;;
+	*)
+		_fail "unexpected error testing for asynchronous I/O support"
+		;;
+	esac
+}
+
 # this test requires that a (specified) aio-dio executable exists
+# and that the kernel supports asynchronous I/O.
 # $1 - command (optional)
 #
 _require_aiodio()
@@ -1899,6 +1916,7 @@ _require_aiodio()
         AIO_TEST=src/aio-dio-regress/$1
         [ -x $AIO_TEST ] || _notrun "$AIO_TEST not built"
     fi
+    _require_aio
     _require_odirect
 }
 
diff --git a/src/Makefile b/src/Makefile
index e5042c9b..940c2694 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -59,6 +59,7 @@ endif
 
 ifeq ($(HAVE_AIO), true)
 SUBDIRS += aio-dio-regress
+LLDLIBS += -laio
 endif
 
 ifeq ($(HAVE_SSL), true)
diff --git a/src/feature.c b/src/feature.c
index 334063b1..b7354689 100644
--- a/src/feature.c
+++ b/src/feature.c
@@ -30,6 +30,7 @@
  * Return code: 0 is true, anything else is error/not supported
  *
  * Test for machine features
+ *   -A  test whether AIO syscalls are available
  *   -o  report a number of online cpus
  *   -s  report pagesize
  *   -w  report bits per long
@@ -46,6 +47,10 @@
 #include <xfs/xqm.h>
 #endif
 
+#ifdef HAVE_LIBAIO_H
+#include <libaio.h>
+#endif
+
 #ifndef USRQUOTA
 #define USRQUOTA  0
 #endif
@@ -66,7 +71,7 @@ usage(void)
 	fprintf(stderr, "Usage: feature [-v] -<q|u|g|p|U|G|P> <filesystem>\n");
 	fprintf(stderr, "       feature [-v] -c <file>\n");
 	fprintf(stderr, "       feature [-v] -t <file>\n");
-	fprintf(stderr, "       feature -o | -s | -w\n");
+	fprintf(stderr, "       feature -A | -o | -s | -w\n");
 	exit(1);
 }
 
@@ -199,10 +204,35 @@ hasxfsquota(int type, int q, char *device)
 	return (1);
 }
 
+static int
+check_aio_support(void)
+{
+#ifdef HAVE_LIBAIO_H
+	struct io_context *ctx = NULL;
+	int err;
+
+	err = io_setup(1, &ctx);
+	if (err == 0)
+		return 0;
+
+	if (err == -ENOSYS) /* CONFIG_AIO=n */
+		return 1;
+
+	fprintf(stderr, "unexpected error from io_setup(): %s\n",
+		strerror(-err));
+	return 2;
+#else
+	/* libaio was unavailable at build time; assume AIO is unsupported */
+	return 1;
+#endif
+}
+
+
 int
 main(int argc, char **argv)
 {
 	int	c;
+	int	Aflag = 0;
 	int	cflag = 0;
 	int	tflag = 0;
 	int	gflag = 0;
@@ -217,8 +247,11 @@ main(int argc, char **argv)
 	int	oflag = 0;
 	char	*fs = NULL;
 
-	while ((c = getopt(argc, argv, "ctgGopPqsuUvw")) != EOF) {
+	while ((c = getopt(argc, argv, "ActgGopPqsuUvw")) != EOF) {
 		switch (c) {
+		case 'A':
+			Aflag++;
+			break;
 		case 'c':
 			cflag++;
 			break;
@@ -268,7 +301,7 @@ main(int argc, char **argv)
 		if (optind != argc-1)	/* need a device */
 			usage();
 		fs = argv[argc-1];
-	} else if (wflag || sflag || oflag) {
+	} else if (Aflag || wflag || sflag || oflag) {
 		if (optind != argc)
 			usage();
 	} else 
@@ -293,6 +326,9 @@ main(int argc, char **argv)
 	if (Uflag)
 		return(hasxfsquota(USRQUOTA, XFS_QUOTA_UDQ_ACCT, fs));
 
+	if (Aflag)
+		return(check_aio_support());
+
 	if (sflag) {
 		printf("%d\n", getpagesize());
 		exit(0);
diff --git a/tests/generic/112 b/tests/generic/112
index 55be3948..0ab1c8c8 100755
--- a/tests/generic/112
+++ b/tests/generic/112
@@ -122,6 +122,7 @@ _process_args()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_aio
 
 [ -x $here/ltp/aio-stress ] || \
 	_notrun "fsx not built with AIO for this platform"
diff --git a/tests/generic/113 b/tests/generic/113
index 54d61918..7e20d684 100755
--- a/tests/generic/113
+++ b/tests/generic/113
@@ -77,6 +77,7 @@ _do_test()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_aio
 _require_odirect
 
 [ -x $here/ltp/aio-stress ] || _notrun "aio-stress not built for this platform"
diff --git a/tests/xfs/240 b/tests/xfs/240
index 62a7735b..fa0edc77 100755
--- a/tests/xfs/240
+++ b/tests/xfs/240
@@ -49,9 +49,8 @@ _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
 _require_xfs_io_command "cowextsize"
-_require_test_program "aio-dio-regress/aiocp"
+_require_aiodio "aiocp"
 AIO_TEST="src/aio-dio-regress/aiocp"
-_require_odirect
 
 rm -f $seqres.full
 
diff --git a/tests/xfs/241 b/tests/xfs/241
index 5b29f4d1..b3096732 100755
--- a/tests/xfs/241
+++ b/tests/xfs/241
@@ -46,9 +46,8 @@ _supported_fs xfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "cowextsize"
-_require_test_program "aio-dio-regress/aiocp"
+_require_aiodio "aiocp"
 AIO_TEST="src/aio-dio-regress/aiocp"
-_require_odirect
 
 rm -f $seqres.full
 
-- 
2.13.0.303.g4ebf302169-goog

