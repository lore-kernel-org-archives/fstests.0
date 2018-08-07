Received: from mail.cn.fujitsu.com ([183.91.158.132]:62418 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727429AbeHGOuS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Aug 2018 10:50:18 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 8BA944B41EE4
        for <fstests@vger.kernel.org>; Tue,  7 Aug 2018 20:35:58 +0800 (CST)
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH] src/stat_test: fix undefined reference to `xfstests_statx'
Date: Tue, 7 Aug 2018 20:35:51 +0800
Message-ID: <20180807123551.5744-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since glibc 2.28 has added the statx function after commit fd70af45528d
("Add the statx function"), stat_test.c will include
/usr/include/bits/statx.h eventually by "include <sys/stat.h>". That causes
the STATX_TYPE has already been defined before include "status.h", then
xfstests_statx will not be defined.

So make fails with the following error message:

/usr/bin/ld: /tmp/cc2Isfch.o: in function `main':
/home/luke/workspace/xfstests-dev/src/stat_test.c:690: undefined reference to `xfstests_statx'
/usr/bin/ld: /tmp/cc2Isfch.o: in function `get_reference':
/home/luke/workspace/xfstests-dev/src/stat_test.c:301: undefined reference to `xfstests_statx'
/usr/bin/ld: /tmp/cc2Isfch.o: in function `main':
/home/luke/workspace/xfstests-dev/src/stat_test.c:642: undefined reference to `xfstests_statx'

Just move out the definition of xfstests_statx between "#ifndef STATX_TYPE"
and "#endif /* STATX_TYPE */".

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
---
 src/statx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/statx.h b/src/statx.h
index 5d58208a94e6..3f239d791dfe 100644
--- a/src/statx.h
+++ b/src/statx.h
@@ -159,6 +159,7 @@ struct statx {
 #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
 
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
+#endif /* STATX_TYPE */
 
 static inline
 int xfstests_statx(int dfd, const char *filename, unsigned flags,
@@ -172,5 +173,4 @@ int xfstests_statx(int dfd, const char *filename, unsigned flags,
 #endif
 }
 
-#endif /* STATX_TYPE */
 #endif /* STATX_H */
-- 
2.18.0



