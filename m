Received: from mx1.redhat.com ([209.132.183.28]:45774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751678AbcJVFkO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 22 Oct 2016 01:40:14 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9816B624B4
        for <fstests@vger.kernel.org>; Sat, 22 Oct 2016 05:40:13 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/054: only filter ROOT_INO at the beginning
Date: Sat, 22 Oct 2016 13:39:56 +0800
Message-Id: <1477114796-19019-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

In the test ROOT_INO is filtered out or replaced, but if ROOT_INO is
also 32, more "32"s are filtered or replaced than expected. This
happens to me when testing 512B block size XFS and 1k block size CRC
enabled XFS.

Also the ROOT_INO should be the inode number of TEST_DIR not
SCRATCH_MNT.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/054 | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/xfs/054 b/tests/xfs/054
index 7d08f8a..578b752 100755
--- a/tests/xfs/054
+++ b/tests/xfs/054
@@ -52,13 +52,13 @@ _require_test
 _require_xfs_io_command "inode"
 
 # We know the root inode is there
-ROOT_INO=`ls -id $SCRATCH_MNT | awk '{print $1}'`
+ROOT_INO=`ls -id $TEST_DIR | awk '{print $1}'`
 
 touch $TEST_DIR/file
 
 $XFS_IO_PROG -c "inode"       $TEST_DIR/file
 $XFS_IO_PROG -c "inode -v"    $TEST_DIR/file | \
-		grep -vw $ROOT_INO | sed -e s/.*:/LAST:/g
+		grep -vw "^$ROOT_INO" | sed -e s/.*:/LAST:/g
 
 #  These should fail, -n requires an inode
 $XFS_IO_PROG -c "inode -n"    $TEST_DIR/file 2>&1 | grep -q Query \
@@ -83,15 +83,15 @@ $XFS_IO_PROG -c "inode -n -v badnumber" $TEST_DIR/file | grep -q numeric \
 # These should all work, and return $ROOT_INO or the next inode...
 # grep out ROOT_INO (which is incorrect) when we should be getting next inode
 $XFS_IO_PROG -c "inode       $ROOT_INO" $TEST_DIR/file | \
-		sed -e s/$ROOT_INO/ROOT_INO/g
+		sed -e s/^$ROOT_INO/ROOT_INO/g
 $XFS_IO_PROG -c "inode -v    $ROOT_INO" $TEST_DIR/file | \
-		sed -e s/$ROOT_INO/ROOT_INO/g
+		sed -e s/^$ROOT_INO/ROOT_INO/g
 $XFS_IO_PROG -c "inode -n    $ROOT_INO" $TEST_DIR/file | \
-		grep -vw $ROOT_INO | sed -e s/.*/NEXT/g
+		grep -vw "^$ROOT_INO" | sed -e s/.*/NEXT/g
 $XFS_IO_PROG -c "inode -nv   $ROOT_INO" $TEST_DIR/file | \
-		grep -vw $ROOT_INO | sed -e s/.*:/NEXT:/g
+		grep -vw "^$ROOT_INO" | sed -e s/.*:/NEXT:/g
 $XFS_IO_PROG -c "inode -n -v $ROOT_INO" $TEST_DIR/file | \
-		grep -vw $ROOT_INO | sed -e s/.*:/NEXT:/g
+		grep -vw "^$ROOT_INO" | sed -e s/.*:/NEXT:/g
 
 # Try one that doesn't exist, 2^64-2?  Should get 0
 $XFS_IO_PROG -c "inode       18446744073709551614" $TEST_DIR/file
-- 
2.7.4

