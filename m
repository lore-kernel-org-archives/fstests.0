Received: from mx2.mpynet.fi ([82.197.21.85]:41190 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbdJEM7L (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Oct 2017 08:59:11 -0400
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH 1/4] fsstress: Fix wrong size argument to getcwd()
Date: Thu, 5 Oct 2017 12:49:57 +0000
Message-ID: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Fixes the following ASAN failure:

==11670==WARNING: AddressSanitizer failed to allocate 0xffffffffffffffff bytes
==11670==AddressSanitizer's allocator is terminating the process instead of returning 0

...

    #5 0x4bb230 in __interceptor_malloc /home/vak-local/3.9.1/release/final/llvm.src/projects/compiler-rt/lib/asan/asan_malloc_linux.cc:65:10
    #6 0x7f97e6491405 in getcwd /build/glibc-6V9RKT/glibc-2.19/io/../sysdeps/unix/sysv/linux/getcwd.c:68
    #7 0x454691 in getcwd /home/vak-local/3.9.1/release/final/llvm.src/projects/compiler-rt/lib/asan/../sanitizer_common/sanitizer_common_interceptors.inc:2822:15
    #8 0x4f765d in doproc /.../ltp/fsstress.c:933:12
    #9 0x4f5f54 in main /.../ltp/fsstress.c:581:5
---
 ltp/fsstress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 24c063e..96f48b1 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -965,7 +965,7 @@ doproc(void)
 		_exit(1);
 	}
 	top_ino = statbuf.st_ino;
-	homedir = getcwd(NULL, -1);
+	homedir = getcwd(NULL, 0);
 	seed += procid;
 	srandom(seed);
 	if (namerand)
-- 
2.1.4

