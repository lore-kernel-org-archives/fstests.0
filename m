Received: from mail-pg0-f66.google.com ([74.125.83.66]:33125 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933234AbdBVTbe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Feb 2017 14:31:34 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so1635383pgj.0
        for <fstests@vger.kernel.org>; Wed, 22 Feb 2017 11:31:33 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: fix setting mkfs options for ext4
Date: Wed, 22 Feb 2017 11:30:13 -0800
Message-Id: <20170222193013.116510-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Commit ebbfbefce909 ("test-appliance: add support for xfstests to use
EXT_MKFS_OPTIONS") changed the test appliances to set both MKFS_OPTIONS
and EXT_MKFS_OPTIONS when starting 'check'.  However, MKFS_OPTIONS was
not exported into the environment, so it was not actually being
recognized.  Fix this by exporting it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/fs/ext4/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/config b/kvm-xfstests/test-appliance/files/root/fs/ext4/config
index 0dfedf6..cbfbeec 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/config
@@ -28,7 +28,7 @@ function format_filesystem()
 
 function setup_mount_opts()
 {
-    MKFS_OPTIONS="$EXT_MKFS_OPTIONS"
+    export MKFS_OPTIONS="$EXT_MKFS_OPTIONS"
     if test -n "$EXT_MOUNT_OPTIONS" ; then
 	EXT_MOUNT_OPTIONS="-o block_validity,$EXT_MOUNT_OPTIONS"
     else
-- 
2.11.0.483.g087da7b7c-goog

