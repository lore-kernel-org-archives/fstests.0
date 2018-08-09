Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727601AbeHIKRn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Aug 2018 06:17:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C5797B2B1
        for <fstests@vger.kernel.org>; Thu,  9 Aug 2018 07:54:06 +0000 (UTC)
From: Xiong Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH] generic: add test for checking /proc/locks after exec and flock
Date: Thu,  9 Aug 2018 15:53:53 +0800
Message-Id: <20180809075353.31514-1-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Murphy Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Regression test case for kernel patch:
    fs/lock: show locks info owned by dead/invisible processes

Open new fd by exec shell built-in, then require exclusive lock
by flock(1) command. Checking /proc/locks for the lock info.

This patchset post by Konstantin Khorenko <khorenko@virtuozzo.com>
has not been merged v4.18-rc8.

Signed-off-by: Xiong Murphy Zhou <xzhou@redhat.com>
---
 tests/generic/504     | 58 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/504.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 61 insertions(+)
 create mode 100755 tests/generic/504
 create mode 100644 tests/generic/504.out

diff --git a/tests/generic/504 b/tests/generic/504
new file mode 100755
index 00000000..b77f1d60
--- /dev/null
+++ b/tests/generic/504
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 RedHat Inc.  All Rights Reserved.
+#
+# FS QA Test 504
+#
+# Regression test case for kernel patch:
+#     fs/lock: show locks info owned by dead/invisible processes
+#
+# Open new fd by exec shell built-in, then require exclusive lock
+# by flock(1) command. Checking /proc/locks for the lock info.
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
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+# Create test file and find its inode NO.
+touch $TEST_DIR/flock_testfile
+tf_inode=$(stat -c %i $TEST_DIR/flock_testfile)
+echo inode $tf_inode >> $seqres.full
+
+# Create new fd by exec and lock.
+exec 9> $TEST_DIR/flock_testfile
+flock -x 9
+cat /proc/locks >> $seqres.full
+
+# Checking
+grep -qw $tf_inode /proc/locks || echo "lock info not found"
+
+# success, all done
+status=0
+echo "Silence is golden"
+exit
diff --git a/tests/generic/504.out b/tests/generic/504.out
new file mode 100644
index 00000000..d46394b8
--- /dev/null
+++ b/tests/generic/504.out
@@ -0,0 +1,2 @@
+QA output created by 504
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 79a5705a..55155de8 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -506,3 +506,4 @@
 501 auto quick clone log
 502 auto quick log
 503 auto quick dax punch collapse zero
+504 auto quick locks
-- 
2.17.0.252.gfe0a9ea

