Received: from mail-pf0-f196.google.com ([209.85.192.196]:34780 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbdG2EPU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Jul 2017 00:15:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id u17so3545634pfa.1
        for <fstests@vger.kernel.org>; Fri, 28 Jul 2017 21:15:20 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests: include <sys/sysmacros.h> for major() and minor()
Date: Fri, 28 Jul 2017 21:13:41 -0700
Message-Id: <20170729041341.2564-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

This resolves the following deprecation warning (and other instances of
the same warning) when compiling with glibc 2.25 or later:

stat_test.c: In function 'cmp_statx':
stat_test.c:251:13: warning: In the GNU C Library, "major" is defined
 by <sys/sysmacros.h>. For historical compatibility, it is
 currently defined by <sys/types.h> as well, but we plan to
 remove this soon. To use "major", include <sys/sysmacros.h>
 directly. If you did not intend to use a system-defined macro
 "major", you should undefine it after including <sys/types.h>.
  devcmp(dev);
             ^

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 src/fssum.c     | 1 +
 src/stat_test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/src/fssum.c b/src/fssum.c
index 88e75621..04052cdc 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -31,6 +31,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #ifdef __SOLARIS__
 #include <sys/mkdev.h>
 #endif
diff --git a/src/stat_test.c b/src/stat_test.c
index fc87ed5c..198c1332 100644
--- a/src/stat_test.c
+++ b/src/stat_test.c
@@ -19,6 +19,7 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include "statx.h"
 
 static bool failed = false;
-- 
2.13.3

