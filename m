Received: from mail-pf0-f194.google.com ([209.85.192.194]:34226 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758250AbdCUVQK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Mar 2017 17:16:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so23782735pfb.1
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2017 14:16:09 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2] generic: test renaming encrypted files without key
Date: Tue, 21 Mar 2017 14:14:32 -0700
Message-Id: <20170321211432.96524-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add a new test to test another behavior when accessing encrypted files
without the key: renames should be forbidden, even though they may be
possible cryptographically.  Test both a regular rename and a cross
rename.  (It happens that generic/398 also covers the cross rename case,
but it's primarily for a different reason.)

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/533     | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/533.out |  3 ++
 tests/generic/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/generic/533
 create mode 100644 tests/generic/533.out

diff --git a/tests/generic/533 b/tests/generic/533
new file mode 100755
index 00000000..6d8b323b
--- /dev/null
+++ b/tests/generic/533
@@ -0,0 +1,84 @@
+#! /bin/bash
+# FS QA Test generic/533
+#
+# Try to rename files in an encrypted directory, without access to the
+# encryption key.  This should fail with ENOKEY.  Test both a regular rename and
+# a cross rename.  This is a regression test for:
+#	173b8439e1ba ("ext4: don't allow encrypted operations without keys")
+#	363fa4e078cb ("f2fs: don't allow encrypted operations without keys")
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
+_require_command "$KEYCTL_PROG" keyctl
+_requires_renameat2
+
+_new_session_keyring
+
+_scratch_mkfs_encrypted &>> $seqres.full
+_scratch_mount
+
+mkdir $SCRATCH_MNT/edir
+keydesc=$(_generate_encryption_key)
+$XFS_IO_PROG -c "set_encpolicy $keydesc" $SCRATCH_MNT/edir
+echo a > $SCRATCH_MNT/edir/a
+echo b > $SCRATCH_MNT/edir/b
+_unlink_encryption_key $keydesc
+_scratch_cycle_mount
+
+# Note that because encrypted filenames are unpredictable, this needs to be
+# written in a way that does not assume any particular filenames.
+efile1=$(find $SCRATCH_MNT/edir -maxdepth 1 -type f | head -1)
+efile2=$(find $SCRATCH_MNT/edir -maxdepth 1 -type f | tail -1)
+mv $efile1 $efile2 |& _filter_scratch | sed 's|edir/[a-zA-Z0-9+,_]\+|edir/FILENAME|g'
+src/renameat2 -x $efile1 $efile2
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/533.out b/tests/generic/533.out
new file mode 100644
index 00000000..7db871be
--- /dev/null
+++ b/tests/generic/533.out
@@ -0,0 +1,3 @@
+QA output created by 533
+mv: cannot move 'SCRATCH_MNT/edir/FILENAME' to 'SCRATCH_MNT/edir/FILENAME': Required key not available
+Required key not available
diff --git a/tests/generic/group b/tests/generic/group
index f0096bbc..383ad1e9 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -420,3 +420,4 @@
 415 auto clone
 416 auto enospc
 417 auto quick shutdown log
+533 auto quick encrypt
-- 
2.12.1.500.gab5fba24ee-goog

