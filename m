Received: from szxga04-in.huawei.com ([45.249.212.190]:13620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbeJKU1p (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Oct 2018 16:27:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4B1F56060A308
        for <fstests@vger.kernel.org>; Thu, 11 Oct 2018 21:00:35 +0800 (CST)
From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH] ext4/018: fix mismatch wildcard with debugfs
Date: Thu, 11 Oct 2018 21:14:10 +0800
Message-ID: <20181011131410.3587-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Yufen Yu <yuyufen@huawei.com>
List-ID: <fstests@vger.kernel.org>

For the new version of debugfs(v1.44.0+), it changes "File ACL:" format
from "%sFile ACL: %llu    Directory ACL: %d\n" to "%sFile ACL: %llu\n".

Thus, update this case accordingly.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 tests/ext4/018 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/018 b/tests/ext4/018
index 0116c5f7..eb6d827b 100755
--- a/tests/ext4/018
+++ b/tests/ext4/018
@@ -55,7 +55,7 @@ echo "+ check fs"
 e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not fail"
 
 echo "+ corrupt image"
-blk="$(debugfs -R 'stat /attrfile' "${SCRATCH_DEV}" 2> /dev/null | grep 'File ACL:' | sed -e 's/^.*File ACL: \([0-9]*\).*Directory.*$/\1/g')"
+blk="$(debugfs -R 'stat /attrfile' "${SCRATCH_DEV}" 2> /dev/null | grep 'File ACL:' | sed -e 's/^.*File ACL: \([0-9]*\)/\1/g')"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 $((blk * blksz + 20)) 8" "${SCRATCH_DEV}" >> $seqres.full
 
 echo "+ mount image"
-- 
2.13.6
