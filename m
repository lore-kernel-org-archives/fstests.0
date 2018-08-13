Received: from mx2.suse.de ([195.135.220.15]:56366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbeHMICv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Aug 2018 04:02:51 -0400
From: Qu Wenruo <wqu@suse.com>
Subject: [PATCH] fstests: btrfs: Add test for corrupted childless qgroup numbers
Date: Mon, 13 Aug 2018 13:22:05 +0800
Message-Id: <20180813052205.4408-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This bug is exposed by populating a high level qgroup, and then make it
childless with old qgroup numbers, and finally do rescan.

Normally rescan should zero out all qgroups' accounting number, but due
to a kernel bug which won't mark childless qgroups dirty, their on-disk
data is never updated, thus old numbers remain and cause qgroup
corruption.

Fixed by the following kernel patch:
"btrfs: qgroup: Dirty all qgroups before rescan"

Reported-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
changelog:
v2:
  Change the adjective for the offending group, from "orphan" to
  "childless"
v3:
  Don't use _run_btrfs_util_prog any more, use $BTRFS_UTIL_PROG
  directly.
  Introduce new filter, _filter_btrfs_qgroup_assign_warnings(), to
  handle different possible behaviors of "btrfs qgroup assign".
  Modify golden output to cooperate with above change.
  Add the missing tailing dot for each sentence.
  Fix grammar errors.
---
 common/filter.btrfs |  9 +++++
 tests/btrfs/170     | 87 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/170.out |  2 ++
 tests/btrfs/group   |  1 +
 4 files changed, 99 insertions(+)
 create mode 100755 tests/btrfs/170
 create mode 100644 tests/btrfs/170.out

diff --git a/common/filter.btrfs b/common/filter.btrfs
index aaff2278..faeef7a2 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -88,5 +88,14 @@ _filter_btrfs_prop_error()
 	fi
 }
 
+# filter warning messages caused "btrfs quota assign/remove" command
+# Since qgroup relationship change could cause qgroup inconsistent, it would
+# either trigger a qgroup rescan, or warning message.
+_filter_btrfs_qgroup_assign_warnings()
+{
+	sed -e "/Quota data changed, rescan scheduled/d" \
+	    -e "/quotas may be inconsistent, rescan needed/d"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/btrfs/170 b/tests/btrfs/170
new file mode 100755
index 00000000..08cc8e9b
--- /dev/null
+++ b/tests/btrfs/170
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 170
+#
+# Test if btrfs can clear high level childless qgroup's accounting numbers
+# during rescan.
+#
+# Fixed by the following kernel patch:
+# "btrfs: qgroup: Dirty all qgroups before rescan"
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
+. ./common/filter.btrfs
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
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+
+# Populate the fs
+$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" > /dev/null
+_pwrite_byte 0xcdcd 0 1M "$SCRATCH_MNT/subvol/file1" | _filter_xfs_io > /dev/null
+
+# Ensure that buffered file data is persisted, so we won't have an
+# empty file in the snapshot.
+sync
+$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
+	"$SCRATCH_MNT/snapshot" > /dev/null
+
+
+$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
+$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+
+# Create high level qgroup
+$BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
+
+$BTRFS_UTIL_PROG qgroup assign "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_MNT" \
+	2>&1 | _filter_btrfs_qgroup_assign_warnings
+
+# Above assignment will mark qgroup inconsistent due to the shared extents
+# between subvol/snapshot/high level qgroup, do rescan here.
+$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+
+# Now remove the qgroup relationship and make 1/0 childless
+# Due to the shared extent outside of 1/0, we will mark qgroup inconsistent
+# and keep the number of qgroup 1/0.
+$BTRFS_UTIL_PROG qgroup remove "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_MNT" \
+	2>&1 | _filter_btrfs_qgroup_assign_warnings
+
+# Above removal also marks qgroup inconsistent, rescan again
+$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+
+# After the test, btrfs check will verify qgroup numbers to catch any
+# corruption.
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
new file mode 100644
index 00000000..f37552df
--- /dev/null
+++ b/tests/btrfs/170.out
@@ -0,0 +1,2 @@
+QA output created by 170
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index b616c73d..339c9771 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -172,3 +172,4 @@
 167 auto quick replace volume
 168 auto quick send
 169 auto quick send
+170 auto quick qgroup
-- 
2.18.0
