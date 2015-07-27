Received: from imap.thunk.org ([74.207.234.97]:46582 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754318AbbG0OWv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Jul 2015 10:22:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/4] xfstests: if DEV_BSIZE is not defined, assume it to be 512
Date: Mon, 27 Jul 2015 10:22:44 -0400
Message-Id: <1438006967-18815-2-git-send-email-tytso@mit.edu>
In-Reply-To: <1438006967-18815-1-git-send-email-tytso@mit.edu>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

On Linux systems with glibc, DEV_BSIZE defines the sector size for the
Linux kernel, which is 512 since the beginning of time --- and which
we can't really change without breaking a huge amount of kernel code.
Some non-glibc C libraries, may not define DEV_BSIZE; if it does not
exist, assume that it will be 512.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/str_to_bytes.c | 4 ++++
 lib/write_log.c    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/lib/str_to_bytes.c b/lib/str_to_bytes.c
index c0d7d97..d63e93b 100644
--- a/lib/str_to_bytes.c
+++ b/lib/str_to_bytes.c
@@ -44,7 +44,11 @@
  ****************************************************************************/
 
 #if linux
+#ifdef DEV_BSIZE
 #define B_MULT	DEV_BSIZE	/* block size */
+#else
+#define B_MULT	512		/* block size */
+#endif
 #endif
 
 
diff --git a/lib/write_log.c b/lib/write_log.c
index 8c921fc..852a2ae 100644
--- a/lib/write_log.c
+++ b/lib/write_log.c
@@ -62,7 +62,11 @@
 
 #ifndef BSIZE
 #ifdef linux
+#ifdef DEV_BSIZE
 #define BSIZE DEV_BSIZE
+#else  /* !DEV_BSIZE */
+#define BSIZE 512
+#endif	/* DEV_BSIZE */
 #else
 #define BSIZE BBSIZE
 #endif
-- 
2.3.0

