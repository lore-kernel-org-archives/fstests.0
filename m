Received: from mx2.mpynet.fi ([82.197.21.85]:24126 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbdJEM7L (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Oct 2017 08:59:11 -0400
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH 2/4] writev_on_pagefault: Use ssize_t type for write(2) return value
Date: Thu, 5 Oct 2017 12:49:58 +0000
Message-ID: <1507207800-5688-2-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
References: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

---
 src/writev_on_pagefault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/writev_on_pagefault.c b/src/writev_on_pagefault.c
index 17dbfb7..eaa0c4b 100644
--- a/src/writev_on_pagefault.c
+++ b/src/writev_on_pagefault.c
@@ -43,7 +43,7 @@ void usage(char *progname)
 int main(int argc, char *argv[])
 {
 	int fd, i, c;
-	size_t ret;
+	ssize_t ret;
 	struct iovec *iov;
 	int pagesz = 4096;
 	char *data = NULL;
@@ -107,7 +107,7 @@ int main(int argc, char *argv[])
 	if (ret < 0)
 		perror("writev failed");
 	else
-		printf("wrote %d bytes\n", (int)ret);
+		printf("wrote %zd bytes\n", ret);
 
 	close(fd);
 	return 0;
-- 
2.1.4

