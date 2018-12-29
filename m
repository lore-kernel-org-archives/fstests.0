Received: from szxga05-in.huawei.com ([45.249.212.191]:16670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728185AbeL2Cb3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Dec 2018 21:31:29 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E278DAEFBC213
        for <fstests@vger.kernel.org>; Sat, 29 Dec 2018 10:31:25 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH 2/5] generic/019: check scratch device is a block device or not
Date: Sat, 29 Dec 2018 10:34:49 +0800
Message-ID: <20181229023452.28074-3-houtao1@huawei.com>
In-Reply-To: <20181229023452.28074-1-houtao1@huawei.com>
References: <20181229023452.28074-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: houtao1@huawei.com
List-ID: <fstests@vger.kernel.org>

To ensure "blockdev --getsz $SCRATCH_DEV" will succeed.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tests/generic/019 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/019 b/tests/generic/019
index 32db36fc..8e1c9331 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -22,6 +22,7 @@ status=1	# failure is the default!
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_block_device $SCRATCH_DEV
 _require_fail_make_request
 
 SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
-- 
2.16.2.dirty
