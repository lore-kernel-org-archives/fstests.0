Received: from mail-pl0-f68.google.com ([209.85.160.68]:35192 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSUwA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Apr 2018 16:52:00 -0400
Received: by mail-pl0-f68.google.com with SMTP id w21-v6so3941846plq.2
        for <fstests@vger.kernel.org>; Thu, 19 Apr 2018 13:52:00 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH 1/2] test-appliance: fix specifying f2fs mount options in config file
Date: Thu, 19 Apr 2018 13:50:19 -0700
Message-Id: <20180419205020.16868-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

setup_mount_opts() is supposed to prepend "-o " to the mount options,
but it failed to do so in the case where mount options are specified in
a config file rather than on the command line.  Fix it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/fs/f2fs/config | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
index b0c2196..94c402b 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
@@ -31,12 +31,9 @@ function format_filesystem()
 function setup_mount_opts()
 {
     if test -n "$MNTOPTS" ; then
-	if test -n "$F2FS_MOUNT_OPTIONS" ; then
-	    export F2FS_MOUNT_OPTIONS="$F2FS_MOUNT_OPTIONS,$MNTOPTS"
-	else
-	    export F2FS_MOUNT_OPTIONS="-o $MNTOPTS"
-	fi
+	F2FS_MOUNT_OPTIONS+="${F2FS_MOUNT_OPTIONS:+,}$MNTOPTS"
     fi
+    export F2FS_MOUNT_OPTIONS="${F2FS_MOUNT_OPTIONS:+-o }$F2FS_MOUNT_OPTIONS"
 }
 
 function get_mkfs_opts()
-- 
2.17.0.484.g0c8726318c-goog

