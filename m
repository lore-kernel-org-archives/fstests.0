Received: from mx2.suse.de ([195.135.220.15]:54971 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752378AbeCOVzG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Mar 2018 17:55:06 -0400
From: jeffm@suse.com
Subject: [PATCH 2/4] build: AC_PACKAGE_WANT_GDBM, fall back to compat if libgdbm detection fails
Date: Thu, 15 Mar 2018 17:54:53 -0400
Message-Id: <20180315215455.8245-3-jeffm@suse.com>
In-Reply-To: <20180315215455.8245-1-jeffm@suse.com>
References: <20180315215455.8245-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: xfstests list <fstests@vger.kernel.org>
Cc: Luis Rodriguez <mcgrof@suse.com>, Eryu Guan <eguan@redhat.com>, Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

We currently check if libgdbm_compat contains the required symbols
even if libgdbm does.  Let's fall back only when necessary (which
is pretty much always anyway).

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 m4/package_gdbmdev.m4 | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/m4/package_gdbmdev.m4 b/m4/package_gdbmdev.m4
index 484b751a..3e5f33d0 100644
--- a/m4/package_gdbmdev.m4
+++ b/m4/package_gdbmdev.m4
@@ -30,16 +30,15 @@ AC_DEFUN([AC_PACKAGE_WANT_GDBM],
 
       if test $found = true; then
         libgdbm="${libgdbm} -lgdbm"
-      fi
-
-      found="no"
-      AC_CHECK_LIB(gdbm_compat,dbm_open,found=true,found=false,-lgdbm)
-      AC_CHECK_LIB(gdbm_compat,dbm_fetch,,found=false,-lgdbm)
-      AC_CHECK_LIB(gdbm_compat,dbm_store,,found=false,-lgdbm)
-      AC_CHECK_LIB(gdbm_compat,dbm_close,,found="no",-lgdbm)
-
-      if test $found = true ; then
-        libgdbm="${libgdbm} -lgdbm_compat -lgdbm"
+      else
+	AC_CHECK_LIB(gdbm_compat,dbm_open,found=true,found=false,-lgdbm)
+	AC_CHECK_LIB(gdbm_compat,dbm_fetch,,found=false,-lgdbm)
+	AC_CHECK_LIB(gdbm_compat,dbm_store,,found=false,-lgdbm)
+	AC_CHECK_LIB(gdbm_compat,dbm_close,,found="false",-lgdbm)
+
+	if test $found = true ; then
+	  libgdbm="${libgdbm} -lgdbm_compat -lgdbm"
+	fi
       fi
     fi
 
-- 
2.15.1

