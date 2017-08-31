Received: from mail-pf0-f193.google.com ([209.85.192.193]:38298 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdHaUPa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Aug 2017 16:15:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id r187so381017pfr.5
        for <fstests@vger.kernel.org>; Thu, 31 Aug 2017 13:15:30 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH] setup-buildchroot: fix copying passwd and group entries
Date: Thu, 31 Aug 2017 13:14:50 -0700
Message-Id: <20170831201450.32463-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

create_chroot() is now supposed to add $CHROOT_USER to /etc/passwd in
the chroot.  However, due to a bad grep pattern, it would add multiple
entries if $CHROOT_USER happened to be a suffix of another username.
Also the passwd record is not guaranteed to actually be in the file
/etc/passwd.  Fix it by using 'getent passwd $CHROOT_USER' instead.

A similar problem existed for the group entry, but also the
$CHROOT_USER's primary group is not guaranteed to have the same name as
the user.  Fix that by using 'id -g' to look up the primary group.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 setup-buildchroot | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup-buildchroot b/setup-buildchroot
index 2340eb5..992a87c 100755
--- a/setup-buildchroot
+++ b/setup-buildchroot
@@ -524,8 +524,8 @@ EOF
 	chmod 1777 "$CHROOT_DIR/run/shm"
     fi
     if [ -n "$CHROOT_USER" ]; then
-	grep "$CHROOT_USER": /etc/passwd >> "$CHROOT_DIR/etc/passwd"
-	grep "$CHROOT_USER": /etc/group >> "$CHROOT_DIR/etc/group"
+	getent passwd "$CHROOT_USER" >> "$CHROOT_DIR/etc/passwd"
+	getent group "$(id -g "$CHROOT_USER")" >> "$CHROOT_DIR/etc/group"
 	run_in_chroot "adduser $CHROOT_USER sudo"
     fi
 }
-- 
2.14.1.581.gf28d330327-goog

