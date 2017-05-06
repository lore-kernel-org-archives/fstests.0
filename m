Received: from mail-pf0-f196.google.com ([209.85.192.196]:33342 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdEFAVP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 May 2017 20:21:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id b23so2406979pfc.0
        for <fstests@vger.kernel.org>; Fri, 05 May 2017 17:21:15 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 1/2] common/config: make set_prog_path() accept one argument only
Date: Fri,  5 May 2017 17:19:32 -0700
Message-Id: <20170506001933.49582-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

All callers of set_prog_path() pass it only one argument, the program to
find on the $PATH.  Therefore, to simplify things remove the unused code
which allowed fallback paths to be specified in the remaining arguments.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/config | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/common/config b/common/config
index 59041a39..b29c0eb0 100644
--- a/common/config
+++ b/common/config
@@ -93,7 +93,7 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
 
 export RECREATE_TEST_DEV=false
 
-# $1 = prog to look for, $2* = default pathnames if not found in $PATH
+# $1 = prog to look for
 set_prog_path()
 {
     p=`which $1 2> /dev/null`
@@ -101,17 +101,6 @@ set_prog_path()
         echo $p
         return 0
     fi
-    p=$1
-
-    shift
-    for f; do
-        if [ -x $f ]; then
-            echo $f
-            return 0
-        fi
-    done
-
-    echo ""
     return 1
 }
 
-- 
2.13.0.rc1.294.g07d810a77f-goog

