Received: from mx1.redhat.com ([209.132.183.28]:34912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbbFDSQB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 4 Jun 2015 14:16:01 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 8A41F350106
	for <fstests@vger.kernel.org>; Thu,  4 Jun 2015 18:16:01 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-237.bos.redhat.com [10.18.41.237])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t54IG1BF029762
	for <fstests@vger.kernel.org>; Thu, 4 Jun 2015 14:16:01 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH v2] xfstests/xfs: test inode allocation with fragmented free space
Date: Thu,  4 Jun 2015 14:15:59 -0400
Message-Id: <1433441759-14125-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

XFS dynamic inode allocation has a fundamental limitation in that an
inode chunk requires a contiguous extent of a minimum size. Depending on
the level of free space fragmentation, inode allocation can fail with
ENOSPC where the filesystem might not be near 100% usage.

The sparse inodes feature was implemented to provide an inode allocation
strategy that maximizes the ability to allocate inodes under free space
fragmentation. This test fragments free space and verifies that
filesystems that support sparse inode allocation can allocate a minimum
percentage of inodes on the fs.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

v2:
- Modified test to explicitly format with -i sparse instead of passive
  detection.
- Create and use generic _require_xfs_sparse_inodes().
- Refactored various utility functions into generic helpers.
- Cleaned up some commands and error checking cruft.
- Cleaned up and added more detailed comments.
- Based golden output on _within_tolerance() filter.
v1: http://article.gmane.org/gmane.comp.file-systems.fstests/830

 common/rc         |  37 ++++++++++++++++
 tests/xfs/075     | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/075.out |   2 +
 tests/xfs/group   |   1 +
 4 files changed, 170 insertions(+)
 create mode 100755 tests/xfs/075
 create mode 100644 tests/xfs/075.out

diff --git a/common/rc b/common/rc
index 610045e..0562360 100644
--- a/common/rc
+++ b/common/rc
@@ -1449,6 +1449,18 @@ _require_xfs_sysfs()
 	fi
 }
 
+# this test requires the xfs sparse inode feature
+#
+_require_xfs_sparse_inodes()
+{
+	_scratch_mkfs_xfs_supported -m crc=1 -i sparse > /dev/null 2>&1 \
+		|| _notrun "mkfs.xfs does not support sparse inodes"
+	_scratch_mkfs_xfs -m crc=1 -i sparse > /dev/null 2>&1
+	_scratch_mount >/dev/null 2>&1 \
+		|| _notrun "kernel does not support sparse inodes"
+	umount $SCRATCH_MNT
+}
+
 # this test requires that external log/realtime devices are not in use
 #
 _require_nonexternal()
@@ -2724,6 +2736,18 @@ _get_used_inode()
 	echo $nr_inode
 }
 
+_get_used_inode_percent()
+{
+	if [ -z "$1" ]; then
+		echo "Usage: _get_used_inode_percent <mnt>"
+		exit 1
+	fi
+	local pct_inode;
+	pct_inode=`$DF_PROG -i $1 | tail -1 | awk '{ print $6 }' | \
+		   sed -e 's/%//'`
+	echo $pct_inode
+}
+
 _get_free_inode()
 {
 	if [ -z "$1" ]; then
@@ -2735,6 +2759,19 @@ _get_free_inode()
 	echo $nr_inode
 }
 
+# get the available space in bytes
+#
+_get_available_space()
+{
+	if [ -z "$1" ]; then
+		echo "Usage: _get_available_space <mnt>"
+		exit 1
+	fi
+	local avail_kb;
+	avail_kb=`$DF_PROG $1 | tail -n1 | awk '{ print $5 }'`
+	echo $((avail_kb * 1024))
+}
+
 # get btrfs profile configs being tested
 #
 # A set of pre-set profile configs are exported via _btrfs_profile_configs
diff --git a/tests/xfs/075 b/tests/xfs/075
new file mode 100755
index 0000000..465c274
--- /dev/null
+++ b/tests/xfs/075
@@ -0,0 +1,130 @@
+#!/bin/bash
+# FS QA Test No. xfs/075
+#
+# Verify that a filesystem with sparse inode support can allocate inodes in the
+# event of free space fragmentation. This test is generic in nature but
+# primarily relevant to filesystems that implement dynamic inode allocation
+# (e.g., XFS).
+#
+# The test is inspired by inode allocation limitations on XFS when available
+# free space is fragmented. XFS allocates inodes 64 at a time and thus requires
+# an extent of length that depends on inode size (64 * isize / blksize).
+#
+# The test creates a small, sparse inode enabled filesystem. It fragments free
+# space, allocates inodes to ENOSPC and then verifies that most of the available
+# inodes (.i.e., free space) have been consumed.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
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
+#
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
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+_cleanup()
+{
+	cd /
+	umount $SCRATCH_MNT 2>/dev/null
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_consume_freesp()
+{
+	file=$1
+
+	# consume nearly all available space (leave ~1MB)
+	avail=`_get_available_space $SCRATCH_MNT`
+	filesizemb=$((avail / 1024 / 1024 - 1))
+	$XFS_IO_PROG -fc "falloc 0 ${filesizemb}m" $file
+}
+
+# Allocate inodes in a directory until failure.
+_alloc_inodes()
+{
+	dir=$1
+
+	i=0
+	while [ true ]; do
+		touch $dir/$i 2>> $seqres.full || break
+		i=$((i + 1))
+	done
+}
+
+# real QA test starts here
+_supported_os Linux
+
+_require_scratch
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "fpunch"
+_require_xfs_sparse_inodes
+
+rm -f $seqres.full
+
+_scratch_mkfs "-d size=50m -m crc=1 -i sparse" |
+	_filter_mkfs > /dev/null 2> $tmp.mkfs
+. $tmp.mkfs	# for isize
+
+_scratch_mount
+
+# Calculate the fs inode chunk size based on the inode size and fixed 64-inode
+# record. This value is used as the target level of free space fragmentation
+# induced by the test (i.e., max size of free extents). We don't need to go
+# smaller than a full chunk because the XFS block allocator tacks on alignment
+# requirements to the size of the requested allocation. In other words, a chunk
+# sized free chunk is not enough to guarantee a successful chunk sized
+# allocation.
+CHUNK_SIZE=$((isize * 64))
+
+_consume_freesp $SCRATCH_MNT/spc
+
+# Now that the fs is nearly full, punch holes in every other $CHUNK_SIZE range
+# of the space consumer file. This should ensure that most freed extents are not
+# contiguous with any others and thus sufficiently fragment free space. After
+# each hole punch, allocate as many inodes as possible into the newly freed
+# space. Note that we start at the end of the file and work backwards as a
+# reverse allocation pattern increases the chances of both left and right sparse
+# record merges.
+offset=`stat -c "%s" $SCRATCH_MNT/spc`
+offset=$((offset - $CHUNK_SIZE * 2))
+while [ $offset -ge 0 ]; do
+	$XFS_IO_PROG -c "fpunch $offset $CHUNK_SIZE" $SCRATCH_MNT/spc \
+		2>> $seqres.full || _fail "fpunch failed"
+
+	# allocate as many inodes as possible
+	mkdir -p $SCRATCH_MNT/offset.$offset > /dev/null 2>&1
+	_alloc_inodes $SCRATCH_MNT/offset.$offset
+
+	offset=$((offset - $CHUNK_SIZE * 2))
+done
+
+# check that we've hit at least 95% inode usage
+iusepct=`_get_used_inode_percent $SCRATCH_MNT`
+_within_tolerance "iusepct" $iusepct 100 5 0 -v
+
+status=0
+exit
diff --git a/tests/xfs/075.out b/tests/xfs/075.out
new file mode 100644
index 0000000..8bd0686
--- /dev/null
+++ b/tests/xfs/075.out
@@ -0,0 +1,2 @@
+QA output created by 075
+iusepct is in range
diff --git a/tests/xfs/group b/tests/xfs/group
index 848a1bd..b5d55ed 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -71,6 +71,7 @@
 071 rw auto
 072 rw auto prealloc quick
 073 copy auto
+075 auto enospc
 078 growfs auto quick
 080 rw ioctl
 081 deprecated # log logprint quota
-- 
1.9.3

