Received: from mail-pg0-f65.google.com ([74.125.83.65]:36257 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdFHVro (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Jun 2017 17:47:44 -0400
Received: by mail-pg0-f65.google.com with SMTP id v18so5791596pgb.3
        for <fstests@vger.kernel.org>; Thu, 08 Jun 2017 14:47:43 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 1/2] xfstests-bld: misc: remove encrypt-test-revalidate
Date: Thu,  8 Jun 2017 14:46:26 -0700
Message-Id: <20170608214627.136906-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The encrypt-test-revalidate script isn't useful anymore because what it
did is now covered by xfstest generic/429.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/Makefile.in             |  3 +--
 misc/encrypt-test-revalidate | 47 --------------------------------------------
 2 files changed, 1 insertion(+), 49 deletions(-)
 delete mode 100755 misc/encrypt-test-revalidate

diff --git a/misc/Makefile.in b/misc/Makefile.in
index a71bd6d..c0f2395 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -13,8 +13,7 @@ LDFLAGS = @LDFLAGS@
 
 PROGS= fname_benchmark postmark resize syncfs
 SCRIPTS= encrypt-fname-benchmark \
-	encrypt-smoketest \
-	encrypt-test-revalidate
+	encrypt-smoketest
 
 all: $(PROGS)
 
diff --git a/misc/encrypt-test-revalidate b/misc/encrypt-test-revalidate
deleted file mode 100755
index 2a4e763..0000000
--- a/misc/encrypt-test-revalidate
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/sh -vx
-. /root/test-config
-
-dmesg -n 7
-mkdir -p /vdc
-
-do_mount ()
-{
-    mount -t ext4 $VDC /vdc
-}
-
-do_unmount ()
-{
-    umount /vdc
-}
-
-mke2fs -t ext4 -O encrypt,^metadata_csum -Fq $VDC
-do_mount
-mkdir /vdc/a /vdc/b
-echo foobar | e4crypt add_key /vdc/a
-cp /etc/motd /vdc/a
-ln -s motd /vdc/a/link
-cp -r /root/xfstests /vdc/a
-do_unmount
-do_mount
-ls -l /vdc/a
-cat /vdc/a/link
-cat /vdc/a/motd
-keys=$(keyctl show | grep ext4 | awk '{print $1}')
-echo $keys | xargs -n 1 keyctl invalidate
-f=$(find /vdc/a -maxdepth 1 -type f)
-ls -l /vdc/a/NOEXIST
-ls -l /vdc/a/xfstests/README
-ls -l /vdc/a
-ls -l $f
-echo foobar | e4crypt add_key
-ls -l /vdc/a/NOEXIST
-ls -l /vdc/a/xfstests/README
-ls -l $f
-ls -l /vdc/a
-keys=$(keyctl show | grep ext4 | awk '{print $1}')
-echo $keys | xargs -n 1 keyctl invalidate
-ls -l /vdc/a/NOEXIST
-ls -l /vdc/a/xfstests/README
-ls -l $f
-ls -l /vdc/a
-do_unmount
-- 
2.13.0.506.g27d5fe0cd-goog

