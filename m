Received: from mail-pg0-f68.google.com ([74.125.83.68]:33104 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757451AbcLUVYT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 16:24:19 -0500
Received: by mail-pg0-f68.google.com with SMTP id g1so15796975pgn.0
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 13:24:19 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v5 0/6] Add filesystem-level encryption tests
Date: Wed, 21 Dec 2016 13:21:56 -0800
Message-Id: <1482355322-74978-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Sandeen <sandeen@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

This is the fifth revision of the patchset to add xfstests for
filesystem-level encryption.  Patch 6/6 (generic/404) was adjusted to
address comments from Eryu Guan, and the patches were rebased onto the
latest xfstests master.  Otherwise the patches are unchanged from v4.

The new tests are designed to run on any filesystem that implements the
"fscrypt" API, currently ext4, f2fs, and (merged for Linux 4.10) ubifs.
I've run all the new tests on both ext4 and f2fs.  Currently, generic/403
is expected to fail due to kernel bugs, and I've sent kernel patches to
fix these.  With the help of my patches to support ubifs in xfstests and
xfstests-bld, I've also run the new tests on ubifs, except for
generic/404 which doesn't work on ubifs yet.  generic/402 and generic/403
also fail on ubifs, AFAICS due to kernel bugs.

Note that the new tests are designed to complement, not replace, doing a
full xfstests run with encryption enabled, which for ext4 can currently
be done by using the test_dummy_encryption mount option.

Changes since v4:
	* generic/404: use $XFS_IO_PROG
	* generic/404: document why we zero the device

Changes since v3:
	* Replace _require_encryption with _require_scratch_encryption
	* Move filesystem type check into _scratch_mkfs_encrypted
	* Use _exclude_scratch_mount_option
	* Never cd into $SCRATCH_MNT
	* generic/403: uncomment test of exchange without key
	* generic/403: test linking and renaming special file
	* Send both stdout and stderr from mkfs to $seqres.full

Changes since v2:
	* Use filesystem-specific key prefix rather than generic one
	* Use a new keyring for each test
	* Add a test for restrictions on moving and linking files
	* Make "cryptographic weaknesses" test compatible with f2fs
	* For now, accept both the old and new versions of certain error
	  codes which are planned to be changed

Changes since v1:
	* Drop fscrypt_util test program and use new xfs_io commands and
	  keyctl instead (xfs_io patch sent separately)
	* Updates to match xfstests coding style
	* Move validation of policy structure into its own test
	* Add test to detect some cryptographic weaknesses
	* Drop ioctl locking test

Eric Biggers (6):
  generic: add utilities for testing filesystem encryption
  generic: test setting and getting encryption policies
  generic: test validation of encryption policy structure
  generic: test encrypted file access
  generic: test enforcement of one encryption policy per tree
  generic: test for weaknesses in filesystem encryption

 common/config         |   2 +
 common/encrypt        | 146 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/400     | 135 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/400.out |  43 +++++++++++++
 tests/generic/401     |  82 +++++++++++++++++++++++++
 tests/generic/401.out |  18 ++++++
 tests/generic/402     | 144 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/402.out |  13 ++++
 tests/generic/403     | 158 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/403.out |  45 ++++++++++++++
 tests/generic/404     | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/404.out |   3 +
 tests/generic/group   |   5 ++
 13 files changed, 960 insertions(+)
 create mode 100644 common/encrypt
 create mode 100755 tests/generic/400
 create mode 100644 tests/generic/400.out
 create mode 100755 tests/generic/401
 create mode 100644 tests/generic/401.out
 create mode 100755 tests/generic/402
 create mode 100644 tests/generic/402.out
 create mode 100644 tests/generic/403
 create mode 100644 tests/generic/403.out
 create mode 100755 tests/generic/404
 create mode 100644 tests/generic/404.out

-- 
2.8.0.rc3.226.g39d4020

