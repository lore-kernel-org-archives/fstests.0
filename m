Received: from mx1.mpynet.fi ([82.197.21.84]:57039 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbeAVP5z (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Jan 2018 10:57:55 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2 7/8] t_mtab: Replace sys_siglist[] with strsignal()
Date: Mon, 22 Jan 2018 15:57:18 +0000
Message-ID: <1516636639-9107-8-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

strsignal(3) says that strsignal() should be used instead of
sys_siglist[].

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 src/t_mtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/t_mtab.c b/src/t_mtab.c
index 5e9d521..fd85c6b 100644
--- a/src/t_mtab.c
+++ b/src/t_mtab.c
@@ -34,7 +34,7 @@ static int signals_have_been_setup = 0;
 /* Ensure that the lock is released if we are interrupted.  */
 static void
 handler (int sig) {
-    fprintf(stderr, "%s\n", sys_siglist[sig]);
+    fprintf(stderr, "%s\n", strsignal(sig));
     exit(1);
 }
 
-- 
2.1.4

