Received: from mail-pf0-f195.google.com ([209.85.192.195]:38410 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdHaUQG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Aug 2017 16:16:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id r187so381859pfr.5
        for <fstests@vger.kernel.org>; Thu, 31 Aug 2017 13:16:06 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH] setup-buildchroot: fix finding files in chroot.d
Date: Thu, 31 Aug 2017 13:15:40 -0700
Message-Id: <20170831201540.32597-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

get_schroot_config() sometimes didn't find the files in
/etc/schroot/chroot.d/ because there was a typo in the regex: it used
[0-09] instead of [0-9].  Fix it, and also cat schroot.conf first so
that it doesn't get printed multiple times by the xargs command.

We also don't need to check whether schroot.conf exists, since it was
already checked in check_prerequisites(), and the 'cat' command would
fail anyway if it didn't exist.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 setup-buildchroot | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/setup-buildchroot b/setup-buildchroot
index a556894..2340eb5 100755
--- a/setup-buildchroot
+++ b/setup-buildchroot
@@ -361,21 +361,14 @@ validate_binfmt_misc()
 # the chroot.d directory
 get_schroot_config()
 {
-    local files
-
-    if test ! -f $SCHROOT_CONFFILE
-    then
-	die $SCHROOT_CONFFILE does not exist
-    fi
+    cat $SCHROOT_CONFFILE
 
     if test -d $SCHROOT_CHROOT_D
     then
 	(cd $SCHROOT_CHROOT_D ;
 	 find . -maxdepth 1 -type f |
-	     egrep '^./[a-ZA-Z0-09_-][a-ZA-Z0-09_.-]*$' |
-	     xargs cat $SCHROOT_CONFFILE)
-    else
-	cat $SCHROOT_CONFFILE
+	     egrep '^./[a-ZA-Z0-9_-][a-ZA-Z0-9_.-]*$' |
+	     xargs cat)
     fi
 }
 
-- 
2.14.1.581.gf28d330327-goog

