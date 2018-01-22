Received: from mx1.mpynet.fi ([82.197.21.84]:50585 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeAVP5w (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Jan 2018 10:57:52 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2 5/8] dmiperf: Include sys/types.h for u_int32_t
Date: Mon, 22 Jan 2018 15:57:16 +0000
Message-ID: <1516636639-9107-6-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

u_int32_t type is defined in sys/types.h, which is often included by
glibc implicitly when some other headers are used, but other C libraries
such as musl may not necessarily do so, therefore an explicit include is
needed.

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 src/dmiperf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dmiperf.c b/src/dmiperf.c
index 245e529..359324a 100644
--- a/src/dmiperf.c
+++ b/src/dmiperf.c
@@ -16,6 +16,7 @@
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <sys/types.h>
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <sys/time.h>
-- 
2.1.4

