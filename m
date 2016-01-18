Received: from mx1.redhat.com ([209.132.183.28]:59578 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbcARFDg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 Jan 2016 00:03:36 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 4B8397AE8B
	for <fstests@vger.kernel.org>; Mon, 18 Jan 2016 05:03:36 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/2] fstests: introduce _require_no_mount_opts helper
Date: Mon, 18 Jan 2016 13:03:26 +0800
Message-Id: <1453093407-17734-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Some tests require there's no certain mount option, so introduce a new
helper _require_no_mount_opts() to do the check on $MOUNT_OPTIONS.

Also convert generic/192 and xfs/134 to use this helper.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc         |  8 ++++++++
 tests/generic/192 | 11 -----------
 tests/xfs/134     |  8 +++-----
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/common/rc b/common/rc
index e3aa334..57e4403 100644
--- a/common/rc
+++ b/common/rc
@@ -2794,8 +2794,16 @@ _require_cloner()
 		_notrun "cloner binary not present at $CLONER_PROG"
 }
 
+_require_no_mount_opts()
+{
+	if echo $MOUNT_OPTIONS | grep -q "$1"; then
+		_notrun "mount option \"$1\" not allowed in this test"
+	fi
+}
+
 _require_atime()
 {
+	_require_no_mount_opts "noatime"
 	if [ "$FSTYP" == "nfs" ]; then
 		_notrun "atime related mount options have no effect on NFS"
 	fi
diff --git a/tests/generic/192 b/tests/generic/192
index ebabea2..7298283 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -38,13 +38,6 @@ _access_time()
 	stat -c %X $1
 }
 
-is_noatime_set() {
-	case "$MOUNT_OPTIONS" in
-		*noatime*) return 0;;
-	esac
-	return 1
-}
-
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
@@ -61,10 +54,6 @@ _require_atime
 #delay=45
 delay=40
 
-if is_noatime_set; then
-	_notrun "this test makes no sense with noatime"
-fi
-
 testfile=$TEST_DIR/testfile
 rm -f $testfile
 rm -f $seqres.full
diff --git a/tests/xfs/134 b/tests/xfs/134
index be18ee8..d6927bd 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -50,6 +50,9 @@ _supported_os Linux IRIX
 
 _require_test
 _require_xfs_quota
+# we can't run with group quotas
+_require_no_mount_opts "gquota"
+_require_no_mount_opts "grpquota"
 
 dir=$SCRATCH_MNT/project
 
@@ -70,11 +73,6 @@ _scratch_mkfs_xfs >/dev/null 2>&1
 
 #if pquota's already in mount options then we dont need to enable
 
-# we can't run with group quotas
-if ( `echo $MOUNT_OPTIONS | grep -q gquota` || `echo $MOUNT_OPTIONS | grep -q grpquota` )
-then
-    _notrun "Can't run with group quotas enabled"
-fi
 EXTRA_MOUNT_OPTIONS="-o pquota"
 
 if ! _scratch_mount "$EXTRA_MOUNT_OPTIONS" >$tmp.out 2>&1
-- 
1.8.3.1

