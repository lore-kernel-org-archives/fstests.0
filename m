Received: from mx1.redhat.com ([209.132.183.28]:55157 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbbGGCUz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 6 Jul 2015 22:20:55 -0400
From: xuw2015@gmail.com
Subject: [PATCH v2] xfs/015: keep create_file running until growfs finished
Date: Tue,  7 Jul 2015 10:20:50 +0800
Message-Id: <1436235650-1206-1-git-send-email-xuw2015@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: George Wang <xuw2015@gmail.com>
List-ID: <fstests@vger.kernel.org>

From: George Wang <xuw2015@gmail.com>

create_file may run over before growfs, which depends on many reasons. such as
the schedule algorithm, the workload of testing machine, etc. we should always
make sure the create_file run over after growfs, then we can get the valid
result of this test.

Signed-off-by: George Wang <xuw2015@gmail.com>
---
 tests/xfs/015 | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/xfs/015 b/tests/xfs/015
index 4dbf38a..b8fa437 100755
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
+	# keep running until failed after growfs
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
1.9.3

