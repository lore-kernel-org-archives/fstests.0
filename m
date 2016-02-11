Received: from mx1.redhat.com ([209.132.183.28]:35386 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbcBKQhl (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 11:37:41 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 83FC1C0A5279
	for <fstests@vger.kernel.org>; Thu, 11 Feb 2016 16:37:41 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs: change return value check to golden image check
Date: Fri, 12 Feb 2016 00:37:36 +0800
Message-Id: <1455208656-16637-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

xfs/133 and xfs/138 use too much code to do "return value" check,
it's not necessary. For the code can be more readable and clear,
I change "return value" check to golden image check.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/133     | 20 +++++++-------------
 tests/xfs/133.out |  7 +++++++
 tests/xfs/138     | 26 ++++++++++++--------------
 tests/xfs/138.out | 12 ++++++++++++
 4 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/tests/xfs/133 b/tests/xfs/133
index 330221f..82c38b1 100755
--- a/tests/xfs/133
+++ b/tests/xfs/133
@@ -46,8 +46,6 @@ _cleanup()
 rm -f $seqres.full
 
 # real QA test starts here
-
-# Modify as appropriate.
 _supported_fs xfs
 _supported_os Linux
 _require_scratch
@@ -72,22 +70,18 @@ $qa_project:10
 EOF
 
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
-		-c "project -s $qa_project" $SCRATCH_MNT >>$seqres.full 2>&1
-	[ $? -ne 0 ] && _fail "Initalize project=$qa_project Failed"
+		-c "project -s $qa_project" $SCRATCH_MNT > /dev/null
 
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
-		-c "limit -p bsoft=100m bhard=200m $qa_project" $SCRATCH_MNT >>$seqres.full 2>&1
-	[ $? -ne 0 ] && _fail "Create limit for project=$qa_project Failed"
+		-c "limit -p bsoft=100m bhard=200m $qa_project" $SCRATCH_MNT
 
-	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
-		-c "quota -p -v $qa_project" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_project
-	[ $? -ne 0 ] && _fail "Query project=$qa_project Failed"
+	echo "=== quota command output ==="
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid \
+		-c "quota -p -v -b $qa_project" $SCRATCH_MNT | _filter_quota
 
+	echo "=== report command output ==="
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
-		-c "report -p" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_project
-	[ $? -ne 0 ] && _fail "Report project=$qa_project Failed"
-
-	return 0
+		-c "report -p -N -b" $SCRATCH_MNT | _filter_quota
 }
 
 # Test project
diff --git a/tests/xfs/133.out b/tests/xfs/133.out
index 189cb69..21cfd0d 100644
--- a/tests/xfs/133.out
+++ b/tests/xfs/133.out
@@ -1 +1,8 @@
 QA output created by 133
+=== quota command output ===
+Disk quotas for Project 123456-project (10)
+Filesystem Blocks Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 0 102400 204800 00 [--------] SCRATCH_MNT
+=== report command output ===
+123456-project 0 102400 204800 00 [--------]
+
diff --git a/tests/xfs/138 b/tests/xfs/138
index 6b17608..c6a6f50 100755
--- a/tests/xfs/138
+++ b/tests/xfs/138
@@ -47,8 +47,6 @@ _cleanup()
 rm -f $seqres.full
 
 # real QA test starts here
-
-# Modify as appropriate.
 _supported_fs xfs
 _supported_os Linux
 _require_scratch
@@ -63,20 +61,20 @@ _qmount_option "uquota,gquota"
 _qmount
 
 # user test
-xfs_quota -x -c "limit -u bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT >>$seqres.full 2>&1
-[ $? -ne 0 ] && _fail "Create limit for user 123456-fsgqa Failed"
-xfs_quota -x -c "quota -u -v 123456-fsgqa" $SCRATCH_MNT 2>>$seqres.full | grep -qw 123456-fsgqa
-[ $? -ne 0 ] && _fail "Query user 123456-fsgqa Failed"
-xfs_quota -x -c "report -u" $SCRATCH_MNT 2>>$seqres.full | grep -qw 123456-fsgqa
-[ $? -ne 0 ] && _fail "Report user 123456-fsgqa Failed"
+echo "== user test =="
+$XFS_QUOTA_PROG -x -c "limit -u bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT
+echo "=== quota command output ==="
+$XFS_QUOTA_PROG -c "quota -u -b -N -v 123456-fsgqa" $SCRATCH_MNT | _filter_quota
+echo "=== report command output ==="
+$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota
 
 # group test
-xfs_quota -x -c "limit -g bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT >>$seqres.full 2>&1
-[ $? -ne 0 ] && _fail "Create limit for group 123456-fsgqa Failed"
-xfs_quota -x -c "quota -g -v 123456-fsgqa" $SCRATCH_MNT 2>>$seqres.full | grep -qw 123456-fsgqa
-[ $? -ne 0 ] && _fail "Query group 123456-fsgqa Failed"
-xfs_quota -x -c "report -u" $SCRATCH_MNT 2>>$seqres.full | grep -qw 123456-fsgqa
-[ $? -ne 0 ] && _fail "Report group 123456-fsgqa Failed"
+echo "== group test =="
+$XFS_QUOTA_PROG -x -c "limit -g bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT
+echo "=== quota command output ==="
+$XFS_QUOTA_PROG -c "quota -g -b -N -v 123456-fsgqa" $SCRATCH_MNT | _filter_quota
+echo "=== report command output ==="
+$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota
 
 # success, all done
 status=0
diff --git a/tests/xfs/138.out b/tests/xfs/138.out
index f3eb411..71929c4 100644
--- a/tests/xfs/138.out
+++ b/tests/xfs/138.out
@@ -1 +1,13 @@
 QA output created by 138
+== user test ==
+=== quota command output ===
+SCRATCH_DEV 0 102400 204800 00 [--------] SCRATCH_MNT
+=== report command output ===
+123456-fsgqa 0 102400 204800 00 [--------]
+
+== group test ==
+=== quota command output ===
+SCRATCH_DEV 0 102400 204800 00 [--------] SCRATCH_MNT
+=== report command output ===
+123456-fsgqa 0 102400 204800 00 [--------]
+
-- 
1.9.3

