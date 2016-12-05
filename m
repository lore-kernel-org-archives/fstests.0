Received: from mail-pf0-f170.google.com ([209.85.192.170]:36758 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcLETX3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Dec 2016 14:23:29 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so65153567pfz.3
        for <fstests@vger.kernel.org>; Mon, 05 Dec 2016 11:23:28 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v3 5/6] generic: test enforcement of one encryption policy per tree
Date: Mon,  5 Dec 2016 11:21:08 -0800
Message-Id: <1480965669-39714-6-git-send-email-ebiggers@google.com>
In-Reply-To: <1480965669-39714-1-git-send-email-ebiggers@google.com>
References: <1480965669-39714-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Add an xfstest which partially verifies that the filesystem enforces
that all files in an encrypted directory tree use the same encryption
policy.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/403     | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/403.out |  34 +++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 165 insertions(+)
 create mode 100644 tests/generic/403
 create mode 100644 tests/generic/403.out

diff --git a/tests/generic/403 b/tests/generic/403
new file mode 100644
index 0000000..77427b8
--- /dev/null
+++ b/tests/generic/403
@@ -0,0 +1,130 @@
+#! /bin/bash
+# FS QA Test generic/403
+#
+# Filesystem encryption is designed to enforce that a consistent encryption
+# policy is used within a given encrypted directory tree and that an encrypted
+# directory tree does not contain any unencrypted files.  This test verifies
+# that filesystem operations that would violate this constraint fail with EPERM.
+# This does not yet test enforcement of this constraint on lookup, which is
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
+_supported_fs ext4 f2fs
+_supported_os Linux
+_require_xfs_io_command "set_encpolicy"
+_require_scratch
+_require_encryption
+_requires_renameat2
+
+_new_session_keyring
+_scratch_mkfs_encrypted >> $seqres.full
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
+echo -e "\n*** Link encrypted <= encrypted ***"
+ln $edir1/efile1 $edir2/efile1 |& _filter_scratch
+
+echo -e "\n*** Rename encrypted => encrypted ***"
+mv $edir1/efile1 $edir2/efile1 |& _filter_scratch
+
+echo -e "\n*** Exchange encrypted <=> encrypted ***"
+src/renameat2 -x $edir1/efile1 $edir2/efile2 |& _filter_scratch
+
+
+echo -e "\n\n*** Link unencrypted <= encrypted ***"
+ln $udir/ufile $edir1/ufile |& _filter_scratch
+
+echo -e "\n*** Rename unencrypted => encrypted ***"
+mv $udir/ufile $edir1/ufile |& _filter_scratch
+
+echo -e "\n*** Exchange unencrypted <=> encrypted ***"
+src/renameat2 -x $udir/ufile $edir1/efile1 |& _filter_scratch
+
+
+echo -e "\n\n*** Link encrypted <= unencrypted ***"
+ln -v $edir1/efile1 $udir/efile1 |& _filter_scratch # should succeed
+rm $udir/efile1 # undo
+
+echo -e "\n*** Rename encrypted => unencrypted ***"
+mv -v $edir1/efile1 $udir/efile1 |& _filter_scratch # should succeed
+mv $udir/efile1 $edir1/efile1 # undo
+
+echo -e "\n*** Exchange encrypted <=> unencrypted ***"
+src/renameat2 -x $edir1/efile1 $udir/ufile |& _filter_scratch
+
+# Now test the cases where we don't have access to the encryption keys.
+
+_unlink_encryption_key $keydesc1
+_unlink_encryption_key $keydesc2
+_scratch_cycle_mount
+efile1=$(find $edir1 -type f)
+efile2=$(find $edir2 -type f)
+echo
+
+# TODO: this currently succeeds.  It should fail.  Fix this kernel-side.
+#echo -e "\n*** Exchange encrypted <=> encrypted without key ***"
+#src/renameat2 -x $efile1 $efile2
+
+echo -e "\n*** Exchange encrypted <=> unencrypted without key ***"
+src/renameat2 -x $efile1 $udir/ufile
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/403.out b/tests/generic/403.out
new file mode 100644
index 0000000..27ed8cb
--- /dev/null
+++ b/tests/generic/403.out
@@ -0,0 +1,34 @@
+QA output created by 403
+
+*** Link encrypted <= encrypted ***
+ln: failed to create hard link 'SCRATCH_MNT/edir2/efile1' => 'SCRATCH_MNT/edir1/efile1': Operation not permitted
+
+*** Rename encrypted => encrypted ***
+mv: cannot move 'SCRATCH_MNT/edir1/efile1' to 'SCRATCH_MNT/edir2/efile1': Operation not permitted
+
+*** Exchange encrypted <=> encrypted ***
+Operation not permitted
+
+
+*** Link unencrypted <= encrypted ***
+ln: failed to create hard link 'SCRATCH_MNT/edir1/ufile' => 'SCRATCH_MNT/udir/ufile': Operation not permitted
+
+*** Rename unencrypted => encrypted ***
+mv: cannot move 'SCRATCH_MNT/udir/ufile' to 'SCRATCH_MNT/edir1/ufile': Operation not permitted
+
+*** Exchange unencrypted <=> encrypted ***
+Operation not permitted
+
+
+*** Link encrypted <= unencrypted ***
+'SCRATCH_MNT/udir/efile1' => 'SCRATCH_MNT/edir1/efile1'
+
+*** Rename encrypted => unencrypted ***
+'SCRATCH_MNT/edir1/efile1' -> 'SCRATCH_MNT/udir/efile1'
+
+*** Exchange encrypted <=> unencrypted ***
+Operation not permitted
+
+
+*** Exchange encrypted <=> unencrypted without key ***
+Operation not permitted
diff --git a/tests/generic/group b/tests/generic/group
index e218380..a0d6e84 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -399,3 +399,4 @@
 400 auto quick encrypt
 401 auto quick encrypt
 402 auto quick encrypt
+403 auto quick encrypt
-- 
2.8.0.rc3.226.g39d4020

