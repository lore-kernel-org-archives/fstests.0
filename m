Received: from mx1.redhat.com ([209.132.183.28]:48152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756718AbcBWETq (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 22 Feb 2016 23:19:46 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 986CA63151
	for <fstests@vger.kernel.org>; Tue, 23 Feb 2016 04:19:46 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] fstests: update autoconf rules to define _GNU_SOURCE where needed
Date: Tue, 23 Feb 2016 12:19:27 +0800
Message-Id: <1456201167-20541-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Starting from xfsprogs commit cb898f157f84 ("linux.h: Use off64_t
instead of loff_t") in v4.5-rc1, fstests failed to build because of
configure error:

    checking xfs/xfs.h usability... no
    checking xfs/xfs.h presence... yes
    configure: WARNING: xfs/xfs.h: present but cannot be compiled
    configure: WARNING: xfs/xfs.h:     check for missing prerequisite headers?
    configure: WARNING: xfs/xfs.h: see the Autoconf documentation
    configure: WARNING: xfs/xfs.h:     section "Present But Cannot Be Compiled"
    configure: WARNING: xfs/xfs.h: proceeding with the compiler's result
    checking for xfs/xfs.h... no

    FATAL ERROR: cannot find a valid <xfs/xfs.h> header file.
    Run "make install-qa" from the xfsprogs source.

and that's because off64_t is not defined without _GNU_SOURCE being set.

Fix it by updating the autoconf rules adding _GNU_SOURCE define for the
following checks:

xfs.h libxfs.h xfs_log_format.h xlog_assign_lsn xqm.h xfsctl

Suggested-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 configure.ac          |  4 +++-
 m4/package_xfslibs.m4 | 19 ++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index d038f95..fa48d2f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -34,7 +34,9 @@ AC_HEADER_STDC
 			cifs/ioctl.h		\
     ])
 
-AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[#include <xfs/libxfs.h>])
+AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
+#define _GNU_SOURCE
+#include <xfs/libxfs.h>])
 
 AC_PACKAGE_NEED_UUIDCOMPARE
 
diff --git a/m4/package_xfslibs.m4 b/m4/package_xfslibs.m4
index 78a3dc4..6bf4704 100644
--- a/m4/package_xfslibs.m4
+++ b/m4/package_xfslibs.m4
@@ -1,27 +1,29 @@
 AC_DEFUN([AC_PACKAGE_NEED_XFS_XFS_H],
-  [ AC_CHECK_HEADERS([xfs/xfs.h])
+  [ AC_CHECK_HEADERS([xfs/xfs.h],,,[#define _GNU_SOURCE])
     if test "$ac_cv_header_xfs_xfs_h" != "yes"; then
         echo
         echo 'FATAL ERROR: cannot find a valid <xfs/xfs.h> header file.'
-        echo 'Run "make install-qa" from the xfsprogs source.'
+        echo 'Run "make install-dev" from the xfsprogs source.'
         exit 1
     fi
   ])
 
 AC_DEFUN([AC_PACKAGE_WANT_LIBXFS_H],
-  [ AC_CHECK_HEADERS([xfs/libxfs.h], [ have_libxfs=true ], [ have_libxfs=false ])
+  [ AC_CHECK_HEADERS([xfs/libxfs.h], [ have_libxfs=true ],
+    [ have_libxfs=false ], [#define _GNU_SOURCE])
     AC_SUBST(have_libxfs)
   ])
 
 AC_DEFUN([AC_PACKAGE_WANT_XLOG_ASSIGN_LSN],
   [ AC_CHECK_DECL(xlog_assign_lsn,
-      [ have_xlog_assign_lsn=true ], [ have_xlog_assign_lsn=false ],
-      [[#include <xfs/libxfs.h>]])
+      [ have_xlog_assign_lsn=true ], [ have_xlog_assign_lsn=false ], [[
+#define _GNU_SOURCE
+#include <xfs/libxfs.h>]])
     AC_SUBST(have_xlog_assign_lsn)
   ])
 
 AC_DEFUN([AC_PACKAGE_NEED_XFS_XQM_H],
-  [ AC_CHECK_HEADERS([xfs/xqm.h])
+  [ AC_CHECK_HEADERS([xfs/xqm.h],,,[#define _GNU_SOURCE])
     if test "$ac_cv_header_xfs_xqm_h" != "yes"; then
         echo
         echo 'FATAL ERROR: cannot find a valid <xfs/xqm.h> header file.'
@@ -99,7 +101,10 @@ AC_DEFUN([AC_PACKAGE_NEED_IRIX_LIBHANDLE],
 
 AC_DEFUN([AC_PACKAGE_NEED_XFSCTL_MACRO],
   [ AC_MSG_CHECKING([xfsctl from xfs/xfs.h])
-    AC_TRY_LINK([#include <xfs/xfs.h>], [ int x = xfsctl(0, 0, 0, 0); ],
+    AC_TRY_LINK([
+#define _GNU_SOURCE
+#include <xfs/xfs.h> ],
+      [ int x = xfsctl(0, 0, 0, 0); ],
       [ echo ok ],
       [ echo
         echo 'FATAL ERROR: cannot find required macros in the XFS headers.'
-- 
2.5.0

