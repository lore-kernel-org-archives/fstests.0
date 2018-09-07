Received: from mail.kernel.org ([198.145.29.99]:57302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeIGFkw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Sep 2018 01:40:52 -0400
From: Eric Biggers <ebiggers@kernel.org>
Subject: [xfstests-bld PATCH] kernel-configs: fix i386 configs
Date: Thu,  6 Sep 2018 18:01:18 -0700
Message-Id: <20180907010118.234124-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Commit 452331adc6c0 ("kernel-configs: enable virtio_9P and 9P_FS")
removed the explicit unsetting of CONFIG_64BIT from some of the i386
kconfigs.  So, they actually became x86_64.  Fix it by syncing them back
up with the x86_64 configs.  I also added the script I used to do this.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kernel-configs/i386-config-3.18     |  1 +
 kernel-configs/i386-config-4.1      |  5 +---
 kernel-configs/i386-config-4.14     |  3 +--
 kernel-configs/i386-config-4.4      |  4 +--
 kernel-configs/i386-config-4.9      |  3 +--
 kernel-configs/sync_i386_configs.sh | 38 +++++++++++++++++++++++++++++
 6 files changed, 43 insertions(+), 11 deletions(-)
 create mode 100755 kernel-configs/sync_i386_configs.sh

diff --git a/kernel-configs/i386-config-3.18 b/kernel-configs/i386-config-3.18
index 19eeff1..2dba879 100644
--- a/kernel-configs/i386-config-3.18
+++ b/kernel-configs/i386-config-3.18
@@ -1,3 +1,4 @@
+# CONFIG_64BIT is not set
 CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
diff --git a/kernel-configs/i386-config-4.1 b/kernel-configs/i386-config-4.1
index 2f3c689..0cad730 100644
--- a/kernel-configs/i386-config-4.1
+++ b/kernel-configs/i386-config-4.1
@@ -1,3 +1,4 @@
+# CONFIG_64BIT is not set
 CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -10,7 +11,6 @@ CONFIG_CGROUPS=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
 CONFIG_JUMP_LABEL=y
 CONFIG_SMP=y
 # CONFIG_X86_EXTENDED_PLATFORM is not set
@@ -43,7 +43,6 @@ CONFIG_INET_UDP_DIAG=y
 CONFIG_NETLINK_DIAG=y
 # CONFIG_WIRELESS is not set
 CONFIG_NET_9P=y
-CONFIG_NET_9P_VIRTIO=y
 CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK2MTD=y
@@ -133,8 +132,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_DEBUG_OBJECTS=y
-CONFIG_DEBUG_SLAB=y
-CONFIG_DEBUG_SLAB_LEAK=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3000
 CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
diff --git a/kernel-configs/i386-config-4.14 b/kernel-configs/i386-config-4.14
index 2deade0..ecb9cf6 100644
--- a/kernel-configs/i386-config-4.14
+++ b/kernel-configs/i386-config-4.14
@@ -1,3 +1,4 @@
+# CONFIG_64BIT is not set
 CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -138,8 +139,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_DEBUG_OBJECTS=y
-CONFIG_DEBUG_SLAB=y
-CONFIG_DEBUG_SLAB_LEAK=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3000
 CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
diff --git a/kernel-configs/i386-config-4.4 b/kernel-configs/i386-config-4.4
index b21615a..38ede35 100644
--- a/kernel-configs/i386-config-4.4
+++ b/kernel-configs/i386-config-4.4
@@ -1,3 +1,4 @@
+# CONFIG_64BIT is not set
 CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -10,7 +11,6 @@ CONFIG_CGROUPS=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
 CONFIG_JUMP_LABEL=y
 CONFIG_SMP=y
 # CONFIG_X86_EXTENDED_PLATFORM is not set
@@ -138,8 +138,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_DEBUG_OBJECTS=y
-CONFIG_DEBUG_SLAB=y
-CONFIG_DEBUG_SLAB_LEAK=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3000
 CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
diff --git a/kernel-configs/i386-config-4.9 b/kernel-configs/i386-config-4.9
index 324b6e6..f235cea 100644
--- a/kernel-configs/i386-config-4.9
+++ b/kernel-configs/i386-config-4.9
@@ -1,3 +1,4 @@
+# CONFIG_64BIT is not set
 CONFIG_LOCALVERSION="-xfstests"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -138,8 +139,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_DEBUG_OBJECTS=y
-CONFIG_DEBUG_SLAB=y
-CONFIG_DEBUG_SLAB_LEAK=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3000
 CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
diff --git a/kernel-configs/sync_i386_configs.sh b/kernel-configs/sync_i386_configs.sh
new file mode 100755
index 0000000..2d75d64
--- /dev/null
+++ b/kernel-configs/sync_i386_configs.sh
@@ -0,0 +1,38 @@
+#!/bin/bash
+
+# Generate the i386 configs from the x86_64 ones.
+
+set -e -u
+
+KCONFIGS_DIR=$(realpath "$(dirname "$0")")
+: "${LINUX_DIR:=$HOME/linux}"
+
+version_at_least()
+{
+    local cur_ver=$1
+    local want_ver=$2
+    [ "$(echo -e "$cur_ver\n$want_ver" | sort -V | head -n1)" = "$want_ver" ]
+}
+
+cd "$KCONFIGS_DIR"
+versions=$(echo x86_64-config-* | sed 's/x86_64-config-//g')
+
+cd "$LINUX_DIR"
+for vers in $versions; do
+    git checkout "stable/linux-$vers.y"
+    if version_at_least "$vers" 3.9; then
+	unset ARCH
+	echo '# CONFIG_64BIT is not set' > .config
+    else
+	export ARCH=i386
+	echo > .config
+    fi
+    cat "$KCONFIGS_DIR/x86_64-config-$vers" >> .config
+    if version_at_least "$vers" 3.7; then
+	make olddefconfig
+    else
+	make oldnoconfig
+    fi
+    make savedefconfig
+    cp -v defconfig "$KCONFIGS_DIR/i386-config-$vers"
+done
-- 
2.19.0.rc2.392.g5ba43deb5a-goog
