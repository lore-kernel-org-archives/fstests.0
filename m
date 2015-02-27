Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46459 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbbB0LbG (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Feb 2015 06:31:06 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1RBV6Xq022041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 27 Feb 2015 06:31:06 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 0/5] Some random regression tests
Date: Fri, 27 Feb 2015 19:30:20 +0800
Message-Id: <1425036625-23361-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

I'm porting more tests from RH internal test case pool.

The first patch is containing 6 sub-tests, and each sub-test is relatively
small, so I grouped them together.

Thanks,
Eryu

Eryu Guan (5):
  generic: test some mount/umount corner cases
  generic: test quota handling on remount ro failure
  generic: test hardlink to unlinked file
  shared: test truncate orphan inodes when mounting extN
  generic: test fs freeze/unfreeze and mount/umount race

 tests/generic/067     | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/067.out |   2 +
 tests/generic/071     |  69 ++++++++++++++++++++++++
 tests/generic/071.out |   3 ++
 tests/generic/072     |  99 ++++++++++++++++++++++++++++++++++
 tests/generic/072.out |   2 +
 tests/generic/073     |  98 ++++++++++++++++++++++++++++++++++
 tests/generic/073.out |   2 +
 tests/generic/group   |   4 ++
 tests/shared/001      |  71 +++++++++++++++++++++++++
 tests/shared/001.out  |   2 +
 tests/shared/group    |   1 +
 12 files changed, 496 insertions(+)
 create mode 100755 tests/generic/067
 create mode 100644 tests/generic/067.out
 create mode 100755 tests/generic/071
 create mode 100644 tests/generic/071.out
 create mode 100755 tests/generic/072
 create mode 100644 tests/generic/072.out
 create mode 100755 tests/generic/073
 create mode 100644 tests/generic/073.out
 create mode 100755 tests/shared/001
 create mode 100644 tests/shared/001.out

-- 
1.8.3.1

