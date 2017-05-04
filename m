Received: from sandeen.net ([63.231.237.45]:46858 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751961AbdEDAVU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 3 May 2017 20:21:20 -0400
Subject: [PATCH V2] xfs/289: test fragmented multi-fsb readdir
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <fbad53d8-9807-1912-c3e4-e932020c19d3@sandeen.net>
Date: Wed, 3 May 2017 19:21:19 -0500
MIME-Version: 1.0
In-Reply-To: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

Regression test for kernel commit:
023cc840 xfs: handle array index overrun in xfs_dir2_leaf_readbuf()

See commit for detailed problem description.

tl;dr: readahead on weirdly fragmented multi-block directories
was broken.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: address most review comments, esp. nuking ginormous .out
file, but kept touch vs. echo, because echo allocates
1 byte -> 1 block and throws off all
the space calibration.  Still runs in 28s here.

288->289.

Thanks,
-Eric

diff --git a/tests/xfs/289 b/tests/xfs/289
new file mode 100755
index 0000000..86e3dd6
--- /dev/null
+++ b/tests/xfs/289
@@ -0,0 +1,118 @@
+#! /bin/bash
+# FS QA Test 289
+#
+# Test readdir on fragmented multi-fsb dir blocks
+#
+# If the readahead map ends with a partial multi-fsb dir
+# block, the loop at the end of xfs_dir2_leaf_readbuf() may
+# walk off the end of the mapping array, read garbage,
+# corrupt the loop control counter, and never return.
+#
+# Failure is a hang; KASAN should also catch this.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
+# Author: Eric Sandeen <sandeen@redhat.com>
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
+_require_scratch
+_require_test_program "punch-alternating"
+
+# We want to mkfs with a very specific geometry
+MKFS_OPTIONS=""
+_scratch_mkfs "-d size=512m -n size=8192 -i size=1024" >> $seqres.full 2>&1 \
+	|| _fail "mkfs failed"
+_scratch_mount
+
+# Make a ton of mostly-empty inode clusters so we can always
+# make more inodes
+mkdir $SCRATCH_MNT/tmp
+for I in `seq 1 10000`; do touch $SCRATCH_MNT/tmp/$I; done
+
+# These mostly-empty clusters will live here:
+mkdir $SCRATCH_MNT/clusters
+for I in `seq 1 32 10000`; do
+	mv $SCRATCH_MNT/tmp/$I $SCRATCH_MNT/clusters;
+done
+rm -rf $SCRATCH_MNT/tmp
+
+# Make our test dir with a couple blocks, should be contiguous
+mkdir $SCRATCH_MNT/testdir
+# roughly 20 chars per file
+for I in `seq 1 100`; do
+	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
+done
+
+# Now completely fragment freespace.
+# Consume most of it:
+$XFS_IO_PROG -f -c "falloc 0 400m" $SCRATCH_MNT/fillfile ||
+	_fail "Could not allocate space"
+
+# File to fragment:
+$XFS_IO_PROG -f -c "falloc 0 70m" $SCRATCH_MNT/fragfile ||
+	_fail "Could not allocate space"
+
+df -h $SCRATCH_MNT >> $seqres.full 2>&1
+
+# Fill remaining space; let this run to failure
+dd if=/dev/zero of=$SCRATCH_MNT/spacefile1 oflag=direct >> $seqres.full 2>&1
+# Fragment our all-consuming file
+./src/punch-alternating $SCRATCH_MNT/fragfile >> $seqres.full 2>&1
+
+# Punching might have freed up large-ish swaths of metadata
+# Consume hopefully any remaining contiguous freespace
+# (and then some for good measure)
+dd conv=fsync if=/dev/zero of=$SCRATCH_MNT/spacefile2 bs=1M count=64 >> $seqres.full 2>&1
+
+# Now populate the directory so that it must allocate these
+# fragmented blocks
+for I in `seq 1 1400`; do
+	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
+done
+
+# Now traverse that ugly thing!
+find $SCRATCH_MNT/testdir | sort | _filter_scratch | md5sum
+
+status=0
+exit
diff --git a/tests/xfs/289.out b/tests/xfs/289.out
new file mode 100644
index 0000000..35f8c5e
--- /dev/null
+++ b/tests/xfs/289.out
@@ -0,0 +1,2 @@
+QA output created by 289
+23accd029fad51ec02e4ec1f24799878  -
diff --git a/tests/xfs/group b/tests/xfs/group
index 75769f9..1b7046b 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -285,6 +285,7 @@
 285 dangerous_fuzzers dangerous_scrub
 286 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 287 auto dump quota quick
+289 auto dir metadata dangerous
 290 auto rw prealloc quick ioctl zero
 291 auto repair
 292 auto mkfs quick


