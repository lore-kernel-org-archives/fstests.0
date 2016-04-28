Received: from mail-pa0-f44.google.com ([209.85.220.44]:35512 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbcD1Rds (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2016 13:33:48 -0400
Received: by mail-pa0-f44.google.com with SMTP id iv1so34699989pac.2
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2016 10:33:48 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 0/2] fstests: btrfs: the lost levels
Date: Thu, 28 Apr 2016 10:33:35 -0700
Message-Id: <cover.1461864695.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com, Omar Sandoval <osandov@fb.com>
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Changes since v1:

- Fixed _supported_fs and _supported_os in patch 2
- Added Josef's Reviewed-by

Original cover letter below:

Inspired by a conversation a few of us had at LSF about forgotten
fstests, I went back and checked if I had let any tests disappear into
the ether. Turns out that I did, so here are the tests for Btrfs replace
missing that I never got merged, updated with everyone's comments from
last time around ([1], [2]). Patch 1/3 in that original series did get
merged but the last two didn't fare so well.

Thanks!

1: https://patchwork.kernel.org/patch/6856101/
2: https://patchwork.kernel.org/patch/6856051/

Omar Sandoval (2):
  btrfs: add replace missing and replace RAID 5/6 to profile configs
  btrfs: add test for replacing a missing device

 common/rc           |  95 ++++++++++++++++++++---------------------
 tests/btrfs/027     | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/027.out |   2 +
 tests/btrfs/group   |   1 +
 4 files changed, 170 insertions(+), 47 deletions(-)
 create mode 100755 tests/btrfs/027
 create mode 100644 tests/btrfs/027.out

-- 
2.8.0

