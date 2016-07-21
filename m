Received: from mx2.suse.de ([195.135.220.15]:49115 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbcGUIzL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Jul 2016 04:55:11 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 24F33AAB7
	for <fstests@vger.kernel.org>; Thu, 21 Jul 2016 08:55:10 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH v2] generic/235: Fix false failures for some quota formats
Date: Thu, 21 Jul 2016 10:55:06 +0200
Message-Id: <1469091306-8559-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Different quota format may print additional information in repquota(8)
output after standard quota information is printed. If format does
support this additional printouts, repquota(8) will separate possible
output by two empty lines even if format handler doesn't actually
printout anything (which is currently always the case for queries test
generic/235 does). If format doesn't support additional printouts, these
two empty lines are not present in the output. This inconsistency causes
false failures for some quota formats.

Fix the problem by filtering out empty lines out of repquota(8) output.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/235     | 9 +++++++--
 tests/generic/235.out | 8 --------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/tests/generic/235 b/tests/generic/235
index 59456b67c092..d42054efee91 100755
--- a/tests/generic/235
+++ b/tests/generic/235
@@ -46,6 +46,11 @@ _require_scratch
 _require_quota
 _require_user
 
+_repquota()
+{
+	repquota -u -g $SCRATCH_MNT  | grep -v -E '^root|^$' | _filter_scratch
+}
+
 # real QA test starts here
 rm -f $seqres.full
 
@@ -57,7 +62,7 @@ quotaon $SCRATCH_MNT 2>/dev/null
 touch $SCRATCH_MNT/testfile
 chown $qa_user:$qa_user $SCRATCH_MNT/testfile
 
-repquota -u -g $SCRATCH_MNT  | grep -v "^root" | _filter_scratch
+_repquota
 
 # If remount fails with this problem:
 #
@@ -70,7 +75,7 @@ _scratch_mount "-o remount,rw" 2>&1 | tee -a $seqres.full | _filter_scratch
 
 $XFS_IO_PROG -c 'pwrite 0 8k' -c 'fsync' \
 			$SCRATCH_MNT/testfile >>$seqres.full 2>&1
-repquota -u -g $SCRATCH_MNT  | grep -v "^root" | _filter_scratch
+_repquota
 
 _scratch_unmount 2>/dev/null
 
diff --git a/tests/generic/235.out b/tests/generic/235.out
index 95c10058d1cb..601fa2fa3de8 100644
--- a/tests/generic/235.out
+++ b/tests/generic/235.out
@@ -5,16 +5,12 @@ Block grace time: 7days; Inode grace time: 7days
 User            used    soft    hard  grace    used  soft  hard  grace
 ----------------------------------------------------------------------
 fsgqa     --       0       0       0              1     0     0       
-
-
 *** Report for group quotas on device SCRATCH_DEV
 Block grace time: 7days; Inode grace time: 7days
                         Block limits                File limits
 Group           used    soft    hard  grace    used  soft  hard  grace
 ----------------------------------------------------------------------
 fsgqa     --       0       0       0              1     0     0       
-
-
 touch: cannot touch 'SCRATCH_MNT/failed': Read-only file system
 *** Report for user quotas on device SCRATCH_DEV
 Block grace time: 7days; Inode grace time: 7days
@@ -22,13 +18,9 @@ Block grace time: 7days; Inode grace time: 7days
 User            used    soft    hard  grace    used  soft  hard  grace
 ----------------------------------------------------------------------
 fsgqa     --       8       0       0              1     0     0       
-
-
 *** Report for group quotas on device SCRATCH_DEV
 Block grace time: 7days; Inode grace time: 7days
                         Block limits                File limits
 Group           used    soft    hard  grace    used  soft  hard  grace
 ----------------------------------------------------------------------
 fsgqa     --       8       0       0              1     0     0       
-
-
-- 
2.6.6

