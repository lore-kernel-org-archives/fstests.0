Received: from sandeen.net ([63.231.237.45]:47752 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbcI3Cc1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Sep 2016 22:32:27 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 5D60C2B51
        for <fstests@vger.kernel.org>; Thu, 29 Sep 2016 21:31:55 -0500 (CDT)
From: Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH] exercise and validate the xfs_io inode command
Message-ID: <ce19a4ec-ee15-17a8-67e0-b8418534f3c7@sandeen.net>
Date: Thu, 29 Sep 2016 21:32:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Run various modes of the xfs_io "inode" command.

This fails today, I have some patches to fix it up.
The "grep -q" for failures strings are fairly loose
because I'm changing them, and don't want to depend
on the exact error or usage message ...

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/054 b/tests/xfs/054
new file mode 100755
index 0000000..7d08f8a
--- /dev/null
+++ b/tests/xfs/054
@@ -0,0 +1,104 @@
+#! /bin/bash
+# FS QA Test 054
+#
+# Exercise the xfs_io inode command
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
+_supported_fs xfs
+_supported_os Linux
+_require_test
+_require_xfs_io_command "inode"
+
+# We know the root inode is there
+ROOT_INO=`ls -id $SCRATCH_MNT | awk '{print $1}'`
+
+touch $TEST_DIR/file
+
+$XFS_IO_PROG -c "inode"       $TEST_DIR/file
+$XFS_IO_PROG -c "inode -v"    $TEST_DIR/file | \
+		grep -vw $ROOT_INO | sed -e s/.*:/LAST:/g
+
+#  These should fail, -n requires an inode
+$XFS_IO_PROG -c "inode -n"    $TEST_DIR/file 2>&1 | grep -q Query \
+		|| echo "bare -n succeeded"
+$XFS_IO_PROG -c "inode -nv"   $TEST_DIR/file 2>&1 | grep -q Query \
+		|| echo "bare -nv succeeded"
+$XFS_IO_PROG -c "inode -n -v" $TEST_DIR/file 2>&1 | grep -q Query \
+		|| echo "bare -n -v succeeded"
+
+# These fail too, requires a valid inode number
+$XFS_IO_PROG -c "inode       badnumber" $TEST_DIR/file | grep -q numeric \
+		|| echo "Bad inode number succeeded"
+$XFS_IO_PROG -c "inode -v    badnumber" $TEST_DIR/file | grep -q numeric \
+		|| echo "Bad inode number succeeded"
+$XFS_IO_PROG -c "inode -n    badnumber" $TEST_DIR/file | grep -q numeric \
+		|| echo "Bad inode number succeeded"
+$XFS_IO_PROG -c "inode -nv   badnumber" $TEST_DIR/file | grep -q numeric \
+		|| echo "Bad inode number succeeded"
+$XFS_IO_PROG -c "inode -n -v badnumber" $TEST_DIR/file | grep -q numeric \
+		|| echo "Bad inode number succeeded"
+
+# These should all work, and return $ROOT_INO or the next inode...
+# grep out ROOT_INO (which is incorrect) when we should be getting next inode
+$XFS_IO_PROG -c "inode       $ROOT_INO" $TEST_DIR/file | \
+		sed -e s/$ROOT_INO/ROOT_INO/g
+$XFS_IO_PROG -c "inode -v    $ROOT_INO" $TEST_DIR/file | \
+		sed -e s/$ROOT_INO/ROOT_INO/g
+$XFS_IO_PROG -c "inode -n    $ROOT_INO" $TEST_DIR/file | \
+		grep -vw $ROOT_INO | sed -e s/.*/NEXT/g
+$XFS_IO_PROG -c "inode -nv   $ROOT_INO" $TEST_DIR/file | \
+		grep -vw $ROOT_INO | sed -e s/.*:/NEXT:/g
+$XFS_IO_PROG -c "inode -n -v $ROOT_INO" $TEST_DIR/file | \
+		grep -vw $ROOT_INO | sed -e s/.*:/NEXT:/g
+
+# Try one that doesn't exist, 2^64-2?  Should get 0
+$XFS_IO_PROG -c "inode       18446744073709551614" $TEST_DIR/file
+$XFS_IO_PROG -c "inode -v    18446744073709551614" $TEST_DIR/file
+$XFS_IO_PROG -c "inode -n    18446744073709551614" $TEST_DIR/file
+$XFS_IO_PROG -c "inode -nv   18446744073709551614" $TEST_DIR/file
+$XFS_IO_PROG -c "inode -n -v 18446744073709551614" $TEST_DIR/file
+
+status=0
+exit
diff --git a/tests/xfs/054.out b/tests/xfs/054.out
new file mode 100644
index 0000000..ef725b4
--- /dev/null
+++ b/tests/xfs/054.out
@@ -0,0 +1,13 @@
+QA output created by 054
+0
+LAST:32
+ROOT_INO
+ROOT_INO:32
+NEXT
+NEXT:32
+NEXT:32
+0
+0
+0
+0
+0
diff --git a/tests/xfs/group b/tests/xfs/group
index 798bf99..60e65de 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -51,6 +51,7 @@
 051 auto log metadata
 052 quota db auto quick
 053 attr acl repair quick auto
+054 auto quick
 055 dump ioctl remote tape
 056 dump ioctl auto quick
 057 acl auto


