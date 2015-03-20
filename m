Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46629 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbbCTKRY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 06:17:24 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2KAHOsm010815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 06:17:24 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 0/9] some backlog patches and new test and fixes
Date: Fri, 20 Mar 2015 18:16:49 +0800
Message-Id: <1426846618-23413-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

First five patches are backlogs from last fstests update(but rebased on current
master and renumbered). The sixth patch is a new test case. And the last three
patches are random fixes.

Any reviews are welcomed!

Thanks,
Eryu

Eryu Guan (9):
  generic: test some mount/umount corner cases
  generic: test quota handling on remount ro failure
  generic: test hardlink to unlinked file
  shared: test truncate orphan inodes when mounting extN
  generic: test fs freeze/unfreeze and mount/umount race
  generic: test I/O error path by fully filling dm snapshot
  common: recognise NFS export over IPv6 in _require_scratch_nocheck()
  xfs/014: replace df with $DF_PROG
  generic/077: add missing _require_scratch

 common/config         |   1 +
 common/rc             |   6 ++-
 tests/generic/067     | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/067.out |   2 +
 tests/generic/072     |  69 ++++++++++++++++++++++++
 tests/generic/072.out |   3 ++
 tests/generic/073     |  99 ++++++++++++++++++++++++++++++++++
 tests/generic/073.out |   2 +
 tests/generic/077     |   1 +
 tests/generic/080     |  98 ++++++++++++++++++++++++++++++++++
 tests/generic/080.out |   2 +
 tests/generic/081     |  79 ++++++++++++++++++++++++++++
 tests/generic/081.out |   2 +
 tests/generic/group   |   5 ++
 tests/shared/001      |  71 +++++++++++++++++++++++++
 tests/shared/001.out  |   2 +
 tests/shared/group    |   1 +
 tests/xfs/014         |   2 +-
 18 files changed, 585 insertions(+), 3 deletions(-)
 create mode 100755 tests/generic/067
 create mode 100644 tests/generic/067.out
 create mode 100755 tests/generic/072
 create mode 100644 tests/generic/072.out
 create mode 100755 tests/generic/073
 create mode 100644 tests/generic/073.out
 create mode 100755 tests/generic/080
 create mode 100644 tests/generic/080.out
 create mode 100755 tests/generic/081
 create mode 100644 tests/generic/081.out
 create mode 100755 tests/shared/001
 create mode 100644 tests/shared/001.out

-- 
2.1.0

