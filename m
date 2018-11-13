Received: from mx1.redhat.com ([209.132.183.28]:48502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732148AbeKMUux (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Nov 2018 15:50:53 -0500
From: XiaoLi Feng <xifeng@redhat.com>
Subject: [PATCH] ext4/034: filter out the specified vaule of $SCRATCH_MNT
Date: Tue, 13 Nov 2018 18:53:15 +0800
Message-Id: <1542106395-22960-1-git-send-email-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, xiaoli feng <xifeng@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: xiaoli feng <xifeng@redhat.com>

In 034.out, the $SCRATCH_MNT is specified by "/mnt/scratch". It's
not flexible. Modify it to fit the different vaule of $SCRATCH_MNT.

Signed-off-by: xiaoli feng <xifeng@redhat.com>
---
 tests/ext4/034     | 2 +-
 tests/ext4/034.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/034 b/tests/ext4/034
index c0735c7..5c34d0d 100755
--- a/tests/ext4/034
+++ b/tests/ext4/034
@@ -70,7 +70,7 @@ $XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/dummy >> $seqres.full
 
 # Use 'syncfs' instead of 'sync' here as 'sync' could have dirtied quota files
 # ahead of writeback and could not reproduce the bug.
-echo "sync $SCRATCH_MNT to writeback"
+echo "sync $SCRATCH_MNT to writeback" | _filter_scratch
 $XFS_IO_PROG -c "syncfs" $SCRATCH_MNT >> $seqres.full
 
 # success, all done
diff --git a/tests/ext4/034.out b/tests/ext4/034.out
index 0791ef7..4b4ebe0 100644
--- a/tests/ext4/034.out
+++ b/tests/ext4/034.out
@@ -5,4 +5,4 @@ Set hard quota
 Create 2 level extent tree (btree) for foobar with a unwritten extent
 Convert unwritten extent to written and collapse extent tree to inode
 Create a new file and do fsync to force a jbd2 commit
-sync /mnt/scratch to writeback
+sync SCRATCH_MNT to writeback
-- 
1.8.3.1
