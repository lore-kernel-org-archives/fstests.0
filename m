Received: from mail-wm0-f65.google.com ([74.125.82.65]:33715 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754556AbdIGKC6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 06:02:58 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 7/8] fstests: crash consistency fsx test for cloned files
Date: Thu,  7 Sep 2017 13:03:12 +0300
Message-Id: <1504778593-12071-8-git-send-email-amir73il@gmail.com>
In-Reply-To: <1504778593-12071-1-git-send-email-amir73il@gmail.com>
References: <1504778593-12071-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/502     | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/502.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 144 insertions(+)
 create mode 100755 tests/generic/502
 create mode 100644 tests/generic/502.out

diff --git a/tests/generic/502 b/tests/generic/502
new file mode 100755
index 0000000..96908f5
--- /dev/null
+++ b/tests/generic/502
@@ -0,0 +1,141 @@
+#! /bin/bash
+# FS QA Test No. 502
+#
+# Run fsx with log writes on cloned files to verify power fail safeness.
+#
+#-----------------------------------------------------------------------
+# Copyright (C) 2017 CTERA Networks. All Rights Reserved.
+# Author: Amir Goldstein <amir73il@gmail.com>
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
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_log_writes_cleanup
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/reflink
+. ./common/dmlogwrites
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch_reflink
+_require_cp_reflink
+_require_log_writes
+
+rm -f $seqres.full
+
+check_files()
+{
+	local name=$1
+
+	# Now look for our files
+	for i in $(find $SANITY_DIR -type f | grep $name | grep mark)
+	do
+		local filename=$(basename $i)
+		local mark="${filename##*.}"
+		echo "checking $filename" >> $seqres.full
+		_log_writes_replay_log $filename
+		_scratch_mount
+		local expected_md5=$(_md5_checksum $i)
+		local md5=$(_md5_checksum $SCRATCH_MNT/$name)
+		[ "${md5}" != "${expected_md5}" ] && _fail "$filename md5sum mismatched"
+		_scratch_unmount
+		_check_scratch_fs
+	done
+}
+
+SANITY_DIR=$TEST_DIR/fsxtests
+rm -rf $SANITY_DIR
+mkdir $SANITY_DIR
+
+# Create the log
+_log_writes_init
+
+_log_writes_mkfs >> $seqres.full 2>&1
+
+# Log writes emulates discard support, turn it on for maximum crying.
+_log_writes_mount -o discard
+
+# write testfile index -1 to be cloned to testfile0
+$XFS_IO_PROG -f -c "pwrite -S 0xff 0 256k" -c "fsync" \
+	$SCRATCH_MNT/testfile-1 > /dev/null 2>&1
+
+NUM_FILES=10
+NUM_OPS=10
+FSX_OPTS="-N $NUM_OPS -d -k -P $SANITY_DIR -i $LOGWRITES_DMDEV"
+# Run fsx for a while
+# Set random seeds for fsx runs (0 for timestamp + pid)
+for j in `seq 0 $((NUM_FILES-1))`
+do
+	# clone the clone from prev iteration which may have already mutated
+	_cp_reflink $SCRATCH_MNT/testfile$((j-1)) $SCRATCH_MNT/testfile$j
+	run_check $here/ltp/fsx $FSX_OPTS -S 0 -j $j $SCRATCH_MNT/testfile$j &
+done
+wait
+
+test_md5=()
+for j in `seq 0 $((NUM_FILES-1))`
+do
+	test_md5[$j]=$(_md5_checksum $SCRATCH_MNT/testfile$j)
+done
+
+# Unmount the scratch dir and tear down the log writes target
+_log_writes_mark last
+_log_writes_unmount
+_log_writes_mark end
+_log_writes_remove
+_check_scratch_fs
+
+# check pre umount
+echo "checking pre umount" >> $seqres.full
+_log_writes_replay_log last
+_scratch_mount
+_scratch_unmount
+_check_scratch_fs
+
+for j in `seq 0 $((NUM_FILES-1))`
+do
+	check_files testfile$j
+done
+
+# Check the end
+echo "checking post umount" >> $seqres.full
+_log_writes_replay_log end
+_scratch_mount
+for j in `seq 0 $((NUM_FILES-1))`
+do
+	md5=$(_md5_checksum $SCRATCH_MNT/testfile$j)
+	[ "${md5}" != "${test_md5[$j]}" ] && _fail "testfile$j end md5sum mismatched"
+done
+
+echo "Silence is golden"
+status=0
+exit
+
diff --git a/tests/generic/502.out b/tests/generic/502.out
new file mode 100644
index 0000000..930f6d4
--- /dev/null
+++ b/tests/generic/502.out
@@ -0,0 +1,2 @@
+QA output created by 502
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 1e1b524..4324775 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -459,3 +459,4 @@
 454 auto quick attr
 500 auto log replay
 501 auto quick metadata
+502 auto log replay clone
-- 
2.7.4

