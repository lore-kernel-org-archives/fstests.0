Received: from mail-wr0-f182.google.com ([209.85.128.182]:35929 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdIETKv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Sep 2017 15:10:51 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 00/13] Crash consistency xfstest using dm-log-writes
Date: Tue,  5 Sep 2017 22:11:07 +0300
Message-Id: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Eryu,

This is the 3rd revision of crash consistency patch set.
I addressed all your review commennts on v2 patches.

These patches are originally from Josef Bacik.

I've added some debugging options for running fsx
and replay-log, which I used to analyze the crash consistency
bugs uncovered by the tests.

The original fsx crash consistency test (500) is failing sometimes
on kernel v4.13 for ext4, btrfs and xfs.
A fix for xfs is queued for v4.14, I think there is a fix by Josef
for btrfs queued for v4.14 as well.

A 'quick' and reliable regression test (501) was created for the
ext4 issue.

I created another crash consistency test which runs fsx on cloned
files (502). This test is failing check fs sometimes on kernel v4.13,
at the end of the test, but this is not related to crash consistency.
There is a fix is the works for v4.14.

A 'quick' and reliable regression test (503) was created for this issue.

The new 'clones crash' test (502) is also failing sometimes on xfs_repair
errors like: "fatal error -- illegal state 13 in block map 147", on crash
points, but I havn't been able to narrow down the issue yet.

Amir.

Amir Goldstein (13):
  fsx: add support for integrity check with dm-log-writes target
  fsx: add optional logid prefix to log messages
  fsx: add support for recording operations to a file
  fsx: add support for writing constant instead of random data
  fsx: add support for keeping existing file
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
 common/dmlogwrites           |  94 +++++++++
 doc/auxiliary-programs.txt   |   8 +
 doc/requirement-checking.txt |  20 ++
 ltp/fsx.c                    | 246 ++++++++++++++++++-----
 src/Makefile                 |   2 +-
 src/log-writes/Makefile      |  23 +++
 src/log-writes/SOURCE        |   6 +
 src/log-writes/log-writes.c  | 458 +++++++++++++++++++++++++++++++++++++++++++
 src/log-writes/log-writes.h  |  81 ++++++++
 src/log-writes/replay-log.c  | 389 ++++++++++++++++++++++++++++++++++++
 tests/generic/500            | 135 +++++++++++++
 tests/generic/500.out        |   2 +
 tests/generic/501            |  80 ++++++++
 tests/generic/501.out        |   2 +
 tests/generic/502            | 142 ++++++++++++++
 tests/generic/502.out        |   2 +
 tests/generic/503            |  69 +++++++
 tests/generic/503.out        |   2 +
 tests/generic/group          |   4 +
 21 files changed, 1721 insertions(+), 47 deletions(-)
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

