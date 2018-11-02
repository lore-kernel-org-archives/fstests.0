Received: from mail-it1-f195.google.com ([209.85.166.195]:40617 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeKCGjF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Nov 2018 02:39:05 -0400
Received: by mail-it1-f195.google.com with SMTP id e11so1798597itl.5
        for <fstests@vger.kernel.org>; Fri, 02 Nov 2018 14:30:18 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 7/7] btrfs: test balance and resize with an active swap file
Date: Fri,  2 Nov 2018 14:29:42 -0700
Message-Id: <e6656ec218c973d548803ed50a45c8d3f81fe388.1541193856.git.osandov@fb.com>
In-Reply-To: <cover.1541193856.git.osandov@fb.com>
References: <cover.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Make sure we don't shrink the device past an active swap file, but allow
shrinking otherwise, as well as growing and balance.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/btrfs/177     | 64 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/177.out |  6 +++++
 tests/btrfs/group   |  1 +
 3 files changed, 71 insertions(+)
 create mode 100755 tests/btrfs/177
 create mode 100644 tests/btrfs/177.out

diff --git a/tests/btrfs/177 b/tests/btrfs/177
new file mode 100755
index 00000000..12dad8fc
--- /dev/null
+++ b/tests/btrfs/177
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Facebook.  All Rights Reserved.
+#
+# FS QA Test 177
+#
+# Test relocation (balance and resize) with an active swap file.
+#
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
+. ./common/rc
+. ./common/filter
+. ./common/btrfs
+
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch_swapfile
+
+swapfile="$SCRATCH_MNT/swap"
+
+# First, create a 1GB filesystem and fill it up.
+_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+dd if=/dev/zero of="$SCRATCH_MNT/fill" bs=1024k >> $seqres.full 2>&1
+# Now add more space and create a swap file. We know that the first 1GB of the
+# filesystem was used, so the swap file must be in the new part of the
+# filesystem.
+$BTRFS_UTIL_PROG filesystem resize 2G "$SCRATCH_MNT" | _filter_scratch
+_format_swapfile "$swapfile" $((32 * 1024 * 1024))
+swapon "$swapfile"
+# Add even more space which we know is unused.
+$BTRFS_UTIL_PROG filesystem resize 3G "$SCRATCH_MNT" | _filter_scratch
+# Free up the first 1GB of the filesystem.
+rm -f "$SCRATCH_MNT/fill"
+# Get rid of empty block groups and also make sure that balance skips block
+# groups containing active swap files.
+_run_btrfs_balance_start "$SCRATCH_MNT"
+# Shrink away the unused space.
+$BTRFS_UTIL_PROG filesystem resize 2G "$SCRATCH_MNT" | _filter_scratch
+# Try to shrink away the area occupied by the swap file, which should fail.
+$BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
+swapoff "$swapfile"
+# It should work again after swapoff.
+$BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" | _filter_scratch
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/btrfs/177.out b/tests/btrfs/177.out
new file mode 100644
index 00000000..6ced01da
--- /dev/null
+++ b/tests/btrfs/177.out
@@ -0,0 +1,6 @@
+QA output created by 177
+Resize 'SCRATCH_MNT' of '2G'
+Resize 'SCRATCH_MNT' of '3G'
+Resize 'SCRATCH_MNT' of '2G'
+Text file busy
+Resize 'SCRATCH_MNT' of '1G'
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3562420b..0b62e58a 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -179,3 +179,4 @@
 174 auto quick swap
 175 auto quick swap
 176 auto quick swap
+177 auto quick swap
-- 
2.19.1
