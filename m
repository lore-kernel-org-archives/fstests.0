Return-Path: <fstests-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36914 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbaGQCbI (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 16 Jul 2014 22:31:08 -0400
Message-ID: <53C73562.3010005@oracle.com>
Date: Thu, 17 Jul 2014 10:30:58 +0800
From: Jeff Liu <jeff.liu@oracle.com>
MIME-Version: 1.0
Subject: [PATCH] xfs/007: add project quota Q_XQUOTRM test
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "xfs@oss.sgi.com" <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

From: Jie Liu <jeff.liu@oracle.com>

Add test for project quota Q_XQUOTRM operations, this patch also
update the golden output file to match the new output.

Signed-off-by: Jie Liu <jeff.liu@oracle.com>
---
 tests/xfs/007     | 15 ++++++++++-----
 tests/xfs/007.out |  4 +++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/xfs/007 b/tests/xfs/007
index 8cc5bf3..ca05a3c 100755
--- a/tests/xfs/007
+++ b/tests/xfs/007
@@ -47,10 +47,12 @@ _supported_os Linux Irix
 
 _require_scratch
 _require_xfs_quota
+_require_xfs_mkfs_crc
+_require_xfs_crc
 
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs_xfs -m crc=1 >/dev/null 2>&1
 
-_qmount_option "uquota,gquota"
+_qmount_option "uquota,gquota,pquota"
 _qmount
 
 echo "*** umount"
@@ -58,21 +60,24 @@ umount $SCRATCH_MNT
 
 UQUOTINO=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | grep uquotino | awk '{print $NF}'`
 GQUOTINO=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | grep gquotino | awk '{print $NF}'` 
+PQUOTINO=`xfs_db -c "sb 0" -c "p" $SCRATCH_DEV | grep pquotino | awk '{print $NF}'`
 
 echo "*** Usage before quotarm ***"
 xfs_db -c "inode $UQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
 xfs_db -c "inode $GQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
+xfs_db -c "inode $PQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
 
 _qmount
-echo "*** turn off user and group quotas"
-xfs_quota -x -c 'off -ug' $SCRATCH_MNT
-xfs_quota -x -c "remove -ug" $SCRATCH_MNT
+echo "*** turn off user/group/project quotas"
+xfs_quota -x -c 'off -ugp' $SCRATCH_MNT
+xfs_quota -x -c "remove -ugp" $SCRATCH_MNT
 echo "*** umount"
 umount $SCRATCH_MNT
 
 echo "*** Usage after quotarm ***"
 xfs_db -c "inode $UQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
 xfs_db -c "inode $GQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
+xfs_db -c "inode $PQUOTINO" -c "p core.nblocks" $SCRATCH_DEV
 
 # success, all done
 status=0
diff --git a/tests/xfs/007.out b/tests/xfs/007.out
index 0fc17ae..f370e5f 100644
--- a/tests/xfs/007.out
+++ b/tests/xfs/007.out
@@ -3,8 +3,10 @@ QA output created by 007
 *** Usage before quotarm ***
 core.nblocks = 1
 core.nblocks = 1
-*** turn off user and group quotas
+core.nblocks = 1
+*** turn off user/group/project quotas
 *** umount
 *** Usage after quotarm ***
 core.nblocks = 0
 core.nblocks = 0
+core.nblocks = 0
-- 
1.8.3.2
