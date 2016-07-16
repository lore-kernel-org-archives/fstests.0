Received: from mx1.redhat.com ([209.132.183.28]:39016 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbcGPK23 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 16 Jul 2016 06:28:29 -0400
Message-Id: <201607161028.u6GASRfh013586@int-mx13.intmail.prod.int.phx2.redhat.com>
Date: Sat, 16 Jul 2016 18:28:26 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-07-16
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This is a
relatively small update compared to previous updates.

Thanks,
Eryu

The following changes since commit 024bdaea1c5741d37bf62b0fcb5a581ede5a5682:

  ext4/021: add _require_metadata_journaling (2016-07-08 10:51:54 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 2caf9a321867662dc195bef5fa214a03ba8fd070:

  generic: add _require_block_device to more tests (2016-07-16 17:34:57 +0800)

----------------------------------------------------------------

fstests: update on 2016-07-16

This update contains:
o New btrfs tests
o Skip xfs/096 if mkfs.xfs doesn't accept invalid inputs
o Other small fixes

----------------------------------------------------------------
Eryu Guan (1):
      generic: add _require_block_device to more tests

Filipe Manana (3):
      btrfs: incremental send after moving directories around
      btrfs: incremental send after removing a directory
      btrfs: invalid rmdir issued by send operation

Jan Tulak (2):
      common/rc: add _require_xfs_mkfs_validation
      xfs/096: run test only if mkfs.xfs accepts invalid inputs

Qu Wenruo (1):
      btrfs/079: Fix wrong value passed to available space check

 common/rc           |  35 +++++++
 tests/btrfs/079     |   2 +-
 tests/btrfs/127     | 263 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/127.out |   2 +
 tests/btrfs/128     | 129 ++++++++++++++++++++++++++
 tests/btrfs/128.out |   2 +
 tests/btrfs/129     | 125 +++++++++++++++++++++++++
 tests/btrfs/129.out |   2 +
 tests/btrfs/group   |   3 +
 tests/generic/067   |   1 +
 tests/generic/299   |   1 +
 tests/generic/300   |   1 +
 tests/xfs/096       |   1 +
 13 files changed, 566 insertions(+), 1 deletion(-)
--
Eryu Guan
eguan@redhat.com
