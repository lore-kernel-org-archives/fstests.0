Received: from mail-pg0-f48.google.com ([74.125.83.48]:35210 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPVYn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Apr 2018 17:24:43 -0400
Received: by mail-pg0-f48.google.com with SMTP id j3so4402781pgf.2
        for <fstests@vger.kernel.org>; Mon, 16 Apr 2018 14:24:42 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] generic: test exceeding max file size via INSERT_RANGE
Date: Mon, 16 Apr 2018 14:24:35 -0700
Message-Id: <20180416212435.203505-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Note: this test will fail on ext4 and xfs until the fixes are applied.

-----8<-----

Test how the "insert range" fallocate operation interacts with the
maximum file size (s_maxbytes).

- Shift extents past the max file size (exposes an ext4 bug).
- Increase i_size past the max file size (exposes an xfs bug).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/484     | 115 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/484.out |   4 ++
 tests/generic/group   |   1 +
 3 files changed, 120 insertions(+)
 create mode 100755 tests/generic/484
 create mode 100644 tests/generic/484.out

diff --git a/tests/generic/484 b/tests/generic/484
new file mode 100755
index 00000000..7b40b3c3
--- /dev/null
+++ b/tests/generic/484
@@ -0,0 +1,115 @@
+#! /bin/bash
+# FS QA Test No. 484
+#
+# Regression test for:
+#    ???????????? ("ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS")
+#    ???????????? ("xfs: prevent creating negative-sized file via INSERT_RANGE")
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Google, Inc.  All Rights Reserved.
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
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $testfile
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
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_math
+_require_xfs_io_command "falloc" "-k"
+_require_xfs_io_command "finsert"
+_require_xfs_io_command "truncate"
+
+# Get the maximum size of a file in $TEST_DIR (s_maxbytes).  On ext4 this will
+# be UINT32_MAX * block_size, but other filesystems may allow up to LLONG_MAX.
+get_max_file_size()
+{
+	local testfile=$TEST_DIR/maxfilesize.$seq
+	local l=0
+	local r=9223372036854775807 # LLONG_MAX
+
+	rm -f $testfile
+	while (( l < r )); do
+		# Use _math() to avoid signed integer overflow.
+		local m=$(_math "($l + $r + 1) / 2")
+		if $XFS_IO_PROG -f -c "truncate $m" $testfile \
+			|& grep -q 'File too large'
+		then
+			r=$(( m - 1 ))
+		else
+			l=$m
+		fi
+	done
+	echo $l
+}
+
+block_size=$(_get_block_size $TEST_DIR)
+max_file_size=$(get_max_file_size)
+max_blocks=$((max_file_size / block_size))
+testfile=$TEST_DIR/testfile.$seq
+
+echo "# With KEEP_SIZE"
+rm -f "$testfile"
+
+# Add an extent at the beginning of the file.  With ext4, this is needed to
+# reproduce the bug where the extents appear out of order later.
+$XFS_IO_PROG -f -c "falloc 0 $((2 * block_size))" "$testfile"
+
+# Add an extent just below s_maxbytes, without changing i_size (i.e. with -k).
+# The out-of-order extents bug can't be reproduced if i_size is changed, because
+# then the range insertion fails due to the new i_size being > s_maxbytes.
+$XFS_IO_PROG -c "falloc -k $(( (max_blocks - 1) * $block_size )) $block_size" \
+	"$testfile"
+
+# Insert an extent at the beginning of the file.  With the ext4 bug, this caused
+# the logical block number of the extent just below s_maxbytes to wrap around,
+# causing the extents to get out of order, causing corruption detected by
+# e2fsck.  With the fix, the range insertion fails with EINVAL.  Though, with
+# xfs and f2fs the insertion succeeds, resulting in extents beyond s_maxbytes,
+# but there is no wraparound -- which is arguably okay.  So we allow either
+# behavior and just rely on fsck detecting if something went wrong.
+$XFS_IO_PROG -c "finsert 0 $((2 * block_size))" "$testfile" &>>$seqres.full
+
+# Also do the same test, but with changing i_size (i.e. without -k).  The
+# insertion should fail with EFBIG.  This exposed an XFS bug where i_size + len
+# underwent signed overflow, resulting in a negative-sized file.
+echo "# Without KEEP_SIZE"
+rm -f "$testfile"
+$XFS_IO_PROG -f -c "falloc 0 $((2 * block_size))" "$testfile"
+$XFS_IO_PROG -c "falloc $(( (max_blocks - 1) * $block_size )) $block_size" \
+	"$testfile"
+$XFS_IO_PROG -c "finsert 0 $((2 * block_size))" "$testfile"
+
+status=0
+exit
diff --git a/tests/generic/484.out b/tests/generic/484.out
new file mode 100644
index 00000000..4def4fc0
--- /dev/null
+++ b/tests/generic/484.out
@@ -0,0 +1,4 @@
+QA output created by 484
+# With KEEP_SIZE
+# Without KEEP_SIZE
+fallocate: File too large
diff --git a/tests/generic/group b/tests/generic/group
index ea8e51b3..3f93dc4d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -486,3 +486,4 @@
 481 auto quick log metadata
 482 auto metadata replay
 483 auto quick log metadata
+484 auto quick insert
-- 
2.17.0.484.g0c8726318c-goog

