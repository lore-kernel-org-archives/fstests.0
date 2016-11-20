Received: from mx1.redhat.com ([209.132.183.28]:34102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbcKTGbB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 20 Nov 2016 01:31:01 -0500
Message-Id: <201611200630.uAK6UxvA003140@int-mx10.intmail.prod.int.phx2.redhat.com>
Date: Sun, 20 Nov 2016 14:30:58 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-11-20
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This update
contains patches from last two weeks, in which we have new xfs, btrfs and
generic tests added, and require xfs_io binary to be mandatory for fstests run.
There're also updates to make xfs_copy tests without "-d" option on v5 XFS
possible and to fix bugs in ocfs2 testing, and other small fixes.

New failure I noticed in this update:
- xfs/118 is a new test that may crash your kernel if you're not using latest
  kernel from linux-xfs tree (for-next branch)
- generic/391 is a new test and fails on btrfs

Thanks,
Eryu

The following changes since commit e604301e2605a152d8438f60d893ff29ed65d637:

  common: add CephFS support (2016-11-05 17:30:14 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 083ff5827b603f2d646d20a20086fa55aa89b1c1:

  fstests: Introduce check for explicit SHARED extent flag reporting (2016-11-18 16:41:06 +0800)

----------------------------------------------------------------

fstests: update on 2016-11-20

This update contains:
o New tests for xfs and btrfs, and new generic test
o xfs_io is made mandatory
o Test xfs_copy v5 XFS without -d option
o Bug fixes for ocfs2 testing

----------------------------------------------------------------
Amir Goldstein (1):
      generic/37[3-4]: use bind mount instead of 2nd _scratch_mount

Christoph Hellwig (1):
      fstests: fix fsx fallocate error messages

Darrick J. Wong (1):
      fstests: fix some minor problems testing ocfs2

Eric Sandeen (1):
      xfs: testcase for kernelspace xfs_fsr extent handling flaw

Eryu Guan (4):
      fstests: make xfs_io mandatory
      xfs/021: filter out detailed array element info from xfs_db
      generic/38[3-6]: require project quota to be enabled on SCRATCH_DEV
      generic: fix $tmp path in tests

Liu Bo (1):
      generic/098: update test for truncating a file into the middle of a hole

Omar Sandoval (2):
      xfs/298: cd to / instead of ~
      generic: concurrent non-overlapping direct I/O on the same extents

Qu Wenruo (2):
      btrfs: Check false ENOSPC bug caused by incorrect metadata reserve
      fstests: Introduce check for explicit SHARED extent flag reporting

Zorro Lang (2):
      generic: multi-thread freeze/unfreeze test under fsstress
      fstests: test xfs_copy V5 XFS without -d option

 .gitignore            |   1 +
 common/config         |   4 +-
 common/quota          |   2 +-
 common/rc             |  48 +++++++++++++----------
 common/reflink        |  44 +++++++++++++++++++++
 ltp/fsx.c             |  10 ++---
 src/Makefile          |   2 +-
 src/dio-interleaved.c |  98 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/132       | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/132.out   |   2 +
 tests/btrfs/group     |   1 +
 tests/generic/018     |   2 +-
 tests/generic/094     |   2 +-
 tests/generic/098     |  60 +++++++++++++++++++----------
 tests/generic/098.out |  10 +++++
 tests/generic/225     |   2 +-
 tests/generic/249     |   2 +-
 tests/generic/372     |   1 +
 tests/generic/373     |   4 +-
 tests/generic/374     |   4 +-
 tests/generic/383     |   1 +
 tests/generic/384     |   2 +-
 tests/generic/385     |   2 +-
 tests/generic/386     |   2 +-
 tests/generic/390     |  94 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/390.out |   2 +
 tests/generic/391     |  76 +++++++++++++++++++++++++++++++++++++
 tests/generic/391.out |   2 +
 tests/generic/group   |   2 +
 tests/xfs/021         |   2 +-
 tests/xfs/032         |  21 +++++++---
 tests/xfs/073         |   8 +---
 tests/xfs/094         |   1 -
 tests/xfs/103         |   1 -
 tests/xfs/118         |  99 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/118.out     |   2 +
 tests/xfs/298         |   2 +-
 tests/xfs/group       |   1 +
 38 files changed, 648 insertions(+), 74 deletions(-)
--
Eryu Guan
eguan@redhat.com
