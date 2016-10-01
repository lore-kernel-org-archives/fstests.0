Received: from mx1.redhat.com ([209.132.183.28]:58642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbcJAL4J (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 1 Oct 2016 07:56:09 -0400
Message-Id: <201610011156.u91Bu7KV026670@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Sat, 01 Oct 2016 19:56:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-10-01
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This update
mainly contains a new generic test to test log recovery, and fixes to
rmap/reflink tests.

New failures I noticed in this update:
- generic/388 fails on XFS or even crashes the kernel with Linus tree, the bug
  has been fixed in linux-xfs tree for-next branch

Please note that it's public holiday next week in China, I'll try to
review/test/merge patches and send out pull request as usual, but please don't
be surprised if I didn't :)

Thanks,
Eryu

The following changes since commit 0bbd20b104765c75faaf8e28a54c32df505ce7fd:

  btrfs: test free space tree mount options (2016-09-24 00:39:13 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 4053326a0c5f73488fb4f54bd084ba821545a6cd:

  generic/349,350,351: remove from quick group (2016-09-29 16:27:47 +0800)

----------------------------------------------------------------

fstests: update on 2016-10-01

This update contains:
o A new generic test to test log recovery
o Fixes for rmap/reflink tests
o Other minor fixes all around the tree

----------------------------------------------------------------
Brian Foster (1):
      generic: shutdown fs after log recovery

Darrick J. Wong (3):
      xfs/122: decrease the log update done item sizes
      xfs/130: don't modify files after failed mount
      xfs/207,327: fsxattr no longer has the reflink flag

Eryu Guan (4):
      generic/317: use id to get user id
      generic/052: use _check_scratch_fs not _xfs_check
      xfs/287: fix wrong seq number in test
      generic/349,350,351: remove from quick group

Theodore Ts'o (1):
      generic/361: require that file system uses a real block device

 tests/generic/052     |  2 +-
 tests/generic/317     |  2 +-
 tests/generic/361     |  1 +
 tests/generic/388     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/388.out |  2 ++
 tests/generic/group   |  7 ++--
 tests/xfs/122.out     |  6 ++--
 tests/xfs/130         |  9 ++----
 tests/xfs/130.out     |  1 -
 tests/xfs/207.out     |  4 +--
 tests/xfs/287         |  2 +-
 tests/xfs/327.out     |  6 ++--
 12 files changed, 110 insertions(+), 21 deletions(-)
--
Eryu Guan
eguan@redhat.com
