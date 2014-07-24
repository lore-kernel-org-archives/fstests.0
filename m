Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5313 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756788AbaGXKwH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 24 Jul 2014 06:52:07 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] xfs: new case to test inode allocations in post-growfs disk space
Date: Thu, 24 Jul 2014 18:51:45 +0800
Message-Id: <1406199105-13623-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1405529554-31225-1-git-send-email-eguan@redhat.com>
References: <1405529554-31225-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Make sure inodes can be allocated in new space added by xfs_growfs.

Regression test for
xfs: allow inode allocations in post-growfs disk space

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
 - test on 16M xfs to make test quicker, ~70s -> ~10s
 - use _require_fs_space to check $SCRATCH_MNT space
 - reduce inode consumer count to agcount * 2, not hardcoded 1000
 - expect 99% inode usage, not absolute number 0 of free inode
 - new _get_total_inode and _get_used_inode helper, and keep
   _get_free_inode helper which could benefit other tests

 common/rc         |  33 +++++++++++++++++
 tests/xfs/015     | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/015.out |   2 ++
 tests/xfs/group   |   1 +
 4 files changed, 141 insertions(+)
 create mode 100755 tests/xfs/015
 create mode 100644 tests/xfs/015.out

diff --git a/common/rc b/common/rc
index 2c83340..407fb94 100644
--- a/common/rc
+++ b/common/rc
@@ -2225,6 +2225,39 @@ _require_btrfs_fs_feature()
 		_notrun "Feature $feat not supported by the available btrfs version"
 }
 
+_get_total_inode()
+{
+	if [ -z "$1" ]; then
+		echo "Usage: _get_total_inode <mnt>"
+		exit 1
+	fi
+	local nr_inode;
+	nr_inode=`$DF_PROG -i $1 | tail -1 | awk '{print $3}'`
+	echo $nr_inode
+}
+
+_get_used_inode()
+{
+	if [ -z "$1" ]; then
+		echo "Usage: _get_used_inode <mnt>"
+		exit 1
+	fi
+	local nr_inode;
+	nr_inode=`$DF_PROG -i $1 | tail -1 | awk '{print $4}'`
+	echo $nr_inode
+}
+
+_get_free_inode()
+{
+	if [ -z "$1" ]; then
+		echo "Usage: _get_free_inode <mnt>"
+		exit 1
+	fi
+	local nr_inode;
+	nr_inode=`$DF_PROG -i $1 | tail -1 | awk '{print $5}'`
+	echo $nr_inode
+}
+
 init_rc()
 {
 	if [ "$iam" == new ]
diff --git a/tests/xfs/015 b/tests/xfs/015
new file mode 100755
index 0000000..4dbf38a
--- /dev/null
+++ b/tests/xfs/015
@@ -0,0 +1,105 @@
+#! /bin/bash
+# FS QA Test No. xfs/015
+#
+# Make sure inodes can be allocated in new space added by xfs_growfs
+#
+# Regression test for
+# xfs: allow inode allocations in post-growfs disk space
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Red Hat Inc.  All Rights Reserved.
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
+    cd /
+    rm -f $tmp.*
+}
+
+create_file()
+{
+	local dir=$1
+	local i=0
+
+	while echo -n >$dir/testfile_$i; do
+		let i=$i+1
+	done
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs xfs
+_supported_os Linux
+
+_require_scratch
+
+# need 64M space, don't make any assumption
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+_require_fs_space $SCRATCH_MNT 65536
+_scratch_unmount
+
+rm -f $seqres.full
+
+_scratch_mkfs_sized $((16 * 1024 * 1024)) | _filter_mkfs >$seqres.full 2>$tmp.mkfs
+# get original data blocks number and agcount
+. $tmp.mkfs
+_scratch_mount
+
+nr_worker=$((agcount * 2))
+echo "Fork $nr_worker workers to consume free inodes in background" >>$seqres.full
+(
+	i=0
+	while [ $i -lt $nr_worker ]; do
+		mkdir $SCRATCH_MNT/testdir_$i
+		create_file $SCRATCH_MNT/testdir_$i &
+		let i=$i+1
+	done
+	wait
+) >/dev/null 2>&1 &
+
+# Grow fs at the same time, at least x4
+# doubling or tripling the size couldn't reproduce
+echo "Grow fs to $((dblocks * 4)) blocks" >>$seqres.full
+$XFS_GROWFS_PROG -D $((dblocks * 4)) $SCRATCH_MNT >>$seqres.full
+
+# Wait for background create_file to hit ENOSPC
+wait
+
+# log inode status in $seqres.full for debug purpose
+echo "Inode status after growing fs" >>$seqres.full
+$DF_PROG -i $SCRATCH_MNT >>$seqres.full
+
+# inode should be at least 99% used
+total_inode=`_get_total_inode $SCRATCH_MNT`
+used_inode=`_get_used_inode $SCRATCH_MNT`
+_within_tolerance "used inodes" $used_inode $total_inode %1 -v
+
+status=$?
+exit
diff --git a/tests/xfs/015.out b/tests/xfs/015.out
new file mode 100644
index 0000000..8275ab3
--- /dev/null
+++ b/tests/xfs/015.out
@@ -0,0 +1,2 @@
+QA output created by 015
+used inodes is in range
diff --git a/tests/xfs/group b/tests/xfs/group
index d5b50b7..0aab336 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -12,6 +12,7 @@
 012 rw auto quick
 013 auto metadata stress
 014 auto enospc quick quota
+015 auto enospc growfs
 016 rw auto quick
 017 mount auto quick stress
 018 deprecated # log logprint v2log
-- 
1.8.3.1

