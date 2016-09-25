Received: from mx1.redhat.com ([209.132.183.28]:33782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966115AbcIYLDy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 25 Sep 2016 07:03:54 -0400
Message-Id: <201609251103.u8PB3pxh029944@int-mx14.intmail.prod.int.phx2.redhat.com>
Date: Sun, 25 Sep 2016 19:03:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-09-25
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This update
contains patches accumulated in last two weeks.

Eric moved several quota and project quota tests in xfs dir to generic, to have
some initial test coverage on ext4 project quota code. Many thanks to Eric! And
there're also new tests and new fixes as usual.

New failures I noticed in this update:
- generic/387 fails on btrfs
- btrfs/131 fails on btrfs

Thanks,
Eryu

The following changes since commit 06d400134e1148461402f640036b8ccc2f6e4c93:

  xfs: test getbmapx shared extent reporting (2016-09-08 19:36:13 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 0bbd20b104765c75faaf8e28a54c32df505ce7fd:

  btrfs: test free space tree mount options (2016-09-24 00:39:13 +0800)

----------------------------------------------------------------

fstests: update on 2016-09-25

This update contains:
o Move some quota tests from xfs dir to generic dir
o New tests for btrfs, overlayfs, xfs and generic fs
o Misc fixes

----------------------------------------------------------------
Eric Sandeen (4):
      xfs/260: fix output to match actions
      xfs: modify quota tests to work on generic filesystems
      fstests: move now-generic quota tests to generic
      xfs: make some xfs project quota tests generic

Eryu Guan (3):
      overlay: sgid inheritance over whiteout
      fstests: require scratch dev in tests using dm targets
      fstests: move now-generic xfs project quota tests generic

Omar Sandoval (1):
      btrfs: test free space tree mount options

Wang Xiaoguang (1):
      generic: truncate heavily reflinked file

Xiao Yang (2):
      xfs/098: fix xfs_repair on newer xfsprogs
      common/rc: fix fsmap check

Zorro Lang (1):
      xfs: various operations on mounted fs

 common/quota          |   55 +-
 common/rc             |   10 +-
 tests/btrfs/131       |  153 ++++
 tests/btrfs/131.out   |   20 +
 tests/btrfs/group     |    1 +
 tests/generic/347     |    1 +
 tests/generic/379     |  132 ++++
 tests/generic/379.out |   73 ++
 tests/generic/380     |   95 +++
 tests/generic/380.out |    9 +
 tests/generic/381     |   82 ++
 tests/generic/381.out |   13 +
 tests/generic/382     |  120 +++
 tests/generic/382.out |   25 +
 tests/generic/383     |   99 +++
 tests/generic/383.out |    8 +
 tests/generic/384     |  116 +++
 tests/generic/384.out |    5 +
 tests/generic/385     |  101 +++
 tests/generic/385.out | 2002 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/386     |  156 ++++
 tests/generic/386.out |    2 +
 tests/generic/387     |   81 ++
 tests/generic/387.out |    2 +
 tests/generic/group   |    9 +
 tests/overlay/015     |   97 +++
 tests/overlay/015.out |    6 +
 tests/overlay/group   |    1 +
 tests/xfs/006         |    2 +-
 tests/xfs/054         |  132 ----
 tests/xfs/054.out     |   73 --
 tests/xfs/098         |   16 +-
 tests/xfs/118         |   94 ---
 tests/xfs/118.out     |    9 -
 tests/xfs/133         |   95 ---
 tests/xfs/133.out     |    8 -
 tests/xfs/134         |  122 ---
 tests/xfs/134.out     |    5 -
 tests/xfs/138         |   81 --
 tests/xfs/138.out     |   13 -
 tests/xfs/196         |   98 ---
 tests/xfs/196.out     | 2002 -------------------------------------------------
 tests/xfs/260         |  119 ---
 tests/xfs/260.out     |   31 -
 tests/xfs/262         |  152 ----
 tests/xfs/262.out     |    2 -
 tests/xfs/264         |    2 +-
 tests/xfs/284         |  107 +++
 tests/xfs/284.out     |    8 +
 tests/xfs/group       |    9 +-
 50 files changed, 3598 insertions(+), 3056 deletions(-)
--
Eryu Guan
eguan@redhat.com
