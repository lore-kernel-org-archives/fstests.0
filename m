Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52928 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbbBFGho (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:44 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/9 v5] common/log: define _require_logstate
Date: Thu,  5 Feb 2015 22:37:09 -0800
Message-Id: <1423204633-66673-6-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch defines logstate by adding dump.f2fs for f2fs's clean and dirty logs.
This macro is added into:

  xfs/085
  xfs/086
  xfs/087

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/config |  1 +
 common/log    | 51 +++++++++++++++++++++++++++++++++++++++++++++------
 tests/xfs/085 |  1 +
 tests/xfs/086 |  1 +
 tests/xfs/087 |  1 +
 5 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/common/config b/common/config
index 235f4a1..e5c3579 100644
--- a/common/config
+++ b/common/config
@@ -220,6 +220,7 @@ case "$HOSTOS" in
         export MKFS_UDF_PROG="`set_prog_path mkudffs`"
         export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
         export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
+        export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
         export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
diff --git a/common/log b/common/log
index 87074d9..d8b18f8 100644
--- a/common/log
+++ b/common/log
@@ -216,14 +216,35 @@ _check_log()
         | head | grep -q "<CLEAN>" || _fail "DIRTY LOG"
 }
 
+_scratch_xfs_logstate()
+{
+    _scratch_xfs_logprint -t | tee -a $seqres.full | grep -q "<CLEAN>"
+    echo $?
+}
+
+_scratch_f2fs_logstate()
+{
+    $DUMP_F2FS_PROG $SCRATCH_DEV | tee -a $seqres.full | grep -q "unmount"
+    echo $?
+}
+
 _print_logstate()
 {
-    _scratch_xfs_logprint -t | tee -a $seqres.full >$tmp.logprint
-    if grep -q "<DIRTY>" $tmp.logprint; then
-	echo "dirty log"
-    fi
-    if grep -q "<CLEAN>" $tmp.logprint; then
-	echo "clean log"
+    case "$FSTYP" in
+    xfs)
+        dirty=$(_scratch_xfs_logstate)
+        ;;
+    f2fs)
+        dirty=$(_scratch_f2fs_logstate)
+        ;;
+    *)
+        ;;
+    esac
+
+    if [ $dirty -ne 0 ]; then
+        echo "dirty log"
+    else
+        echo "clean log"
     fi
 }
 
@@ -470,6 +491,24 @@ _require_v2log()
     # otherwise presume it does support v2 logs...:)
 }
 
+_require_logstate()
+{
+    case "$FSTYP" in
+    xfs)
+        if [ -z "$XFS_LOGPRINT_PROG" ]; then
+            _notrun "This test requires xfs_logprint utility."
+        fi
+        ;;
+    f2fs)
+        if [ -z "$DUMP_F2FS_PROG" ]; then
+            _notrun "This test requires dump.f2fs utility."
+        fi
+        ;;
+    *)
+        _notrun "$FSTYP does not support log state probing."
+        ;;
+    esac
+}
 
 # make sure this script returns success
 /bin/true
diff --git a/tests/xfs/085 b/tests/xfs/085
index 539f324..1b6f424 100755
--- a/tests/xfs/085
+++ b/tests/xfs/085
@@ -48,6 +48,7 @@ rm -f $tmp.log
 
 _require_scratch
 _require_scratch_shutdown
+_require_logstate
 
 echo "mkfs"
 _scratch_mkfs_xfs >>$seqres.full 2>&1 \
diff --git a/tests/xfs/086 b/tests/xfs/086
index 08566d7..02977aa 100755
--- a/tests/xfs/086
+++ b/tests/xfs/086
@@ -45,6 +45,7 @@ _supported_os IRIX Linux
 rm -f $seqres.full $tmp.*
 _require_scratch
 _require_scratch_shutdown
+_require_logstate
 _require_v2log
 
 echo "*** init FS"
diff --git a/tests/xfs/087 b/tests/xfs/087
index 42c7d3b..17a999c 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -60,6 +60,7 @@ _supported_os IRIX Linux
 rm -f $seqres.full $tmp.*
 _require_scratch
 _require_scratch_shutdown
+_require_logstate
 _require_v2log 
 _require_xfs_quota
 
-- 
2.1.1

