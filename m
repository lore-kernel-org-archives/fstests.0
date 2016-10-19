Received: from mx1.redhat.com ([209.132.183.28]:8382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938778AbcJSOSV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Oct 2016 10:18:21 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10FF161A1B
        for <fstests@vger.kernel.org>; Wed, 19 Oct 2016 11:50:17 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] generic: Check linking O_TMPFILE into namespace with POSIX ACLs
Date: Wed, 19 Oct 2016 13:50:14 +0200
Message-Id: <1476877814-29310-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

When an O_TMPFILE file is linked into a directory with a POSIX default
ACL, the file should inherit the default ACL and the umask needs to be
ignored.

This goes together with generic/004, which tests O_TMPFILE files without
POSIX ACLs.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 tests/generic/389     | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/389.out |  6 +++++
 tests/generic/group   |  1 +
 3 files changed, 78 insertions(+)
 create mode 100755 tests/generic/389
 create mode 100644 tests/generic/389.out

diff --git a/tests/generic/389 b/tests/generic/389
new file mode 100755
index 0000000..23ca6d2
--- /dev/null
+++ b/tests/generic/389
@@ -0,0 +1,71 @@
+#! /bin/bash
+# FS QA Test 389
+#
+# Test if O_TMPFILE files inherit POSIX Default ACLs when they are linked into
+# the namespace (also see tests/generic/004).
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+	rm -f ${testfile}
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/attr
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_test
+_require_xfs_io_command "flink"
+_require_acls
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+testfile="${TEST_DIR}/d/tst-tmpfile-flink"
+
+umask 022
+mkdir -p ${TEST_DIR}/d
+setfacl -d -m u::rwx,g::rwx,o::rx ${TEST_DIR}/d
+$XFS_IO_PROG -T -m 0666 \
+	-c "pwrite 0 4096" \
+	-c "pread 0 4096" \
+	-c "flink ${testfile}" \
+	${TEST_DIR}/d | _filter_xfs_io
+stat -c '%a' ${testfile}
+rm -rf ${TEST_DIR}/d
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/389.out b/tests/generic/389.out
new file mode 100644
index 0000000..4d11ac7
--- /dev/null
+++ b/tests/generic/389.out
@@ -0,0 +1,6 @@
+QA output created by 389
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+664
diff --git a/tests/generic/group b/tests/generic/group
index fc32cfd..2656ff2 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -391,3 +391,4 @@
 386 auto quick quota
 387 auto clone
 388 auto log metadata
+389 auto quick
-- 
2.7.4

