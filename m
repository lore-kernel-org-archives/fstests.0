Received: from mga05.intel.com ([192.55.52.43]:19927 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbdLGVfJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Dec 2017 16:35:09 -0500
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 1/3] xfstests: fix _BSD_SOURCE complier warning
Date: Thu,  7 Dec 2017 14:35:01 -0700
Message-Id: <20171207213503.31070-1-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
List-ID: <fstests@vger.kernel.org>

When compiling xfstests with either gcc 6.4.1 or 7.2.1 I see the following
warning:

In file included from /usr/include/stdio.h:27:0,
                 from fssum.c:25:
/usr/include/features.h:148:3: warning: #warning "_BSD_SOURCE and _SVID_SOURCE
are deprecated, use _DEFAULT_SOURCE" [-Wcpp]
 # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"
   ^~~~~~~

The feature_test_macros(7) man page says this about _BSD_SOURCE:

 Since glibc 2.20, this macro is deprecated. It now has the same effect as
 defining _DEFAULT_SOURCE, but generates a compile-time warning (unless
 _DEFAULT_SOURCE is also defined). Use _DEFAULT_SOURCE instead.  To allow
 code that requires _BSD_SOURCE in glibc 2.19 and earlier and
 _DEFAULT_SOURCE in glibc 2.20 and later to compile without warnings,
 define both _BSD_SOURCE and _DEFAULT_SOURCE.

Keep backwards compatibility with older code by defining both _BSD_SOURCE
and _DEFAULT_SOURCE.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 src/fssum.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/fssum.c b/src/fssum.c
index 04052cdc..13111d6f 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -17,6 +17,7 @@
  */
 #ifdef __linux__
 #define _BSD_SOURCE
+#define _DEFAULT_SOURCE
 #define _LARGEFILE64_SOURCE
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
-- 
2.14.3

