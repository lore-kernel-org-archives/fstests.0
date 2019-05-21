Received: from mx2.suse.de ([195.135.220.15]:52700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfEUI2k (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 May 2019 04:28:40 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v2] src/attr_replace_test: limit size of extended attribute value
Date: Tue, 21 May 2019 09:28:36 +0100
Message-Id: <20190521082836.4482-1-lhenriques@suse.com>
In-Reply-To: <fa6146ed-e9c3-20da-0baa-36b9ceafbf8f@suse.com>
References: <fa6146ed-e9c3-20da-0baa-36b9ceafbf8f@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
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
index 0720bfdc18ab..cca8dcf8ff60 100644
--- a/src/attr_replace_test.c
+++ b/src/attr_replace_test.c
@@ -9,6 +9,8 @@
 #include <sys/types.h>
 #include <sys/xattr.h>
 #include <sys/stat.h>
+#include <sys/param.h>
+#include <linux/limits.h>
 
 #define die() do { perror(""); \
 fprintf(stderr, "error at line %d\n", __LINE__); \
@@ -44,6 +46,7 @@ int main(int argc, char *argv[])
 	size = sbuf.st_blksize * 3 / 4;
 	if (!size)
 		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
+	size = MIN(size, XATTR_SIZE_MAX);
 	value = malloc(size);
 	if (!value)
 		fail("Failed to allocate memory\n");
