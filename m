Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52972 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbbBFGhs (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:48 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 8/9 v5] common/quota: give quota mount option per filesystem
Date: Thu,  5 Feb 2015 22:37:12 -0800
Message-Id: <1423204633-66673-9-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch add _get_quota_option to assign the mount option selectively
in:

  tests/xfs/087

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/quota  | 15 +++++++++++++++
 tests/xfs/087 |  7 ++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/common/quota b/common/quota
index b320cf2..a103826 100644
--- a/common/quota
+++ b/common/quota
@@ -78,6 +78,21 @@ _require_xfs_quota()
 }
 
 #
+# give quota option accoring to the filesystems.
+#
+_get_quota_option()
+{
+    case $FSTYP in
+    xfs)
+        _require_xfs_quota
+        echo "-o uquota"
+        ;;
+    *)
+        ;;
+    esac
+}
+
+#
 # checks that the XFS project quota support in the kernel is enabled.
 #
 _require_prjquota()
diff --git a/tests/xfs/087 b/tests/xfs/087
index 8da0f9c..2fd6f1a 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -62,7 +62,8 @@ _require_scratch
 _require_scratch_shutdown
 _require_logstate
 _require_v2log 
-_require_xfs_quota
+
+QUOTA_OPTION=`_get_quota_option`
 
 echo "*** init FS"
 umount $SCRATCH_DEV >/dev/null 2>&1
@@ -90,7 +91,7 @@ do
 
     # mount the FS
     _echofull "mount"
-    if ! _scratch_mount -o uquota >>$seqres.full 2>&1; then
+    if ! _scratch_mount $QUOTA_OPTION >>$seqres.full 2>&1; then
 	_echofull "mount failed: $MOUNT_OPTIONS"
 	continue
     fi
@@ -116,7 +117,7 @@ do
     _scratch_xfs_logprint -n >>$seqres.full 2>&1
 
     _echofull "mount with replay"
-    _scratch_mount -o uquota >>$seqres.full 2>&1 \
+    _scratch_mount $QUOTA_OPTION >>$seqres.full 2>&1 \
 	|| _fail "mount failed: $MOUNT_OPTIONS"
 
     # check on what FS looks like after log recovery
-- 
2.1.1

