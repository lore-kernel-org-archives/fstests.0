Received: from userp1040.oracle.com ([156.151.31.81]:29926 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbdDZV4H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2017 17:56:07 -0400
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH] fstests: regression test for nocsum dio read's repair
Date: Wed, 26 Apr 2017 14:54:39 -0600
Message-Id: <1493240079-812-1-git-send-email-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Commit 2dabb3248453 ("Btrfs: Direct I/O read: Work on sectorsized blocks")
introduced this regression.  It'd cause 'Segmentation fault' error.

The upstream fix is
	Btrfs: fix segment fault when doing dio read

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
 tests/btrfs/142     | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/142.out |  39 +++++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 229 insertions(+)
 create mode 100755 tests/btrfs/142
 create mode 100644 tests/btrfs/142.out

diff --git a/tests/btrfs/142 b/tests/btrfs/142
new file mode 100755
index 0000000..c5fcd22
--- /dev/null
+++ b/tests/btrfs/142
@@ -0,0 +1,189 @@
+#! /bin/bash
+# FS QA Test 142
+#
+# Regression test for btrfs DIO read's repair during read without checksum.
+#
+# Commit 2dabb3248453 ("Btrfs: Direct I/O read: Work on sectorsized blocks")
+# introduced this regression.  It'd cause 'Segmentation fault' error.
+#
+# The upstream fix is
+#	Btrfs: fix segment fault when doing dio read
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
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
+_require_scratch_dev_pool 2
+
+_require_btrfs_command inspect-internal dump-tree
+_require_command "$FILEFRAG_PROG" filefrag
+
+# helpe to convert 'file offset' to btrfs logical offset
+FILEFRAG_FILTER='
+	if (/blocks? of (\d+) bytes/) {
+		$blocksize = $1;
+		next
+	}
+	($ext, $logical, $physical, $length) =
+		(/^\s*(\d+):\s+(\d+)..\s+\d+:\s+(\d+)..\s+\d+:\s+(\d+):/)
+	or next;
+	($flags) = /.*:\s*(\S*)$/;
+	print $physical * $blocksize, "#",
+	      $length * $blocksize, "#",
+	      $logical * $blocksize, "#",
+	      $flags, " "'
+
+# this makes filefrag output script readable by using a perl helper.
+# output is one extent per line, with three numbers separated by '#'
+# the numbers are: physical, length, logical (all in bytes)
+# sample output: "1234#10#5678" -> physical 1234, length 10, logical 5678
+_filter_extents()
+{
+	tee -a $seqres.full | $PERL_PROG -ne "$FILEFRAG_FILTER"
+}
+
+_check_file_extents()
+{
+	cmd="filefrag -v $1"
+	echo "# $cmd" >> $seqres.full
+	out=`$cmd | _filter_extents`
+	if [ -z "$out" ]; then
+		return 1
+	fi
+	echo "after filter: $out" >> $seqres.full
+	echo $out
+	return 0
+}
+
+_check_repair()
+{
+	filter=${1:-cat}
+	dmesg | tac | sed -ne "0,\#run fstests $seqnum at $date_time#p" | tac | $filter | grep -q -e "direct IO failed"
+	if [ $? -eq 0 ]; then
+		echo 1
+	else
+		echo 0
+	fi
+}
+
+_get_physical()
+{
+        # $1 is logical address
+        # print chunk tree and find devid 2 which is $SCRATCH_DEV
+        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) { print $6 }'
+}
+
+
+SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
+
+start_fail()
+{
+	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
+	echo 1 > $DEBUGFS_MNT/fail_make_request/times
+	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
+	echo 1 > $SYSFS_BDEV/make-it-fail
+}
+
+stop_fail()
+{
+	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
+	echo 0 > $DEBUGFS_MNT/fail_make_request/times
+	echo 0 > $SYSFS_BDEV/make-it-fail
+}
+
+_scratch_dev_pool_get 2
+# step 1, create a raid1 btrfs which contains one 128k file.
+echo "step 1......mkfs.btrfs" >>$seqres.full
+
+mkfs_opts="-d raid1"
+_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
+
+# -o nospace_cache makes sure data is written to the start position of the data
+# chunk
+_scratch_mount -o nospace_cache,nodatasum
+
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" | _filter_xfs_io
+
+sync
+
+# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
+# one in $SCRATCH_DEV_POOL
+echo "step 2......corrupt file extent" >>$seqres.full
+
+extents=`_check_file_extents $SCRATCH_MNT/foobar`
+logical_in_btrfs=`echo ${extents} | cut -d '#' -f 1`
+physical_on_scratch=`_get_physical ${logical_in_btrfs}`
+
+_scratch_unmount
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV | _filter_xfs_io
+
+_scratch_mount -o nospace_cache,nodatasum
+
+# step 3, 128k dio read (this read can repair bad copy)
+echo "step 3......repair the bad copy" >>$seqres.full
+
+# since raid1 consists of two copies, and the following read may read the good
+# copy directly, so lets loop 10 times here and discard output that dio reads
+# give
+for i in `seq 1 10`; do
+	# start_fail only fails the following dio read so the repair is
+	# supposed to work.
+	start_fail
+	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null
+	stop_fail
+	repair=`_check_repair`
+	if [ $repair -eq 1 ]; then
+		break
+	fi
+done
+
+_scratch_unmount
+
+# check if the repair works
+$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV | _filter_xfs_io
+
+_scratch_dev_pool_put
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/142.out b/tests/btrfs/142.out
new file mode 100644
index 0000000..ba4cbbc
--- /dev/null
+++ b/tests/btrfs/142.out
@@ -0,0 +1,39 @@
+QA output created by 142
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 244056064
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0e8c0000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0010:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0020:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0030:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0040:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0050:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0060:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0070:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0080:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0090:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c00a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c00b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c00c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c00d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c00e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c00f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0100:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0110:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0120:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0130:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0140:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0150:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0160:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0170:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0180:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c0190:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c01a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c01b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c01c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c01d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c01e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+0e8c01f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+read 512/512 bytes at offset 244056064
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 7b380e5..a4f97cd 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -143,3 +143,4 @@
 139 auto qgroup
 140 auto quick
 141 auto quick
+142 auto quick
-- 
2.5.0

