Received: from mail-io0-f175.google.com ([209.85.223.175]:34062 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968551AbdDSXzC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Apr 2017 19:55:02 -0400
Received: by mail-io0-f175.google.com with SMTP id a103so44156829ioj.1
        for <fstests@vger.kernel.org>; Wed, 19 Apr 2017 16:55:02 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] generic: fix statx definition for non-x86 architecture
Date: Wed, 19 Apr 2017 16:54:53 -0700
Message-Id: <20170419235453.8237-1-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: dhowells@redhat.com, eguan@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Fix a compilation error for ARM:
__ILP32__ is defined but not __X32_SYSCALL_BIT.

The check should only apply for x86_64 architecture, statx for other
architectures is not implemented yet - see commit 7acc839c9e57
"statx: Add a system call to make enhanced file info available".

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 src/statx.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/statx.h b/src/statx.h
index b491c018..5d58208a 100644
--- a/src/statx.h
+++ b/src/statx.h
@@ -19,10 +19,12 @@
 #ifndef __NR_statx
 # ifdef __i386__
 #  define __NR_statx 383
-# elif defined (__ILP32__)
-#  define __NR_statx (__X32_SYSCALL_BIT + 332)
 # elif defined(__x86_64__)
-#  define __NR_statx 332
+#  if defined (__ILP32__)
+#   define __NR_statx (__X32_SYSCALL_BIT + 332)
+#  else
+#   define __NR_statx 332
+#  endif
 # endif
 #endif
 
-- 
2.12.2

