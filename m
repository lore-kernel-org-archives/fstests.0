Received: from mx1.redhat.com ([209.132.183.28]:53918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbcHTOoK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 20 Aug 2016 10:44:10 -0400
Message-Id: <201608201444.u7KEi22g015351@int-mx14.intmail.prod.int.phx2.redhat.com>
Date: Sat, 20 Aug 2016 22:44:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-08-20
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This is a
normal update, which contains new generic and XFS tests and other fixes.

Thanks,
Eryu

The following changes since commit c760a54061d26890be3929e4c6659bf3dc9e0c6a:

  src/t_immutable: allow EPERM on immutable inode (2016-08-12 11:17:34 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 3c75489a57518745598e239ffeec2af64400f185:

  common/rc: improve _require_metadata_journaling() for ext4 (2016-08-20 00:54:28 +0800)

----------------------------------------------------------------

fstests: update on 2016-08-20

This update contains:
o New tests for generic and XFS
o Miscellaneous small fixes

----------------------------------------------------------------
Brian Foster (1):
      generic: shutdown fs after log recovery

Eric Sandeen (2):
      common/quota: add prjquota to _qmount_option() filter
      xfs: test xfs_quota "state" command

Eric Whitney (2):
      generic/135: redirect stderr from _scratch_mkfs
      common/rc: improve _require_metadata_journaling() for ext4

Omar Sandoval (1):
      src/test-nextquota: fix build failure with glibc 2.24

Xiao Yang (1):
      xfs/191: skip tests on older xfsprogs

 common/quota          |   1 +
 common/rc             |  18 +++--
 src/test-nextquota.c  |   9 ++-
 tests/generic/135     |   2 +-
 tests/generic/375     |  89 ++++++++++++++++++++++
 tests/generic/375.out |   2 +
 tests/generic/group   |   1 +
 tests/xfs/263         |  97 ++++++++++++++++++++++++
 tests/xfs/263.out     | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/group       |   1 +
 10 files changed, 408 insertions(+), 11 deletions(-)
--
Eryu Guan
eguan@redhat.com
