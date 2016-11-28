Received: from mail-pf0-f172.google.com ([209.85.192.172]:33895 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755470AbcK1WRO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Nov 2016 17:17:14 -0500
Received: by mail-pf0-f172.google.com with SMTP id c4so27106665pfb.1
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2016 14:17:14 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 0/5] Add filesystem-level encryption tests
Date: Mon, 28 Nov 2016 14:16:37 -0800
Message-Id: <1480371402-12204-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

This is the second version of the patch series to add some xfstests for
filesystem-level encryption.  The new tests are designed to run on any
filesystem that implements the "fscrypt" API, currently ext4 and f2fs.  (fscrypt
support for ubifs is also under development, but it looks like xfstests doesn't
have ubifs support yet.)

The new tests are designed to complement, not replace, doing a full xfstests run
with encryption enabled, which for ext4 can currently be done by using the
test_dummy_encryption mount option.

v2 of the series drops the fscrypt_util test program and instead uses new xfs_io
commands to set and get encryption policies, and uses keyctl to add and remove
encryption keys.  I'm sending the xfs_io patch separately since xfs_io is part
of xfsprogs.

Eric Biggers (5):
  generic: add utilities for testing filesystem encryption
  generic: test setting and getting encryption policies
  generic: test validation of encryption policy structure
  generic: test encrypted file access
  generic: test for weaknesses in filesystem encryption

 common/config         |   2 +
 common/encrypt        | 128 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/400     | 126 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/400.out |  43 ++++++++++++++
 tests/generic/401     |  83 +++++++++++++++++++++++++++
 tests/generic/401.out |  18 ++++++
 tests/generic/402     | 145 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/402.out |  11 ++++
 tests/generic/403     | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/403.out |   3 +
 tests/generic/group   |   4 ++
 11 files changed, 718 insertions(+)
 create mode 100644 common/encrypt
 create mode 100755 tests/generic/400
 create mode 100644 tests/generic/400.out
 create mode 100755 tests/generic/401
 create mode 100644 tests/generic/401.out
 create mode 100755 tests/generic/402
 create mode 100644 tests/generic/402.out
 create mode 100755 tests/generic/403
 create mode 100644 tests/generic/403.out

-- 
2.8.0.rc3.226.g39d4020

