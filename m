Received: from mx2.suse.de ([195.135.220.15]:54966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeCOVzG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Mar 2018 17:55:06 -0400
From: jeffm@suse.com
Subject: [PATCH 1/4] build: remove dead AC_PACKAGE_WANT_NDBM macro
Date: Thu, 15 Mar 2018 17:54:52 -0400
Message-Id: <20180315215455.8245-2-jeffm@suse.com>
In-Reply-To: <20180315215455.8245-1-jeffm@suse.com>
References: <20180315215455.8245-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: xfstests list <fstests@vger.kernel.org>
Cc: Luis Rodriguez <mcgrof@suse.com>, Eryu Guan <eguan@redhat.com>, Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

Commit fb05a918085 build: remove IRIX-specific build logic) removed
the tests used on IRIX but missed AC_PACKAGE_WANT_NDBM.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 m4/package_gdbmdev.m4 | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/m4/package_gdbmdev.m4 b/m4/package_gdbmdev.m4
index e9634316..484b751a 100644
--- a/m4/package_gdbmdev.m4
+++ b/m4/package_gdbmdev.m4
@@ -1,23 +1,3 @@
-AC_DEFUN([AC_PACKAGE_WANT_NDBM],
-  [ AC_CHECK_HEADERS(ndbm.h, [ have_db=true ], [ have_db=false ])
-    found=false
-    libgdbm=""
-
-    if test $have_db = true; then
-      AC_CHECK_LIB(ndbm,dbm_open,found=true,found=false)
-      AC_CHECK_LIB(ndbm,dbm_fetch,,found=false)
-      AC_CHECK_LIB(ndbm,dbm_store,,found=false)
-      AC_CHECK_LIB(ndbm,dbm_close,,found=false)
-
-      if test $found = true; then
-        libgdbm="$ndbm"
-      fi
-    fi
-
-    AC_SUBST(libgdbm)
-    AC_SUBST(have_db)
-  ])
-
 AC_DEFUN([AC_PACKAGE_WANT_GDBM],
   [ AC_CHECK_HEADER(gdbm-ndbm.h, [ gdbm_ndbm=true; have_db=true ], [ gdbm_ndbm=false; have_db=false ])
 
-- 
2.15.1

