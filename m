Received: from aserp2130.oracle.com ([141.146.126.79]:56902 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeFAPyv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Jun 2018 11:54:51 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 0/4] fstests: btrfs seed test cases
Date: Fri,  1 Jun 2018 23:57:22 +0800
Message-Id: <20180601155726.21308-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

v2->v3: Changes as per review comments as in the individual patches.

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
 tests/btrfs/161     |  91 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/161.out |   9 +++++
 tests/btrfs/162     | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/162.out |   9 +++++
 tests/btrfs/163     | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/163.out |   9 +++++
 tests/btrfs/164     | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/164.out |   9 +++++
 tests/btrfs/group   |   4 ++
 10 files changed, 458 insertions(+)
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

