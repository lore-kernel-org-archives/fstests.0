Received: from mail-pf0-f170.google.com ([209.85.192.170]:32943 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbcLETXb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Dec 2016 14:23:31 -0500
Received: by mail-pf0-f170.google.com with SMTP id d2so65137146pfd.0
        for <fstests@vger.kernel.org>; Mon, 05 Dec 2016 11:23:30 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v3 6/6] generic: test for weaknesses in filesystem encryption
Date: Mon,  5 Dec 2016 11:21:09 -0800
Message-Id: <1480965669-39714-7-git-send-email-ebiggers@google.com>
In-Reply-To: <1480965669-39714-1-git-send-email-ebiggers@google.com>
References: <1480965669-39714-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Add an xfstest which can detect some basic crypto mistakes that would
reduce the confidentiality guarantee provided by filesystem encryption.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/config         |   1 +
 tests/generic/404     | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/404.out |   3 +
 tests/generic/group   |   1 +
 4 files changed, 168 insertions(+)
 create mode 100755 tests/generic/404
 create mode 100644 tests/generic/404.out

diff --git a/common/config b/common/config
index 3727ec0..6cce7ce 100644
--- a/common/config
+++ b/common/config
@@ -203,6 +203,7 @@ export UUIDGEN_PROG="`set_prog_path uuidgen`"
 export GETRICHACL_PROG="`set_prog_path getrichacl`"
 export SETRICHACL_PROG="`set_prog_path setrichacl`"
 export KEYCTL_PROG="`set_prog_path keyctl`"
+export XZ_PROG="`set_prog_path xz`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/tests/generic/404 b/tests/generic/404
new file mode 100755
index 0000000..7b0e842
--- /dev/null
+++ b/tests/generic/404
@@ -0,0 +1,163 @@
+#! /bin/bash
+# FS QA Test generic/404
+#
+# Check for weaknesses in filesystem encryption involving the same ciphertext
+# being repeated.  For file contents, we fill a small filesystem with large
+# files of 0's and verify the filesystem is incompressible.  For filenames, we
+# create an identical symlink in two different directories and verify the
+# ciphertext filenames and symlink targets are different.
+#
+# This test can detect some basic cryptographic mistakes such as nonce reuse
+# (across files), initialization vector reuse (across blocks), or data somehow
+# being left in plaintext by accident.  For example, it detects the
+# initialization vector reuse bug fixed in commit 02fc59a0d28f ("f2fs/crypto:
+# fix xts_tweak initialization").
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
+_require_command "$XZ_PROG" xz
+_require_command "$KEYCTL_PROG" keyctl
+_require_encryption
+
+_new_session_keyring
+
+# Set up a small filesystem containing an encrypted directory.  64 MB is enough
+# for both ext4 and f2fs.  (f2fs doesn't support a 32 MB filesystem.)
+fs_size_in_mb=64
+fs_size=$((fs_size_in_mb * 1024 * 1024))
+dd if=/dev/zero of=$SCRATCH_DEV bs=$((1024 * 1024)) \
+	count=$fs_size_in_mb &>> $seqres.full
+MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" \
+	_scratch_mkfs_sized $fs_size &>> $seqres.full
+_scratch_mount
+
+keydesc=$(_generate_encryption_key)
+mkdir $SCRATCH_MNT/encrypted_dir
+$XFS_IO_PROG -c "set_encpolicy $keydesc" $SCRATCH_MNT/encrypted_dir
+
+# Create the "same" symlink in two different directories.
+# Later we'll check both the name and target of the symlink.
+mkdir $SCRATCH_MNT/encrypted_dir/subdir1
+mkdir $SCRATCH_MNT/encrypted_dir/subdir2
+ln -s symlink_target $SCRATCH_MNT/encrypted_dir/subdir1/symlink
+ln -s symlink_target $SCRATCH_MNT/encrypted_dir/subdir2/symlink
+
+#
+# Write files of 1 MB of all the same byte until we hit ENOSPC.  Note that we
+# must not create sparse files, since the contents of sparse files are not
+# stored on-disk.  Also, we create multiple files rather than one big file
+# because we want to test for reuse of per-file keys.
+#
+total_file_size=0
+i=1
+while true; do
+	file=$SCRATCH_MNT/encrypted_dir/file$i
+	if ! xfs_io -f $file -c 'pwrite 0 1M' &> $tmp.out; then
+		if ! grep -q 'No space left on device' $tmp.out; then
+			echo "FAIL: unexpected pwrite failure"
+			cat $tmp.out
+		elif [ -e $file ]; then
+			total_file_size=$((total_file_size + $(stat -c %s $file)))
+		fi
+		break
+	fi
+	total_file_size=$((total_file_size + $(stat -c %s $file)))
+	i=$((i + 1))
+	if [ $i -gt $fs_size_in_mb ]; then
+		echo "FAIL: filesystem never filled up!"
+		break
+	fi
+done
+
+# We shouldn't have been able to write more data than we had space for.
+if (( $total_file_size > $fs_size )); then
+	echo "FAIL: wrote $total_file_size bytes but should have only" \
+		"had space for $fs_size bytes at most"
+fi
+
+#
+# Unmount the filesystem and compute its compressed size.  It must be no smaller
+# than the amount of data that was written; otherwise there was a compromise in
+# the confidentiality of the data.  False positives should not be possible
+# because filesystem metadata will also contribute to the compressed size.
+#
+# Note: it's important to use a strong compressor such as xz which can detect
+# redundancy across most or all of the filesystem.  We run xz with a 64 MB
+# sliding window but use some custom settings to make it faster and use less
+# memory than the '-9' preset.  The memory needed with our settings will be
+# 64 * 6.5 = 416 MB; see xz(1).
+#
+_unlink_encryption_key $keydesc
+_scratch_unmount
+fs_compressed_size=$(head -c $fs_size $SCRATCH_DEV | \
+	xz --lzma2=dict=64M,mf=hc4,mode=fast,nice=16 | \
+	wc -c)
+
+if (( $fs_compressed_size < $total_file_size )); then
+	echo "FAIL: filesystem was compressible" \
+		"($total_file_size bytes => $fs_compressed_size bytes)"
+else
+	echo "PASS: ciphertexts were not repeated for contents"
+fi
+
+# Verify that encrypted filenames and symlink targets were not reused.  Note
+# that since the ciphertexts should be unpredictable, we cannot simply include
+# the expected names in the expected output file.
+_scratch_mount
+find $SCRATCH_MNT/encrypted_dir -type l | wc -l
+link1=$(find $SCRATCH_MNT/encrypted_dir -type l | head -1)
+link2=$(find $SCRATCH_MNT/encrypted_dir -type l | tail -1)
+[ $(basename $link1) = $(basename $link2) ] && \
+	echo "Encrypted filenames were reused!"
+[ $(readlink $link1) = $(readlink $link2) ] && \
+	echo "Encrypted symlink targets were reused!"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/404.out b/tests/generic/404.out
new file mode 100644
index 0000000..220edb4
--- /dev/null
+++ b/tests/generic/404.out
@@ -0,0 +1,3 @@
+QA output created by 404
+PASS: ciphertexts were not repeated for contents
+2
diff --git a/tests/generic/group b/tests/generic/group
index a0d6e84..d310654 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -400,3 +400,4 @@
 401 auto quick encrypt
 402 auto quick encrypt
 403 auto quick encrypt
+404 auto encrypt
-- 
2.8.0.rc3.226.g39d4020

