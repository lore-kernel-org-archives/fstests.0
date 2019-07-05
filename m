Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfGEL01 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Jul 2019 07:26:27 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs/189: make the test work on systems with a page size greater than 4Kb
Date: Fri,  5 Jul 2019 12:26:21 +0100
Message-Id: <20190705112621.653-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The test currently uses offsets and lengths which are multiples of 4K, but
not multiples of 64K (or any other page size between 4Kb and 64Kb). This
makes the reflink calls fail with -EINVAL because reflink only operates on
ranges that are aligned to the the filesystem's block size.

Fix this by ensuring all ranges passed to the reflink calls are aligned to
64K, so that the test works on any system regardless of its page size.
The test still fails without the corresponding kernel fix applied [1] as
it is supposed to.

[1] 3c850b45110950 ("Btrfs: incremental send, fix emission of invalid clone operations")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/189     | 10 ++++++----
 tests/btrfs/189.out |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/189 b/tests/btrfs/189
index 5f736d73..7b6a1708 100755
--- a/tests/btrfs/189
+++ b/tests/btrfs/189
@@ -59,20 +59,22 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 
 # Clone part of the extent from a higher offset to a lower offset of the same
 # file.
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1560K 500K 100K" $SCRATCH_MNT/bar \
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1600K 640K 128K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
 # Now clone from the previous file, same range, into the middle of another file,
 # such that the end offset at the destination is smaller than the destination's
 # file size.
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1560K 0 100K" $SCRATCH_MNT/zoo \
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1600K 0 128K" $SCRATCH_MNT/zoo \
 	| _filter_xfs_io
 
 # Truncate the source file of the previous clone operation to a smaller size,
 # which ends up in the middle of the range of previous clone operation from file
 # bar to file bar. We want to check this doesn't confuse send to issue invalid
-# clone operations.
-$XFS_IO_PROG -c "truncate 550K" $SCRATCH_MNT/bar
+# clone operations. This smaller size must not be aligned to the sector size of
+# the filesystem - the unaligned size is what can cause those invalid clone
+# operations.
+$XFS_IO_PROG -c "truncate 710K" $SCRATCH_MNT/bar
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
 	| _filter_scratch
diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
index 0ae3cdce..79c70b03 100644
--- a/tests/btrfs/189.out
+++ b/tests/btrfs/189.out
@@ -9,9 +9,9 @@ wrote 2097152/2097152 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
-linked 102400/102400 bytes at offset 512000
+linked 131072/131072 bytes at offset 655360
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-linked 102400/102400 bytes at offset 0
+linked 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
 At subvol SCRATCH_MNT/incr
-- 
2.11.0
