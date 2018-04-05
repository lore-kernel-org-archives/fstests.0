Received: from mail-pl0-f66.google.com ([209.85.160.66]:41517 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeDEWVF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Apr 2018 18:21:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id bj1-v6so18850391plb.8
        for <fstests@vger.kernel.org>; Thu, 05 Apr 2018 15:21:04 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] common/config: support f2fs-tools v1.9 and later
Date: Thu,  5 Apr 2018 15:19:01 -0700
Message-Id: <20180405221901.41861-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Pass the -f option to mkfs.f2fs when it appears to support it.  This is
required by f2fs-tools v1.9 and later in order to format the filesystem
even when an existing filesystem is detected.  But earlier versions did
not accept this option.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/config | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/common/config b/common/config
index 20f0e5f3..7c046a78 100644
--- a/common/config
+++ b/common/config
@@ -94,10 +94,11 @@ set_prog_path()
 	type -P $1
 }
 
-# Handle mkfs.btrfs which does (or does not) require -f to overwrite
-set_btrfs_mkfs_prog_path_with_opts()
+# Handle mkfs.$fstyp which does (or does not) require -f to overwrite
+set_mkfs_prog_path_with_opts()
 {
-	p=`set_prog_path mkfs.btrfs`
+	local fstyp=$1
+	local p=`set_prog_path mkfs.$fstyp`
 	if [ "$p" != "" ] && grep -q 'force overwrite' $p; then
 		echo "$p -f"
 	else
@@ -223,8 +224,8 @@ case "$HOSTOS" in
         export MKFS_XFS_PROG="`set_prog_path mkfs.xfs`"
         export MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
         export MKFS_UDF_PROG="`set_prog_path mkudffs`"
-        export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
-        export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
+        export MKFS_BTRFS_PROG="`set_mkfs_prog_path_with_opts btrfs`"
+        export MKFS_F2FS_PROG="`set_mkfs_prog_path_with_opts f2fs`"
         export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
-- 
2.17.0.484.g0c8726318c-goog

