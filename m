Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35565 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbaFWOyY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 23 Jun 2014 10:54:24 -0400
From: Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 2/2] generic/017: Do not create file systems with different block sizes
Date: Mon, 23 Jun 2014 16:54:15 +0200
Message-Id: <1403535255-14601-2-git-send-email-lczerner@redhat.com>
In-Reply-To: <1403535255-14601-1-git-send-email-lczerner@redhat.com>
References: <1403535255-14601-1-git-send-email-lczerner@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: fdmanana@gmail.com, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

User takes care about specifying mkfs options he wishes to test and the
test itself should not change it if it's not strictly necessary for the
test itself.

In this case it is not necessary and we should only test configuration
provided by the user. Moreover if the block size was already specified
some mkfs utilities does not handle multiple of the same parameters and
the mkfs utility fails making it re-try with only provided options
(ignoring what user specified), which is wrong.

In this case it's also a problem for btrfs file system which does not
support block size < page size.

Fix it by removing the mkfs, and testing existing configuration only.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 tests/generic/017     | 46 +++++++++++++++++-----------------------------
 tests/generic/017.out |  2 --
 2 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/tests/generic/017 b/tests/generic/017
index 13b7254..11705bf 100755
--- a/tests/generic/017
+++ b/tests/generic/017
@@ -49,41 +49,29 @@ _do_die_on_error=y
 testfile=$SCRATCH_MNT/$seq.$$
 BLOCKS=10240
 
-for (( BSIZE = 1024; BSIZE <= 4096; BSIZE *= 2 )); do
+BSIZE=`get_block_size $SCRATCH_MNT`
 
-	length=$(($BLOCKS * $BSIZE))
-	case $FSTYP in
-	xfs)
-	_scratch_mkfs -b size=$BSIZE >> $seqres.full 2>&1
-	;;
-	ext4)
-	_scratch_mkfs -b $BSIZE >> $seqres.full 2>&1
-	;;
-	esac
-	_scratch_mount >> $seqres.full 2>&1
+length=$(($BLOCKS * $BSIZE))
 
-	# Write file
-	$XFS_IO_PROG -f -c "pwrite 0 $length" -c fsync $testfile > /dev/null
+# Write file
+$XFS_IO_PROG -f -c "pwrite 0 $length" -c fsync $testfile > /dev/null
 
-	# Collapse alternate blocks 
-	for (( i = 1; i <= 7; i++ )); do
-		for (( j=0; j < $(($BLOCKS/(2**$i))); j++ )); do
-			offset=$(($j*$BSIZE))
-			$XFS_IO_PROG -c "fcollapse $offset $BSIZE" $testfile > /dev/null
-		done
+# Collapse alternate blocks 
+for (( i = 1; i <= 7; i++ )); do
+	for (( j=0; j < $(($BLOCKS/(2**$i))); j++ )); do
+		offset=$(($j*$BSIZE))
+		$XFS_IO_PROG -c "fcollapse $offset $BSIZE" $testfile > /dev/null
 	done
+done
 
-	# Check if 80 extents are present
-	$XFS_IO_PROG -c "fiemap -v" $testfile | grep "^ *[0-9]*:" |wc -l
-
-	_check_scratch_fs
-	if [ $? -ne 0 ]; then
-		status=1
-		exit
-	fi
+# Check if 80 extents are present
+$XFS_IO_PROG -c "fiemap -v" $testfile | grep "^ *[0-9]*:" |wc -l
 
-	umount $SCRATCH_MNT
-done
+_check_scratch_fs
+if [ $? -ne 0 ]; then
+	status=1
+	exit
+fi
 
 # success, all done
 status=0
diff --git a/tests/generic/017.out b/tests/generic/017.out
index cc524ac..ea9a7a8 100644
--- a/tests/generic/017.out
+++ b/tests/generic/017.out
@@ -1,4 +1,2 @@
 QA output created by 017
 80
-80
-80
-- 
1.8.3.1

