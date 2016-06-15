Received: from mx1.redhat.com ([209.132.183.28]:41008 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbcFOKUK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 15 Jun 2016 06:20:10 -0400
Message-Id: <201606151020.u5FAK3IT025412@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Wed, 15 Jun 2016 18:20:02 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-06-15
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Dave Chinner <dchinner@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This is my
first public pull request for fstests, and I followed your pull request format
to Linus. I reviewed & picked up as many patches as I can, also included
patches posted to the list since this Monday. Two patchsets are not reviewed,
rachacl tests from Andreas Gruenbacher, and bind mount & shared subtree tests
from Zorro Lang. I need more time working on them. Jan Tulak's xfs mkfs tests
and fixes need help from xfs developers to review.

For release testing, I tested building fstests after a new clone and after
fetching new commits in existing repo, on x86_64 (with both upstream xfsprogs
and xfsprogs shipped with RHEL7) and ppc64le hosts. And I tested xfs, extN,
btrfs, overlay, NFS, CIFS, with 4.7-rc1 kernel. For xfs and extN, I tested with
different block sizes and mkfs/mount options (crc=1, finobt=1, sparse=1,
data=journal|writeback). All test results looked good to me.

Please pull and review, any problems/comments/suggestions please let me know.

Thanks,
Eryu

The following changes since commit 048edf040490c8480db111849420492f78121846:

  generic: renumber tests after merge (2016-05-09 16:03:29 +1000)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 5f02db6f02e4e0f8d4ddd53e7f5e0c3d5e32d347:

  btrfs: qgroup handling on data extents balance (2016-06-15 16:46:12 +0800)

----------------------------------------------------------------

fstests: update on 2016-06-15

This update contains:
o Darrick J. Wong's new reflink tests and fixes
o Avoid build failure caused by struct fsxattr redefinition
o New tests for generic, shared, xfs, ext4, btrfs and overlay
o Various small fixes

----------------------------------------------------------------
Brian Foster (1):
      xfs: discontiguous multi-block buffer logging test

Christoph Hellwig (2):
      generic/346: add to the quick and rw groups
      generic/186-7: fix unreferenced variables

Darrick J. Wong (8):
      xfs/104: don't enospc when ag metadata overhead grows
      generic: don't put loop control files on the scratch mount
      xfs: recover copy-on-write leftover
      xfs: check accounting during refcountbt expansion
      reflink: avoid reflink on swap files
      xfs: map multiple bmbt records to a single rmapbt record
      reflink: change block sharing with constant refcount
      xfs/122: don't break on old xfsprogs

Eric Sandeen (2):
      dmerror: exclude dmerror tests with mount -o dax
      xfs: filter stripe width details from repair

Eryu Guan (4):
      generic/250: ignore xfs_io IO errors when writing to dmerror device
      generic: clear of suid/sgid on direct write
      generic: check symlink to very long path
      generic: check remount on I/O errors

Guangwen Feng (1):
      shared: check corrupted orphaned inode list handling

Jan Kara (1):
      generic: Test handling of private file mappings

Jeffrey Bastian (1):
      build: avoid struct fsxattr redefinition

Lu Fengqi (1):
      btrfs: check qgroup on extent de-reference

Masayoshi Mizuma (1):
      fstests: add _require_command check to killall

Qu Wenruo (3):
      generic: extent map search on dedupe file
      generic: check fiemap SHARED flag on sync
      btrfs: qgroup handling on data extents balance

Tahsin Erdogan (1):
      generic/131: dynamically allocate tcp listen port to avoid port clashes

Theodore Ts'o (3):
      defrag: test $TEST_DEV for extents for ext4 defrag
      generic: mark tests that require O_DIRECT
      shared/272: don't try to use O_DIRECT

Wang Xiaoguang (2):
      generic/015,274: add to the 'enospc' group
      ext4: regression test for fsync transaction ids initialization

Xiong Zhou (1):
      overlay: test memleak in copy-up error handling path

Zorro Lang (2):
      xfs/133-4: filter redundant projid 0 quota report info out
      common/rc: teach _require_xfs_io_command accept multi-parameters

 common/config           |   1 +
 common/defrag           |   2 +-
 common/dmerror          |   5 ++
 common/dmhugedisk       |  60 ++++++++++++++++
 common/filter           |   9 +++
 common/punch            |  17 +++++
 common/rc               |   7 +-
 common/repair           |   2 +
 ltp/fsstress.c          |   2 +-
 src/holetest.c          | 121 +++++++++++++++++++++++---------
 src/locktest.c          |  16 ++++-
 src/t_immutable.c       |   4 +-
 tests/btrfs/028         |  95 +++++++++++++++++++++++++
 tests/btrfs/028.out     |   2 +
 tests/btrfs/123         |  85 +++++++++++++++++++++++
 tests/btrfs/123.out     |  67 ++++++++++++++++++
 tests/btrfs/group       |   2 +
 tests/ext4/021          | 106 ++++++++++++++++++++++++++++
 tests/ext4/021.out      |   2 +
 tests/ext4/group        |   1 +
 tests/generic/051       |   5 +-
 tests/generic/094       |   1 +
 tests/generic/131       |  17 ++---
 tests/generic/162       |   8 ++-
 tests/generic/163       |   8 ++-
 tests/generic/164       |   8 ++-
 tests/generic/165       |   8 ++-
 tests/generic/166       |   8 ++-
 tests/generic/167       |   8 ++-
 tests/generic/168       |   8 ++-
 tests/generic/170       |   8 ++-
 tests/generic/186       |   2 +-
 tests/generic/187       |   2 +-
 tests/generic/225       |   1 +
 tests/generic/250       |   5 +-
 tests/generic/250.out   |   3 +-
 tests/generic/270       |   3 +-
 tests/generic/310       |   5 +-
 tests/generic/311       |   1 +
 tests/generic/333       |  20 +++---
 tests/generic/334       |  20 +++---
 tests/generic/352       |  98 ++++++++++++++++++++++++++
 tests/generic/352.out   |   5 ++
 tests/generic/353       |  92 +++++++++++++++++++++++++
 tests/generic/353.out   |  15 ++++
 tests/generic/354       |  60 ++++++++++++++++
 tests/generic/354.out   |  73 ++++++++++++++++++++
 tests/generic/355       |  98 ++++++++++++++++++++++++++
 tests/generic/355.out   |  14 ++++
 tests/generic/356       |  74 ++++++++++++++++++++
 tests/generic/356.out   |   6 ++
 tests/generic/357       |  73 ++++++++++++++++++++
 tests/generic/357.out   |   5 ++
 tests/generic/358       |  80 +++++++++++++++++++++
 tests/generic/358.out   |  69 +++++++++++++++++++
 tests/generic/359       |  94 +++++++++++++++++++++++++
 tests/generic/359.out   |  20 ++++++
 tests/generic/360       |  63 +++++++++++++++++
 tests/generic/360.out   |   2 +
 tests/generic/361       |  78 +++++++++++++++++++++
 tests/generic/361.out   |   2 +
 tests/generic/group     |  16 ++++-
 tests/overlay/005       | 115 +++++++++++++++++++++++++++++++
 tests/overlay/005.out   |   2 +
 tests/overlay/group     |   1 +
 tests/shared/004        |  64 +++++++++++++++++
 tests/shared/004.out    |   2 +
 tests/shared/272        |   4 +-
 tests/shared/group      |   1 +
 tests/xfs/011           |   5 +-
 tests/xfs/013           |   5 +-
 tests/xfs/030.out.linux |   4 +-
 tests/xfs/051           |   5 +-
 tests/xfs/070           |   3 +-
 tests/xfs/079           |   3 +-
 tests/xfs/104           |   9 ++-
 tests/xfs/122           |  17 ++---
 tests/xfs/122.out       |   1 +
 tests/xfs/133           |   2 +-
 tests/xfs/134           |  20 ++++--
 tests/xfs/141           |   3 +-
 tests/xfs/148.out       |   4 +-
 tests/xfs/167           |   2 +-
 tests/xfs/178.out       |   4 +-
 tests/xfs/297           |   3 +-
 tests/xfs/305           |   3 +-
 tests/xfs/306           | 121 ++++++++++++++++++++++++++++++++
 tests/xfs/306.out       |   2 +
 tests/xfs/307           | 179 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/307.out       |  13 ++++
 tests/xfs/308           | 180 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/308.out       |  13 ++++
 tests/xfs/309           |  95 +++++++++++++++++++++++++
 tests/xfs/309.out       |  10 +++
 tests/xfs/310           | 119 ++++++++++++++++++++++++++++++++
 tests/xfs/310.out       |  13 ++++
 tests/xfs/group         |   5 ++
 97 files changed, 2678 insertions(+), 146 deletions(-)
--
Eryu Guan
eguan@redhat.com
