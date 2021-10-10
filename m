Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B6AC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDC960EFD
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 23:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhJJXJD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Oct 2021 19:09:03 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:47452 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232812AbhJJXJC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Oct 2021 19:09:02 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id EBBFB8BA4B
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 10:07:01 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mZhuH-004nTI-1H
        for fstests@vger.kernel.org; Mon, 11 Oct 2021 10:07:01 +1100
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1mZhuG-000uFN-WD
        for fstests@vger.kernel.org;
        Mon, 11 Oct 2021 10:07:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/2] fstests: autoconf has deprecated a bunch of macros
Date:   Mon, 11 Oct 2021 10:06:58 +1100
Message-Id: <20211010230659.216166-2-david@fromorbit.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211010230659.216166-1-david@fromorbit.com>
References: <20211010230659.216166-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61637216
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=8gfv0ekSlNoA:10 a=20KFwNOVAAAA:8 a=cXqCQ8CLNl3YPJw1TkIA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Latest debian unstable environment results in these build warnings:

autoconf
configure.ac:8: warning: The macro `AC_HEADER_STDC' is obsolete.
configure.ac:8: You should run autoupdate.
./lib/autoconf/headers.m4:704: AC_HEADER_STDC is expanded from...
configure.ac:8: the top level
configure.ac:50: warning: The macro `AC_TRY_LINK' is obsolete.
configure.ac:50: You should run autoupdate.
./lib/autoconf/general.m4:2920: AC_TRY_LINK is expanded from...
m4/package_xfslibs.m4:95: AC_PACKAGE_NEED_XFSCTL_MACRO is expanded from...
configure.ac:50: the top level
configure.ac:63: warning: The macro `AC_TRY_LINK' is obsolete.
configure.ac:63: You should run autoupdate.
./lib/autoconf/general.m4:2920: AC_TRY_LINK is expanded from...
acinclude.m4:19: AC_PACKAGE_WANT_FALLOCATE is expanded from...
configure.ac:63: the top level
configure.ac:64: warning: The macro `AC_TRY_LINK' is obsolete.
configure.ac:64: You should run autoupdate.
./lib/autoconf/general.m4:2920: AC_TRY_LINK is expanded from...
acinclude.m4:32: AC_PACKAGE_WANT_OPEN_BY_HANDLE_AT is expanded from...
configure.ac:64: the top level
configure.ac:69: warning: The macro `AC_TRY_LINK' is obsolete.
configure.ac:69: You should run autoupdate.
./lib/autoconf/general.m4:2920: AC_TRY_LINK is expanded from...
m4/package_libcdev.m4:106: AC_HAVE_COPY_FILE_RANGE is expanded from...
configure.ac:69: the top level
configure.ac:107: warning: The macro `AC_CONFIG_HEADER' is obsolete.
configure.ac:107: You should run autoupdate.
./lib/autoconf/status.m4:719: AC_CONFIG_HEADER is expanded from...
configure.ac:107: the top level

So, run autoupdate and then fix all the warnings.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 acinclude.m4          | 16 ++++-------
 configure.ac          |  9 +++----
 m4/package_libcdev.m4 | 63 +++++++++++++++++++------------------------
 m4/package_ncurses.m4 |  7 ++---
 m4/package_xfslibs.m4 |  7 ++---
 5 files changed, 41 insertions(+), 61 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index a605c01c..fd92f0d5 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -18,28 +18,22 @@ AC_DEFUN([AC_PACKAGE_WANT_LINUX_FS_H],
 
 AC_DEFUN([AC_PACKAGE_WANT_FALLOCATE],
   [ AC_MSG_CHECKING([for fallocate])
-    AC_TRY_LINK([
+    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
 #define _GNU_SOURCE
 #define _FILE_OFFSET_BITS 64
 #include <fcntl.h>
-#include <linux/falloc.h> ],
-      [ fallocate(0, 0, 0, 0); ],
-      [ have_fallocate=true; AC_MSG_RESULT(yes) ],
-      [ have_fallocate=false; AC_MSG_RESULT(no) ])
+#include <linux/falloc.h> ]], [[ fallocate(0, 0, 0, 0); ]])],[ have_fallocate=true; AC_MSG_RESULT(yes) ],[ have_fallocate=false; AC_MSG_RESULT(no) ])
     AC_SUBST(have_fallocate)
   ])
 
 AC_DEFUN([AC_PACKAGE_WANT_OPEN_BY_HANDLE_AT],
   [ AC_MSG_CHECKING([for open_by_handle_at])
-    AC_TRY_LINK([
+    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
 #define _GNU_SOURCE
 #include <fcntl.h>
-      ],
-      [
+      ]], [[
           struct file_handle fh;
           open_by_handle_at(0, &fh, 0);
-      ],
-      [ have_open_by_handle_at=true; AC_MSG_RESULT(yes) ],
-      [ have_open_by_handle_at=false; AC_MSG_RESULT(no) ])
+      ]])],[ have_open_by_handle_at=true; AC_MSG_RESULT(yes) ],[ have_open_by_handle_at=false; AC_MSG_RESULT(no) ])
     AC_SUBST(have_open_by_handle_at)
   ])
diff --git a/configure.ac b/configure.ac
index 6e5ab397..cbf83779 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,12 +1,11 @@
-AC_INIT([xfstests], [1.1.1])
+AC_INIT([xfstests],[1.1.2])
 AC_CONFIG_MACRO_DIR([m4])
 LT_INIT
 AC_CONFIG_SRCDIR([src/xfsctl.c])
 AC_PACKAGE_GLOBALS(xfstests)
 AC_PACKAGE_UTILITIES(xfstests)
 
-AC_HEADER_STDC
-    AC_CHECK_HEADERS([	assert.h		\
+AC_CHECK_HEADERS([	assert.h		\
 			bstring.h		\
 			libgen.h		\
 			dirent.h		\
@@ -34,7 +33,7 @@ AC_HEADER_STDC
 			btrfs/ioctl.h		\
 			cifs/ioctl.h		\
 			sys/mman.h		\
-    ])
+])
 
 AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
 #define _GNU_SOURCE
@@ -104,6 +103,6 @@ AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
 #include <linux/btrfs.h>
 ]])
 
-AC_CONFIG_HEADER(include/config.h)
+AC_CONFIG_HEADERS([include/config.h])
 AC_CONFIG_FILES([include/builddefs])
 AC_OUTPUT
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index 14e67e18..5c76c0f7 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -3,15 +3,14 @@
 # 
 AC_DEFUN([AC_HAVE_FADVISE],
   [ AC_MSG_CHECKING([for fadvise ])
-    AC_TRY_COMPILE([
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #define _GNU_SOURCE
 #define _FILE_OFFSET_BITS 64
 #include <fcntl.h>
-    ], [
+    ]], [[
 	posix_fadvise(0, 1, 0, POSIX_FADV_NORMAL);
-    ],	have_fadvise=yes
-	AC_MSG_RESULT(yes),
-	AC_MSG_RESULT(no))
+    ]])],[have_fadvise=yes
+	AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
     AC_SUBST(have_fadvise)
   ])
 
@@ -20,15 +19,14 @@ AC_DEFUN([AC_HAVE_FADVISE],
 # 
 AC_DEFUN([AC_HAVE_MADVISE],
   [ AC_MSG_CHECKING([for madvise ])
-    AC_TRY_COMPILE([
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #define _GNU_SOURCE
 #define _FILE_OFFSET_BITS 64
 #include <sys/mman.h>
-    ], [
+    ]], [[
 	posix_madvise(0, 0, MADV_NORMAL);
-    ],	have_madvise=yes
-	AC_MSG_RESULT(yes),
-	AC_MSG_RESULT(no))
+    ]])],[have_madvise=yes
+	AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
     AC_SUBST(have_madvise)
   ])
 
@@ -37,15 +35,14 @@ AC_DEFUN([AC_HAVE_MADVISE],
 # 
 AC_DEFUN([AC_HAVE_MINCORE],
   [ AC_MSG_CHECKING([for mincore ])
-    AC_TRY_COMPILE([
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #define _GNU_SOURCE
 #define _FILE_OFFSET_BITS 64
 #include <sys/mman.h>
-    ], [
+    ]], [[
 	mincore(0, 0, 0);
-    ],	have_mincore=yes
-	AC_MSG_RESULT(yes),
-	AC_MSG_RESULT(no))
+    ]])],[have_mincore=yes
+	AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
     AC_SUBST(have_mincore)
   ])
 
@@ -54,15 +51,14 @@ AC_DEFUN([AC_HAVE_MINCORE],
 # 
 AC_DEFUN([AC_HAVE_SENDFILE],
   [ AC_MSG_CHECKING([for sendfile ])
-    AC_TRY_COMPILE([
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #define _GNU_SOURCE
 #define _FILE_OFFSET_BITS 64
 #include <sys/sendfile.h>
-    ], [
+    ]], [[
          sendfile(0, 0, 0, 0);
-    ],	have_sendfile=yes
-	AC_MSG_RESULT(yes),
-	AC_MSG_RESULT(no))
+    ]])],[have_sendfile=yes
+	AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
     AC_SUBST(have_sendfile)
   ])
 
@@ -71,14 +67,13 @@ AC_DEFUN([AC_HAVE_SENDFILE],
 #
 AC_DEFUN([AC_HAVE_GETMNTENT],
   [ AC_MSG_CHECKING([for getmntent ])
-    AC_TRY_COMPILE([
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #include <stdio.h>
 #include <mntent.h>
-    ], [
+    ]], [[
          getmntent(0);
-    ], have_getmntent=yes
-       AC_MSG_RESULT(yes),
-       AC_MSG_RESULT(no))
+    ]])],[have_getmntent=yes
+       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
     AC_SUBST(have_getmntent)
   ])
 
@@ -87,15 +82,14 @@ AC_DEFUN([AC_HAVE_GETMNTENT],
 #
 AC_DEFUN([AC_HAVE_GETMNTINFO],
   [ AC_MSG_CHECKING([for getmntinfo ])
-    AC_TRY_COMPILE([
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #include <sys/param.h>
 #include <sys/ucred.h>
 #include <sys/mount.h>
-    ], [
+    ]], [[
          getmntinfo(0, 0);
-    ], have_getmntinfo=yes
-       AC_MSG_RESULT(yes),
-       AC_MSG_RESULT(no))
+    ]])],[have_getmntinfo=yes
+       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
     AC_SUBST(have_getmntinfo)
   ])
 
@@ -105,15 +99,14 @@ AC_DEFUN([AC_HAVE_GETMNTINFO],
 #
 AC_DEFUN([AC_HAVE_COPY_FILE_RANGE],
   [ AC_MSG_CHECKING([for copy_file_range])
-    AC_TRY_LINK([
+    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
 #define _GNU_SOURCE
 #include <sys/syscall.h>
 #include <unistd.h>
-    ], [
+    ]], [[
          syscall(__NR_copy_file_range, 0, 0, 0, 0, 0, 0);
-    ], have_copy_file_range=yes
-       AC_MSG_RESULT(yes),
-       AC_MSG_RESULT(no))
+    ]])],[have_copy_file_range=yes
+       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
     AC_SUBST(have_copy_file_range)
   ])
 
diff --git a/m4/package_ncurses.m4 b/m4/package_ncurses.m4
index 83a2c382..b220dd64 100644
--- a/m4/package_ncurses.m4
+++ b/m4/package_ncurses.m4
@@ -19,12 +19,9 @@ AC_DEFUN([AC_PACKAGE_WANT_WORKING_LIBNCURSES],
     libcurses="-lncurses"
     LIBS="$LIBS $libcurses"
     CFLAGS="$CFLAGS -D_GNU_SOURCE"
-    AC_TRY_LINK([
+    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
 #include <ncurses.h>
-#include <signal.h>],
-        [wgetch(stdscr);],
-        [enable_curses=yes; AC_MSG_RESULT([ok])],
-        [enable_curses=no; libcurses=""; AC_MSG_RESULT([disabling curses])])
+#include <signal.h>]], [[wgetch(stdscr);]])],[enable_curses=yes; AC_MSG_RESULT([ok])],[enable_curses=no; libcurses=""; AC_MSG_RESULT([disabling curses])])
     AC_SUBST(enable_curses)
     AC_SUBST(libcurses)
   ])
diff --git a/m4/package_xfslibs.m4 b/m4/package_xfslibs.m4
index 9be56e11..0746cd1d 100644
--- a/m4/package_xfslibs.m4
+++ b/m4/package_xfslibs.m4
@@ -94,13 +94,10 @@ AC_DEFUN([AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE],
 
 AC_DEFUN([AC_PACKAGE_NEED_XFSCTL_MACRO],
   [ AC_MSG_CHECKING([xfsctl from xfs/xfs.h])
-    AC_TRY_LINK([
+    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
 #define _GNU_SOURCE
 #define _FILE_OFFSET_BITS 64
-#include <xfs/xfs.h> ],
-      [ int x = xfsctl(0, 0, 0, 0); ],
-      [ echo ok ],
-      [ echo
+#include <xfs/xfs.h> ]], [[ int x = xfsctl(0, 0, 0, 0); ]])],[ echo ok ],[ echo
         echo 'FATAL ERROR: cannot find required macros in the XFS headers.'
         echo 'Upgrade your XFS programs (xfsprogs) development package.'
         echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
-- 
2.33.0

