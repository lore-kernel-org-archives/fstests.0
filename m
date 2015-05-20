Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41136 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753195AbbETOKI (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 May 2015 10:10:08 -0400
From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH V2] fstests: add a test for fallocate+truncate
Date: Wed, 20 May 2015 10:09:59 -0400
Message-ID: <1432130999-3956-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

There was some confused about what the fs was supposed to do when you truncate
at i_size with preallocated space past i_size.  We decided on the following
things

1) truncate(i_size) will trim all blocks past i_size.
2) truncate(x) where x > i_size will not trim all blocks past i_size.

This test is to make sure we're all acting sanely.  Thanks,

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
V1->V2:
-changed the test number
-fixed up minor comments from Eryu.

 tests/generic/087     | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/087.out |  6 +++++
 tests/generic/group   |  1 +
 3 files changed, 78 insertions(+)
 create mode 100644 tests/generic/087
 create mode 100644 tests/generic/087.out

diff --git a/tests/generic/087 b/tests/generic/087
new file mode 100644
index 0000000..f57e89d
--- /dev/null
+++ b/tests/generic/087
@@ -0,0 +1,71 @@
+#! /bin/bash
+# FS QA Test No. 087
+#
+# fallocate/truncate tests with FALLOC_FL_KEEP_SIZE option.
+# Verify if the disk space is released after truncating a file to i_size after
+# writing to a portion of a preallocated range.
+#
+# This also verifies that truncat'ing up past i_size doesn't remove the
+# preallocated space.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Facebook.  All Rights Reserved.
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
+status=0	# success is the default!
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
+. ./common/punch
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_xfs_io_command "falloc"
+_require_fiemap
+
+# First test to make sure that truncating at i_size trims the preallocated bit
+# past i_size
+$XFS_IO_PROG -f -c "falloc -k 0 10M" -c "pwrite 0 5M" -c "truncate 5M"\
+	$TEST_DIR/testfile.$seq | _filter_xfs_io
+sync
+$XFS_IO_PROG -c "fiemap -v" $TEST_DIR/testfile.$seq | _filter_fiemap
+
+# Now verify that if we truncate up past i_size we don't trim the preallocated
+# bit
+$XFS_IO_PROG -c "falloc -k 5M 5M" -c "truncate 7M" $TEST_DIR/testfile.$seq
+$XFS_IO_PROG -c "fiemap -v" $TEST_DIR/testfile.$seq | _filter_fiemap
+
+# success, all done
+exit
diff --git a/tests/generic/087.out b/tests/generic/087.out
new file mode 100644
index 0000000..c7cef59
--- /dev/null
+++ b/tests/generic/087.out
@@ -0,0 +1,6 @@
+QA output created by 087
+wrote 5242880/5242880 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0: [0..10239]: data
+0: [0..10239]: data
+1: [10240..20479]: unwritten
diff --git a/tests/generic/group b/tests/generic/group
index 927a91a..a801af4 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -90,6 +90,7 @@
 085 auto freeze mount
 086 auto prealloc preallocrw quick
 088 perms auto quick
+087 auto quick prealloc
 089 metadata auto
 091 rw auto quick
 093 attr cap udf auto
-- 
1.8.3.1

