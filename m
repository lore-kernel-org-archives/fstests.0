Received: from mail.cn.fujitsu.com ([183.91.158.132]:48124 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751986AbeEQDoC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 May 2018 23:44:02 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3] generic/486: Get rid of the redundant error=%d printing
Date: Thu, 17 May 2018 11:32:27 +0800
Message-ID: <1526527947-4905-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20180517031645.GE29080@desktop.hz.ali.com>
References: <20180517031645.GE29080@desktop.hz.ali.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: darrick.wong@oracle.com, fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) Without the fix, perror() can indicate the actual error(ENODATA).
2) After calling perror() and redirecting the output of perror()
   to a file, errno seems to be set to EINVAL unexpectedly.
   See the following mail for detailed info:
   https://www.spinics.net/lists/fstests/msg09675.html

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/attr_replace_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
index 23adc07..0720bfd 100644
--- a/src/attr_replace_test.c
+++ b/src/attr_replace_test.c
@@ -11,7 +11,7 @@
 #include <sys/stat.h>
 
 #define die() do { perror(""); \
-fprintf(stderr, "error=%d at line %d\n", errno, __LINE__); \
+fprintf(stderr, "error at line %d\n", __LINE__); \
 exit(1); } while (0)
 
 #define fail(...) do { \
-- 
1.8.3.1



