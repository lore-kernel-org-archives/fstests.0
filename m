Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52953 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbbBFGhq (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:46 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 7/9 v5] common/log: add _get_log_configs for testing options
Date: Thu,  5 Feb 2015 22:37:11 -0800
Message-Id: <1423204633-66673-8-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch adds _get_log_configs for xfs and f2fs to test several mount options
for:
  xfs/086
* xfs/087

In xfs/087, one more test was added, so 10 tests will be done in total.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/log        | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/086     | 15 +--------------
 tests/xfs/087     | 14 +-------------
 tests/xfs/087.out | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 27 deletions(-)

diff --git a/common/log b/common/log
index d8b18f8..5be5411 100644
--- a/common/log
+++ b/common/log
@@ -510,5 +510,52 @@ _require_logstate()
     esac
 }
 
+_xfs_log_config()
+{
+    echo "# mkfs-opt             mount-opt"
+    echo "# ------------------------------"
+    echo "  version=2            logbsize=32k"
+    echo "  version=2,su=4096    logbsize=32k"
+    echo "  version=2,su=32768   logbsize=32k"
+    echo "  version=2,su=32768   logbsize=64k"
+    echo "  version=2            logbsize=64k"
+    echo "  version=2,su=64k     logbsize=64k"
+    echo "  version=2            logbsize=128k"
+    echo "  version=2,su=128k    logbsize=128k"
+    echo "  version=2            logbsize=256k"
+    echo "  version=2,su=256k    logbsize=256k"
+}
+
+_f2fs_log_config()
+{
+    echo "# mkfs-opt             mount-opt"
+    echo "# ------------------------------"
+    echo "  test1     active_logs=6,background_gc=off"
+    echo "  test2     active_logs=6,background_gc=off,inline_data"
+    echo "  test3     active_logs=6,background_gc=off,inline_dentry"
+    echo "  test4     active_logs=6,background_gc=off,inline_data,inline_dentry"
+    echo "  test5     active_logs=6,background_gc=off,disable_roll_forward"
+    echo "  test6     active_logs=6,background_gc=off,discard,inline_data,inline_dentry"
+    echo "  test7     active_logs=6,background_gc=on"
+    echo "  test8     active_logs=6,background_gc=on,inline_data"
+    echo "  test9     active_logs=6,background_gc=on,inline_data,inline_dentry"
+    echo "  test10    active_logs=6,background_gc=on,discard,inline_data,inline_dentry"
+}
+
+_get_log_configs()
+{
+    case "$FSTYP" in
+    xfs)
+        _xfs_log_config
+        ;;
+    f2fs)
+        _f2fs_log_config
+        ;;
+    *)
+        _notrun "$FSTYP does not support log configs."
+        ;;
+    esac
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/xfs/086 b/tests/xfs/086
index 1f81c1b..0cc5008 100755
--- a/tests/xfs/086
+++ b/tests/xfs/086
@@ -51,20 +51,7 @@ _require_v2log
 echo "*** init FS"
 umount $SCRATCH_DEV >/dev/null 2>&1
 
-cat >$tmp.seq.params <<EOF
-# mkfs-opt             mount-opt
-# ------------------------------
-  version=2            logbsize=32k
-  version=2,su=4096    logbsize=32k
-  version=2,su=32768   logbsize=32k
-  version=2,su=32768   logbsize=64k
-  version=2            logbsize=64k
-  version=2,su=64k     logbsize=64k
-  version=2            logbsize=128k
-  version=2,su=128k    logbsize=128k
-  version=2            logbsize=256k
-  version=2,su=256k    logbsize=256k
-EOF
+_get_log_configs > $tmp.seq.params
 
 # Do the work for various log params which
 # should not effect the data content of the log
diff --git a/tests/xfs/087 b/tests/xfs/087
index 8986f67..8da0f9c 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -67,19 +67,7 @@ _require_xfs_quota
 echo "*** init FS"
 umount $SCRATCH_DEV >/dev/null 2>&1
 
-cat >$tmp.seq.params <<EOF
-# mkfs-opt             mount-opt
-# ------------------------------
-  version=2            logbsize=32k
-  version=2,su=4096    logbsize=32k
-  version=2,su=32768   logbsize=32k
-  version=2            logbsize=64k
-  version=2,su=64k     logbsize=64k
-  version=2            logbsize=128k
-  version=2,su=128k    logbsize=128k
-  version=2            logbsize=256k
-  version=2,su=256k    logbsize=256k
-EOF
+_get_log_configs > $tmp.seq.params
 
 cat $tmp.seq.params \
 | while read mkfs mnt restofline
diff --git a/tests/xfs/087.out b/tests/xfs/087.out
index 181774e..9f6f80a 100644
--- a/tests/xfs/087.out
+++ b/tests/xfs/087.out
@@ -378,3 +378,45 @@ clean log
 
 *** filesystem is checked ok ***
 
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
-- 
2.1.1

