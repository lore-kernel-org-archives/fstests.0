Received: from mga02.intel.com ([134.134.136.20]:34525 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393421AbfIWSAJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 14:00:09 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 16/16] generic/568: Add lease testing
Date: Mon, 23 Sep 2019 10:59:59 -0700
Message-Id: <20190923175959.2802-2-ira.weiny@intel.com>
In-Reply-To: <20190923175959.2802-1-ira.weiny@intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
 <20190923175959.2802-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Create a new lease test script.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	New patch for this series.

 common/locktest       |  4 ++++
 tests/generic/568     | 32 ++++++++++++++++++++++++++++++++
 tests/generic/568.out |  2 ++
 tests/generic/group   |  1 +
 4 files changed, 39 insertions(+)
 create mode 100755 tests/generic/568
 create mode 100644 tests/generic/568.out

diff --git a/common/locktest b/common/locktest
index c41f5054c523..1da5fbb1eb62 100644
--- a/common/locktest
+++ b/common/locktest
@@ -89,3 +89,7 @@ _run_generic() {
 _run_locktest() {
 	_run_generic ""
 }
+
+_run_leasetest() {
+	_run_generic "-L"
+}
diff --git a/tests/generic/568 b/tests/generic/568
new file mode 100755
index 000000000000..0d52c384cbd1
--- /dev/null
+++ b/tests/generic/568
@@ -0,0 +1,32 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Intel, Corp.  All Rights Reserved.
+#
+# FSQA Test No. 568
+#
+# lease test
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/locktest
+
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_test_fcntl_advisory_locks
+
+_run_leasetest
+
+exit
diff --git a/tests/generic/568.out b/tests/generic/568.out
new file mode 100644
index 000000000000..5efccbbc6194
--- /dev/null
+++ b/tests/generic/568.out
@@ -0,0 +1,2 @@
+QA output created by 568
+success!
diff --git a/tests/generic/group b/tests/generic/group
index 7cf4f6c48b2f..c773d6b52a99 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -570,3 +570,4 @@
 565 auto quick copy_range
 566 auto quick quota metadata
 567 auto quick rw punch
+568 auto quick
-- 
2.20.1
