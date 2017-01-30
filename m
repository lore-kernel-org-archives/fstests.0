Received: from mail-pf0-f193.google.com ([209.85.192.193]:33151 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754380AbdA3VhB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2017 16:37:01 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so24191211pfg.0
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2017 13:37:01 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2] xfstests-bld: populate keyring with default key for test_dummy_encryption
Date: Mon, 30 Jan 2017 13:36:47 -0800
Message-Id: <20170130213647.14843-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

We can improve test coverage and simplify the test_dummy_encryption
kernel logic by requiring userspace to add a default master key to the
keyring.  Update xfstests-bld to do this.  This allows xfstests-bld to
test kernels with the corresponding kernel patch applied ("fscrypt: make
test_dummy_encryption require a keyring key").  It can still test older
kernels too; the key just doesn't get used in that case.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/fs/ext4/config | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/config b/kvm-xfstests/test-appliance/files/root/fs/ext4/config
index 66d2633..23e869c 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/config
@@ -36,6 +36,19 @@ function setup_mount_opts()
     if test -n "$MNTOPTS" ; then
 	EXT_MOUNT_OPTIONS="$EXT_MOUNT_OPTIONS,$MNTOPTS"
     fi
+    if echo "$EXT_MOUNT_OPTIONS" | grep -q test_dummy_encryption; then
+	# Create a new session keyring and add a default master key to it.
+	keyctl new_session > /dev/null
+	local mode='\x00\x00\x00\x00'
+	local raw="$(printf '\\x%02x' $(seq 0 63))"
+	if lscpu | grep -q '^Byte Order:[[:space:]]\+Little Endian$'; then
+	    local size='\x40\x00\x00\x00'
+	else
+	    local size='\x00\x00\x00\x40'
+	fi
+	echo -n -e "${mode}${raw}${size}" | \
+		keyctl padd logon ext4:4242424242424242 @s > /dev/null
+    fi
 }
 
 function get_mkfs_opts()
-- 
2.11.0.483.g087da7b7c-goog

