Received: from mx1.redhat.com ([209.132.183.28]:57986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbfCYRR1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Mar 2019 13:17:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C000A83F3C
        for <fstests@vger.kernel.org>; Mon, 25 Mar 2019 17:17:26 +0000 (UTC)
Received: from bfoster.bos.redhat.com (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77B1564280
        for <fstests@vger.kernel.org>; Mon, 25 Mar 2019 17:17:26 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH v2] generic: test stale data exposure after writeback crash
Date: Mon, 25 Mar 2019 13:17:25 -0400
Message-Id: <20190325171725.55069-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

XFS has historically had a stale data exposure window if a crash
occurs after a delalloc->physical extent conversion but before
writeback completes to the associated extent. While this should be a
rare occurrence in production environments due to typical writeback
ordering and such, it is not guaranteed in all cases until data
extents are initialized as unwritten (or otherwise zeroed) before
they are written.

Add a test that performs selective writeback ordering to reproduce
stale data exposure after a crash. Note that this test currently
fails on XFS.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

v2:
- Use larger write offsets to cover 64k page systems.
- Change magic output to only fail on stale data exposure.
- Add to shutdown group.
v1: https://marc.info/?l=fstests&m=155292973818110&w=2

 tests/generic/999     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  3 ++
 tests/generic/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..ee2260c8
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 999
+#
+# Test a some write patterns for stale data exposure after a crash.  XFS is
+# historically susceptible to this problem in the window between delalloc to
+# physical extent conversion and writeback completion.
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_scratch_shutdown
+
+# create a small fs and initialize free blocks with a unique pattern
+_scratch_mkfs_sized $((1024 * 1024 * 100)) >> $seqres.full 2>&1
+_scratch_mount
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 100m" -c fsync $SCRATCH_MNT/spc \
+	>> $seqres.full 2>&1
+rm -f $SCRATCH_MNT/spc
+$XFS_IO_PROG -c fsync $SCRATCH_MNT
+
+# Write a couple files with particular writeback sequences. The first writes a
+# delalloc extent and triggers writeback on the last page. The second triggers
+# post-eof preallocation (on XFS), write extends into the preallocation and
+# triggers writeback of the last written page.
+$XFS_IO_PROG -fc "pwrite 0 256k" -c "sync_range -w 252k 4k" \
+	-c "sync_range -a 252k 4k" $SCRATCH_MNT/file.1 >> $seqres.full 2>&1
+$XFS_IO_PROG -fc "pwrite 0 260k" -c fsync -c "pwrite 1536k 4k" \
+	-c "sync_range -w 1536k 4k" -c "sync_range -a 1536k 4k" \
+	$SCRATCH_MNT/file.2 >> $seqres.full 2>&1
+
+# Shut down before any other writeback completes. Flush the log to persist inode
+# size updates.
+_scratch_shutdown -f
+
+# Now search both files for stale bytes. The region prior to the last page in
+# the first file should be zero filled. The region between the two writes to the
+# second file should also be zero filled.
+_scratch_cycle_mount
+echo file.1 | tee -a $seqres.full
+hexdump $SCRATCH_MNT/file.1 | tee -a $seqres.full | grep ab
+echo file.2 | tee -a $seqres.full
+hexdump $SCRATCH_MNT/file.2 | tee -a $seqres.full | grep ab
+
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..4560af3c
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,3 @@
+QA output created by 999
+file.1
+file.2
diff --git a/tests/generic/group b/tests/generic/group
index 78b9b45d..1c39ea73 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -538,3 +538,4 @@
 533 auto quick attr
 534 auto quick log
 535 auto quick log
+999 auto quick rw shutdown
-- 
2.17.2
