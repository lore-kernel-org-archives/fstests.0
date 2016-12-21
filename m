Received: from mail-pg0-f66.google.com ([74.125.83.66]:34562 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758119AbcLUVYg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 16:24:36 -0500
Received: by mail-pg0-f66.google.com with SMTP id b1so17563492pgc.1
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 13:24:35 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v5 1/6] generic: add utilities for testing filesystem encryption
Date: Wed, 21 Dec 2016 13:21:57 -0800
Message-Id: <1482355322-74978-2-git-send-email-ebiggers3@gmail.com>
In-Reply-To: <1482355322-74978-1-git-send-email-ebiggers3@gmail.com>
References: <1482355322-74978-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Sandeen <sandeen@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add utility functions for testing filesystem-level encryption via the
common API currently supported by ext4 and f2fs, in development for
ubifs and planned for xfs.  Setting and getting encryption policies will
use new commands being added to xfs_io, while adding and removing
encryption keys will use keyctl.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/config  |   1 +
 common/encrypt | 146 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 common/encrypt

diff --git a/common/config b/common/config
index f0f08d2..3727ec0 100644
--- a/common/config
+++ b/common/config
@@ -202,6 +202,7 @@ export DEBUGFS_PROG="`set_prog_path debugfs`"
 export UUIDGEN_PROG="`set_prog_path uuidgen`"
 export GETRICHACL_PROG="`set_prog_path getrichacl`"
 export SETRICHACL_PROG="`set_prog_path setrichacl`"
+export KEYCTL_PROG="`set_prog_path keyctl`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/common/encrypt b/common/encrypt
new file mode 100644
index 0000000..f09104d
--- /dev/null
+++ b/common/encrypt
@@ -0,0 +1,146 @@
+#-----------------------------------------------------------------------
+#
+# Common functions for testing filesystem-level encryption
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
+
+_require_scratch_encryption()
+{
+	_require_scratch
+
+	_require_xfs_io_command "set_encpolicy"
+
+	# The 'test_dummy_encryption' mount option interferes with trying to use
+	# encryption for real, even if we are just trying to get/set policies
+	# and never put any keys in the keyring.  So skip the real encryption
+	# tests if the 'test_dummy_encryption' mount option was specified.
+	_exclude_scratch_mount_option "test_dummy_encryption"
+
+	# Make a filesystem on the scratch device with the encryption feature
+	# enabled.  If this fails then probably the userspace tools (e.g.
+	# e2fsprogs or f2fs-tools) are too old to understand encryption.
+	if ! _scratch_mkfs_encrypted &>>$seqres.full; then
+		_notrun "$FSTYP userspace tools do not support encryption"
+	fi
+
+	# Try to mount the filesystem.  If this fails then either the kernel
+	# isn't aware of encryption, or the mkfs options were not compatible
+	# with encryption (e.g. ext4 with block size != PAGE_SIZE).
+	if ! _scratch_mount &>>$seqres.full; then
+		_notrun "kernel is unaware of $FSTYP encryption feature," \
+			"or mkfs options are not compatible with encryption"
+	fi
+
+	# The kernel may be aware of encryption without supporting it.  For
+	# example, for ext4 this is the case with kernels configured with
+	# CONFIG_EXT4_FS_ENCRYPTION=n.  Detect support for encryption by trying
+	# to set an encryption policy.  (For ext4 we could instead check for the
+	# presence of /sys/fs/ext4/features/encryption, but this is broken on
+	# some older kernels and is ext4-specific anyway.)
+	mkdir $SCRATCH_MNT/tmpdir
+	if $XFS_IO_PROG -c set_encpolicy $SCRATCH_MNT/tmpdir \
+		2>&1 >>$seqres.full | \
+		egrep -q 'Inappropriate ioctl for device|Operation not supported'
+	then
+		_notrun "kernel does not support $FSTYP encryption"
+	fi
+	rmdir $SCRATCH_MNT/tmpdir
+	_scratch_unmount
+}
+
+_scratch_mkfs_encrypted()
+{
+	case $FSTYP in
+	ext4|f2fs)
+		_scratch_mkfs -O encrypt
+		;;
+	*)
+		_notrun "No encryption support for $FSTYP"
+		;;
+	esac
+}
+
+# Give the invoking shell a new session keyring.  This makes any keys we add to
+# the session keyring scoped to the lifetime of the test script.
+_new_session_keyring()
+{
+	$KEYCTL_PROG new_session >>$seqres.full
+}
+
+#
+# Generate a random encryption key, add it to the session keyring, and print out
+# the resulting key descriptor (example: "8bf798e1a494e1ec").  Requires the
+# keyctl program.  It's assumed the caller has already set up a test-scoped
+# session keyring using _new_session_keyring.
+#
+_generate_encryption_key()
+{
+	# Generate a key descriptor (16 character hex string)
+	local keydesc=""
+	for ((i = 0; i < 8; i++)); do
+		keydesc="${keydesc}$(printf "%02x" $(( $RANDOM % 256 )))"
+	done
+
+	# Generate the actual encryption key (64 bytes)
+	local raw=""
+	for ((i = 0; i < 64; i++)); do
+		raw="${raw}\\x$(printf "%02x" $(( $RANDOM % 256 )))"
+	done
+
+	#
+	# Add the key to the session keyring.  The required structure is:
+	#
+	#	#define FS_MAX_KEY_SIZE 64
+	#	struct fscrypt_key {
+	#		u32 mode;
+	#		u8 raw[FS_MAX_KEY_SIZE];
+	#		u32 size;
+	#	} __packed;
+	#
+	# The kernel ignores 'mode' but requires that 'size' be 64.
+	#
+	# Keys are named $FSTYP:KEYDESC where KEYDESC is the 16-character key
+	# descriptor hex string.  Newer kernels (ext4 4.8 and later, f2fs 4.6
+	# and later) also allow the common key prefix "fscrypt:" in addition to
+	# their filesystem-specific key prefix ("ext4:", "f2fs:").  It would be
+	# nice to use the common key prefix, but for now use the filesystem-
+	# specific prefix to make it possible to test older kernels...
+	#
+	local big_endian=$(echo -ne '\x11' | od -tx2 | head -1 | \
+			   cut -f2 -d' ' | cut -c1 )
+	if (( big_endian )); then
+		local mode='\x00\x00\x00\x00'
+		local size='\x00\x00\x00\x40'
+	else
+		local mode='\x00\x00\x00\x00'
+		local size='\x40\x00\x00\x00'
+	fi
+	echo -n -e "${mode}${raw}${size}" |
+		$KEYCTL_PROG padd logon $FSTYP:$keydesc @s >>$seqres.full
+	echo $keydesc
+}
+
+# Unlink an encryption key from the session keyring, given its key descriptor.
+_unlink_encryption_key()
+{
+	local keydesc=$1
+	local keyid=$($KEYCTL_PROG search @s logon $FSTYP:$keydesc)
+	$KEYCTL_PROG unlink $keyid >>$seqres.full
+}
-- 
2.8.0.rc3.226.g39d4020

