Received: from mail-pg0-f68.google.com ([74.125.83.68]:37216 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbdIHX6r (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Sep 2017 19:58:47 -0400
Received: by mail-pg0-f68.google.com with SMTP id v5so1926266pgn.4
        for <fstests@vger.kernel.org>; Fri, 08 Sep 2017 16:58:47 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH] gen-image: create /etc/mtab symlink
Date: Fri,  8 Sep 2017 16:58:29 -0700
Message-Id: <20170908235829.67348-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Currently the root_fs's are being created with no /etc/mtab file.
/etc/mtab is supposed to be obsolete, but some programs such as mke2fs
still expect it to exist.  On Debian systems, systemd will automatically
symlink /etc/mtab to ../proc/self/mounts as specified by
/usr/lib/tmpfiles.d/debian.conf.  But if the root_fs is used as a chroot
(as android-xfstests does), that does not happen, and as of Debian
Stretch the 'mount' program from util-linux doesn't create /etc/mtab
either.  So until nothing else needs it, just make an /etc/mtab symlink
while creating the root_fs.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/gen-image | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kvm-xfstests/test-appliance/gen-image b/kvm-xfstests/test-appliance/gen-image
index 48cf624..8343294 100755
--- a/kvm-xfstests/test-appliance/gen-image
+++ b/kvm-xfstests/test-appliance/gen-image
@@ -289,6 +289,7 @@ echo "fsgqa:!::" >> $ROOTDIR/etc/gshadow
 mkdir $ROOTDIR/home/fsgqa
 chown 31415:31415 $ROOTDIR/home/fsgqa
 chmod 755 $ROOTDIR/root
+ln -sf ../proc/self/mounts $ROOTDIR/etc/mtab
 fix_symlinks
 
 cp $ROOTDIR/lib/systemd/system/serial-getty@.service \
-- 
2.14.1.581.gf28d330327-goog

