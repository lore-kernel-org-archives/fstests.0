Received: from mx1.redhat.com ([209.132.183.28]:47341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbbIKLlx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 11 Sep 2015 07:41:53 -0400
From: xuw2015@gmail.com
Subject: [PATCH] generic/027: enlarge fs size for btrfs in bigger page-size machine
Date: Fri, 11 Sep 2015 19:41:31 +0800
Message-Id: <1441971691-26427-1-git-send-email-xuw2015@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: George Wang <xuw2015@gmail.com>
List-ID: <fstests@vger.kernel.org>

From: George Wang <xuw2015@gmail.com>

btrfs on bigger page-size machine(such as ppc64/ppc64le), the min fs
size shoule be more than 480MB. Otherwise, the mount will fail.
So we shoud adjust the fs size to 512MB for btrfs to run this test
correctly. And we also provide a double check: if mount fails, we should
never run this test.

Signed-off-by: George Wang <xuw2015@gmail.com>
---
 tests/generic/027 | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tests/generic/027 b/tests/generic/027
index d2e59d6..c42b9a6 100755
--- a/tests/generic/027
+++ b/tests/generic/027
@@ -65,8 +65,17 @@ _require_scratch
 rm -f $seqres.full
 echo "Silence is golden"
 
-_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
-_scratch_mount
+loop=100
+fs_size=$((256 * 1024 * 1024)) 
+# btrfs takes much longer time, reduce the loop count
+# btrfs takes much more space when first mount on bigger page-size machine
+if [ "$FSTYP" == "btrfs" ]; then
+	loop=10
+	fs_size=$((512 * 1024 * 1024))
+fi
+
+_scratch_mkfs_sized $(fs_size) >>$seqres.full 2>&1
+_scratch_mount || _notrun "scratch dev is not mounted successfully"
 
 echo "Reserve 2M space" >>$seqres.full
 $XFS_IO_PROG -f -c "pwrite 0 2m" $SCRATCH_MNT/testfile >>$seqres.full 2>&1
@@ -75,12 +84,6 @@ $XFS_IO_PROG -f -c "pwrite 0 254m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
 echo "Remove reserved file" >>$seqres.full
 rm -f $SCRATCH_MNT/testfile
 
-loop=100
-# btrfs takes much longer time, reduce the loop count
-if [ "$FSTYP" == "btrfs" ]; then
-	loop=10
-fi
-
 dir=$SCRATCH_MNT/testdir
 echo -n "iteration" >>$seqres.full
 i=1
-- 
1.9.3

