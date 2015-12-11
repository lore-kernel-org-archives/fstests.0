Received: from mx1.redhat.com ([209.132.183.28]:33434 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125AbbLKIfa (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 11 Dec 2015 03:35:30 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 6B7D5DCA23
	for <fstests@vger.kernel.org>; Fri, 11 Dec 2015 08:35:30 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 0/4] fstests: rudimentary overlayfs testing support, take two
Date: Fri, 11 Dec 2015 16:35:03 +0800
Message-Id: <1449822907-31197-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Adding basic overlayfs support to fstests, it doesn't test anything
overlayfs specific, but runs existing tests on top of overlayfs. It's
following the path from Eric's patchset and Zab's review back in Mar.

A new fstype "overlay" is added, and TEST_DEV/SCRATCH_DEV are required
to be fs paths, and overlayfs is mounted at TEST_DIR/SCRATCH_MNT, so
tests can be run there.

I tested with the following config, the backing fs of TEST_DEV and
SCRATCH_DEV are both XFS

TEST_DEV=/mnt/ovl/test
TEST_DIR=/mnt/testarea/test
SCRATCH_DEV=/mnt/ovl/scratch
SCRATCH_MNT=/mnt/testarea/scratch

./check -overlay -g auto

Some tests failed:
generic/003	atime not updated (should _notrun on overlayfs?)
generic/062	failed to create whiteout device, fixed in patch 3
		overlayfs lacks of selinux support
generic/079	overlay dir inode has no ioctl method, fixed in patch 4
generic/192	atime not updated (should _notrun on overlayfs?)
generic/193	suid not cleard on write, will fix overlayfs
generic/31[49]	overlayfs not inherit default acl, will fix overlayfs

Patch 1 is from Eric, which introduces mount/umount helper functions to
mount/umount test and scratch devices. I did minor updates.

Patch 2 introduces the overlay support.

Patch 3 fixes generic/062 failure, but it still fails due to lack of
selinux support on overlayfs.

Patch 4 fixes generic/079 failure.

Thanks,
Eryu

Eric Sandeen (1):
  fstests: use mount/umount helpers everywhere

Eryu Guan (3):
  fstests: rudimentary overlayfs testing support
  generic/062: don't create WHITEOUT_DEV
  generic/079: _notrun if fs doesn't support ioctl

 check                 |  32 ++++-----
 common/attr           |   2 +-
 common/config         |  14 +++-
 common/dump           |   2 +-
 common/filestreams    |   2 +-
 common/log            |   6 +-
 common/punch          |   2 +-
 common/quota          |   2 +-
 common/rc             | 182 ++++++++++++++++++++++++++++++++++++++++----------
 common/repair         |   4 +-
 soak                  |   6 +-
 tests/btrfs/002       |   2 +-
 tests/btrfs/003       |  16 ++---
 tests/btrfs/004       |   6 +-
 tests/btrfs/005       |   4 +-
 tests/btrfs/007       |   6 +-
 tests/btrfs/011       |   6 +-
 tests/btrfs/029       |   4 +-
 tests/btrfs/031       |   2 +-
 tests/ext4/002        |   2 +-
 tests/ext4/301        |   2 +-
 tests/ext4/302        |   2 +-
 tests/ext4/303        |   2 +-
 tests/ext4/304        |   2 +-
 tests/ext4/305        |   4 +-
 tests/generic/014     |   2 +-
 tests/generic/015     |   2 +-
 tests/generic/019     |   2 +-
 tests/generic/043     |   4 +-
 tests/generic/044     |   4 +-
 tests/generic/045     |   4 +-
 tests/generic/046     |   4 +-
 tests/generic/047     |   4 +-
 tests/generic/048     |   4 +-
 tests/generic/049     |   4 +-
 tests/generic/050     |   8 +--
 tests/generic/050.out |   2 +-
 tests/generic/051     |  10 +--
 tests/generic/052     |   4 +-
 tests/generic/053     |   2 +-
 tests/generic/054     |   6 +-
 tests/generic/055     |   6 +-
 tests/generic/062     |   4 +-
 tests/generic/067     |   2 +-
 tests/generic/068     |   2 +-
 tests/generic/069     |   2 +-
 tests/generic/076     |   4 +-
 tests/generic/077     |   4 +-
 tests/generic/079     |   4 +-
 tests/generic/083     |   4 +-
 tests/generic/105     |   2 +-
 tests/generic/117     |   4 +-
 tests/generic/120     |   2 +-
 tests/generic/124     |   2 +-
 tests/generic/128     |   2 +-
 tests/generic/135     |   2 +-
 tests/generic/157     |   2 +-
 tests/generic/158     |   2 +-
 tests/generic/166     |   2 +-
 tests/generic/167     |   2 +-
 tests/generic/169     |   4 +-
 tests/generic/192     |   2 +-
 tests/generic/219     |   8 +--
 tests/generic/226     |   6 +-
 tests/generic/230     |   6 +-
 tests/generic/231     |  14 ++--
 tests/generic/232     |   6 +-
 tests/generic/233     |   6 +-
 tests/generic/234     |   2 +-
 tests/generic/235     |   6 +-
 tests/generic/256     |   2 +-
 tests/generic/258     |   2 +-
 tests/generic/269     |   2 +-
 tests/generic/274     |   2 +-
 tests/generic/275     |   2 +-
 tests/generic/280     |   4 +-
 tests/generic/299     |   2 +-
 tests/generic/300     |   2 +-
 tests/generic/317     |   8 +--
 tests/generic/318     |   8 +--
 tests/shared/289      |   4 +-
 tests/udf/098         |   6 +-
 tests/udf/101         |   2 +-
 tests/xfs/004         |   4 +-
 tests/xfs/006         |   2 +-
 tests/xfs/007         |   4 +-
 tests/xfs/009         |   2 +-
 tests/xfs/010         |   4 +-
 tests/xfs/011         |   4 +-
 tests/xfs/013         |   4 +-
 tests/xfs/014         |   4 +-
 tests/xfs/016         |   4 +-
 tests/xfs/017         |   4 +-
 tests/xfs/018         |   4 +-
 tests/xfs/019         |   6 +-
 tests/xfs/021         |   6 +-
 tests/xfs/030         |   4 +-
 tests/xfs/033         |   4 +-
 tests/xfs/034         |   4 +-
 tests/xfs/041         |   6 +-
 tests/xfs/042         |   4 +-
 tests/xfs/044         |   2 +-
 tests/xfs/050         |   4 +-
 tests/xfs/052         |   4 +-
 tests/xfs/054         |   6 +-
 tests/xfs/065         |   4 +-
 tests/xfs/071         |   2 +-
 tests/xfs/072         |   4 +-
 tests/xfs/073         |   4 +-
 tests/xfs/076         |   2 +-
 tests/xfs/081         |   6 +-
 tests/xfs/082         |   4 +-
 tests/xfs/104         |   2 +-
 tests/xfs/106         |   2 +-
 tests/xfs/108         |  10 +--
 tests/xfs/109         |   6 +-
 tests/xfs/110         |   2 +-
 tests/xfs/111         |   6 +-
 tests/xfs/116         |  10 +--
 tests/xfs/121         |   4 +-
 tests/xfs/134         |   2 +-
 tests/xfs/136         |   6 +-
 tests/xfs/148         |   4 +-
 tests/xfs/175         |   2 +-
 tests/xfs/176         |   2 +-
 tests/xfs/177         |   4 +-
 tests/xfs/181         |   4 +-
 tests/xfs/189         |  12 ++--
 tests/xfs/196         |   2 +-
 tests/xfs/199         |   6 +-
 tests/xfs/201         |   2 +-
 tests/xfs/220         |   6 +-
 tests/xfs/227         |   4 +-
 tests/xfs/244         |   4 +-
 tests/xfs/287         |   6 +-
 tests/xfs/299         |   6 +-
 tests/xfs/304         |   6 +-
 137 files changed, 451 insertions(+), 325 deletions(-)

-- 
1.8.3.1

