Received: from mail-pg0-f42.google.com ([74.125.83.42]:36787 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755464AbcK1WR2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Nov 2016 17:17:28 -0500
Received: by mail-pg0-f42.google.com with SMTP id f188so61084193pgc.3
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2016 14:17:28 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 4/5] generic: test encrypted file access
Date: Mon, 28 Nov 2016 14:16:41 -0800
Message-Id: <1480371402-12204-5-git-send-email-ebiggers@google.com>
In-Reply-To: <1480371402-12204-1-git-send-email-ebiggers@google.com>
References: <1480371402-12204-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Test accessing encrypted files and directories, both with and without
the encryption key.  As noted in the comment, this test is expected to
fail on some old kernels.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/402     | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/402.out |  11 ++++
 tests/generic/group   |   1 +
 3 files changed, 157 insertions(+)
 create mode 100755 tests/generic/402
 create mode 100644 tests/generic/402.out

diff --git a/tests/generic/402 b/tests/generic/402
new file mode 100755
index 0000000..f51b99f
--- /dev/null
+++ b/tests/generic/402
@@ -0,0 +1,145 @@
+#! /bin/bash
+# FS QA Test generic/402
+#
+# Test accessing encrypted files and directories, both with and without the
+# encryption key.  Access with the encryption key is more of a sanity check and
+# is not intended to fully test all the encrypted I/O paths; to do that you'd
+# need to run all the xfstests with encryption enabled.  Access without the
+# encryption key, on the other hand, should result in some particular behaviors.
+#
+# Note that this test uses the common key prefix (fscrypt:), which wasn't
+# supported by ext4 before 4.8 and f2fs before 4.6.  It's expected that this
+# test will fail on such old kernels.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Google, Inc.  All Rights Reserved.
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
+. ./common/encrypt
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4 f2fs
+_supported_os Linux
+_require_xfs_io_command "set_encpolicy"
+_require_scratch
+_require_command "$KEYCTL_PROG" keyctl
+_require_encryption
+
+_scratch_mkfs_encrypted >> $seqres.full
+_scratch_mount
+
+mkdir $SCRATCH_MNT/edir $SCRATCH_MNT/ref_dir
+keydesc=$(_generate_encryption_key)
+$XFS_IO_PROG -c "set_encpolicy $keydesc" $SCRATCH_MNT/edir
+for dir in $SCRATCH_MNT/edir $SCRATCH_MNT/ref_dir; do
+	touch $dir/empty > /dev/null
+	$XFS_IO_PROG -t -f -c "pwrite 0 4k" $dir/a > /dev/null
+	$XFS_IO_PROG -t -f -c "pwrite 0 33k" $dir/abcdefghijklmnopqrstuvwxyz > /dev/null
+	maxname=$(yes | head -255 | tr -d '\n') # 255 character filename
+	$XFS_IO_PROG -t -f -c "pwrite 0 1k" $dir/$maxname > /dev/null
+	ln -s a $dir/symlink
+	ln -s abcdefghijklmnopqrstuvwxyz $dir/symlink2
+	ln -s $maxname $dir/symlink3
+	mkdir $dir/subdir
+	mkdir $dir/subdir/subsubdir
+done
+# Diff encrypted directory with unencrypted reference directory
+diff -r $SCRATCH_MNT/edir $SCRATCH_MNT/ref_dir
+# Cycle mount and diff again
+_scratch_cycle_mount
+diff -r $SCRATCH_MNT/edir $SCRATCH_MNT/ref_dir
+
+#
+# Now try accessing the files without the encryption key.  It should still be
+# possible to list the directory and remove files.  But filenames should be
+# encrypted, and it should not be possible to read regular files or to create
+# new files or subdirectories.
+#
+# Note that we cannot simply use ls -R to verify the files because the encrypted
+# filenames are unpredictable.  By design, the key used to encrypt a directory's
+# filenames is derived from the master key (the key in the keyring) and a nonce
+# generated by the kernel.  Hence, the encrypted filenames will be different
+# every time this test is run, even if we were to put a fixed key into the
+# keyring instead of a random one.  The same applies to symlink targets.
+#
+# Also, there are some inconsistencies in which error codes are returned on
+# different kernel versions and filesystems when trying to create a file or
+# subdirectory without access to the parent directory's encryption key.  For now
+# we just accept multiple error codes.
+#
+_unlink_encryption_key $keydesc
+_scratch_cycle_mount
+
+# Check that unencrypted names aren't there
+stat $SCRATCH_MNT/edir/empty |& _filter_scratch
+stat $SCRATCH_MNT/edir/symlink |& _filter_scratch
+
+# Check that the correct numbers of files and subdirectories are there
+ls $SCRATCH_MNT/edir | wc -l
+find $SCRATCH_MNT/edir -mindepth 2 -maxdepth 2 -type d | wc -l
+
+# Try to read a nondirectory file (should fail with ENOKEY)
+md5sum $(find $SCRATCH_MNT/edir -maxdepth 1 -type f | head -1) |& \
+		cut -d ' ' -f3-
+
+filter_enoent()
+{
+	sed -e 's/No such file or directory/Permission denied/'
+}
+
+filter_eperm()
+{
+	sed -e 's/Operation not permitted/Permission denied/'
+}
+
+# Try to create new files and directories in the encrypted directory, both with
+# and without using correctly base-64 encoded filenames.  These should all fail.
+$XFS_IO_PROG -f $SCRATCH_MNT/edir/newfile |& filter_enoent | _filter_scratch
+mkdir $SCRATCH_MNT/edir/newdir |& filter_enoent | _filter_scratch
+$XFS_IO_PROG -f $SCRATCH_MNT/edir/0123456789abcdef |& filter_eperm | _filter_scratch
+mkdir $SCRATCH_MNT/edir/0123456789abcdef |& filter_eperm | _filter_scratch
+
+# Delete the encrypted directory (should succeed)
+rm -r $SCRATCH_MNT/edir
+stat $SCRATCH_MNT/edir |& _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/402.out b/tests/generic/402.out
new file mode 100644
index 0000000..700d056
--- /dev/null
+++ b/tests/generic/402.out
@@ -0,0 +1,11 @@
+QA output created by 402
+stat: cannot stat 'SCRATCH_MNT/edir/empty': No such file or directory
+stat: cannot stat 'SCRATCH_MNT/edir/symlink': No such file or directory
+8
+1
+Required key not available
+SCRATCH_MNT/edir/newfile: Permission denied
+mkdir: cannot create directory 'SCRATCH_MNT/edir/newdir': Permission denied
+SCRATCH_MNT/edir/0123456789abcdef: Permission denied
+mkdir: cannot create directory 'SCRATCH_MNT/edir/0123456789abcdef': Permission denied
+stat: cannot stat 'SCRATCH_MNT/edir': No such file or directory
diff --git a/tests/generic/group b/tests/generic/group
index a3438cf..7af053d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -396,3 +396,4 @@
 391 auto quick rw
 400 auto quick encrypt
 401 auto quick encrypt
+402 auto quick encrypt
-- 
2.8.0.rc3.226.g39d4020

