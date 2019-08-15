Received: from userp2130.oracle.com ([156.151.31.86]:51712 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfHOQgy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Aug 2019 12:36:54 -0400
Date: Thu, 15 Aug 2019 09:34:34 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH RFC 3/2] fstests: check that we can't write to swap files
Message-ID: <20190815163434.GA15186@magnolia>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156588514105.111054.13645634739408399209.stgit@magnolia>
Sender: fstests-owner@vger.kernel.org
To: hch@infradead.org, akpm@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>


From: Darrick J. Wong <darrick.wong@oracle.com>

While active, the media backing a swap file is leased to the kernel.
Userspace has no business writing to it.  Make sure we can't do this.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/717     |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/717.out |    7 ++++++
 tests/generic/718     |   46 ++++++++++++++++++++++++++++++++++++++
 tests/generic/718.out |    5 ++++
 tests/generic/group   |    2 ++
 5 files changed, 120 insertions(+)
 create mode 100755 tests/generic/717
 create mode 100644 tests/generic/717.out
 create mode 100755 tests/generic/718
 create mode 100644 tests/generic/718.out

diff --git a/tests/generic/717 b/tests/generic/717
new file mode 100755
index 00000000..ab12ee4d
--- /dev/null
+++ b/tests/generic/717
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-newer
+# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
+#
+# FS QA Test No. 717
+#
+# Check that we can't modify a file that's an active swap file.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	swapoff $testfile
+	rm -rf $tmp.* $testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs generic
+_require_scratch_swapfile
+
+rm -f $seqres.full
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testfile=$SCRATCH_MNT/$seq.swap
+
+_format_swapfile $testfile 20m
+swapon $testfile 2>&1 | _filter_scratch
+
+# Can we write to it?
+$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $testfile
+$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $testfile
+$XFS_IO_PROG -c 'mmap -rw 64k 64k' -c 'mwrite -S 0x61 64k 64k' $testfile
+
+# Can we change the file size?
+$XFS_IO_PROG -c 'truncate 18m' $testfile
+
+# Can you fallocate the file?
+$XFS_IO_PROG -c 'falloc 0 32m' $testfile
+
+# We test that you can't reflink, dedupe, or copy_file_range into a swapfile
+# in other tests.
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/717.out b/tests/generic/717.out
new file mode 100644
index 00000000..2cd9bcdb
--- /dev/null
+++ b/tests/generic/717.out
@@ -0,0 +1,7 @@
+QA output created by 717
+pwrite: Text file busy
+pwrite: Text file busy
+mmap: Text file busy
+no mapped regions, try 'help mmap'
+ftruncate: Text file busy
+fallocate: Text file busy
diff --git a/tests/generic/718 b/tests/generic/718
new file mode 100755
index 00000000..35cf718f
--- /dev/null
+++ b/tests/generic/718
@@ -0,0 +1,46 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-newer
+# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
+#
+# FS QA Test No. 718
+#
+# Check that we can't modify a block device that's an active swap device.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	swapoff $SCRATCH_DEV
+	rm -rf $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs generic
+_require_scratch_nocheck
+
+rm -f $seqres.full
+
+$MKSWAP_PROG "$SCRATCH_DEV" >> $seqres.full
+swapon $SCRATCH_DEV 2>&1 | _filter_scratch
+
+# Can we write to it?
+$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $SCRATCH_DEV
+$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $SCRATCH_DEV
+$XFS_IO_PROG -c 'mmap -rw 64k 64k' -c 'mwrite -S 0x61 64k 64k' $SCRATCH_DEV
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/718.out b/tests/generic/718.out
new file mode 100644
index 00000000..5cd25b9a
--- /dev/null
+++ b/tests/generic/718.out
@@ -0,0 +1,5 @@
+QA output created by 718
+pwrite: Text file busy
+pwrite: Text file busy
+mmap: Text file busy
+no mapped regions, try 'help mmap'
diff --git a/tests/generic/group b/tests/generic/group
index 003fa963..c58d41e3 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -570,3 +570,5 @@
 565 auto quick copy_range
 715 auto quick rw
 716 auto quick rw
+717 auto quick rw swap
+718 auto quick rw swap
