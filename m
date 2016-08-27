Received: from mx1.redhat.com ([209.132.183.28]:34026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbcH0K2G (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 27 Aug 2016 06:28:06 -0400
Message-Id: <201608271028.u7RAS346020335@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Sat, 27 Aug 2016 18:28:03 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-08-27
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This update
contains patches from last two weeks, and I replaced generic/375 with another
test (which doesn't crash latest upstream kernel) and dropped the original
generic/375 for now. And I kept the "xfs_quota state command" test from Eric,
because the failure looks expected to me (due to a missing kernel patch).

I'd like to mention new failures I noticed in this update (and I'd like to
continue do this in future pull requests):
- generic/375 fails on extN, XFS, btrfs and overlayfs due to sgid not cleard on
  setfacl. NFSv3 fails differently because of a setfacl bug.
- generic/376 fails dmesg check on btrfs if lockdep is turned on.
- xfs/263 fails on XFS.

If there's anything you want me to do in pull requests differently please let
me know.

Thanks,
Eryu

The following changes since commit c760a54061d26890be3929e4c6659bf3dc9e0c6a:

  src/t_immutable: allow EPERM on immutable inode (2016-08-12 11:17:34 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 21eb9d303cff056753a3104602ff674d468af52e:

  fstests: add punch, collapse, insert, zero test groups (2016-08-26 15:45:03 +0800)

----------------------------------------------------------------

fstests: update on 2016-08-27

This update contains:
o New tests for generic and XFS
o New punch, collapse, insert, zero groups
o Bug fixes of generic and XFS cases
o Bug fixes and improvements in common filters and helpers

----------------------------------------------------------------
Andreas Gruenbacher (1):
      generic: Check clearing of SGID in chmod and acl_set_file

Eric Sandeen (2):
      common/quota: add prjquota to _qmount_option() filter
      xfs: test xfs_quota "state" command

Eric Whitney (2):
      generic/135: redirect stderr from _scratch_mkfs
      common/rc: improve _require_metadata_journaling() for ext4

Filipe Manana (1):
      generic: fsync after file rename

Omar Sandoval (1):
      src/test-nextquota: fix build failure with glibc 2.24

Theodore Ts'o (1):
      fstests: add punch, collapse, insert, zero test groups

Xiao Yang (1):
      xfs/191: skip tests on older xfsprogs

Zorro Lang (3):
      xfs/033: source mkfs output again if isize less than 512
      xfs/006: refactor reset error handling code to common/rc
      xfs: EIO error handling test

 common/quota                |   1 +
 common/rc                   |  55 ++++++++++--
 src/test-nextquota.c        |   9 +-
 tests/btrfs/group           |   2 +-
 tests/ext4/group            |   4 +-
 tests/generic/135           |   2 +-
 tests/generic/375           |  81 ++++++++++++++++++
 tests/generic/375.out       |   9 ++
 tests/generic/376           |  77 +++++++++++++++++
 tests/generic/376.out       |   5 ++
 tests/generic/group         |  90 ++++++++++----------
 tests/xfs/006               |  27 ++----
 tests/xfs/006.out           |   1 +
 tests/xfs/033               |   8 +-
 tests/xfs/033.out.crc.linux |   6 --
 tests/xfs/033.out.irix      |   6 --
 tests/xfs/033.out.linux     |   6 --
 tests/xfs/263               |  97 +++++++++++++++++++++
 tests/xfs/263.out           | 199 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/264               | 126 ++++++++++++++++++++++++++++
 tests/xfs/264.out           |  21 +++++
 tests/xfs/group             |  24 +++---
 22 files changed, 746 insertions(+), 110 deletions(-)
--
Eryu Guan
eguan@redhat.com
