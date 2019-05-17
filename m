Received: from mx2.suse.de ([195.135.220.15]:55778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727221AbfEQMG4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 May 2019 08:06:56 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] src/attr_replace_test: limit size of extended attribute value
Date: Fri, 17 May 2019 13:06:53 +0100
Message-Id: <20190517120653.22180-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Luis Henriques <lhenriques@suse.com>, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

The maximum size for extended attribute values is 65536 (XATTR_SIZE_MAX).
Since there are filesystems that can set blksize to really big values
(CephFS for example has a default of 4M), it's easy to have this test
failing with fsetxattr returning -E2BIG.

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 src/attr_replace_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
index 0720bfdc18ab..1ca9bf11ba58 100644
--- a/src/attr_replace_test.c
+++ b/src/attr_replace_test.c
@@ -9,6 +9,7 @@
 #include <sys/types.h>
 #include <sys/xattr.h>
 #include <sys/stat.h>
+#include <linux/limits.h>
 
 #define die() do { perror(""); \
 fprintf(stderr, "error at line %d\n", __LINE__); \
@@ -44,6 +45,8 @@ int main(int argc, char *argv[])
 	size = sbuf.st_blksize * 3 / 4;
 	if (!size)
 		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
+	if (size > XATTR_SIZE_MAX)
+		size = XATTR_SIZE_MAX;
 	value = malloc(size);
 	if (!value)
 		fail("Failed to allocate memory\n");
