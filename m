Received: from mx2.suse.de ([195.135.220.15]:36172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbfDBKee (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 Apr 2019 06:34:34 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 1/2] ceph: test basic ceph.quota.max_files quota
Date: Tue,  2 Apr 2019 11:34:27 +0100
Message-Id: <20190402103428.21435-2-lhenriques@suse.com>
In-Reply-To: <20190402103428.21435-1-lhenriques@suse.com>
References: <20190402103428.21435-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Simple set of checks for CephFS max_files directory quota implementation.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/ceph/001      | 108 ++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/001.out  |   1 +
 tests/ceph/Makefile |  20 ++++++++
 tests/ceph/group    |   1 +
 4 files changed, 130 insertions(+)
 create mode 100755 tests/ceph/001
 create mode 100644 tests/ceph/001.out
 create mode 100644 tests/ceph/Makefile
 create mode 100644 tests/ceph/group

diff --git a/tests/ceph/001 b/tests/ceph/001
new file mode 100755
index 000000000000..c4fe310d5135
--- /dev/null
+++ b/tests/ceph/001
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 SUSE LLC. All Rights Reserved.
+#
+# FS QA Test No. 001
+#
+# Test basic ceph.quota.max_files quota features.
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+testdir=$TEST_DIR/quota-test
+
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	rm -rf $testdir
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs ceph
+
+_require_attrs
+
+set_quota()
+{
+	val=$1
+	dir=$2
+	$SETFATTR_PROG -n ceph.quota.max_files -v $val $dir >/dev/null 2>&1
+}
+get_quota()
+{
+	dir=$1
+	$GETFATTR_PROG --only-values -n ceph.quota.max_files $dir 2> /dev/null
+}
+
+mkdir $testdir
+
+# test setting quota
+set_quota 10 $testdir
+ret=$(get_quota $testdir)
+if [ "$ret" -ne 10 ]; then
+	_fail "expected max_files quota to be 10, got '$ret' instead"
+fi
+# set quota to largest acceptable value (0x7FFFFFFFFFFFFFFF)
+set_quota 9223372036854775807 $testdir
+ret=$(get_quota $testdir)
+if [ "$ret" -ne 9223372036854775807 ]; then
+	_fail "expected max_files quota to be 9223372036854775807, got '$ret' instead"
+fi
+# test resetting quota
+set_quota 0 $testdir
+ret=$(get_quota $testdir)
+if [ -n "$ret" ]; then
+	_fail "expected 0 max_files quota, got '$ret' instead"
+fi
+# set quota to invalid values (0x8000000000000000 and -1)
+set_quota 9223372036854775808 $testdir
+ret=$(get_quota $testdir)
+if [ -n "$ret" ]; then
+	_fail "expected max_files quota to be 0, got '$ret' instead"
+fi
+set_quota -1 $testdir
+ret=$(get_quota $testdir)
+if [ -n "$ret" ]; then
+	_fail "expected max_files quota to be 0, got '$ret' instead"
+fi
+
+set_quota 5 $testdir
+mkdir $testdir/0
+touch $testdir/0/1
+touch $testdir/0/2
+touch $testdir/3
+touch $testdir/4 2> /dev/null
+if [ $? -ne 1 ]; then
+	_fail "Should have failed to create file"
+fi
+mkdir $testdir/5 2> /dev/null
+if [ $? -ne 1 ]; then
+	_fail "Should have failed to create directory"
+fi
+
+set_quota 0 $testdir
+touch $testdir/4 2> /dev/null
+if [ $? -ne 0 ]; then
+	_fail "Should have succeeded to create file"
+fi
+mkdir $testdir/5 2> /dev/null
+if [ $? -ne 0 ]; then
+	_fail "Should have succeeded to create directory"
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/ceph/001.out b/tests/ceph/001.out
new file mode 100644
index 000000000000..097d046a6fd4
--- /dev/null
+++ b/tests/ceph/001.out
@@ -0,0 +1 @@
+QA output created by 001
diff --git a/tests/ceph/Makefile b/tests/ceph/Makefile
new file mode 100644
index 000000000000..f93862af4f31
--- /dev/null
+++ b/tests/ceph/Makefile
@@ -0,0 +1,20 @@
+#
+# Copyright (c) 2019 SUSE LLC. All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+CEPHFS_DIR = cephfs
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(CEPHFS_DIR)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
diff --git a/tests/ceph/group b/tests/ceph/group
new file mode 100644
index 000000000000..e389bc6ec7ee
--- /dev/null
+++ b/tests/ceph/group
@@ -0,0 +1 @@
+001 auto quick quota
