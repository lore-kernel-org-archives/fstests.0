Received: from szxga04-in.huawei.com ([45.249.212.190]:17070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbeL2Cbg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Dec 2018 21:31:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 317B9D2803908
        for <fstests@vger.kernel.org>; Sat, 29 Dec 2018 10:31:31 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH 4/5] generic/466: explicitly request $SCRATCH_DEV to be a block device
Date: Sat, 29 Dec 2018 10:34:51 +0800
Message-ID: <20181229023452.28074-5-houtao1@huawei.com>
In-Reply-To: <20181229023452.28074-1-houtao1@huawei.com>
References: <20181229023452.28074-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: houtao1@huawei.com
List-ID: <fstests@vger.kernel.org>

so "blockdev --getsize64 $SCRATCH_DEV" will succeed.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tests/generic/466 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/466 b/tests/generic/466
index bc577df7..8168b5be 100755
--- a/tests/generic/466
+++ b/tests/generic/466
@@ -29,6 +29,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs generic
 _require_scratch_nocheck
+_require_block_device $SCRATCH_DEV
 
 rm -f $seqres.full
 
-- 
2.16.2.dirty
