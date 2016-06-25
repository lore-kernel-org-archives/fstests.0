Received: from mx1.redhat.com ([209.132.183.28]:39828 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbcFYJ6K (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 25 Jun 2016 05:58:10 -0400
Message-Id: <201606250958.u5P9w8Bn001094@int-mx13.intmail.prod.int.phx2.redhat.com>
Date: Sat, 25 Jun 2016 17:58:08 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [GIT PULL] fstests: updates on 2016-06-25
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Can you please pull the fstests update from the location below? This is
a relatively small update, it contains three regression tests for
overlayfs, a new helper to exclude certain mount option in
$MOUNT_OPTIONS, and various small fixes.

Thanks,
Eryu

The following changes since commit 5f02db6f02e4e0f8d4ddd53e7f5e0c3d5e32d347:

  btrfs: qgroup handling on data extents balance (2016-06-15 16:46:12 +0800)

are available in the git repository at:

  https://github.com/guaneryu/xfstests.git for-dave

for you to fetch changes up to 54774d4bb5f8b5756913034cf9fdd28ba5bee03c:

  ext4/271: _notrun if there are journal related mount options (2016-06-24 12:54:04 +0800)

----------------------------------------------------------------

fstests: update on 2016-06-24

This update contains:
o New regression tests for overlayfs
o New helper _exclude_scratch_mount_option
o Various small fixes

----------------------------------------------------------------
Anand Jain (1):
      btrfs/006: ignore btrfs filesystem sync stdout output

Andreas Gruenbacher (1):
      generic/026: This test doesn't require runas

Brian Foster (1):
      fstests: support check for uuidgen utility

Eric Sandeen (1):
      xfs/186: fix test for crc=0, ftype=1

Eryu Guan (7):
      xfs/186: run test on expected XFS configuration
      dmthin: express low_water in cluster_size not sector size
      overlay: test visible whiteout issue after rename
      overlay: getcwd() after a failed rmdir
      overlay: create new file over whiteout
      fstests: introduce _exclude_scratch_mount_option helper
      ext4/271: _notrun if there are journal related mount options

 README                |  3 +-
 common/config         |  1 +
 common/dmthin         |  2 ++
 common/rc             |  9 ++++++
 tests/btrfs/006       |  2 +-
 tests/btrfs/006.out   |  1 -
 tests/ext4/271        |  6 ++++
 tests/generic/026     |  3 --
 tests/generic/192     | 11 -------
 tests/overlay/006     | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/006.out |  2 ++
 tests/overlay/007     | 65 +++++++++++++++++++++++++++++++++++++++
 tests/overlay/007.out |  2 ++
 tests/overlay/008     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/008.out |  3 ++
 tests/overlay/group   |  3 ++
 tests/xfs/134         |  8 ++---
 tests/xfs/186         | 24 +++++++++++++--
 tests/xfs/306         |  3 +-
 19 files changed, 284 insertions(+), 26 deletions(-)
--
Eryu Guan
eguan@redhat.com
