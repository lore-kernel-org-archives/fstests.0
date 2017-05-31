Received: from mail-pf0-f194.google.com ([209.85.192.194]:36736 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdEaWkN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 May 2017 18:40:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so4596705pfb.3
        for <fstests@vger.kernel.org>; Wed, 31 May 2017 15:40:13 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 6/6] build: remove IRIX-specific build logic
Date: Wed, 31 May 2017 15:36:55 -0700
Message-Id: <20170531223655.130613-7-ebiggers3@gmail.com>
In-Reply-To: <20170531223655.130613-1-ebiggers3@gmail.com>
References: <20170531223655.130613-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

As xfstests is no longer supported on IRIX, remove the ability to build
xfstests for IRIX.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 configure.ac          |  59 ++++++++++----------------
 include/builddefs.in  |   3 --
 ltp/Makefile          |   4 --
 m4/package_globals.m4 |   2 +-
 m4/package_libcdev.m4 |   2 +-
 m4/package_utilies.m4 |  14 +++----
 m4/package_xfslibs.m4 |  13 ------
 make_irix             | 114 --------------------------------------------------
 src/Makefile          |   4 --
 9 files changed, 32 insertions(+), 183 deletions(-)
 delete mode 100755 make_irix

diff --git a/configure.ac b/configure.ac
index 843ff6b6..57092f1c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -42,45 +42,32 @@ AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
 
 AC_PACKAGE_NEED_UUIDCOMPARE
 
-case $pkg_platform
-in
-	irix)
-		AC_PACKAGE_NEED_SYS_ACL_H
-		AC_PACKAGE_NEED_ATTRIBUTES_H
-		AC_PACKAGE_WANT_NDBM
-		AC_PACKAGE_NEED_IRIX_LIBHANDLE
-		have_attr_list=true
-		AC_SUBST(have_attr_list)
-		;;
-	*)
-		AC_MULTILIB($enable_lib64)
-		AC_PACKAGE_NEED_XFS_XFS_H
-		AC_PACKAGE_WANT_LIBXFS_H
-		AC_PACKAGE_WANT_XLOG_ASSIGN_LSN
-		AC_PACKAGE_NEED_XFS_XQM_H
-		AC_PACKAGE_NEED_XFSCTL_MACRO
-		AC_PACKAGE_NEED_XFS_HANDLE_H
+AC_MULTILIB($enable_lib64)
+AC_PACKAGE_NEED_XFS_XFS_H
+AC_PACKAGE_WANT_LIBXFS_H
+AC_PACKAGE_WANT_XLOG_ASSIGN_LSN
+AC_PACKAGE_NEED_XFS_XQM_H
+AC_PACKAGE_NEED_XFSCTL_MACRO
+AC_PACKAGE_NEED_XFS_HANDLE_H
 
-		AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE
-		AC_PACKAGE_NEED_ATTR_XATTR_H
-		AC_PACKAGE_NEED_ATTRIBUTES_H
-		AC_PACKAGE_WANT_ATTRLIST_LIBATTR
-		AC_PACKAGE_NEED_GETXATTR_LIBATTR
+AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE
+AC_PACKAGE_NEED_ATTR_XATTR_H
+AC_PACKAGE_NEED_ATTRIBUTES_H
+AC_PACKAGE_WANT_ATTRLIST_LIBATTR
+AC_PACKAGE_NEED_GETXATTR_LIBATTR
 
-		AC_PACKAGE_NEED_SYS_ACL_H
-		AC_PACKAGE_NEED_ACL_LIBACL_H
-		AC_PACKAGE_NEED_ACLINIT_LIBACL
+AC_PACKAGE_NEED_SYS_ACL_H
+AC_PACKAGE_NEED_ACL_LIBACL_H
+AC_PACKAGE_NEED_ACLINIT_LIBACL
 
-		AC_PACKAGE_WANT_GDBM
-		AC_PACKAGE_WANT_AIO
-		AC_PACKAGE_WANT_DMAPI
-		AC_PACKAGE_WANT_LINUX_FIEMAP_H
-		AC_PACKAGE_WANT_FALLOCATE
-		AC_PACKAGE_WANT_OPEN_BY_HANDLE_AT
-		AC_PACKAGE_WANT_LINUX_PRCTL_H
-		AC_PACKAGE_WANT_LINUX_FS_H
-		;;
-esac
+AC_PACKAGE_WANT_GDBM
+AC_PACKAGE_WANT_AIO
+AC_PACKAGE_WANT_DMAPI
+AC_PACKAGE_WANT_LINUX_FIEMAP_H
+AC_PACKAGE_WANT_FALLOCATE
+AC_PACKAGE_WANT_OPEN_BY_HANDLE_AT
+AC_PACKAGE_WANT_LINUX_PRCTL_H
+AC_PACKAGE_WANT_LINUX_FS_H
 
 AC_CHECK_FUNCS([renameat2])
 
diff --git a/include/builddefs.in b/include/builddefs.in
index 38fb9c60..cb52b99a 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -76,9 +76,6 @@ endif
 ifeq ($(PKG_PLATFORM),darwin)
 PCFLAGS = -traditional-cpp $(GCCFLAGS)
 endif
-ifeq ($(PKG_PLATFORM),irix)
-PCFLAGS = -nostdinc -I$(ROOT)/usr/include -I$(TOPDIR)/../irix/include
-endif
 ifeq ($(PKG_PLATFORM),freebsd)
 endif
 
diff --git a/ltp/Makefile b/ltp/Makefile
index 5bea4927..eed83f48 100644
--- a/ltp/Makefile
+++ b/ltp/Makefile
@@ -17,10 +17,6 @@ ifeq ($(HAVE_ATTR_LIST), true)
 LCFLAGS += -DHAVE_ATTR_LIST
 LLDLIBS += $(LIBATTR)
 endif
-ifeq ($(PKG_PLATFORM),irix)
-LCFLAGS += -DHAVE_ATTR_LIST
-LLDLIBS += $(LIBATTR)
-endif
 
 ifeq ($(HAVE_AIO), true)
 TARGETS += aio-stress
diff --git a/m4/package_globals.m4 b/m4/package_globals.m4
index 72fbbb78..ce7a8c51 100644
--- a/m4/package_globals.m4
+++ b/m4/package_globals.m4
@@ -39,7 +39,7 @@ AC_DEFUN([AC_PACKAGE_GLOBALS],
     test -z "$DISTRIBUTION" || pkg_distribution="$DISTRIBUTION"
     AC_SUBST(pkg_distribution)
 
-    pkg_platform=`uname -s | tr 'A-Z' 'a-z' | sed -e 's/irix64/irix/'`
+    pkg_platform=`uname -s | tr 'A-Z' 'a-z'`
     test -z "$PLATFORM" || pkg_platform="$PLATFORM"
     AC_SUBST(pkg_platform)
   ])
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index 5156ced6..fb123f33 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -67,7 +67,7 @@ AC_DEFUN([AC_HAVE_SENDFILE],
   ])
 
 #
-# Check if we have a getmntent libc call (IRIX, Linux)
+# Check if we have a getmntent libc call (Linux)
 #
 AC_DEFUN([AC_HAVE_GETMNTENT],
   [ AC_MSG_CHECKING([for getmntent ])
diff --git a/m4/package_utilies.m4 b/m4/package_utilies.m4
index 726406c8..108ef455 100644
--- a/m4/package_utilies.m4
+++ b/m4/package_utilies.m4
@@ -41,7 +41,7 @@ AC_DEFUN([AC_PACKAGE_UTILITIES],
     AC_PACKAGE_NEED_UTILITY($1, "$cc", cc, [C compiler])
 
     if test -z "$MAKE"; then
-        AC_PATH_PROG(MAKE, gmake,, /usr/bin:/usr/local/bin:/usr/freeware/bin)
+        AC_PATH_PROG(MAKE, gmake,, /usr/bin:/usr/local/bin)
     fi
     if test -z "$MAKE"; then
         AC_PATH_PROG(MAKE, make,, /usr/bin)
@@ -54,19 +54,19 @@ AC_DEFUN([AC_PACKAGE_UTILITIES],
 	AC_PATH_PROG(LIBTOOL, glibtool,, /usr/bin)
     fi
     if test -z "$LIBTOOL"; then
-	AC_PATH_PROG(LIBTOOL, libtool,, /usr/bin:/usr/local/bin:/usr/freeware/bin)
+	AC_PATH_PROG(LIBTOOL, libtool,, /usr/bin:/usr/local/bin)
     fi
     libtool=$LIBTOOL
     AC_SUBST(libtool)
     AC_PACKAGE_NEED_UTILITY($1, "$libtool", libtool, [GNU libtool])
 
     if test -z "$TAR"; then
-        AC_PATH_PROG(TAR, tar,, /usr/freeware/bin:/bin:/usr/local/bin:/usr/bin)
+        AC_PATH_PROG(TAR, tar,, /bin:/usr/local/bin:/usr/bin)
     fi
     tar=$TAR
     AC_SUBST(tar)
     if test -z "$ZIP"; then
-        AC_PATH_PROG(ZIP, gzip,, /bin:/usr/bin:/usr/local/bin:/usr/freeware/bin)
+        AC_PATH_PROG(ZIP, gzip,, /bin:/usr/bin:/usr/local/bin)
     fi
 
     zip=$ZIP
@@ -108,14 +108,14 @@ AC_DEFUN([AC_PACKAGE_UTILITIES],
 
     if test "$enable_gettext" = yes; then
         if test -z "$MSGFMT"; then
-                AC_PATH_PROG(MSGFMT, msgfmt,, /usr/bin:/usr/local/bin:/usr/freeware/bin)
+                AC_PATH_PROG(MSGFMT, msgfmt,, /usr/bin:/usr/local/bin)
         fi
         msgfmt=$MSGFMT
         AC_SUBST(msgfmt)
         AC_PACKAGE_NEED_UTILITY($1, "$msgfmt", msgfmt, gettext)
 
         if test -z "$MSGMERGE"; then
-                AC_PATH_PROG(MSGMERGE, msgmerge,, /usr/bin:/usr/local/bin:/usr/freeware/bin)
+                AC_PATH_PROG(MSGMERGE, msgmerge,, /usr/bin:/usr/local/bin)
         fi
         msgmerge=$MSGMERGE
         AC_SUBST(msgmerge)
@@ -123,7 +123,7 @@ AC_DEFUN([AC_PACKAGE_UTILITIES],
     fi
 
     if test -z "$RPM"; then
-        AC_PATH_PROG(RPM, rpm,, /bin:/usr/bin:/usr/freeware/bin)
+        AC_PATH_PROG(RPM, rpm,, /bin:/usr/bin)
     fi
     rpm=$RPM
     AC_SUBST(rpm)
diff --git a/m4/package_xfslibs.m4 b/m4/package_xfslibs.m4
index 5588e9ed..9be56e11 100644
--- a/m4/package_xfslibs.m4
+++ b/m4/package_xfslibs.m4
@@ -92,19 +92,6 @@ AC_DEFUN([AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE],
     AC_SUBST(libhdl)
   ])
 
-AC_DEFUN([AC_PACKAGE_NEED_IRIX_LIBHANDLE],
-  [ 
-    AC_MSG_CHECKING([libhandle.a for IRIX])
-    libhdl="`pwd`/../irix/libhandle/libhandle.a"
-    if ! test -f $libhdl; then
-	echo 'no'
-        echo 'FATAL ERROR: could not find IRIX XFS handle library.'
-        exit 1
-    fi
-    echo 'yes'
-    AC_SUBST(libhdl)
-  ])
-
 AC_DEFUN([AC_PACKAGE_NEED_XFSCTL_MACRO],
   [ AC_MSG_CHECKING([xfsctl from xfs/xfs.h])
     AC_TRY_LINK([
diff --git a/make_irix b/make_irix
deleted file mode 100755
index d1782785..00000000
--- a/make_irix
+++ /dev/null
@@ -1,114 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) 2004 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#
-# Do a build using the IRIX TOOLROOT
-# Use "-f" to force a configure.
-#
-
-error=false
-
-# Do initial checks
-
-# check have root/toolroot set
-if [ -z "$TOOLROOT" ]; then
-	echo "TOOLROOT needs to be set to a populated IRIX toolroot"
-	error=true
-fi 
-if [ -z "$ROOT" ]; then
-	echo "ROOT needs to be set to a populated IRIX root"
-	error=true
-fi 
-
-# check we have c compiler license
-if ! grep -iq '^feature cc' /var/flexlm/license.dat; then
-	echo "Unable to find cc license for IRIX"
-	echo "Get license: http://www.csd.sgi.com/prod/software/swl/keyrequest.html"
-	error=true
-fi
-
-# check we have dev.sw.lib installed
-# needed by ld32 even though we have $ROOT
-if versions dev.sw.lib | grep -q dev.sw.lib; then
-	:
-else
-	echo "dev.sw.lib is not installed"
-	echo "Install from irix-6.5-development-libraries-1/dist"
-	error=true
-fi
-
-# any check failures then exit out
-$error && exit 1
-
-# root/toolroot paths
-fw_bin=$TOOLROOT/usr/freeware/bin
-fw_tools=$TOOLROOT/usr/fw_tools
-fw_share=$ROOT/usr/freeware/share
-irix_bin=$TOOLROOT/usr/bin
-
-# env vars
-export AC_MACRODIR=$fw_share/autoconf
-export M4=$irix_bin/gnum4
-export CC=$irix_bin/cc
-export LIBTOOL=$fw_bin/libtool
-export MAKE=$fw_tools/gmake
-export AWK=$irix_bin/nawk
-
-# check all tools/files are in root/toolroot that we need
-FILES="$AC_MACRODIR $M4 $CC $LIBTOOL $MAKE $fw_bin/aclocal $fw_bin/autoheader $fw_bin/autoconf"
-for f in $FILES; do
-	if [ ! -e $f ]; then
-		echo "file $f not found in ROOT/TOOLROOT"
-		error=true
-	fi
-done
-$error && exit 1
-
-# force a full configure
-if [ $# -eq 1 ]; then
-	if [ $1 = "-f" ]; then
-		rm -f config.cache configure include/builddefs
-		shift
-	fi
-fi
-
-# --- do all the configure stuff using the toolroot paths ---
-
-# aclocal.m4 is actually checked in - probably won't recreate it often
-if [ ! -e aclocal.m4 ]; then
-	set -x
-	$fw_bin/aclocal --acdir=m4 --output=aclocal.m4
-	set -
-fi
-
-if [ ! -e ./configure ]; then
-	set -x
-	$fw_bin/autoheader
-	$fw_bin/autoconf
-	set -
-fi
-
-if [ ! -e include/builddefs ]; then
-	set -x
-	./configure
-	set -
-fi
-
-# Now call gmake with any args we were given
-set -x
-$MAKE $@
-set -
diff --git a/src/Makefile b/src/Makefile
index 4ec01975..5c87c29c 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -49,10 +49,6 @@ ifeq ($(PKG_PLATFORM),linux)
 TARGETS += $(LINUX_TARGETS)
 endif
 
-ifeq ($(PKG_PLATFORM),irix)
-LLDLIBS += -lgen
-endif
-
 ifeq ($(HAVE_DB), true)
 TARGETS += dbtest
 LLDLIBS += $(LIBGDBM)
-- 
2.13.0.506.g27d5fe0cd-goog

