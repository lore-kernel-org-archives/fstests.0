Received: from cn.fujitsu.com ([222.73.24.84]:65047 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932227AbcFOGjE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 15 Jun 2016 02:39:04 -0400
Received: from localhost.localdomain (unknown [10.167.226.107])
	by cn.fujitsu.com (Postfix) with ESMTP id 4EC084056403
	for <fstests@vger.kernel.org>; Wed, 15 Jun 2016 14:38:50 +0800 (CST)
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH v2] ext4: regression test for fsync transaction ids initialization
Date: Wed, 15 Jun 2016 14:37:10 +0800
Message-Id: <1465972630-29595-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <20160614042103.GM5140@eguan.usersys.redhat.com>
References: <20160614042103.GM5140@eguan.usersys.redhat.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Commit 688f869 fixed this bug:
    ext4: Initialize fsync transaction ids in ext4_new_inode()

We manually modify jbd2 journal_superblock_s.s_sequence to be a very large
number, which will greatly reduce the time taken to trigger this bug, though
it seems some too hacked.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
v2:
- don't use loop devices, use scratch device directly. And use
Eryu Guan's script to find jbd2 journal superblock's offset.
---
 tests/ext4/021     | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/021.out |   2 +
 tests/ext4/group   |   1 +
 3 files changed, 109 insertions(+)
 create mode 100755 tests/ext4/021
 create mode 100644 tests/ext4/021.out

diff --git a/tests/ext4/021 b/tests/ext4/021
new file mode 100755
index 0000000..2e13142
--- /dev/null
+++ b/tests/ext4/021
@@ -0,0 +1,106 @@
+#! /bin/bash
+# FS QA Test 021
+#
+# Regression test for commit:
+# 688f869 ext4: Initialize fsync transaction ids in ext4_new_inode()
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+_require_scratch
+_require_dumpe2fs
+
+_scratch_mkfs_sized $((8 * 1024 * 1024)) >> $seqres.full 2>&1
+
+blocksize=`$DUMPE2FS_PROG -h $SCRATCH_DEV 2>/dev/null | grep "Block size" | \
+	awk '{print $3}'`
+offset=0
+found=0
+# this is the jbd2 journal superblock magic number on disk, in big endian
+magic="c0 3b 39 98"
+
+# 8M in bytes
+filesize=$((8 * 1024 * 1024))
+while [ $offset -lt $filesize ]; do
+	if od -j $offset -N 4 -t x1 $SCRATCH_DEV | \
+	   grep -i "$magic" >/dev/null; then
+		echo "Found journal: $offset" >> $seqres.full
+		found=1
+		break
+	fi
+	offset=$((offset + blocksize))
+done
+if [ $found -ne 1 ]; then
+	echo "Found no journal"
+	exit
+fi
+
+# Overwrite journal.s_squence to 0x 81d1a480
+# 0x81d1a480 is hex form of 2178000000, and jbd2 journal is big endian on
+# disk, the s_squence offset to the beginning of journal superblock is 24
+# we do this to let jbd2 start to run with a initial big transaction id,
+# which will reduce the time taken to trigger this bug.
+xfs_io  -c "pwrite -S 0x81 $((offset+24)) 1" \
+	-c "pwrite -S 0xd1 $((offset+25)) 1" \
+	-c "pwrite -S 0xa4 $((offset+26)) 1" \
+	-c "pwrite -S 0x80 $((offset+27)) 1" $SCRATCH_DEV >> $seqres.full 2>&1
+
+trans_id=`$DUMPE2FS_PROG $SCRATCH_DEV 2>/dev/null | grep "Journal sequence" | \
+	awk '{print $NF}'`
+echo "Initial transaction id is $trans_id"
+_scratch_mount
+
+do_fdatasync_work()
+{
+	while [ 1 ]; do
+		$XFS_IO_PROG -f -c "fdatasync" $SCRATCH_MNT/testfile
+	done
+}
+
+do_fdatasync_work &
+datasync_work_pid=$!
+sleep 10
+kill $datasync_work_pid >/dev/null 2>&1
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/021.out b/tests/ext4/021.out
new file mode 100644
index 0000000..9e504e2
--- /dev/null
+++ b/tests/ext4/021.out
@@ -0,0 +1,2 @@
+QA output created by 021
+Initial transaction id is 0x81d1a480
diff --git a/tests/ext4/group b/tests/ext4/group
index 9e28159..bbdbe1d 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -23,6 +23,7 @@
 018 fuzzers
 019 fuzzers
 020 auto quick ioctl rw
+021 auto quick
 271 auto rw quick
 301 aio auto ioctl rw stress
 302 aio auto ioctl rw stress
-- 
2.5.0



