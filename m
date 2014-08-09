Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:52006 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbaHIFUS (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 9 Aug 2014 01:20:18 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] xfstests: fix up autoconf test for libgdbm_compat when building statically
Date: Sat,  9 Aug 2014 01:20:14 -0400
Message-Id: <1407561614-30569-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

When building statically, -lgdbm_compat will not automatically pull in
-lgdbm.  So this needs to be specified explicitly in AC_CHECK_LIB and
in the list of libraries passed to the linker.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 m4/package_gdbmdev.m4 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/m4/package_gdbmdev.m4 b/m4/package_gdbmdev.m4
index ae76e34..734a192 100644
--- a/m4/package_gdbmdev.m4
+++ b/m4/package_gdbmdev.m4
@@ -45,13 +45,13 @@ AC_DEFUN([AC_PACKAGE_WANT_GDBM],
       fi
 
       found="no"
-      AC_CHECK_LIB(gdbm_compat,dbm_open,found=true,found=false)
-      AC_CHECK_LIB(gdbm_compat,dbm_fetch,,found=false)
-      AC_CHECK_LIB(gdbm_compat,dbm_store,,found=false)
-      AC_CHECK_LIB(gdbm_compat,dbm_close,,found="no")
+      AC_CHECK_LIB(gdbm_compat,dbm_open,found=true,found=false,-lgdbm)
+      AC_CHECK_LIB(gdbm_compat,dbm_fetch,,found=false,-lgdbm)
+      AC_CHECK_LIB(gdbm_compat,dbm_store,,found=false,-lgdbm)
+      AC_CHECK_LIB(gdbm_compat,dbm_close,,found="no",-lgdbm)
 
       if test $found = true ; then
-        libgdbm="${libgdbm} -lgdbm_compat"
+        libgdbm="${libgdbm} -lgdbm_compat -lgdbm"
       fi
     fi
 
-- 
2.0.0

