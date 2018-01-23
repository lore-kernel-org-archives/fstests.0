Received: from mx1.mpynet.fi ([82.197.21.84]:44026 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbeAWIJY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 Jan 2018 03:09:24 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v3 6/8] fssum: Use htobe64() instead of a custom macro
Date: Tue, 23 Jan 2018 08:08:18 +0000
Message-ID: <1516694898-16458-1-git-send-email-rostislav@tuxera.com>
In-Reply-To: <20180123074412.GA26914@infradead.org>
References: <20180123074412.GA26914@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: hch@infradead.org
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Remove unnecessary htonll() macro definition.

Macros and functions starting with two underscores are usually internal
and shouldn't be used by applications when a version without "__" is
available.

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
Christoph, I agree with you about this. Using htobe64() is indeed the proper
function to use.
 src/fssum.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 13111d6..2eaa236 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -40,6 +40,7 @@
 #include <netinet/in.h>
 #include <inttypes.h>
 #include <assert.h>
+#include <endian.h>
 
 #define CS_SIZE 16
 #define CHUNKS	128
@@ -49,12 +50,6 @@
 #define SEEK_DATA 3
 #define SEEK_HOLE 4
 #endif
-
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-#define htonll(x)     __bswap_64 (x)
-#else
-#define htonll(x)     (x)
-#endif
 #endif
 
 /* TODO: add hardlink recognition */
@@ -216,7 +211,7 @@ sum_add_sum(sum_t *dst, sum_t *src)
 void
 sum_add_u64(sum_t *dst, uint64_t val)
 {
-	uint64_t v = htonll(val);
+	uint64_t v = htobe64(val);
 	sum_add(dst, &v, sizeof(v));
 }
 
-- 
2.1.4

