Received: from imap.thunk.org ([74.207.234.97]:37878 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbbGZMVH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 26 Jul 2015 08:21:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/6] xfsprogs: pull in libgen.h to get prototype for basename()
Date: Sun, 26 Jul 2015 08:20:51 -0400
Message-Id: <1437913255-7524-3-git-send-email-tytso@mit.edu>
In-Reply-To: <1437913255-7524-1-git-send-email-tytso@mit.edu>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: xfs@oss.sgi.com
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The function prototype for basename() is in <libgen.h>, per Posix.
Without the the function prototype, the build will throw errors due to
the missing prototype.

On glibc, using libgen.h will force the use of Poxis's basename(),
instead of glibc's basename() with GNU extensions.  However, xfsprogs
doesn't depend on any of the GNU extensions, so this is fine.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 include/platform_defs.h.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/platform_defs.h.in b/include/platform_defs.h.in
index 3e059af..bfab7cc 100644
--- a/include/platform_defs.h.in
+++ b/include/platform_defs.h.in
@@ -35,6 +35,7 @@
 #include <sys/types.h>
 #include <limits.h>
 #include <stdbool.h>
+#include <libgen.h>
 
 #undef HAVE___U32
 #ifdef HAVE___U32
-- 
2.3.0

