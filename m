Received: from mx1.redhat.com ([209.132.183.28]:56128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755250AbcIQIpQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 17 Sep 2016 04:45:16 -0400
Message-Id: <201609170845.u8H8jDeE007426@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Sat, 17 Sep 2016 16:45:13 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-09-17
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This is a small
update that only contains two new tests and a fix to xfs/098.

Thanks,
Eryu

The following changes since commit 06d400134e1148461402f640036b8ccc2f6e4c93:

  xfs: test getbmapx shared extent reporting (2016-09-08 19:36:13 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 81dc4bc7280ca01f8048f7db85492c3282ed070a:

  xfs: various operations on mounted fs (2016-09-15 12:26:58 +0800)

----------------------------------------------------------------

fstests: update on 2016-09-17

This update contains:
o New tests for xfs and overlayfs
o Fix to xfs/098

----------------------------------------------------------------
Eryu Guan (1):
      overlay: sgid inheritance over whiteout

Xiao Yang (1):
      xfs/098: fix xfs_repair on newer xfsprogs

Zorro Lang (1):
      xfs: various operations on mounted fs

 common/rc             |   2 +-
 tests/overlay/015     |  97 +++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/015.out |   6 +++
 tests/overlay/group   |   1 +
 tests/xfs/098         |  16 +++++++-
 tests/xfs/284         | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/284.out     |   8 ++++
 tests/xfs/group       |   1 +
 8 files changed, 236 insertions(+), 2 deletions(-)
--
Eryu Guan
eguan@redhat.com
