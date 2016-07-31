Received: from mx1.redhat.com ([209.132.183.28]:54950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbcGaC4u (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 30 Jul 2016 22:56:50 -0400
Message-Id: <201607310256.u6V2uPFQ014241@int-mx11.intmail.prod.int.phx2.redhat.com>
Date: Sun, 31 Jul 2016 10:56:24 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-07-31
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This is a small
update that only contains some new tests.

Thanks,
Eryu

The following changes since commit 6721ab08bd2772da9f3aa1ae7b46b7cb5c0e8308:

  generic/235: Fix false failures for some quota formats (2016-07-21 17:44:30 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 2d7ed0ce0366175b57b135c8aa4b850d989a2d39:

  overlay: truncate running binaries from lower and upper dirs (2016-07-31 10:37:08 +0800)

----------------------------------------------------------------

fstests: update on 2016-07-31

This update contains:
o New overlayfs regression tests
o New generic test that exercises write(2) and fallocate(2)
o Rewrite of xfs/106

----------------------------------------------------------------
Eryu Guan (3):
      overlay: dump overlay private xattr
      overlay: remove stale file from upperdir
      overlay: truncate running binaries from lower and upper dirs

Wang Xiaoguang (1):
      generic: run write(2) and fallocate(2) in parallel

Zorro Lang (1):
      xfs/106: rewrite to make it a reliable regression test

 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/t_truncate_self.c |  20 ++
 tests/generic/371     |  75 +++++
 tests/generic/371.out |   2 +
 tests/generic/group   |   1 +
 tests/overlay/011     |  79 +++++
 tests/overlay/011.out |   2 +
 tests/overlay/012     |  77 +++++
 tests/overlay/012.out |   2 +
 tests/overlay/013     |  74 +++++
 tests/overlay/013.out |   2 +
 tests/overlay/group   |   3 +
 tests/xfs/106         | 361 ++++++++++++++---------
 tests/xfs/106.out     | 790 +++++++++++++++++++++++++++++---------------------
 tests/xfs/group       |   2 +-
 16 files changed, 1014 insertions(+), 479 deletions(-)
--
Eryu Guan
eguan@redhat.com
