Received: from mx1.mpynet.fi ([82.197.21.84]:47354 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751110AbeAVP5w (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Jan 2018 10:57:52 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2 6/8] fssum: Use bswap_64() instead of __bswap_64()
Date: Mon, 22 Jan 2018 15:57:17 +0000
Message-ID: <1516636639-9107-7-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Macros and functions starting with two underscores are usually internal
and shouldn't be used by applications when a version without "__" is
available.

Include byteswap.h explicitly since bswap_64() is defined there.

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 src/fssum.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/fssum.c b/src/fssum.c
index 13111d6..46e02ba 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -40,6 +40,7 @@
 #include <netinet/in.h>
 #include <inttypes.h>
 #include <assert.h>
+#include <byteswap.h>
 
 #define CS_SIZE 16
 #define CHUNKS	128
@@ -51,7 +52,7 @@
 #endif
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
-#define htonll(x)     __bswap_64 (x)
+#define htonll(x)     bswap_64 (x)
 #else
 #define htonll(x)     (x)
 #endif
-- 
2.1.4

