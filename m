Received: from mail-pf0-f195.google.com ([209.85.192.195]:34320 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033442AbdEYT1H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2017 15:27:07 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so41051685pfk.1
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 12:27:07 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 6/7] Makefile: check whether xfsprogs-dev exists before cleaning it
Date: Thu, 25 May 2017 12:25:48 -0700
Message-Id: <20170525192549.138518-7-ebiggers3@gmail.com>
In-Reply-To: <20170525192549.138518-1-ebiggers3@gmail.com>
References: <20170525192549.138518-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

If running 'make clean' (or do-all) before the repositories have been
cloned, don't try to clean a nonexistent xfsprogs-dev directory.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6be3752..ced32b2 100644
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@ clean:
 	do \
 		if test -f $$i/Makefile ; then make -C $$i clean ; fi ; \
 	done
-	make -C xfsprogs-dev realclean
+	if test -d xfsprogs-dev; then make -C xfsprogs-dev realclean; fi
 	rm -rf bld xfstests
 	rm -f kvm-xfstests/util/zerofree $(SCRIPTS)
 
-- 
2.13.0.219.gdb65acc882-goog

