Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58510 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751164AbeDQXo6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Apr 2018 19:44:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w3HNivet016092
        for <fstests@vger.kernel.org>; Tue, 17 Apr 2018 16:44:57 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2hdt4cr3e5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Tue, 17 Apr 2018 16:44:57 -0700
From: Howard McLauchlan <hmclauchlan@fb.com>
Subject: [PATCH] btrfs: add verify chattr support for send/receive test
Date: Tue, 17 Apr 2018 16:44:42 -0700
Message-ID: <20180417234442.31126-1-hmclauchlan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Howard McLauchlan <hmclauchlan@fb.com>
List-ID: <fstests@vger.kernel.org>

This test aims to verify correct behaviour with chattr operations and
btrfs send/receive. The intent is to check general correctness as well
as special interactions with troublesome flags(immutable, append only).

This test is motivated by a bug in btrfs which demonstrates a lack of
chattr support in btrfs send/receive.

A kernel patch to fix this can be found at:

    btrfs: add chattr support for send/receive

The accompanying userspace patch can be found at:

    btrfs-progs: add chattr support for send/receive

Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
---
 tests/btrfs/159     | 202 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/159.out |  38 +++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 241 insertions(+)
 create mode 100755 tests/btrfs/159
 create mode 100644 tests/btrfs/159.out

diff --git a/tests/btrfs/159 b/tests/btrfs/159
new file mode 100755
index 00000000..b3a32594
--- /dev/null
+++ b/tests/btrfs/159
@@ -0,0 +1,202 @@
+#! /bin/bash
+# FS QA Test 159
+#
+# This test verifies the correct behaviour of chattr support for btrfs
+# send/receive; 6 cases will be tested:
+# 1. New inode created with an inode flag set
+# 2. Existing inode with BTRFS_INODE_APPEND is written to with sequence:
+#		chattr -a
+#		pwrite something
+#		chattr +a
+# 3. Existing inode with BTRFS_INODE_APPEND is written to with sequence:
+#		chattr -a
+#		pwrite something
+#		chattr +d
+# 4. Existing inode is written to with sequence:
+#		setfattr something
+#		chattr +a
+# 5. Existing inode with BTRFS_INODE_APPEND is written to with sequence:
+#		chattr -a
+#		setfattr something
+#		setfattr something else
+#		chattr +a
+# 6. As above, but with pwrite instead of setfattr
+# The goal of 5 and 6 is not to test correctness, but to ensure we
+# don't send extra chattrs that are unnecessary.
+#
+# We verify the md5sum of the snapshots in the receive directory to ensure file
+# contents have changed appropriately. We also observe the flags changing (or
+# not changing) as appropriate.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Facebook.  All Rights Reserved.
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
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -rf $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Create receive directory
+mkdir $SCRATCH_MNT/receive
+
+# Create test file and set chattr flag
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/parent
+$XFS_IO_PROG -f -c "pwrite -S 0xaa 0K 32K" $SCRATCH_MNT/parent/foo | _filter_xfs_io
+$CHATTR_PROG +a $SCRATCH_MNT/parent/foo
+
+# Send/Receive initial snapshot
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/parent \
+	$SCRATCH_MNT/old_parent
+_run_btrfs_util_prog send -f $SCRATCH_MNT/out $SCRATCH_MNT/old_parent
+_run_btrfs_util_prog receive -f $SCRATCH_MNT/out $SCRATCH_MNT/receive
+
+# Verify post-send content and flags
+echo "post-send file digest for old_parent:"
+md5sum $SCRATCH_MNT/old_parent/foo | _filter_scratch
+echo "post-send file flag for old_parent:"
+lsattr $SCRATCH_MNT/receive/old_parent/foo | _filter_scratch
+
+# Make change
+$CHATTR_PROG -a $SCRATCH_MNT/parent/foo
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0K 32K" $SCRATCH_MNT/parent/foo | _filter_xfs_io
+$CHATTR_PROG +a $SCRATCH_MNT/parent/foo
+
+# Send incremental change
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/parent \
+	$SCRATCH_MNT/child_1
+_run_btrfs_util_prog send -p $SCRATCH_MNT/old_parent -f $SCRATCH_MNT/out \
+$SCRATCH_MNT/child_1
+_run_btrfs_util_prog receive -f $SCRATCH_MNT/out $SCRATCH_MNT/receive
+
+# Verify
+echo "post-send file digest for child_1:"
+md5sum $SCRATCH_MNT/child_1/foo | _filter_scratch
+echo "post-send file flag for child_1:"
+lsattr $SCRATCH_MNT/receive/child_1/foo | _filter_scratch
+
+# Make change
+$CHATTR_PROG -a $SCRATCH_MNT/parent/foo
+$XFS_IO_PROG -f -c "pwrite -S 0xac 0K 32K" $SCRATCH_MNT/parent/foo | _filter_xfs_io
+$CHATTR_PROG +d $SCRATCH_MNT/parent/foo
+
+# Send incremental change
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/parent \
+	$SCRATCH_MNT/child_2
+_run_btrfs_util_prog send -p $SCRATCH_MNT/old_parent -f $SCRATCH_MNT/out \
+$SCRATCH_MNT/child_2
+_run_btrfs_util_prog receive -f $SCRATCH_MNT/out $SCRATCH_MNT/receive
+
+# Verify
+echo "post-send file digest for child_2:"
+md5sum $SCRATCH_MNT/child_2/foo | _filter_scratch
+echo "post-send file flag for child_2:"
+lsattr $SCRATCH_MNT/receive/child_2/foo | _filter_scratch
+
+# Send fattr, then chattr
+$SETFATTR_PROG -n user.test -v 0xaaaa $SCRATCH_MNT/parent/foo
+$CHATTR_PROG +a $SCRATCH_MNT/parent/foo
+
+# Send incremental change against child_2
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/parent \
+	$SCRATCH_MNT/child_3
+_run_btrfs_util_prog send -p $SCRATCH_MNT/child_2 -f $SCRATCH_MNT/out \
+$SCRATCH_MNT/child_3
+_run_btrfs_util_prog receive -f $SCRATCH_MNT/out $SCRATCH_MNT/receive
+
+# Verify
+echo "post-send file flag for child_3:"
+lsattr $SCRATCH_MNT/receive/child_3/foo | _filter_scratch
+echo "post-send xattr for child_3:"
+$GETFATTR_PROG --absolute-names -d $SCRATCH_MNT/receive/child_3/foo | _filter_scratch
+
+# chattr, send fattr, then chattr
+$CHATTR_PROG -a $SCRATCH_MNT/parent/foo
+$SETFATTR_PROG -n user.test_1 -v 0xbbbb $SCRATCH_MNT/parent/foo
+$SETFATTR_PROG -n user.test -v 0xcccc $SCRATCH_MNT/parent/foo
+$CHATTR_PROG +a $SCRATCH_MNT/parent/foo
+
+
+# Send incremental change
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/parent \
+	$SCRATCH_MNT/child_4
+_run_btrfs_util_prog send -p $SCRATCH_MNT/old_parent -f $SCRATCH_MNT/out \
+$SCRATCH_MNT/child_4
+_run_btrfs_util_prog receive -f $SCRATCH_MNT/out $SCRATCH_MNT/receive
+
+# Verify
+echo "post-send file flag for child_4:"
+lsattr $SCRATCH_MNT/receive/child_4/foo | _filter_scratch
+echo "post-send xattr for child_4:"
+$GETFATTR_PROG --absolute-names -d $SCRATCH_MNT/receive/child_4/foo | _filter_scratch
+
+# Technically we've hit this path, but to be sure...
+$CHATTR_PROG -a $SCRATCH_MNT/parent/foo
+$XFS_IO_PROG -f -c "pwrite -S 0xac 64k 128k" $SCRATCH_MNT/parent/foo | _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite -S 0xac 1024k 1056k" $SCRATCH_MNT/parent/foo | _filter_xfs_io
+$CHATTR_PROG +a $SCRATCH_MNT/parent/foo
+
+# Send incremental change
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/parent \
+	$SCRATCH_MNT/child_5
+_run_btrfs_util_prog send -p $SCRATCH_MNT/old_parent -f $SCRATCH_MNT/out \
+$SCRATCH_MNT/child_5
+_run_btrfs_util_prog receive -f $SCRATCH_MNT/out $SCRATCH_MNT/receive
+
+# Verify
+echo "post-send file flag for child_5:"
+lsattr $SCRATCH_MNT/receive/child_5/foo | _filter_scratch
+
+# optional stuff if your test has verbose output to help resolve problems
+
+#echo "If failure, check $seqres.full (this) and $seqres.full.ok (reference)"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
new file mode 100644
index 00000000..3bd7b303
--- /dev/null
+++ b/tests/btrfs/159.out
@@ -0,0 +1,38 @@
+QA output created by 159
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+post-send file digest for old_parent:
+c28418534a020122aca59fd3ff9581b5  SCRATCH_MNT/old_parent/foo
+post-send file flag for old_parent:
+-----a------------ SCRATCH_MNT/receive/old_parent/foo
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+post-send file digest for child_1:
+8e3ba8330fc5309ed7d2f447c13d9e71  SCRATCH_MNT/child_1/foo
+post-send file flag for child_1:
+-----a------------ SCRATCH_MNT/receive/child_1/foo
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+post-send file digest for child_2:
+5671126b7326949ea0f14d5a875084ac  SCRATCH_MNT/child_2/foo
+post-send file flag for child_2:
+------d----------- SCRATCH_MNT/receive/child_2/foo
+post-send file flag for child_3:
+-----ad----------- SCRATCH_MNT/receive/child_3/foo
+post-send xattr for child_3:
+# file: SCRATCH_MNT/receive/child_3/foo
+user.test=0sqqo=
+
+post-send file flag for child_4:
+-----ad----------- SCRATCH_MNT/receive/child_4/foo
+post-send xattr for child_4:
+# file: SCRATCH_MNT/receive/child_4/foo
+user.test=0szMw=
+user.test_1=0su7s=
+
+wrote 131072/131072 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1081344/1081344 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+post-send file flag for child_5:
+-----ad----------- SCRATCH_MNT/receive/child_5/foo
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 8007e07e..bc83db94 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -161,3 +161,4 @@
 156 auto quick trim
 157 auto quick raid
 158 auto quick raid scrub
+159 auto
-- 
2.17.0

