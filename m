Received: from synology.com ([59.124.61.242]:38197 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965648AbcJ1BuD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 27 Oct 2016 21:50:03 -0400
From: robbieko <robbieko@synology.com>
Subject: [PATCH v2 0/4] Btrfs: add serval test case for incremental send
Date: Fri, 28 Oct 2016 09:44:02 +0800
Message-Id: <1477619046-16375-1-git-send-email-robbieko@synology.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Robbie Ko <robbieko@synology.com>
List-ID: <fstests@vger.kernel.org>

From: Robbie Ko <robbieko@synology.com>

Patch for test btrfs incremental send.

v2:
* Improve the change log

Robbie Ko (4):
  xfstests: btrfs/131: add test for an incremental send with name
    collision
  xfstests: btrfs/132: add test for invaild update time by an
    incremental send
  xfstests: btrfs/133: add test for incremental send with rmdir applied
    on wrong name
  xfstests: btrfs/134: add test for incremental send which renames a
    directory already being deleted

 tests/btrfs/131     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/131.out |   2 +
 tests/btrfs/132     | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/132.out |   2 +
 tests/btrfs/133     | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/133.out |   2 +
 tests/btrfs/134     | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/134.out |   2 +
 tests/btrfs/group   |   4 ++
 9 files changed, 482 insertions(+)
 create mode 100755 tests/btrfs/131
 create mode 100644 tests/btrfs/131.out
 create mode 100755 tests/btrfs/132
 create mode 100644 tests/btrfs/132.out
 create mode 100755 tests/btrfs/133
 create mode 100644 tests/btrfs/133.out
 create mode 100755 tests/btrfs/134
 create mode 100644 tests/btrfs/134.out

-- 
1.9.1

