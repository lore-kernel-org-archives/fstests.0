Received: from mail-wr1-f66.google.com ([209.85.221.66]:40704 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405208AbfITSsz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Sep 2019 14:48:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so7791441wru.7
        for <fstests@vger.kernel.org>; Fri, 20 Sep 2019 11:48:54 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH][xfstests-bld] build-all: fix acl tools build
Date: Fri, 20 Sep 2019 21:48:46 +0300
Message-Id: <20190920184846.18251-1-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On a clean do-all buster image getfacl is dynamically
linked with libacl.so.1, but the built library is not installed.
The installed libacl.so.1 in the image is incompatible with the
version of acl tools that we build:

root@kvm-xfstests:~# getfacl -n -p xfstests/
getfacl: symbol lookup error: getfacl: undefined symbol: walk_tree

Fix this by linking acl tools with the static libacl library.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 build-all | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/build-all b/build-all
index 217ae62..83a1394 100755
--- a/build-all
+++ b/build-all
@@ -233,12 +233,15 @@ fi
 
 if test -z "$SKIP_ACL" ; then
     build_start "ACL library"
+    # Specify NO_SOLIB=1 so that libacl is only built as a static
+    # library.  Then acl tools will be statically linked to it, and we won't
+    # have to install libacl1.so.
     (cd acl; \
      CPPFLAGS="-I$DESTDIR/include" \
      CFLAGS="$LCF -I$DESTDIR/include" \
      LDFLAGS="$LLF $EXEC_LDFLAGS -L$DESTDIR/lib" \
      ./configure $cross --prefix=$DESTDIR --disable-nls; $MAKE_CLEAN ; \
-     make $J LDFLAGS="$LLF $EXEC_LLDFLAGS -static -L$DESTDIR/lib" ; \
+     make $J NO_SOLIB=1 LDFLAGS="$LLF $EXEC_LLDFLAGS -static -L$DESTDIR/lib" ; \
      make $J install)
 fi
 
-- 
2.17.1
