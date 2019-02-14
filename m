Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390720AbfBNPSq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 14 Feb 2019 10:18:46 -0500
From: fdmanana@kernel.org
Subject: [PATCH] fstests: btrfs, test for corruption when reading compressed files
Date: Thu, 14 Feb 2019 15:18:39 +0000
Message-Id: <20190214151839.23619-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Regression test for read corruption of compressed and shared extents after
punching holes into a file. The same extent is shared by the same file in
consecutive ranges (without other extents in between).

This is motivated by a bug recently found in btrfs for which there is a
patch for the linux kernel titled:

  "Btrfs: fix corruption reading shared and compressed extents after hole
   punching"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/183     | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/183.out | 21 +++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 98 insertions(+)
 create mode 100755 tests/btrfs/183
 create mode 100644 tests/btrfs/183.out

diff --git a/tests/btrfs/183 b/tests/btrfs/183
new file mode 100755
index 00000000..ddd83c2d
--- /dev/null
+++ b/tests/btrfs/183
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 183
+#
+# Regression test for read corruption of compressed and shared extents after
+# punching holes into a file.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch_reflink
+_require_xfs_io_command "fpunch"
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount "-o compress"
+
+# Create a file with 3 consecutive compressed extents, each corresponds to 128Kb
+# of data (uncompressed size) and each is stored on disk as a 4Kb extent
+# (compressed size, regardless of compression algorithm used).
+# Each extent starts with 4Kb of zeroes, while the remaining bytes all have a
+# value of 0xff.
+$XFS_IO_PROG -f -c "pwrite -S 0xff 0 384K" \
+	     -c "pwrite -S 0x00 0 4K" \
+	     -c "pwrite -S 0x00 128K 4K" \
+	     -c "pwrite -S 0x00 256K 4K" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+echo "File digest after initial creation:"
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+# Clone the first extent into offsets 128K and 256K.
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foobar 0 128K 128K" \
+	     -c "reflink $SCRATCH_MNT/foobar 0 256K 128K" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+echo "File digest after reflinking:"
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+# Punch holes into the regions that are already full of zeroes.
+$XFS_IO_PROG -c "fpunch 0 4K" \
+	     -c "fpunch 128K 4K" \
+	     -c "fpunch 256K 4K" \
+	     $SCRATCH_MNT/foobar
+
+echo "File digest after punching holes:"
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+echo 1 > /proc/sys/vm/drop_caches
+
+echo "File digest after dropping page cache:"
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+status=0
+exit
diff --git a/tests/btrfs/183.out b/tests/btrfs/183.out
new file mode 100644
index 00000000..36fe3ba8
--- /dev/null
+++ b/tests/btrfs/183.out
@@ -0,0 +1,21 @@
+QA output created by 183
+wrote 393216/393216 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 262144
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File digest after initial creation:
+5a0888d80d7ab1fd31c229f83a3bbcc8  SCRATCH_MNT/foobar
+linked 131072/131072 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 131072/131072 bytes at offset 262144
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File digest after reflinking:
+5a0888d80d7ab1fd31c229f83a3bbcc8  SCRATCH_MNT/foobar
+File digest after punching holes:
+5a0888d80d7ab1fd31c229f83a3bbcc8  SCRATCH_MNT/foobar
+File digest after dropping page cache:
+5a0888d80d7ab1fd31c229f83a3bbcc8  SCRATCH_MNT/foobar
diff --git a/tests/btrfs/group b/tests/btrfs/group
index e32c84e4..d1eeb90a 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -185,3 +185,4 @@
 180 auto quick qgroup limit
 181 auto quick balance
 182 auto quick balance
+183 auto quick clone compress punch
-- 
2.11.0
