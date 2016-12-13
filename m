Received: from mail-pf0-f194.google.com ([209.85.192.194]:33959 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbcLMHAw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2016 02:00:52 -0500
Received: by mail-pf0-f194.google.com with SMTP id y68so5556156pfb.1
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2016 23:00:52 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: format filesystem with '-O encrypt' in encrypt config
Date: Mon, 12 Dec 2016 22:59:41 -0800
Message-Id: <1481612381-65741-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y . Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

We were relying on the kernel setting the 'encrypt' feature flag for us.
We should just do it in userspace when formatting the filesystem.

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
2.8.0.rc3.226.g39d4020

