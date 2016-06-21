Received: from mx1.redhat.com ([209.132.183.28]:42078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbcFUKlI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 21 Jun 2016 06:41:08 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2 1/2] fstests: introduce _require_no_mount_opts helper
Date: Tue, 21 Jun 2016 18:40:28 +0800
Message-Id: <1466505629-9402-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: jack@suse.cz, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Some tests require that there's no certain mount option, so
introduce a new helper _require_no_mount_opts() to do the check on
$MOUNT_OPTIONS.

Also convert generic/192 and xfs/134 to use this helper.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- rebase on top of current master

 common/rc         |  8 ++++++++
 tests/generic/192 | 11 -----------
 tests/xfs/134     |  8 +++-----
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/common/rc b/common/rc
index 3a9c4d1..680ea2b 100644
--- a/common/rc
+++ b/common/rc
@@ -2926,8 +2926,16 @@ _require_cloner()
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
index 6bbc87c..d3ed0ec 100755
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
index cd47069..a7df9fe 100755
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
2.5.5

