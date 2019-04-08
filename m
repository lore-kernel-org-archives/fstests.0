Received: from mx2.suse.de ([195.135.220.15]:53862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbfDHQIr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 Apr 2019 12:08:47 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v3 1/2] ceph: test basic ceph.quota.max_files quota
Date: Mon,  8 Apr 2019 17:08:41 +0100
Message-Id: <20190408160842.23649-2-lhenriques@suse.com>
In-Reply-To: <20190408160842.23649-1-lhenriques@suse.com>
References: <20190408160842.23649-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Dave Chinner <david@fromorbit.com>, Eryu Guan <guaneryu@gmail.com>, ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Simple set of checks for CephFS max_files directory quota implementation.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/ceph/001      | 88 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/001.out  |  9 +++++
 tests/ceph/Makefile | 20 +++++++++++
 tests/ceph/group    |  1 +
 4 files changed, 118 insertions(+)
 create mode 100755 tests/ceph/001
 create mode 100644 tests/ceph/001.out
 create mode 100644 tests/ceph/Makefile
 create mode 100644 tests/ceph/group

diff --git a/tests/ceph/001 b/tests/ceph/001
new file mode 100755
index 000000000000..bbffe75aa7b2
--- /dev/null
+++ b/tests/ceph/001
@@ -0,0 +1,88 @@
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
+workdir=$TEST_DIR/$seq
+
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
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
+	local val=$1
+	local dir=$2
+	$SETFATTR_PROG -n ceph.quota.max_files -v $val $dir >>$seqres.full 2>&1
+}
+get_quota()
+{
+	local dir=$1
+	_getfattr -n ceph.quota.max_files --absolute-names $dir \
+		  2>>$seqres.full | _filter_test_dir
+}
+
+rm -f $seqres.full
+rm -rf $workdir
+mkdir $workdir
+
+# test setting quota
+set_quota 10 $workdir
+get_quota $workdir
+
+# set quota to largest acceptable value (0x7FFFFFFFFFFFFFFF)
+set_quota 9223372036854775807 $workdir
+get_quota $workdir
+
+# test resetting quota
+set_quota 0 $workdir
+get_quota $workdir
+
+# set quota to invalid values (0x8000000000000000 and -1)
+set_quota 9223372036854775808 $workdir
+get_quota $workdir
+
+set_quota -1 $workdir
+get_quota $workdir
+
+set_quota 5 $workdir
+mkdir $workdir/0
+touch $workdir/0/1
+touch $workdir/0/2
+touch $workdir/3
+
+touch $workdir/4 2>&1 | _filter_test_dir # should fail
+mkdir $workdir/5 2>&1 | _filter_test_dir # should fail
+
+set_quota 0 $workdir
+touch $workdir/4 # shouldn't fail
+mkdir $workdir/5 # shouldn't fail
+
+# success, all done
+status=0
+exit
diff --git a/tests/ceph/001.out b/tests/ceph/001.out
new file mode 100644
index 000000000000..bc5ff5e61a8f
--- /dev/null
+++ b/tests/ceph/001.out
@@ -0,0 +1,9 @@
+QA output created by 001
+# file: TEST_DIR/001
+ceph.quota.max_files="10"
+
+# file: TEST_DIR/001
+ceph.quota.max_files="9223372036854775807"
+
+touch: cannot touch 'TEST_DIR/001/4': Disk quota exceeded
+mkdir: cannot create directory 'TEST_DIR/001/5': Disk quota exceeded
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
