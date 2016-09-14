Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:59608 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbcINBzm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Sep 2016 21:55:42 -0400
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH v6 0/6] Btrfs in-band de-duplication test cases
Date: Wed, 14 Sep 2016 09:55:21 +0800
Message-Id: <20160914015527.10274-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc: fdmanana@gmail.com, mfasheh@suse.de
List-ID: <fstests@vger.kernel.org>

Btrfs in-band de-duplication test case for in-memory backend.
With extra option ALWAYS_ENABLE_BTRFS_FEATURE macro to enable dedupe/quota
for all test cases.
This is quite handy to hugely increase the coverage without introducing a lot
new test cases.

v6:
  Introduce ALWAYS_ENABLE_BTRFS_FEATURE macro to enable dedupe/quota for all
  existing test cases.
v5:
  Due to kernel ioctl change, add FORCE flag for "dedupe enable" ioctl call.
v4:
  Due to kernel patchset re-organization, remove on-disk backend test cases
v3:
  Add new test cases for on-disk backend with metadata balance
v2:
  Add new test cases for on-disk backend with full balance


Qu Wenruo (6):
  fstests: common: Introduce _post_mount_hook for btrfs
  fstests: common: rename _require_btrfs to _require_btrfs_subcommand
  fstests: Add btrfs dedupe post mount hook
  fstests: btrfs: Add basic test for btrfs in-band de-duplication
  fstests: btrfs: Add testcase for btrfs dedupe and metadata balance
    race test
  fstests: btrfs: Test inband dedupe with data balance.

 common/defrag       |  13 ++++++
 common/rc           |  41 ++++++++++++++++++-
 tests/btrfs/004     |   2 +-
 tests/btrfs/048     |   2 +-
 tests/btrfs/059     |   2 +-
 tests/btrfs/200     | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/200.out |  22 ++++++++++
 tests/btrfs/201     | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/201.out |   2 +
 tests/btrfs/203     | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/203.out |   3 ++
 tests/btrfs/group   |   3 ++
 12 files changed, 424 insertions(+), 4 deletions(-)
 create mode 100755 tests/btrfs/200
 create mode 100644 tests/btrfs/200.out
 create mode 100755 tests/btrfs/201
 create mode 100644 tests/btrfs/201.out
 create mode 100755 tests/btrfs/203
 create mode 100644 tests/btrfs/203.out

-- 
2.7.4



