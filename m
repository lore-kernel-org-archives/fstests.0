Received: from mail-wr0-f196.google.com ([209.85.128.196]:35497 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdI2KxB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Sep 2017 06:53:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id n64so992004wrb.2
        for <fstests@vger.kernel.org>; Fri, 29 Sep 2017 03:53:01 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] kernel-configs: enable namespace support
Date: Fri, 29 Sep 2017 13:53:37 +0300
Message-Id: <1506682417-8701-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@google.com>, Eryu Guan <eguan@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

At this time there is only one xfstest that requires namespaces
support (overlay/020) and it requires user namespace support.
This test fails with default kvm-xfstests configs.

Recently, a regression with overlayfs was reported relating
to mount ns, so tests that require only mount ns may be needed too.

This change re-enables the kernel default namespace support for all
kernel configurations and enables user ns support for stable kernels
v3.18 and above, where user ns is considered stable and maintained.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 kernel-configs/i386-config-3.10   | 4 ----
 kernel-configs/i386-config-3.14   | 4 ----
 kernel-configs/i386-config-3.18   | 5 +----
 kernel-configs/i386-config-3.2    | 4 ----
 kernel-configs/i386-config-3.4    | 4 ----
 kernel-configs/i386-config-4.1    | 5 +----
 kernel-configs/i386-config-4.4    | 5 +----
 kernel-configs/i386-config-4.9    | 5 +----
 kernel-configs/x86_64-config-3.10 | 4 ----
 kernel-configs/x86_64-config-3.14 | 4 ----
 kernel-configs/x86_64-config-3.18 | 5 +----
 kernel-configs/x86_64-config-3.2  | 4 ----
 kernel-configs/x86_64-config-3.4  | 4 ----
 kernel-configs/x86_64-config-4.1  | 5 +----
 kernel-configs/x86_64-config-4.4  | 5 +----
 kernel-configs/x86_64-config-4.9  | 5 +----
 16 files changed, 8 insertions(+), 64 deletions(-)

diff --git a/kernel-configs/i386-config-3.10 b/kernel-configs/i386-config-3.10
index 20f2e18..0ec01c5 100644
--- a/kernel-configs/i386-config-3.10
+++ b/kernel-configs/i386-config-3.10
@@ -8,10 +8,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/i386-config-3.14 b/kernel-configs/i386-config-3.14
index 1bd5159..7270033 100644
--- a/kernel-configs/i386-config-3.14
+++ b/kernel-configs/i386-config-3.14
@@ -8,10 +8,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/i386-config-3.18 b/kernel-configs/i386-config-3.18
index d31dcab..119ba1b 100644
--- a/kernel-configs/i386-config-3.18
+++ b/kernel-configs/i386-config-3.18
@@ -8,10 +8,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/i386-config-3.2 b/kernel-configs/i386-config-3.2
index f098214..a90b672 100644
--- a/kernel-configs/i386-config-3.2
+++ b/kernel-configs/i386-config-3.2
@@ -6,10 +6,6 @@ CONFIG_FHANDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/i386-config-3.4 b/kernel-configs/i386-config-3.4
index 5703598..54224ce 100644
--- a/kernel-configs/i386-config-3.4
+++ b/kernel-configs/i386-config-3.4
@@ -6,10 +6,6 @@ CONFIG_FHANDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/i386-config-4.1 b/kernel-configs/i386-config-4.1
index 2b65848..88d52d5 100644
--- a/kernel-configs/i386-config-4.1
+++ b/kernel-configs/i386-config-4.1
@@ -8,10 +8,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/i386-config-4.4 b/kernel-configs/i386-config-4.4
index 1f53d44..62854a7 100644
--- a/kernel-configs/i386-config-4.4
+++ b/kernel-configs/i386-config-4.4
@@ -8,10 +8,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/i386-config-4.9 b/kernel-configs/i386-config-4.9
index 7c8b764..bb26945 100644
--- a/kernel-configs/i386-config-4.9
+++ b/kernel-configs/i386-config-4.9
@@ -7,10 +7,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/x86_64-config-3.10 b/kernel-configs/x86_64-config-3.10
index cf8216a..a763eed 100644
--- a/kernel-configs/x86_64-config-3.10
+++ b/kernel-configs/x86_64-config-3.10
@@ -7,10 +7,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/x86_64-config-3.14 b/kernel-configs/x86_64-config-3.14
index 3a40b3d..a276318 100644
--- a/kernel-configs/x86_64-config-3.14
+++ b/kernel-configs/x86_64-config-3.14
@@ -7,10 +7,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/x86_64-config-3.18 b/kernel-configs/x86_64-config-3.18
index 0eaf2cd..6a8afc8 100644
--- a/kernel-configs/x86_64-config-3.18
+++ b/kernel-configs/x86_64-config-3.18
@@ -7,10 +7,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/x86_64-config-3.2 b/kernel-configs/x86_64-config-3.2
index b92cbcc..64ee6a4 100644
--- a/kernel-configs/x86_64-config-3.2
+++ b/kernel-configs/x86_64-config-3.2
@@ -6,10 +6,6 @@ CONFIG_FHANDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/x86_64-config-3.4 b/kernel-configs/x86_64-config-3.4
index dcf2008..1a24556 100644
--- a/kernel-configs/x86_64-config-3.4
+++ b/kernel-configs/x86_64-config-3.4
@@ -6,10 +6,6 @@ CONFIG_FHANDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/x86_64-config-4.1 b/kernel-configs/x86_64-config-4.1
index 961cf66..c8610d4 100644
--- a/kernel-configs/x86_64-config-4.1
+++ b/kernel-configs/x86_64-config-4.1
@@ -7,10 +7,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/x86_64-config-4.4 b/kernel-configs/x86_64-config-4.4
index 65d925e..7dfb7b4 100644
--- a/kernel-configs/x86_64-config-4.4
+++ b/kernel-configs/x86_64-config-4.4
@@ -7,10 +7,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/kernel-configs/x86_64-config-4.9 b/kernel-configs/x86_64-config-4.9
index 66348a3..16e54bc 100644
--- a/kernel-configs/x86_64-config-4.9
+++ b/kernel-configs/x86_64-config-4.9
@@ -6,10 +6,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-- 
2.7.4

