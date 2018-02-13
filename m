Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933797AbeBMJMU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Feb 2018 04:12:20 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [RFC PATCH 0/2] _fail test by default if _scratch_mount fails
Date: Tue, 13 Feb 2018 17:12:01 +0800
Message-Id: <20180213091203.22909-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi all,

This is an RFC patchset that follows Andreas Gruenbacher's recent post
"Failing scratch mounts"[1]. It changes _scratch_mount to call _fail on
mount failure by default, so that when the mount fails, the tests won't
write to the underlying filesystem and fail in implicit way, which
sometimes makes debugging harder to do.

Also introduce a new _scratch_mount_nocheck helper, which mount scratch
device and doesn't check the mount status, for tests that need to check
mount status themselves.

This two-patch patchset should really be one patch, but for easy review,
I split the patch into two pieces, the first patch introduce the new
_scratch_mount_nocheck helper and converts _scratch_mount usages in
common dir, the second patch converts all the tests (which can be
tedious).

I've tested it by running full '-g auto' tests against xfs/xfs with
reflink/ext4/btrfs and I didn't see any new failures.

(Note that I based this patchset against fstests release on Feb. 4th, so
I didn't convert the new tests release on Feb. 11th. And as this is an
RFC, I didn't write detailed commit log in each patch.)

Thanks,
Eryu

[1] https://www.spinics.net/lists/fstests/msg08903.html

Eryu Guan (2):
  fstests: introduce _scratch_mount_nocheck
  fstests: use _scratch_mount_nocheck where appropriate in tests

 common/attr        |  2 +-
 common/dmapi       |  4 ++--
 common/dump        |  4 ++--
 common/encrypt     |  2 +-
 common/filestreams |  4 ++--
 common/fuzzy       |  4 ++--
 common/log         |  6 +++---
 common/overlay     |  2 +-
 common/punch       |  2 +-
 common/quota       |  4 ++--
 common/rc          | 38 ++++++++++++++++++++++----------------
 common/xfs         | 12 ++++++------
 tests/btrfs/004    |  6 +++---
 tests/btrfs/007    |  4 ++--
 tests/btrfs/009    |  2 +-
 tests/btrfs/012    |  4 ++--
 tests/btrfs/042    |  2 +-
 tests/btrfs/057    |  2 +-
 tests/btrfs/091    |  4 ++--
 tests/btrfs/131    |  4 ++--
 tests/btrfs/136    |  2 +-
 tests/ext4/003     |  2 +-
 tests/ext4/006     |  4 ++--
 tests/ext4/007     |  2 +-
 tests/ext4/008     |  2 +-
 tests/ext4/011     |  4 ++--
 tests/ext4/012     |  4 ++--
 tests/ext4/024     |  2 +-
 tests/ext4/025     |  2 +-
 tests/ext4/305     |  2 +-
 tests/ext4/306     |  2 +-
 tests/generic/015  |  2 +-
 tests/generic/019  |  4 ++--
 tests/generic/050  | 10 +++++-----
 tests/generic/052  |  4 ++--
 tests/generic/053  |  2 +-
 tests/generic/054  |  4 ++--
 tests/generic/055  |  4 ++--
 tests/generic/062  |  2 +-
 tests/generic/064  |  2 +-
 tests/generic/068  |  2 +-
 tests/generic/069  |  2 +-
 tests/generic/076  |  2 +-
 tests/generic/077  |  2 +-
 tests/generic/079  |  2 +-
 tests/generic/082  |  4 ++--
 tests/generic/083  |  2 +-
 tests/generic/105  |  2 +-
 tests/generic/117  |  2 +-
 tests/generic/120  |  2 +-
 tests/generic/169  |  2 +-
 tests/generic/235  |  4 ++--
 tests/generic/270  |  2 +-
 tests/generic/294  |  2 +-
 tests/generic/317  |  2 +-
 tests/generic/318  |  2 +-
 tests/generic/388  |  2 +-
 tests/generic/390  |  2 +-
 tests/generic/403  |  2 +-
 tests/generic/466  |  2 +-
 tests/shared/003   |  2 +-
 tests/xfs/005      |  2 +-
 tests/xfs/009      |  2 +-
 tests/xfs/016      |  2 +-
 tests/xfs/017      |  6 +++---
 tests/xfs/019      |  2 +-
 tests/xfs/021      |  3 +--
 tests/xfs/034      |  2 +-
 tests/xfs/041      |  4 ++--
 tests/xfs/042      |  4 ++--
 tests/xfs/044      |  4 ++--
 tests/xfs/045      |  4 ++--
 tests/xfs/057      |  2 +-
 tests/xfs/067      |  2 +-
 tests/xfs/072      |  2 +-
 tests/xfs/073      |  2 +-
 tests/xfs/075      |  4 ++--
 tests/xfs/077      |  4 ++--
 tests/xfs/079      |  2 +-
 tests/xfs/083      |  6 +++---
 tests/xfs/085      |  2 +-
 tests/xfs/090      |  2 +-
 tests/xfs/092      |  2 +-
 tests/xfs/094      |  2 +-
 tests/xfs/098      |  2 +-
 tests/xfs/103      |  2 +-
 tests/xfs/104      |  2 +-
 tests/xfs/111      |  2 +-
 tests/xfs/121      |  6 +++---
 tests/xfs/130      |  2 +-
 tests/xfs/137      |  4 ++--
 tests/xfs/141      |  2 +-
 tests/xfs/177      |  6 ++----
 tests/xfs/181      |  2 +-
 tests/xfs/183      |  3 +--
 tests/xfs/189      | 14 +++++++-------
 tests/xfs/263      |  2 +-
 tests/xfs/270      |  4 ++--
 tests/xfs/297      |  2 +-
 tests/xfs/333      |  2 +-
 tests/xfs/338      |  2 +-
 tests/xfs/340      |  2 +-
 tests/xfs/433      |  2 +-
 tests/xfs/434      |  2 +-
 tests/xfs/435      |  2 +-
 tests/xfs/436      |  2 +-
 tests/xfs/439      |  2 +-
 107 files changed, 180 insertions(+), 178 deletions(-)

-- 
2.14.3

