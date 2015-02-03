Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56520 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754321AbbBCXHx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 3 Feb 2015 18:07:53 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/8 v4] common/rc:  define dump.f2fs and logstate for f2fs
Date: Tue,  3 Feb 2015 15:07:18 -0800
Message-Id: <1423004840-45315-7-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch defines dump.f2fs and logstate for f2fs's clean and dirty logs.
And, also it adds _link_out_file_fs to specify output according to filesystem.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/config |  1 +
 common/log    | 20 +++++++++++++++++---
 common/rc     | 22 ++++++++++++++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/common/config b/common/config
index 9fb3703..cdc2214 100644
--- a/common/config
+++ b/common/config
@@ -221,6 +221,7 @@ case "$HOSTOS" in
         export MKFS_UDF_PROG="`set_prog_path mkudffs`"
         export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
         export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
+        export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
         export BMAP_F2FS_PROG="`set_prog_path fibmap.f2fs`"
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
diff --git a/common/log b/common/log
index 87074d9..186eb4c 100644
--- a/common/log
+++ b/common/log
@@ -218,11 +218,25 @@ _check_log()
 
 _print_logstate()
 {
-    _scratch_xfs_logprint -t | tee -a $seqres.full >$tmp.logprint
-    if grep -q "<DIRTY>" $tmp.logprint; then
+    case "$FSTYP" in
+        xfs)
+            _scratch_xfs_logprint -t | tee -a $seqres.full >$tmp.logprint
+            DIRTY="<DIRTY>"
+            CLEAN="<CLEAN>"
+            ;;
+        f2fs)
+            _scratch_f2fs_logprint | tee -a $seqres.full >$tmp.logprint
+            DIRTY="sudden-power-off"
+            CLEAN="unmount"
+            ;;
+        *)
+            ;;
+    esac
+
+    if grep -q $DIRTY $tmp.logprint; then
 	echo "dirty log"
     fi
-    if grep -q "<CLEAN>" $tmp.logprint; then
+    if grep -q $CLEAN $tmp.logprint; then
 	echo "clean log"
     fi
 }
diff --git a/common/rc b/common/rc
index 72e2f99..04b05eb 100644
--- a/common/rc
+++ b/common/rc
@@ -770,6 +770,11 @@ _scratch_xfs_repair()
     $XFS_REPAIR_PROG $SCRATCH_OPTIONS $* $SCRATCH_DEV
 }
 
+_scratch_f2fs_logprint()
+{
+    $DUMP_F2FS_PROG $SCRATCH_DEV
+}
+
 _get_pids_by_name()
 {
     if [ $# -ne 1 ]
@@ -2091,6 +2096,16 @@ _link_out_file()
 	fi
 }
 
+_link_out_file_fs()
+{
+	if [ -z "$1" -o -z "$2" ]; then
+		echo Error must pass src and dst.
+		exit
+	fi
+	rm -f $2
+	ln -s $1.$FSTYP $2
+}
+
 _die()
 {
         echo $@
@@ -2435,6 +2450,13 @@ _require_dumpe2fs()
 	fi
 }
 
+_require_dumpf2fs()
+{
+	if [ -z "$DUMP_F2FS_PROG" ]; then
+		_notrun "This test requires dump.f2fs utility."
+	fi
+}
+
 _require_ugid_map()
 {
 	if [ ! -e /proc/self/uid_map ]; then
-- 
2.1.1

