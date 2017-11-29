Received: from prv3-mh.provo.novell.com ([137.65.250.26]:36736 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdK2GOb (ORCPT
        <rfc822;groupwise-fstests@vger.kernel.org:0:0>);
        Wed, 29 Nov 2017 01:14:31 -0500
From: Qu Wenruo <wqu@suse.com>
Subject: [PATCH] fstests: btrfs: Add test case to check if btrfs can handle full fs trim correctly
Date: Wed, 29 Nov 2017 14:14:19 +0800
Message-Id: <20171129061419.18310-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Ancient commit f4c697e6406d ("btrfs: return EINVAL if start > total_bytes in
fitrim ioctl") introduced a regression where btrfs may fail to trim any
free space in existing block groups.

It's caused by confusion with btrfs_super_block->total_bytes and btrfs
logical address space.
Unlike physical address, any aligned bytenr in range [0, U64_MAX) is
valid in btrfs logical address space, and it's chunk mapping mechanism
of btrfs to handle the logical<->physical mapping.

The test case will craft a btrfs with the following features:
0) Single data/meta profile
   Make trimmed bytes reporting and chunk allocation more predictable.

1) All chunks start beyond super_block->total_bytes (1G)
   By relocating these blocks several times.

2) Unallocated space is less than 50% of the whole fs

3) Fragmented data chunks
   Data chunks will be full of fragments, 50% of data chunks will be
   free space.

So in theory fstrim should be able to trim over 50% space of the fs.
(after fix, 64% of the fs can be trimmed)
While the regression makes btrfs only able to trim unallocated space,
which is less than 50% of the total space.
(without fix, it's only 31%)

Fixed by patch named "btrfs: Ensure btrfs_trim_fs can trim the whole fs".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/155     | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/155.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 123 insertions(+)
 create mode 100755 tests/btrfs/155
 create mode 100644 tests/btrfs/155.out

diff --git a/tests/btrfs/155 b/tests/btrfs/155
new file mode 100755
index 00000000..6918f093
--- /dev/null
+++ b/tests/btrfs/155
@@ -0,0 +1,120 @@
+#! /bin/bash
+# FS QA Test 155
+#
+# Check if btrfs can correctly trim free space in block groups
+#
+# An ancient regression prevent btrfs from trimming free space inside
+# existing block groups, if bytenr of block group starts beyond
+# btrfs_super_block->total_bytes.
+# However all bytenr in btrfs is in btrfs logical address space,
+# where any bytenr in range [0, U64_MAX] is valid.
+#
+# Fixed by patch named "btrfs: Ensure btrfs_trim_fs can trim the whole fs".
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_fstrim
+
+# 1024fs size
+fs_size=$((1024 * 1024 * 1024))
+
+# Use small files to fill half of the fs
+file_size=$(( 1024 * 1024 ))
+nr_files=$(( $fs_size / $file_size / 2))
+
+# Force to use single data and meta profile.
+# Since the test relies on fstrim output, which will differ for different
+# profiles
+_scratch_mkfs -b $fs_size -m single -d single > /dev/null
+_scratch_mount
+
+_require_batched_discard "$SCRATCH_MNT"
+
+for n in $(seq -w 0 $(( $nr_files - 1))); do
+	$XFS_IO_PROG -f -c "pwrite 0 $file_size" "$SCRATCH_MNT/file_$n" \
+		> /dev/null
+done
+
+# Flush all buffer data into disk, to trigger chunk allocation
+sync
+
+# Now we have take at least 50% of the filesystem, relocate all chunks twice
+# so all chunks will start after 1G in logical space.
+# (Btrfs chunk allocation will not rewind to reuse lower space)
+_run_btrfs_util_prog balance start --full-balance "$SCRATCH_MNT"
+
+# To avoid possible false ENOSPC alert on v4.15-rc1, seems to be a
+# reserved space related bug (maybe related to outstanding space rework?),
+# but that's another story.
+sync
+
+_run_btrfs_util_prog balance start --full-balance "$SCRATCH_MNT"
+
+# Now remove half of the files to make some holes for later trim.
+# While still keep the chunk space fragmented, so no chunk will be freed
+rm $SCRATCH_MNT/file_*[13579] -f
+
+# Make sure space is freed
+sync
+
+trimmed=$($FSTRIM_PROG -v "$SCRATCH_MNT" | _filter_fstrim)
+echo "Trimmed=$trimmed total_size=$fs_size ratio=$(($trimmed * 100 / $fs_size))%" \
+	>> $seqres.full
+
+# For correct full fs trim, both unallocated space (less than 50%)
+# and free space in existing block groups (about 25%) should be trimmed.
+# If less than 50% is trimmed, then only unallocated space is trimmed.
+# BTW, without fix only 31% can be trimmed, while after fix it's 64%.
+if [ $trimmed -lt $(( $fs_size / 2)) ]; then
+	echo "Free space in block groups not trimmed"
+	echo "Trimmed=$trimmed total_size=$fs_size ratio=$(($trimmed * 100 / $fs_size))%"
+fi
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/155.out b/tests/btrfs/155.out
new file mode 100644
index 00000000..d25dcd3b
--- /dev/null
+++ b/tests/btrfs/155.out
@@ -0,0 +1,2 @@
+QA output created by 155
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index c98cf823..86c7128e 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -157,3 +157,4 @@
 152 auto quick metadata qgroup send
 153 auto quick qgroup
 154 auto quick
+155 auto trim
-- 
2.14.2

