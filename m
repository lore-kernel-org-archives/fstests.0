Received: from mail-it1-f196.google.com ([209.85.166.196]:35261 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbeKCGjC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Nov 2018 02:39:02 -0400
Received: by mail-it1-f196.google.com with SMTP id p64-v6so5105028itp.0
        for <fstests@vger.kernel.org>; Fri, 02 Nov 2018 14:30:16 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 5/7] btrfs: test swap files on multiple devices
Date: Fri,  2 Nov 2018 14:29:40 -0700
Message-Id: <fdbb983029c8854bcd9eb1ab46450efc167c9bf1.1541193856.git.osandov@fb.com>
In-Reply-To: <cover.1541193856.git.osandov@fb.com>
References: <cover.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Swap files currently need to exist on exactly one device in exactly one
place.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/btrfs/175     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/175.out |  8 +++++
 tests/btrfs/group   |  1 +
 3 files changed, 82 insertions(+)
 create mode 100755 tests/btrfs/175
 create mode 100644 tests/btrfs/175.out

diff --git a/tests/btrfs/175 b/tests/btrfs/175
new file mode 100755
index 00000000..64afc4f0
--- /dev/null
+++ b/tests/btrfs/175
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Facebook.  All Rights Reserved.
+#
+# FS QA Test 175
+#
+# Test swap file activation on multiple devices.
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
+
+rm -f $seqres.full
+
+_supported_fs generic
+_supported_os Linux
+_require_scratch_dev_pool 2
+_require_scratch_swapfile
+
+cycle_swapfile() {
+	local sz=${1:-$(($(get_page_size) * 10))}
+	_format_swapfile "$SCRATCH_MNT/swap" "$sz"
+	swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
+	swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
+}
+
+echo "RAID 1"
+_scratch_pool_mkfs -d raid1 -m raid1 >> $seqres.full 2>&1
+_scratch_mount
+cycle_swapfile
+_scratch_unmount
+
+echo "DUP"
+_scratch_pool_mkfs -d dup -m dup >> $seqres.full 2>&1
+_scratch_mount
+cycle_swapfile
+_scratch_unmount
+
+echo "Single on multiple devices"
+_scratch_pool_mkfs -d single -m raid1 -b $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+# Each device is only 1 GB, so 1.5 GB must be split across multiple devices.
+cycle_swapfile $((3 * 1024 * 1024 * 1024 / 2))
+_scratch_unmount
+
+echo "Single on one device"
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+# Create the swap file, then add the device. That way we know it's all on one
+# device.
+_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
+$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
+swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
+swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/btrfs/175.out b/tests/btrfs/175.out
new file mode 100644
index 00000000..ce2e5992
--- /dev/null
+++ b/tests/btrfs/175.out
@@ -0,0 +1,8 @@
+QA output created by 175
+RAID 1
+swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
+DUP
+swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
+Single on multiple devices
+swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
+Single on one device
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 2e10f7df..b6160b72 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -177,3 +177,4 @@
 172 auto quick punch
 173 auto quick swap
 174 auto quick swap
+175 auto quick swap
-- 
2.19.1
