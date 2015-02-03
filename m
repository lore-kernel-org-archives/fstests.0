Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56516 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbbBCXHx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 3 Feb 2015 18:07:53 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/8 v4] tests/generic: relocate xfs's tests into tests/generic/
Date: Tue,  3 Feb 2015 15:07:17 -0800
Message-Id: <1423004840-45315-6-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch moves the generic testcases defined in xfs into tests/generic/.
* xfs/053 -> generic/054
  xfs/137 -> generic/137
  xfs/138 -> generic/138
  xfs/139 -> generic/139
  xfs/140 -> generic/140
  xfs/179 -> generic/179
  xfs/180 -> generic/180
  xfs/182 -> generic/182
  xfs/200 -> generic/200
* xfs/306 -> generic/305

* The test number was changed to address conflicts.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/generic/054     | 102 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/054.out |  10 ++++
 tests/generic/137     | 106 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/137.out |   1 +
 tests/generic/138     | 112 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/138.out |   1 +
 tests/generic/139     | 112 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/139.out |   1 +
 tests/generic/140     | 109 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/140.out |   1 +
 tests/generic/179     | 107 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/179.out |   1 +
 tests/generic/180     | 111 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/180.out |   1 +
 tests/generic/182     | 108 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/182.out |   1 +
 tests/generic/200     | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/200.out |  24 ++++++++++
 tests/generic/305     | 105 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/305.out |   2 +
 tests/generic/group   |  10 ++++
 tests/xfs/053         | 102 ----------------------------------------
 tests/xfs/053.out     |  10 ----
 tests/xfs/137         | 106 -----------------------------------------
 tests/xfs/137.out     |   1 -
 tests/xfs/138         | 112 --------------------------------------------
 tests/xfs/138.out     |   1 -
 tests/xfs/139         | 112 --------------------------------------------
 tests/xfs/139.out     |   1 -
 tests/xfs/140         | 109 -------------------------------------------
 tests/xfs/140.out     |   1 -
 tests/xfs/179         | 107 ------------------------------------------
 tests/xfs/179.out     |   1 -
 tests/xfs/180         | 111 -------------------------------------------
 tests/xfs/180.out     |   1 -
 tests/xfs/182         | 108 ------------------------------------------
 tests/xfs/182.out     |   1 -
 tests/xfs/200         | 127 --------------------------------------------------
 tests/xfs/200.out     |  24 ----------
 tests/xfs/306         | 105 -----------------------------------------
 tests/xfs/306.out     |   2 -
 tests/xfs/group       |  10 ----
 42 files changed, 1152 insertions(+), 1152 deletions(-)
 create mode 100755 tests/generic/054
 create mode 100644 tests/generic/054.out
 create mode 100755 tests/generic/137
 create mode 100644 tests/generic/137.out
 create mode 100755 tests/generic/138
 create mode 100644 tests/generic/138.out
 create mode 100755 tests/generic/139
 create mode 100644 tests/generic/139.out
 create mode 100755 tests/generic/140
 create mode 100644 tests/generic/140.out
 create mode 100755 tests/generic/179
 create mode 100644 tests/generic/179.out
 create mode 100755 tests/generic/180
 create mode 100644 tests/generic/180.out
 create mode 100755 tests/generic/182
 create mode 100644 tests/generic/182.out
 create mode 100755 tests/generic/200
 create mode 100644 tests/generic/200.out
 create mode 100755 tests/generic/305
 create mode 100644 tests/generic/305.out
 delete mode 100755 tests/xfs/053
 delete mode 100644 tests/xfs/053.out
 delete mode 100755 tests/xfs/137
 delete mode 100644 tests/xfs/137.out
 delete mode 100755 tests/xfs/138
 delete mode 100644 tests/xfs/138.out
 delete mode 100755 tests/xfs/139
 delete mode 100644 tests/xfs/139.out
 delete mode 100755 tests/xfs/140
 delete mode 100644 tests/xfs/140.out
 delete mode 100755 tests/xfs/179
 delete mode 100644 tests/xfs/179.out
 delete mode 100755 tests/xfs/180
 delete mode 100644 tests/xfs/180.out
 delete mode 100755 tests/xfs/182
 delete mode 100644 tests/xfs/182.out
 delete mode 100755 tests/xfs/200
 delete mode 100644 tests/xfs/200.out
 delete mode 100755 tests/xfs/306
 delete mode 100644 tests/xfs/306.out

diff --git a/tests/generic/054 b/tests/generic/054
new file mode 100755
index 0000000..4106970
--- /dev/null
+++ b/tests/generic/054
@@ -0,0 +1,102 @@
+#! /bin/bash
+# FS QA Test No. 054
+#
+# Test stale data exposure via writeback using various file allocation
+# modification commands. The presumption is that such commands result in partial
+# writeback and can convert a delayed allocation extent, that might be larger
+# than the ranged affected by fallocate, to a normal extent. If the fs happens
+# to crash sometime between when the extent modification is logged and writeback
+# occurs for dirty pages within the extent but outside of the fallocated range,
+# stale data exposure can occur.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Red Hat, Inc.  All Rights Reserved.
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
+. ./common/punch
+
+# real QA test starts here
+rm -f $seqres.full
+
+_crashtest()
+{
+	cmd=$1
+	img=$SCRATCH_MNT/$seq.img
+	mnt=$SCRATCH_MNT/$seq.mnt
+	file=$mnt/file
+
+	# Create an fs on a small, initialized image. The pattern is written to
+	# the image to detect stale data exposure.
+	$XFS_IO_PROG -f -c "truncate 0" -c "pwrite 0 25M" $img \
+		>> $seqres.full 2>&1
+	_mkfs_dev $img >> $seqres.full 2>&1
+
+	mkdir -p $mnt
+	_mount $img $mnt
+
+	echo $cmd
+
+	# write, run the test command and shutdown the fs
+	$XFS_IO_PROG -f -c "pwrite -S 1 0 64k" -c "$cmd 60k 4k" $file | \
+		_filter_xfs_io
+	./src/godown -f $mnt
+
+	$UMOUNT_PROG $mnt
+	_mount $img $mnt
+
+	# we generally expect a zero-sized file (this should be silent)
+	hexdump $file
+
+	$UMOUNT_PROG $mnt
+}
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_scratch_shutdown
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "fpunch"
+_require_xfs_io_command "fzero"
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+_crashtest "falloc -k"
+_crashtest "fpunch"
+_crashtest "fzero -k"
+
+status=0
+exit
diff --git a/tests/generic/054.out b/tests/generic/054.out
new file mode 100644
index 0000000..b2d605f
--- /dev/null
+++ b/tests/generic/054.out
@@ -0,0 +1,10 @@
+QA output created by 054
+falloc -k
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+fpunch
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+fzero -k
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/137 b/tests/generic/137
new file mode 100755
index 0000000..6ec1bcb
--- /dev/null
+++ b/tests/generic/137
@@ -0,0 +1,106 @@
+#! /bin/bash
+# FSQA Test No. 137
+#
+# Test for NULL files problem
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
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
+status=1    # failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux IRIX
+
+_require_scratch
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+# create files
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	xfs_io -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error creating/writing file $file
+		exit
+	fi
+	let i=$i+1
+done
+
+# give the system a chance to write something out
+sleep 10
+
+src/godown $SCRATCH_MNT
+
+umount $SCRATCH_MNT
+_scratch_mount
+umount $SCRATCH_MNT
+if [ ! _check_scratch_fs ]
+then
+	echo error detected in filesystem
+	exit
+fi
+_scratch_mount
+
+# check file size and contents
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	# if file does not exist, the create was not logged, skip it
+	if [ -e $file ]
+	then
+		# if file size is zero it cannot be corrupt, skip it
+		if [ -s $file ]
+		then
+			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
+			if $BMAP_PROG $file | grep 'no extents' > /dev/null
+			then
+				echo corrupt file $file - non-zero size but no extents
+			elif $BMAP_PROG $file | grep 'hole' > /dev/null
+			then
+				echo corrupt file $file - contains holes
+			else
+				rm -f $file
+			fi
+		else
+			rm -f $file
+		fi
+	fi
+	let i=$i+1
+done
+
+status=0
+exit 
diff --git a/tests/generic/137.out b/tests/generic/137.out
new file mode 100644
index 0000000..0fd8b81
--- /dev/null
+++ b/tests/generic/137.out
@@ -0,0 +1 @@
+QA output created by 137
diff --git a/tests/generic/138 b/tests/generic/138
new file mode 100755
index 0000000..9f12639
--- /dev/null
+++ b/tests/generic/138
@@ -0,0 +1,112 @@
+#! /bin/bash
+# FSQA Test No. 138
+#
+# Test for NULL files problem
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
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
+status=1    # failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux IRIX
+
+_require_scratch
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+# create files
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	xfs_io -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error creating/writing file $file
+		exit
+	fi
+	xfs_io -c "truncate 64k" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error truncating file $file
+		exit
+	fi
+	let i=$i+1
+done
+
+# give the system a chance to write something out
+sleep 10
+
+src/godown $SCRATCH_MNT
+
+umount $SCRATCH_MNT
+_scratch_mount
+umount $SCRATCH_MNT
+if [ ! _check_scratch_fs ]
+then
+	echo error detected in filesystem
+	exit
+fi
+_scratch_mount
+
+# check file size and contents
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	# if file does not exist, the create was not logged, skip it
+	if [ -e $file ]
+	then
+		# if file size is zero it cannot be corrupt, skip it
+		if [ -s $file ]
+		then
+			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
+			if $BMAP_PROG $file | grep 'no extents' > /dev/null
+			then
+				echo corrupt file $file - non-zero size but no extents
+			elif $BMAP_PROG $file | grep 'hole' > /dev/null
+			then
+				echo corrupt file $file - contains holes
+			else
+				rm -f $file
+			fi
+		else
+			rm -f $file
+		fi
+	fi
+	let i=$i+1
+done
+
+status=0
+exit 
diff --git a/tests/generic/138.out b/tests/generic/138.out
new file mode 100644
index 0000000..f3eb411
--- /dev/null
+++ b/tests/generic/138.out
@@ -0,0 +1 @@
+QA output created by 138
diff --git a/tests/generic/139 b/tests/generic/139
new file mode 100755
index 0000000..4baa1bc
--- /dev/null
+++ b/tests/generic/139
@@ -0,0 +1,112 @@
+#! /bin/bash
+# FSQA Test No. 139
+#
+# Test for NULL files problem
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
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
+status=1    # failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux IRIX
+
+_require_scratch
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+# create files
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	xfs_io -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error creating/writing file $file
+		exit
+	fi
+	xfs_io -c "truncate 32k" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error truncating file $file
+		exit
+	fi
+	let i=$i+1
+done
+
+# give the system a chance to write something out
+sleep 10
+
+src/godown $SCRATCH_MNT
+
+umount $SCRATCH_MNT
+_scratch_mount
+umount $SCRATCH_MNT
+if [ ! _check_scratch_fs ]
+then
+	echo error detected in filesystem
+	exit
+fi
+_scratch_mount
+
+# check file size and contents
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	# if file does not exist, the create was not logged, skip it
+	if [ -e $file ]
+	then
+		# if file size is zero it cannot be corrupt, skip it
+		if [ -s $file ]
+		then
+			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
+			if $BMAP_PROG $file | grep 'no extents' > /dev/null
+			then
+				echo corrupt file $file - non-zero size but no extents
+			elif $BMAP_PROG $file | grep 'hole' > /dev/null
+			then
+				echo corrupt file $file - contains holes
+			else
+				rm -f $file
+			fi
+		else
+			rm -f $file
+		fi
+	fi
+	let i=$i+1
+done
+
+status=0
+exit 
diff --git a/tests/generic/139.out b/tests/generic/139.out
new file mode 100644
index 0000000..be0ebc2
--- /dev/null
+++ b/tests/generic/139.out
@@ -0,0 +1 @@
+QA output created by 139
diff --git a/tests/generic/140 b/tests/generic/140
new file mode 100755
index 0000000..aff835a
--- /dev/null
+++ b/tests/generic/140
@@ -0,0 +1,109 @@
+#! /bin/bash
+# FSQA Test No. 140
+#
+# Test for NULL files problem
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
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
+status=1    # failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux IRIX
+
+_require_scratch
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+# create files
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error creating/writing file $file
+		exit
+	fi
+	xfs_io -c "truncate 64k" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error truncating file $file
+		exit
+	fi
+	let i=$i+1
+done
+
+# give the system a chance to write something out
+sleep 10
+
+src/godown $SCRATCH_MNT
+
+umount $SCRATCH_MNT
+_scratch_mount
+umount $SCRATCH_MNT
+if [ ! _check_scratch_fs ]
+then
+	echo error detected in filesystem
+	exit
+fi
+_scratch_mount
+
+# check file size and contents
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	# if file does not exist, the create was not logged, skip it
+	if [ -e $file ]
+	then
+		# if file size is zero it cannot be corrupt, skip it
+		if [ -s $file ]
+		then
+			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
+			if $BMAP_PROG $file | grep 'no extents' > /dev/null
+			then
+				echo corrupt file $file - non-zero size but no extents
+			else
+				rm -f $file
+			fi
+		else
+			rm -f $file
+		fi
+	fi
+	let i=$i+1
+done
+
+status=0
+exit 
diff --git a/tests/generic/140.out b/tests/generic/140.out
new file mode 100644
index 0000000..e6506b8
--- /dev/null
+++ b/tests/generic/140.out
@@ -0,0 +1 @@
+QA output created by 140
diff --git a/tests/generic/179 b/tests/generic/179
new file mode 100755
index 0000000..e71afae
--- /dev/null
+++ b/tests/generic/179
@@ -0,0 +1,107 @@
+#! /bin/bash
+# FSQA Test No. 179
+#
+# Test for NULL files problem
+# test inode size is on disk after fsync
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
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
+status=1    # failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux IRIX
+
+_require_scratch
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+_check_files()
+{
+	# check file size and contents
+	i=1;
+	while [ $i -lt 1000 ]
+	do
+		file=$SCRATCH_MNT/$i
+		# if file is missing then fsync failed
+		if [ -e $file ]
+		then
+			# if file size is not 32KB then fsync failed
+			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
+			then
+				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
+				if $BMAP_PROG $file | grep 'no extents' > /dev/null
+				then
+					echo corrupt file $file - non-zero size but no extents
+				else
+					rm -f $file
+				fi
+			else
+				echo file $file has incorrect size - fsync failed
+			fi
+		else
+			echo file $file missing - fsync failed
+		fi
+		let i=$i+1
+	done
+}
+
+# create files and fsync them
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" -c "fsync" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error creating/writing file $file
+		exit
+	fi
+	let i=$i+1
+done
+
+# shutdown immediately after, then remount and test
+src/godown $SCRATCH_MNT
+umount $SCRATCH_MNT
+_scratch_mount
+umount $SCRATCH_MNT
+if [ ! _check_scratch_fs ]
+then
+	echo error detected in filesystem
+	exit
+fi
+_scratch_mount
+_check_files
+
+status=0
+exit
diff --git a/tests/generic/179.out b/tests/generic/179.out
new file mode 100644
index 0000000..e5b0ba9
--- /dev/null
+++ b/tests/generic/179.out
@@ -0,0 +1 @@
+QA output created by 179
diff --git a/tests/generic/180 b/tests/generic/180
new file mode 100755
index 0000000..9e9bf8d
--- /dev/null
+++ b/tests/generic/180
@@ -0,0 +1,111 @@
+#! /bin/bash
+# FSQA Test No. 180
+#
+# Test for NULL files problem
+# test inode size is on disk after sync
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
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
+status=1    # failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux IRIX
+
+_require_scratch
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+# Do we have enough space on disk?  10G
+_require_fs_space $SCRATCH_MNT 10485760
+
+_check_files()
+{
+	# check file size and contents
+	i=1;
+	while [ $i -lt 1000 ]
+	do
+		file=$SCRATCH_MNT/$i
+		# if file is missing then sync failed
+		if [ -e $file ]
+		then
+			# if file size is not 10MB then sync failed
+			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 10485760 ]
+			then
+				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
+				if $BMAP_PROG $file | grep 'no extents' > /dev/null
+				then
+					echo corrupt file $file - non-zero size but no extents
+				else
+					rm -f $file
+				fi
+			else
+				echo file $file has incorrect size - sync failed
+			fi
+		else
+			echo file $file missing - sync failed
+		fi
+		let i=$i+1
+	done
+}
+
+# create files and sync them
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	xfs_io -f -c "pwrite -b 64k -S 0xff 0 10m" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error creating/writing file $file
+		exit
+	fi
+	let i=$i+1
+done
+
+# sync, then shutdown immediately after, then remount and test
+sync
+src/godown $SCRATCH_MNT
+umount $SCRATCH_MNT
+_scratch_mount
+umount $SCRATCH_MNT
+if [ ! _check_scratch_fs ]
+then
+	echo error detected in filesystem
+	exit
+fi
+_scratch_mount
+_check_files
+
+status=0
+exit
diff --git a/tests/generic/180.out b/tests/generic/180.out
new file mode 100644
index 0000000..9035544
--- /dev/null
+++ b/tests/generic/180.out
@@ -0,0 +1 @@
+QA output created by 180
diff --git a/tests/generic/182 b/tests/generic/182
new file mode 100755
index 0000000..68d872c
--- /dev/null
+++ b/tests/generic/182
@@ -0,0 +1,108 @@
+#! /bin/bash
+# FSQA Test No. 182
+#
+# Test for NULL files problem
+# test inode size is on disk after sync - expose log replay bug
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
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
+status=1    # failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux IRIX
+
+_require_scratch
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+_check_files()
+{
+	# check file size and contents
+	i=1;
+	while [ $i -lt 1000 ]
+	do
+		file=$SCRATCH_MNT/$i
+		# if file is missing then sync failed
+		if [ -e $file ]
+		then
+			# if file size is not 32KB then sync failed
+			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
+			then
+				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
+				if $BMAP_PROG $file | grep 'no extents' > /dev/null
+				then
+					echo corrupt file $file - non-zero size but no extents
+				else
+					rm -f $file
+				fi
+			else
+				echo file $file has incorrect size - sync failed
+			fi
+		else
+			echo file $file missing - sync failed
+		fi
+		let i=$i+1
+	done
+}
+
+# create files and sync them
+i=1;
+while [ $i -lt 1000 ]
+do
+	file=$SCRATCH_MNT/$i
+	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo error creating/writing file $file
+		exit
+	fi
+	let i=$i+1
+done
+
+# sync, then shutdown immediately after, then remount and test
+sync
+src/godown $SCRATCH_MNT
+umount $SCRATCH_MNT
+_scratch_mount
+umount $SCRATCH_MNT
+if [ ! _check_scratch_fs ]
+then
+	echo error detected in filesystem
+	exit
+fi
+_scratch_mount
+_check_files
+
+status=0
+exit
diff --git a/tests/generic/182.out b/tests/generic/182.out
new file mode 100644
index 0000000..5e665c8
--- /dev/null
+++ b/tests/generic/182.out
@@ -0,0 +1 @@
+QA output created by 182
diff --git a/tests/generic/200 b/tests/generic/200
new file mode 100755
index 0000000..f29feb9
--- /dev/null
+++ b/tests/generic/200
@@ -0,0 +1,127 @@
+#! /bin/bash
+# FS QA Test No. 200
+#
+# Check out various mount/remount/unmount scenarious on a read-only blockdev.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2009 Christoph Hellwig.
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
+
+_cleanup()
+{
+	cd /
+	blockdev --setrw $SCRATCH_DEV
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch_nocheck
+_require_scratch_shutdown
+_require_norecovery
+
+_scratch_mkfs >/dev/null 2>&1
+
+#
+# Mark the device read-only
+#
+echo "setting device read-only"
+blockdev --setro $SCRATCH_DEV
+
+#
+# Mount it, and make sure we can't write to it, and we can unmount it again
+#
+echo "mounting read-only block device:"
+_scratch_mount 2>&1 | _filter_scratch | _filter_ro_mount
+
+echo "touching file on read-only filesystem (should fail)"
+touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
+
+#
+# Apparently this used to be broken at some point:
+#	http://oss.sgi.com/bugzilla/show_bug.cgi?id=807
+#
+echo "unmounting read-only filesystem"
+umount $SCRATCH_MNT 2>&1 | _filter_scratch
+
+echo "setting device read-write"
+blockdev --setrw $SCRATCH_DEV
+
+echo "mounting read-write block device:"
+_scratch_mount 2>&1 | _filter_scratch
+
+echo "touch files"
+touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
+
+echo "going down:"
+src/godown -f $SCRATCH_MNT
+
+echo "unmounting shutdown filesystem:"
+umount $SCRATCH_MNT 2>&1 | _filter_scratch
+
+echo "setting device read-only"
+blockdev --setro $SCRATCH_DEV
+
+#
+# Mounting a filesystem that requires log-recovery fails unless
+# -o norecovery is used.
+#
+echo "mounting filesystem that needs recovery on a read-only device:"
+_scratch_mount 2>&1 | _filter_scratch | _filter_ro_mount
+
+echo "unmounting read-only filesystem"
+umount $SCRATCH_MNT 2>&1 | _filter_scratch
+
+#
+# This is the way out if the underlying device really is read-only.
+# Doesn't mean it's a good idea in practive, more a last resort
+# data recovery hack.
+#
+echo "mounting filesystem with -o norecovery on a read-only device:"
+_scratch_mount -o norecovery 2>&1 | _filter_scratch | _filter_ro_mount
+
+echo "unmounting read-only filesystem"
+umount $SCRATCH_MNT 2>&1 | _filter_scratch
+
+echo "setting device read-write"
+blockdev --setrw $SCRATCH_DEV
+
+#
+# But log recovery is performed when mount with -o ro as long as
+# the underlying device is not write protected.
+#
+echo "mounting filesystem that needs recovery with -o ro:"
+_scratch_mount -o ro 2>&1 | _filter_scratch 
+
+# success, all done
+echo "*** done"
+rm -f $seqres.full
+status=0
diff --git a/tests/generic/200.out b/tests/generic/200.out
new file mode 100644
index 0000000..40f9163
--- /dev/null
+++ b/tests/generic/200.out
@@ -0,0 +1,24 @@
+QA output created by 200
+setting device read-only
+mounting read-only block device:
+mount: SCRATCH_DEV is write-protected, mounting read-only
+touching file on read-only filesystem (should fail)
+touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
+unmounting read-only filesystem
+setting device read-write
+mounting read-write block device:
+touch files
+going down:
+unmounting shutdown filesystem:
+setting device read-only
+mounting filesystem that needs recovery on a read-only device:
+mount: SCRATCH_DEV is write-protected, mounting read-only
+mount: cannot mount SCRATCH_DEV read-only
+unmounting read-only filesystem
+umount: SCRATCH_MNT: not mounted
+mounting filesystem with -o norecovery on a read-only device:
+mount: SCRATCH_DEV is write-protected, mounting read-only
+unmounting read-only filesystem
+setting device read-write
+mounting filesystem that needs recovery with -o ro:
+*** done
diff --git a/tests/generic/305 b/tests/generic/305
new file mode 100755
index 0000000..0081277
--- /dev/null
+++ b/tests/generic/305
@@ -0,0 +1,105 @@
+#!/bin/bash
+# FS QA Test No. generic/305
+#
+# Basic log recovery stress test - do lots of stuff, shut down in the middle of
+# it and check that recovery runs to completion and everything can be
+# successfully removed afterwards..
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2013 Red Hat, Inc.  All Rights Reserved.
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
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_shutdown
+
+rm -f $seqres.full
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+SLEEP_TIME=$((30 * $TIME_FACTOR))
+PROCS=$((2 * LOAD_FACTOR))
+
+load_dir=$SCRATCH_MNT/test
+
+# let this run for a while
+$FSSTRESS_PROG -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
+sleep $SLEEP_TIME
+killall -q $FSSTRESS_PROG
+wait
+sync
+umount $SCRATCH_MNT
+
+# now mount again, run the load again, this time with a shutdown.
+_scratch_mount
+$XFS_FSR_PROG -v $load_dir >> $seqres.full 2>&1
+$FSSTRESS_PROG -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
+sleep $SLEEP_TIME
+sync
+
+# now shutdown and unmount
+sleep 5
+$here/src/godown $load_dir
+killall -q $FSSTRESS_PROG
+wait
+
+# for some reason fsstress processes manage to live on beyond the wait?
+sleep 5
+umount $SCRATCH_MNT
+
+# now recover, check the filesystem for consistency
+_scratch_mount
+umount $SCRATCH_MNT
+_check_scratch_fs
+
+# now clean up.
+_scratch_mount
+for d in $load_dir/*; do
+        rm -rf $d > /dev/null 2>&1 &
+done
+wait
+umount $SCRATCH_MNT
+
+echo "No output is good. Failures are loud."
+
+status=0
+exit
diff --git a/tests/generic/305.out b/tests/generic/305.out
new file mode 100644
index 0000000..b7f6801
--- /dev/null
+++ b/tests/generic/305.out
@@ -0,0 +1,2 @@
+QA output created by 305
+No output is good. Failures are loud.
diff --git a/tests/generic/group b/tests/generic/group
index fb67b57..122b172 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -45,6 +45,7 @@
 040 metadata auto quick
 041 metadata auto quick
 053 acl repair auto quick
+054 auto quick rw
 062 attr udf auto quick
 068 other auto freeze dangerous stress
 069 rw udf auto quick
@@ -79,12 +80,20 @@
 132 pattern auto
 133 rw auto
 135 metadata auto quick
+137 metadata log auto
+138 metadata log auto
+139 metadata log auto
+140 metadata log auto
 141 rw auto quick
 169 rw metadata auto quick
+179 metadata rw auto
+180 metadata rw auto
+182 metadata rw auto
 184 metadata auto quick
 192 atime auto
 193 metadata auto quick
 198 auto aio quick
+200 mount auto quick
 204 metadata rw auto
 207 auto aio quick
 208 auto aio
@@ -138,6 +147,7 @@
 294 auto quick
 299 auto aio enospc rw stress
 300 auto aio enospc preallocrw stress
+305 auto stress log metadata repair
 306 auto quick rw
 307 auto quick
 308 auto quick
diff --git a/tests/xfs/053 b/tests/xfs/053
deleted file mode 100755
index a3ebc62..0000000
--- a/tests/xfs/053
+++ /dev/null
@@ -1,102 +0,0 @@
-#! /bin/bash
-# FS QA Test No. 053
-#
-# Test stale data exposure via writeback using various file allocation
-# modification commands. The presumption is that such commands result in partial
-# writeback and can convert a delayed allocation extent, that might be larger
-# than the ranged affected by fallocate, to a normal extent. If the fs happens
-# to crash sometime between when the extent modification is logged and writeback
-# occurs for dirty pages within the extent but outside of the fallocated range,
-# stale data exposure can occur.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2014 Red Hat, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/punch
-
-# real QA test starts here
-rm -f $seqres.full
-
-_crashtest()
-{
-	cmd=$1
-	img=$SCRATCH_MNT/$seq.img
-	mnt=$SCRATCH_MNT/$seq.mnt
-	file=$mnt/file
-
-	# Create an fs on a small, initialized image. The pattern is written to
-	# the image to detect stale data exposure.
-	$XFS_IO_PROG -f -c "truncate 0" -c "pwrite 0 25M" $img \
-		>> $seqres.full 2>&1
-	_mkfs_dev $img >> $seqres.full 2>&1
-
-	mkdir -p $mnt
-	_mount $img $mnt
-
-	echo $cmd
-
-	# write, run the test command and shutdown the fs
-	$XFS_IO_PROG -f -c "pwrite -S 1 0 64k" -c "$cmd 60k 4k" $file | \
-		_filter_xfs_io
-	./src/godown -f $mnt
-
-	$UMOUNT_PROG $mnt
-	_mount $img $mnt
-
-	# we generally expect a zero-sized file (this should be silent)
-	hexdump $file
-
-	$UMOUNT_PROG $mnt
-}
-
-# Modify as appropriate.
-_supported_fs generic
-_supported_os Linux
-_require_scratch
-_require_scratch_shutdown
-_require_xfs_io_command "falloc"
-_require_xfs_io_command "fpunch"
-_require_xfs_io_command "fzero"
-
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-_crashtest "falloc -k"
-_crashtest "fpunch"
-_crashtest "fzero -k"
-
-status=0
-exit
diff --git a/tests/xfs/053.out b/tests/xfs/053.out
deleted file mode 100644
index c777fe2..0000000
--- a/tests/xfs/053.out
+++ /dev/null
@@ -1,10 +0,0 @@
-QA output created by 053
-falloc -k
-wrote 65536/65536 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-fpunch
-wrote 65536/65536 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-fzero -k
-wrote 65536/65536 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/xfs/137 b/tests/xfs/137
deleted file mode 100755
index 6ec1bcb..0000000
--- a/tests/xfs/137
+++ /dev/null
@@ -1,106 +0,0 @@
-#! /bin/bash
-# FSQA Test No. 137
-#
-# Test for NULL files problem
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux IRIX
-
-_require_scratch
-_require_scratch_shutdown
-_require_bmap
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-# create files
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error creating/writing file $file
-		exit
-	fi
-	let i=$i+1
-done
-
-# give the system a chance to write something out
-sleep 10
-
-src/godown $SCRATCH_MNT
-
-umount $SCRATCH_MNT
-_scratch_mount
-umount $SCRATCH_MNT
-if [ ! _check_scratch_fs ]
-then
-	echo error detected in filesystem
-	exit
-fi
-_scratch_mount
-
-# check file size and contents
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	# if file does not exist, the create was not logged, skip it
-	if [ -e $file ]
-	then
-		# if file size is zero it cannot be corrupt, skip it
-		if [ -s $file ]
-		then
-			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if $BMAP_PROG $file | grep 'no extents' > /dev/null
-			then
-				echo corrupt file $file - non-zero size but no extents
-			elif $BMAP_PROG $file | grep 'hole' > /dev/null
-			then
-				echo corrupt file $file - contains holes
-			else
-				rm -f $file
-			fi
-		else
-			rm -f $file
-		fi
-	fi
-	let i=$i+1
-done
-
-status=0
-exit 
diff --git a/tests/xfs/137.out b/tests/xfs/137.out
deleted file mode 100644
index 0fd8b81..0000000
--- a/tests/xfs/137.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 137
diff --git a/tests/xfs/138 b/tests/xfs/138
deleted file mode 100755
index 9f12639..0000000
--- a/tests/xfs/138
+++ /dev/null
@@ -1,112 +0,0 @@
-#! /bin/bash
-# FSQA Test No. 138
-#
-# Test for NULL files problem
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux IRIX
-
-_require_scratch
-_require_scratch_shutdown
-_require_bmap
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-# create files
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error creating/writing file $file
-		exit
-	fi
-	xfs_io -c "truncate 64k" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error truncating file $file
-		exit
-	fi
-	let i=$i+1
-done
-
-# give the system a chance to write something out
-sleep 10
-
-src/godown $SCRATCH_MNT
-
-umount $SCRATCH_MNT
-_scratch_mount
-umount $SCRATCH_MNT
-if [ ! _check_scratch_fs ]
-then
-	echo error detected in filesystem
-	exit
-fi
-_scratch_mount
-
-# check file size and contents
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	# if file does not exist, the create was not logged, skip it
-	if [ -e $file ]
-	then
-		# if file size is zero it cannot be corrupt, skip it
-		if [ -s $file ]
-		then
-			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if $BMAP_PROG $file | grep 'no extents' > /dev/null
-			then
-				echo corrupt file $file - non-zero size but no extents
-			elif $BMAP_PROG $file | grep 'hole' > /dev/null
-			then
-				echo corrupt file $file - contains holes
-			else
-				rm -f $file
-			fi
-		else
-			rm -f $file
-		fi
-	fi
-	let i=$i+1
-done
-
-status=0
-exit 
diff --git a/tests/xfs/138.out b/tests/xfs/138.out
deleted file mode 100644
index f3eb411..0000000
--- a/tests/xfs/138.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 138
diff --git a/tests/xfs/139 b/tests/xfs/139
deleted file mode 100755
index 4baa1bc..0000000
--- a/tests/xfs/139
+++ /dev/null
@@ -1,112 +0,0 @@
-#! /bin/bash
-# FSQA Test No. 139
-#
-# Test for NULL files problem
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux IRIX
-
-_require_scratch
-_require_scratch_shutdown
-_require_bmap
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-# create files
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error creating/writing file $file
-		exit
-	fi
-	xfs_io -c "truncate 32k" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error truncating file $file
-		exit
-	fi
-	let i=$i+1
-done
-
-# give the system a chance to write something out
-sleep 10
-
-src/godown $SCRATCH_MNT
-
-umount $SCRATCH_MNT
-_scratch_mount
-umount $SCRATCH_MNT
-if [ ! _check_scratch_fs ]
-then
-	echo error detected in filesystem
-	exit
-fi
-_scratch_mount
-
-# check file size and contents
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	# if file does not exist, the create was not logged, skip it
-	if [ -e $file ]
-	then
-		# if file size is zero it cannot be corrupt, skip it
-		if [ -s $file ]
-		then
-			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if $BMAP_PROG $file | grep 'no extents' > /dev/null
-			then
-				echo corrupt file $file - non-zero size but no extents
-			elif $BMAP_PROG $file | grep 'hole' > /dev/null
-			then
-				echo corrupt file $file - contains holes
-			else
-				rm -f $file
-			fi
-		else
-			rm -f $file
-		fi
-	fi
-	let i=$i+1
-done
-
-status=0
-exit 
diff --git a/tests/xfs/139.out b/tests/xfs/139.out
deleted file mode 100644
index be0ebc2..0000000
--- a/tests/xfs/139.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 139
diff --git a/tests/xfs/140 b/tests/xfs/140
deleted file mode 100755
index aff835a..0000000
--- a/tests/xfs/140
+++ /dev/null
@@ -1,109 +0,0 @@
-#! /bin/bash
-# FSQA Test No. 140
-#
-# Test for NULL files problem
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux IRIX
-
-_require_scratch
-_require_scratch_shutdown
-_require_bmap
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-# create files
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error creating/writing file $file
-		exit
-	fi
-	xfs_io -c "truncate 64k" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error truncating file $file
-		exit
-	fi
-	let i=$i+1
-done
-
-# give the system a chance to write something out
-sleep 10
-
-src/godown $SCRATCH_MNT
-
-umount $SCRATCH_MNT
-_scratch_mount
-umount $SCRATCH_MNT
-if [ ! _check_scratch_fs ]
-then
-	echo error detected in filesystem
-	exit
-fi
-_scratch_mount
-
-# check file size and contents
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	# if file does not exist, the create was not logged, skip it
-	if [ -e $file ]
-	then
-		# if file size is zero it cannot be corrupt, skip it
-		if [ -s $file ]
-		then
-			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if $BMAP_PROG $file | grep 'no extents' > /dev/null
-			then
-				echo corrupt file $file - non-zero size but no extents
-			else
-				rm -f $file
-			fi
-		else
-			rm -f $file
-		fi
-	fi
-	let i=$i+1
-done
-
-status=0
-exit 
diff --git a/tests/xfs/140.out b/tests/xfs/140.out
deleted file mode 100644
index e6506b8..0000000
--- a/tests/xfs/140.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 140
diff --git a/tests/xfs/179 b/tests/xfs/179
deleted file mode 100755
index e71afae..0000000
--- a/tests/xfs/179
+++ /dev/null
@@ -1,107 +0,0 @@
-#! /bin/bash
-# FSQA Test No. 179
-#
-# Test for NULL files problem
-# test inode size is on disk after fsync
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux IRIX
-
-_require_scratch
-_require_scratch_shutdown
-_require_bmap
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-_check_files()
-{
-	# check file size and contents
-	i=1;
-	while [ $i -lt 1000 ]
-	do
-		file=$SCRATCH_MNT/$i
-		# if file is missing then fsync failed
-		if [ -e $file ]
-		then
-			# if file size is not 32KB then fsync failed
-			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
-			then
-				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if $BMAP_PROG $file | grep 'no extents' > /dev/null
-				then
-					echo corrupt file $file - non-zero size but no extents
-				else
-					rm -f $file
-				fi
-			else
-				echo file $file has incorrect size - fsync failed
-			fi
-		else
-			echo file $file missing - fsync failed
-		fi
-		let i=$i+1
-	done
-}
-
-# create files and fsync them
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" -c "fsync" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error creating/writing file $file
-		exit
-	fi
-	let i=$i+1
-done
-
-# shutdown immediately after, then remount and test
-src/godown $SCRATCH_MNT
-umount $SCRATCH_MNT
-_scratch_mount
-umount $SCRATCH_MNT
-if [ ! _check_scratch_fs ]
-then
-	echo error detected in filesystem
-	exit
-fi
-_scratch_mount
-_check_files
-
-status=0
-exit
diff --git a/tests/xfs/179.out b/tests/xfs/179.out
deleted file mode 100644
index e5b0ba9..0000000
--- a/tests/xfs/179.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 179
diff --git a/tests/xfs/180 b/tests/xfs/180
deleted file mode 100755
index 9e9bf8d..0000000
--- a/tests/xfs/180
+++ /dev/null
@@ -1,111 +0,0 @@
-#! /bin/bash
-# FSQA Test No. 180
-#
-# Test for NULL files problem
-# test inode size is on disk after sync
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux IRIX
-
-_require_scratch
-_require_scratch_shutdown
-_require_bmap
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-# Do we have enough space on disk?  10G
-_require_fs_space $SCRATCH_MNT 10485760
-
-_check_files()
-{
-	# check file size and contents
-	i=1;
-	while [ $i -lt 1000 ]
-	do
-		file=$SCRATCH_MNT/$i
-		# if file is missing then sync failed
-		if [ -e $file ]
-		then
-			# if file size is not 10MB then sync failed
-			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 10485760 ]
-			then
-				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if $BMAP_PROG $file | grep 'no extents' > /dev/null
-				then
-					echo corrupt file $file - non-zero size but no extents
-				else
-					rm -f $file
-				fi
-			else
-				echo file $file has incorrect size - sync failed
-			fi
-		else
-			echo file $file missing - sync failed
-		fi
-		let i=$i+1
-	done
-}
-
-# create files and sync them
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 64k -S 0xff 0 10m" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error creating/writing file $file
-		exit
-	fi
-	let i=$i+1
-done
-
-# sync, then shutdown immediately after, then remount and test
-sync
-src/godown $SCRATCH_MNT
-umount $SCRATCH_MNT
-_scratch_mount
-umount $SCRATCH_MNT
-if [ ! _check_scratch_fs ]
-then
-	echo error detected in filesystem
-	exit
-fi
-_scratch_mount
-_check_files
-
-status=0
-exit
diff --git a/tests/xfs/180.out b/tests/xfs/180.out
deleted file mode 100644
index 9035544..0000000
--- a/tests/xfs/180.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 180
diff --git a/tests/xfs/182 b/tests/xfs/182
deleted file mode 100755
index 68d872c..0000000
--- a/tests/xfs/182
+++ /dev/null
@@ -1,108 +0,0 @@
-#! /bin/bash
-# FSQA Test No. 182
-#
-# Test for NULL files problem
-# test inode size is on disk after sync - expose log replay bug
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux IRIX
-
-_require_scratch
-_require_scratch_shutdown
-_require_bmap
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-_check_files()
-{
-	# check file size and contents
-	i=1;
-	while [ $i -lt 1000 ]
-	do
-		file=$SCRATCH_MNT/$i
-		# if file is missing then sync failed
-		if [ -e $file ]
-		then
-			# if file size is not 32KB then sync failed
-			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
-			then
-				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if $BMAP_PROG $file | grep 'no extents' > /dev/null
-				then
-					echo corrupt file $file - non-zero size but no extents
-				else
-					rm -f $file
-				fi
-			else
-				echo file $file has incorrect size - sync failed
-			fi
-		else
-			echo file $file missing - sync failed
-		fi
-		let i=$i+1
-	done
-}
-
-# create files and sync them
-i=1;
-while [ $i -lt 1000 ]
-do
-	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo error creating/writing file $file
-		exit
-	fi
-	let i=$i+1
-done
-
-# sync, then shutdown immediately after, then remount and test
-sync
-src/godown $SCRATCH_MNT
-umount $SCRATCH_MNT
-_scratch_mount
-umount $SCRATCH_MNT
-if [ ! _check_scratch_fs ]
-then
-	echo error detected in filesystem
-	exit
-fi
-_scratch_mount
-_check_files
-
-status=0
-exit
diff --git a/tests/xfs/182.out b/tests/xfs/182.out
deleted file mode 100644
index 5e665c8..0000000
--- a/tests/xfs/182.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 182
diff --git a/tests/xfs/200 b/tests/xfs/200
deleted file mode 100755
index f29feb9..0000000
--- a/tests/xfs/200
+++ /dev/null
@@ -1,127 +0,0 @@
-#! /bin/bash
-# FS QA Test No. 200
-#
-# Check out various mount/remount/unmount scenarious on a read-only blockdev.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2009 Christoph Hellwig.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-
-_cleanup()
-{
-	cd /
-	blockdev --setrw $SCRATCH_DEV
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux
-
-_require_scratch_nocheck
-_require_scratch_shutdown
-_require_norecovery
-
-_scratch_mkfs >/dev/null 2>&1
-
-#
-# Mark the device read-only
-#
-echo "setting device read-only"
-blockdev --setro $SCRATCH_DEV
-
-#
-# Mount it, and make sure we can't write to it, and we can unmount it again
-#
-echo "mounting read-only block device:"
-_scratch_mount 2>&1 | _filter_scratch | _filter_ro_mount
-
-echo "touching file on read-only filesystem (should fail)"
-touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
-
-#
-# Apparently this used to be broken at some point:
-#	http://oss.sgi.com/bugzilla/show_bug.cgi?id=807
-#
-echo "unmounting read-only filesystem"
-umount $SCRATCH_MNT 2>&1 | _filter_scratch
-
-echo "setting device read-write"
-blockdev --setrw $SCRATCH_DEV
-
-echo "mounting read-write block device:"
-_scratch_mount 2>&1 | _filter_scratch
-
-echo "touch files"
-touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
-
-echo "going down:"
-src/godown -f $SCRATCH_MNT
-
-echo "unmounting shutdown filesystem:"
-umount $SCRATCH_MNT 2>&1 | _filter_scratch
-
-echo "setting device read-only"
-blockdev --setro $SCRATCH_DEV
-
-#
-# Mounting a filesystem that requires log-recovery fails unless
-# -o norecovery is used.
-#
-echo "mounting filesystem that needs recovery on a read-only device:"
-_scratch_mount 2>&1 | _filter_scratch | _filter_ro_mount
-
-echo "unmounting read-only filesystem"
-umount $SCRATCH_MNT 2>&1 | _filter_scratch
-
-#
-# This is the way out if the underlying device really is read-only.
-# Doesn't mean it's a good idea in practive, more a last resort
-# data recovery hack.
-#
-echo "mounting filesystem with -o norecovery on a read-only device:"
-_scratch_mount -o norecovery 2>&1 | _filter_scratch | _filter_ro_mount
-
-echo "unmounting read-only filesystem"
-umount $SCRATCH_MNT 2>&1 | _filter_scratch
-
-echo "setting device read-write"
-blockdev --setrw $SCRATCH_DEV
-
-#
-# But log recovery is performed when mount with -o ro as long as
-# the underlying device is not write protected.
-#
-echo "mounting filesystem that needs recovery with -o ro:"
-_scratch_mount -o ro 2>&1 | _filter_scratch 
-
-# success, all done
-echo "*** done"
-rm -f $seqres.full
-status=0
diff --git a/tests/xfs/200.out b/tests/xfs/200.out
deleted file mode 100644
index 40f9163..0000000
--- a/tests/xfs/200.out
+++ /dev/null
@@ -1,24 +0,0 @@
-QA output created by 200
-setting device read-only
-mounting read-only block device:
-mount: SCRATCH_DEV is write-protected, mounting read-only
-touching file on read-only filesystem (should fail)
-touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
-unmounting read-only filesystem
-setting device read-write
-mounting read-write block device:
-touch files
-going down:
-unmounting shutdown filesystem:
-setting device read-only
-mounting filesystem that needs recovery on a read-only device:
-mount: SCRATCH_DEV is write-protected, mounting read-only
-mount: cannot mount SCRATCH_DEV read-only
-unmounting read-only filesystem
-umount: SCRATCH_MNT: not mounted
-mounting filesystem with -o norecovery on a read-only device:
-mount: SCRATCH_DEV is write-protected, mounting read-only
-unmounting read-only filesystem
-setting device read-write
-mounting filesystem that needs recovery with -o ro:
-*** done
diff --git a/tests/xfs/306 b/tests/xfs/306
deleted file mode 100755
index 71f352e..0000000
--- a/tests/xfs/306
+++ /dev/null
@@ -1,105 +0,0 @@
-#!/bin/bash
-# FS QA Test No. xfs/306
-#
-# Basic log recovery stress test - do lots of stuff, shut down in the middle of
-# it and check that recovery runs to completion and everything can be
-# successfully removed afterwards..
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2013 Red Hat, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-_cleanup()
-{
-	cd /
-	umount $SCRATCH_MNT 2>/dev/null
-	rm -f $tmp.*
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux
-
-_require_scratch
-_require_scratch_shutdown
-
-rm -f $seqres.full
-
-_scratch_mkfs > $seqres.full 2>&1
-_scratch_mount
-
-SLEEP_TIME=$((30 * $TIME_FACTOR))
-PROCS=$((2 * LOAD_FACTOR))
-
-load_dir=$SCRATCH_MNT/test
-
-# let this run for a while
-$FSSTRESS_PROG -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
-sleep $SLEEP_TIME
-killall -q $FSSTRESS_PROG
-wait
-sync
-umount $SCRATCH_MNT
-
-# now mount again, run the load again, this time with a shutdown.
-_scratch_mount
-$XFS_FSR_PROG -v $load_dir >> $seqres.full 2>&1
-$FSSTRESS_PROG -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
-sleep $SLEEP_TIME
-sync
-
-# now shutdown and unmount
-sleep 5
-$here/src/godown $load_dir
-killall -q $FSSTRESS_PROG
-wait
-
-# for some reason fsstress processes manage to live on beyond the wait?
-sleep 5
-umount $SCRATCH_MNT
-
-# now recover, check the filesystem for consistency
-_scratch_mount
-umount $SCRATCH_MNT
-_check_scratch_fs
-
-# now clean up.
-_scratch_mount
-for d in $load_dir/*; do
-        rm -rf $d > /dev/null 2>&1 &
-done
-wait
-umount $SCRATCH_MNT
-
-echo "No output is good. Failures are loud."
-
-status=0
-exit
diff --git a/tests/xfs/306.out b/tests/xfs/306.out
deleted file mode 100644
index 9fd18a4..0000000
--- a/tests/xfs/306.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 306
-No output is good. Failures are loud.
diff --git a/tests/xfs/group b/tests/xfs/group
index 496630d..4099793 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -50,7 +50,6 @@
 050 quota auto quick
 051 auto log metadata
 052 quota db auto quick
-053 auto quick rw
 054 quota auto quick
 055 dump ioctl remote tape
 056 dump ioctl auto quick
@@ -99,10 +98,6 @@
 122 other auto quick
 134 quota auto quick
 136 attr2
-137 metadata log auto
-138 metadata log auto
-139 metadata log auto
-140 metadata log auto
 142 dmapi
 143 dmapi
 144 dmapi
@@ -139,10 +134,7 @@
 176 dmapi
 177 dmapi
 178 mkfs other auto
-179 metadata rw auto
-180 metadata rw auto
 181 log auto quick
-182 metadata rw auto
 183 rw other auto quick
 185 dmapi
 186 attr auto quick
@@ -156,7 +148,6 @@
 196 quota auto quick
 197 dir auto quick
 199 mount auto quick
-200 mount auto quick
 201 metadata auto quick
 202 repair auto quick
 203 ioctl auto
@@ -201,4 +192,3 @@
 303 auto quick quota
 304 auto quick quota
 305 auto quota
-306 auto stress log metadata repair
-- 
2.1.1

