Received: from mail-pg0-f67.google.com ([74.125.83.67]:34179 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdCWTQv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Mar 2017 15:16:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id w20so12992942pgc.1
        for <fstests@vger.kernel.org>; Thu, 23 Mar 2017 12:16:50 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] ext4: test mounting filesystem with encrypted inode on orphan list
Date: Thu, 23 Mar 2017 12:16:08 -0700
Message-Id: <20170323191608.96422-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>, Theodore Ts'o <tytso@mit.edu>, Michael Halcrow <mhalcrow@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add an ext4-specific regression test for a bug which caused ext4 to
crash when mounting a filesystem which had an encrypted inode on its
orphan list.

This bug was present in kernels v4.1 and later.  It has been fixed in
v4.11-rc1, v4.10.4, v4.9.16, and v4.4.55.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/ext4/309     | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/309.out |  2 ++
 tests/ext4/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/ext4/309
 create mode 100644 tests/ext4/309.out

diff --git a/tests/ext4/309 b/tests/ext4/309
new file mode 100755
index 00000000..a557024a
--- /dev/null
+++ b/tests/ext4/309
@@ -0,0 +1,87 @@
+#! /bin/bash
+# FS QA Test ext4/309
+#
+# Regression test for 0d06863f903a ("ext4: don't BUG when truncating encrypted
+# inodes on the orphan list").
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
+#
+# Author: Eric Biggers <ebiggers@google.com>
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
+
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
+# get standard environment and checks
+. ./common/rc
+. ./common/encrypt
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+_require_scratch_encryption
+_require_xfs_io_command "set_encpolicy"
+_require_command "$KEYCTL_PROG" keyctl
+
+_new_session_keyring
+
+#
+# Create an encrypted file whose size is not a multiple of the filesystem block
+# size, then add it to the orphan list.
+#
+# We create the encrypted file normally, rather than use debugfs to force the
+# inode flags to ENCRYPT|EXTENTS as done in the example listed in the commit
+# message of the kernel fix, because forcing the inode flags is incompatible
+# with some MKFS_OPTIONS such as inline_data or ^extents.
+#
+# This choice does, however, have the disadvantage that this test won't detect
+# the bug in as many situations, such as in kernels configured without
+# encryption support.
+#
+_scratch_mkfs_encrypted &>>$seqres.full
+_scratch_mount
+mkdir $SCRATCH_MNT/edir
+keydesc=$(_generate_encryption_key)
+$XFS_IO_PROG -c "set_encpolicy $keydesc" $SCRATCH_MNT/edir
+echo foo > $SCRATCH_MNT/edir/file
+inum=$(stat -c '%i' $SCRATCH_MNT/edir/file)
+_scratch_unmount
+debugfs -w -R "set_super_value s_last_orphan $inum" $SCRATCH_DEV &>>$seqres.full
+
+# Try to mount the filesystem.  This would hit a BUG() in fs/ext4/inode.c.
+_scratch_mount
+
+# success, all done
+echo "Didn't crash!"
+status=0
+exit
diff --git a/tests/ext4/309.out b/tests/ext4/309.out
new file mode 100644
index 00000000..ea3e66ed
--- /dev/null
+++ b/tests/ext4/309.out
@@ -0,0 +1,2 @@
+QA output created by 309
+Didn't crash!
diff --git a/tests/ext4/group b/tests/ext4/group
index 70d619e4..da0493f3 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -35,3 +35,4 @@
 306 auto rw resize quick
 307 auto ioctl rw defrag
 308 auto ioctl rw prealloc quick defrag
+309 auto quick encrypt dangerous
-- 
2.12.1.500.gab5fba24ee-goog

