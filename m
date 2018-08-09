Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731994AbeHIRrD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Aug 2018 13:47:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7354F4023444
        for <fstests@vger.kernel.org>; Thu,  9 Aug 2018 15:21:39 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] src/statx: fix undefined reference to xfstests_statx
Date: Thu,  9 Aug 2018 23:21:32 +0800
Message-Id: <20180809152132.4965-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: dhowells@redhat.com
List-ID: <fstests@vger.kernel.org>

xfstests build fails after glibc updated to 2.28:

  /tmp/cc3s96Dw.o: In function `main':
  /root/xfstests-dev/src/stat_test.c:690: undefined reference to `xfstests_statx'
  /tmp/cc3s96Dw.o: In function `get_reference':
  /root/xfstests-dev/src/stat_test.c:301: undefined reference to `xfstests_statx'
  /tmp/cc3s96Dw.o: In function `main':
  /root/xfstests-dev/src/stat_test.c:642: undefined reference to `xfstests_statx'
  collect2: error: ld returned 1 exit status
  gmake[2]: *** [Makefile:82: stat_test] Error 1
  gmake[1]: *** [include/buildrules:31: src] Error 2
  make: *** [Makefile:53: default] Error 2

Due to glibc-headers-2.28 defines struct statx and all related
things, include STATX_TYPE. But xfstests src/statx.h won't build
xfstests_statx() function STATX_TYPE has been defined, that doesn't
make sense.

If all statx things has been defined by glibc, we can skip xfstests
internal statx definition, but xfstests_statx() function is still
needed, because it's called by other programs.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

CC David Howells <dhowells@redhat.com>, the original author of src/statx.h.
For this change won't break his original design.

Thanks,
Zorro

 src/statx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/statx.h b/src/statx.h
index 5d58208a..f6aaafd6 100644
--- a/src/statx.h
+++ b/src/statx.h
@@ -160,6 +160,8 @@ struct statx {
 
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
 
+#endif /* STATX_TYPE */
+
 static inline
 int xfstests_statx(int dfd, const char *filename, unsigned flags,
 		   unsigned int mask, struct statx *buffer)
@@ -172,5 +174,4 @@ int xfstests_statx(int dfd, const char *filename, unsigned flags,
 #endif
 }
 
-#endif /* STATX_TYPE */
 #endif /* STATX_H */
-- 
2.14.4

