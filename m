Received: from mail-it1-f195.google.com ([209.85.166.195]:40608 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbeKCGjA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Nov 2018 02:39:00 -0400
Received: by mail-it1-f195.google.com with SMTP id e11so1798373itl.5
        for <fstests@vger.kernel.org>; Fri, 02 Nov 2018 14:30:13 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 3/7] btrfs: test swap file activation restrictions
Date: Fri,  2 Nov 2018 14:29:38 -0700
Message-Id: <9eeea2eecff0b9fad27f49c082e987232edb40c0.1541193856.git.osandov@fb.com>
In-Reply-To: <cover.1541193856.git.osandov@fb.com>
References: <cover.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Swap files on Btrfs have some restrictions not applicable to other
filesystems.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/btrfs/173     | 55 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/173.out |  5 +++++
 tests/btrfs/group   |  1 +
 3 files changed, 61 insertions(+)
 create mode 100755 tests/btrfs/173
 create mode 100644 tests/btrfs/173.out

diff --git a/tests/btrfs/173 b/tests/btrfs/173
new file mode 100755
index 00000000..665bec39
--- /dev/null
+++ b/tests/btrfs/173
@@ -0,0 +1,55 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Facebook.  All Rights Reserved.
+#
+# FS QA Test 173
+#
+# Test swap file activation restrictions specific to Btrfs.
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
+_require_scratch_swapfile
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+echo "COW file"
+# We can't use _format_swapfile because we don't want chattr +C, and we can't
+# unset it after the swap file has been created.
+rm -f "$SCRATCH_MNT/swap"
+touch "$SCRATCH_MNT/swap"
+chmod 0600 "$SCRATCH_MNT/swap"
+_pwrite_byte 0x61 0 $(($(get_page_size) * 10)) "$SCRATCH_MNT/swap" >> $seqres.full
+mkswap "$SCRATCH_MNT/swap" >> $seqres.full
+swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
+swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
+
+echo "Compressed file"
+rm -f "$SCRATCH_MNT/swap"
+_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+$CHATTR_PROG +c "$SCRATCH_MNT/swap"
+swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
+swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
+
+status=0
+exit
diff --git a/tests/btrfs/173.out b/tests/btrfs/173.out
new file mode 100644
index 00000000..6d7856bf
--- /dev/null
+++ b/tests/btrfs/173.out
@@ -0,0 +1,5 @@
+QA output created by 173
+COW file
+swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
+Compressed file
+swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
diff --git a/tests/btrfs/group b/tests/btrfs/group
index a490d7eb..3525014f 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -175,3 +175,4 @@
 170 auto quick snapshot
 171 auto quick qgroup
 172 auto quick punch
+173 auto quick swap
-- 
2.19.1
