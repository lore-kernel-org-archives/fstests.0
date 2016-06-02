Received: from mx1.redhat.com ([209.132.183.28]:60839 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161026AbcFBNKE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 2 Jun 2016 09:10:04 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAE7C552F5
	for <fstests@vger.kernel.org>; Thu,  2 Jun 2016 13:10:02 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-195.bos.redhat.com [10.18.41.195])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u52DA23a016765
	for <fstests@vger.kernel.org>; Thu, 2 Jun 2016 09:10:02 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH v2] xfstests: xfs discontiguous multi-block buffer logging test
Date: Thu,  2 Jun 2016 09:10:01 -0400
Message-Id: <1464873001-17508-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

XFS had a bug in the multi-block buffer logging code that caused a NULL
lv panic at log push time due to invalid regions being set in the buffer
log format bitmap. This was demonstrated by modifying a multi-block
directory buffer in a manner that only logs regions beyond the first
FSB-sized mapping of the buffer.

To recreate these conditions, this test fragments free space and
populates several directories with enough entries to require
discontiguous multi-block buffers. To recreate the problem, we remove
entries from the tail end of the directory and fsync to flush the log.

Note that this test causes a panic on kernels affected by the bug. As
such, it is included in the 'dangerous' group. The bug is resolved by
kernel commit a3916e528b91 ("xfs: fix broken multi-fsb buffer logging").

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

v2:
- Added comments and some aesthetic fixups.
- Fixed up output file.
- Added to quick group.
v1: http://thread.gmane.org/gmane.comp.file-systems.fstests/2475

 tests/xfs/399     | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/399.out |   2 +
 tests/xfs/group   |   1 +
 3 files changed, 124 insertions(+)
 create mode 100755 tests/xfs/399
 create mode 100644 tests/xfs/399.out

diff --git a/tests/xfs/399 b/tests/xfs/399
new file mode 100755
index 0000000..8cea305
--- /dev/null
+++ b/tests/xfs/399
@@ -0,0 +1,121 @@
+#! /bin/bash
+# FS QA Test No. 399
+#
+# Regression test for an XFS multi-block buffer logging bug.
+#
+# The XFS bug results in a panic when a non-contiguous multi-block buffer is
+# mapped and logged in a particular manner, such that only regions beyond the
+# first fsb-sized mapping are logged. The crash occurs asynchronous to
+# transaction submission, when the associated buffer log item is pushed from the
+# CIL (i.e., when the log is subsequently flushed).
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+
+_require_scratch_nocheck	# check complains about single AG fs
+_require_xfs_io_command "fpunch"
+
+rm -f $seqres.full
+
+# Create a small fs with a large directory block size. We want to fill up the fs
+# quickly and then create multi-fsb dirblocks over fragmented free space.
+_scratch_mkfs_xfs -d size=20m -n size=64k >> $seqres.full 2>&1
+_scratch_mount
+
+# Fill a source directory with many largish-named files. 1k uuid-named entries
+# sufficiently populates a 64k directory block.
+mkdir $SCRATCH_MNT/src
+for i in $(seq 0 1023); do
+	touch $SCRATCH_MNT/src/`uuidgen`
+done
+
+# precreate target dirs while we still have free space for inodes
+for i in $(seq 0 3); do
+	mkdir $SCRATCH_MNT/$i
+done
+
+# consume and fragment free space
+$XFS_IO_PROG -xc "resblks 16" $SCRATCH_MNT >> $seqres.full 2>&1
+dd if=/dev/zero of=$SCRATCH_MNT/file bs=4k >> $seqres.full 2>&1
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1
+size=`stat -c %s $SCRATCH_MNT/file`
+for i in $(seq 0 8192 $size); do
+	$XFS_IO_PROG -c "fpunch $i 4k" $SCRATCH_MNT/file >> $seqres.full 2>&1
+done
+
+# Replicate the src dir several times into fragmented free space. After one or
+# two dirs, we should have nothing but non-contiguous directory blocks.
+for d in $(seq 0 3); do
+	for f in `ls -1 $SCRATCH_MNT/src`; do
+		ln $SCRATCH_MNT/src/$f $SCRATCH_MNT/$d/$f
+	done
+done
+
+# Fragment the target dirs a bit. Remove a handful of entries from each to
+# populate the best free space regions in the directory block headers. We want
+# to populate these now so the subsequent unlinks have no reason to log the
+# first block of the directory.
+for d in $(seq 0 3); do
+	i=0
+	for f in `ls -U $SCRATCH_MNT/$d`; do
+		if [ $i == 0 ]; then
+			unlink $SCRATCH_MNT/$d/$f
+		fi
+		i=$(((i + 1) % 128))
+	done
+done
+
+# remount to flush and ensure subsequent operations allocate a new log item
+_scratch_cycle_mount
+
+# Unlink an entry towards the end of each dir and fsync. The unlink should only
+# need to log the latter mappings of the 64k directory block. If the logging bug
+# is present, this will crash!
+for d in $(seq 0 3); do
+	f=`ls -U $SCRATCH_MNT/$d | tail -10 | head -n 1`
+	unlink $SCRATCH_MNT/$d/$f
+	$XFS_IO_PROG -c fsync $SCRATCH_MNT/$d
+done
+
+echo Silence is golden.
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/399.out b/tests/xfs/399.out
new file mode 100644
index 0000000..01b7175
--- /dev/null
+++ b/tests/xfs/399.out
@@ -0,0 +1,2 @@
+QA output created by 399
+Silence is golden.
diff --git a/tests/xfs/group b/tests/xfs/group
index f4c6816..e1bc647 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -285,3 +285,4 @@
 303 auto quick quota
 304 auto quick quota
 305 auto quota
+399 auto dangerous quick
-- 
2.5.5

