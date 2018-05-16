Received: from mail-pg0-f65.google.com ([74.125.83.65]:39414 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeEPQ5I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 May 2018 12:57:08 -0400
Received: by mail-pg0-f65.google.com with SMTP id e1-v6so544018pga.6
        for <fstests@vger.kernel.org>; Wed, 16 May 2018 09:57:08 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 0/4] xfstests: generic swap file tests
Date: Wed, 16 May 2018 09:56:56 -0700
Message-Id: <cover.1526489529.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>, Eryu Guan <guaneryu@gmail.com>, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Hi,

I picked up my Btrfs swap file series again and added a few tests as a
result. I'm still working on the Btrfs-specific tests, but since Darrick
has a pending swap file test, I figured I'd send these out and see if we
can combine them. They're a little rough around the edges.

Thanks!

Omar Sandoval (4):
  generic: enable swapfile tests on Btrfs
  generic: add test for dedupe on an active swapfile
  generic: add test for truncate/fpunch of an active swapfile
  generic: test invalid swap file activation

 .gitignore            |  2 ++
 common/rc             |  3 ++
 src/Makefile          |  2 +-
 src/mkswap.c          | 83 +++++++++++++++++++++++++++++++++++++++++++
 src/swapon.c          | 24 +++++++++++++
 tests/generic/356     |  6 +++-
 tests/generic/357     |  6 +++-
 tests/generic/488     | 78 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/488.out |  7 ++++
 tests/generic/489     | 77 +++++++++++++++++++++++++++++++++++++++
 tests/generic/489.out |  8 +++++
 tests/generic/490     | 75 ++++++++++++++++++++++++++++++++++++++
 tests/generic/490.out |  5 +++
 tests/generic/group   |  2 ++
 14 files changed, 375 insertions(+), 3 deletions(-)
 create mode 100644 src/mkswap.c
 create mode 100644 src/swapon.c
 create mode 100755 tests/generic/488
 create mode 100644 tests/generic/488.out
 create mode 100755 tests/generic/489
 create mode 100644 tests/generic/489.out
 create mode 100755 tests/generic/490
 create mode 100644 tests/generic/490.out

-- 
2.17.0

