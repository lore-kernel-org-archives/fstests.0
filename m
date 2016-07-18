Received: from mx2.suse.de ([195.135.220.15]:48123 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbcGRMAe (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 Jul 2016 08:00:34 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 20AB8AD59
	for <fstests@vger.kernel.org>; Mon, 18 Jul 2016 12:00:32 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/235: Use CSV format for repquota output
Date: Mon, 18 Jul 2016 14:00:24 +0200
Message-Id: <1468843224-8940-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Different quota format may print additional information in repquota(8)
output after standard quota information is printed and this information
is separated by two empty lines. For quota formats that don't support
printing any additional information these lines are not present in the
output which causes false failures of the test. Switch the test to use
repquota(8) CSV output format which does not have these formatting
issues and in general should be more stable.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/235     |  4 ++--
 tests/generic/235.out | 40 ++++++++--------------------------------
 2 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/tests/generic/235 b/tests/generic/235
index 59456b67c092..e2a66fd312f6 100755
--- a/tests/generic/235
+++ b/tests/generic/235
@@ -57,7 +57,7 @@ quotaon $SCRATCH_MNT 2>/dev/null
 touch $SCRATCH_MNT/testfile
 chown $qa_user:$qa_user $SCRATCH_MNT/testfile
 
-repquota -u -g $SCRATCH_MNT  | grep -v "^root" | _filter_scratch
+repquota -O csv -u -g $SCRATCH_MNT  | grep -v "^root" | _filter_scratch
 
 # If remount fails with this problem:
 #
@@ -70,7 +70,7 @@ _scratch_mount "-o remount,rw" 2>&1 | tee -a $seqres.full | _filter_scratch
 
 $XFS_IO_PROG -c 'pwrite 0 8k' -c 'fsync' \
 			$SCRATCH_MNT/testfile >>$seqres.full 2>&1
-repquota -u -g $SCRATCH_MNT  | grep -v "^root" | _filter_scratch
+repquota -O csv -u -g $SCRATCH_MNT  | grep -v "^root" | _filter_scratch
 
 _scratch_unmount 2>/dev/null
 
diff --git a/tests/generic/235.out b/tests/generic/235.out
index 95c10058d1cb..3053c48ce535 100644
--- a/tests/generic/235.out
+++ b/tests/generic/235.out
@@ -1,34 +1,10 @@
 QA output created by 235
-*** Report for user quotas on device SCRATCH_DEV
-Block grace time: 7days; Inode grace time: 7days
-                        Block limits                File limits
-User            used    soft    hard  grace    used  soft  hard  grace
-----------------------------------------------------------------------
-fsgqa     --       0       0       0              1     0     0       
-
-
-*** Report for group quotas on device SCRATCH_DEV
-Block grace time: 7days; Inode grace time: 7days
-                        Block limits                File limits
-Group           used    soft    hard  grace    used  soft  hard  grace
-----------------------------------------------------------------------
-fsgqa     --       0       0       0              1     0     0       
-
-
+User,BlockStatus,FileStatus,BlockUsed,BlockSoftLimit,BlockHardLimit,BlockGrace,FileUsed,FileSoftLimit,FileHardLimit,FileGrace
+fsgqa,ok,ok,0,0,0,,1,0,0,
+Group,BlockStatus,FileStatus,BlockUsed,BlockSoftLimit,BlockHardLimit,BlockGrace,FileUsed,FileSoftLimit,FileHardLimit,FileGrace
+fsgqa,ok,ok,0,0,0,,1,0,0,
 touch: cannot touch 'SCRATCH_MNT/failed': Read-only file system
-*** Report for user quotas on device SCRATCH_DEV
-Block grace time: 7days; Inode grace time: 7days
-                        Block limits                File limits
-User            used    soft    hard  grace    used  soft  hard  grace
-----------------------------------------------------------------------
-fsgqa     --       8       0       0              1     0     0       
-
-
-*** Report for group quotas on device SCRATCH_DEV
-Block grace time: 7days; Inode grace time: 7days
-                        Block limits                File limits
-Group           used    soft    hard  grace    used  soft  hard  grace
-----------------------------------------------------------------------
-fsgqa     --       8       0       0              1     0     0       
-
-
+User,BlockStatus,FileStatus,BlockUsed,BlockSoftLimit,BlockHardLimit,BlockGrace,FileUsed,FileSoftLimit,FileHardLimit,FileGrace
+fsgqa,ok,ok,8,0,0,,1,0,0,
+Group,BlockStatus,FileStatus,BlockUsed,BlockSoftLimit,BlockHardLimit,BlockGrace,FileUsed,FileSoftLimit,FileHardLimit,FileGrace
+fsgqa,ok,ok,8,0,0,,1,0,0,
-- 
2.6.6

