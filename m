Received: from mail-pf0-f180.google.com ([209.85.192.180]:35038 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbcLETXW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Dec 2016 14:23:22 -0500
Received: by mail-pf0-f180.google.com with SMTP id i88so64888686pfk.2
        for <fstests@vger.kernel.org>; Mon, 05 Dec 2016 11:23:03 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v3 0/6] Add filesystem-level encryption tests
Date: Mon,  5 Dec 2016 11:21:03 -0800
Message-Id: <1480965669-39714-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

This is the third version of the patch series to add some xfstests for
filesystem-level encryption.  The new tests are designed to run on any
filesystem that implements the "fscrypt" API, currently ext4 and f2fs.
(fscrypt support for ubifs is also under development, but it looks like
xfstests doesn't have ubifs support yet.)

The new tests are designed to complement, not replace, doing a full
xfstests run with encryption enabled, which for ext4 can currently be
done by using the test_dummy_encryption mount option.

Changes since v2:
	* Use filesystem-specific key prefix rather than generic one.
	* Use a new keyring for each test.
	* Add a test for restrictions on moving and linking files.
	* Make "cryptographic weaknesses" test compatible with f2fs.
	* For now, accept both the old and new versions of certain error
	  codes which are planned to be changed.

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
 common/encrypt        | 137 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/400     | 132 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/400.out |  43 +++++++++++++
 tests/generic/401     |  83 +++++++++++++++++++++++++
 tests/generic/401.out |  18 ++++++
 tests/generic/402     | 145 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/402.out |  13 ++++
 tests/generic/403     | 130 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/403.out |  34 +++++++++++
 tests/generic/404     | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/404.out |   3 +
 tests/generic/group   |   5 ++
 13 files changed, 908 insertions(+)
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

