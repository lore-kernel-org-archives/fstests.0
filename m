Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41169 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbaLKRRE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 12:17:04 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBBHH4mA032749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 11 Dec 2014 12:17:04 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 0/4] fstests: some random cleanups
Date: Fri, 12 Dec 2014 01:16:07 +0800
Message-Id: <1418318171-5892-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Some random and simple cleanups.

Eryu Guan (4):
  xfs/071: remove xfs/071.out from git
  fstests: change mode of test files to 0755
  btrfs/017: remove duplicate test
  common: fix comment about _require_test

 common/rc           |   2 +-
 tests/btrfs/010     |   0
 tests/btrfs/013     |   0
 tests/btrfs/015     |   0
 tests/btrfs/017     |  61 ------------------------------
 tests/btrfs/017.out |   2 -
 tests/btrfs/018     |   0
 tests/btrfs/026     |   0
 tests/btrfs/027     |   0
 tests/btrfs/028     |   0
 tests/btrfs/029     |   0
 tests/btrfs/031     |   0
 tests/btrfs/043     |   0
 tests/btrfs/044     |   0
 tests/btrfs/046     |   0
 tests/btrfs/049     |   0
 tests/btrfs/057     |   0
 tests/btrfs/058     |   0
 tests/btrfs/076     |   0
 tests/btrfs/077     |   0
 tests/btrfs/group   |   1 -
 tests/generic/029   |   0
 tests/generic/030   |   0
 tests/generic/031   |   0
 tests/generic/032   |   0
 tests/generic/033   |   0
 tests/generic/323   |   0
 tests/generic/324   |   0
 tests/xfs/071.out   | 107 ----------------------------------------------------
 tests/xfs/298       |   0
 tests/xfs/306       |   0
 31 files changed, 1 insertion(+), 172 deletions(-)
 mode change 100644 => 100755 tests/btrfs/010
 mode change 100644 => 100755 tests/btrfs/013
 mode change 100644 => 100755 tests/btrfs/015
 delete mode 100644 tests/btrfs/017
 delete mode 100644 tests/btrfs/017.out
 mode change 100644 => 100755 tests/btrfs/018
 mode change 100644 => 100755 tests/btrfs/026
 mode change 100644 => 100755 tests/btrfs/027
 mode change 100644 => 100755 tests/btrfs/028
 mode change 100644 => 100755 tests/btrfs/029
 mode change 100644 => 100755 tests/btrfs/031
 mode change 100644 => 100755 tests/btrfs/043
 mode change 100644 => 100755 tests/btrfs/044
 mode change 100644 => 100755 tests/btrfs/046
 mode change 100644 => 100755 tests/btrfs/049
 mode change 100644 => 100755 tests/btrfs/057
 mode change 100644 => 100755 tests/btrfs/058
 mode change 100644 => 100755 tests/btrfs/076
 mode change 100644 => 100755 tests/btrfs/077
 mode change 100644 => 100755 tests/generic/029
 mode change 100644 => 100755 tests/generic/030
 mode change 100644 => 100755 tests/generic/031
 mode change 100644 => 100755 tests/generic/032
 mode change 100644 => 100755 tests/generic/033
 mode change 100644 => 100755 tests/generic/323
 mode change 100644 => 100755 tests/generic/324
 delete mode 100644 tests/xfs/071.out
 mode change 100644 => 100755 tests/xfs/298
 mode change 100644 => 100755 tests/xfs/306

-- 
1.8.3.1

