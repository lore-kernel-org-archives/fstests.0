Received: from szxga06-in.huawei.com ([45.249.212.32]:60810 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933286AbeALL7r (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 12 Jan 2018 06:59:47 -0500
From: "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [PATCH v3 7/7] overlay/019: fix fs check failure
Date: Fri, 12 Jan 2018 20:05:33 +0800
Message-ID: <20180112120533.6099-8-yi.zhang@huawei.com>
In-Reply-To: <20180112120533.6099-1-yi.zhang@huawei.com>
References: <20180112120533.6099-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Cc: miklos@szeredi.hu, amir73il@gmail.com, eguan@redhat.com, yi.zhang@huawei.com, miaoxie@huawei.com, yangerkun@huawei.com
List-ID: <fstests@vger.kernel.org>

This is a stability test, fsstress will create a lot of orphan
whiteouts in lowerdir, which will lead to inconsistency of overlay
image and fs check failure. No need to check this manual craft
file system, so just skip fs check.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 tests/overlay/019 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/overlay/019 b/tests/overlay/019
index 3e2bc4e..575aaf7 100755
--- a/tests/overlay/019
+++ b/tests/overlay/019
@@ -46,7 +46,7 @@ rm -f $seqres.full
 # real QA test starts here
 _supported_fs overlay
 _supported_os Linux
-_require_scratch
+_require_scratch_nocheck
 
 # Remove all files from previous tests
 _scratch_mkfs
-- 
2.9.5

