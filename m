Received: from mail-pg0-f53.google.com ([74.125.83.53]:33487 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755337AbcK1WRZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Nov 2016 17:17:25 -0500
Received: by mail-pg0-f53.google.com with SMTP id 3so61393473pgd.0
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2016 14:17:24 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 2/5] generic: test setting and getting encryption policies
Date: Mon, 28 Nov 2016 14:16:39 -0800
Message-Id: <1480371402-12204-3-git-send-email-ebiggers@google.com>
In-Reply-To: <1480371402-12204-1-git-send-email-ebiggers@google.com>
References: <1480371402-12204-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Several kernel bugs were recently fixed regarding the constraints for
setting encryption policies.  Add tests for these cases and a few more.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/400     | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/400.out |  43 +++++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 170 insertions(+)
 create mode 100755 tests/generic/400
 create mode 100644 tests/generic/400.out

diff --git a/tests/generic/400 b/tests/generic/400
new file mode 100755
index 0000000..5baf5e7
--- /dev/null
+++ b/tests/generic/400
@@ -0,0 +1,126 @@
+#! /bin/bash
+# FS QA Test generic/400
+#
+# Test setting and getting encryption policies.
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
+_require_xfs_io_command "get_encpolicy"
+_require_xfs_io_command "set_encpolicy"
+_require_scratch
+_require_encryption
+_require_user
+
+_scratch_mkfs_encrypted >> $seqres.full
+_scratch_mount
+cd $SCRATCH_MNT
+
+check_no_policy()
+{
+	# When a file is unencrypted, FS_IOC_GET_ENCRYPTION_POLICY currently
+	# fails with ENOENT on ext4 but with ENODATA on f2fs.  It's planned to
+	# consistently use ENODATA, but for now make this test accept both.
+	$XFS_IO_PROG -c "get_encpolicy" $1 |&
+		sed -e 's/No such file or directory/No data available/'
+}
+
+# Should be able to set an encryption policy on an empty directory
+echo -e "\n*** Setting encryption policy on empty directory ***"
+mkdir empty_dir
+check_no_policy empty_dir
+$XFS_IO_PROG -c "set_encpolicy 0000111122223333" empty_dir
+$XFS_IO_PROG -c "get_encpolicy" empty_dir
+
+# Should be able to set the same policy again, but not a different one
+echo -e "\n*** Setting encryption policy again ***"
+$XFS_IO_PROG -c "set_encpolicy 0000111122223333" empty_dir
+$XFS_IO_PROG -c "get_encpolicy" empty_dir
+$XFS_IO_PROG -c "set_encpolicy 4444555566667777" empty_dir
+$XFS_IO_PROG -c "get_encpolicy" empty_dir
+
+# Should *not* be able to set an encryption policy on a nonempty directory
+echo -e "\n*** Setting encryption policy on nonempty directory ***"
+mkdir nonempty_dir
+touch nonempty_dir/file
+$XFS_IO_PROG -c "set_encpolicy" nonempty_dir
+check_no_policy nonempty_dir
+
+# Should *not* be able to set an encryption policy on a nondirectory file, even
+# an empty one.  Regression test for 002ced4be642: "fscrypto: only allow setting
+# encryption policy on directories".
+echo -e "\n*** Setting encryption policy on nondirectory ***"
+touch nondirectory
+$XFS_IO_PROG -c "set_encpolicy" nondirectory
+check_no_policy nondirectory
+
+# Should *not* be able to set an encryption policy on another user's directory.
+# Regression test for 163ae1c6ad62: "fscrypto: add authorization check for
+# setting encryption policy".
+echo -e "\n*** Setting encryption policy on another user's directory ***"
+mkdir unauthorized_dir
+su $qa_user -c "$XFS_IO_PROG -c \"set_encpolicy\" unauthorized_dir"
+check_no_policy unauthorized_dir
+
+# Should *not* be able to set an encryption policy on a directory on a
+# filesystem mounted readonly.  Regression test for ba63f23d69a3: "fscrypto:
+# require write access to mount to set encryption policy".  Test both a regular
+# readonly filesystem and a readonly bind mount of a read-write filesystem.
+echo -e "\n*** Setting encryption policy on readonly filesystem ***"
+mkdir ro_dir ro_bind_mnt
+_scratch_remount ro
+$XFS_IO_PROG -c "set_encpolicy" ro_dir
+check_no_policy ro_dir
+_scratch_remount rw
+mount --bind $SCRATCH_MNT ro_bind_mnt
+mount -o remount,ro ro_bind_mnt
+$XFS_IO_PROG -c "set_encpolicy" ro_bind_mnt/ro_dir
+check_no_policy ro_bind_mnt/ro_dir
+umount ro_bind_mnt
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/400.out b/tests/generic/400.out
new file mode 100644
index 0000000..79dc596
--- /dev/null
+++ b/tests/generic/400.out
@@ -0,0 +1,43 @@
+QA output created by 400
+
+*** Setting encryption policy on empty directory ***
+empty_dir: failed to get encryption policy: No data available
+Encryption policy for empty_dir:
+	Policy version: 0
+	Master key descriptor: 0000111122223333
+	Contents encryption mode: 1 (AES-256-XTS)
+	Filenames encryption mode: 4 (AES-256-CTS)
+	Flags: 0x02
+
+*** Setting encryption policy again ***
+Encryption policy for empty_dir:
+	Policy version: 0
+	Master key descriptor: 0000111122223333
+	Contents encryption mode: 1 (AES-256-XTS)
+	Filenames encryption mode: 4 (AES-256-CTS)
+	Flags: 0x02
+empty_dir: failed to set encryption policy: Invalid argument
+Encryption policy for empty_dir:
+	Policy version: 0
+	Master key descriptor: 0000111122223333
+	Contents encryption mode: 1 (AES-256-XTS)
+	Filenames encryption mode: 4 (AES-256-CTS)
+	Flags: 0x02
+
+*** Setting encryption policy on nonempty directory ***
+nonempty_dir: failed to set encryption policy: Directory not empty
+nonempty_dir: failed to get encryption policy: No data available
+
+*** Setting encryption policy on nondirectory ***
+nondirectory: failed to set encryption policy: Invalid argument
+nondirectory: failed to get encryption policy: No data available
+
+*** Setting encryption policy on another user's directory ***
+unauthorized_dir: failed to set encryption policy: Permission denied
+unauthorized_dir: failed to get encryption policy: No data available
+
+*** Setting encryption policy on readonly filesystem ***
+ro_dir: failed to set encryption policy: Read-only file system
+ro_dir: failed to get encryption policy: No data available
+ro_bind_mnt/ro_dir: failed to set encryption policy: Read-only file system
+ro_bind_mnt/ro_dir: failed to get encryption policy: No data available
diff --git a/tests/generic/group b/tests/generic/group
index 2c16bd1..3f148a2 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -394,3 +394,4 @@
 389 auto quick acl
 390 auto freeze stress dangerous
 391 auto quick rw
+400 auto quick encrypt
-- 
2.8.0.rc3.226.g39d4020

