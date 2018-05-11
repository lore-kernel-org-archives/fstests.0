Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEKPns (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 11 May 2018 11:43:48 -0400
From: fdmanana@kernel.org
Subject: [PATCH] fstests: generic test for fsync of file with xattrs
Date: Fri, 11 May 2018 16:43:43 +0100
Message-Id: <20180511154343.12960-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that xattrs are not lost after calling fsync multiple times with a
filesystem commit in between the fsync calls.

This test is motivated by a bug found in btrfs which is fixed by a patch
for the linux kernel titled:

  Btrfs: fix xattr loss after power failure

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/487     | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/487.out | 11 +++++++
 tests/generic/group   |  1 +
 3 files changed, 98 insertions(+)
 create mode 100755 tests/generic/487
 create mode 100644 tests/generic/487.out

diff --git a/tests/generic/487 b/tests/generic/487
new file mode 100755
index 00000000..328b5378
--- /dev/null
+++ b/tests/generic/487
@@ -0,0 +1,86 @@
+#! /bin/bash
+# FSQA Test No. 487
+#
+# Test that xattrs are not lost after calling fsync multiple times with a
+# filesystem commit in between the fsync calls.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+# Author: Filipe Manana <fdmanana@suse.com>
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
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmflakey
+. ./common/attr
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_dm_target flakey
+_require_attrs
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+touch $SCRATCH_MNT/foobar
+$SETFATTR_PROG -n user.xa1 -v qwerty $SCRATCH_MNT/foobar
+$SETFATTR_PROG -n user.xa2 -v 'hello world' $SCRATCH_MNT/foobar
+$SETFATTR_PROG -n user.xa3 -v test $SCRATCH_MNT/foobar
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
+
+# Call sync to commit all fileystem metadata.
+sync
+
+$XFS_IO_PROG -c "pwrite -S 0xea 0 64K" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/foobar >>$seqres.full
+
+# Simulate a power failure and mount the filesystem to check that the xattrs
+# were not lost and neither was the data we wrote.
+_flakey_drop_and_remount
+echo "File xattrs after power failure:"
+$GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
+echo "File data after power failure:"
+od -t x1 $SCRATCH_MNT/foobar
+
+_unmount_flakey
+_cleanup_flakey
+
+status=0
+exit
diff --git a/tests/generic/487.out b/tests/generic/487.out
new file mode 100644
index 00000000..44a119f8
--- /dev/null
+++ b/tests/generic/487.out
@@ -0,0 +1,11 @@
+QA output created by 487
+File xattrs after power failure:
+# file: SCRATCH_MNT/foobar
+user.xa1="qwerty"
+user.xa2="hello world"
+user.xa3="test"
+
+File data after power failure:
+0000000 ea ea ea ea ea ea ea ea ea ea ea ea ea ea ea ea
+*
+0200000
diff --git a/tests/generic/group b/tests/generic/group
index 505383f7..c8f51ec2 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -489,3 +489,4 @@
 484 auto quick
 485 auto quick insert
 486 auto quick attr
+487 auto quick attr
-- 
2.11.0

