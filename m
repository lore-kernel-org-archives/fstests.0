Received: from mail-pf0-f177.google.com ([209.85.192.177]:35179 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdAYQof (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Jan 2017 11:44:35 -0500
Received: by mail-pf0-f177.google.com with SMTP id f144so59394274pfa.2
        for <fstests@vger.kernel.org>; Wed, 25 Jan 2017 08:44:35 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2] btrfs: add regression test for setxattr on subvolume directory
Date: Wed, 25 Jan 2017 08:44:01 -0800
Message-Id: <e305204790623c5b7eb39a5f76e091af529c6fa1.1485362533.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

This is a regression test for "Btrfs: disable xattr operations on
subvolume directories". On v4.9, it will result in an aborted
transaction.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Changes since v1: fix executable permissions, use $BTRFS_UTIL_PROG, add
Anand's Reviewed-by.

 tests/btrfs/047     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/047.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 72 insertions(+)
 create mode 100755 tests/btrfs/047
 create mode 100644 tests/btrfs/047.out

diff --git a/tests/btrfs/047 b/tests/btrfs/047
new file mode 100755
index 00000000..411f1aff
--- /dev/null
+++ b/tests/btrfs/047
@@ -0,0 +1,69 @@
+#! /bin/bash
+# FS QA Test 047
+#
+# Test that we can't set xattrs on subvolume placeholder directories.
+# Regression test for Btrfs: disable xattr operations on subvolume directories.
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
+. ./common/attr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs btrfs
+_supported_os Linux
+_require_attrs
+_require_scratch
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/parent" >>$seqres.full
+$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/parent/child" >>$seqres.full
+$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/parent" "$SCRATCH_MNT/snapshot" >>$seqres.full
+
+$SETFATTR_PROG -n user.test -v foo "$SCRATCH_MNT/snapshot/child" |& _filter_scratch
+
+# The original bug resulted in bogus delayed inodes being inserted, so run the
+# delayed inodes by doing a commit.
+$BTRFS_UTIL_PROG filesystem sync "$SCRATCH_MNT" >>$seqres.full
+
+status=0
+exit
diff --git a/tests/btrfs/047.out b/tests/btrfs/047.out
new file mode 100644
index 00000000..48555e90
--- /dev/null
+++ b/tests/btrfs/047.out
@@ -0,0 +1,2 @@
+QA output created by 047
+setfattr: SCRATCH_MNT/snapshot/child: Operation not supported
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 88fb8db4..69451c6b 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -49,6 +49,7 @@
 044 auto quick send
 045 auto quick send
 046 auto quick send
+047 auto quick snapshot attr
 048 auto quick
 049 auto quick
 050 auto quick send
-- 
2.11.0

