Received: from aserp1040.oracle.com ([141.146.126.69]:25243 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdLDXfp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Dec 2017 18:35:45 -0500
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH] fstests: btrfs: reproduce a read failure on raid6 setup
Date: Mon,  4 Dec 2017 15:33:23 -0700
Message-Id: <20171204223323.3710-1-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test case is to reproduce a bug of raid6 reconstruction process.

The kernel fix are
Btrfs: do not merge rbios if their fail stripe index are not identical
Btrfs: make raid6 rebuild retry more

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
 tests/btrfs/155     | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/155.out |  10 +++++
 tests/btrfs/group   |   1 +
 3 files changed, 130 insertions(+)
 create mode 100755 tests/btrfs/155
 create mode 100644 tests/btrfs/155.out

diff --git a/tests/btrfs/155 b/tests/btrfs/155
new file mode 100755
index 0000000..2dec0c3
--- /dev/null
+++ b/tests/btrfs/155
@@ -0,0 +1,119 @@
+#! /bin/bash
+# FS QA Test 155
+#
+# The test case is to reproduce a bug in raid6 reconstruction process that
+# would end up with read failure.
+#
+# if there is data
+# corruption on two disks in the same horizontal stripe, e.g. due to bitrot.
+#
+# The bug happens a) when all disks are good to read,
+# b) there is corrupted data on two disks in the same horizontal stripe due to
+# something like bitrot,
+# c) when rebuilding data after crc fails, btrfs is not able to tell whether
+# other copies are good or corrupted because btrfs doesn't have crc for
+# unallocated blocks.
+#
+# The kernel fixes are
+# Btrfs: do not merge rbios if their fail stripe index are not identical
+# Btrfs: make raid6 rebuild retry more 
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Oracle.  All Rights Reserved.
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
+_require_scratch_dev_pool 4
+_require_btrfs_command inspect-internal dump-tree
+
+get_physical_stripe0()
+{
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+	grep " DATA\|RAID6" -A 10 | $AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /0/) { print $6 }'
+}
+
+get_physical_stripe1()
+{
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+	grep " DATA\|RAID6" -A 10 | $AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /1/) { print $6 }'
+}
+
+_scratch_dev_pool_get 4
+# step 1: create a raid6 btrfs and create a 4K file
+echo "step 1......mkfs.btrfs" >>$seqres.full
+
+mkfs_opts="-d raid6 -b 1G"
+_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
+
+# -o nospace_cache makes sure data is written to the start position of the data
+# chunk
+_scratch_mount -o nospace_cache
+
+# [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" "$SCRATCH_MNT/foobar" | _filter_xfs_io
+
+_scratch_unmount
+
+stripe_0=`get_physical_stripe0`
+stripe_1=`get_physical_stripe1`
+dev4=`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
+dev3=`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
+
+# step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
+echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
+
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs_io
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs_io
+
+# step 3: read foobar to repair the bitrot
+echo "step 3......repair the bitrot" >> $seqres.full
+_scratch_mount -o nospace_cache
+
+# read the 2nd stripe, i.e. [64K, 128K), to trigger repair
+od -x -j 64K $SCRATCH_MNT/foobar
+
+_scratch_dev_pool_put 
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/155.out b/tests/btrfs/155.out
new file mode 100644
index 0000000..7bac256
--- /dev/null
+++ b/tests/btrfs/155.out
@@ -0,0 +1,10 @@
+QA output created by 155
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 9437184
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 9437184
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0200000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
+*
+0400000
diff --git a/tests/btrfs/group b/tests/btrfs/group
index c98cf82..c84a166 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -157,3 +157,4 @@
 152 auto quick metadata qgroup send
 153 auto quick qgroup
 154 auto quick
+155 auto quick repair
-- 
2.5.0

