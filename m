Received: from szxga05-in.huawei.com ([45.249.212.191]:16671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeL2Cb3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Dec 2018 21:31:29 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E58C44EF2355
        for <fstests@vger.kernel.org>; Sat, 29 Dec 2018 10:31:25 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH 0/5] tiny fixes for xfstests
Date: Sat, 29 Dec 2018 10:34:47 +0800
Message-ID: <20181229023452.28074-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: houtao1@huawei.com
List-ID: <fstests@vger.kernel.org>

Hou Tao (5):
  check: use _try_scratch_mount instead of _scratch_mount to mount
    SCRATCH_DEV
  generic/019: check scratch device is a block device or not
  generic/131: wait until the server is ready
  generic/466: explicitly request $SCRATCH_DEV to be a block device
  fsx: check ENOSYS in test_copy_range()

 check             |  2 +-
 ltp/fsx.c         |  2 +-
 tests/generic/019 |  1 +
 tests/generic/131 | 19 +++++++++++++------
 tests/generic/466 |  1 +
 5 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.16.2.dirty
