Received: from mail-lf0-f68.google.com ([209.85.215.68]:35331 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753432AbdH2NhV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Aug 2017 09:37:21 -0400
Received: by mail-lf0-f68.google.com with SMTP id h132so2150930lfh.2
        for <fstests@vger.kernel.org>; Tue, 29 Aug 2017 06:37:21 -0700 (PDT)
From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 1/3] t_mtab: Add newlines to error messages
Date: Tue, 29 Aug 2017 16:37:13 +0300
Message-Id: <20170829133715.12275-1-tuomas.tynkkynen@iki.fi>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
List-ID: <fstests@vger.kernel.org>

I can't recall anymore what exactly I did to have tests using t_mtab
to fail, but nevertheless this commit adds the proper newlines.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 src/t_mtab.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/t_mtab.c b/src/t_mtab.c
index 9bca9543..5e9d5216 100644
--- a/src/t_mtab.c
+++ b/src/t_mtab.c
@@ -34,7 +34,7 @@ static int signals_have_been_setup = 0;
 /* Ensure that the lock is released if we are interrupted.  */
 static void
 handler (int sig) {
-    fprintf(stderr, "%s", sys_siglist[sig]);
+    fprintf(stderr, "%s\n", sys_siglist[sig]);
     exit(1);
 }
 
@@ -99,7 +99,7 @@ lock_mtab (void) {
 			   Too many files open in the system?
 			   Filesystem full? */
 			fprintf(stderr, "can't create lock file %s: %s "
-			     "(use -n flag to override)",
+			     "(use -n flag to override)\n",
 			     linktargetfile, strerror (errsv));
 			exit(1);
 		}
@@ -112,7 +112,7 @@ lock_mtab (void) {
 
 		if (j < 0 && errsv != EEXIST) {
 			fprintf(stderr, "can't link lock file %s: %s "
-			     "(use -n flag to override)",
+			     "(use -n flag to override)\n",
 			     mounted_lock, strerror (errsv));
 			exit(1);
 		}
@@ -157,7 +157,7 @@ lock_mtab (void) {
 			if (fcntl (fd, F_SETLKW, &flock) == -1 &&
 			    errno != EBUSY && errno != EAGAIN) {
 				int errsv = errno;
-				fprintf(stderr, "can't lock lock file %s: %s",
+				fprintf(stderr, "can't lock lock file %s: %s\n",
 				     mounted_lock, (errno == EINTR) ?
 				     _("timed out") : strerror (errsv));
 				exit(1);
-- 
2.13.0

