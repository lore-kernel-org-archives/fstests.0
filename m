Received: from mail-wm0-f41.google.com ([74.125.82.41]:36513 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdCAOLs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Mar 2017 09:11:48 -0500
Received: by mail-wm0-f41.google.com with SMTP id n11so197254wma.1
        for <fstests@vger.kernel.org>; Wed, 01 Mar 2017 06:11:14 -0800 (PST)
From: Nave Vardy <nave.vardy@plexistor.com>
Subject: [PATCH v2] generic/414: reflink concurrent operations
Date: Wed,  1 Mar 2017 16:10:34 +0200
Message-Id: <1488377434-12064-1-git-send-email-nave.vardy@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Nave Vardy <nave.vardy@plexistor.com>
List-ID: <fstests@vger.kernel.org>

reflink: concurrent operations test

perform read operation on the target file while
doing write or fpunch operations on the reflinks.

Signed-off-by: Nave Vardy <nave.vardy@plexistor.com>
---

This is the V2 of [PATCH] generic/409: reflink concurrent operations

v2:
 - change file's permissions to 755
 - use _require_fs_space()
 - use _get_block_size() instead of hard-coded 4096
 - use _cp_reflink instead of cp --reflink
 - increase loop concurrency by doing more preads from the target file
 - remove test from group quick

 tests/generic/414     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/414.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 100 insertions(+)
 create mode 100755 tests/generic/414
 create mode 100644 tests/generic/414.out

diff --git a/tests/generic/414 b/tests/generic/414
new file mode 100755
index 0000000..d3c368b
--- /dev/null
+++ b/tests/generic/414
@@ -0,0 +1,97 @@
+#!/bin/bash
+# FS QA Test No. 414
+#
+# test for races between write or fpunch operations on reflinked files
+# to read operations on the target file
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (c) 2017 Plexistor Ltd. All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=0    # success is the default!
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
+. ./common/reflink
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch_reflink
+_require_cp_reflink
+_require_fs_space $SCRATCH_MNT $((250 * 1024))
+
+_scratch_mkfs_sized $((250 * 1024 ** 2)) >> $seqres.full 2>&1 \
+					|| _fail "mkfs failed"
+_scratch_mount || _fail "mount failed"
+
+echo "Silence is golden"
+
+workfile=${SCRATCH_MNT}/workfile
+light_clone=${SCRATCH_MNT}/light_clone
+
+file_size=$((10 * 1024 * 1024))
+bs=`_get_block_size $SCRATCH_MNT`
+block_num=$((file_size / bs))
+reflinks_num=20
+
+$XFS_IO_PROG -f -c "pwrite 0 $file_size" $workfile >> $seqres.full
+
+for ((i=1; i<=reflinks_num; i++));
+do
+	_cp_reflink $workfile ${light_clone}_$i
+done
+
+#for each block simultaneously pwrite (or fpunch) all reflinks
+#while performing pread from the targted file
+for ((block_index=0; block_index<block_num; block_index++));
+do
+	for ((i=1; i<=reflinks_num; i++));
+	do
+		$XFS_IO_PROG -c "pread $((block_index * bs)) $bs" \
+					$workfile >> $seqres.full &
+		if [ $((block_index % 2)) -eq 0 ]; then
+			$XFS_IO_PROG -c "pwrite $((block_index * bs)) $bs" \
+					${light_clone}_$i  >> $seqres.full &
+		else
+			$XFS_IO_PROG -c "fpunch $((block_index * bs)) $bs" \
+					${light_clone}_$i >> $seqres.full &
+		fi
+	done
+	# wait for all threads to join before moving to next block
+	wait
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/414.out b/tests/generic/414.out
new file mode 100644
index 0000000..57685d3
--- /dev/null
+++ b/tests/generic/414.out
@@ -0,0 +1,2 @@
+QA output created by 414
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index bd358d5..be77180 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -416,3 +416,4 @@
 411 auto quick mount
 412 auto quick metadata
 413 auto quick
+414 auto clone
-- 
2.5.5

