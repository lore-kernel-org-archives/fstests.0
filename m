Received: from sandeen.net ([63.231.237.45]:55074 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbcBKXm5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 18:42:57 -0500
Received: from Liberator.local (70-90-76-85-BusName-mn.hfc.comcastbusiness.net [70.90.76.85])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 9519263C5B53
	for <fstests@vger.kernel.org>; Thu, 11 Feb 2016 17:42:56 -0600 (CST)
From: Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH] xfs: test inode32/inode64 options w/ remount & growfs
Message-ID: <56BD1C80.8090302@sandeen.net>
Date: Thu, 11 Feb 2016 17:42:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

inode32/inode64 allocator behavior with respect to mount,
remount and growfs is a little tricky.

The inode32 mount option should only enable the inode32
allocator heuristics if the filesystem is large enough
for 64-bit inodes to exist.  Today, it has this behavior
on the initial mount, but a remount with inode32
unconditionally changes the allocation heuristics, even
for a small fs.

Also, an inode32 mounted small filesystem should transition
to the inode32 allocator if the filesystem is subsequently
grown to a sufficient size.  Today that does not happen.

This test tests both of these behaviors and demonstrates the
problem.

Signed-off-by: Eric Sandeen <sandeen@redha.com>
---

right now the golden output is the actual AGs for file
data allocation; I'm not sure if that's too "tight" an
output or not - the rotor *does* have well-defined
behavior, so I think it's ok.

diff --git a/tests/xfs/260 b/tests/xfs/260
new file mode 100755
index 0000000..a5e2324
--- /dev/null
+++ b/tests/xfs/260
@@ -0,0 +1,135 @@
+#! /bin/bash
+# FS QA Test 260
+#
+# Test inode32/inode64 mount/remount options, with growfs
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
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_test
+_require_loop
+
+loopfile=$TEST_DIR/testfile
+loopmnt=$TEST_DIR/mnt
+
+mkdir -p $loopmnt
+
+# Takes file path as argument
+create_and_map()
+{
+	echo foo > $1
+	xfs_bmap -v $1 | grep -v "EXT\|file" | awk '{print $4}'
+}
+
+# Test proper inode32/inode64 behavior for initial mount and remount.
+# mount, remount, remount
+#
+# Args: size, initial opt, first remount, 2nd remount
+# i.e.: 512g inode32 inode64 inode32
+#   or:   4t inode64 inode32 inode64
+workout_remount()
+{
+	echo "Remount: $1, $2, $3, $4"
+
+	rm -f $loopfile
+	xfs_io -f -c "truncate $1" $loopfile
+	$MKFS_XFS_PROG $loopfile >> $seqres.full 2>&1
+
+	echo "mount $2"
+	mount -t xfs -o loop,$2 $loopfile $loopmnt
+	for I in `seq 1 4`; do create_and_map $loopmnt/file$I; done
+
+	echo "remount $3"
+	mount -o remount,$3 $loopmnt
+	for I in `seq 5 8`; do create_and_map $loopmnt/file$I; done
+
+	echo "remount $4"
+	mount -o remount,$4 $loopmnt
+	for I in `seq 9 12`; do create_and_map $loopmnt/file$I; done
+
+	umount $loopmnt
+}
+
+# Test proper inode32/inode64 across a growfs
+# Mount, grow, remount
+#
+# Args: size1, size2, mount opt, remount opt
+# i.e.: 512g 1t inode32 inode64
+
+workout_growfs()
+{
+	echo "Growfs: $1, $2, $3, $4"
+
+	rm -f $loopfile
+	xfs_io -f -c "truncate $2" $loopfile
+	$MKFS_XFS_PROG -d size=$1 $loopfile >> $seqres.full 2>&1
+
+	echo "$1, mount $3"
+	mount -t xfs -o loop,$3 $loopfile $loopmnt
+	for I in `seq 1 4`; do create_and_map $loopmnt/file$I; done
+
+	echo "growfs $1 to $2"
+	$XFS_GROWFS_PROG $loopmnt >> $seqres.full 2>&1
+	for I in `seq 5 12`; do create_and_map $loopmnt/file$I; done
+
+	# Do more than 4 files here to try to hit new AGs
+	echo "$2, remount $4"
+	mount -o remount,$4 $loopmnt
+	for I in `seq 13 20`; do create_and_map $loopmnt/file$I; done
+
+	umount $loopmnt
+}
+
+workout_remount 128g inode64 inode32 inode64
+workout_remount 128g inode32 inode64 inode32
+workout_remount   4t inode64 inode32 inode64
+workout_remount   4t inode32 inode64 inode32
+
+workout_growfs 1t 4t inode32 inode64
+workout_growfs 1t 4t inode64 inode32
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/260.out b/tests/xfs/260.out
new file mode 100644
index 0000000..4bdf2f0
--- /dev/null
+++ b/tests/xfs/260.out
@@ -0,0 +1,113 @@
+QA output created by 260
+Remount: 128g, inode64, inode32, inode64
+mount inode64
+0
+0
+0
+0
+remount inode32
+0
+0
+0
+0
+remount inode64
+0
+0
+0
+0
+Remount: 128g, inode32, inode64, inode32
+mount inode32
+0
+0
+0
+0
+remount inode64
+0
+0
+0
+0
+remount inode32
+0
+0
+0
+0
+Remount: 4t, inode64, inode32, inode64
+mount inode64
+0
+0
+0
+0
+remount inode32
+1
+2
+3
+1
+remount inode64
+0
+0
+0
+0
+Remount: 4t, inode32, inode64, inode32
+mount inode32
+1
+2
+3
+1
+remount inode64
+0
+0
+0
+0
+remount inode32
+2
+3
+1
+2
+Growfs: 1t, 4t, inode32, inode64
+1t, mount inode32
+0
+0
+0
+0
+growfs 1t to 4t
+1
+2
+3
+4
+5
+6
+7
+8
+4t, remount inode64
+0
+0
+0
+0
+0
+0
+0
+0
+Growfs: 1t, 4t, inode64, inode32
+1t, mount inode64
+0
+0
+0
+0
+growfs 1t to 4t
+0
+0
+0
+0
+0
+0
+0
+0
+4t, remount inode32
+1
+2
+3
+4
+5
+6
+7
+8
diff --git a/tests/xfs/group b/tests/xfs/group
index 2db3520..ce0c69d 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -207,6 +207,7 @@
 252 auto quick prealloc
 253 auto quick
 259 auto quick
+260 auto growfs
 261 auto quick quota
 262 auto quick quota
 266 dump ioctl auto quick

