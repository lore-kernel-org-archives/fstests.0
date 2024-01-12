Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5D276915
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QegYa+0R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lfraOu3l"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 68CDC21C02
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705077801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NznSBNttnPNeVpUACfhc8g/pKwIuGJJvgTPFKPtFM50=;
	b=QegYa+0RUHe5mQjYzpfOuWjj9VB4vtKG7PUV0PlF7L77hjQZRNeKaKzzVfijciCDy7iEAL
	sXXdgsMVCrqDMTrwxaWXlODpe46uFydlJt+oRAzwPGT6m3jvxhwI2rKXmbt+Y5KWe6XfaO
	Q9QAQHsUGljztRBAH3tsmOi4n/hA0dc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705077799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NznSBNttnPNeVpUACfhc8g/pKwIuGJJvgTPFKPtFM50=;
	b=lfraOu3l/BAEWvMeFawa0vCFZMOjaRWgXaecj5O1UXCEw7MwJmWFE6fwKcL2vvd93XQc9N
	RWdUysAWpO4q8jwzCEEJyM3XqYY5VBnpvJ6hWhtoUGf8GuzcY2n1AKbxrKPe0Oc6qu549H
	t2QTGci6/l6qG+rwKDOLJxPLin8bqb8=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH] build: remove unused m4 macros
Date: Fri, 12 Jan 2024 17:42:30 +0100
Message-ID: <20240112164230.17283-1-ailiop@suse.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Remove a whole lot of unused m4 macros from the build system.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 acinclude.m4            |  5 ---
 configure.ac            |  1 -
 m4/manual_format.m4     | 17 --------
 m4/package_libcdev.m4   | 95 -----------------------------------------
 m4/package_ncurses.m4   | 27 ------------
 m4/package_pthread.m4   | 19 ---------
 m4/package_types.m4     | 50 ----------------------
 m4/package_xfslibs.m4   | 28 ------------
 m4/visibility_hidden.m4 | 22 ----------
 9 files changed, 264 deletions(-)
 delete mode 100644 m4/manual_format.m4
 delete mode 100644 m4/package_ncurses.m4
 delete mode 100644 m4/package_pthread.m4
 delete mode 100644 m4/package_types.m4
 delete mode 100644 m4/visibility_hidden.m4

diff --git a/acinclude.m4 b/acinclude.m4
index fd92f0d53e95..7632e5cc882e 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -7,11 +7,6 @@ AC_DEFUN([AC_PACKAGE_WANT_LINUX_FIEMAP_H],
     AC_SUBST(have_fiemap)
   ])
 
-AC_DEFUN([AC_PACKAGE_WANT_LINUX_PRCTL_H],
-  [ AC_CHECK_HEADERS([sys/prctl.h], [ have_prctl=true ], [ have_prctl=false ])
-    AC_SUBST(have_prctl)
-  ])
-
 AC_DEFUN([AC_PACKAGE_WANT_LINUX_FS_H],
   [ AC_CHECK_HEADER([linux/fs.h])
   ])
diff --git a/configure.ac b/configure.ac
index b22fc52bffef..1a936997b32d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -61,7 +61,6 @@ AC_PACKAGE_WANT_LIBCAP
 AC_PACKAGE_WANT_LINUX_FIEMAP_H
 AC_PACKAGE_WANT_FALLOCATE
 AC_PACKAGE_WANT_OPEN_BY_HANDLE_AT
-AC_PACKAGE_WANT_LINUX_PRCTL_H
 AC_PACKAGE_WANT_LINUX_FS_H
 AC_PACKAGE_WANT_LIBBTRFSUTIL
 
diff --git a/m4/manual_format.m4 b/m4/manual_format.m4
deleted file mode 100644
index 50c6a91480ab..000000000000
--- a/m4/manual_format.m4
+++ /dev/null
@@ -1,17 +0,0 @@
-# 
-# Find format of installed man pages.
-# Always gzipped on Debian, but not Redhat pre-7.0.
-# We don't deal with bzip2'd man pages, which Mandrake uses,
-# someone will send us a patch sometime hopefully. :-)
-# 
-AC_DEFUN([AC_MANUAL_FORMAT],
-  [ have_zipped_manpages=false
-    for d in ${prefix}/share/man ${prefix}/man ; do
-        if test -f $d/man1/man.1.gz
-        then
-            have_zipped_manpages=true
-            break
-        fi
-    done
-    AC_SUBST(have_zipped_manpages)
-  ])
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index d5d88b8e4462..a0d50f4d9b68 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -1,98 +1,3 @@
-# 
-# Check if we have a working fadvise system call
-# 
-AC_DEFUN([AC_HAVE_FADVISE],
-  [ AC_MSG_CHECKING([for fadvise ])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
-#define _GNU_SOURCE
-#define _FILE_OFFSET_BITS 64
-#include <fcntl.h>
-    ]], [[
-	posix_fadvise(0, 1, 0, POSIX_FADV_NORMAL);
-    ]])],[have_fadvise=yes
-	AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
-    AC_SUBST(have_fadvise)
-  ])
-
-# 
-# Check if we have a working madvise system call
-# 
-AC_DEFUN([AC_HAVE_MADVISE],
-  [ AC_MSG_CHECKING([for madvise ])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
-#define _GNU_SOURCE
-#define _FILE_OFFSET_BITS 64
-#include <sys/mman.h>
-    ]], [[
-	posix_madvise(0, 0, MADV_NORMAL);
-    ]])],[have_madvise=yes
-	AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
-    AC_SUBST(have_madvise)
-  ])
-
-# 
-# Check if we have a working mincore system call
-# 
-AC_DEFUN([AC_HAVE_MINCORE],
-  [ AC_MSG_CHECKING([for mincore ])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
-#define _GNU_SOURCE
-#define _FILE_OFFSET_BITS 64
-#include <sys/mman.h>
-    ]], [[
-	mincore(0, 0, 0);
-    ]])],[have_mincore=yes
-	AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
-    AC_SUBST(have_mincore)
-  ])
-
-# 
-# Check if we have a working sendfile system call
-# 
-AC_DEFUN([AC_HAVE_SENDFILE],
-  [ AC_MSG_CHECKING([for sendfile ])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
-#define _GNU_SOURCE
-#define _FILE_OFFSET_BITS 64
-#include <sys/sendfile.h>
-    ]], [[
-         sendfile(0, 0, 0, 0);
-    ]])],[have_sendfile=yes
-	AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
-    AC_SUBST(have_sendfile)
-  ])
-
-#
-# Check if we have a getmntent libc call (Linux)
-#
-AC_DEFUN([AC_HAVE_GETMNTENT],
-  [ AC_MSG_CHECKING([for getmntent ])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
-#include <stdio.h>
-#include <mntent.h>
-    ]], [[
-         getmntent(0);
-    ]])],[have_getmntent=yes
-       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
-    AC_SUBST(have_getmntent)
-  ])
-
-#
-# Check if we have a getmntinfo libc call (FreeBSD, Mac OS X)
-#
-AC_DEFUN([AC_HAVE_GETMNTINFO],
-  [ AC_MSG_CHECKING([for getmntinfo ])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
-#include <sys/param.h>
-#include <sys/ucred.h>
-#include <sys/mount.h>
-    ]], [[
-         getmntinfo(0, 0);
-    ]])],[have_getmntinfo=yes
-       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
-    AC_SUBST(have_getmntinfo)
-  ])
-
 #
 #
 # Check if we have a copy_file_range system call (Linux)
diff --git a/m4/package_ncurses.m4 b/m4/package_ncurses.m4
deleted file mode 100644
index b220dd64122a..000000000000
--- a/m4/package_ncurses.m4
+++ /dev/null
@@ -1,27 +0,0 @@
-AC_DEFUN([AC_PACKAGE_NEED_NCURSES_H],
-  [ AC_CHECK_HEADERS([ncurses.h])
-    if test "$ac_cv_header_ncurses_h" != yes; then
-        echo
-        echo 'FATAL ERROR: could not find a valid ncurses header.'
-        echo 'Install the ncurses development package.'
-        exit 1
-    fi
-  ])
-
-AC_DEFUN([AC_PACKAGE_WANT_WORKING_LIBNCURSES],
-  [ AC_CHECK_LIB(ncurses, initscr,, [
-        echo
-        echo 'FATAL ERROR: could not find a valid ncurses library.'
-        echo 'Install the ncurses library package.'
-        exit 1
-    ])
-    AC_MSG_CHECKING([for bad glibc/ncurses header interaction])
-    libcurses="-lncurses"
-    LIBS="$LIBS $libcurses"
-    CFLAGS="$CFLAGS -D_GNU_SOURCE"
-    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
-#include <ncurses.h>
-#include <signal.h>]], [[wgetch(stdscr);]])],[enable_curses=yes; AC_MSG_RESULT([ok])],[enable_curses=no; libcurses=""; AC_MSG_RESULT([disabling curses])])
-    AC_SUBST(enable_curses)
-    AC_SUBST(libcurses)
-  ])
diff --git a/m4/package_pthread.m4 b/m4/package_pthread.m4
deleted file mode 100644
index be21d2935170..000000000000
--- a/m4/package_pthread.m4
+++ /dev/null
@@ -1,19 +0,0 @@
-AC_DEFUN([AC_PACKAGE_NEED_PTHREAD_H],
-  [ AC_CHECK_HEADERS(pthread.h)
-    if test $ac_cv_header_pthread_h = no; then
-	AC_CHECK_HEADERS(pthread.h,, [
-	echo
-	echo 'FATAL ERROR: could not find a valid pthread header.'
-	exit 1])
-    fi
-  ])
-
-AC_DEFUN([AC_PACKAGE_NEED_PTHREADMUTEXINIT],
-  [ AC_CHECK_LIB(pthread, pthread_mutex_init,, [
-	echo
-	echo 'FATAL ERROR: could not find a valid pthread library.'
-	exit 1
-    ])
-    libpthread=-lpthread
-    AC_SUBST(libpthread)
-  ])
diff --git a/m4/package_types.m4 b/m4/package_types.m4
deleted file mode 100644
index 91db64e987e6..000000000000
--- a/m4/package_types.m4
+++ /dev/null
@@ -1,50 +0,0 @@
-# 
-# Check if we have a type for the pointer's size integer (__psint_t)
-# 
-AC_DEFUN([AC_TYPE_PSINT],
-  [ AC_MSG_CHECKING([for __psint_t ])
-    AC_TRY_COMPILE([
-#include <sys/types.h>
-#include <stdlib.h>
-#include <stddef.h>
-    ], [
-         __psint_t  psint;
-    ], AC_DEFINE(HAVE___PSINT_T) AC_MSG_RESULT(yes) , AC_MSG_RESULT(no))
-  ])
-
-# 
-# Check if we have a type for the pointer's size unsigned (__psunsigned_t)
-# 
-AC_DEFUN([AC_TYPE_PSUNSIGNED],
-  [ AC_MSG_CHECKING([for __psunsigned_t ])
-    AC_TRY_COMPILE([
-#include <sys/types.h>
-#include <stdlib.h>
-#include <stddef.h>
-    ], [
-        __psunsigned_t  psuint;
-    ], AC_DEFINE(HAVE___PSUNSIGNED_T) AC_MSG_RESULT(yes) , AC_MSG_RESULT(no))
-  ])
-
-# 
-# Check type sizes
-# 
-AC_DEFUN([AC_SIZEOF_POINTERS_AND_LONG],
-  [ if test "$cross_compiling" = yes -a -z "$ac_cv_sizeof_long"; then
-      AC_MSG_WARN([Cross compiling; assuming 32bit long and 32bit pointers])
-    fi
-    AC_CHECK_SIZEOF(long, 4)
-    AC_CHECK_SIZEOF(char *, 4)
-    if test $ac_cv_sizeof_long -eq 4 -o $ac_cv_sizeof_long -eq 0; then
-      AC_DEFINE(HAVE_32BIT_LONG)
-    fi
-    if test $ac_cv_sizeof_long -eq 8; then
-      AC_DEFINE(HAVE_64BIT_LONG)
-    fi
-    if test $ac_cv_sizeof_char_p -eq 4 -o $ac_cv_sizeof_char_p -eq 0; then
-      AC_DEFINE(HAVE_32BIT_PTR)
-    fi
-    if test $ac_cv_sizeof_char_p -eq 8; then
-      AC_DEFINE(HAVE_64BIT_PTR)
-    fi
-  ])
diff --git a/m4/package_xfslibs.m4 b/m4/package_xfslibs.m4
index 1549360df60f..2f1dbc695186 100644
--- a/m4/package_xfslibs.m4
+++ b/m4/package_xfslibs.m4
@@ -50,34 +50,6 @@ AC_DEFUN([AC_PACKAGE_NEED_XFS_HANDLE_H],
     fi
   ])
 
-AC_DEFUN([AC_PACKAGE_NEED_LIBXFSINIT_LIBXFS],
-  [ AC_CHECK_LIB(xfs, libxfs_init,, [
-        echo
-        echo 'FATAL ERROR: could not find a valid XFS base library.'
-        echo 'Install or upgrade the XFS library package.'
-        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
-        exit 1
-    ])
-    libxfs="-lxfs"
-    test -f ${libexecdir}${libdirsuffix}/libxfs.la && \
-	libxfs="${libexecdir}${libdirsuffix}/libxfs.la"
-    AC_SUBST(libxfs)
-  ])
-
-AC_DEFUN([AC_PACKAGE_NEED_OPEN_BY_FSHANDLE],
-  [ AC_CHECK_LIB(handle, open_by_fshandle,, [
-        echo
-        echo 'FATAL ERROR: could not find a current XFS handle library.'
-        echo 'Install or upgrade the XFS library package.'
-        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
-        exit 1
-    ])
-    libhdl="-lhandle"
-    test -f ${libexecdir}${libdirsuffix}/libhandle.la && \
-	libhdl="${libexecdir}${libdirsuffix}/libhandle.la"
-    AC_SUBST(libhdl)
-  ])
-
 AC_DEFUN([AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE],
   [ AC_CHECK_LIB(handle, attr_list_by_handle,, [
         echo
diff --git a/m4/visibility_hidden.m4 b/m4/visibility_hidden.m4
deleted file mode 100644
index bfd74e4b64e6..000000000000
--- a/m4/visibility_hidden.m4
+++ /dev/null
@@ -1,22 +0,0 @@
-AC_DEFUN([AC_FUNC_GCC_VISIBILITY],
-  [AC_CACHE_CHECK(whether __attribute__((visibility())) is supported,
-		  libc_cv_visibility_attribute,
-		  [cat > conftest.c <<EOF
-		   int foo __attribute__ ((visibility ("hidden"))) = 1;
-		   int bar __attribute__ ((visibility ("protected"))) = 1;
-EOF
-		  libc_cv_visibility_attribute=no
-		  if ${CC-cc} -Werror -S conftest.c -o conftest.s \
-			>/dev/null 2>&1; then
-		    if grep '\.hidden.*foo' conftest.s >/dev/null; then
-		      if grep '\.protected.*bar' conftest.s >/dev/null; then
-			libc_cv_visibility_attribute=yes
-		      fi
-		    fi
-		  fi
-		  rm -f conftest.[cs]
-		  ])
-   if test $libc_cv_visibility_attribute = yes; then
-     AC_DEFINE(HAVE_VISIBILITY_ATTRIBUTE, [], [GCC supports visibility attributes])
-   fi
-  ])
-- 
2.41.0

