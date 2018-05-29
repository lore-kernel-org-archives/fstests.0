Received: from mx2.suse.de ([195.135.220.15]:39101 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936974AbeE2Q4G (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:56:06 -0400
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A890AD7C
        for <fstests@vger.kernel.org>; Tue, 29 May 2018 16:56:05 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/6] ext4: Test for s_inodes_count overflow during fs resize
Date: Tue, 29 May 2018 18:55:57 +0200
Message-Id: <20180529165601.32133-3-jack@suse.cz>
In-Reply-To: <20180529165601.32133-1-jack@suse.cz>
References: <20180529165601.32133-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Test for overflow of s_inodes_count during filesystem resizing.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/config      |   1 +
 tests/ext4/033     | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/033.out |   6 +++
 tests/ext4/group   |   1 +
 4 files changed, 131 insertions(+)
 create mode 100755 tests/ext4/033
 create mode 100644 tests/ext4/033.out

diff --git a/common/config b/common/config
index 51380231aed3..6efc8f9fc4a5 100644
--- a/common/config
+++ b/common/config
@@ -173,6 +173,7 @@ export INDENT_PROG="$(type -P indent)"
 export XFS_COPY_PROG="$(type -P xfs_copy)"
 export FSTRIM_PROG="$(type -P fstrim)"
 export DUMPE2FS_PROG="$(type -P dumpe2fs)"
+export RESIZE2FS_PROG="$(type -P resize2fs)"
 export FIO_PROG="$(type -P fio)"
 export FILEFRAG_PROG="$(type -P filefrag)"
 export E4DEFRAG_PROG="$(type -P e4defrag)"
diff --git a/tests/ext4/033 b/tests/ext4/033
new file mode 100755
index 000000000000..d3e56ab7d1ba
--- /dev/null
+++ b/tests/ext4/033
@@ -0,0 +1,123 @@
+#! /bin/bash
+# FS QA Test 033
+#
+# Test s_inodes_count overflow for huge filesystems. This bug was fixed
+# by commit "ext4: Forbid overflowing inode count when resizing".
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Jan Kara, SUSE.  All Rights Reserved.
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
+	umount $SCRATCH_MNT >/dev/null 2>&1
+	_dmhugedisk_cleanup
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmhugedisk
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+_require_scratch_nocheck
+_require_dmhugedisk
+_require_dumpe2fs
+_require_command "$RESIZE2FS_PROG" resize2fs
+
+# Figure out whether device is large enough
+devsize=$(blockdev --getsize64 $SCRATCH_DEV)
+if [ $devsize -lt 4294967296 ]; then
+	_notrun "Too small scratch device, need at least 4G"
+fi
+
+# Figure out block size
+echo "Figure out block size"
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount >> $seqres.full
+blksz="$(_get_block_size $SCRATCH_MNT)"
+_scratch_unmount
+
+inodes_per_group=$((blksz*8))
+group_blocks=$((blksz*8))
+
+# Number of groups to overflow s_inodes_count
+limit_groups=$(((1<<32)/inodes_per_group))
+
+# Create device huge enough so that overflowing inode count is possible.
+# Set chunk size to 16 sectors. Group descriptors with META_BG feature
+# are rather sparse and that leads to huge overallocation especially with
+# 1k blocksize.
+echo "Format huge device"
+_dmhugedisk_init $(((limit_groups + 16)*group_blocks*(blksz/512))) 16
+
+# Start with small fs
+group_count=$((limit_groups - 16))
+_mkfs_dev -N $((group_count*inodes_per_group)) -b $blksz \
+	$DMHUGEDISK_DEV $((group_count*group_blocks))
+
+_mount $DMHUGEDISK_DEV $SCRATCH_MNT
+
+echo "Initial fs dump" >> $seqres.full
+$DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
+
+# This should fail, s_inodes_count would just overflow!
+echo "Resizing to inode limit + 1..."
+$RESIZE2FS_PROG $DMHUGEDISK_DEV $((limit_groups*group_blocks)) >> $seqres.full 2>&1
+if [ $? -eq 0 ]; then
+	echo "Resizing succeeded but it should fail!"
+	exit
+fi
+
+# This should succeed, we are maxing out inodes
+echo "Resizing to max group count..."
+$RESIZE2FS_PROG $DMHUGEDISK_DEV $(((limit_groups-1)*group_blocks)) >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+	echo "Resizing failed!"
+	exit
+fi
+
+echo "Fs dump after resize" >> $seqres.full
+$DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
+
+# This should fail, s_inodes_count would overflow by quite a bit!
+echo "Resizing to device size..."
+$RESIZE2FS_PROG $DMHUGEDISK_DEV >> $seqres.full 2>&1
+if [ $? -eq 0 ]; then
+	echo "Resizing succeeded but it should fail!"
+	exit
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/033.out b/tests/ext4/033.out
new file mode 100644
index 000000000000..24c251cbb2b3
--- /dev/null
+++ b/tests/ext4/033.out
@@ -0,0 +1,6 @@
+QA output created by 033
+Figure out block size
+Format huge device
+Resizing to inode limit + 1...
+Resizing to max group count...
+Resizing to device size...
diff --git a/tests/ext4/group b/tests/ext4/group
index 5bd15f82b3be..b850f568e674 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -35,6 +35,7 @@
 030 auto quick dax
 031 auto quick dax
 032 auto quick ioctl resize
+033 auto ioctl resize
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.13.6

