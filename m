Received: from mx1.redhat.com ([209.132.183.28]:49577 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbbFXLFa (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 24 Jun 2015 07:05:30 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id ABE06B82B1
	for <fstests@vger.kernel.org>; Wed, 24 Jun 2015 11:05:30 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v4] generic: test bug when zero range is crossing isize within single block
Date: Wed, 24 Jun 2015 19:05:25 +0800
Message-Id: <1435143925-10037-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Lukas Czerner <lczerner@redhat.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Lukas Czerner <lczerner@redhat.com>

Exercise the situation that cause ext4 to BUG_ON() when we use
zero range to zero a range which starts within the isize but ends
past the isize but still in the same block. This particular problem
has only been seen on systems with page_size > block_size.

This tests exercises the problem fixed in kernel with commit
0f2af21aae11972fa924374ddcf52e88347cf5a8
ext4: Allocate entire range in zero range

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---

This patch got lost in previous fstests updates, I did minor updates and resent.

v4:
- Use scratch dev instead of test dev, it's easy and common to test page_size > block_size scenario on scratch device
- Add "Silence is golden" to indicate test expects no output
- Renumber to generic/094

 tests/generic/094     | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/094.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 67 insertions(+)
 create mode 100755 tests/generic/094
 create mode 100644 tests/generic/094.out

diff --git a/tests/generic/094 b/tests/generic/094
new file mode 100755
index 0000000..602e5b6
--- /dev/null
+++ b/tests/generic/094
@@ -0,0 +1,64 @@
+#! /bin/bash
+# FS QA Test 094
+#
+# Exercise the situation that cause ext4 to BUG_ON() when we use
+# zero range to zero a range which starts within the isize but ends
+# past the isize but still in the same block. This particular problem
+# has only been seen on systems with page_size > block_size.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat, Inc., Lukas Czerner <lczerner@redhat.com>
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
+# real QA test starts here
+_supported_fs generic
+_supported_os IRIX Linux
+_require_scratch
+_require_xfs_io_command "fzero"
+
+rm -f $seqres.full
+echo "Silence is golden"
+
+# Use smaller scratch fs to shorten the test time
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
+_scratch_mount
+
+testfile=$SCRATCH_MNT/$seq.$$
+$XFS_IO_PROG -f -c "pwrite 4096 512" -c "fzero 4351 512" $testfile >> $seqres.full 2>&1
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/094.out b/tests/generic/094.out
new file mode 100644
index 0000000..bcdcf29
--- /dev/null
+++ b/tests/generic/094.out
@@ -0,0 +1,2 @@
+QA output created by 094
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index ca15a3f..fcca238 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -96,6 +96,7 @@
 091 rw auto quick
 092 auto quick prealloc
 093 attr cap udf auto
+094 auto prealloc quick
 097 udf auto
 099 udf auto
 100 udf auto
-- 
2.4.3

