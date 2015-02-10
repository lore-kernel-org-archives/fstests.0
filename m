Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52399 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbbBJVyo (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 10 Feb 2015 16:54:44 -0500
Date: Tue, 10 Feb 2015 13:54:41 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 8/9 v6] xfs/087: give quota mount option per filesystem
Message-ID: <20150210215441.GB83208@jaegeuk-mac02.mot.com>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
 <1423204633-66673-9-git-send-email-jaegeuk@kernel.org>
 <20150210060100.GM4251@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150210060100.GM4251@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

Change log from v5:
 o move function into the test script

-- >8 --

This patch add _get_quota_option to assign the mount option selectively.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/xfs/087 | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tests/xfs/087 b/tests/xfs/087
index 8da0f9c..38be6d5 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -53,6 +53,18 @@ _do_meta()
     fi
 }
 
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
 # real QA test starts here
 _supported_fs xfs
 _supported_os IRIX Linux
@@ -62,7 +74,8 @@ _require_scratch
 _require_scratch_shutdown
 _require_logstate
 _require_v2log 
-_require_xfs_quota
+
+QUOTA_OPTION=`_get_quota_option`
 
 echo "*** init FS"
 umount $SCRATCH_DEV >/dev/null 2>&1
@@ -90,7 +103,7 @@ do
 
     # mount the FS
     _echofull "mount"
-    if ! _scratch_mount -o uquota >>$seqres.full 2>&1; then
+    if ! _scratch_mount $QUOTA_OPTION >>$seqres.full 2>&1; then
 	_echofull "mount failed: $MOUNT_OPTIONS"
 	continue
     fi
@@ -116,7 +129,7 @@ do
     _scratch_xfs_logprint -n >>$seqres.full 2>&1
 
     _echofull "mount with replay"
-    _scratch_mount -o uquota >>$seqres.full 2>&1 \
+    _scratch_mount $QUOTA_OPTION >>$seqres.full 2>&1 \
 	|| _fail "mount failed: $MOUNT_OPTIONS"
 
     # check on what FS looks like after log recovery
-- 
2.1.1

