Received: from mx1.redhat.com ([209.132.183.28]:41284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732540AbfIFQxI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Sep 2019 12:53:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 076388980EF
        for <fstests@vger.kernel.org>; Fri,  6 Sep 2019 16:53:08 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] generic/567: test mmap write vs. hole punching
Date: Fri,  6 Sep 2019 18:53:04 +0200
Message-Id: <20190906165304.32066-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

On file systems with a block size smaller than the page size, hole
punching can leave the pages at the beginning and the end of the hole
partially mapped to disk blocks.  Make sure writes to those pages are
handled correctly.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 tests/generic/567     | 65 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/567.out | 19 +++++++++++++
 tests/generic/group   |  1 +
 3 files changed, 85 insertions(+)
 create mode 100755 tests/generic/567
 create mode 100644 tests/generic/567.out

diff --git a/tests/generic/567 b/tests/generic/567
new file mode 100755
index 00000000..bc03e477
--- /dev/null
+++ b/tests/generic/567
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2014 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test No. generic/567
+#
+# Test mapped writes against punch-hole to ensure we get the data
+# correctly written. This can expose data corruption bugs on filesystems
+# where the block size is smaller than the page size.
+#
+# (generic/029 is a similar test but for truncate.)
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
+    cd /
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_MNT/testfile
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+# Punch a hole straddling two pages to check that the mapped write after the
+# hole-punching is correctly handled.
+
+# -c "truncate 12288"
+$XFS_IO_PROG -t -f \
+-c "pwrite -S 0x58 0 12288" \
+-c "mmap -rw 0 12288" \
+-c "mwrite -S 0x5a 2048 8192" \
+-c "fpunch 2048 8192" \
+-c "mwrite -S 0x59 2048 8192" \
+-c "close"      \
+$testfile | _filter_xfs_io
+
+echo "==== Pre-Remount ==="
+hexdump -C $testfile
+_scratch_cycle_mount
+echo "==== Post-Remount =="
+hexdump -C $testfile
+
+status=0
+exit
+
diff --git a/tests/generic/567.out b/tests/generic/567.out
new file mode 100644
index 00000000..8ca73fa9
--- /dev/null
+++ b/tests/generic/567.out
@@ -0,0 +1,19 @@
+QA output created by 567
+wrote 12288/12288 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== Pre-Remount ===
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+*
+00002800  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+00003000
+==== Post-Remount ==
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
+*
+00002800  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+00003000
diff --git a/tests/generic/group b/tests/generic/group
index d26c080f..dd2734bd 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -569,3 +569,4 @@
 564 auto quick copy_range
 565 auto quick copy_range
 566 auto quick quota metadata
+567 auto quick rw
-- 
2.20.1
