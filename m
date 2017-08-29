Received: from mail-lf0-f68.google.com ([209.85.215.68]:38060 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753634AbdH2NhW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Aug 2017 09:37:22 -0400
Received: by mail-lf0-f68.google.com with SMTP id z12so679971lfd.5
        for <fstests@vger.kernel.org>; Tue, 29 Aug 2017 06:37:22 -0700 (PDT)
From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 2/3] fsx: Fix -Wformat-security warnings
Date: Tue, 29 Aug 2017 16:37:14 +0300
Message-Id: <20170829133715.12275-2-tuomas.tynkkynen@iki.fi>
In-Reply-To: <20170829133715.12275-1-tuomas.tynkkynen@iki.fi>
References: <20170829133715.12275-1-tuomas.tynkkynen@iki.fi>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
List-ID: <fstests@vger.kernel.org>

Some distros (NixOS) have their build environment enable
-Werror=format-security by default for security/hardening reasons.
Currently fsx fails to build due to this:

fsx.c: In function 'prt':
fsx.c:215:18: error: format not a string literal and no format arguments [-Werror=format-security]
  fprintf(stdout, buffer);
                  ^
fsx.c:217:20: error: format not a string literal and no format arguments [-Werror=format-security]
   fprintf(fsxlogf, buffer);
                    ^
Indeed the compiler is correct here, if the message-to-be-printed were
to contain a '%', unpredictable things would happen. Fix this.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 ltp/fsx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 3713bbe3..fba2b4d8 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -212,9 +212,9 @@ prt(const char *fmt, ...)
 	va_start(args, fmt);
 	vsnprintf(buffer, BUF_SIZE, fmt, args);
 	va_end(args);
-	fprintf(stdout, buffer);
+	fprintf(stdout, "%s", buffer);
 	if (fsxlogf)
-		fprintf(fsxlogf, buffer);
+		fprintf(fsxlogf, "%s", buffer);
 }
 
 void
-- 
2.13.0

