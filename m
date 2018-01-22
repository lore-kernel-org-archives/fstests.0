Received: from mx1.mpynet.fi ([82.197.21.84]:40117 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbeAVP5u (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Jan 2018 10:57:50 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2 1/8] fsstress: Include stddef.h for ptrdiff_t
Date: Mon, 22 Jan 2018 15:57:12 +0000
Message-ID: <1516636639-9107-2-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

In musl C library headers ptrdiff_t is only defined in stddef.h.

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 ltp/fsstress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 4dea029..63c2eb4 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <setjmp.h>
 #include <sys/uio.h>
+#include <stddef.h>
 #include "global.h"
 
 #ifdef HAVE_ATTR_XATTR_H
-- 
2.1.4

