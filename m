Received: from mail-io0-f182.google.com ([209.85.223.182]:47067 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdKAAMU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Oct 2017 20:12:20 -0400
Received: by mail-io0-f182.google.com with SMTP id 101so2664305ioj.3
        for <fstests@vger.kernel.org>; Tue, 31 Oct 2017 17:12:20 -0700 (PDT)
From: harshads <harshads@google.com>
Subject: [PATCH] ext4/030: Ext4 online resize tests.
Date: Tue, 31 Oct 2017 17:11:59 -0700
Message-Id: <20171101001159.88570-1-harshads@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: harshads <harshads@google.com>
List-ID: <fstests@vger.kernel.org>

Add tests for Ext4 online resize feature. Once online resizing with
bigalloc support is merged into Ext4, these tests can be used to
sanitize the working of that feature. In order to test online resizing
with bigalloc, set MKFS_OPTIONS="-O bigalloc -C <cluster_size>" and
run the test.

Signed-off-by: Harshad Shirwadkar <harshads@google.com>
---
 tests/ext4/030     | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/030.out | 21 ++++++++++++
 tests/ext4/group   |  1 +
 3 files changed, 115 insertions(+)
 create mode 100755 tests/ext4/030
 create mode 100644 tests/ext4/030.out

diff --git a/tests/ext4/030 b/tests/ext4/030
new file mode 100755
index 00000000..c958e10c
--- /dev/null
+++ b/tests/ext4/030
@@ -0,0 +1,93 @@
+#! /bin/bash
+# FS QA Test ext4/030
+#
+# Ext4 online resize test.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
+#
+# Author: Harshad Shirwadkar <harshads@google.com>
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
+# get standard environment and checks
+. ./common/rc
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+
+_require_scratch
+rm -f $seqres.full
+TESTDIR="${SCRATCH_MNT}/scratchdir"
+TESTFILE="${TESTDIR}/testfile"
+
+mb2bytes()
+{
+	expr $1 \* 1024 \* 1024
+}
+
+# Takes two arguments: $1 = initial size (mb), $2 = new size (mb).
+work()
+{
+	local original_size=$1
+	local final_size=$2
+
+	echo "+ create scratch fs of size $original_size MB"
+	_scratch_mkfs_sized $(mb2bytes $original_size) 4096 > /dev/null 2>&1
+	dumpe2fs -g "${SCRATCH_DEV}" > /dev/null 2>&1 || \
+		_notrun "dumpe2fs -g not supported"
+
+	echo "+ mount scratch fs"
+	_scratch_mount > /dev/null 2>&1
+
+	echo "+ resize fs to $final_size MB"
+	resize2fs -f "${SCRATCH_DEV}" ${final_size}M >> $seqres.full 2>&1 || \
+		_fail "resize2fs failed"
+
+	echo "+ umount fs"
+	umount "${SCRATCH_MNT}"
+
+	echo "+ check fs"
+	e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || \
+		_fail "fsck should not fail"
+}
+
+## Try resizing to different sizes.
+work 128 1024
+work 1024 2048
+work 1024 4096
+work 1024 5120
+
+status=0
+exit
diff --git a/tests/ext4/030.out b/tests/ext4/030.out
new file mode 100644
index 00000000..14c24cc5
--- /dev/null
+++ b/tests/ext4/030.out
@@ -0,0 +1,21 @@
+QA output created by 030
++ create scratch fs of size 128 MB
++ mount scratch fs
++ resize fs to 1024 MB
++ umount fs
++ check fs
++ create scratch fs of size 1024 MB
++ mount scratch fs
++ resize fs to 2048 MB
++ umount fs
++ check fs
++ create scratch fs of size 1024 MB
++ mount scratch fs
++ resize fs to 4096 MB
++ umount fs
++ check fs
++ create scratch fs of size 1024 MB
++ mount scratch fs
++ resize fs to 5120 MB
++ umount fs
++ check fs
diff --git a/tests/ext4/group b/tests/ext4/group
index 257bb646..f2beeaf8 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -32,6 +32,7 @@
 027 auto quick fsmap
 028 auto quick fsmap
 029 auto quick fsmap
+030 auto ioctl resize
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.15.0.403.gc27cc4dac6-goog

