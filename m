Received: from mx1.redhat.com ([209.132.183.28]:37460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbdFPTkr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Jun 2017 15:40:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3631785540
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 19:40:47 +0000 (UTC)
Received: from tleilax.poochiereds.net (ovpn-120-225.rdu2.redhat.com [10.10.120.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01E4B18EF8
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 19:40:46 +0000 (UTC)
From: Jeff Layton <jlayton@redhat.com>
Subject: [xfstests PATCH v5 0/5] new tests for writeback error reporting behavior
Date: Fri, 16 Jun 2017 15:40:41 -0400
Message-Id: <20170616194046.15923-1-jlayton@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The main changes in this set from the last are:

- add a btrfs/999.out file
- use _supported_fs to whitelist fs' on which the tests should run
- fix the ext3/4 mount option handling when creating journal device
- ensure that dmerror is installed on make install

These tests are intended to test the new writeback error reporting
introduced by this kernel patchset:

    [PATCH v7 00/22] fs: enhanced writeback error reporting with errseq_t (pile #1)

It adds 3 new xfstests for testing kernel behavior when writeback from
the pagecache fails: one generic filesystem test, one test for raw block
devices and one test for btrfs.

The tests work with dmerror to make data writeback from the pagecache
fail, and then tests how the kernel reports errors afterward.

xfs, ext2/3/4 and btrfs all pass on a kernel with the patchset above. "Bare"
block devices also work correctly.

Jeff Layton (5):
  ext4: allow ext4 to use $SCRATCH_LOGDEV
  ext3: allow it to put journal on a separate device when doing
    scratch_mkfs
  generic: add a writeback error handling test
  generic: test writeback error handling on dmerror devices
  btrfs: make a btrfs version of writeback error reporting test

 .gitignore                 |   1 +
 common/dmerror             |  13 ++-
 common/rc                  |  14 ++-
 doc/auxiliary-programs.txt |  16 ++++
 src/Makefile               |   4 +-
 src/dmerror                |  44 +++++++++
 src/fsync-err.c            | 223 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/999            |  94 +++++++++++++++++++
 tests/btrfs/999.out        |   3 +
 tests/btrfs/group          |   1 +
 tests/generic/998          |  63 +++++++++++++
 tests/generic/998.out      |   2 +
 tests/generic/999          |  84 +++++++++++++++++
 tests/generic/999.out      |   3 +
 tests/generic/group        |   2 +
 15 files changed, 559 insertions(+), 8 deletions(-)
 create mode 100755 src/dmerror
 create mode 100644 src/fsync-err.c
 create mode 100755 tests/btrfs/999
 create mode 100644 tests/btrfs/999.out
 create mode 100755 tests/generic/998
 create mode 100644 tests/generic/998.out
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

-- 
2.13.0

