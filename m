Received: from userp1040.oracle.com ([156.151.31.81]:36339 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbcKPTJS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Nov 2016 14:09:18 -0500
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH v2] fstests: generic/098 update test for truncating a file into the middle of a hole
Date: Wed, 16 Nov 2016 11:17:03 -0800
Message-Id: <1479323823-5638-1-git-send-email-bo.li.liu@oracle.com>
In-Reply-To: <1478903404-25619-1-git-send-email-bo.li.liu@oracle.com>
References: <1478903404-25619-1-git-send-email-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

This updates generic/098 by adding a sync option, i.e. 'sync' after the second
write, and with btrfs's NO_HOLES, we could still get wrong isize after remount.

This gets fixed by the patch

'Btrfs: fix truncate down when no_holes feature is enabled'

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
v2: use 'local' for local variable and add comments for 'sync' option.

 tests/generic/098     | 60 +++++++++++++++++++++++++++++++++------------------
 tests/generic/098.out | 10 +++++++++
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/tests/generic/098 b/tests/generic/098
index 838bb5d..8ab0ad4 100755
--- a/tests/generic/098
+++ b/tests/generic/098
@@ -64,27 +64,45 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-# Create our test file with some data and durably persist it.
-$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 128K" $SCRATCH_MNT/foo | _filter_xfs_io
-sync
-
-# Append some data to the file, increasing its size, and leave a hole between
-# the old size and the start offset if the following write. So our file gets
-# a hole in the range [128Kb, 256Kb[.
-$XFS_IO_PROG -c "pwrite -S 0xbb 256K 32K" $SCRATCH_MNT/foo | _filter_xfs_io
-
-# Now truncate our file to a smaller size that is in the middle of the hole we
-# previously created. On most truncate implementations the data we appended
-# before gets discarded from memory (with truncate_setsize()) and never ends
-# up being written to disk.
-$XFS_IO_PROG -c "truncate 160K" $SCRATCH_MNT/foo
-
-_scratch_cycle_mount
-
-# We expect to see a file with a size of 160Kb, with the first 128Kb of data all
-# having the value 0xaa and the remaining 32Kb of data all having the value 0x00
-echo "File content after remount:"
-od -t x1 $SCRATCH_MNT/foo
+workout()
+{
+	local need_sync=$1
+
+	# Create our test file with some data and durably persist it.
+	$XFS_IO_PROG -t -f -c "pwrite -S 0xaa 0 128K" $SCRATCH_MNT/foo | _filter_xfs_io
+	sync
+
+	# Append some data to the file, increasing its size, and leave a hole between
+	# the old size and the start offset if the following write. So our file gets
+	# a hole in the range [128Kb, 256Kb[.
+	$XFS_IO_PROG -c "pwrite -S 0xbb 256K 32K" $SCRATCH_MNT/foo | _filter_xfs_io
+
+	# This 'sync' is to flush file extent on disk and update on-disk inode size.
+	# This is required to trigger a bug in btrfs truncate where it updates on-disk
+	# inode size incorrectly.
+	if [ $need_sync -eq 1 ]; then
+		sync
+	fi
+
+	# Now truncate our file to a smaller size that is in the middle of the hole we
+	# previously created.
+	# If we don't flush dirty page cache above, on most truncate
+	# implementations the data we appended before gets discarded from
+	# memory (with truncate_setsize()) and never ends up being written to
+	# disk.
+	$XFS_IO_PROG -c "truncate 160K" $SCRATCH_MNT/foo
+
+	_scratch_cycle_mount
+
+	# We expect to see a file with a size of 160Kb, with the first 128Kb of data all
+	# having the value 0xaa and the remaining 32Kb of data all having the value 0x00
+	echo "File content after remount:"
+	od -t x1 $SCRATCH_MNT/foo
+}
+
+workout 0
+# flush after each write
+workout 1
 
 status=0
 exit
diff --git a/tests/generic/098.out b/tests/generic/098.out
index 37415ee..f87f046 100644
--- a/tests/generic/098.out
+++ b/tests/generic/098.out
@@ -9,3 +9,13 @@ File content after remount:
 0400000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 *
 0500000
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 32768/32768 bytes at offset 262144
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File content after remount:
+0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
+*
+0400000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+0500000
-- 
2.5.0

