Received: from mx2.suse.de ([195.135.220.15]:54974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752651AbeCOVzG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Mar 2018 17:55:06 -0400
From: jeffm@suse.com
Subject: [PATCH 4/4] build: fix <ndbm.h> detection in AC_PACKAGE_WANT_GDBM
Date: Thu, 15 Mar 2018 17:54:55 -0400
Message-Id: <20180315215455.8245-5-jeffm@suse.com>
In-Reply-To: <20180315215455.8245-1-jeffm@suse.com>
References: <20180315215455.8245-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: xfstests list <fstests@vger.kernel.org>
Cc: Luis Rodriguez <mcgrof@suse.com>, Eryu Guan <eguan@redhat.com>, Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

SUSE systems export the NDBM interface via /usr/include/ndbm.h

This means that dbtest wasn't built on SUSE systems until
commit 2353022 (build: update AC_PACKAGE_WANT_GDBM() and src/dbtest.c
to build).  That change was incompatible with older
SLES releases due to <ndbm.h> and <gdbm.h> both defining the datum
type, resulting in build failures.

Nothing has ever set HAVE_GDBM_H or checked for the <gdbm.h> header
prior to the above commit, and it's not required on SUSE systems
either, so just remove that entirely.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 m4/package_gdbmdev.m4 | 20 +++-----------------
 src/dbtest.c          |  3 ---
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/m4/package_gdbmdev.m4 b/m4/package_gdbmdev.m4
index 922cbcbc..723900fc 100644
--- a/m4/package_gdbmdev.m4
+++ b/m4/package_gdbmdev.m4
@@ -22,26 +22,12 @@ AC_DEFUN([AC_PACKAGE_WANT_GDBM],
     fi
 
     if test -z "$have_db"; then
-      AC_CHECK_HEADER(gdbm.h,
-	[
-	  have_db=true
-	  gdbm_ndbm_=true
-	], [
-	  have_db=false
-	  gdbm_ndbm_=false
-	])
       AC_CHECK_HEADER(ndbm.h,
 	[
-	  ndbm_=true
-	], [
-	  ndbm_=false
+	  have_db=true
+	  AC_DEFINE(HAVE_NDBM_H, [1],
+		    [Define to 1 if you have the <ndbm.h> header file.])
 	])
-	if test $gdbm_ndbm_ = true; then
-	  if test $ndbm_ = true; then
-	    AC_DEFINE(HAVE_GDBM_H, [1],
-		      [Define to 1 if you have both <gdbm.h> and <ndbm.h> header files.])
-	  fi
-	fi
     fi
 
     if test "$have_db" = true; then
diff --git a/src/dbtest.c b/src/dbtest.c
index f45db4ac..4366dcdf 100644
--- a/src/dbtest.c
+++ b/src/dbtest.c
@@ -22,9 +22,6 @@
 #include <gdbm/ndbm.h>
 #elif HAVE_GDBM_NDBM_H
 #include <gdbm-ndbm.h>
-#elif HAVE_GDBM_H
-#include <gdbm.h>
-#include <ndbm.h>
 #elif HAVE_NDBM_H
 #include <ndbm.h>
 #else
-- 
2.15.1

