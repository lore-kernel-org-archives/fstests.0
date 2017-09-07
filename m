Received: from mail-wr0-f194.google.com ([209.85.128.194]:38785 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754523AbdIGKCz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 06:02:55 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 5/8] fstests: crash consistency fsx test using dm-log-writes
Date: Thu,  7 Sep 2017 13:03:10 +0300
Message-Id: <1504778593-12071-6-git-send-email-amir73il@gmail.com>
In-Reply-To: <1504778593-12071-1-git-send-email-amir73il@gmail.com>
References: <1504778593-12071-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Cherry-picked the test from commit 70d41e17164b
in Josef Bacik's fstests tree (https://github.com/josefbacik/fstests).
Quoting from Josef's commit message:

  The test just runs some ops and exits, then finds all of the good buffers
  in the directory we provided and:
  - replays up to the mark given
  - mounts the file system and compares the md5sum
  - unmounts and fsck's to check for metadata integrity

  dm-log-writes will pretend to do discard and the replay-log tool will
  replay it properly depending on the underlying device, either by writing
  0's or actually calling the discard ioctl, so I've enabled discard in the
  test for maximum fun.

[Amir:]
- Removed unneeded _test_falloc_support dynamic FSX_OPTS
- Fold repetitions into for loops
- Added place holders for using constant random seeds
- Add pre umount checkpint
- Add test to new 'replay' group
- Address review comments by Eryu Guan

Cc: Josef Bacik <jbacik@fb.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/500     | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/500.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 141 insertions(+)
 create mode 100755 tests/generic/500
 create mode 100644 tests/generic/500.out

diff --git a/tests/generic/500 b/tests/generic/500
new file mode 100755
index 0000000..fd4d6ec
--- /dev/null
+++ b/tests/generic/500
@@ -0,0 +1,138 @@
+#! /bin/bash
+# FS QA Test No. 500
+#
+# Run fsx with log writes to verify power fail safeness.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Facebook. All Rights Reserved.
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
+. ./common/dmlogwrites
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch_nocheck
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
+NUM_FILES=4
+NUM_OPS=200
+FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
+# Set random seeds for fsx runs (0 for timestamp + pid)
+# When test failure is detected, check the seed values printed
+# by fsx processes to $seqres.full and set them in this array
+# to repeat the same fsx runs
+seeds=(0 0 0 0)
+# Run fsx for a while
+for j in `seq 0 $((NUM_FILES-1))`
+do
+	run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
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
+_scratch_unmount
+_check_scratch_fs
+
+echo "Silence is golden"
+status=0
+exit
+
diff --git a/tests/generic/500.out b/tests/generic/500.out
new file mode 100644
index 0000000..883b2ca
--- /dev/null
+++ b/tests/generic/500.out
@@ -0,0 +1,2 @@
+QA output created by 500
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 1894de0..c857153 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -457,3 +457,4 @@
 452 auto quick
 453 auto quick dir
 454 auto quick attr
+500 auto log replay
-- 
2.7.4

