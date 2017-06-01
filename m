Received: from mx2.suse.de ([195.135.220.15]:35936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751083AbdFATDy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 1 Jun 2017 15:03:54 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19223AAB4
        for <fstests@vger.kernel.org>; Thu,  1 Jun 2017 19:03:53 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH] btrfs/144: quota exhausts prematurely with direct I/O
Date: Thu,  1 Jun 2017 14:03:48 -0500
Message-Id: <20170601190348.7617-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

While performing direct I/O in small blocksizes, the
quota gets exhausted prematurely. In the test, we are
trying to create ~180M file with a block size of 512 bytes
using direct I/O on a subvolume which is allocated 200M.

This test is currently failing.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 tests/btrfs/144     | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/144.out |  3 +++
 tests/btrfs/group   |  1 +
 3 files changed, 74 insertions(+)
 create mode 100755 tests/btrfs/144
 create mode 100644 tests/btrfs/144.out

diff --git a/tests/btrfs/144 b/tests/btrfs/144
new file mode 100755
index 00000000..34156716
--- /dev/null
+++ b/tests/btrfs/144
@@ -0,0 +1,70 @@
+#! /bin/bash
+# FS QA Test 144
+#
+# Check if btrfs quota limits are not reached when direct writes
+# are performed in small blocks.
+#
+# This test is currently failing.
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
+_run_btrfs_util_prog qgroup limit -e 200M $SUBVOL
+
+
+# Direct write file within 200M limits
+
+dd if=/dev/zero of=$SUBVOL/file1 count=36000 bs=512 oflag=direct 
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/144.out b/tests/btrfs/144.out
new file mode 100644
index 00000000..49244bdb
--- /dev/null
+++ b/tests/btrfs/144.out
@@ -0,0 +1,3 @@
+QA output created by 144
+36000+0 records in
+36000+0 records out
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 6f19619e..1de7c161 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -145,3 +145,4 @@
 141 auto quick
 142 auto quick
 143 auto quick
+144 auto quick qgroup
-- 
2.12.3

