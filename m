Received: from imap.thunk.org ([74.207.234.97]:37885 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbbGZMVH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 26 Jul 2015 08:21:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/6] xfsprogs: define NBBY if not defined by the system header files
Date: Sun, 26 Jul 2015 08:20:50 -0400
Message-Id: <1437913255-7524-2-git-send-email-tytso@mit.edu>
In-Reply-To: <1437913255-7524-1-git-send-email-tytso@mit.edu>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: xfs@oss.sgi.com
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Android's bionic libc doesn't define NBBY; this isn't a standard
define, and since all modern/sane platforms have 8 bits per byte, use
this as a default.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 include/platform_defs.h.in | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/platform_defs.h.in b/include/platform_defs.h.in
index ac260bc..3e059af 100644
--- a/include/platform_defs.h.in
+++ b/include/platform_defs.h.in
@@ -178,4 +178,8 @@ typedef unsigned short umode_t;
 #define max(a,b)	(((a)>(b))?(a):(b))
 #endif
 
+#ifndef NBBY
+#define NBBY 8
+#endif
+
 #endif	/* __XFS_PLATFORM_DEFS_H__ */
-- 
2.3.0

