Received: from mx2.suse.de ([195.135.220.15]:38708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751693AbdCNRax (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Mar 2017 13:30:53 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH v2] btrfs/139: creation/deletion within qgroup limits
Date: Tue, 14 Mar 2017 12:30:26 -0500
Message-Id: <20170314173026.19401-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

If we create and delete files within the qgroup limits, qg->reserved
(allocations before commits) over-inflates and causes -EDQUOT to
be returned pre-maturely.

Also, 32/64bit data-type exchanges can cause reserved (u64)
to go negative (very large) and -EDQUOT is returned
pre-maturely.

Will be fixed by patches with subjects:
btrfs: Retry after commit on getting EDQUOT
btrfs: Change qgroup_meta_rsv to 64bit

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---

Changes since v1:
 - require_scratch inclusion
 - output of xfs_io programs for a smaller out file
 - Code Comments

 tests/btrfs/139     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/139.out | 16 +++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 96 insertions(+)
 create mode 100755 tests/btrfs/139
 create mode 100644 tests/btrfs/139.out

diff --git a/tests/btrfs/139 b/tests/btrfs/139
new file mode 100755
index 0000000..e930d78
--- /dev/null
+++ b/tests/btrfs/139
@@ -0,0 +1,79 @@
+#! /bin/bash
+# FS QA Test 139
+#
+# Check if btrfs quota limits are not reached when you constantly
+# create and delete files within the exclusive qgroup limits.
+#
+# Finally we create files to exceed the quota.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 SUSE. All Rights Reserved.
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
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+SUBVOL=$SCRATCH_MNT/subvol
+
+_run_btrfs_util_prog subvolume create $SUBVOL
+_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog qgroup limit -e 1G $SUBVOL
+
+
+# Write and delete files within 1G limits, multiple times
+for i in $(seq 1 5); do
+	for j in $(seq 1 240); do
+		$XFS_IO_PROG -f -c "pwrite 0 4m" $SUBVOL/file_$j > /dev/null
+	done
+	rm -f $SUBVOL/file*
+done
+
+# Exceed the limits here
+for j in $(seq 1 8); do
+	$XFS_IO_PROG -f -c "pwrite 0 128m" $SUBVOL/file_$j 2>&1 | _filter_xfs_io | _filter_xfs_io_error
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/139.out b/tests/btrfs/139.out
new file mode 100644
index 0000000..6146844
--- /dev/null
+++ b/tests/btrfs/139.out
@@ -0,0 +1,16 @@
+QA output created by 139
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+pwrite: Disk quota exceeded
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 76a1181..641d826 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -141,3 +141,4 @@
 136 auto convert
 137 auto quick send
 138 auto compress
+139 auto qgroup
-- 
2.10.2

