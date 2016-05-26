Received: from mx1.redhat.com ([209.132.183.28]:37329 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbcEZGnn (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 May 2016 02:43:43 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96A2064099
	for <fstests@vger.kernel.org>; Thu, 26 May 2016 06:43:42 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic: test clear of suid/sgid on direct write
Date: Thu, 26 May 2016 14:41:36 +0800
Message-Id: <1464244896-6275-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Check that suid/sgid bits are cleared on direct write. XFS triggered
WARN_ON_ONCE in this case. Patchset from Jan Kara fixed the warning:

http://oss.sgi.com/archives/xfs/2014-12/msg00071.html

This test is inspired by a test case from Eric Sandeen, and follows the
test steps in generic/193. This test requires direct I/O, it's not added
to generic/193 but to a new test, so that generic/193 still runs on
filesystems don't have direct I/O support.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/352     | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/352.out | 14 ++++++++
 tests/generic/group   |  1 +
 3 files changed, 113 insertions(+)
 create mode 100755 tests/generic/352
 create mode 100644 tests/generic/352.out

diff --git a/tests/generic/352 b/tests/generic/352
new file mode 100755
index 0000000..f15920e
--- /dev/null
+++ b/tests/generic/352
@@ -0,0 +1,98 @@
+#! /bin/bash
+# FS QA Test 352
+#
+# Test clear of suid/sgid on direct write.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
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
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_user
+_require_odirect
+
+testfile=$TEST_DIR/$seq.test
+rm -f $testfile
+
+do_io()
+{
+	su $qa_user -c "$XFS_IO_PROG -d -c 'pwrite 0 4k' $testfile" \
+		>>$seqres.full
+}
+
+echo "Check that suid/sgid bits are cleared after direct write"
+
+# create testfile and set base ownership & permission
+echo "this is a test" >> $testfile
+chmod 644 $testfile
+chown $qa_user:$qa_user $testfile
+
+echo "== with no exec perm"
+chmod ug+s $testfile
+echo -n "before: "; stat -c '%A' $testfile
+do_io
+echo -n "after:  "; stat -c '%A' $testfile
+
+echo "== with user exec perm"
+chmod ug+s $testfile
+chmod u+x $testfile
+echo -n "before: "; stat -c '%A' $testfile
+do_io
+echo -n "after:  "; stat -c '%A' $testfile
+
+echo "== with group exec perm"
+chmod ug+s $testfile
+chmod g+x $testfile
+chmod u-x $testfile
+echo -n "before: "; stat -c '%A' $testfile
+do_io
+echo -n "after:  "; stat -c '%A' $testfile
+
+echo "== with user+group exec perm"
+chmod ug+s $testfile
+chmod u+x $testfile
+echo -n "before: "; stat -c '%A' $testfile
+do_io
+echo -n "after:  "; stat -c '%A' $testfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/352.out b/tests/generic/352.out
new file mode 100644
index 0000000..b8ad619
--- /dev/null
+++ b/tests/generic/352.out
@@ -0,0 +1,14 @@
+QA output created by 352
+Check that suid/sgid bits are cleared after direct write
+== with no exec perm
+before: -rwSr-Sr--
+after:  -rw-r-Sr--
+== with user exec perm
+before: -rwsr-Sr--
+after:  -rwxr-Sr--
+== with group exec perm
+before: -rwSr-sr--
+after:  -rw-r-xr--
+== with user+group exec perm
+before: -rwsr-sr--
+after:  -rwxr-xr--
diff --git a/tests/generic/group b/tests/generic/group
index 36fb759..7a72f6b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -354,3 +354,4 @@
 349 blockdev quick rw
 350 blockdev quick rw
 351 blockdev quick rw
+352 auto quick
-- 
2.5.5

