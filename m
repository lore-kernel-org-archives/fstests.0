Received: from mail-pg0-f67.google.com ([74.125.83.67]:34556 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbcLOU2R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Dec 2016 15:28:17 -0500
Received: by mail-pg0-f67.google.com with SMTP id e9so7200665pgc.1
        for <fstests@vger.kernel.org>; Thu, 15 Dec 2016 12:28:17 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v4 4/6] generic: test encrypted file access
Date: Thu, 15 Dec 2016 12:26:23 -0800
Message-Id: <1481833585-39148-5-git-send-email-ebiggers3@gmail.com>
In-Reply-To: <1481833585-39148-1-git-send-email-ebiggers3@gmail.com>
References: <1481833585-39148-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Sandeen <sandeen@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Test accessing encrypted files and directories, both with and without
the encryption key.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/402     | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/402.out |  13 +++++
 tests/generic/group   |   1 +
 3 files changed, 158 insertions(+)
 create mode 100755 tests/generic/402
 create mode 100644 tests/generic/402.out

diff --git a/tests/generic/402 b/tests/generic/402
new file mode 100755
index 0000000..8f37f9f
--- /dev/null
+++ b/tests/generic/402
@@ -0,0 +1,144 @@
+#! /bin/bash
+# FS QA Test generic/402
+#
+# Test accessing encrypted files and directories, both with and without the
+# encryption key.  Access with the encryption key is more of a sanity check and
+# is not intended to fully test all the encrypted I/O paths; to do that you'd
+# need to run all the xfstests with encryption enabled.  Access without the
+# encryption key, on the other hand, should result in some particular behaviors.
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
+_supported_fs generic
+_supported_os Linux
+_require_scratch_encryption
+_require_xfs_io_command "set_encpolicy"
+_require_command "$KEYCTL_PROG" keyctl
+
+_new_session_keyring
+
+_scratch_mkfs_encrypted &>> $seqres.full
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
+# TODO: there are some inconsistencies in which error codes are returned on
+# different kernel versions and filesystems when trying to create a file or
+# subdirectory without access to the parent directory's encryption key.  It's
+# planned to consistently use ENOKEY, but for now make this test accept multiple
+# error codes...
+#
+
+filter_create_errors()
+{
+	sed -e 's/No such file or directory/Required key not available/' \
+	    -e 's/Permission denied/Required key not available/' \
+	    -e 's/Operation not permitted/Required key not available/'
+}
+
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
+# Try to create new files, directories, and symlinks in the encrypted directory,
+# both with and without using correctly base-64 encoded filenames.  These should
+# all fail with ENOKEY.
+$XFS_IO_PROG -f $SCRATCH_MNT/edir/newfile |& filter_create_errors | _filter_scratch
+$XFS_IO_PROG -f $SCRATCH_MNT/edir/0123456789abcdef |& filter_create_errors | _filter_scratch
+mkdir $SCRATCH_MNT/edir/newdir |& filter_create_errors | _filter_scratch
+mkdir $SCRATCH_MNT/edir/0123456789abcdef |& filter_create_errors | _filter_scratch
+ln -s foo $SCRATCH_MNT/edir/newlink |& filter_create_errors | _filter_scratch
+ln -s foo $SCRATCH_MNT/edir/0123456789abcdef |& filter_create_errors | _filter_scratch
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
index 0000000..8573474
--- /dev/null
+++ b/tests/generic/402.out
@@ -0,0 +1,13 @@
+QA output created by 402
+stat: cannot stat 'SCRATCH_MNT/edir/empty': No such file or directory
+stat: cannot stat 'SCRATCH_MNT/edir/symlink': No such file or directory
+8
+1
+Required key not available
+SCRATCH_MNT/edir/newfile: Required key not available
+SCRATCH_MNT/edir/0123456789abcdef: Required key not available
+mkdir: cannot create directory 'SCRATCH_MNT/edir/newdir': Required key not available
+mkdir: cannot create directory 'SCRATCH_MNT/edir/0123456789abcdef': Required key not available
+ln: failed to create symbolic link 'SCRATCH_MNT/edir/newlink': Required key not available
+ln: failed to create symbolic link 'SCRATCH_MNT/edir/0123456789abcdef': Required key not available
+stat: cannot stat 'SCRATCH_MNT/edir': No such file or directory
diff --git a/tests/generic/group b/tests/generic/group
index a455c29..e218380 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -398,3 +398,4 @@
 393 auto quick rw
 400 auto quick encrypt
 401 auto quick encrypt
+402 auto quick encrypt
-- 
2.8.0.rc3.226.g39d4020

