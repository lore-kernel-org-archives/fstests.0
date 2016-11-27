Received: from mx1.redhat.com ([209.132.183.28]:56940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753806AbcK0Lxq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 27 Nov 2016 06:53:46 -0500
Message-Id: <201611271153.uARBriG3001593@int-mx11.intmail.prod.int.phx2.redhat.com>
Date: Sun, 27 Nov 2016 19:53:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-11-27
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? There're new
generic and overlayfs tests, and two test updates caused by fs behavior changes
(see below for details).

New failure I noticed in this update:
- overlay/016 is a new case that fails on current Linus tree (4.9-rc6)
- generic/182 fails on reflink XFS, there's a behavior change pending in XFS
  list
- ext4/001 fails on DAX mount, this is also a behavior change pending in ext4
  tree

Thanks,
Eryu

The following changes since commit 083ff5827b603f2d646d20a20086fa55aa89b1c1:

  fstests: Introduce check for explicit SHARED extent flag reporting (2016-11-18 16:41:06 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 79a1c380829225292bf02c6b2de0ef2b93f40f37:

  ext4/001: Fixup file layout with DAX (2016-11-27 18:42:45 +0800)

----------------------------------------------------------------

fstests: update on 2016-11-27

This update contains:
o New generic and overlay tests
o Test behavior changes to generic/182 and ext4/001
o Bug fixes to btrfs/124-5

----------------------------------------------------------------
Amir Goldstein (1):
      overlay: test ro/rw fd data inconsistecies

Darrick J. Wong (1):
      generic/182: retain existing btrfs behavior when len == 0

Filipe Manana (1):
      btrfs/124-5: add missing umount for raid5 tests

Jaegeuk Kim (2):
      generic: check inode metadata on f{data}sync after power-cut
      generic: check some inline truncation behaviors

Jan Kara (1):
      ext4/001: Fixup file layout with DAX

 tests/btrfs/124       |   1 +
 tests/btrfs/125       |   1 +
 tests/ext4/001.cfg    |   2 +-
 tests/generic/182     |   6 +--
 tests/generic/182.out |   2 -
 tests/generic/392     | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/392.out |  11 ++++
 tests/generic/393     | 128 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/393.out |  45 +++++++++++++++++
 tests/generic/group   |   2 +
 tests/overlay/016     |  98 ++++++++++++++++++++++++++++++++++++
 tests/overlay/016.out |  12 +++++
 tests/overlay/group   |   1 +
 13 files changed, 438 insertions(+), 6 deletions(-)
--
Eryu Guan
eguan@redhat.com
