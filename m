Received: from imap.thunk.org ([74.207.234.97]:46586 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbbG0OWv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Jul 2015 10:22:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/4] xfstests: Support C libraries that define SIGCHLD instead of SIGCLD
Date: Mon, 27 Jul 2015 10:22:45 -0400
Message-Id: <1438006967-18815-3-git-send-email-tytso@mit.edu>
In-Reply-To: <1438006967-18815-1-git-send-email-tytso@mit.edu>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

SIGCLD is the name used by System V; SIGCHLD is the name defined by
Posix.  Some C libraries will only define SIGCHLD and not SIGCLD, so
accomodate them.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 ltp/doio.c      | 4 ++++
 ltp/growfiles.c | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/ltp/doio.c b/ltp/doio.c
index 966cff1..3e525d4 100644
--- a/ltp/doio.c
+++ b/ltp/doio.c
@@ -361,7 +361,11 @@ char	**argv;
 		case SIGTSTP:
 		case SIGSTOP:
 		case SIGCONT:
+#if defined(SIGCLD)
 		case SIGCLD:
+#elif defined (SIGCHLD)
+		case SIGCHLD:
+#endif
 		case SIGBUS:
 		case SIGSEGV:
 		case SIGQUIT:
diff --git a/ltp/growfiles.c b/ltp/growfiles.c
index 06f179f..19ed013 100644
--- a/ltp/growfiles.c
+++ b/ltp/growfiles.c
@@ -1389,7 +1389,11 @@ set_sig()
 #ifdef SIGRESTART
 	        case SIGRESTART:
 #endif /* SIGRESTART */
-                case SIGCLD:
+#if defined(SIGCLD)
+		case SIGCLD:
+#elif defined(SIGCHLD)
+		case SIGCHLD:
+#endif
                     break;
 
                 default:
-- 
2.3.0

