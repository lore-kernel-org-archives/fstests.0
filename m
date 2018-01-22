Received: from mx1.mpynet.fi ([82.197.21.84]:17845 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751215AbeAVP5v (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Jan 2018 10:57:51 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2 3/8] doio, growfiles: Use standard signal name SIGCHLD instead of SIGCLD
Date: Mon, 22 Jan 2018 15:57:14 +0000
Message-ID: <1516636639-9107-4-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

SIGCLD is synonymous with SIGCHLD, but the former is non-standard and
not supported by some C libraries such as musl.

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 ltp/doio.c      | 2 +-
 ltp/growfiles.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ltp/doio.c b/ltp/doio.c
index b937718..939a1ea 100644
--- a/ltp/doio.c
+++ b/ltp/doio.c
@@ -362,7 +362,7 @@ char	**argv;
 		case SIGTSTP:
 		case SIGSTOP:
 		case SIGCONT:
-		case SIGCLD:
+		case SIGCHLD:
 		case SIGBUS:
 		case SIGSEGV:
 		case SIGQUIT:
diff --git a/ltp/growfiles.c b/ltp/growfiles.c
index ad1ecdf..951b926 100644
--- a/ltp/growfiles.c
+++ b/ltp/growfiles.c
@@ -1389,7 +1389,7 @@ set_sig()
 #ifdef SIGRESTART
 	        case SIGRESTART:
 #endif /* SIGRESTART */
-                case SIGCLD:
+                case SIGCHLD:
                     break;
 
                 default:
-- 
2.1.4

