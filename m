Received: from mail-pg0-f68.google.com ([74.125.83.68]:36404 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbdEQXfA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 19:35:00 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so3591150pge.3
        for <fstests@vger.kernel.org>; Wed, 17 May 2017 16:35:00 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 4/5] kernel-configs: enable f2fs support
Date: Wed, 17 May 2017 16:32:32 -0700
Message-Id: <20170517233233.61244-5-ebiggers3@gmail.com>
In-Reply-To: <20170517233233.61244-1-ebiggers3@gmail.com>
References: <20170517233233.61244-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Merged the following into each config:

    CONFIG_F2FS_FS=y
    CONFIG_F2FS_FS_SECURITY=y
    CONFIG_F2FS_FS_ENCRYPTION=y

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kernel-configs/i386-config-3.10   | 1 +
 kernel-configs/i386-config-3.14   | 2 ++
 kernel-configs/i386-config-3.8    | 1 +
 kernel-configs/i386-config-4.1    | 2 ++
 kernel-configs/i386-config-4.7    | 5 +++--
 kernel-configs/x86_64-config-3.10 | 1 +
 kernel-configs/x86_64-config-3.14 | 2 ++
 kernel-configs/x86_64-config-3.18 | 2 ++
 kernel-configs/x86_64-config-4.1  | 2 ++
 kernel-configs/x86_64-config-4.4  | 3 +++
 kernel-configs/x86_64-config-4.7  | 5 +++--
 kernel-configs/x86_64-config-4.9  | 4 +++-
 12 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel-configs/i386-config-3.10 b/kernel-configs/i386-config-3.10
index b919604..f8588db 100644
--- a/kernel-configs/i386-config-3.10
+++ b/kernel-configs/i386-config-3.10
@@ -314,6 +314,7 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_HUGETLBFS=y
 CONFIG_ECRYPT_FS=y
 CONFIG_CRAMFS=y
+CONFIG_F2FS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_NFSD=y
diff --git a/kernel-configs/i386-config-3.14 b/kernel-configs/i386-config-3.14
index 30da52b..ff3fd44 100644
--- a/kernel-configs/i386-config-3.14
+++ b/kernel-configs/i386-config-3.14
@@ -334,6 +334,8 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_HUGETLBFS=y
 CONFIG_ECRYPT_FS=y
 CONFIG_CRAMFS=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
 CONFIG_EFIVAR_FS=m
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
diff --git a/kernel-configs/i386-config-3.8 b/kernel-configs/i386-config-3.8
index d0eed3c..5578d33 100644
--- a/kernel-configs/i386-config-3.8
+++ b/kernel-configs/i386-config-3.8
@@ -291,6 +291,7 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_HUGETLBFS=y
 CONFIG_CRAMFS=y
+CONFIG_F2FS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_NFSD=y
diff --git a/kernel-configs/i386-config-4.1 b/kernel-configs/i386-config-4.1
index 120c4ef..b245303 100644
--- a/kernel-configs/i386-config-4.1
+++ b/kernel-configs/i386-config-4.1
@@ -250,6 +250,8 @@ CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=y
 CONFIG_BTRFS_FS_POSIX_ACL=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
 CONFIG_FS_DAX=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
diff --git a/kernel-configs/i386-config-4.7 b/kernel-configs/i386-config-4.7
index bf31694..9bc0ebe 100644
--- a/kernel-configs/i386-config-4.7
+++ b/kernel-configs/i386-config-4.7
@@ -268,8 +268,10 @@ CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=y
 CONFIG_BTRFS_FS_POSIX_ACL=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
+CONFIG_F2FS_FS_ENCRYPTION=y
 CONFIG_FS_DAX=y
-CONFIG_FS_ENCRYPTION=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_QUOTA_DEBUG=y
@@ -345,7 +347,6 @@ CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_VMAC=y
 CONFIG_CRYPTO_CRC32C_INTEL=y
-CONFIG_CRYPTO_CRC32=y
 CONFIG_CRYPTO_CRC32_PCLMUL=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_RMD160=y
diff --git a/kernel-configs/x86_64-config-3.10 b/kernel-configs/x86_64-config-3.10
index 441acf3..6cfc5c2 100644
--- a/kernel-configs/x86_64-config-3.10
+++ b/kernel-configs/x86_64-config-3.10
@@ -228,6 +228,7 @@ CONFIG_SQUASHFS_XATTR=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_SQUASHFS_XZ=y
 CONFIG_ROMFS_FS=y
+CONFIG_F2FS_FS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
diff --git a/kernel-configs/x86_64-config-3.14 b/kernel-configs/x86_64-config-3.14
index 56d0a42..f356c94 100644
--- a/kernel-configs/x86_64-config-3.14
+++ b/kernel-configs/x86_64-config-3.14
@@ -238,6 +238,8 @@ CONFIG_SQUASHFS_XATTR=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_SQUASHFS_XZ=y
 CONFIG_ROMFS_FS=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
diff --git a/kernel-configs/x86_64-config-3.18 b/kernel-configs/x86_64-config-3.18
index 746c873..bc530c9 100644
--- a/kernel-configs/x86_64-config-3.18
+++ b/kernel-configs/x86_64-config-3.18
@@ -239,6 +239,8 @@ CONFIG_SQUASHFS_XATTR=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_SQUASHFS_XZ=y
 CONFIG_ROMFS_FS=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
diff --git a/kernel-configs/x86_64-config-4.1 b/kernel-configs/x86_64-config-4.1
index ec73222..12db1cc 100644
--- a/kernel-configs/x86_64-config-4.1
+++ b/kernel-configs/x86_64-config-4.1
@@ -216,6 +216,8 @@ CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_XFS_RT=y
 CONFIG_BTRFS_FS=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
 CONFIG_QUOTA=y
diff --git a/kernel-configs/x86_64-config-4.4 b/kernel-configs/x86_64-config-4.4
index bdf4087..efbab94 100644
--- a/kernel-configs/x86_64-config-4.4
+++ b/kernel-configs/x86_64-config-4.4
@@ -225,6 +225,9 @@ CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_XFS_RT=y
 CONFIG_BTRFS_FS=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
+CONFIG_F2FS_FS_ENCRYPTION=y
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
 CONFIG_QUOTA=y
diff --git a/kernel-configs/x86_64-config-4.7 b/kernel-configs/x86_64-config-4.7
index eb4a51f..8752ebf 100644
--- a/kernel-configs/x86_64-config-4.7
+++ b/kernel-configs/x86_64-config-4.7
@@ -225,8 +225,10 @@ CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_XFS_RT=y
 CONFIG_BTRFS_FS=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
+CONFIG_F2FS_FS_ENCRYPTION=y
 CONFIG_FS_DAX=y
-CONFIG_FS_ENCRYPTION=y
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
 CONFIG_QUOTA=y
@@ -315,7 +317,6 @@ CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_VMAC=y
 CONFIG_CRYPTO_CRC32C_INTEL=y
-CONFIG_CRYPTO_CRC32=y
 CONFIG_CRYPTO_CRC32_PCLMUL=y
 CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
 CONFIG_CRYPTO_MD4=y
diff --git a/kernel-configs/x86_64-config-4.9 b/kernel-configs/x86_64-config-4.9
index 0937576..5cf43a4 100644
--- a/kernel-configs/x86_64-config-4.9
+++ b/kernel-configs/x86_64-config-4.9
@@ -224,6 +224,9 @@ CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_XFS_RT=y
 CONFIG_BTRFS_FS=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
+CONFIG_F2FS_FS_ENCRYPTION=y
 CONFIG_FS_DAX=y
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
@@ -314,7 +317,6 @@ CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_VMAC=y
 CONFIG_CRYPTO_CRC32C_INTEL=y
-CONFIG_CRYPTO_CRC32=y
 CONFIG_CRYPTO_CRC32_PCLMUL=y
 CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
 CONFIG_CRYPTO_MD4=y
-- 
2.13.0.303.g4ebf302169-goog

