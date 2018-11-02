Received: from mail-it1-f193.google.com ([209.85.166.193]:51327 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeKCGjE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Nov 2018 02:39:04 -0400
Received: by mail-it1-f193.google.com with SMTP id h13so5119610itl.1
        for <fstests@vger.kernel.org>; Fri, 02 Nov 2018 14:30:17 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 6/7] btrfs: test device add/remove/replace with an active swap file
Date: Fri,  2 Nov 2018 14:29:41 -0700
Message-Id: <e25fbb2fa868368febd346598a395fbe1f56f8e7.1541193856.git.osandov@fb.com>
In-Reply-To: <cover.1541193856.git.osandov@fb.com>
References: <cover.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Make sure that we don't remove or replace a device with an active swap
file but can add, remove, and replace other devices.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/btrfs/176     | 82 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/176.out |  5 +++
 tests/btrfs/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/btrfs/176
 create mode 100644 tests/btrfs/176.out

diff --git a/tests/btrfs/176 b/tests/btrfs/176
new file mode 100755
index 00000000..1e576149
--- /dev/null
+++ b/tests/btrfs/176
@@ -0,0 +1,82 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Facebook.  All Rights Reserved.
+#
+# FS QA Test 176
+#
+# Test device remove/replace with an active swap file.
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
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch_dev_pool 3
+_require_scratch_swapfile
+
+# We check the filesystem manually because we move devices around.
+rm -f "${RESULT_DIR}/require_scratch"
+
+scratch_dev1="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $1 }')"
+scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
+scratch_dev3="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $3 }')"
+
+echo "Remove device"
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
+swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
+# We know the swap file is on device 1 because we added device 2 after it was
+# already created.
+$BTRFS_UTIL_PROG device delete "$scratch_dev1" "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
+# Deleting/readding device 2 should still work.
+$BTRFS_UTIL_PROG device delete "$scratch_dev2" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
+swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
+# Deleting device 1 should work again after swapoff.
+$BTRFS_UTIL_PROG device delete "$scratch_dev1" "$SCRATCH_MNT"
+_scratch_unmount
+_check_scratch_fs "$scratch_dev2"
+
+echo "Replace device"
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
+swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
+# Again, we know the swap file is on device 1.
+$BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev3" "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
+# Replacing device 2 should still work.
+$BTRFS_UTIL_PROG replace start -fB "$scratch_dev2" "$scratch_dev3" "$SCRATCH_MNT"
+swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
+# Replacing device 1 should work again after swapoff.
+$BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev2" "$SCRATCH_MNT"
+_scratch_unmount
+_check_scratch_fs "$scratch_dev2"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/176.out b/tests/btrfs/176.out
new file mode 100644
index 00000000..5c99e0fd
--- /dev/null
+++ b/tests/btrfs/176.out
@@ -0,0 +1,5 @@
+QA output created by 176
+Remove device
+Text file busy
+Replace device
+Text file busy
diff --git a/tests/btrfs/group b/tests/btrfs/group
index b6160b72..3562420b 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -178,3 +178,4 @@
 173 auto quick swap
 174 auto quick swap
 175 auto quick swap
+176 auto quick swap
-- 
2.19.1
