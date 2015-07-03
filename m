Received: from mx1.redhat.com ([209.132.183.28]:40336 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755013AbbGCRPc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 3 Jul 2015 13:15:32 -0400
From: xuw2015@gmail.com
Subject: [PATCH] xfs/015: make it more robust
Date: Sat,  4 Jul 2015 01:15:27 +0800
Message-Id: <1435943727-6075-1-git-send-email-xuw2015@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: George Wang <xuw2015@gmail.com>
List-ID: <fstests@vger.kernel.org>

From: George Wang <xuw2015@gmail.com>

create_file may run over before growfs, which depends on many reasons. such as
the schedule algorithm, the workload of testing machine, etc. we should always
make sure the create_file run over after growfs, then we can get the valid
result of this test.
---
 tests/xfs/015 | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/xfs/015 b/tests/xfs/015
index 4dbf38a..d9d4446 100755
--- a/tests/xfs/015
+++ b/tests/xfs/015
@@ -43,9 +43,16 @@ create_file()
 {
 	local dir=$1
 	local i=0
-
-	while echo -n >$dir/testfile_$i; do
-		let i=$i+1
+	local in_growfs=false
+
+	# keep run until failed after growfs
+	while true; do
+		[ -f $tmp.growfs ] && in_growfs=true
+		while echo -n >$dir/testfile_$i; do
+			let i=$i+1
+		done
+		$in_growfs && break
+		usleep 1000
 	done
 }
 
@@ -89,6 +96,9 @@ echo "Fork $nr_worker workers to consume free inodes in background" >>$seqres.fu
 echo "Grow fs to $((dblocks * 4)) blocks" >>$seqres.full
 $XFS_GROWFS_PROG -D $((dblocks * 4)) $SCRATCH_MNT >>$seqres.full
 
+# mark xfs_growfs finished to create_file
+touch $tmp.growfs
+
 # Wait for background create_file to hit ENOSPC
 wait
 
-- 
1.8.4.2

