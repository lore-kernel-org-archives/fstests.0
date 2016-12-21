Received: from mail-pg0-f65.google.com ([74.125.83.65]:34583 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758168AbcLUVYj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 16:24:39 -0500
Received: by mail-pg0-f65.google.com with SMTP id b1so17563593pgc.1
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 13:24:38 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v5 5/6] generic: test enforcement of one encryption policy per tree
Date: Wed, 21 Dec 2016 13:22:01 -0800
Message-Id: <1482355322-74978-6-git-send-email-ebiggers3@gmail.com>
In-Reply-To: <1482355322-74978-1-git-send-email-ebiggers3@gmail.com>
References: <1482355322-74978-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Sandeen <sandeen@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add an xfstest which verifies that the filesystem forbids operations
that would violate the constraint that all files in an encrypted
directory tree use the same encryption policy.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/403     | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/403.out |  45 ++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 204 insertions(+)
 create mode 100644 tests/generic/403
 create mode 100644 tests/generic/403.out

diff --git a/tests/generic/403 b/tests/generic/403
new file mode 100644
index 0000000..0e06cc5
--- /dev/null
+++ b/tests/generic/403
@@ -0,0 +1,158 @@
+#! /bin/bash
+# FS QA Test generic/403
+#
+# Filesystem encryption is designed to enforce that a consistent encryption
+# policy is used within a given encrypted directory tree and that an encrypted
+# directory tree does not contain any unencrypted files.  This test verifies
+# that filesystem operations that would violate this constraint fail with EPERM.
+# This does not test enforcement of this constraint on lookup, which is still
+# needed to detect offline changes.
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
+. ./common/renameat2
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch_encryption
+_require_xfs_io_command "set_encpolicy"
+_requires_renameat2
+
+_new_session_keyring
+_scratch_mkfs_encrypted &>> $seqres.full
+_scratch_mount
+
+# Set up two encrypted directories, with different encryption policies,
+# and one unencrypted directory.
+edir1=$SCRATCH_MNT/edir1
+edir2=$SCRATCH_MNT/edir2
+udir=$SCRATCH_MNT/udir
+mkdir $edir1 $edir2 $udir
+keydesc1=$(_generate_encryption_key)
+keydesc2=$(_generate_encryption_key)
+$XFS_IO_PROG -c "set_encpolicy $keydesc1" $edir1
+$XFS_IO_PROG -c "set_encpolicy $keydesc2" $edir2
+touch $edir1/efile1
+touch $edir2/efile2
+touch $udir/ufile
+
+
+# Test linking and moving an encrypted file into an encrypted directory with a
+# different encryption policy.  Should fail with EPERM.
+
+echo -e "\n*** Link encrypted <= encrypted ***"
+ln $edir1/efile1 $edir2/efile1 |& _filter_scratch
+
+echo -e "\n*** Rename encrypted => encrypted ***"
+mv $edir1/efile1 $edir2/efile1 |& _filter_scratch
+
+
+# Test linking and moving an unencrypted file into an encrypted directory.
+# Should fail with EPERM.
+
+echo -e "\n\n*** Link unencrypted <= encrypted ***"
+ln $udir/ufile $edir1/ufile |& _filter_scratch
+
+echo -e "\n*** Rename unencrypted => encrypted ***"
+mv $udir/ufile $edir1/ufile |& _filter_scratch
+
+
+# Test linking and moving an encrypted file into an unencrypted directory.
+# Should succeed.
+
+echo -e "\n\n*** Link encrypted <= unencrypted ***"
+ln -v $edir1/efile1 $udir/efile1 |& _filter_scratch
+rm $udir/efile1 # undo
+
+echo -e "\n*** Rename encrypted => unencrypted ***"
+mv -v $edir1/efile1 $udir/efile1 |& _filter_scratch
+mv $udir/efile1 $edir1/efile1 # undo
+
+
+# Test moving a forbidden (unencrypted, or encrypted with a different encryption
+# policy) file into an encrypted directory via an exchange (cross rename)
+# operation.  Should fail with EPERM.
+
+echo -e "\n\n*** Exchange encrypted <=> encrypted ***"
+src/renameat2 -x $edir1/efile1 $edir2/efile2 |& _filter_scratch
+
+echo -e "\n*** Exchange unencrypted <=> encrypted ***"
+src/renameat2 -x $udir/ufile $edir1/efile1 |& _filter_scratch
+
+echo -e "\n*** Exchange encrypted <=> unencrypted ***"
+src/renameat2 -x $edir1/efile1 $udir/ufile |& _filter_scratch
+
+
+# Test a file with a special type, i.e. not regular, directory, or symlink.
+# Since such files are not subject to encryption, there should be no
+# restrictions on linking or moving them into encrypted directories.
+
+echo -e "\n\n*** Special file tests ***"
+mkfifo $edir1/fifo
+mv -v $edir1/fifo $edir2/fifo | _filter_scratch
+mv -v $edir2/fifo $udir/fifo | _filter_scratch
+mv -v $udir/fifo $edir1/fifo | _filter_scratch
+mkfifo $udir/fifo
+src/renameat2 -x $udir/fifo $edir1/fifo
+ln -v $edir1/fifo $edir2/fifo | _filter_scratch
+rm $edir1/fifo $edir2/fifo $udir/fifo
+
+
+# Now test that *without* access to the encrypted key, we cannot use an exchange
+# (cross rename) operation to move a forbidden file into an encrypted directory.
+
+_unlink_encryption_key $keydesc1
+_unlink_encryption_key $keydesc2
+_scratch_cycle_mount
+efile1=$(find $edir1 -type f)
+efile2=$(find $edir2 -type f)
+
+echo -e "\n\n*** Exchange encrypted <=> encrypted without key ***"
+src/renameat2 -x $efile1 $efile2
+echo -e "\n*** Exchange encrypted <=> unencrypted without key ***"
+src/renameat2 -x $efile1 $udir/ufile
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/403.out b/tests/generic/403.out
new file mode 100644
index 0000000..22d3255
--- /dev/null
+++ b/tests/generic/403.out
@@ -0,0 +1,45 @@
+QA output created by 403
+
+*** Link encrypted <= encrypted ***
+ln: failed to create hard link 'SCRATCH_MNT/edir2/efile1' => 'SCRATCH_MNT/edir1/efile1': Operation not permitted
+
+*** Rename encrypted => encrypted ***
+mv: cannot move 'SCRATCH_MNT/edir1/efile1' to 'SCRATCH_MNT/edir2/efile1': Operation not permitted
+
+
+*** Link unencrypted <= encrypted ***
+ln: failed to create hard link 'SCRATCH_MNT/edir1/ufile' => 'SCRATCH_MNT/udir/ufile': Operation not permitted
+
+*** Rename unencrypted => encrypted ***
+mv: cannot move 'SCRATCH_MNT/udir/ufile' to 'SCRATCH_MNT/edir1/ufile': Operation not permitted
+
+
+*** Link encrypted <= unencrypted ***
+'SCRATCH_MNT/udir/efile1' => 'SCRATCH_MNT/edir1/efile1'
+
+*** Rename encrypted => unencrypted ***
+'SCRATCH_MNT/edir1/efile1' -> 'SCRATCH_MNT/udir/efile1'
+
+
+*** Exchange encrypted <=> encrypted ***
+Operation not permitted
+
+*** Exchange unencrypted <=> encrypted ***
+Operation not permitted
+
+*** Exchange encrypted <=> unencrypted ***
+Operation not permitted
+
+
+*** Special file tests ***
+'SCRATCH_MNT/edir1/fifo' -> 'SCRATCH_MNT/edir2/fifo'
+'SCRATCH_MNT/edir2/fifo' -> 'SCRATCH_MNT/udir/fifo'
+'SCRATCH_MNT/udir/fifo' -> 'SCRATCH_MNT/edir1/fifo'
+'SCRATCH_MNT/edir2/fifo' => 'SCRATCH_MNT/edir1/fifo'
+
+
+*** Exchange encrypted <=> encrypted without key ***
+Operation not permitted
+
+*** Exchange encrypted <=> unencrypted without key ***
+Operation not permitted
diff --git a/tests/generic/group b/tests/generic/group
index 8350af7..15acd25 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -400,3 +400,4 @@
 400 auto quick encrypt
 401 auto quick encrypt
 402 auto quick encrypt
+403 auto quick encrypt
-- 
2.8.0.rc3.226.g39d4020

