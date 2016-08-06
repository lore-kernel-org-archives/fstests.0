Received: from mx1.redhat.com ([209.132.183.28]:49388 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbcHFUvd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 6 Aug 2016 16:51:33 -0400
Message-Id: <201608061013.u76ADGJr016961@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Sat, 06 Aug 2016 18:13:16 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-08-06
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? It mainly
contains fixes for reflink & rmap tests from Darrick J. Wong (first 11 patches
in the patchset, I'll go through the rest new tests next week).

Thanks,
Eryu

The following changes since commit 6721ab08bd2772da9f3aa1ae7b46b7cb5c0e8308:

  generic/235: Fix false failures for some quota formats (2016-07-21 17:44:30 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to b7d908a0e8eb3bc069275dedfe981f9ea3aeeec2:

  README: document Fedora, RHEL, and CentOS dependencies (2016-08-06 00:01:10 +0800)

----------------------------------------------------------------

fstests: update on 2016-08-06

This update contains:
o Fixes for reflink & rmap tests
o New generic tests and tests for xfs, ext4 and overlayfs
o Rewrite of xfs/106
o Other fixes and improvements in README, _require_defrag and check

----------------------------------------------------------------
Christoph Hellwig (1):
      generic/095: update warning whitelist

Darrick J. Wong (13):
      xfs/26[34]: remove duplicate tests
      xfs: use rmapbt-checking helper
      xfs/310: fix the size calculation for the huge device
      xfs/122: list the new log redo items
      common/reflink: actually test dedupe on scratch device
      xfs/129: fix post-metadump remounting idiocy
      xfs/179: use scratch device helpers
      xfs/234: use scratch device helpers
      common/rc: optionally test xfs_repair index rebuilding
      xfs/128: cycle_mount the scratch device
      common/dmerror: fix mount option issues
      xfs: test attr_list_by_handle cursor iteration
      generic: test accurate shared extent reporting

Eric Sandeen (1):
      README: document Fedora, RHEL, and CentOS dependencies

Eric Whitney (1):
      common/defrag: rework _require_defrag for ext4

Eryu Guan (3):
      overlay: dump overlay private xattr
      overlay: remove stale file from upperdir
      overlay: truncate running binaries from lower and upper dirs

Jan Kara (1):
      ext4: Test expansion of inode size

Omar Sandoval (1):
      check: allow comments in exclude files

Wang Xiaoguang (1):
      generic: run write(2) and fallocate(2) in parallel

Zorro Lang (1):
      xfs/106: rewrite to make it a reliable regression test

 .gitignore                            |   2 +
 README                                |  18 +-
 check                                 |   4 +-
 common/defrag                         |  17 +-
 common/dmerror                        |   9 +-
 common/rc                             |  29 ++
 common/reflink                        |   2 +-
 src/Makefile                          |   5 +-
 src/attr-list-by-handle-cursor-test.c | 118 +++++
 src/t_truncate_self.c                 |  20 +
 tests/ext4/022                        | 183 ++++++++
 tests/ext4/022.out                    | 432 +++++++++++++++++++
 tests/ext4/group                      |   1 +
 tests/generic/095                     |   6 +-
 tests/generic/371                     |  75 ++++
 tests/generic/371.out                 |   2 +
 tests/generic/372                     |  90 ++++
 tests/generic/372.out                 |  17 +
 tests/generic/group                   |   2 +
 tests/overlay/011                     |  79 ++++
 tests/overlay/011.out                 |   2 +
 tests/overlay/012                     |  77 ++++
 tests/overlay/012.out                 |   2 +
 tests/overlay/013                     |  74 ++++
 tests/overlay/013.out                 |   2 +
 tests/overlay/group                   |   3 +
 tests/xfs/106                         | 361 ++++++++++------
 tests/xfs/106.out                     | 790 +++++++++++++++++++---------------
 tests/xfs/122.out                     |   8 +
 tests/xfs/128                         |   6 +-
 tests/xfs/129                         |   6 +-
 tests/xfs/179                         |  10 +-
 tests/xfs/234                         |   6 +-
 tests/xfs/263                         | 179 --------
 tests/xfs/263.out                     |  13 -
 tests/xfs/264                         | 180 --------
 tests/xfs/264.out                     |  13 -
 tests/xfs/269                         |  64 +++
 tests/xfs/269.out                     |   5 +
 tests/xfs/310                         |   9 +-
 tests/xfs/314                         |   4 +-
 tests/xfs/317                         |   4 +-
 tests/xfs/322                         |   4 +-
 tests/xfs/group                       |   7 +-
 44 files changed, 2025 insertions(+), 915 deletions(-)
--
Eryu Guan
eguan@redhat.com
