Received: from aserp2120.oracle.com ([141.146.126.78]:45504 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389534AbfHWD6F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Aug 2019 23:58:05 -0400
Date: Thu, 22 Aug 2019 20:57:34 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] generic: test for failure to unlock inode after chgrp fails
 with EDQUOT
Message-ID: <20190823035734.GH1037350@magnolia>
References: <20190823035528.GH1037422@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823035528.GH1037422@magnolia>
Sender: fstests-owner@vger.kernel.org
To: xfs <linux-xfs@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, Salvatore Bonaccorso <carnil@debian.org>, Security Officers <security@kernel.org>, Debian Security Team <team@security.debian.org>, benjamin.moody@gmail.com, Ben Hutchings <benh@debian.org>, Christoph Hellwig <hch@infradead.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

This is a regression test that checks for xfs drivers that fail to
unlock the inode after changing the group id fails with EDQUOT.  It
pairs with "xfs: fix missing ILOCK unlock when xfs_setattr_nonsize fails
due to EDQUOT".

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/719     |   56 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/719.out |    2 ++
 tests/generic/group   |    1 +
 3 files changed, 59 insertions(+)
 create mode 100755 tests/generic/719
 create mode 100644 tests/generic/719.out

diff --git a/tests/generic/719 b/tests/generic/719
new file mode 100755
index 00000000..2771a1f3
--- /dev/null
+++ b/tests/generic/719
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-newer
+# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
+#
+# FS QA Test No. 719
+#
+# Regression test for chgrp returning to userspace with ILOCK held after a
+# hard quota error.  This causes the filesystem to hang, so it is (for now)
+# a dangerous test.
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
index e998d1d5..bb93bccc 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -572,3 +572,4 @@
 716 dangerous_norepair
 717 auto quick rw swap
 718 auto quick rw swap
+719 dangerous
