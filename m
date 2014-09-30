Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:4688 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753926AbaI3ChU (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 29 Sep 2014 22:37:20 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XYnJU-0004XA-Ny
	for fstests@vger.kernel.org; Tue, 30 Sep 2014 12:37:16 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XYnJU-0005Zk-Mk
	for fstests@vger.kernel.org; Tue, 30 Sep 2014 12:37:16 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] xfs/007: check correct quota inodes
Date: Tue, 30 Sep 2014 12:37:16 +1000
Message-Id: <1412044636-21398-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Commit b8cac56 ("xfs/007: add project quota Q_XQUOTARM test") has
been broken since it was added - the new code checked the group
quota inode rather than the project quota inode and so always
reported a pre-RM block count of zero.  This occurred due to a copy
and paste of the existing user/group test code and didn't fix up all
the code properly.

Factor the common code into a single function, and pass in the
correct variables the tests require. While there, make sure that we
remove the 007.full file before the test starts to aid future
debugging and also check that project quotas are supported before
trying to test them.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/007     | 78 ++++++++++++++++++++++++++-----------------------------
 tests/xfs/007.out |  4 +--
 2 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/tests/xfs/007 b/tests/xfs/007
index 247c5b3..22ee27d 100755
--- a/tests/xfs/007
+++ b/tests/xfs/007
@@ -48,55 +48,51 @@ _supported_os Linux Irix
 _require_scratch
 _require_xfs_quota
 
-_scratch_mkfs_xfs >/dev/null 2>&1
-
-_qmount_option "uquota,gquota"
-_qmount
+rm -f $seqres.full
 
-echo "*** umount"
-umount $SCRATCH_MNT
+_scratch_mkfs_xfs >/dev/null 2>&1
 
-UQUOTINO=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | grep uquotino | awk '{print $NF}'`
-GQUOTINO=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | grep gquotino | awk '{print $NF}'` 
+do_test()
+{
+	qino_1=$1
+	qino_2=$2
+	off_opts=$3
+
+	echo "*** umount"
+	umount $SCRATCH_MNT
+
+	QINO_1=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | \
+			grep $qino_1 | awk '{print $NF}'`
+	QINO_2=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | \
+			grep $qino_2 | awk '{print $NF}'` 
+
+	echo "*** Usage before quotarm ***"
+	xfs_db -c "inode $QINO_1" -c "p core.nblocks" $SCRATCH_DEV
+	xfs_db -c "inode $QINO_2" -c "p core.nblocks" $SCRATCH_DEV
+
+	_qmount
+	echo "*** turn off $off_opts quotas"
+	xfs_quota -x -c "off -$off_opts" $SCRATCH_MNT
+	xfs_quota -x -c "remove -$off_opts" $SCRATCH_MNT
+	echo "*** umount"
+	umount $SCRATCH_MNT
+
+	echo "*** Usage after quotarm ***"
+	xfs_db -c "inode $QINO_1" -c "p core.nblocks" $SCRATCH_DEV
+	xfs_db -c "inode $QINO_2" -c "p core.nblocks" $SCRATCH_DEV
+}
 
-echo "*** Usage before quotarm ***"
-xfs_db -c "inode $UQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
-xfs_db -c "inode $GQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
 
+# Test user and group first
+_qmount_option "uquota,gquota"
 _qmount
-echo "*** turn off user and group quotas"
-xfs_quota -x -c 'off -ug' $SCRATCH_MNT
-xfs_quota -x -c "remove -ug" $SCRATCH_MNT
-echo "*** umount"
-umount $SCRATCH_MNT
-
-echo "*** Usage after quotarm ***"
-xfs_db -c "inode $UQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
-xfs_db -c "inode $GQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
+do_test uquotino gquotino ug
 
+# Test user and project
 _qmount_option "uquota,pquota"
 _qmount
-
-echo "*** umount"
-umount $SCRATCH_MNT
-
-UQUOTINO=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | grep uquotino | awk '{print $NF}'`
-PQUOTINO=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | grep gquotino | awk '{print $NF}'`
-
-echo "*** Usage before quotarm ***"
-xfs_db -c "inode $UQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
-xfs_db -c "inode $PQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
-
-_qmount
-echo "*** turn off user and project quotas"
-xfs_quota -x -c 'off -up' $SCRATCH_MNT
-xfs_quota -x -c "remove -up" $SCRATCH_MNT
-echo "*** umount"
-umount $SCRATCH_MNT
-
-echo "*** Usage after quotarm ***"
-xfs_db -c "inode $UQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
-xfs_db -c "inode $PQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
+_require_prjquota $SCRATCH_DEV
+do_test uquotino pquotino up
 
 # success, all done
 status=0
diff --git a/tests/xfs/007.out b/tests/xfs/007.out
index 7c5bff5..8b5f3ea 100644
--- a/tests/xfs/007.out
+++ b/tests/xfs/007.out
@@ -3,7 +3,7 @@ QA output created by 007
 *** Usage before quotarm ***
 core.nblocks = 1
 core.nblocks = 1
-*** turn off user and group quotas
+*** turn off ug quotas
 *** umount
 *** Usage after quotarm ***
 core.nblocks = 0
@@ -12,7 +12,7 @@ core.nblocks = 0
 *** Usage before quotarm ***
 core.nblocks = 1
 core.nblocks = 1
-*** turn off user and project quotas
+*** turn off up quotas
 *** umount
 *** Usage after quotarm ***
 core.nblocks = 0
-- 
2.0.0

