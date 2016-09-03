Received: from mx1.redhat.com ([209.132.183.28]:48958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753524AbcICQIM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 3 Sep 2016 12:08:12 -0400
Message-Id: <201609031557.u83Fvi3d029636@int-mx10.intmail.prod.int.phx2.redhat.com>
Date: Sat, 03 Sep 2016 23:57:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-09-03
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This update
mainly contains reflink tests fixes from Darrick, and I'll go through the
remaining patches for new reflink/rmap tests next week.

New failures I noticed in this update:
- generic/377 fails on XFS. XFS doesn't return ERANGE as expected when the
  buffer isn't big enough.

Thanks,
Eryu

The following changes since commit 21eb9d303cff056753a3104602ff674d468af52e:

  fstests: add punch, collapse, insert, zero test groups (2016-08-26 15:45:03 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 2db29c7d6fedb8325acab74afbb2e49e35be54fb:

  xfs/122: check the ag reservation counter ioctl (2016-09-02 16:40:34 +0800)

----------------------------------------------------------------

fstests: update on 2016-09-03

This update contains:
o New generic and xfs tests
o Fixes of reflink/rmap tests
o Other misc fixes for tests and README

----------------------------------------------------------------
Artem Savkov (1):
      generic: listxattr syscall with different buffer sizes

Darrick J. Wong (8):
      tests/xfs: don't run tests if cowextsize isn't present
      xfs/122: decrease the log update done item sizes
      xfs/130,235: deal with an unreplayable dirty log
      generic/159, 160: deal with EACCES -> EPERM transition
      xfs/122: test btree header block sizes
      xfs: test swapext with reflink
      xfs/122: track xfs_scrub_metadata
      xfs/122: check the ag reservation counter ioctl

Eric Sandeen (1):
      README: fix up dependency lists

Wang Xiaoguang (1):
      generic/172: raise fs size

Zorro Lang (2):
      generic/095: add xfs_file_aio_read into warning whitelist
      xfs: rw remount with unknown ro-compat features

 .gitignore            |   1 +
 README                |  17 ++++----
 src/Makefile          |   2 +-
 src/listxattr.c       |  73 +++++++++++++++++++++++++++++++++
 tests/generic/095     |   4 +-
 tests/generic/159     |   7 +++-
 tests/generic/160     |   7 +++-
 tests/generic/172     |  20 ++++-----
 tests/generic/377     |  87 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/377.out |  11 +++++
 tests/generic/group   |   1 +
 tests/xfs/122.out     |  10 +++--
 tests/xfs/130         |   3 +-
 tests/xfs/215         |   1 +
 tests/xfs/218         |   1 +
 tests/xfs/219         |   1 +
 tests/xfs/221         |   1 +
 tests/xfs/223         |   1 +
 tests/xfs/224         |   1 +
 tests/xfs/225         |   1 +
 tests/xfs/226         |   1 +
 tests/xfs/228         |   1 +
 tests/xfs/230         |   1 +
 tests/xfs/231         |   1 +
 tests/xfs/232         |   1 +
 tests/xfs/235         |   3 +-
 tests/xfs/243         |   1 +
 tests/xfs/248         |   1 +
 tests/xfs/249         |   1 +
 tests/xfs/251         |   1 +
 tests/xfs/254         |   1 +
 tests/xfs/255         |   1 +
 tests/xfs/256         |   1 +
 tests/xfs/257         |   1 +
 tests/xfs/258         |   1 +
 tests/xfs/270         |  93 ++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/270.out     |   5 +++
 tests/xfs/315         |   1 +
 tests/xfs/326         |   1 +
 tests/xfs/328         | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/328.out     |   6 +++
 tests/xfs/329         |  97 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/329.out     |  10 +++++
 tests/xfs/330         | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/330.out     |  12 ++++++
 tests/xfs/group       |   4 ++
 46 files changed, 678 insertions(+), 29 deletions(-)
--
Eryu Guan
eguan@redhat.com
