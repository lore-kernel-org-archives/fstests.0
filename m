Received: from mga03.intel.com ([134.134.136.65]:4267 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfICVIV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 3 Sep 2019 17:08:21 -0400
From: ira.weiny@intel.com
Subject: [PATCH 2/3] src/locktest: Update test header comment
Date: Tue,  3 Sep 2019 14:08:14 -0700
Message-Id: <20190903210815.29545-3-ira.weiny@intel.com>
In-Reply-To: <20190903210815.29545-1-ira.weiny@intel.com>
References: <20190903210815.29545-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

The offset is also used as flags for the OPEN commands.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/locktest.c b/src/locktest.c
index 089951e2d992..6030c7a8a909 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -175,7 +175,7 @@ char *descriptions[] = {
 };
 
 static int64_t tests[][6] =
-	/*	test #	Action	offset		length		expected	server/client */
+	/*	test #	Action	[offset|flags]	length		expected	server/client */
 	{ 	
 	/* Various simple tests exercising the list */
 
-- 
2.20.1
