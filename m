Received: from mail.cn.fujitsu.com ([183.91.158.132]:57859 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753930AbeFTDYb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jun 2018 23:24:31 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] src/t_stripealign.c: Fix complier error
Date: Wed, 20 Jun 2018 11:12:00 +0800
Message-ID: <1529464320-6721-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

The FIEMAP_EXTENT_SHARED flag was added into kernel since commit
8c0414cd524e, so undefined FIEMAP_EXTENT_SHARED resulted in complier
error on old distros(e.g. RHEL6), as below:
----------------------------------------------------------------------
t_stripealign.c:99: error: 'FIEMAP_EXTENT_SHARED' undeclared (first use in this function)
----------------------------------------------------------------------

We fix it by defining the flag manually.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/t_stripealign.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/t_stripealign.c b/src/t_stripealign.c
index 690f743..2685d97 100644
--- a/src/t_stripealign.c
+++ b/src/t_stripealign.c
@@ -20,6 +20,10 @@
 #include <linux/fiemap.h>
 #include <linux/fs.h>
 
+#ifndef FIEMAP_EXTENT_SHARED
+# define FIEMAP_EXTENT_SHARED	0x00002000
+#endif
+
 #define FIEMAP_EXTENT_ACCEPTABLE	(FIEMAP_EXTENT_LAST | \
 		FIEMAP_EXTENT_DATA_ENCRYPTED | FIEMAP_EXTENT_ENCODED | \
 		FIEMAP_EXTENT_UNWRITTEN | FIEMAP_EXTENT_MERGED | \
-- 
1.7.1



