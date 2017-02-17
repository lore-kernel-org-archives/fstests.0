Received: from mail-pg0-f54.google.com ([74.125.83.54]:33899 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755590AbdBQGzk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2017 01:55:40 -0500
Received: by mail-pg0-f54.google.com with SMTP id z67so13182079pgb.1
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 22:55:39 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 2/2] btrfs: test decompression in the middle of large extents
Date: Thu, 16 Feb 2017 22:54:52 -0800
Message-Id: <8298fa62e0746a394ee26924ee3c69accd7f1841.1487314416.git.osandov@fb.com>
In-Reply-To: <7e55bbd20c8e6515e0b76b1ee4c348fb6066c502.1487314416.git.osandov@fb.com>
References: <7e55bbd20c8e6515e0b76b1ee4c348fb6066c502.1487314416.git.osandov@fb.com>
In-Reply-To: <7e55bbd20c8e6515e0b76b1ee4c348fb6066c502.1487314416.git.osandov@fb.com>
References: <7e55bbd20c8e6515e0b76b1ee4c348fb6066c502.1487314416.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

This is a regression test for "Btrfs: fix btrfs_decompress_buf2page()".
It fails for zlib on v4.10-rc[1-7].

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Changed from v1:

- Remove from quick group
- Handle compress features in sysfs generically
- Require btrfs property command

 common/btrfs        |  8 +++++
 tests/btrfs/137     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/137.out |  2 ++
 tests/btrfs/group   |  1 +
 4 files changed, 108 insertions(+)
 create mode 100755 tests/btrfs/137
 create mode 100644 tests/btrfs/137.out

diff --git a/common/btrfs b/common/btrfs
index 96c3635b..b342644c 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -364,3 +364,11 @@ _reload_btrfs_ko()
 	modprobe -r btrfs || _fail "btrfs unload failed"
 	modprobe btrfs || _fail "btrfs load failed"
 }
+
+_btrfs_compression_algos()
+{
+	echo zlib
+	for feature in /sys/fs/btrfs/features/compress_*; do
+		echo "${feature#/sys/fs/btrfs/features/compress_}"
+	done
+}
diff --git a/tests/btrfs/137 b/tests/btrfs/137
new file mode 100755
index 00000000..d5e4774b
--- /dev/null
+++ b/tests/btrfs/137
@@ -0,0 +1,97 @@
+#! /bin/bash
+# FS QA Test 137
+#
+# Test decompression in the middle of large extents. Regression test for Linux
+# kernel commit 6e78b3f7a193 ("Btrfs: fix btrfs_decompress_buf2page()").
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Facebook.  All Rights Reserved.
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
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_btrfs_command property
+
+algos=($(_btrfs_compression_algos))
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+# Need 1GB for the uncompressed file plus <1GB for each compressed file.
+_require_fs_space $SCRATCH_MNT $((1024 * 1024 * (1 + ${#algos[@]})))
+
+# Checksum a piece in the middle of the file. This hits the unaligned case that
+# caused the original bug.
+do_csum()
+{
+	dd if="$1" bs=4K skip=555 count=100 2>>$seqres.full| md5sum | cut -d ' ' -f 1
+}
+
+# Create a large, uncompressed (but compressible) file.
+touch "${SCRATCH_MNT}/uncompressed"
+$BTRFS_UTIL_PROG property set "${SCRATCH_MNT}/uncompressed" compression ""
+_ddt of="${SCRATCH_MNT}/uncompressed" bs=1M count=1K 2>&1 | _filter_dd
+
+csum="$(do_csum "${SCRATCH_MNT}/uncompressed")"
+
+for algo in ${algos[@]}; do
+	echo "Testing ${algo}" >> $seqres.full
+
+	# Copy the same data, but with compression enabled.
+	touch "${SCRATCH_MNT}/${algo}"
+	$BTRFS_UTIL_PROG property set "${SCRATCH_MNT}/${algo}" compression "${algo}"
+	dd if="${SCRATCH_MNT}/uncompressed" of="${SCRATCH_MNT}/${algo}" bs=1M 2>&1 | _filter_dd
+
+	# The correct data is likely still cached. Cycle the mount to drop the
+	# cache and start fresh.
+	_scratch_cycle_mount
+
+	# Check the checksum.
+	compressed_csum="$(do_csum "${SCRATCH_MNT}/${algo}")"
+	if [ "${compressed_csum}" != "${csum}" ]; then
+		echo "Checksum mismatch for ${algo} (expected ${csum}, got ${compressed_csum})"
+	fi
+done
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/btrfs/137.out b/tests/btrfs/137.out
new file mode 100644
index 00000000..eb48dd21
--- /dev/null
+++ b/tests/btrfs/137.out
@@ -0,0 +1,2 @@
+QA output created by 137
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index ea88ba4e..a8d1851d 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -139,3 +139,4 @@
 134 auto quick send
 135 auto quick send
 136 auto convert
+137 auto compress
-- 
2.11.1

