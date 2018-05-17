Received: from mail.cn.fujitsu.com ([183.91.158.132]:23004 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751332AbeEQBrv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 May 2018 21:47:51 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/486: Get rid of the redundant error=%d printing
Date: Thu, 17 May 2018 09:36:10 +0800
Message-ID: <1526520970-17213-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20180516152714.GA4910@magnolia>
References: <20180516152714.GA4910@magnolia>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: darrick.wong@oracle.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) Without the fix, perror() can indicate the actual error(ENODATA).
2) After calling perror() and redirecting the output of perror()
   to a file, errno seems to be set to EINVAL unexpectedly.
   See the following mail for detailed info:
   https://www.spinics.net/lists/fstests/msg09675.html

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/attr_replace_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
index 23adc07..33fa74d 100644
--- a/src/attr_replace_test.c
+++ b/src/attr_replace_test.c
@@ -11,7 +11,6 @@
 #include <sys/stat.h>
 
 #define die() do { perror(""); \
-fprintf(stderr, "error=%d at line %d\n", errno, __LINE__); \
 exit(1); } while (0)
 
 #define fail(...) do { \
-- 
1.8.3.1



