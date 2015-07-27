Received: from imap.thunk.org ([74.207.234.97]:46576 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754313AbbG0OWv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Jul 2015 10:22:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/4] xfstests: remove manual declaration of errno
Date: Mon, 27 Jul 2015 10:22:47 -0400
Message-Id: <1438006967-18815-5-git-send-email-tytso@mit.edu>
In-Reply-To: <1438006967-18815-1-git-send-email-tytso@mit.edu>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

locktest.c has already #included <errno.h>, so remove the unneeded
(and in some cases, incorrect) manual declaration of errno as an
integer.  Some C libraries use a macro to provide thread-safety for
errno, so it's incorrect to try to provide a manual declaration.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 src/locktest.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/locktest.c b/src/locktest.c
index 23bb240..adf8ce0 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -779,7 +779,6 @@ main(int argc, char *argv[])
     char	*p;
     extern char	*optarg;
     extern int	optind;
-    extern int	errno;
     int fail_count = 0;; 
     
     atexit(cleanup);
-- 
2.3.0

