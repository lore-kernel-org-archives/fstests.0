Received: from mail-pf0-f195.google.com ([209.85.192.195]:35676 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdBFVoX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2017 16:44:23 -0500
Received: by mail-pf0-f195.google.com with SMTP id f144so7687657pfa.2
        for <fstests@vger.kernel.org>; Mon, 06 Feb 2017 13:44:23 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: use old key prefix in ext4 encrypt config
Date: Mon,  6 Feb 2017 13:42:35 -0800
Message-Id: <20170206214237.8838-3-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

For the ext4 encrypt config, add the dummy key using the "ext4:" prefix
instead of the "fscrypt:" prefix.  This will allow xfstests-bld to test
any old kernels to which the change to make test_dummy_encryption
require a keyring key may get backported.  (Of course, it also remains
able to test old kernels to which that change has *not* been
backported.)  Using the old / fs-specific key prefix is also consistent
with the xfstests in the "encrypt" group, which use the fs-specific key
prefix to allow the tests to run unmodified on older kernels.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/fs/ext4/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/config b/kvm-xfstests/test-appliance/files/root/fs/ext4/config
index 86840e0..9fde22c 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/config
@@ -46,7 +46,7 @@ function setup_mount_opts()
         fi
         local key="${mode}${raw}${size}"
         keyctl new_session
-        echo -n -e "${key}" | keyctl padd logon fscrypt:4242424242424242 @s
+        echo -n -e "${key}" | keyctl padd logon ext4:4242424242424242 @s
     fi
 }
 
-- 
2.11.0.483.g087da7b7c-goog

