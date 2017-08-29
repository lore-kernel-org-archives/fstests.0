Received: from mail-lf0-f68.google.com ([209.85.215.68]:33278 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753662AbdH2NhX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Aug 2017 09:37:23 -0400
Received: by mail-lf0-f68.google.com with SMTP id y15so2162328lfd.0
        for <fstests@vger.kernel.org>; Tue, 29 Aug 2017 06:37:23 -0700 (PDT)
From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 3/3] stat_test, fssum: Include <sys/sysmacros.h> to avoid glibc warning
Date: Tue, 29 Aug 2017 16:37:15 +0300
Message-Id: <20170829133715.12275-3-tuomas.tynkkynen@iki.fi>
In-Reply-To: <20170829133715.12275-1-tuomas.tynkkynen@iki.fi>
References: <20170829133715.12275-1-tuomas.tynkkynen@iki.fi>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
List-ID: <fstests@vger.kernel.org>

Compiling against a recent glibc gives a number of warnings of this
sort:

stat_test.c: In function 'cmp_statx':
stat_test.c:251:13: warning: In the GNU C Library, "major" is defined
 by <sys/sysmacros.h>. For historical compatibility, it is
 currently defined by <sys/types.h> as well, but we plan to
 remove this soon. To use "major", include <sys/sysmacros.h>
 directly. If you did not intend to use a system-defined macro
 "major", you should undefine it after including <sys/types.h>.
  devcmp(dev);

Do as the message says to avoid it. xfstests already includes
<sys/sysmacros.h> in two other places so it seems safe to assume this
header generally exists.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 src/fssum.c     | 1 +
 src/stat_test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/src/fssum.c b/src/fssum.c
index 04052cdc..fa763d19 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -29,6 +29,7 @@
 #include <fcntl.h>
 #include <dirent.h>
 #include <errno.h>
+#include <sys/sysmacros.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
diff --git a/src/stat_test.c b/src/stat_test.c
index 198c1332..ba1650f2 100644
--- a/src/stat_test.c
+++ b/src/stat_test.c
@@ -17,6 +17,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <sys/sysmacros.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
-- 
2.13.0

