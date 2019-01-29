Received: from mx2.suse.de ([195.135.220.15]:45568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727215AbfA2Mcl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Jan 2019 07:32:41 -0500
From: Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 3/3] btrfs: Test if btrfs will report false ENOSPC error balancing small metadata chunk
Date: Tue, 29 Jan 2019 20:32:22 +0800
Message-Id: <20190129123222.8698-3-wqu@suse.com>
In-Reply-To: <20190129123222.8698-1-wqu@suse.com>
References: <20190129123222.8698-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org
Cc: fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

This is a test case for a long existing bug, caused by over-estimated
metadata space_info::bytes_may_use.

There is one proposed patch for btrfs-progs to fix it, titled:
"btrfs-progs: balance: Sync the fs before balancing metadata chunks"

The test case itself is almost the same as btrfs/181, which uses small
files to bump the reserved space to trigger the false alert.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
changelog:
v2:
- Grammar and type fixes.
- Use full subcommand name for 'btrfs' command.
---
 tests/btrfs/182     | 60 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/182.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 63 insertions(+)
 create mode 100755 tests/btrfs/182
 create mode 100644 tests/btrfs/182.out

diff --git a/tests/btrfs/182 b/tests/btrfs/182
new file mode 100755
index 000000000000..2b347011aaa8
--- /dev/null
+++ b/tests/btrfs/182
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 182
+#
+# Test if balance will report false ENOSPC error
+#
+# This is a long existing bug, caused by over-estimated metadata
+# space_info::bytes_may_use.
+# There is one proposed patch for btrfs-progs to fix it, titled:
+# "btrfs-progs: balance: Sync the fs before balancing metadata chunks"
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
+_supported_fs btrfs 
+_supported_os Linux
+_require_scratch
+
+nr_files=1024
+
+_scratch_mkfs > /dev/null
+_scratch_mount
+
+$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" > /dev/null
+
+# Create some small files to take up enough metadata reserved space 
+for ((i = 0; i < $nr_files; i++)) do
+	_pwrite_byte 0xcd 0 1K "$SCRATCH_MNT/subvol/file_$i" > /dev/null
+done
+
+$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" > /dev/null
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/182.out b/tests/btrfs/182.out
new file mode 100644
index 000000000000..53d28e50c68b
--- /dev/null
+++ b/tests/btrfs/182.out
@@ -0,0 +1,2 @@
+QA output created by 182
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 0db485cbe834..e32c84e4b253 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -184,3 +184,4 @@
 179 auto qgroup dangerous
 180 auto quick qgroup limit
 181 auto quick balance
+182 auto quick balance
-- 
2.20.1
