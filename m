Received: from userp2130.oracle.com ([156.151.31.86]:35718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754515AbeE1JtN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 May 2018 05:49:13 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 0/4] fstests: btrfs seed test cases
Date: Mon, 28 May 2018 17:51:44 +0800
Message-Id: <20180528095148.30828-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

1/4 was sent separately which is now integrated into this set, with some
 changes as indicated in the patch.
Though rest of the patches 2/4..4/4 are new, they carry the set version v2.

These test cases verify the seed sprout opertions.

Anand Jain (4):
  fstests: btrfs: add seed sprout functionality test
  fstests: btrfs: nested seed device test
  fstests: btrfs: seed device replace test
  fstests: btrfs: seed device delete test

 common/config       |   1 +
 tests/btrfs/161     |  90 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/161.out |   9 +++++
 tests/btrfs/162     | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/162.out |   9 +++++
 tests/btrfs/163     | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/163.out |   9 +++++
 tests/btrfs/164     | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/164.out |   9 +++++
 tests/btrfs/group   |   4 ++
 10 files changed, 462 insertions(+)
 create mode 100755 tests/btrfs/161
 create mode 100644 tests/btrfs/161.out
 create mode 100755 tests/btrfs/162
 create mode 100644 tests/btrfs/162.out
 create mode 100755 tests/btrfs/163
 create mode 100644 tests/btrfs/163.out
 create mode 100755 tests/btrfs/164
 create mode 100644 tests/btrfs/164.out

-- 
2.7.0

