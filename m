Received: from mx1.redhat.com ([209.132.183.28]:37886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752188AbcIKFwR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 11 Sep 2016 01:52:17 -0400
Message-Id: <201609110552.u8B5qE2o029525@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Sun, 11 Sep 2016 13:52:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-09-10
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This update
contains patches from last two weeks, they're mainly new reflink/rmap tests and
fixes from Darrick, along with other new generic, XFS and overlay tests.

New failures I noticed in this update:
- generic/377 fails on XFS. XFS doesn't return ERANGE as expected when the
  buffer isn't big enough.
- generic/378 fails on CIFS v2.0/v2.1/v3.0 (passes on CIFS v1.0).

Thanks,
Eryu

The following changes since commit 21eb9d303cff056753a3104602ff674d468af52e:

  fstests: add punch, collapse, insert, zero test groups (2016-08-26 15:45:03 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 06d400134e1148461402f640036b8ccc2f6e4c93:

  xfs: test getbmapx shared extent reporting (2016-09-08 19:36:13 +0800)

----------------------------------------------------------------

fstests: update on 2016-09-10

This update contains:
o New generic, XFS and overlay tests
o New tests and fixes of reflink/rmap tests
o Other misc fixes for tests, common helpers and README file

----------------------------------------------------------------
Artem Savkov (1):
      generic: listxattr syscall with different buffer sizes

Darrick J. Wong (10):
      tests/xfs: don't run tests if cowextsize isn't present
      xfs/122: decrease the log update done item sizes
      xfs/130,235: deal with an unreplayable dirty log
      generic/159, 160: deal with EACCES -> EPERM transition
      xfs/122: test btree header block sizes
      xfs: test swapext with reflink
      xfs/122: track xfs_scrub_metadata
      xfs/122: check the ag reservation counter ioctl
      xfs: test getfsmap ioctl
      xfs: test getbmapx shared extent reporting

Eric Sandeen (1):
      README: fix up dependency lists

Eryu Guan (4):
      common/rc: introduce _overlay_mount_dirs helper
      overlay: copy-up lowerdir which has opaque xattr set
      xfs/279: filter scsi debug device correctly
      generic: simple permission check on hard links

Qu Wenruo (1):
      common/rc: Enhance _exclude_scratch_mount_option to handle multiple options

Wang Xiaoguang (1):
      generic/172: raise fs size

Xiao Yang (1):
      ext4/021: use $XFS_IO_PROG instead of xfs_io

Zorro Lang (2):
      generic/095: add xfs_file_aio_read into warning whitelist
      xfs: rw remount with unknown ro-compat features

 .gitignore            |   1 +
 README                |  17 ++++----
 common/rc             |  48 +++++++++++++++++-----
 src/Makefile          |   2 +-
 src/listxattr.c       |  73 +++++++++++++++++++++++++++++++++
 tests/ext4/021        |   2 +-
 tests/ext4/271        |   6 +--
 tests/generic/095     |   4 +-
 tests/generic/159     |   7 +++-
 tests/generic/160     |   7 +++-
 tests/generic/172     |  20 ++++-----
 tests/generic/377     |  87 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/377.out |  11 +++++
 tests/generic/378     |  73 +++++++++++++++++++++++++++++++++
 tests/generic/378.out |   3 ++
 tests/generic/group   |   2 +
 tests/overlay/005     |   5 +--
 tests/overlay/010     |   5 +--
 tests/overlay/014     |  94 +++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/014.out |   3 ++
 tests/overlay/group   |   1 +
 tests/xfs/122.out     |  10 +++--
 tests/xfs/130         |   3 +-
 tests/xfs/134         |   3 +-
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
 tests/xfs/271         |  82 +++++++++++++++++++++++++++++++++++++
 tests/xfs/271.out     |  13 ++++++
 tests/xfs/272         |  84 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/272.out     |   6 +++
 tests/xfs/273         |  65 ++++++++++++++++++++++++++++++
 tests/xfs/273.out     |   3 ++
 tests/xfs/274         |  95 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/274.out     |   7 ++++
 tests/xfs/275         |  68 +++++++++++++++++++++++++++++++
 tests/xfs/275.out     |   4 ++
 tests/xfs/276         |  85 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/276.out     |   6 +++
 tests/xfs/277         |  68 +++++++++++++++++++++++++++++++
 tests/xfs/277.out     |   4 ++
 tests/xfs/279         |   2 +-
 tests/xfs/280         |  93 ++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/280.out     |  17 ++++++++
 tests/xfs/315         |   1 +
 tests/xfs/326         |   1 +
 tests/xfs/328         | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/328.out     |   6 +++
 tests/xfs/329         |  97 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/329.out     |  10 +++++
 tests/xfs/330         | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/330.out     |  12 ++++++
 tests/xfs/group       |  12 ++++++
 74 files changed, 1607 insertions(+), 54 deletions(-)
--
Eryu Guan
eguan@redhat.com
