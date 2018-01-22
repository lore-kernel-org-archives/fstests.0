Received: from mx1.mpynet.fi ([82.197.21.84]:34152 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbeAVP5v (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Jan 2018 10:57:51 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2 4/8] metaperf: Include linux/param.h explicitly for HZ macro
Date: Mon, 22 Jan 2018 15:57:15 +0000
Message-ID: <1516636639-9107-5-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Glibc includes linux/param.h when we include sys/param.h, whereas musl
libc does not do that. HZ is a Linux-specific macro, therefore include
the header file that defines it explicitly.

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 src/metaperf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/metaperf.c b/src/metaperf.c
index d06b589..5f5a971 100644
--- a/src/metaperf.c
+++ b/src/metaperf.c
@@ -25,6 +25,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <linux/param.h>
 
 typedef	void	*(*fpi_t)(void);
 typedef	void	(*fpt_t)(int, void *);
-- 
2.1.4

