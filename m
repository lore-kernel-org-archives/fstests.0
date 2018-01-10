Received: from mga01.intel.com ([192.55.52.88]:54014 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754356AbeAJIZ7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 10 Jan 2018 03:25:59 -0500
From: Chen Rong <rongx.a.chen@intel.com>
Subject: [PATCH] common: support defrag test on f2fs
Date: Wed, 10 Jan 2018 16:24:50 +0800
Message-Id: <1515572690-11377-1-git-send-email-rongx.a.chen@intel.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chen Rong <rongx.a.chen@intel.com>
List-ID: <fstests@vger.kernel.org>

f2fs-tools has a defragment tool, so we can test generic/324 on f2fs

Signed-off-by: Chen Rong <rongx.a.chen@intel.com>
---
 common/config | 1 +
 common/defrag | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/common/config b/common/config
index d0fbfe5..71cb367 100644
--- a/common/config
+++ b/common/config
@@ -226,6 +226,7 @@ case "$HOSTOS" in
         export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
         export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
         export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
+        export DEFRAG_F2FS_PROG="`set_prog_path defrag.f2fs`"
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
 	export BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
diff --git a/common/defrag b/common/defrag
index d279382..d54b89c 100644
--- a/common/defrag
+++ b/common/defrag
@@ -44,6 +44,9 @@ _require_defrag()
     btrfs)
 	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
 	;;
+    f2fs)
+	DEFRAG_PROG="$DEFRAG_F2FS_PROG"
+	;;
     *)
         _notrun "defragmentation not supported for fstype \"$FSTYP\""
 	;;
-- 
2.7.4

