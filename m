Received: from mail-it1-f196.google.com ([209.85.166.196]:36144 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbeKCGjC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Nov 2018 02:39:02 -0400
Received: by mail-it1-f196.google.com with SMTP id w7-v6so5099024itd.1
        for <fstests@vger.kernel.org>; Fri, 02 Nov 2018 14:30:15 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 4/7] btrfs: test invalid operations on a swap file
Date: Fri,  2 Nov 2018 14:29:39 -0700
Message-Id: <ef3cf56dce9333158dc8e60d914dbbfad8a4dbe8.1541193856.git.osandov@fb.com>
In-Reply-To: <cover.1541193856.git.osandov@fb.com>
References: <cover.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Btrfs forbids some operations which should not be done on a swap file.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/btrfs/174     | 66 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/174.out | 10 +++++++
 tests/btrfs/group   |  1 +
 3 files changed, 77 insertions(+)
 create mode 100755 tests/btrfs/174
 create mode 100644 tests/btrfs/174.out

diff --git a/tests/btrfs/174 b/tests/btrfs/174
new file mode 100755
index 00000000..a26e6669
--- /dev/null
+++ b/tests/btrfs/174
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Facebook.  All Rights Reserved.
+#
+# FS QA Test 174
+#
+# Test restrictions on operations that can be done on an active swap file
+# specific to Btrfs.
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
+$BTRFS_UTIL_PROG subvol create "$SCRATCH_MNT/swapvol" >> $seqres.full
+swapfile="$SCRATCH_MNT/swapvol/swap"
+_format_swapfile "$swapfile" $(($(get_page_size) * 10))
+swapon "$swapfile"
+
+# Turning off nowcow doesn't do anything because the file is not empty, not
+# because the file is a swap file, but make sure this works anyways.
+echo "Disable nocow"
+$CHATTR_PROG -C "$swapfile"
+lsattr -l "$swapfile" | _filter_scratch | _filter_spaces
+
+# Compression we reject outright.
+echo "Enable compression"
+$CHATTR_PROG +c "$swapfile" 2>&1 | grep -o "Text file busy"
+lsattr -l "$swapfile" | _filter_scratch | _filter_spaces
+
+echo "Snapshot"
+$BTRFS_UTIL_PROG subvol snap "$SCRATCH_MNT/swapvol" \
+	"$SCRATCH_MNT/swapsnap" 2>&1 | grep -o "Text file busy"
+
+echo "Defrag"
+# We pass the -c (compress) flag to force defrag even if the file isn't
+# fragmented.
+$BTRFS_UTIL_PROG filesystem defrag -c "$swapfile" 2>&1 | grep -o "Text file busy"
+
+swapoff "$swapfile"
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/btrfs/174.out b/tests/btrfs/174.out
new file mode 100644
index 00000000..bc24f1fb
--- /dev/null
+++ b/tests/btrfs/174.out
@@ -0,0 +1,10 @@
+QA output created by 174
+Disable nocow
+SCRATCH_MNT/swapvol/swap No_COW
+Enable compression
+Text file busy
+SCRATCH_MNT/swapvol/swap No_COW
+Snapshot
+Text file busy
+Defrag
+Text file busy
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3525014f..2e10f7df 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -176,3 +176,4 @@
 171 auto quick qgroup
 172 auto quick punch
 173 auto quick swap
+174 auto quick swap
-- 
2.19.1
