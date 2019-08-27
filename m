Received: from userp2120.oracle.com ([156.151.31.85]:46712 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfH0ESu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Aug 2019 00:18:50 -0400
Date: Mon, 26 Aug 2019 21:18:16 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH v2] generic: test for failure to unlock inode after chgrp
 fails with EDQUOT
Message-ID: <20190827041816.GB1037528@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, xfs <linux-xfs@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, Salvatore Bonaccorso <carnil@debian.org>, Security Officers <security@kernel.org>, Debian Security Team <team@security.debian.org>, benjamin.moody@gmail.com, Ben Hutchings <benh@debian.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

This is a regression test that checks for xfs drivers that fail to
unlock the inode after changing the group id fails with EDQUOT.  It
pairs with "xfs: fix missing ILOCK unlock when xfs_setattr_nonsize fails
due to EDQUOT".

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v2: add commit id
---
 tests/generic/719     |   59 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/719.out |    2 ++
 tests/generic/group   |    1 +
 3 files changed, 62 insertions(+)
 create mode 100755 tests/generic/719
 create mode 100644 tests/generic/719.out

diff --git a/tests/generic/719 b/tests/generic/719
new file mode 100755
index 00000000..3da2539c
--- /dev/null
+++ b/tests/generic/719
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-newer
+# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
+#
+# FS QA Test No. 719
+#
+# Regression test for chgrp returning to userspace with ILOCK held after a
+# hard quota error.  This causes the filesystem to hang, so it is (for now)
+# a dangerous test.
+#
+# This test goes with commit 1fb254aa983bf ("xfs: fix missing ILOCK unlock when
+# xfs_setattr_nonsize fails due to EDQUOT")
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
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/quota
+. ./common/filter
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs generic
+_require_scratch
+_require_quota
+_require_user
+
+rm -f $seqres.full
+
+_qmount_option "grpquota"
+_scratch_mkfs > $seqres.full
+_qmount
+
+dir="$SCRATCH_MNT/dummy"
+mkdir -p $dir
+chown $qa_user $dir
+$XFS_QUOTA_PROG -x -f -c "limit -g bsoft=100k bhard=100k $qa_user" $SCRATCH_MNT
+
+$XFS_IO_PROG -f -c 'pwrite -S 0x58 0 1m' $dir/foo >> $seqres.full
+chown $qa_user "${dir}/foo"
+su $qa_user -c "chgrp $qa_user ${dir}/foo" 2>&1 | _filter_scratch
+ls -la ${dir} >> $seqres.full
+$XFS_QUOTA_PROG -x -f -c 'report -hag' $SCRATCH_MNT >> $seqres.full
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/719.out b/tests/generic/719.out
new file mode 100644
index 00000000..8f9d51b5
--- /dev/null
+++ b/tests/generic/719.out
@@ -0,0 +1,2 @@
+QA output created by 719
+chgrp: changing group of 'SCRATCH_MNT/dummy/foo': Disk quota exceeded
diff --git a/tests/generic/group b/tests/generic/group
index 2e4a6f79..cd418106 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -568,3 +568,4 @@
 563 auto quick
 564 auto quick copy_range
 565 auto quick copy_range
+719 auto quick quota metadata
