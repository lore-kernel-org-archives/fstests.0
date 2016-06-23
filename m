Received: from mx1.redhat.com ([209.132.183.28]:42289 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbcFWGKE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 23 Jun 2016 02:10:04 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3724EC049D5C
	for <fstests@vger.kernel.org>; Thu, 23 Jun 2016 06:10:04 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v4 1/2] fstests: introduce _exclude_scratch_mount_option helper
Date: Thu, 23 Jun 2016 14:09:46 +0800
Message-Id: <1466662187-31201-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Some tests require that there's no certain mount option in
MKFS_OPTIONS, so introduce a new helper
_exclude_scratch_mount_option() to do the check on $MOUNT_OPTIONS.

Also convert generic/192 and xfs/134 to use this helper.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v4:
- rename to _exclude_scratch_mount_option

v3:
- rename to _exclude_mount_option
- add comment to make it clear that it only works on MOUNT_OPTIONS

v2:
- rebase on top of current master

 common/rc         |  9 +++++++++
 tests/generic/192 | 11 -----------
 tests/xfs/134     |  8 +++-----
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/common/rc b/common/rc
index 3a9c4d1..883bd7b 100644
--- a/common/rc
+++ b/common/rc
@@ -2926,8 +2926,17 @@ _require_cloner()
 		_notrun "cloner binary not present at $CLONER_PROG"
 }
 
+# skip test if MKFS_OPTIONS contains the given string
+_exclude_scratch_mount_option()
+{
+	if echo $MOUNT_OPTIONS | grep -q "$1"; then
+		_notrun "mount option \"$1\" not allowed in this test"
+	fi
+}
+
 _require_atime()
 {
+	_exclude_scratch_mount_option "noatime"
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
index cd47069..b3a1107 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -50,6 +50,9 @@ _supported_os Linux IRIX
 
 _require_test
 _require_xfs_quota
+# we can't run with group quotas
+_exclude_scratch_mount_option "gquota"
+_exclude_scratch_mount_option "grpquota"
 
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
2.7.4

