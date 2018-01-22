Received: from mx1.mpynet.fi ([82.197.21.84]:33651 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbeAVP5z (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Jan 2018 10:57:55 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2 8/8] pwrite_mmap_blocked: Include signal.h instead of sys/signal.h
Date: Mon, 22 Jan 2018 15:57:19 +0000
Message-ID: <1516636639-9107-9-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

sys/signal.h is wrong and should not be used. Musl C library warns about
it.

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 src/pwrite_mmap_blocked.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pwrite_mmap_blocked.c b/src/pwrite_mmap_blocked.c
index 26e2230..0ebd746 100644
--- a/src/pwrite_mmap_blocked.c
+++ b/src/pwrite_mmap_blocked.c
@@ -22,7 +22,7 @@
 #include <errno.h>
 #include <time.h>
 #include <sys/mman.h>
-#include <sys/signal.h>
+#include <signal.h>
 #include <sys/stat.h>
 
 
-- 
2.1.4

