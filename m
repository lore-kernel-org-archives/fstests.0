Received: from mx1.redhat.com ([209.132.183.28]:33790 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcHMHup (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Aug 2016 03:50:45 -0400
Message-Id: <201608130750.u7D7ohIc007295@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Sat, 13 Aug 2016 15:50:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-08-13
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This is a small
update which only contains 4 commits, including new reflink tests and fixes and
fix to src/t_immutable.c

Thanks,
Eryu

The following changes since commit b7d908a0e8eb3bc069275dedfe981f9ea3aeeec2:

  README: document Fedora, RHEL, and CentOS dependencies (2016-08-06 00:01:10 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to c760a54061d26890be3929e4c6659bf3dc9e0c6a:

  src/t_immutable: allow EPERM on immutable inode (2016-08-12 11:17:34 +0800)

----------------------------------------------------------------

fstests: update on 2016-08-13

This update contains:
o New reflink tests
o Scrub filesystem at the end of tests
o Fixes to xfs/122 and src/t_immutable.c

----------------------------------------------------------------
Darrick J. Wong (3):
      reflink: test cross-mountpoint reflink and dedupe
      xfs: scrub fs at the end of the test
      xfs/122: add the realtime rmapbt inode and btree fields

Eryu Guan (1):
      src/t_immutable: allow EPERM on immutable inode

 README                |   3 ++
 common/config         |   1 +
 common/rc             |   7 ++++
 src/t_immutable.c     | 108 +++++++++++++++++++++++++-------------------------
 tests/generic/373     |  90 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/373.out |   9 +++++
 tests/generic/374     |  88 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/374.out |  10 +++++
 tests/generic/group   |   2 +
 tests/xfs/122.out     |   6 ++-
 10 files changed, 269 insertions(+), 55 deletions(-)
--
Eryu Guan
eguan@redhat.com
