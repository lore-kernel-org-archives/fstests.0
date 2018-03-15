Received: from mx2.suse.de ([195.135.220.15]:54977 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752575AbeCOVzG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Mar 2018 17:55:06 -0400
From: jeffm@suse.com
Subject: [PATCH 3/4] build: clean up AC_PACKAGE_WANT_GDBM
Date: Thu, 15 Mar 2018 17:54:54 -0400
Message-Id: <20180315215455.8245-4-jeffm@suse.com>
In-Reply-To: <20180315215455.8245-1-jeffm@suse.com>
References: <20180315215455.8245-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: xfstests list <fstests@vger.kernel.org>
Cc: Luis Rodriguez <mcgrof@suse.com>, Eryu Guan <eguan@redhat.com>, Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

The AC_PACKAGE_WANT_GDBM macro is not easily read.  It's not doing anything
particularly complex other than working through a set of alternatives
for headers and libraries.

This patch cleans it up to be more readable.  We also only attempt to
check in libgdbm_compat if the checks in libgdbm fail.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 m4/package_gdbmdev.m4 | 87 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/m4/package_gdbmdev.m4 b/m4/package_gdbmdev.m4
index 3e5f33d0..922cbcbc 100644
--- a/m4/package_gdbmdev.m4
+++ b/m4/package_gdbmdev.m4
@@ -1,43 +1,66 @@
 AC_DEFUN([AC_PACKAGE_WANT_GDBM],
-  [ AC_CHECK_HEADER(gdbm-ndbm.h, [ gdbm_ndbm=true; have_db=true ], [ gdbm_ndbm=false; have_db=false ])
+  [
+    have_db=
+    AC_CHECK_HEADER(gdbm-ndbm.h,
+      [
+	have_db=true
+        AC_DEFINE(HAVE_GDBM_NDBM_H, [1],
+		  [Define to 1 if you have the <gdbm-ndbm.h> header file.])
+      ])
 
-    if test $gdbm_ndbm = true; then
-        AC_DEFINE(HAVE_GDBM_NDBM_H, [1], [Define to 1 if you have the <gdbm-ndbm.h> header file.])
-    else
-        AS_UNSET([ac_cv_header_gdbm_ndbm_h])
-        AC_CHECK_HEADER(gdbm/ndbm.h, [ gdbm_ndbm_=true; have_db=true ], [ gdbm_ndbm_=false; have_db=false ])
-        if test $gdbm_ndbm_ = true; then
-            AC_DEFINE(HAVE_GDBM_NDBM_H_, [1], [Define to 1 if you have the <gdbm/ndbm.h> header file.])
-        else
-            AC_CHECK_HEADER(gdbm.h, [ gdbm_ndbm_=true; have_db=true ], [ gdbm_ndbm_=false; have_db=false ])
-            AC_CHECK_HEADER(ndbm.h, [ ndbm_=true ], [ ndbm_=false ])
-                if test $gdbm_ndbm_ = true; then
-                    if test $ndbm_ = true; then
-                        AC_DEFINE(HAVE_GDBM_H, [1], [Define to 1 if you have both <gdbm.h> and <ndbm.h> header files.])
-                    fi
-                fi
-        fi
+    if test -z "$have_db"; then
+      dnl gdbm-ndbm.h and gdbm/ndbm.h map to the same autoconf internal
+      dnl variable.  We need to clear it or this test will be skipped
+      dnl and the cached result from first test will be used.
+      AS_UNSET([ac_cv_header_gdbm_ndbm_h])
+      AC_CHECK_HEADER(gdbm/ndbm.h,
+	[
+	  have_db=true
+	  AC_DEFINE(HAVE_GDBM_NDBM_H_, [1],
+		    [Define to 1 if you have the <gdbm/ndbm.h> header file.])
+	])
     fi
 
-    found=false
-    libgdbm=""
+    if test -z "$have_db"; then
+      AC_CHECK_HEADER(gdbm.h,
+	[
+	  have_db=true
+	  gdbm_ndbm_=true
+	], [
+	  have_db=false
+	  gdbm_ndbm_=false
+	])
+      AC_CHECK_HEADER(ndbm.h,
+	[
+	  ndbm_=true
+	], [
+	  ndbm_=false
+	])
+	if test $gdbm_ndbm_ = true; then
+	  if test $ndbm_ = true; then
+	    AC_DEFINE(HAVE_GDBM_H, [1],
+		      [Define to 1 if you have both <gdbm.h> and <ndbm.h> header files.])
+	  fi
+	fi
+    fi
 
-    if test $have_db = true; then
-      AC_CHECK_LIB(gdbm,dbm_open,found=true,found=false)
-      AC_CHECK_LIB(gdbm,dbm_fetch,,found=false)
-      AC_CHECK_LIB(gdbm,dbm_store,,found=false)
-      AC_CHECK_LIB(gdbm,dbm_close,,found=false)
+    if test "$have_db" = true; then
+      found=false
+      AC_CHECK_LIB(gdbm, dbm_open, found=true, found=false)
+      AC_CHECK_LIB(gdbm, dbm_fetch,, found=false)
+      AC_CHECK_LIB(gdbm, dbm_store,, found=false)
+      AC_CHECK_LIB(gdbm, dbm_close,, found=false)
 
-      if test $found = true; then
-        libgdbm="${libgdbm} -lgdbm"
+      if test "$found" = true; then
+        libgdbm="-lgdbm"
       else
-	AC_CHECK_LIB(gdbm_compat,dbm_open,found=true,found=false,-lgdbm)
-	AC_CHECK_LIB(gdbm_compat,dbm_fetch,,found=false,-lgdbm)
-	AC_CHECK_LIB(gdbm_compat,dbm_store,,found=false,-lgdbm)
-	AC_CHECK_LIB(gdbm_compat,dbm_close,,found="false",-lgdbm)
+	AC_CHECK_LIB(gdbm_compat, dbm_open, found=true, found=false, -lgdbm)
+	AC_CHECK_LIB(gdbm_compat, dbm_fetch,, found=false, -lgdbm)
+	AC_CHECK_LIB(gdbm_compat, dbm_store,, found=false, -lgdbm)
+	AC_CHECK_LIB(gdbm_compat, dbm_close,, found="no", -lgdbm)
 
-	if test $found = true ; then
-	  libgdbm="${libgdbm} -lgdbm_compat -lgdbm"
+	if test "$found" = "true"; then
+	  libgdbm="-lgdbm_compat -lgdbm"
 	fi
       fi
     fi
-- 
2.15.1

