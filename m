Received: from mx1.redhat.com ([209.132.183.28]:46283 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753433AbcFHK7K (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 8 Jun 2016 06:59:10 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/2] overlay: test getcwd() failure after rmdir
Date: Wed,  8 Jun 2016 18:59:03 +0800
Message-Id: <1465383543-10060-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1465383543-10060-1-git-send-email-eguan@redhat.com>
References: <1465383543-10060-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <guaneryu@gmail.com>
List-ID: <fstests@vger.kernel.org>

From: Eryu Guan <guaneryu@gmail.com>

Test getcwd() failure after unsuccessful rmdir.

Upstream commit ce9113bbcbf4 ("ovl: fix getcwd() failure after
unsuccessful rmdir") fixed this issue.

Signed-off-by: Eryu Guan <guaneryu@gmail.com>
---
 tests/overlay/006     | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/006.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 68 insertions(+)
 create mode 100755 tests/overlay/006
 create mode 100644 tests/overlay/006.out

diff --git a/tests/overlay/006 b/tests/overlay/006
new file mode 100755
index 0000000..f4d89bf
--- /dev/null
+++ b/tests/overlay/006
@@ -0,0 +1,65 @@
+#! /bin/bash
+# FS QA Test 006
+#
+# Test getcwd() failure after unsuccessful rmdir
+#
+# Upstream commit ce9113bbcbf4 ("ovl: fix getcwd() failure after unsuccessful
+# rmdir") fixed this issue
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
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
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs overlay
+_supported_os Linux
+_require_test
+
+rm -rf $TEST_DIR/$seq
+
+# make a non-empty dir $seq
+mkdir -p $TEST_DIR/$seq/$seq.sub
+# cd to it and call rmdir on it, rmdir should fail
+cd $TEST_DIR/$seq
+rmdir ../$seq >>$seqres.full 2>&1
+# getcwd should return the correct current dir
+pwd | _filter_test_dir
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/006.out b/tests/overlay/006.out
new file mode 100644
index 0000000..8bc96c5
--- /dev/null
+++ b/tests/overlay/006.out
@@ -0,0 +1,2 @@
+QA output created by 006
+TEST_DIR/006
diff --git a/tests/overlay/group b/tests/overlay/group
index aaf8f7f..2600266 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -8,3 +8,4 @@
 003 auto quick whiteout
 004 attr auto copyup quick
 005 auto quick copyup whiteout
+006 auto quick
-- 
2.5.5

