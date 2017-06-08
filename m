Received: from mail-pf0-f196.google.com ([209.85.192.196]:32952 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdFHVry (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Jun 2017 17:47:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so6486745pfe.0
        for <fstests@vger.kernel.org>; Thu, 08 Jun 2017 14:47:49 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 2/2] xfstests-bld: misc: remove encrypt-smoketest
Date: Thu,  8 Jun 2017 14:46:27 -0700
Message-Id: <20170608214627.136906-2-ebiggers3@gmail.com>
In-Reply-To: <20170608214627.136906-1-ebiggers3@gmail.com>
References: <20170608214627.136906-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The encrypt-smoketest script isn't really useful anymore now that
xfstests has an "encrypt" group of tests, which can be run in all
configurations using a command like 'kvm-xfstests -g encrypt'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/Makefile.in       |  3 +--
 misc/encrypt-smoketest | 68 --------------------------------------------------
 2 files changed, 1 insertion(+), 70 deletions(-)
 delete mode 100755 misc/encrypt-smoketest

diff --git a/misc/Makefile.in b/misc/Makefile.in
index c0f2395..ec10377 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -12,8 +12,7 @@ CFLAGS = @CFLAGS@
 LDFLAGS = @LDFLAGS@
 
 PROGS= fname_benchmark postmark resize syncfs
-SCRIPTS= encrypt-fname-benchmark \
-	encrypt-smoketest
+SCRIPTS= encrypt-fname-benchmark
 
 all: $(PROGS)
 
diff --git a/misc/encrypt-smoketest b/misc/encrypt-smoketest
deleted file mode 100755
index e207937..0000000
--- a/misc/encrypt-smoketest
+++ /dev/null
@@ -1,68 +0,0 @@
-#!/bin/sh -vx
-
-. /root/test-config
-
-dmesg -n 7
-mkdir -p /vdc
-
-setup_test_dummy_key ()
-{
-    mode='\x00\x00\x00\x00'
-    raw="$(printf ""\\\\x%02x"" $(seq 0 63))"
-    if lscpu | grep "Byte Order" | grep -q Little ; then
-	size='\x40\x00\x00\x00'
-    else
-	size='\x00\x00\x00\x40'
-    fi
-    key="${mode}${raw}${size}"
-    keyctl new_session
-    echo -n -e "${key}" | keyctl padd logon fscrypt:4242424242424242 @s
-}
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
-do_smoketest ()
-{
-    do_mount
-    rm -rf /vdc/a /vdc/b
-    mkdir /vdc/a /vdc/b
-    echo foobar | e4crypt add_key /vdc/a
-    cp /etc/motd /vdc
-    mv /vdc/motd /vdc/a
-    cp /etc/motd /vdc/a
-    ln -s motd /vdc/a/link
-    cp -r /root/xfstests /vdc/a
-    do_unmount
-    do_mount
-    lsattr /vdc/a
-    ls -l /vdc/a
-    cat /vdc/a/link
-    cat /vdc/a/motd
-    do_unmount
-    keyctl purge logon
-    do_mount
-    lsattr /vdc/a
-    ls -l /vdc/a
-    if test -z "$SKIP_CLEANUP" ; then
-	rm -rf /vdc/a /vdc/b
-    fi
-    do_unmount
-}
-
-if test -z "$SKIP_NO_DIR_INDEX" ; then
-    mke2fs -t ext4 -O encrypt,^dir_index -Fq $VDC
-    do_smoketest
-fi
-
-if test -z "$SKIP_DIR_INDEX" ; then
-    mke2fs -t ext4 -O encrypt -Fq $VDC
-    do_smoketest
-fi
-- 
2.13.0.506.g27d5fe0cd-goog

