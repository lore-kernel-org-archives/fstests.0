Received: from mx1.redhat.com ([209.132.183.28]:34648 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbcGWErl (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 23 Jul 2016 00:47:41 -0400
Message-Id: <201607230447.u6N4ldJ3018962@int-mx13.intmail.prod.int.phx2.redhat.com>
Date: Sat, 23 Jul 2016 12:47:33 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-07-23
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? We have
installation support and other improvements for tests with extended names in
this update, and we have the first test with extended test name, all thanks to
Jan Tulak!

Thanks,
Eryu

The following changes since commit 2caf9a321867662dc195bef5fa214a03ba8fd070:

  generic: add _require_block_device to more tests (2016-07-16 17:34:57 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 6721ab08bd2772da9f3aa1ae7b46b7cb5c0e8308:

  generic/235: Fix false failures for some quota formats (2016-07-21 17:44:30 +0800)

----------------------------------------------------------------

fstests: update on 2016-07-23

This update contains:
o Improments on extended test names handling
o The first test with extended name (xfs/191-input-validation)
o New test cases for xfs and btrfs
o Other bug fixes and improvements

----------------------------------------------------------------
Christoph Hellwig (1):
      generic/120: requires working *atime mount options

Eric Sandeen (1):
      generic/075,112: fix up fsx error handling

Eryu Guan (2):
      common/rc: avoid mkfs option conflicts in _scratch_mkfs_xfs_supported
      xfs: fix wrong seq order in group file

Jan Kara (3):
      generic/294: Filter backquotes from mknod error output
      common/filter: Improve xfs_io filter
      generic/235: Fix false failures for some quota formats

Jan Tulak (4):
      build: Fix installation for extended names
      check: fix extended names handling
      check: remove unused variable
      xfs: Add mkfs input validation tests

Qu Wenruo (2):
      btrfs: send on fully deduped file
      btrfs: Update quick and auto tag for btrfs group

Xiao Yang (1):
      xfs/083: disable dmesg check

 check                              |  26 +--
 common/filter                      |   6 +-
 common/rc                          |  11 +-
 include/buildrules                 |  32 ++++
 tests/btrfs/130                    |  89 ++++++++++
 tests/btrfs/130.out                |   3 +
 tests/btrfs/Makefile               |   4 +-
 tests/btrfs/group                  |   9 +-
 tests/cifs/Makefile                |   4 +-
 tests/ext4/Makefile                |   4 +-
 tests/f2fs/Makefile                |   4 +-
 tests/generic/075                  |   4 +-
 tests/generic/112                  |   2 +-
 tests/generic/120                  |   2 +
 tests/generic/235                  |   9 +-
 tests/generic/235.out              |   8 -
 tests/generic/Makefile             |   4 +-
 tests/overlay/Makefile             |   4 +-
 tests/shared/Makefile              |   4 +-
 tests/udf/Makefile                 |   4 +-
 tests/xfs/083                      |   4 +
 tests/xfs/191-input-validation     | 338 +++++++++++++++++++++++++++++++++++++
 tests/xfs/191-input-validation.out |   2 +
 tests/xfs/Makefile                 |   4 +-
 tests/xfs/group                    |   3 +-
 25 files changed, 533 insertions(+), 51 deletions(-)
--
Eryu Guan
eguan@redhat.com
