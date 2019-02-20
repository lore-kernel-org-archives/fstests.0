Received: from szxga06-in.huawei.com ([45.249.212.32]:35508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726544AbfBTBz7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 19 Feb 2019 20:55:59 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D3A39C827738BBB4B3F0
        for <fstests@vger.kernel.org>; Wed, 20 Feb 2019 09:55:57 +0800 (CST)
From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH 5/5] generic/350: use the common function _get_max_file_size
Date: Wed, 20 Feb 2019 09:59:55 +0800
Message-ID: <20190220015955.26342-6-yuyufen@huawei.com>
In-Reply-To: <20190220015955.26342-1-yuyufen@huawei.com>
References: <20190220015955.26342-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We use common function _get_max_file_size to get the max
file size supported by the filesystems and let the code
be clean.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 tests/generic/350 | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tests/generic/350 b/tests/generic/350
index 0aea4c09..f1d9887b 100755
--- a/tests/generic/350
+++ b/tests/generic/350
@@ -47,17 +47,8 @@ md5sum $dev | sed -e "s|$dev|SCSI_DEBUG_DEV|g"
 
 echo "Punch to MAX_LFS_FILESIZE"
 # zod = MAX_LFS_FILESIZE
-case "$(getconf LONG_BIT)" in
-"32")
-	zod=$(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
-	;;
-"64")
-	zod=9223372036854775807
-	;;
-*)
-	_fail "sizeof(long) == $(getconf LONG_BIT)?"
-	;;
-esac
+zod=$(_get_max_file_size)
+
 $XFS_IO_PROG -c "fpunch 0 $zod" $dev
 
 echo "Check contents"
-- 
2.16.2.dirty
