Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60384 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510AbbDJXlK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 10 Apr 2015 19:41:10 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3ANf9v3015089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2015 19:41:10 -0400
Received: from lenny.home.zabbo.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3ANf9os007272
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2015 19:41:09 -0400
From: Zach Brown <zab@redhat.com>
Subject: [PATCH] generic/326: basic copy_file_range() correctness
Date: Fri, 10 Apr 2015 16:41:08 -0700
Message-Id: <1428709268-27499-1-git-send-email-zab@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Add basic tests for the copy_file_range() syscall that's being
developed.  This relies on having added copy_file_range() support to
xfs_io in xfsprogs.

This is a very rough draft.  Feedback welcome!

Signed-off-by: Zach Brown <zab@redhat.com>
---
 tests/generic/326   | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group |  1 +
 2 files changed, 99 insertions(+)
 create mode 100755 tests/generic/326

diff --git a/tests/generic/326 b/tests/generic/326
new file mode 100755
index 0000000..1fb5ba0
--- /dev/null
+++ b/tests/generic/326
@@ -0,0 +1,98 @@
+#! /bin/bash
+# FS QA Test No. 326
+#
+# Try to test the basic shared behaviour of the file copy offloading
+# syscall. Avoid making assumptions about the capabilities of the
+# underlying storage.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
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
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+src="$TEST_DIR/src"
+dst="$TEST_DIR/dst"
+$XFS_IO_PROG -ftc "pwrite -S 0x12 0 128k" "$src" | _filter_xfs_io
+od -x "$src"
+
+echo "extend destination file"
+$XFS_IO_PROG -ftc "copy_file_range -i $src -s 0 -t 0 $((128 * 1024))" "$dst" \
+	| _filter_xfs_io
+od -x "$dst"
+
+echo "copy into previously written region"
+$XFS_IO_PROG -ft -c "pwrite -S 0xef 0 128k" "$dst" \
+	-c "copy_file_range -i $src -s 0 -t 0 $((128 * 1024))" \
+	| _filter_xfs_io
+od -x "$dst"
+
+echo "copy into fallocate"
+$XFS_IO_PROG -ft -c "falloc 0 128k" "$dst" \
+	-c "copy_file_range -i $src -s 0 -t 0 $((128 * 1024))" \
+	| _filter_xfs_io
+od -x "$dst"
+
+echo "copy from likely sparse source"
+$XFS_IO_PROG -ft -c "pwrite -S 0x56 96k 32k" "$src"  \
+	-c "pwrite -S 0x34 0 32k" | _filter_xfs_io
+$XFS_IO_PROG -ftc "copy_file_range -i $src -s 0 -t 0 $((128 * 1024))" "$dst" \
+	| _filter_xfs_io
+od -x "$dst"
+
+echo "source at eof"
+$XFS_IO_PROG -ftc \
+	"copy_file_range -i $src -s $((128 * 1024)) -t 0 $((128 * 1024))" \
+	"$dst" | _filter_xfs_io
+
+echo "src or dst not regular files"
+$XFS_IO_PROG -ftc "copy_file_range -i /dev/null 1" "$dst" | _filter_xfs_io
+$XFS_IO_PROG -c "copy_file_range -i $src 1" "/dev/null" | _filter_xfs_io
+
+echo "region shouldn't overlap in one file"
+$XFS_IO_PROG -c "copy_file_range -i $src 1" "$src" | _filter_xfs_io
+
+echo "unknown flags fail"
+$XFS_IO_PROG -ftc \
+	"copy_file_range -i $src -s 0 -t 0 4096 -F 0x40000000" "$dst" \
+	| _filter_xfs_io
+
+status=0
+exit $status
diff --git a/tests/generic/group b/tests/generic/group
index 63b883c..a904e17 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -188,3 +188,4 @@
 323 auto aio stress
 324 auto fsr quick
 325 auto quick data log
+326 auto quick
-- 
2.1.0

