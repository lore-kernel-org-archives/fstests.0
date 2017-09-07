Received: from mail-wr0-f176.google.com ([209.85.128.176]:35203 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbdIGKCt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 06:02:49 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 0/8] Crash consistency xfstest using dm-log-writes
Date: Thu,  7 Sep 2017 13:03:05 +0300
Message-Id: <1504778593-12071-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Eryu,

These are the rest of the patches following the fsx patches
v4 posting.

There are no changes to the replay-log patches since v3.

The test patches address your v3 review comments.

The status of tests in current upstream:
- 500 fails sometimes on btrfs/ext4/xfs
- 501 fails always on ext4
- 502 fails sometimes on xfs
- 503 fails always on xfs

The data loss issue found by test 500 on xfs is fixed by
commit 47c7d0b19502 ("xfs: fix incorrect log_flushed on fsync")
now in master.

Amir.

Amir Goldstein (8):
  log-writes: add replay-log program to replay dm-log-writes target
  replay-log: add validations for corrupt log entries
  replay-log: add support for replaying ops in target device sector
  fstests: add support for working with dm-log-writes target
  fstests: crash consistency fsx test using dm-log-writes
  fstests: regression test for ext4 crash consistency bug
  fstests: crash consistency fsx test for cloned files
  fstests: regression test for xfs leftover CoW extent error

 .gitignore                   |   1 +
 README                       |   2 +
 common/dmlogwrites           |  90 +++++++++
 doc/auxiliary-programs.txt   |   8 +
 doc/requirement-checking.txt |  20 ++
 src/Makefile                 |   2 +-
 src/log-writes/Makefile      |  23 +++
 src/log-writes/SOURCE        |   6 +
 src/log-writes/log-writes.c  | 458 +++++++++++++++++++++++++++++++++++++++++++
 src/log-writes/log-writes.h  |  81 ++++++++
 src/log-writes/replay-log.c  | 389 ++++++++++++++++++++++++++++++++++++
 tests/generic/500            | 138 +++++++++++++
 tests/generic/500.out        |   2 +
 tests/generic/501            |  80 ++++++++
 tests/generic/501.out        |   2 +
 tests/generic/502            | 141 +++++++++++++
 tests/generic/502.out        |   2 +
 tests/generic/503            |  74 +++++++
 tests/generic/503.out        |   2 +
 tests/generic/group          |   4 +
 20 files changed, 1524 insertions(+), 1 deletion(-)
 create mode 100644 common/dmlogwrites
 create mode 100644 src/log-writes/Makefile
 create mode 100644 src/log-writes/SOURCE
 create mode 100644 src/log-writes/log-writes.c
 create mode 100644 src/log-writes/log-writes.h
 create mode 100644 src/log-writes/replay-log.c
 create mode 100755 tests/generic/500
 create mode 100644 tests/generic/500.out
 create mode 100755 tests/generic/501
 create mode 100644 tests/generic/501.out
 create mode 100755 tests/generic/502
 create mode 100644 tests/generic/502.out
 create mode 100755 tests/generic/503
 create mode 100644 tests/generic/503.out

-- 
2.7.4

