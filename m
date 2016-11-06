Received: from mx1.redhat.com ([209.132.183.28]:47338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbcKFFJl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 6 Nov 2016 01:09:41 -0400
Message-Id: <201611060509.uA659dRZ008618@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Sun, 06 Nov 2016 13:09:39 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-11-06
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? There're only
two patches in this update, one is to add support to cephfs and one to filter
out all "64" from xfs_io error messages.

New failure I noticed in this update:
- xfs/021 fails due to extra lines outputed by latest xfs_db, a patch to fix
  xfs/021 is in the list for review.

Thanks,
Eryu

The following changes since commit efef020df5b257085831106847d318c93d46531c:

  src/seek_sanity_test: discover allocation size (2016-10-26 19:15:44 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to e604301e2605a152d8438f60d893ff29ed65d637:

  common: add CephFS support (2016-11-05 17:30:14 +0800)

----------------------------------------------------------------

fstests: update on 2016-11-06

This update contains:
o Add cephfs support
o Filter out all "64" suffix from xfs_io error messages

----------------------------------------------------------------
Dave Chinner (1):
      filter: xfs_io output has dropped "64" from error messages

Joao Eduardo Luis (1):
      common: add CephFS support

 README.config-sections |  6 ++++++
 common/config          |  9 +++++++++
 common/filter          |  7 +++++++
 common/rc              | 21 ++++++++++++++++++---
 tests/btrfs/126        |  4 ++--
 tests/btrfs/126.out    |  2 +-
 tests/ext4/306         |  3 ++-
 tests/ext4/306.out     |  2 +-
 tests/f2fs/001         |  6 ++----
 tests/f2fs/001.out     |  2 +-
 tests/generic/171      |  6 ++++--
 tests/generic/171.out  |  4 ++--
 tests/generic/172      |  6 ++++--
 tests/generic/172.out  |  4 ++--
 tests/generic/174      |  6 ++++--
 tests/generic/174.out  |  4 ++--
 tests/generic/230      | 12 ++++++++----
 tests/generic/230.out  |  8 ++++----
 tests/generic/271      |  3 ++-
 tests/generic/271.out  |  2 +-
 tests/generic/272      |  3 ++-
 tests/generic/272.out  |  2 +-
 tests/generic/276      |  3 ++-
 tests/generic/276.out  |  2 +-
 tests/generic/278      |  3 ++-
 tests/generic/278.out  |  2 +-
 tests/generic/328      |  6 ++++--
 tests/generic/328.out  |  4 ++--
 tests/xfs/071          |  4 ++--
 tests/xfs/071.out.64   | 20 ++++++++++----------
 tests/xfs/182          |  6 ++++--
 tests/xfs/182.out      |  2 +-
 32 files changed, 114 insertions(+), 60 deletions(-)
--
Eryu Guan
eguan@redhat.com
