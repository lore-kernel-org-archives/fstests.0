Received: from mx2.suse.de ([195.135.220.15]:56343 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752918AbdFVN2n (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Jun 2017 09:28:43 -0400
From: Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/441: Test SGID inheritance with default ACLs
Date: Thu, 22 Jun 2017 15:28:28 +0200
Message-Id: <20170622132828.16847-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Test that subdirectory properly inherits SGID bit even if parent
directory has default ACLs.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/441     | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/441.out |  3 +++
 tests/generic/group   |  1 +
 3 files changed, 75 insertions(+)
 create mode 100755 tests/generic/441
 create mode 100644 tests/generic/441.out

diff --git a/tests/generic/441 b/tests/generic/441
new file mode 100755
index 000000000000..df382f7b1036
--- /dev/null
+++ b/tests/generic/441
@@ -0,0 +1,71 @@
+#! /bin/bash
+# FS QA Test 441
+#
+# Check if SGID is inherited when creating a subdirectory when the owner is not
+# in the owning group and directory has default ACLs.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 SUSE Linux.  All Rights Reserved.
+#
+# Author: Jan Kara <jack@suse.cz>
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
+. ./common/attr
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_runas
+_require_acls
+
+cd $TEST_DIR
+
+TDIR=testdir.$seq
+
+# Create SGID directory with default ACLs
+rm -rf $TDIR
+mkdir $TDIR
+setfacl -d -m u:101:rwx $TDIR
+chown 100:100 $TDIR
+chmod 2755 $TDIR
+
+_runas -u 100 -g 100 -- mkdir $TDIR/testsub1
+stat -c %A $TDIR/testsub1
+_runas -u 100 -g 101 -- mkdir $TDIR/testsub2
+stat -c %A $TDIR/testsub2
+
+status=0
+exit
diff --git a/tests/generic/441.out b/tests/generic/441.out
new file mode 100644
index 000000000000..c821318a4cc0
--- /dev/null
+++ b/tests/generic/441.out
@@ -0,0 +1,3 @@
+QA output created by 441
+drwxrwsr-x
+drwxrwsr-x
diff --git a/tests/generic/group b/tests/generic/group
index ab1e9d33a846..0d21fe867ab1 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -443,3 +443,4 @@
 438 auto
 439 auto quick punch
 440 auto quick encrypt
+441 auto quick acl
-- 
2.12.3

