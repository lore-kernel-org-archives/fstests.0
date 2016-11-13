Received: from mx1.redhat.com ([209.132.183.28]:48020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbcKMG17 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 13 Nov 2016 01:27:59 -0500
Message-Id: <201611130627.uAD6Ru5S010234@int-mx11.intmail.prod.int.phx2.redhat.com>
Date: Sun, 13 Nov 2016 14:27:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-11-13
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? In this update
we have new xfs, btrfs and generic tests added, and require xfs_io binary to be
mandatory for fstests run. There're also updates to make xfs_copy tests without
"-d" option on v5 XFS possible and to fix bugs in ocfs2 testing.

New failure I noticed in this update:
- xfs/118 is a new test that may crash your kernel if you're not using latest
  kernel from linux-xfs tree (for-next branch)

Thanks,
Eryu

The following changes since commit e604301e2605a152d8438f60d893ff29ed65d637:

  common: add CephFS support (2016-11-05 17:30:14 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 052b0777d7cc61679226e1526a5a4bd727d5be27:

  xfs: testcase for kernelspace xfs_fsr extent handling flaw (2016-11-13 14:01:07 +0800)

----------------------------------------------------------------

fstests: update on 2016-11-13

This update contains:
o New tests for xfs and btrfs, and new generic test
o xfs_io is made mandatory
o Test xfs_copy v5 XFS without -d option
o Bug fixes for ocfs2 testing

----------------------------------------------------------------
Darrick J. Wong (1):
      fstests: fix some minor problems testing ocfs2

Eric Sandeen (1):
      xfs: testcase for kernelspace xfs_fsr extent handling flaw

Eryu Guan (2):
      fstests: make xfs_io mandatory
      xfs/021: filter out detailed array element info from xfs_db

Qu Wenruo (1):
      btrfs: Check false ENOSPC bug caused by incorrect metadata reserve

Zorro Lang (2):
      generic: multi-thread freeze/unfreeze test under fsstress
      fstests: test xfs_copy V5 XFS without -d option

 common/config         |   4 +-
 common/quota          |   2 +-
 common/rc             |  48 +++++++++++++----------
 tests/btrfs/132       | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/132.out   |   2 +
 tests/btrfs/group     |   1 +
 tests/generic/390     |  94 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/390.out |   2 +
 tests/generic/group   |   1 +
 tests/xfs/021         |   2 +-
 tests/xfs/032         |  21 +++++++---
 tests/xfs/073         |   8 +---
 tests/xfs/094         |   1 -
 tests/xfs/103         |   1 -
 tests/xfs/118         |  99 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/118.out     |   2 +
 tests/xfs/group       |   1 +
 17 files changed, 357 insertions(+), 35 deletions(-)
--
Eryu Guan
eguan@redhat.com
