Received: from mail-pl0-f67.google.com ([209.85.160.67]:33209 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSUwC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Apr 2018 16:52:02 -0400
Received: by mail-pl0-f67.google.com with SMTP id w12-v6so3953049plp.0
        for <fstests@vger.kernel.org>; Thu, 19 Apr 2018 13:52:02 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH 2/2] test-appliance: add 'encrypt' config for f2fs
Date: Thu, 19 Apr 2018 13:50:20 -0700
Message-Id: <20180419205020.16868-2-ebiggers3@gmail.com>
In-Reply-To: <20180419205020.16868-1-ebiggers3@gmail.com>
References: <20180419205020.16868-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Allow testing f2fs using the test_dummy_encryption mount option,
available with f2fs in kernel 4.17 and later.  E.g.,

    gce-xfstests -c f2fs/encrypt -g auto

This is the f2fs equivalent of ext4/encrypt.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .../test-appliance/files/root/fs/f2fs/cfg/all.list   |  1 +
 .../test-appliance/files/root/fs/f2fs/cfg/encrypt    |  5 +++++
 .../test-appliance/files/root/fs/f2fs/config         | 12 ++++++++++++
 3 files changed, 18 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/encrypt

diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list
index 4ad96d5..bc796ff 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/all.list
@@ -1 +1,2 @@
 default
+encrypt
diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/encrypt b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/encrypt
new file mode 100644
index 0000000..0e4e8ab
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/cfg/encrypt
@@ -0,0 +1,5 @@
+SIZE=small
+export MKFS_OPTIONS="-O encrypt"
+export F2FS_MOUNT_OPTIONS="test_dummy_encryption"
+REQUIRE_FEATURE=encryption
+TESTNAME="F2FS encryption"
diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
index 94c402b..3857d5d 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
@@ -33,6 +33,18 @@ function setup_mount_opts()
     if test -n "$MNTOPTS" ; then
 	F2FS_MOUNT_OPTIONS+="${F2FS_MOUNT_OPTIONS:+,}$MNTOPTS"
     fi
+    if echo ",$F2FS_MOUNT_OPTIONS," | grep -q ',test_dummy_encryption,'; then
+	local mode='\x00\x00\x00\x00'
+	local raw="$(printf ""\\\\x%02x"" $(seq 0 63))"
+	if lscpu | grep "Byte Order" | grep -q Little ; then
+	    local size='\x40\x00\x00\x00'
+	else
+	    local size='\x00\x00\x00\x40'
+	fi
+	local key="${mode}${raw}${size}"
+	keyctl new_session >& /dev/null
+	echo -n -e "${key}" | keyctl padd logon fscrypt:4242424242424242 @s >& /dev/null
+    fi
     export F2FS_MOUNT_OPTIONS="${F2FS_MOUNT_OPTIONS:+-o }$F2FS_MOUNT_OPTIONS"
 }
 
-- 
2.17.0.484.g0c8726318c-goog

