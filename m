Received: from mx1.redhat.com ([209.132.183.28]:57896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbcJOQ4h (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 15 Oct 2016 12:56:37 -0400
Message-Id: <201610151656.u9FGuYWG002567@int-mx10.intmail.prod.int.phx2.redhat.com>
Date: Sun, 16 Oct 2016 00:56:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-10-15
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? It's a
relatively small update, which mainly improves sgid clearance test.

And I'll be travelling most time of next week, and have limited internet
access. I'll try to review/test patches and send pull request as usual, but no
promise.

Thanks,
Eryu

The following changes since commit c61fa13e94513c15340a1891282e2513bdd087e1:

  xfs: renumber tests after merge (2016-10-08 14:02:04 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 16ef0843f2122deaf9845833ae73f60c67862aa4:

  xfs/122: remove dead code (2016-10-14 10:05:34 +0800)

----------------------------------------------------------------

fstests: update on 2016-10-15

This update contains:
o Improve sgid clearance tests in generic/314 and generic/375
o Remove dead code in xfs/122 and fix _sysfs_dev

----------------------------------------------------------------
Eric Biggers (2):
      generic/375: test both regular file and directory
      generic/314: don't test SGID behavior after setfacl

Eryu Guan (1):
      xfs/122: remove dead code

Zorro Lang (1):
      common/rc: use real device name in _sysfs_dev function

 common/rc             |  2 +-
 tests/generic/314     |  8 ++------
 tests/generic/314.out |  1 -
 tests/generic/375     | 54 ++++++++++++++++++++++++++++++++-------------------
 tests/generic/375.out |  8 ++++++++
 tests/xfs/122         |  4 ----
 6 files changed, 45 insertions(+), 32 deletions(-)
--
Eryu Guan
eguan@redhat.com
