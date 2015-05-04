Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:44493 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752776AbbEDM7w (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 4 May 2015 08:59:52 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1YpFyN-0004O7-S5
	for fstests@vger.kernel.org; Mon, 04 May 2015 22:59:47 +1000
Date: Mon, 4 May 2015 22:59:47 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests master branch updated to c3d3e1e
Message-ID: <20150504125947.GH15810@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.

The new head of the master branch is commit:

c3d3e1e xfstests: btrfs: 020 is bit diverted from its objective

New Commits:

Anand Jain (1):
      [c3d3e1e] xfstests: btrfs: 020 is bit diverted from its objective

Dave Chinner (2):
      [d5425f4] generic: LVM and ram disks don't play well
      [9435b92] common: _require_command needs to handle parameters

Eryu Guan (7):
      [0a0dd14] generic: test quota handling on remount ro failure
      [ddb8f4e] generic: test hardlink to unlinked file
      [3634bde] shared: test truncate orphan inodes when mounting extN
      [6139f10] generic: test fs freeze/unfreeze and mount/umount race
      [bd8febe] generic: add _require_metadata_journaling to more tests
      [b928ca4] shared/289: do not special-case ext3
      [69cb5fb] generic/204: use more space for inode allocation

Filipe Manana (3):
      [2fbdbfb] btrfs: test btrfs send after complex directory hierarchy changes
      [1a9dfb7] btrfs: exercise transaction abort on device with discard support
      [51c53eb] btrfs: test btrfs send after swapping directory names differently

Lukas Czerner (1):
      [7699037] generic: test data corruption on ext4 caused by written/delayed extent

Qu Wenruo (2):
      [842c5a5] btrfs: Check return value of "btrfs filesystem show" command
      [f24afad] btrfs: Incorrect exclusive reference number after file clone.


Code Diffstat:

 common/rc             |  50 +++++++++----
 tests/btrfs/020       |   2 -
 tests/btrfs/087       | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/087.out   |   2 +
 tests/btrfs/088       | 133 +++++++++++++++++++++++++++++++++
 tests/btrfs/088.out   |   9 +++
 tests/btrfs/090       |  71 ++++++++++++++++++
 tests/btrfs/090.out   |   2 +
 tests/btrfs/091       | 102 ++++++++++++++++++++++++++
 tests/btrfs/091.out   |   7 ++
 tests/btrfs/092       | 186 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/092.out   |   2 +
 tests/btrfs/group     |   5 ++
 tests/generic/039     |   1 +
 tests/generic/059     |   1 +
 tests/generic/081     |   1 -
 tests/generic/082     |  73 ++++++++++++++++++
 tests/generic/082.out |   3 +
 tests/generic/084     | 104 ++++++++++++++++++++++++++
 tests/generic/084.out |   2 +
 tests/generic/085     | 106 +++++++++++++++++++++++++++
 tests/generic/085.out |   2 +
 tests/generic/086     |  85 +++++++++++++++++++++
 tests/generic/086.out |  14 ++++
 tests/generic/204     |   6 +-
 tests/generic/325     |   1 +
 tests/generic/group   |   4 +
 tests/shared/001      |  71 ++++++++++++++++++
 tests/shared/001.out  |   2 +
 tests/shared/289      |  13 +---
 tests/shared/group    |   1 +
 31 files changed, 1230 insertions(+), 30 deletions(-)
 create mode 100755 tests/btrfs/087
 create mode 100644 tests/btrfs/087.out
 create mode 100755 tests/btrfs/088
 create mode 100644 tests/btrfs/088.out
 create mode 100755 tests/btrfs/090
 create mode 100644 tests/btrfs/090.out
 create mode 100755 tests/btrfs/091
 create mode 100644 tests/btrfs/091.out
 create mode 100755 tests/btrfs/092
 create mode 100644 tests/btrfs/092.out
 create mode 100755 tests/generic/082
 create mode 100644 tests/generic/082.out
 create mode 100755 tests/generic/084
 create mode 100644 tests/generic/084.out
 create mode 100755 tests/generic/085
 create mode 100644 tests/generic/085.out
 create mode 100755 tests/generic/086
 create mode 100644 tests/generic/086.out
 create mode 100755 tests/shared/001
 create mode 100644 tests/shared/001.out
-- 
Dave Chinner
david@fromorbit.com
