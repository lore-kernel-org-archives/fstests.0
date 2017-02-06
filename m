Received: from mail-pg0-f67.google.com ([74.125.83.67]:35497 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdBFVoS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2017 16:44:18 -0500
Received: by mail-pg0-f67.google.com with SMTP id 204so10085019pge.2
        for <fstests@vger.kernel.org>; Mon, 06 Feb 2017 13:44:18 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: format filesystem with '-O encrypt' in encrypt config
Date: Mon,  6 Feb 2017 13:42:34 -0800
Message-Id: <20170206214237.8838-2-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

We were relying on the kernel setting the 'encrypt' feature flag for us.
We should just do it in userspace when formatting the filesystem.  This
will allow us to eventually remove the kernel-side hack to force-set the
'encrypt' flag in the superblock.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt
index 390e205..320eff0 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt
@@ -1,5 +1,5 @@
 SIZE=small
-export MKFS_OPTIONS=""
+export MKFS_OPTIONS="-O encrypt"
 export EXT_MOUNT_OPTIONS="test_dummy_encryption"
 REQUIRE_FEATURE=encryption
 TESTNAME="Ext4 encryption"
-- 
2.11.0.483.g087da7b7c-goog

