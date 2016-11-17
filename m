Received: from mail-pf0-f176.google.com ([209.85.192.176]:35499 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbcKQTsi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Nov 2016 14:48:38 -0500
Received: by mail-pf0-f176.google.com with SMTP id i88so50338084pfk.2
        for <fstests@vger.kernel.org>; Thu, 17 Nov 2016 11:48:25 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH 0/4] Add filesystem-level encryption tests
Date: Thu, 17 Nov 2016 11:47:03 -0800
Message-Id: <1479412027-34416-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-f2fs@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

This patch series adds some xfstests for the filesystem-level encryption
feature currently supported by ext4 and f2fs.  I verified that they pass
on both ext4 and f2fs with the latest kernel.

Note that these new tests are complementary to and not a replacement for
running all the xfstests with encryption enabled, which for ext4 can
currently be done by setting EXT_MOUNT_OPTIONS="-o test_dummy_encryption".

Eric Biggers (4):
  generic: add utilities for testing filesystem encryption
  generic: test setting and getting encryption policies
  generic: test encrypted file access
  generic: test locking when setting encryption policy

 .gitignore            |   1 +
 common/encrypt        |  89 +++++++++
 src/Makefile          |   2 +-
 src/fscrypt_util.c    | 486 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/400     |  88 +++++++++
 tests/generic/400.out |  24 +++
 tests/generic/401     | 133 ++++++++++++++
 tests/generic/401.out |   2 +
 tests/generic/402     |  39 ++++
 tests/generic/402.out |   2 +
 tests/generic/group   |   3 +
 11 files changed, 868 insertions(+), 1 deletion(-)
 create mode 100755 common/encrypt
 create mode 100644 src/fscrypt_util.c
 create mode 100755 tests/generic/400
 create mode 100644 tests/generic/400.out
 create mode 100755 tests/generic/401
 create mode 100644 tests/generic/401.out
 create mode 100755 tests/generic/402
 create mode 100644 tests/generic/402.out

-- 
2.8.0.rc3.226.g39d4020

