Received: from synology.com ([59.124.61.242]:53993 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758100AbdADLAR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Jan 2017 06:00:17 -0500
From: robbieko <robbieko@synology.com>
Subject: [PATCH v3 0/4] Btrfs: add serval test case for incremental send
Date: Wed,  4 Jan 2017 18:53:26 +0800
Message-Id: <1483527210-2530-1-git-send-email-robbieko@synology.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Robbie Ko <robbieko@synology.com>
List-ID: <fstests@vger.kernel.org>

From: Robbie Ko <robbieko@synology.com>

Patch for test btrfs incremental send.

V3: remove "run_" based helpers
V2: improve the change log

Robbie Ko (4):
  xfstests: btrfs/131: add test for an incremental send with name
    collision
  xfstests: btrfs/132: add test for invaild update time by an
    incremental send
  xfstests: btrfs/133: add test for incremental send with rmdir applied
    on wrong name
  xfstests: btrfs/134: add test for incremental send which renames a
    directory already being deleted

 tests/btrfs/131     | 115 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/131.out |   9 ++++
 tests/btrfs/132     | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/132.out |   7 +++
 tests/btrfs/133     | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/133.out |   9 ++++
 tests/btrfs/134     | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/134.out |   9 ++++
 tests/btrfs/group   |   4 ++
 9 files changed, 523 insertions(+)
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

