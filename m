Received: from mail-pg0-f41.google.com ([74.125.83.41]:34598 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753585AbcK3WcQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Nov 2016 17:32:16 -0500
Received: by mail-pg0-f41.google.com with SMTP id x23so86728320pgx.1
        for <fstests@vger.kernel.org>; Wed, 30 Nov 2016 14:32:16 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] fstests: allow building with latest xfslibs on 32-bit Linux
Date: Wed, 30 Nov 2016 14:31:42 -0800
Message-Id: <1480545102-51699-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

The next version of xfslibs will require that its users enable
transparent largefile support.  This broke building xfstests on 32-bit
Linux because _FILE_OFFSET_BITS=64 was not getting defined when testing
for xfs headers.  Fix this by defining _FILE_OFFSET_BITS=64 when doing
configure checks for the xfs headers.

It was not necessary to define _FILE_OFFSET_BITS=64 for the actual build
because it's already done, in builddefs.in.

The problem could also be solved by adding AC_SYS_LARGEFILE to
configure.ac.  It's debatable, but I chose not to do that because it
might give the impression that it affects the actual compilation of the
test programs and not just the configure checks.  (Since not all .c
files include config.h first, a _FILE_OFFSET_BITS definition in config.h
wouldn't always take effect.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 m4/package_xfslibs.m4 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/m4/package_xfslibs.m4 b/m4/package_xfslibs.m4
index 6bf4704..5588e9e 100644
--- a/m4/package_xfslibs.m4
+++ b/m4/package_xfslibs.m4
@@ -1,5 +1,8 @@
 AC_DEFUN([AC_PACKAGE_NEED_XFS_XFS_H],
-  [ AC_CHECK_HEADERS([xfs/xfs.h],,,[#define _GNU_SOURCE])
+  [ AC_CHECK_HEADERS([xfs/xfs.h],,,[
+      #define _GNU_SOURCE
+      #define _FILE_OFFSET_BITS 64
+    ])
     if test "$ac_cv_header_xfs_xfs_h" != "yes"; then
         echo
         echo 'FATAL ERROR: cannot find a valid <xfs/xfs.h> header file.'
@@ -23,7 +26,10 @@ AC_DEFUN([AC_PACKAGE_WANT_XLOG_ASSIGN_LSN],
   ])
 
 AC_DEFUN([AC_PACKAGE_NEED_XFS_XQM_H],
-  [ AC_CHECK_HEADERS([xfs/xqm.h],,,[#define _GNU_SOURCE])
+  [ AC_CHECK_HEADERS([xfs/xqm.h],,,[
+        #define _GNU_SOURCE
+        #define _FILE_OFFSET_BITS 64
+    ])
     if test "$ac_cv_header_xfs_xqm_h" != "yes"; then
         echo
         echo 'FATAL ERROR: cannot find a valid <xfs/xqm.h> header file.'
@@ -103,6 +109,7 @@ AC_DEFUN([AC_PACKAGE_NEED_XFSCTL_MACRO],
   [ AC_MSG_CHECKING([xfsctl from xfs/xfs.h])
     AC_TRY_LINK([
 #define _GNU_SOURCE
+#define _FILE_OFFSET_BITS 64
 #include <xfs/xfs.h> ],
       [ int x = xfsctl(0, 0, 0, 0); ],
       [ echo ok ],
-- 
2.8.0.rc3.226.g39d4020

