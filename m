Received: from userp1040.oracle.com ([156.151.31.81]:22812 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdEQXgv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 19:36:51 -0400
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH v2 0/5] Regression test for btrfs read repair
Date: Wed, 17 May 2017 16:36:05 -0600
Message-Id: <20170517223610.3916-1-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

v2: - drop _get_current_dmesg as these patches don't use it any more.
    - In order to make the tests deterministic, change to check pid for
      odd/even instead of doing grep with key words in dmesg

This set is adding four regression test case for btrfs read repair, and both
directIO read and buffered read are tested.

Patch 1 is adding a helper to filter filefrag, patch 2-5 are the regression
test.

Liu Bo (5):
  fstests: add _filter_filefrag
  fstests: regression test for btrfs dio read repair
  fstests: regression test for btrfs buffered read's repair
  fstests: regression test for nocsum dio read's repair
  fstests: regression test for nocsum buffered read's repair

 common/filter       |  19 +++++++
 tests/btrfs/140     | 117 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/140.out |  39 ++++++++++++++
 tests/btrfs/141     | 118 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/141.out |  39 ++++++++++++++
 tests/btrfs/142     | 140 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/142.out |  39 ++++++++++++++
 tests/btrfs/143     | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/143.out |  39 ++++++++++++++
 tests/btrfs/group   |   4 ++
 10 files changed, 704 insertions(+)
 create mode 100755 tests/btrfs/140
 create mode 100644 tests/btrfs/140.out
 create mode 100755 tests/btrfs/141
 create mode 100644 tests/btrfs/141.out
 create mode 100755 tests/btrfs/142
 create mode 100644 tests/btrfs/142.out
 create mode 100755 tests/btrfs/143
 create mode 100644 tests/btrfs/143.out

-- 
2.5.0

