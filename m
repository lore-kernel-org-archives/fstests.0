Received: from mail-pf0-f182.google.com ([209.85.192.182]:33907 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbcK1WRW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Nov 2016 17:17:22 -0500
Received: by mail-pf0-f182.google.com with SMTP id c4so27107304pfb.1
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2016 14:17:22 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 1/5] generic: add utilities for testing filesystem encryption
Date: Mon, 28 Nov 2016 14:16:38 -0800
Message-Id: <1480371402-12204-2-git-send-email-ebiggers@google.com>
In-Reply-To: <1480371402-12204-1-git-send-email-ebiggers@google.com>
References: <1480371402-12204-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Add utility functions for testing filesystem-level encryption via the
common API currently supported by ext4 and f2fs, in development for
ubifs and planned for xfs.  Setting and getting encryption policies will
use new commands being added to xfs_io, while adding and removing
encryption keys will use keyctl.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/config  |   1 +
 common/encrypt | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)
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
index 0000000..6ffb6ff
--- /dev/null
+++ b/common/encrypt
@@ -0,0 +1,128 @@
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
+_require_encryption()
+{
+	# The 'test_dummy_encryption' mount option interferes with trying to use
+	# encryption for real, even if we are just trying to get/set policies
+	# and never put any keys in the keyring.  So skip the real encryption
+	# tests if the 'test_dummy_encryption' mount option was specified.
+	if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
+		_notrun "Dummy encryption is on; skipping real encryption tests"
+	fi
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
+		_notrun "kernel is unaware of $FSTYP encryption feature, " \
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
+	_scratch_mkfs -O encrypt
+}
+
+#
+# Generate a random encryption key, add it to the keyring, and print out the
+# resulting key descriptor (example: "8bf798e1a494e1ec").  Requires the keyctl
+# program.
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
+	# Add the key to the user session keyring.  The required structure is:
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
+	# Keys are named fscrypt:KEYDESC where KEYDESC is the 16-character key
+	# descriptor hex string.  Some old kernels only accepted
+	# filesystem-specific key prefixes, namely ext4 pre-4.8 and f2fs
+	# pre-4.6.  It's expected that tests using this code will fail on those
+	# old kernels due to the keys not being found.
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
+		$KEYCTL_PROG padd logon fscrypt:$keydesc @us >>$seqres.full
+	echo $keydesc
+}
+
+# Unlink an encryption key from the keyring, given its key descriptor.
+_unlink_encryption_key()
+{
+	local keydesc=$1
+	local keyid=$($KEYCTL_PROG search @us logon fscrypt:$keydesc)
+	$KEYCTL_PROG unlink $keyid >>$seqres.full
+}
-- 
2.8.0.rc3.226.g39d4020

